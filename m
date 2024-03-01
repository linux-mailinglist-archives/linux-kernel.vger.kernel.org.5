Return-Path: <linux-kernel+bounces-88674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49686E51B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E90A287DA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAF570CD2;
	Fri,  1 Mar 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NLbWSuG0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F970CC8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309829; cv=none; b=b8bfn20XCtIbOD2Tqb+N0L8PN6Dzu9TSy9LwUDTaQNiyydKDI1XeubWGSyQ9ewTzoUzr9MY7HoBFHDUMctCnkIh7XrJvq2LbAKsyKYL9I2TJzmQ4b6f2QX2qF6izQqnmixr1xoQoeqrK81I2A/I+4hQSrguIhBvqKATX/FmbJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309829; c=relaxed/simple;
	bh=/A5CBIENfHWW4XPPPw13wG+4toE2KUEZawUP9+3ggxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhFXXZUNqcSlvSL9DC51jV7kIh72IrIlgFRwcdkpWAppKE2g1LLj4K/M5nQi9JX1asPt9/YHkTGi4//Kc3AZ81ElHl/CFaUElxpRNRFH535OfJx80Eba+vaje0U22YTmt3u88pFkKYJXRwI1kphLZAAI+/HXlO95n25jpYCPiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NLbWSuG0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2DB440E00B2;
	Fri,  1 Mar 2024 16:16:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4BQDK0X13Mgf; Fri,  1 Mar 2024 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709309813; bh=4fLdrLhcEFJ7jjCD39pp4ErP50LzIorbrqySsHobOKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLbWSuG0gxZCI/jwJTCl1d5SwMIrFBHt5FTtENBhC6re0hQNCxkUWzw1Pzyxzoo5x
	 hz6t4dU/DhLdw1KR4+CcaihCVF4/3fX8Udz5H4THEWLC6Mi1r3dKIVy+tMrxtf69a1
	 4VOofTaHsREpLHCrWktsoavM3r9Awfcz0Jib2+bb1y4rqNfCZRPgWQOkuj4afCPlBA
	 vwLvMixf/jSWdeJabXdgCMoaTCl+HOr9h9T0JtQcKN6Ppr7IU2/vK/eQ6MCHVBhhTJ
	 BIM/NS6Cw84aj9l5SDjqMiZa9VoHfYoOu0AXCW8dwFiobmtMoYb+LGG5F7H2u2n/k2
	 UjnwCKmKlB5F6zVtzJxou/k3CLxLZQUm/xGhjvFdk5DMISqecIOy7CBUeJsOKt3ZLL
	 Zpha01F2SOQ/OLfI8mnHqE6YYFIrMaH3bNI2lhqxA0pqdVBYOh6zqq+qaJ0U7woZin
	 8brx0KU6GbwNrNHiWWMckR9eUycjugn6bPHoRaZ0B+xuA8t9Y9WlZpvowF0KUQ6lBk
	 13UiEwA/apUTFNXJuiu6thnHsCT1DbOj+dKjV0AJvbsj7UI9S16boBxFntwIFKzhSM
	 1xrpz/3PbkM5l/DYbgCavQlEFj1uXL7Y5ehuO5Nucu+8w82KeOXXAgbFZPZxkCr4cq
	 XXdmQ2TcQG8zE5Q8qIdeX+Bs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76F9940E0028;
	Fri,  1 Mar 2024 16:16:42 +0000 (UTC)
Date: Fri, 1 Mar 2024 17:16:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 5/9] efi/libstub: Add generic support for parsing
 mem_encrypt=
Message-ID: <20240301161641.GMZeH_aUvBvKZjBIpl@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227151907.387873-16-ardb+git@google.com>

On Tue, Feb 27, 2024 at 04:19:13PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Parse the mem_encrypt= command line parameter from the EFI stub if
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
> boot code by the arch code in the stub.
> 
> This avoids the need for the core kernel to do any string parsing very
> early in the boot.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
>  drivers/firmware/efi/libstub/efistub.h         | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-89005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8586E959
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CA71F23AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47939AF4;
	Fri,  1 Mar 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VO1Lo/Y1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093039AEA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320625; cv=none; b=axOaMCdFNfOBRUVKrxu7pe57IquoCbwIcg/IvXLuFHNlLUQit2U8fCwaihui/EBTGbVE3ewAQ97A4O7L5pgCpN3zbpfMslDIc/2uyPCLZkr/3nNCcznXyzBjseadwJTogD4QKsLrF98L8RKUNe8mtg0B2vw6H0kJq60SLZjIZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320625; c=relaxed/simple;
	bh=dEmjzPDrT+npTyMci1PwxN3F1Q+kk+yxzW8fa60q1AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWiAu+Kb67OWGQX+HzzkbuG/XZrkcbW8JWehxFLTy59X2ACNCvPlGNSpBuMqPQD4OX9dzszDgIJxDDFdu0KGnHSbOkp+g7reMU7FufJ/9A6v6yDLpN5tOCzLkL9P8jRIAm953KdSK0T0DvGzvKpSwTg8Y1b4cUQzh9HaIr2stT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VO1Lo/Y1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CA6A40E0196;
	Fri,  1 Mar 2024 19:17:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5jYA0sa8vCA5; Fri,  1 Mar 2024 19:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709320619; bh=sd/nD7Yx33s4fZwmlkzXtyIVaIXVfPoDtiJXjkBlQOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VO1Lo/Y1GhJsKcSv6cC5FTu5R1YH02Ll27aXZ2PMSU6OFOWh9TJsU7z5Zh8ylBqKc
	 C0vZOh/IDM1NWm7M7F/7lS3WNom7WiGQHz0BEB1UPjhLAlJ9s5Ao5uRfsH2O38duS8
	 a3MusfPakfDxTCku6NUy66pOvGm0TQZi5Glw6CGgKa3dF8grfZh+3InDS/6G8Qrc7h
	 l2CT5qPekiCSwJKa+Bzr72jnEZchbNb7+lJIXSlTxzH9q4uQSLzSR+bpYDYfX3sKDf
	 7DrQcxXOwhBS2ypNkXZRij+I+llThaeIqfdedDNRP3bGI1mR5P5fpzJ2PKSd3T/QIT
	 CCfpZGswpW9YsTTzNQYQemAzgmIT8Hxy1GuhHs5Vppnian1fkNQq5N0OnDVitHZR54
	 HpqOWCGveg1yS0IMLA8FnJFKffnfUh65B5lysexEm0VKECdoGCj+u9tXEYCKb7BAqi
	 /u0MHsEWzEDiFoN9tCNZzl6uc2W0pw7ypw5Wv7D5Rzkm/rQCV+b1LWqi9Csf33pBRq
	 fvGwbq58w4lpRtQ/Nxk7HxibyHHdMcKQ5D1joAQa6Mc4qQMiokDbb88mFRu+BiijSO
	 5KJ2dgPXJ2oym4vP2uofOLtdgfo8ihgWTzEr7reGsFsk0wEPACEWCL2zWlMCpOJd8o
	 DKJjXwXg78j2X5x0Tsf+DKa8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDEAD40E00B2;
	Fri,  1 Mar 2024 19:16:47 +0000 (UTC)
Date: Fri, 1 Mar 2024 20:16:40 +0100
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
Subject: Re: [PATCH v7 6/9] x86/boot: Move mem_encrypt= parsing to the
 decompressor
Message-ID: <20240301191640.GNZeIpmAU3iM1EIg4S@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227151907.387873-17-ardb+git@google.com>

On Tue, Feb 27, 2024 at 04:19:14PM +0100, Ard Biesheuvel wrote:
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 01d19fc22346..eeea058cf602 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -38,6 +38,7 @@
>  #define XLF_EFI_KEXEC			(1<<4)
>  #define XLF_5LEVEL			(1<<5)
>  #define XLF_5LEVEL_ENABLED		(1<<6)
> +#define XLF_MEM_ENCRYPTION		(1<<7)

Needs documenting in Documentation/arch/x86/boot.rst.

And yes, those 5LEVEL things are not documented either but I'm even
questioning the justification for their existence. We'll see...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


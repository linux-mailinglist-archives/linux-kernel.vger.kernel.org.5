Return-Path: <linux-kernel+bounces-12863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C00381FB58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B9D1F23AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2610947;
	Thu, 28 Dec 2023 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jVJbDEyZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA8107BB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2DC640E01A1;
	Thu, 28 Dec 2023 21:25:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HhWxJ4aW-ILO; Thu, 28 Dec 2023 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703798721; bh=l+KGPLS51pZSqpSe2vkbdp6pZtOnenqjT59kvRjTLno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVJbDEyZQlEFGl4pjIOQM6qJ/mh4BE0F37EkAA2T66HvSUj2+Gg9R5xoa3Wqn0XWN
	 CM1I9Mz2rO4abY2LW31/OzdncytSmlgZBuxfYdE3FCUIFZkgVnjIDB6A8iCUdBt6Zk
	 8hdNjPGD9P6rRZuvRC0YNwJl/qxav+gOaiVsOdQ7+1UH6voSbgnlCZUt0FFmwdIW+e
	 azpiBBwwL0SacJEJx6wJfm78IumcRaP3tNbJ57i1zxOLoYEtgNeXqsir02sXBF3Ktr
	 8EqTGc2z/oT0WC2r0JvboPSEd7A2XHawJGPqtYHbBA/FTWbC/LpCJXKOTWfWwTwC8R
	 cOTheigj3QDkGaHjV28VBCQvtFr6faYg7p/jpYvHyU1/jnBKDmFewUe0K4iKoMi0xi
	 +sKkXq0Km3swuPchJjD31EuaiW0lPPrSIHT2UtN0HNqNmf2CR/JnmAuIZUKj0vsCIO
	 J6NMNW51FyjcSQl1B3UKe5eODCypzAJs1deh40bS7M1vQSCOo5SjBjKHktLR2FICLe
	 UG8ADGwgAYAr/HBQ/CdIXfGpFO3GyuRtdmgG2DBSKUvaudEBmGWEHhmGRppQUh5KAW
	 7RZ7anI/vhTtYvS7sExoQ+cZOwXOTted9I2XpU449i+Xq6P9eXsszzYArq22sXpkAh
	 607u0oZVMx1d+bjwOgTZX2Mo=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D56B40E00CB;
	Thu, 28 Dec 2023 21:25:12 +0000 (UTC)
Date: Thu, 28 Dec 2023 22:25:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>
Subject: Re: [PATCH] x86/vdso: shrink vdso/extable.i via IWYU
Message-ID: <20231228212511.GCZY3nt3gKI+aDvSF1@fat_crate.local>
References: <20231228-extable-v1-1-32a18c66b440@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231228-extable-v1-1-32a18c66b440@google.com>

On Thu, Dec 28, 2023 at 08:56:35PM +0000, Tanzir Hasan wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list, changing indirect includes to direct includes. IWYU is
> implemented using the IWYUScripts github repository which is a tool that
> is currently undergoing development. These changes seek to improve build
> times.
> 
> This change to vdso/extable.c resulted in a preprocessed size of
> vdso/extable.i from 64332 lines to 45377 lines (-27%) for the x86
> defconfig.

Maybe I'm missing something but this sounds like the build-time
"improvement" is so minute that you have to look at preprocessed sizes.

Do you have any, more "noticeable" numbers to justify this churn?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


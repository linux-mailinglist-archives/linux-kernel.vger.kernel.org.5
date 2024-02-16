Return-Path: <linux-kernel+bounces-69366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75008858801
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C733C2829CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26713145B18;
	Fri, 16 Feb 2024 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HzsS66Cq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85731E865;
	Fri, 16 Feb 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118893; cv=none; b=FZFj8ggUivRGPQi2+xLq3iPhvSZA5ejw6jhXuhVltG8ZWdCPiIj5D0hlyI6yh2C/q00N/YJ5Q5HyFI4OksvWrUIuwz+4V1eGYABEsStR9eUtIvNNdYGFYHoghEel3vCPbcyu5DPjtKjAikfuaOsOX5E/04aD6AhZY0rHUiuos00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118893; c=relaxed/simple;
	bh=XMtDEBRwm/nhhA+FVIRTNNGO9Tm+d6KI3nOFo2hlxL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcbW6fjz9wBK5KK2bIGZ9sPUwcDwkd3BprhAkxNPNdAwzRxLYCcfXmvS6Jt3LNqjzFaJnjFV/k56TiF9Q1iNdSt/6LcCvFNXvb3VJatuU/4U4nFUosjhjFmu9eCtSKYNOnGDLSgKwre0UrMFu3OyoS/66AsR4Otr5N6KMjzZcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HzsS66Cq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F1C640E01A9;
	Fri, 16 Feb 2024 21:28:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MGfmZixOSE64; Fri, 16 Feb 2024 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708118878; bh=VAh0+9UxLT1H6XK9rCU87AdZyd52PVk7MN7aqBNuBTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzsS66CqmlH1i53tTYIqZ/fUJ7QLhvfUmJr0mlb/M1NoCu/kKI7JJEstCTWo5tdXc
	 K58bypHvlNHK5p6YWXri1tsUIlm20x6REqW1EJlPmezGChFbhIKqaC+wj9a1WwKAGH
	 f1zHKxRsmwp8tiUILahXjdp53zCdx6M/mcJddbuaPAkv9dIrgaLCjhgVIdWLzn7YIB
	 YUegvLeKFKaOtNHGNRwFJ+Yic0TiZzBF+blMlIgqC2otBOFkwOmEMwdu4QFj5V7/Q9
	 wWLVEU1yEzIri8CpzzGd4yyWVcRhEaz7o8mo3lMOPii4nghlqRxD53kbdXZ62zqH4v
	 218pHd2UeHvoGdvBCG9RvrppWbOyGloj06AfhtH3evXMX/FXxzxi6jAJ1IOFiDbpZZ
	 dEUPya0MrH0f995RlkmXz645mjaLyrwfFei21Ola1JR95OXOGPy7p6gGHJWbH4xNDo
	 X6wLA2RK+7cQ5t80OcTxUpZP6NyKbSb2w6oHI4wPvar7H74JkcjTo371K1A2EfTy9B
	 oDQBZtOmclUOJ+YTly4+Jm2o1MbJ6pIhcuupuahLpIQgWDvb+DqD8D6r8aRx8gAG6E
	 vM7rSYoPOHTvtMo9fbZR2DNFa730TVM98l/KNM2QBsVSiDV/KZFOlRq4HsDWzCdS0J
	 WI30ckcoCi21w2YbKU7Vf7Us=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0862B40E0192;
	Fri, 16 Feb 2024 21:27:52 +0000 (UTC)
Date: Fri, 16 Feb 2024 22:27:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240216212745.GAZc_TURO0t35GjTQM@fat_crate.local>
References: <20231010171020.462211-4-david.kaplan@amd.com>
 <170774721951.398.8999401565129728535.tip-bot2@tip-bot2>
 <20240215032049.GA3944823@dev-arch.thelio-3990X>
 <20240215155349.GBZc4zjaHn8hj6xOq3@fat_crate.local>
 <20240216054235.ecpwuni2f3yphhuc@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216054235.ecpwuni2f3yphhuc@treble>

On Thu, Feb 15, 2024 at 09:42:35PM -0800, Josh Poimboeuf wrote:
> Right, the good news is this isn't a regression and the warning is
> working as designed.
> 
> This should tell the build to invoke objtool on that file:
> 
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index b1b8dd1608f7..92d67379f570 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -36,6 +36,7 @@ UBSAN_SANITIZE_vma.o			:= y
>  KCSAN_SANITIZE_vma.o			:= y
>  OBJECT_FILES_NON_STANDARD_vma.o		:= n
>  OBJECT_FILES_NON_STANDARD_extable.o	:= n
> +OBJECT_FILES_NON_STANDARD_vdso-image-64.o := n

Right, this should be:

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c4df99aa1615..4a514cafd73e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -36,6 +36,8 @@ UBSAN_SANITIZE_vma.o			:= y
 KCSAN_SANITIZE_vma.o			:= y
 OBJECT_FILES_NON_STANDARD_vma.o		:= n
 OBJECT_FILES_NON_STANDARD_extable.o	:= n
+OBJECT_FILES_NON_STANDARD_vdso-image-32.o := n
+OBJECT_FILES_NON_STANDARD_vdso-image-64.o := n
 
 # vDSO images to build
 vdso_img-$(VDSO64-y)		+= 64

for completeness.

Lemme know if you want to write a formal patch or I should.

If you do, please make sure to include the exact way to reproduce
because we might need it in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


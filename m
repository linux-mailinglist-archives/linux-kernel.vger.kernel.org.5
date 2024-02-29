Return-Path: <linux-kernel+bounces-87128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A686CFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8791F22B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09956CBED;
	Thu, 29 Feb 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dk40ejjO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3724AEC3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225741; cv=none; b=tOz9VydGNvOj1Yskl2Kyutr6f7kCnZwR+uHrf+MdUTN/KXqeuXDCj8YDCgJZiB6Wcc+x7zFij3XucmWmullHpBUwoGkCtybTqbpsKVriFRFOxut5w65qXC//7CvcMIdOkfTCIQHVdFqtGvXZXQDx35RsW93nRGeEYpJkNWPhVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225741; c=relaxed/simple;
	bh=s4etohPbHlmfBIZmG6DfnKOsO4LfEoocLrDhz2dcjWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSQdPuVfN1kXZzsmbLWlLqNav8Gnslg97oak/uXCkdO14uvF1KzU9TmhdNCwwnRGIvadwLAvrzguy3zWO1ntTSXF/twzk255uMqLwoxQXMrEquWkHQJl0HlrVRj1Eemes02yZKdplOi+KprzMdUKKJcxgIN4lild72jceJG1wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Dk40ejjO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8CE5140E016C;
	Thu, 29 Feb 2024 16:55:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1Fjsi9ZMmdSk; Thu, 29 Feb 2024 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709225730; bh=Q+8EhPT9dMLdrfcS55Igq/0q2X21nFue1lm9HpCHsoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk40ejjO/Ghhj14rdBu8uuVvQyWgvNW2KgbUqtTW22N3jlqxkE5VchoEfvMhxp07N
	 KWFhjjryDU4YzW9D6THMVp47Y684irGXZSaSEF+nngcQKFsKFhBptTy5JVcrSuPusp
	 2Rgurbw7W265llGgukK+oYDMj48brriFQKVfRpjmEwh8TtkHZhMTVmidHE59eUbWvQ
	 iHaYcGaj81VHcNlrmjGIJxxAAQPwMKk4wxsxMKfQAJ1JGqgZEORRWRyZCoLcqSXtnX
	 +KMLbyVt8QkrAsM+FLLccrKQLtOBoE3iXBTUcu6SvRmM68Eu1i4+zey2ArXyJOARQz
	 kQ+bEePAdDCXxx9Pm81fqSrWGJE6Dy4sXK4FeYurCctEZO0ZK78jE3Sew5TyqP2tvD
	 nrassrwCHmzpsiY9yVYlCLbiurg2dQwDyHkPzel6MNp6kXggctAxbSnOIJLl7tZo1s
	 d7LEl81H2VVkb9OW4sk/KReBVXFSMh+tGdea+GHYPur5iLN5wvQrPzqi1Sqj+KvwLQ
	 tQDpIaBDluJPQAyMXnbn9MawLaWelBdKFjn0qnXts10ArAhMB6UHHlaETBmPfwjDen
	 On7FXSh5CIDmFxeGNnIvDHvlkVYftDJ/pQNrO0TuGrb0hT9D3WiC532I21OjO0AlAg
	 pxk2hYRBgTPsAv0aITOey0KU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0565D40E0185;
	Thu, 29 Feb 2024 16:55:04 +0000 (UTC)
Date: Thu, 29 Feb 2024 17:54:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: acdunlap@google.com, alexander.shishkin@linux.intel.com,
	andrisaar@google.com, ardb@kernel.org, bhe@redhat.com,
	brijesh.singh@amd.com, dave.hansen@linux.intel.com,
	dionnaglaze@google.com, grobler@google.com, hpa@zytor.com,
	jacobhxu@google.com, jpoimboe@kernel.org, kai.huang@intel.com,
	linux-kernel@vger.kernel.org, michael.roth@amd.com,
	mingo@redhat.com, peterz@infradead.org, pgonda@google.com,
	ross.lagerwall@citrix.com, sidtelang@google.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, x86@kernel.org, ytcoode@gmail.com
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
Message-ID: <20240229165458.GLZeC24r5_-joAqNLp@fat_crate.local>
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222202404.36206-1-kevinloughlin@google.com>

On Thu, Feb 22, 2024 at 08:24:04PM +0000, Kevin Loughlin wrote:
> SEV-SNP requires encrypted memory to be validated before access.
> Because the ROM memory range is not part of the e820 table, it is not
> pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
> to access this range, the guest must first validate the range.
> 
> The current SEV-SNP code does indeed scan the ROM range during early
> boot and thus attempts to validate the ROM range in probe_roms().
> However, this behavior is neither necessary nor sufficient.

Why is this not necessary, all of a sudden?

> With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will

What is that use case exactly?

CONFIG_DMI_... is usually enabled but the absence of EFI_CONFIG_TABLES
tells me that you're booting some guest with some special OVMF which
doesn't sport such tables.

Why?

/me scrolls upthread

Aha, some project oak thing doing a minimal fw. I can see why but this
should be explained here as to why is this a relevant use case and what
it is using and so on so that future readers can piece it all together.

> attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> falls in the ROM range) prior to validation. The specific problematic
> call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> in a crash during boot if SEV-SNP is enabled under these conditions.
> 
> With regards to necessity, SEV-SNP guests currently read garbage (which
> changes across boots) from the ROM range, meaning these scans are
> unnecessary. The guest reads garbage because the legacy ROM range
> is unencrypted data but is accessed via an encrypted PMD during early
> boot (where the PMD is marked as encrypted due to potentially mapping
> actually-encrypted data in other PMD-contained ranges).

I don't mind ripping that ROM probing thing but that thread we're on
here talks more about why it could be problematic to keep doing so so
pls summarize that here.

A commit should contain all arguments for why it has been arrived at
the decision to do it this way.

> While one solution would be to overhaul the early PMD mapping to treat
> the ROM region of the PMD as unencrypted, SEV-SNP guests do not rely on
> data from the legacy ROM region during early boot (nor can they
> currently, since the data would be garbage that changes across boots).

That's better.

> As such, this patch opts for the simpler approach of skipping the ROM

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> range scans (and the otherwise-necessary range validation) during
> SEV-SNP guest early boot.
> 
> Ultimatly, the potential SEV-SNP guest crash due to lack of ROM range
  ^^^^^^^^^^

Please introduce a spellchecker into your patch creation workflow.

> validation is avoided by simply not accessing the ROM range.
> 
> Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> ---
>  arch/x86/include/asm/sev.h   |  2 --
>  arch/x86/kernel/mpparse.c    |  7 +++++++
>  arch/x86/kernel/probe_roms.c | 11 ++++-------
>  arch/x86/kernel/sev.c        | 15 ---------------
>  drivers/firmware/dmi_scan.c  |  7 ++++++-
>  5 files changed, 17 insertions(+), 25 deletions(-)

..

> diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> index b223922248e9..39ea771e2d4c 100644
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
>  		    base, base + length - 1);
>  	BUILD_BUG_ON(sizeof(*mpf) != 16);
>  
> +	/*
> +	 * Skip scan in SEV-SNP guest if it would touch the legacy ROM region,
> +	 * as this memory is not pre-validated and would thus cause a crash.
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && base + length >= 0xC0000)
> +		return 0;

I don't like spreading around CoCo checks everywhere around the tree.

Think of a better way pls.

> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 015c95a825d3..22e27087eb5b 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
>  			dmi_available = 1;
>  			return;
>  		}
> -	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
> +	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &&
> +		!cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {

Ditto.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


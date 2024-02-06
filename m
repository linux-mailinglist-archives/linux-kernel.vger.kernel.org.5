Return-Path: <linux-kernel+bounces-54779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA7384B397
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEB11C2199A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116C12FF8C;
	Tue,  6 Feb 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ewN44thG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6112EBF0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219110; cv=none; b=Jedrw0VV2y/q//ol6xgAwijWKTCZb38hSSi9MeI6/a/UmeB/7hw7hY43t0zg1xnbsrlEzp7twn/Ux1htP3bX3KCn1APZZzpstUkBMDMWlz2iLF1Z3lyI++YwZ63kJ7hpS9Xl2e/dzngmUxM6FXB57NeVlzw83lbCIAxjHvNaElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219110; c=relaxed/simple;
	bh=oF0oOuWCeALtmTqDD/togNYAEXQEnWbeMH0vNBLK25E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFHwn59iXaLveHLKGgMTW+g9W6QYIO6gY92ieUoaVuVBMm5dFuY5Eb4278r5D8+bNTnJdQVvc8PCUsUbvNloZtYdLYmSfeW0kdsBkVrkGJ8058FCC1TjQ/GEERi8ejoKCHL+wutFLvyaWkhZ1A0QG4aTGMid05FWwHi98Euls7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ewN44thG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D07E40E01A2;
	Tue,  6 Feb 2024 11:31:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HqBmGk6PA-fs; Tue,  6 Feb 2024 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707219097; bh=PVIQ6wTS4WSiS9R42snOSTVuDFtWhoimgMWTvV+IG58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewN44thGght3UNOd7qm9F3lPT0auZoL3mNbzYi+6Qo4r6IKjZmq7R8dy1N4EjU/s3
	 RbNkcCBF+cZXB+gMsYpDEJbvPusjqi5IVzCaAEyCkKIai3fXaMjjPl5TYLbUJVG9Qs
	 26NzPzSPAkuglZtI1xLd/iDuu2ZoOF8PfDkOuts29mxEQUwLB4wFekorJENMdo0gLT
	 G12WBKKGVeJfKui82IrCCAfyN7ePH7J7qLVjEIJSaEFZyLv6RcGeA3PcsoREvBqAy4
	 XNdrsslHHen3RCa4Lpxb8+4wnMKtb6GGOOy2tIEM/PQZ573VNboRSZDBTRlQzIf7X6
	 KjlVzTJLaV3s88FkBl1gHpCvgMv2PxeCWkftBLLIVt3CIy2ISREc2XL7shq/J+rYQ/
	 XOM8uCR7XPGIbWmQrtzchqHVGDjO0ppHcPCnqW+GfYXY+2paKobDBq0d3vPkdincpW
	 E2miXiMBn8fRI1nIstVQWVvMsHEePnUA7BWefzthhkl24B5ClJKNK4SOW5wlff6MSx
	 4+6XARp1L1vfPwtFJQRrhrvfv/7PqT3LzoouYLlRF0N7pJXWXU3h0sGJ/S3KnZVtlt
	 Vqw3Bbtr07U2WGggHLluDqISvc7aBLmplTDzK1QMaCTNEj+cnM3ubF3Ag6nQsgT9Sw
	 qZU/BDberx1R8x4uMzqDt8pQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 622A240E00B2;
	Tue,  6 Feb 2024 11:31:30 +0000 (UTC)
Date: Tue, 6 Feb 2024 12:31:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: x86@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com, michael.roth@amd.com,
	dan.carpenter@linaro.org
Subject: Re: [PATCH] iommu/amd: Fix failure return from snp_lookup_rmpentry().
Message-ID: <20240206113125.GCZcIYjYFz_LGJLTU5@fat_crate.local>
References: <20240205210654.219442-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205210654.219442-1-Ashish.Kalra@amd.com>

On Mon, Feb 05, 2024 at 09:06:54PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> The patch f366a8dac1b8: "iommu/amd: Clean up RMP entries for IOMMU
> pages during SNP shutdown" (linux-next), leads to the following

Add this:

[alias]
        one = show -s --pretty='format:%h (\"%s\")'

to your .git/config so that when you do

$ git one f366a8dac1b8

it can give you the proper formatting for commit references:

f366a8dac1b8 ("iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown")

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 88bb08ae39b2..11340380111d 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3813,9 +3813,11 @@ static int iommu_page_make_shared(void *page)
>  		bool assigned;
>  
>  		ret = snp_lookup_rmpentry(pfn, &assigned, &level);
> -		if (ret)
> +		if (ret) {
>  			pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n",
>  				pfn, ret);
> +			return ret;
> +		}

This one is incomplete and we should've caught this in review: any of
those failure cases here should return an error and not attempt to make
a pfn shared again.

Diff ontop:

---

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 11340380111d..480e7681f4f3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3814,24 +3814,27 @@ static int iommu_page_make_shared(void *page)
 
 		ret = snp_lookup_rmpentry(pfn, &assigned, &level);
 		if (ret) {
-			pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n",
-				pfn, ret);
+			pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n", pfn, ret);
 			return ret;
 		}
 
-		if (!assigned)
-			pr_warn("IOMMU PFN %lx not assigned in RMP table\n",
-				pfn);
+		if (!assigned) {
+			pr_warn("IOMMU PFN %lx not assigned in RMP table\n", pfn);
+			return -EINVAL;
+		}
 
 		if (level > PG_LEVEL_4K) {
 			ret = psmash(pfn);
-			if (ret) {
-				pr_warn("IOMMU PFN %lx had a huge RMP entry, but attempted psmash failed, ret: %d, level: %d\n",
-					pfn, ret, level);
-			}
+			if (!ret)
+				goto done;
+
+			pr_warn("PSMASH failed for IOMMU PFN %lx huge RMP entry, ret: %d, level: %d\n",
+				pfn, ret, level);
+			return ret;
 		}
 	}
 
+done:
 	return rmp_make_shared(pfn, PG_LEVEL_4K);
 }
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


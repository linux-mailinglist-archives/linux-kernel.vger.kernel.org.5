Return-Path: <linux-kernel+bounces-65097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554828547B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE2CB24F92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C618E2E;
	Wed, 14 Feb 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fdS+gbDD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61018E10;
	Wed, 14 Feb 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908762; cv=none; b=rHkx4rcyLbv1zm+xygjpCmiMs2evJB6FFexDIY/EbsisVVPdhLdkwTGcma6/AsQn2bTnd8mZaE/ujSH9wHpP85qY+jEggFVDv/ALZq21r4/clyQyID1E5VLNwNwgOIniUIRgTomz6yuyIuojF4SZh3ipK5muqwCtTiiRZ15bYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908762; c=relaxed/simple;
	bh=yfyMflBKNtVGtU2ImfDEona8nwijQRrVLRbwSrI2atQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3LAIT3nd18xqPJEVAYJ/ckhvM1zHfCi5PI6CK3vMZrue0V28wKz9DiLm3JVwbOM8ZqL+3ASuR6cj0SuHlhfsCSqMr44wIRBoaPDykXff32IpSbgJqNPkCSFNRZi0WFppK3A4Niq5maNAVe5JM6EX6LpMgcAryDVbf64SM42hiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fdS+gbDD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B0A040E023B;
	Wed, 14 Feb 2024 11:05:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4oMTBDzLIK7G; Wed, 14 Feb 2024 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707908755; bh=RFhzM1mdJMfnEuHgaoIgi2HNPVK8ohL6VlPzvvVhHBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdS+gbDDk820q13tmn01nLrKge4DftiKKp4/vca/XB0m67UKxVrQlna6EuNVHkqZG
	 QRHOEZtUKD5KRVHctmRzXcN3XIJ75Ss5td7yTZJeAsZv8atbGS3mxgte+9Ob/gtWzH
	 Tj604yrwrEvshmu96Mmc+mElqecvIgDpas6LwPDZXjgAdAZGux6dmVvm+x17hGZrKF
	 r8BN340NUkcRr4j/YYPnMMTkgW+yVFbXr4X3doLigfGUPEwyKUa1d95ay1tSQU0/pD
	 cbNT7aF+4iDnE3XagjMpWHtsy6fvG9BviKvGrOSq9MB5Kqqvlrt/lSRmZ9aggRRgOp
	 LZyH/iU7Z5UZsQA9hcPaklUVbYukJSNvfPEytv+1Wz/clbFgPGyXL4TitGQqU+kmDh
	 g7OZFJVJcUlRRsbDVUEE7TwTCng9lA+tQBVqekrXlIIOFRZRNhmm4ADhr54MQuDwVW
	 DKbhjuSf35EY9+ZUjDVGlvC0jgbo4s2nkoQ7nynu5Dze4nQlX3Ts3vNLc+8CntFcls
	 /znaiguEzz3koFjtVu09lkZ897d6BiZ4jvmegjXAP0rF0kwYGMg34e0cms431oE+vj
	 C+fQKVZ/qQS9WuVsmHd0XgHyHO62wvx7DjIMLqVuIod1jPdEfbaw26BWS+kbLhlH/9
	 u1Twhe1dSJUaUm8kWc1yVTeY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26B6C40E0192;
	Wed, 14 Feb 2024 11:05:46 +0000 (UTC)
Date: Wed, 14 Feb 2024 12:05:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214110541.GFZcyehY44eSSYsW2l@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-3-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
> +static inline struct cper_fru_poison_desc *get_fpd(struct fru_rec *rec, u32 entry)
> +{
> +	return &rec->entries[entry];
> +}

This one needs to go too.

> +static inline u32 get_fmp_len(struct fru_rec *rec)
> +{
> +	return rec->sec_desc.section_length - sizeof(struct cper_section_descriptor);
> +}

Oh well, I guess we can keep that one.

> +/* Calculate a new checksum. */
> +static u32 get_fmp_checksum(struct fru_rec *rec)
> +{
> +	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
> +	u32 len, checksum;
> +
> +	len = get_fmp_len(rec);
> +
> +	/* Get the current total. */
> +	checksum = do_fmp_checksum(fmp, len);
> +
> +	/* Subtract the current checksum from total. */
> +	checksum -= fmp->checksum;
> +
> +	/* Return the compliment value. */
> +	return 0 - checksum;
> +}

Let's get rid of that one.

Also, I think it is called *complement* value and you simply do

        /* Use the complement value. */
        rec->fmp.checksum = -checksum;

I'd say.

---

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 9eaf892e35b9..f8799beddcc4 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -195,11 +195,12 @@ static u32 do_fmp_checksum(struct cper_sec_fru_mem_poison *fmp, u32 len)
 	return checksum;
 }
 
-/* Calculate a new checksum. */
-static u32 get_fmp_checksum(struct fru_rec *rec)
+static int update_record_on_storage(struct fru_rec *rec)
 {
 	u32 len, checksum;
+	int ret;
 
+	/* Calculate a new checksum. */
 	len = get_fmp_len(rec);
 
 	/* Get the current total. */
@@ -208,15 +209,8 @@ static u32 get_fmp_checksum(struct fru_rec *rec)
 	/* Subtract the current checksum from total. */
 	checksum -= rec->fmp.checksum;
 
-	/* Return the compliment value. */
-	return 0 - checksum;
-}
-
-static int update_record_on_storage(struct fru_rec *rec)
-{
-	int ret;
-
-	rec->fmp.checksum = get_fmp_checksum(rec);
+	/* Use the complement value. */
+	rec->fmp.checksum = -checksum;
 
 	pr_debug("Writing to storage");
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-65080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B585478C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302EDB21E02
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D91863F;
	Wed, 14 Feb 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bBrhAc9I"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D318EA5;
	Wed, 14 Feb 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907887; cv=none; b=mP4KiYMGyJ3W6UnSkq3I5820nxC2/JIRuYyLawTJlqETrHvySh+16yFkYZVG/6EVESOAUO76bB4iNFyd5ya0Jy8dkhOEr1IwgifbdrykUMSSmCfX952q+it/bIuILtYn+EfsTbMwTasmlWe3xA4/TU2t7jUUq0cotUnwlgRG0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907887; c=relaxed/simple;
	bh=VBOjT9PbPH/2fllTgNRpjqHT9x/jVLbcfon0jVzyn5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m76rAcJvDAy+HfRAspduSEymT0/oFjpOdhBsuv75u9TLH3SnaVOAR0aI2r1EfV3UiujMfhjAaJrT3Dzb2tBw1sTL+kj3QV+C3I85uEaCUYsVe9jujml0IQvPL3rV6cVUO0qeShpD8/eTOjCyQvPm+8rxR6s/n+1y5CBAzCWAtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bBrhAc9I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0DCD840E0192;
	Wed, 14 Feb 2024 10:51:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t_5Xw0DbR89L; Wed, 14 Feb 2024 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707907880; bh=rxGQY0MUeKmQh+xTDLGcVVfLxOjh73vp550f/1FpQj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBrhAc9IpVb+UNBjskRb3a+KXVM9RyRBKoCmOiwtEL1TAGvJ2baymYXc7o5/mH7ok
	 L3atJ4kl8HZdRaJn/rSS9Dp1/rZ/5FdIgYamUtGdfFGo4MqTDWsAVsOZWaVUT9Asdf
	 IV9cQNq6VmMyDcB1Jrzz4xqNfibUJ3tJEtlA2BVH/x85hi6EQLJIjsCnmTINxxL9kW
	 QwIwAwHegeUsoxFleqZ4gw9n9eH7H/pbaJtGwt6cYiAhrgbYLGfXiDOnGkHDw+MXnF
	 5HmOgGe7tapt2O2Rjhbxk4uadcxvvkCkNyBIwQTZA51Fm93on0CWz27TAVsb4VP7p0
	 EV1FRRHmlddjG9Rk3w85JgtJEkkx2yOmeLIy8MwRQ0HT3Rrg6iIOBPJqhSNJNN1oC0
	 fdnVr+oTcc+ksjdNu4F5Fl4qgkClv+FBnCjRbS3YwoV+dO/zOrzTHomYZR96CEMqh/
	 S3vTM1x1R7rUkJU7uZeqgzCdTWpYOrhnXAnLokU3xdNMyrI7aidpXJCybOp/dnIwQz
	 MSr6EDBAgJC+UIKwz04+vVXSGFvpeM7uJxOn11vNu+K29miM1FObydOin2UuqRsMHS
	 5+MMoniZq4z2Ka9fe5F/I1zLNwfHIrlh19Iaz3kJEEosONwFhLgw7hlojDOZ/3YlLh
	 Zq/6EmLUMisV++u7ws26raVs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C29F340E00B2;
	Wed, 14 Feb 2024 10:51:11 +0000 (UTC)
Date: Wed, 14 Feb 2024 11:51:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214105106.GEZcybGu7TkvKzutol@fat_crate.local>
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
> +static inline struct cper_sec_fru_mem_poison *get_fmp(struct fru_rec *rec)
> +{
> +	return &rec->fmp;
> +}

Let's get rid of those silly helpers, diff for this one below.

The logic is, you pass around struct fru_rec *rec and inside the
functions you deref what you need.

Thx.

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 0246b13b5ba1..9eaf892e35b9 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -153,11 +153,6 @@ static DEFINE_MUTEX(fmpm_update_mutex);
 #define for_each_fru(i, rec) \
 	for (i = 0; rec = fru_records[i], i < max_nr_fru; i++)
 
-static inline struct cper_sec_fru_mem_poison *get_fmp(struct fru_rec *rec)
-{
-	return &rec->fmp;
-}
-
 static inline struct cper_fru_poison_desc *get_fpd(struct fru_rec *rec, u32 entry)
 {
 	return &rec->entries[entry];
@@ -174,7 +169,7 @@ static struct fru_rec *get_fru_record(u64 fru_id)
 	unsigned int i;
 
 	for_each_fru(i, rec) {
-		if (get_fmp(rec)->fru_id == fru_id)
+		if (rec->fmp.fru_id == fru_id)
 			return rec;
 	}
 
@@ -203,16 +198,15 @@ static u32 do_fmp_checksum(struct cper_sec_fru_mem_poison *fmp, u32 len)
 /* Calculate a new checksum. */
 static u32 get_fmp_checksum(struct fru_rec *rec)
 {
-	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
 	u32 len, checksum;
 
 	len = get_fmp_len(rec);
 
 	/* Get the current total. */
-	checksum = do_fmp_checksum(fmp, len);
+	checksum = do_fmp_checksum(&rec->fmp, len);
 
 	/* Subtract the current checksum from total. */
-	checksum -= fmp->checksum;
+	checksum -= rec->fmp.checksum;
 
 	/* Return the compliment value. */
 	return 0 - checksum;
@@ -244,12 +238,12 @@ static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
 	fpd->addr	= m->addr;
 }
 
-static bool has_valid_entries(u64 valid_bits)
+static bool has_valid_entries(struct fru_rec *rec)
 {
-	if (!(valid_bits & FMP_VALID_LIST_ENTRIES))
+	if (!(rec->fmp.validation_bits & FMP_VALID_LIST_ENTRIES))
 		return false;
 
-	if (!(valid_bits & FMP_VALID_LIST))
+	if (!(rec->fmp.validation_bits & FMP_VALID_LIST))
 		return false;
 
 	return true;
@@ -282,7 +276,7 @@ static bool is_dup_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *new)
 {
 	unsigned int i;
 
-	for (i = 0; i < get_fmp(rec)->nr_entries; i++) {
+	for (i = 0; i < rec->fmp.nr_entries; i++) {
 		if (same_fpd(get_fpd(rec, i), new)) {
 			pr_debug("Found duplicate record");
 			return true;
@@ -294,7 +288,7 @@ static bool is_dup_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *new)
 
 static void update_fru_record(struct fru_rec *rec, struct mce *m)
 {
-	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
+	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
 	struct cper_fru_poison_desc fpd;
 	u32 entry = 0;
 
@@ -303,15 +297,15 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 	init_fpd(&fpd, m);
 
 	/* This is the first entry, so just save it. */
-	if (!has_valid_entries(fmp->validation_bits))
+	if (!has_valid_entries(rec))
 		goto save_fpd;
 
 	/* Ignore already recorded errors. */
 	if (is_dup_fpd(rec, &fpd))
 		goto out_unlock;
 
-	if (fmp->nr_entries >= max_nr_entries) {
-		pr_warn("Exceeded number of entries for FRU 0x%016llx", fmp->fru_id);
+	if (rec->fmp.nr_entries >= max_nr_entries) {
+		pr_warn("Exceeded number of entries for FRU 0x%016llx", rec->fmp.fru_id);
 		goto out_unlock;
 	}
 
@@ -412,9 +406,9 @@ static void retire_mem_records(void)
 	u32 cpu;
 
 	for_each_fru(i, rec) {
-		fmp = get_fmp(rec);
+		fmp = &rec->fmp;
 
-		if (!has_valid_entries(fmp->validation_bits))
+		if (!has_valid_entries(rec))
 			continue;
 
 		cpu = get_cpu_from_fru_id(fmp->fru_id);
@@ -481,7 +475,7 @@ static int save_new_records(void)
 
 static bool is_valid_fmp(struct fru_rec *rec)
 {
-	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
+	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
 	u32 len = get_fmp_len(rec);
 
 	if (!fmp)
@@ -602,8 +596,10 @@ static int get_saved_records(void)
 	return ret;
 }
 
-static void set_fmp_fields(struct cper_sec_fru_mem_poison *fmp, unsigned int cpu)
+static void set_fmp_fields(struct fru_rec *rec, unsigned int cpu)
 {
+	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
+
 	fmp->fru_arch_type    = FMP_ARCH_TYPE_X86_CPUID_1_EAX;
 	fmp->validation_bits |= FMP_VALID_ARCH_TYPE;
 
@@ -638,7 +634,7 @@ static void init_fmps(void)
 
 	for_each_fru(i, rec) {
 		cpu = get_cpu_for_fru_num(i);
-		set_fmp_fields(get_fmp(rec), cpu);
+		set_fmp_fields(rec, cpu);
 	}
 }
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


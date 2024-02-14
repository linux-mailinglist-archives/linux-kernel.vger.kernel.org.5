Return-Path: <linux-kernel+bounces-65927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D918553DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30E5293D93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90CA13EFE6;
	Wed, 14 Feb 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B9L65EMI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792A13DBA9;
	Wed, 14 Feb 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941954; cv=none; b=jGiNjdNUldnK+KQCP3ZBSTHRNr8+XP9SLaAKZr6ePavdAShMZJw7HY3PCOc6xOZ4NiWqzQhINdY3sDkVWEMKhkAqa1J7ioeIPzf/olLVBz4vJtPkndGh2ERwK9QZ8XrgRKDbR62DSSElTYcR+++P++dF7dDOJsxsxv1NP87e7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941954; c=relaxed/simple;
	bh=c7phOXNT4Dkql8q/Y/2mhdiuhF8tmZLyQsVm70ulEM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFXcGWUHtNvtsgAH9NWImgD9ahKCBkCT2wjDWLtS32TbtOYaLpDq9d99sLTdD7grWEsP/brn67lwwwGGe/pF7NLGeGwY2YzSzfFJuTVOXoq9O//l9uzg54qzXzO+T+dFu4gpoluqPbjhf3sBwGLho3Z7S19fKdUjnU9my55kiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B9L65EMI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B1AF40E01A9;
	Wed, 14 Feb 2024 20:19:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nzSfv2Sp4XZL; Wed, 14 Feb 2024 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707941947; bh=ighEcsqx7KfyfF1ddIXJeKNu80xIvoW6GUDahetkqN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9L65EMIybREj+F+VT3Xfs7LRXTCHux0EQQRoovwDeGYoVLwjZhBOynkZrWVpTrth
	 +WoGFeHdP+LzNc4z4pvKWsJ3DR0UQBJyy8m7eUDWR5KBVJyx/Y6pfudaZ8A/QCuWa/
	 V/AD+MXDuYGbJhZW9oNsNDzKcf6OUGvosDMbTIXUPlstHz5pneiPvJEnjLZckJ1PJG
	 Sw56PPozg1ZzdxTnFQcj9nm1KC5cgse4Z0/JXECONLCeK0fnMsfZVFkXohOcAk9mOh
	 b6hvhEQV2eQEpdxtS3g55WYghUsTcBRB8+Es9nwMgdxXjVTxHjvA5Y1smDSSSgkKZA
	 w3Q0NI08itPSRhM/2CyU8RhQeBaMw5+mX9HSyvyISd2wNPUqm2HTvzpB4itv0NJd5m
	 vYGJm86kxQOI23bgjqRZouS3gZ+2x6A/Oj/NiXQE27g2rwIyZi9AV+H5ZPBfQ0DgiT
	 0H0P3t9NZUd/s+JlC5CbnYlJ8OD0kdysfRpo9NKXsEmdjPCn+lAPVrPzgRYETf9SuI
	 53in3i7fM5D5roM2MgNihmXdnwpyE8592uCwy3NtngjCfhBcm5AtqbEWXIDn5efS8J
	 Ox+UQ2vcQGsjndzbAossnKdSANg/xezG0hUlWO5s0TOPbHlLkp7u0ItjI5kr3dJesL
	 7Do4d2Ca3xF+d4xAfVZVfN+Y=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A30DD40E00B2;
	Wed, 14 Feb 2024 20:18:58 +0000 (UTC)
Date: Wed, 14 Feb 2024 21:18:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214201857.GRZc0gMWRBEzhRznUN@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214120214.GJZcyrxgyLLwQ8y19Z@fat_crate.local>
 <1a46d8cb-104f-4854-a09e-c60095e2dcd0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a46d8cb-104f-4854-a09e-c60095e2dcd0@amd.com>

On Wed, Feb 14, 2024 at 10:33:15AM -0500, Yazen Ghannam wrote:
> I was also thinking that MODULE_DEVICE_TABLE shouldn't be used. Not all
> MI300-based systems will need or can use this module. And it does depend
> on specific platform configurations.
> 
> So the module should not autoload. Users will need to manually load it if
> they know that it's usable on their platform. We can keep the cpuid[] and
> model checks just for extra safety.

Ok, makes sense.

The above converted:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index bcee828cb916..6b280cf503a4 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -447,7 +447,7 @@ static int save_new_records(void)
 	return ret;
 }
 
-static bool is_valid_fmp(struct fru_rec *rec)
+static bool fmp_is_valid(struct fru_rec *rec)
 {
 	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
 	u32 len = get_fmp_len(rec);
@@ -486,19 +486,12 @@ static bool is_valid_fmp(struct fru_rec *rec)
 	return true;
 }
 
-static void restore_record(struct fru_rec *new, struct fru_rec *old)
-{
-	/* Records larger than max_rec_len were skipped earlier. */
-	size_t len = min(max_rec_len, old->hdr.record_length);
-
-	memcpy(new, old, len);
-}
-
 static bool valid_record(struct fru_rec *old)
 {
 	struct fru_rec *new;
+	size_t len;
 
-	if (!is_valid_fmp(old)) {
+	if (!fmp_is_valid(old)) {
 		pr_debug("Ignoring invalid record");
 		return false;
 	}
@@ -509,8 +502,11 @@ static bool valid_record(struct fru_rec *old)
 		return false;
 	}
 
-	/* What if ERST has duplicate FRU entries? */
-	restore_record(new, old);
+	/* Records larger than max_rec_len were skipped earlier. */
+	len = min(max_rec_len, old->hdr.record_length);
+
+	/* Restore the record */
+	memcpy(new, old, len);
 
 	return true;
 }
@@ -588,36 +584,35 @@ static void set_fmp_fields(struct fru_rec *rec, unsigned int cpu)
 	fmp->validation_bits |= FMP_VALID_ID;
 }
 
-static unsigned int get_cpu_for_fru_num(unsigned int i)
-{
-	unsigned int cpu = 0;
-
-	/* Should there be more robust error handling if none found? */
-	for_each_online_cpu(cpu) {
-		if (topology_physical_package_id(cpu) == i)
-			return cpu;
-	}
-
-	return cpu;
-}
-
 static void init_fmps(void)
 {
 	struct fru_rec *rec;
 	unsigned int i, cpu;
 
+	cpus_read_lock();
 	for_each_fru(i, rec) {
-		cpu = get_cpu_for_fru_num(i);
-		set_fmp_fields(rec, cpu);
+		int fru_cpu = -1;
+
+		for_each_online_cpu(cpu) {
+			if (topology_physical_package_id(cpu) == i) {
+				fru_cpu = i;
+				break;
+			}
+		}
+
+		if (fru_cpu < 0)
+			continue;
+
+		set_fmp_fields(rec, fru_cpu);
 	}
+	cpus_read_unlock();
 }
 
 static int get_system_info(void)
 {
-	u8 model = boot_cpu_data.x86_model;
-
 	/* Only load on MI300A systems for now. */
-	if (!(model >= 0x90 && model <= 0x9f))
+	if (!(boot_cpu_data.x86_model >= 0x90 &&
+	      boot_cpu_data.x86_model <= 0x9f))
 		return -ENODEV;
 
 	if (!cpu_feature_enabled(X86_FEATURE_AMD_PPIN)) {
@@ -641,7 +636,7 @@ static int get_system_info(void)
 	return 0;
 }
 
-static void deallocate_records(void)
+static void free_records(void)
 {
 	struct fru_rec *rec;
 	int i;
@@ -728,7 +723,7 @@ static int __init fru_mem_poison_init(void)
 	return 0;
 
 out_free:
-	deallocate_records();
+	free_records();
 out:
 	return ret;
 }
@@ -736,7 +731,7 @@ static int __init fru_mem_poison_init(void)
 static void __exit fru_mem_poison_exit(void)
 {
 	mce_unregister_decode_chain(&fru_mem_poison_nb);
-	deallocate_records();
+	free_records();
 }
 
 module_init(fru_mem_poison_init);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


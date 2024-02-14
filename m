Return-Path: <linux-kernel+bounces-65890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A12855368
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A727284EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B5213B7BB;
	Wed, 14 Feb 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AOTxkfEP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521E13A26C;
	Wed, 14 Feb 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939892; cv=none; b=P2wpnqXOKvsrMC28fhY4iZyUFPcy9cmw/TIVrdA7+8lNC/PbjX7bCr0+GehrxImZo/iJl+FIC+tzo0LXRytayxw0B4M7XXXxJ+K6R6Bq/lbMfvKtyo9lbJgJBWrizgSsiFNowf7hmHUd9zkmZJdI8Smr+/L3qZUMteLDFOAnqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939892; c=relaxed/simple;
	bh=BZPqiBFNggsLuV63nhHoEmeUkaGZnU0OIcQ97gfnPvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXesXWJ0Hqyr9zVPChfmGqLFj9nCQ5OtA4s3X0G7TKd549d3ad89Vb9m/fkxv1RfrVLP5lfk2x29+dGMTt4N2ItqChBn8Fa+udzE2J746mOCJzal2w/j/XRmKQIFHRzF/dXTQrHZzYZR6gp+9cUtd87VXdvoZ+Y/c9DlPJT8g/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AOTxkfEP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B83AD40E01A9;
	Wed, 14 Feb 2024 19:44:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m-80sX-7yTap; Wed, 14 Feb 2024 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707939884; bh=LOrbkDutgTY89nsP3CR1ZAUaY3za83ltlqWwp3QISus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOTxkfEPENL/Of8oEUaxD587SyqmDPww6pQLYq7Eh4PerKZ37KOh1PHzBmh8HcVkg
	 PId17adD0B9Gyfe/FgCdNOXUqCWC2s2qhAjYzghn25QQuHahzfE4xOg7z3VCJOorpw
	 tH+Iao/1mlZBWQQAaqOY7BAJfo4pLhJfD2V59hjbKWgK7yCAzUpqd7Mab20yvrSCvE
	 JWylprl9NyJnaBD2gziphxO9EKKxO3gaNJC1AO3E7/GDmkPoxiB6DO0VbtW+9q9Tva
	 GVAka+91rQYUIxTTA4XpFAYHYI4JsfS40IqmBrGbxI6XAkZbJh2H5Md46rNCULMKzm
	 oq9Hx9eqslrpD6Ia2+s/2t7IpQeXCVY9QgWmzLzQJj38z2J3jfg+cYL4cwdgXMn6I0
	 12P78hE3GscEKS8KmvZwB4J9/gb1WkK2yTcB4Pp22am1k9PsphNQVNebasqLW860Nj
	 v5yDSEI2wLvXdQPQboBYrvmk96vS5KvAoBXoVONM84M8Jj1ppy0pF5kiCAWdaeYfhL
	 O1QWepe9OOSTxz+lXMzxQ1C60cjhNFTkkBHE3KteLKuY000RLIc8+kGhgVYeTHDwSr
	 bweBlfmglrqiTCl/xJDhW8wxVDy/UFbwij/7/vnvt2rLo/3iXKOrEM7aAkEbNXJFng
	 udNaDJucuZqFihQa8Vzqs5aM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EA1940E00B2;
	Wed, 14 Feb 2024 19:44:35 +0000 (UTC)
Date: Wed, 14 Feb 2024 20:44:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214194427.GPZc0YG1e_6QWbGUQQ@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214113630.GIZcylvp6-m-FNNE7H@fat_crate.local>
 <4096ae55-62bb-4705-94dc-ccf90ee64988@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4096ae55-62bb-4705-94dc-ccf90ee64988@amd.com>

On Wed, Feb 14, 2024 at 10:26:41AM -0500, Yazen Ghannam wrote:
> > > +	/* This is the first entry, so just save it. */
> > > +	if (!has_valid_entries(fmp->validation_bits))
> > > +		goto save_fpd;
> > 
> > Not needed - if it is the first entry, it'll get saved there.
> > 
> 
> Get saved where?
> 
> For brand new records, the module will allocate them with the headers
> and no descriptor entries (empty list).

As discussed offlist, let's stick to checking validation_bits even if
->nr_entries should be 0 when rec doesn't have valid entries yet.

So lemme readd it.

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index e50f11fb90a4..daab7f58505a 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -275,6 +275,10 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 	fpd.addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
 	fpd.addr	= m->addr;
 
+	/* This is the first entry, so just save it. */
+	if (!rec_has_valid_entries(rec))
+		goto save_fpd;
+
 	/* Ignore already recorded errors. */
 	if (rec_has_fpd(rec, &fpd))
 		goto out_unlock;
@@ -287,6 +291,7 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 	entry	  = fmp->nr_entries;
 	fpd_dest  = &rec->entries[entry];
 
+save_fpd:
 	memcpy(fpd_dest, &fpd, sizeof(struct cper_fru_poison_desc));
 
 	fmp->nr_entries		 = entry + 1;


> > Yap, exactly, this should use atl_err and not struct mce.
> > 
> 
> Yes, tried to do *some* things generic.

Right.

> > > +	 * This should not happen on real errors. But it could happen from
> > 
> > What exactly is "This" here?
> > 
> 
> Ah right. The module should have created, or restored, a record for each FRU
> in the system during module init. So the runtime handler should always find
> a valid record for a FRU. The only exception I could think of, besides bugs,
> is if the user does software error injection and a valid FRU ID doesn't get
> set.

Changed to:

        /*
         * An invalid FRU ID should not happen on real errors. But it
         * could happen from software error injection, etc.
         */
        rec = get_fru_record(m->ppin);

> > Pass in that fmp thing into retire_dram_row() so that you can delay
> > that get_cpu_from_fru_id() call until the moment you actually need it.

IOW, this:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index a314598186a0..c2dc83a4e82a 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -47,6 +47,7 @@
 
 #include <linux/cper.h>
 #include <linux/ras.h>
+#include <linux/cpu.h>
 
 #include <acpi/apei.h>
 
@@ -347,21 +348,10 @@ static struct notifier_block fru_mem_poison_nb = {
 	.priority	= MCE_PRIO_LOWEST,
 };
 
-static u32 get_cpu_from_fru_id(u64 fru_id)
-{
-	unsigned int cpu = 0;
-
-	/* Should there be more robust error handling if none found? */
-	for_each_online_cpu(cpu) {
-		if (topology_ppin(cpu) == fru_id)
-			break;
-	}
-
-	return cpu;
-}
-
-static void retire_mem_fmp(struct fru_rec *rec, u32 nr_entries, u32 cpu)
+static void retire_mem_fmp(struct fru_rec *rec, u32 nr_entries)
 {
+	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
+	unsigned int cpu, err_cpu = -1;
 	unsigned int i;
 
 	for (i = 0; i < nr_entries; i++) {
@@ -373,7 +363,16 @@ static void retire_mem_fmp(struct fru_rec *rec, u32 nr_entries, u32 cpu)
 		if (fpd->addr_type != FPD_ADDR_TYPE_MCA_ADDR)
 			continue;
 
-		retire_dram_row(fpd->addr, fpd->hw_id, cpu);
+		cpus_read_lock();
+		for_each_online_cpu(cpu) {
+			if (topology_ppin(cpu) == fmp->fru_id) {
+				err_cpu = cpu;
+				break;
+			}
+		}
+		cpus_read_unlock();
+
+		retire_dram_row(fpd->addr, fpd->hw_id, err_cpu);
 	}
 }
 
@@ -382,7 +381,6 @@ static void retire_mem_records(void)
 	struct cper_sec_fru_mem_poison *fmp;
 	struct fru_rec *rec;
 	unsigned int i;
-	u32 cpu;
 
 	for_each_fru(i, rec) {
 		fmp = &rec->fmp;
@@ -390,9 +388,7 @@ static void retire_mem_records(void)
 		if (!rec_has_valid_entries(rec))
 			continue;
 
-		cpu = get_cpu_from_fru_id(fmp->fru_id);
-
-		retire_mem_fmp(rec, fmp->nr_entries, cpu);
+		retire_mem_fmp(rec, fmp->nr_entries);
 	}
 }
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


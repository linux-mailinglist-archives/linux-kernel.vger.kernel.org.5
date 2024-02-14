Return-Path: <linux-kernel+bounces-65826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453E855282
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D685C2888C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56C134CD9;
	Wed, 14 Feb 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UyDrvRw0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F112F598;
	Wed, 14 Feb 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936285; cv=none; b=KXskgip6aH5SFuyFsdgmPblKt5f3KZD4tTfPZel854FQzfCMGAMj+BRnM6cuFdY9FPyuDptXcyXRv/u3UqktMY1m9Pvx4L6N3SHvV9BmpR2+L2WvMHaJAqoiCkE4KjgHhylJg3NgdEzBx6PcBA78Z/3e/61wvp9vndvKBmaL1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936285; c=relaxed/simple;
	bh=uD+/f2teJKsFCPXY5eQJTRjF7hC8K1LL4j9UeYj59Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVKYqu7HbS/OTmisQ0HJgtgK6Po0kKZfStg3FS+5SlpQvurrZ2hbNuEpn4wRmDnwUqipaEXxkpv67rGHRHecnKYsdE5t2X37aAm8egvF+nJTRIq28pn59r1rCvvEiguNRxvT8+iVzgx5TCl0oYAFq459S6PRcJyBxIDVAhy6iYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UyDrvRw0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5CC740E01BB;
	Wed, 14 Feb 2024 18:44:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pADLPMB760tG; Wed, 14 Feb 2024 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707936278; bh=hPjwBz+7GPfxkRtkOoKm116lDwc03zgFS/o6mesmDKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyDrvRw0dbXag6vks8q/YkiYSTI4nAX2LEDiV4qqwhIMEQE2xzuwNNL7sJ/uVsYAN
	 Cij167krmYVSwTuN47C5WH+IXluhwpMRZVVO6KqbRS1hCNO/bwNvC+bTQm6twUVNNR
	 kMX3Nn6axYX+mk6hzL67sfxpVF6h2rDssaxcPtE91zVAwjziz2xfAeuU7DxevH9YCe
	 ztZjSCBG538tJBNdYT60HAKCpCLn0yW1oFDtSlTUm3REagulYN9ES43PEZxAZBdChu
	 hiQRa0kZLYJbAybdlWOMQk4hEMYdRRY/EQYa24r4ry9cSk0k3HHz/Eqn8RVbuutSfh
	 wa75gkxIm76M+DYLbDFqs6R3UxcMRhqS56VZQIJABVgS2woeKRkjJFkrKN79CyaZLK
	 ERGol1412fagrRPCb5g4yy3M3CpJZ+mpwOle6QwSfMrBhwc/xQSrd61Oqj3UNYZotD
	 qnrRX0gcj4fx32xiuOh4RS9kBW+tjnIdnJTwsru1SoNVxca4EP4r9I39HX0E54f1Fr
	 yEfWjiyaYqrrBwrCMHViYbAbSy3sRYMLoAN72FWxtGSTqONMGlxX0dAwCONFBHLlVE
	 O/9wC/WlXhuZ+7Vm9/tYvEWAVaPnSNSy8+Qcd9vsN4ldURGuFkfsWKJ/vmKlA3suqL
	 FRIgTT59zXPg6zJyL6m3rfLQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BAED40E016C;
	Wed, 14 Feb 2024 18:44:29 +0000 (UTC)
Date: Wed, 14 Feb 2024 19:44:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214184423.GNZc0KB_8va7gUyk_m@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214110541.GFZcyehY44eSSYsW2l@fat_crate.local>
 <3f793ed7-b65c-48d0-a556-f51bdf4f5add@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f793ed7-b65c-48d0-a556-f51bdf4f5add@amd.com>

On Wed, Feb 14, 2024 at 09:56:14AM -0500, Yazen Ghannam wrote:
> > This one needs to go too.
> > 
> 
> Ack.

Gone:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index a67a4b67cf9d..643c36b6dc9c 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -146,11 +146,6 @@ static DEFINE_MUTEX(fmpm_update_mutex);
 #define for_each_fru(i, rec) \
 	for (i = 0; rec = fru_records[i], i < max_nr_fru; i++)
 
-static inline struct cper_fru_poison_desc *get_fpd(struct fru_rec *rec, u32 entry)
-{
-	return &rec->entries[entry];
-}
-
 static inline u32 get_fmp_len(struct fru_rec *rec)
 {
 	return rec->sec_desc.section_length - sizeof(struct cper_section_descriptor);
@@ -253,7 +248,9 @@ static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
 	unsigned int i;
 
 	for (i = 0; i < rec->fmp.nr_entries; i++) {
-		if (same_fpd(get_fpd(rec, i), fpd)) {
+		struct cper_fru_poison_desc *fpd_i = &rec->entries[i];
+
+		if (same_fpd(fpd_i, fpd)) {
 			pr_debug("Found duplicate record");
 			return true;
 		}
@@ -265,7 +262,7 @@ static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
 static void update_fru_record(struct fru_rec *rec, struct mce *m)
 {
 	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
-	struct cper_fru_poison_desc fpd;
+	struct cper_fru_poison_desc fpd, *fpd_dest;
 	u32 entry = 0;
 
 	mutex_lock(&fmpm_update_mutex);
@@ -287,9 +284,10 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 		goto out_unlock;
 	}
 
-	entry = fmp->nr_entries;
+	entry	  = fmp->nr_entries;
+	fpd_dest  = &rec->entries[entry];
 
-	memcpy(get_fpd(rec, entry), &fpd, sizeof(struct cper_fru_poison_desc));
+	memcpy(fpd_dest, &fpd, sizeof(struct cper_fru_poison_desc));
 
 	fmp->nr_entries		 = entry + 1;
 	fmp->validation_bits	|= FMP_VALID_LIST_ENTRIES;
@@ -359,11 +357,10 @@ static u32 get_cpu_from_fru_id(u64 fru_id)
 
 static void retire_mem_fmp(struct fru_rec *rec, u32 nr_entries, u32 cpu)
 {
-	struct cper_fru_poison_desc *fpd;
 	unsigned int i;
 
 	for (i = 0; i < nr_entries; i++) {
-		fpd = get_fpd(rec, i);
+		struct cper_fru_poison_desc *fpd = &rec->entries[i];
 
 		if (fpd->hw_id_type != FPD_HW_ID_TYPE_MCA_IPID)
 			continue;


> >          /* Use the complement value. */
> >          rec->fmp.checksum = -checksum;
> > 
> > I'd say.
> > 
> 
> This was my first thought. Other checksum code in the kernel does
> the (0-X) thing. So I wasn't sure if there's any odd side effects
> of one over the other. And I didn't take the time to dig into it.

I guess to probably be more expressive? I don't see how

0 - X

and 

-X

differ.

And you can always do a before-after and look at the asm:

before:
# drivers/ras/amd/fmpm.c:202:   rec->fmp.checksum = 0 - checksum;
#NO_APP
        subl    %edx, %eax      # checksum, tmp100
        movl    %eax, 200(%rbx) # tmp100, rec_9(D)->fmp.checksum

after:
# drivers/ras/amd/fmpm.c:202:   rec->fmp.checksum = -checksum;
#NO_APP
        subl    %edx, %eax      # checksum, tmp100
        movl    %eax, 200(%rbx) # tmp100, rec_9(D)->fmp.checksum


> > -/* Calculate a new checksum. */
> > -static u32 get_fmp_checksum(struct fru_rec *rec)
> 
> I made this a helper because we need to validate the checksum when
> reading records from storage too.

It has a single user that's why I whacked it. If a new one materializes,
sure, you can carve it out.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


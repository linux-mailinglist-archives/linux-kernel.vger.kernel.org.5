Return-Path: <linux-kernel+bounces-65142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B7854886
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B40AB27103
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF89199BA;
	Wed, 14 Feb 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lOxmPwcF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C41B814;
	Wed, 14 Feb 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910618; cv=none; b=uzPwX7VVudFKDONjiHtyYZg53GxXZOeyY7AMX43qBypgqiXQRGmUH/bqjRdMEijRLncABMh01oAR1AokQWJ1heLReWp8qP3PUNoTL1wy5wNgG38i8LnrWuDQvfiW2ad4hNnAkAcIjyM7PHCFSPHVSWhUwRGUKFiJ+7jaS0Rusc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910618; c=relaxed/simple;
	bh=T2WqLz2CjW9RPWZ0uth+/4gEHhoWLi0lbC1jmZPBsTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxnsxBEZo7SGKtL70AGGXpbEfFGsF5wr5KtCtrIasEiEp3w4Pih083VMneAN9HV3xlRoSab3Yss95nOEMgZbBbjNCXdg8n1rJXPOQN8joAhnvnatlDNuoJVU/93/afh5XIePNEgqqprZJ1PDaqvcnGI45Z3Py10DC45qy00n3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lOxmPwcF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B037440E0192;
	Wed, 14 Feb 2024 11:36:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id id0nTapW-7z7; Wed, 14 Feb 2024 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707910605; bh=rOr6deuDvMexUVv1eZg26bnq02kxdFci8fGUtHaJovs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOxmPwcFp5f8VWJePTlH0iOrnDP+Sfpnj47A4WrOBel8yYmXsn4u6WZC+GecDzv1V
	 BrdqZNwHWpKrnwtM7uwVOUgtNTDMcjYatar8tHD+twZFp8z9DdB2HhW5QQ8bRjNaqs
	 UU5ZTeABC2PmdpbD83S/eRwGCzcuyNN4zp0YU4HXRla7JCAXYLPhwGCDvmaKquPbui
	 g2b8c9YI40WyQwZ6Z+L12+/vqrmwjQVpLDrykuYaoT2fqZGFw/V8cumiTxaoWMKgS2
	 J/wkK9sY9pq4j1ETbm9LLznlCj2KwdDI1dHwcyNcsPvirzxlT4/j3jOVVzav4MBfPu
	 Pvcgpp5TMnj1SCuz95TLJFBwnTMVGpebNwfI7PhjvGgRX0JOKyEyT6kUnJcVYx7pIK
	 E7493WhztPtNpxzERyLyAliyKiK81a6hpaPKsM6j8d4FqBgoLbIeMJ784D1PZ+o2mE
	 jCT8pSBUw/WMhWeU0jYj0cAXyaOR2OqDj1bnzKAgoMf7UotUy0OtBHSob15P0/bgiL
	 urhACpwjyunsOHZrEKmVHklUCbmUD+Ev1D3XsReW+1rU38Q7SWzPJvCdOYS8VzwkKQ
	 tq3uux3C6RQa0VOG4+nRsClx0xlghZK7DC8brhXcmL8bxmzaaN0k8080gwI2BWD6Mh
	 giRZ0ex00HvPW98mYr22mFRM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7120C40E0254;
	Wed, 14 Feb 2024 11:36:36 +0000 (UTC)
Date: Wed, 14 Feb 2024 12:36:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214113630.GIZcylvp6-m-FNNE7H@fat_crate.local>
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
> +static void update_fru_record(struct fru_rec *rec, struct mce *m)
> +{
> +	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
> +	struct cper_fru_poison_desc fpd;
> +	u32 entry = 0;
> +
> +	mutex_lock(&fmpm_update_mutex);
> +
> +	init_fpd(&fpd, m);
> +
> +	/* This is the first entry, so just save it. */
> +	if (!has_valid_entries(fmp->validation_bits))
> +		goto save_fpd;

Not needed - if it is the first entry, it'll get saved there.

> +	/* Ignore already recorded errors. */
> +	if (is_dup_fpd(rec, &fpd))
> +		goto out_unlock;
> +
> +	if (fmp->nr_entries >= max_nr_entries) {
> +		pr_warn("Exceeded number of entries for FRU 0x%016llx", fmp->fru_id);
> +		goto out_unlock;
> +	}
> +
> +	entry = fmp->nr_entries;

..

> +static void retire_dram_row(u64 addr, u64 id, u32 cpu)
> +{
> +	struct atl_err a_err;

Yap, exactly, this should use atl_err and not struct mce.

> +
> +	memset(&a_err, 0, sizeof(struct atl_err));
> +
> +	a_err.addr = addr;
> +	a_err.ipid = id;
> +	a_err.cpu  = cpu;
> +
> +	amd_retire_dram_row(&a_err);
> +}
> +
> +static int fru_mem_poison_handler(struct notifier_block *nb, unsigned long val, void *data)
> +{
> +	struct mce *m = (struct mce *)data;
> +	struct fru_rec *rec;
> +
> +	if (!mce_is_memory_error(m))
> +		return NOTIFY_DONE;
> +
> +	retire_dram_row(m->addr, m->ipid, m->extcpu);
> +
> +	/*
> +	 * This should not happen on real errors. But it could happen from

What exactly is "This" here?

> +	 * software error injection, etc.
> +	 */
> +	rec = get_fru_record(m->ppin);
> +	if (!rec)
> +		return NOTIFY_DONE;
> +
> +	update_fru_record(rec, m);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block fru_mem_poison_nb = {
> +	.notifier_call  = fru_mem_poison_handler,
> +	.priority	= MCE_PRIO_LOWEST,
> +};
> +
> +static u32 get_cpu_from_fru_id(u64 fru_id)

Fold into the single callsite.

> +{
> +	unsigned int cpu = 0;
> +
> +	/* Should there be more robust error handling if none found? */
> +	for_each_online_cpu(cpu) {
> +		if (topology_ppin(cpu) == fru_id)
> +			break;
> +	}
> +
> +	return cpu;
> +}
> +
> +static void retire_mem_fmp(struct fru_rec *rec, u32 nr_entries, u32 cpu)
> +{
> +	struct cper_fru_poison_desc *fpd;
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_entries; i++) {
> +		fpd = get_fpd(rec, i);
> +
> +		if (fpd->hw_id_type != FPD_HW_ID_TYPE_MCA_IPID)
> +			continue;
> +
> +		if (fpd->addr_type != FPD_ADDR_TYPE_MCA_ADDR)
> +			continue;
> +
> +		retire_dram_row(fpd->addr, fpd->hw_id, cpu);
> +	}
> +}
> +
> +static void retire_mem_records(void)
> +{
> +	struct cper_sec_fru_mem_poison *fmp;
> +	struct fru_rec *rec;
> +	unsigned int i;
> +	u32 cpu;
> +
> +	for_each_fru(i, rec) {
> +		fmp = get_fmp(rec);
> +
> +		if (!has_valid_entries(fmp->validation_bits))
> +			continue;
> +
> +		cpu = get_cpu_from_fru_id(fmp->fru_id);

Pass in that fmp thing into retire_dram_row() so that you can delay
that get_cpu_from_fru_id() call until the moment you actually need it.

> +static int save_new_records(void)
> +{
> +	struct fru_rec *rec;
> +	unsigned int i;
> +	int ret = 0;
> +
> +	for_each_fru(i, rec) {
> +		/* Skip restored records. Should these be fixed up? */

I don't understand that question.

> +		if (rec->hdr.record_length)
> +			continue;
> +
> +		set_rec_fields(rec);
> +
> +		ret = update_record_on_storage(rec);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool is_valid_fmp(struct fru_rec *rec)

fmp_is_valid()

> +{
> +	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
> +	u32 len = get_fmp_len(rec);
> +
> +	if (!fmp)
> +		return false;
> +
> +	if (!len)
> +		return false;
> +
> +	/* Checksum must sum to zero for the entire section. */
> +	if (do_fmp_checksum(fmp, len))
> +		return false;
> +
> +	if (!(fmp->validation_bits & FMP_VALID_ARCH_TYPE))
> +		return false;
> +
> +	if (fmp->fru_arch_type != FMP_ARCH_TYPE_X86_CPUID_1_EAX)
> +		return false;
> +
> +	if (!(fmp->validation_bits & FMP_VALID_ARCH))
> +		return false;
> +
> +	if (fmp->fru_arch != cpuid_eax(1))
> +		return false;
> +
> +	if (!(fmp->validation_bits & FMP_VALID_ID_TYPE))
> +		return false;
> +
> +	if (fmp->fru_id_type != FMP_ID_TYPE_X86_PPIN)
> +		return false;
> +
> +	if (!(fmp->validation_bits & FMP_VALID_ID))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void restore_record(struct fru_rec *new, struct fru_rec *old)
> +{
> +	/* Records larger than max_rec_len were skipped earlier. */
> +	size_t len = min(max_rec_len, old->hdr.record_length);
> +
> +	memcpy(new, old, len);
> +}

Fold into the single call site.

> +
> +static bool valid_record(struct fru_rec *old)
> +{
> +	struct fru_rec *new;
> +
> +	if (!is_valid_fmp(old)) {
> +		pr_debug("Ignoring invalid record");
> +		return false;
> +	}
> +
> +	new = get_fru_record(old->fmp.fru_id);
> +	if (!new) {
> +		pr_debug("Ignoring record for absent FRU");
> +		return false;
> +	}
> +
> +	/* What if ERST has duplicate FRU entries? */
> +	restore_record(new, old);
> +
> +	return true;
> +}
> +
> +/*
> + * Fetch saved records from persistent storage.
> + *
> + * For each found record:
> + * - If it was not created by this module, then ignore it.
> + * - If it is valid, then copy its data to the local cache.
> + * - If it is not valid, then erase it.
> + */
> +static int get_saved_records(void)
> +{
> +	struct fru_rec *old;
> +	u64 record_id;
> +	int ret, pos;
> +	ssize_t len;
> +
> +	/*
> +	 * Assume saved records match current max size.
> +	 *
> +	 * However, this may not be true depending on module parameters.

This must work with module parameters, though. Or, as said and
preferrably, there should not be any module parameters at all.

> +	 */
> +	old = kmalloc(max_rec_len, GFP_KERNEL);
> +	if (!old) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = erst_get_record_id_begin(&pos);
> +	if (ret < 0)
> +		goto out_end;
> +
> +	while (!erst_get_record_id_next(&pos, &record_id)) {
> +		/*
> +		 * Make sure to clear temporary buffer between reads to avoid
> +		 * leftover data from records of various sizes.
> +		 */
> +		memset(old, 0, max_rec_len);
> +
> +		len = erst_read_record(record_id, &old->hdr, max_rec_len,
> +				       sizeof(struct fru_rec), &CPER_CREATOR_FMP);
> +
> +		/* Should this be retried if the temporary buffer is too small? */

Only when it turns out that it is necessary.

> +		if (len < 0)
> +			continue;
> +
> +		if (!valid_record(old))
> +			erst_clear(record_id);

Where is the check which ignores the record not created by this module?

Because this clears all records it deems not valid and that thing needs
to be really careful here and be sure what exactly it clears...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


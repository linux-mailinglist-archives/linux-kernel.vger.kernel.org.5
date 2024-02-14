Return-Path: <linux-kernel+bounces-65112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77488547F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066361C2121F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7301946C;
	Wed, 14 Feb 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Bsai7rLH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C18199B0;
	Wed, 14 Feb 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909373; cv=none; b=tefTtHPl0D1QAPE1KeeGwRdr2KeUXhc6uzKng2mksARr9+BBd3LAef2Y8H4YFXy6v3gxCGJ/5DPr5fxLtwQ1xc4TJePzysi2Oih0J1jWxCWb9GExvdNNe3KIgqQpGDeeA3IJzz5IpOKE1w4mjebwytnbM7EkL8Cq1OTAFzfom7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909373; c=relaxed/simple;
	bh=9uc3h6VGRAOPOB5YNK3g0U3uRZXHDiKUqlVGRywrnns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k95JPo4Y88+WLGZWs/glmjKnd7qBzyunYqqceHbWAww8XiBvg1ieA6SshphgjFjCzjNXtePq+3c9j+i0izJ6DatA3vGNovq5mwMYD2TLGm8BZ0qyvOAKKHYWCu2M0sxL8Ph4j5Rumi3gvdQfB4gXZDt8RkexbEbuLT54lNm52sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Bsai7rLH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08B4840E00B2;
	Wed, 14 Feb 2024 11:16:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i9vhKTJuEWxZ; Wed, 14 Feb 2024 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707909365; bh=68HGXZNF8lYfnnpQilJCkwD6KTVhoDCMdZz8oKRmH2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bsai7rLHj+ayOGPsj3cUSlcqHnslZCfruS387B9WKPgLIYifRG4qJgti4w2dfMIeA
	 bQt/OeNoFzg087bnrKLKQa1Qq5DfgXjsemlgqjf15M9S6DMLKa7j/i9NxlBM2bvKSz
	 QzQtpgW5W1VTVjGINvkiKS+ynwAAyzM509eR8AqhNGWKG/MIVuRbAT4qQsUgu9Cfku
	 fsZdI2/csgKVIJQZKuyi9Vgr5RvTf/lu2vPjRoALJT5CUsIVzkRFiG4cv2QQxbvVxY
	 w+wPUfkdYmTZ7PqCJJzZnN4vLU0Q08Uuw+OX7yMImPLktfG8B6OH4zosNU83yyXFZ6
	 FfXNkZ0VWEnDyncnSQjyXvZHfQXi1OmT7r9ySfbnJbqXZYW9dEBWbrX80BcWaJ3KuR
	 ouwnoOUTgmo4kWNUWwG7PBlWN/eYFRuZudBNQLTETrlDEwyNqTE9Ptc+qKoeDf8OaK
	 bDbv/CeGw51UzAT7C7ioQiVuWwsho2HrkbrJUb9L22LrSVgiE83WFq0yIS1txs2Kg9
	 /WvwfQ0JUCwPORBv1Pta5FhFE8oJfZo4llhD5bOhoqw7tI3mrTlwwt54Q2iCpcAiqR
	 BpVBj0Xd6pRXKKmoxQy/fuDdN9ZlxFjDhL3DIGe3YB0C3Q+xxVtvxSoTEun6GjwyJL
	 hoJJbTnQ0dIZ8BZCAT6/EQcU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4614D40E016C;
	Wed, 14 Feb 2024 11:15:56 +0000 (UTC)
Date: Wed, 14 Feb 2024 12:15:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214111555.GHZcyg6y_CdpA42a91@fat_crate.local>
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
> +static bool has_valid_entries(u64 valid_bits)
> +{
> +	if (!(valid_bits & FMP_VALID_LIST_ENTRIES))
> +		return false;
> +
> +	if (!(valid_bits & FMP_VALID_LIST))
> +		return false;
> +
> +	return true;
> +}

Rename:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 090b60d269e7..3da3f40f1efe 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -221,7 +221,7 @@ static int update_record_on_storage(struct fru_rec *rec)
 	return ret;
 }
 
-static bool has_valid_entries(struct fru_rec *rec)
+static bool rec_has_valid_entries(struct fru_rec *rec)
 {
 	if (!(rec->fmp.validation_bits & FMP_VALID_LIST_ENTRIES))
 		return false;
@@ -286,7 +286,7 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 	fpd.addr	= m->addr;
 
 	/* This is the first entry, so just save it. */
-	if (!has_valid_entries(rec))
+	if (!rec_has_valid_entries(rec))
 		goto save_fpd;
 
 	/* Ignore already recorded errors. */
@@ -397,7 +397,7 @@ static void retire_mem_records(void)
 	for_each_fru(i, rec) {
 		fmp = &rec->fmp;
 
-		if (!has_valid_entries(rec))
+		if (!rec_has_valid_entries(rec))
 			continue;
 
 		cpu = get_cpu_from_fru_id(fmp->fru_id);

---

and this one:

---

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 3da3f40f1efe..813cc6a4f435 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -255,12 +255,12 @@ static bool same_fpd(struct cper_fru_poison_desc *old, struct cper_fru_poison_de
 	return true;
 }
 
-static bool is_dup_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *new)
+static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
 {
 	unsigned int i;
 
 	for (i = 0; i < rec->fmp.nr_entries; i++) {
-		if (same_fpd(get_fpd(rec, i), new)) {
+		if (same_fpd(get_fpd(rec, i), fpd)) {
 			pr_debug("Found duplicate record");
 			return true;
 		}
@@ -290,7 +290,7 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 		goto save_fpd;
 
 	/* Ignore already recorded errors. */
-	if (is_dup_fpd(rec, &fpd))
+	if (rec_has_fpd(rec, &fpd))
 		goto out_unlock;
 
 	if (rec->fmp.nr_entries >= max_nr_entries) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


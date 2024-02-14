Return-Path: <linux-kernel+bounces-65050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD24854726
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B81D1F219BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FA1758C;
	Wed, 14 Feb 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C9QMQ6yK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479918622;
	Wed, 14 Feb 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906591; cv=none; b=RJ68+JDzFav9T4/0MH4BtlEwpUnAdZ3kpkv+TloTTBsTJB4T0p1VDS2EYbriKCKyxYVxuwRuvCo41+esvvK+K5FqbfDPNFToKzm7oLj8uBXQSIyxk5A5hmZfNybD6rjONH1ebEn9OUJbSBH8HXEy66hpPJ82tBU9H6OEiG7u9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906591; c=relaxed/simple;
	bh=P8NIjxnK1HpiSt8JOMSGnObb9cSdOm4A3Kl6MdIabe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKJ4K4Dm6Y8R+4j9blAXpH1U61VmsBA974vPbqlbLlgIqJ8wvYJ6MdnpVzr/3p365or6hU6jFHY8UiCb538pf7DwYb9i7Ea2QrVoP28ZMMqkleU/RiSU50XMqBoMca6d2uOipG/w6g9LEzMk4tuBeAS4z4gmKIkVZUicOyiwT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C9QMQ6yK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 537F940E0192;
	Wed, 14 Feb 2024 10:29:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OJkRduORFJq7; Wed, 14 Feb 2024 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707906583; bh=7/LMMLekrkUxQZt8slNeuu2XCYWDTa2NzF89+ohaswY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9QMQ6yKDpmEIF1ahn39D8l/7HFv4shwH0OPcYcHug6Iy2UIijdW5sUKsAiTug2lX
	 LnmNo682LxpVQZ+AOdtO2kVrBxgSlc1sAc1BvyXIWJ4pjTLQRVb75NHmpaOgMorPEa
	 +jlpWzb2zBT7qCBWXYt7/N67dAAqY52HL+ZiphbUKrUJHS5j/TPVeWTuIdORw/pzkU
	 QsbJlX3DC02kdL4aRa1htYey2rYi6HOzHU+5jqnMobxrWTb8rP7zl0jHQ8Q3OJx/7w
	 kNUfn0qr70SNBBjeyaSHtEDx6/Cetlqy/hndUGdIQyZNptgjVJx898LKSQ7X5VV33p
	 fCW76Ep89RWfZqTAeidiXF3YiLaSKKqZjGrdk+ruSZsunhYYywXUSDWBZfo/nNGMxg
	 SnEckHnI4zfM5tofD20K3OdgnLesMmGeg6ngukd+5Vbhn4kyc3NK45QVVCtasqAfPS
	 AXeAAqJ80Gw3vxlnvbFN0AiMOuwaGaAFz/3CVb0r8bvewQKf7OFloG93BI+J9yCsda
	 W5ni+nhkFaemhkkNkM0JXjL6sEVmx9wJ0EvQdraZ+x5XQw9ZqaHCUDCae5ZJu4+8yU
	 Eqs+KMFq4KsP9WBQWPWjG57YTtjNOGPaX/Oa8y/R8v38aqCUSK4Umexq0Oj6JlkU7m
	 0jR/nOswTZIoWQR32pJ7Oyh4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06FAD40E00B2;
	Wed, 14 Feb 2024 10:29:33 +0000 (UTC)
Date: Wed, 14 Feb 2024 11:29:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214102926.GCZcyWBuEBe7WRXWYO@fat_crate.local>
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
> +/* FRU Memory Poison Section, UEFI vX.Y sec N.X.Z */

Whack those:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 328e0a962c23..0246b13b5ba1 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -72,7 +72,7 @@
 /* FRU ID Types */
 #define FMP_ID_TYPE_X86_PPIN		0
 
-/* FRU Memory Poison Section, UEFI vX.Y sec N.X.Z */
+/* FRU Memory Poison Section */
 struct cper_sec_fru_mem_poison {
 	u32 checksum;
 	u64 validation_bits;
@@ -89,7 +89,7 @@ struct cper_sec_fru_mem_poison {
 /* FRU Descriptor Address Types */
 #define FPD_ADDR_TYPE_MCA_ADDR		0
 
-/* Memory Poison Descriptor, UEFI vX.Y sec N.X.Y */
+/* Memory Poison Descriptor */
 struct cper_fru_poison_desc {
 	u64 timestamp;
 	u32 hw_id_type;


> +/**
> + * DOC: fru_poison_entries (byte)
> + * Maximum number of descriptor entries possible for each FRU.
> + *
> + * Values between '1' and '255' are valid.
> + * No input or '0' will default to FMPM_DEFAULT_MAX_NR_ENTRIES.
> + */
> +static u8 max_nr_entries;
> +module_param(max_nr_entries, byte, 0644);
> +MODULE_PARM_DESC(max_nr_entries,
> +		 "Maximum number of memory poison descriptor entries per FRU");

Why is there a module parameter?

So that people can brick their BIOSes if it can't handle some size?

Can we read out the max size of the area destined for FRU records from
somewhere and go with it?

> +#define FMPM_DEFAULT_MAX_NR_ENTRIES	8
> +
> +/* Maximum number of FRUs in the system. */
> +static unsigned int max_nr_fru;
> +
> +/* Total length of record including headers and list of descriptor entries. */
> +static size_t max_rec_len;
> +
> +/*
> + * Protect the local cache and prevent concurrent writes to storage.

"local cache"?

> + * This is only needed after init once notifier block registration is done.
> + */
> +static DEFINE_MUTEX(fmpm_update_mutex);
> +
> +#define for_each_fru(i, rec) \
> +	for (i = 0; rec = fru_records[i], i < max_nr_fru; i++)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


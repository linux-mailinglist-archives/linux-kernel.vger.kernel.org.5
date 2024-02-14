Return-Path: <linux-kernel+bounces-65172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C58548DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19714B22453
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151E1B5AA;
	Wed, 14 Feb 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aV8A9rgs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B741AAD4;
	Wed, 14 Feb 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912156; cv=none; b=ACjf2JVNvXCPkltLPtLF2GwBIF7Re+3C0+4yO5RgXXspsH3/3uBkkYKkbKb4gr5NjYojcoY2Aa+oF+SLgY13cM6yMMGxsjrtMRpyTXp7WOAaII9oMRD8+DXzE/OPatyDHxa8Y2rQ2t3heBn36kZmxgL5juJ3a8/UFRchSJVH1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912156; c=relaxed/simple;
	bh=APOPmGD7lNpHDllOS/Zh0qFWPNhK3/xtyGrRG2j12EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnYQQMrXSc2fBnpYxh2pIzAPERj/VlN+g41KtjQMPfC3qI5YHCNTQcRqkx1ZmvWd3J1Fu2jS7wXufN3STkdBetkteBUx2p9dv6TvHEQvxZA4b87vkWGRQMyR2VigqfgDQZaVDuyLQTDdqeVnF2VDiQPSd8cPg0lCMIN3ARE+2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aV8A9rgs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A360140E0192;
	Wed, 14 Feb 2024 12:02:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u17yEAOyTX9e; Wed, 14 Feb 2024 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707912149; bh=SebeF/0Lv5fYivsUS+gRzBO8zjCsZxeIcdeQfWHgRDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aV8A9rgskMw7MGyjhwyqh2Ijgr0V/H7+j6Ixig0FxfcZol2RhiaG9b11kZHa3VBrr
	 B2JogLVHI+4c9tY0whiBrsnmv1vG2N8xvqgomV5MnAF1sxytrNqv6MmINAstXLwZI1
	 TAUNdiKpGea/KYnDw/Tw2ke/qsi+N5tt6uXusZ9fqW5wO+iL1r4JNxscoCE65tSfEf
	 tC7v6RN4vzVaZc0w/8kbXUt4l4BUuMlC78+0b5zh/SUHX50C72aXJIwo6Ina+/WB3Q
	 B2vEpzn+M+OFD0317NgQfk2s2w1S5Z1kgUOl+rBxOjH48gqpl+bovA+u5t6KGZ8h6Y
	 ASxtd2dZZ1zN5xRtRklFPt/HEelkZHlQQySmVz67ehbUSscKvynSUP9i9Zzlink2B5
	 T28WNG6G+0OpSwC64GMJ95GUhen4bQU4ICT6Q72AkE8OyaL9Js9NyKQe/dRLO4xVfs
	 3kPEsvrbJp37ZCdz3D9gveH58sxtfZCAAwx1M1o0rXWiSv37tZdHXDeSm/XKFVs0RS
	 hKywYrBJ+w/1tdRP9CBQ2Mkhm6SNOKI1SQWb0IdhWY+mqSmmUdSTHpCn2suixtteId
	 p4tFXfsXut3t+7j46v1/ry8M0VoP62rYhn1Izt6U/NSHpnPCu0dtW745ptg+AAvF7F
	 fO+6VyMobHFNOxrTcDIfIZtI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6877240E016C;
	Wed, 14 Feb 2024 12:02:20 +0000 (UTC)
Date: Wed, 14 Feb 2024 13:02:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214120214.GJZcyrxgyLLwQ8y19Z@fat_crate.local>
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
> +static unsigned int get_cpu_for_fru_num(unsigned int i)
> +{
> +	unsigned int cpu = 0;
> +
> +	/* Should there be more robust error handling if none found? */
> +	for_each_online_cpu(cpu) {

You need to block CPU hotplug operations before iterating over online
CPUs: cpus_read_lock/unlock.

> +		if (topology_physical_package_id(cpu) == i)
> +			return cpu;
> +	}
> +
> +	return cpu;
> +}

Fold this one into its single callsite.

> +
> +static void init_fmps(void)
> +{
> +	struct fru_rec *rec;
> +	unsigned int i, cpu;
> +
> +	for_each_fru(i, rec) {
> +		cpu = get_cpu_for_fru_num(i);
> +		set_fmp_fields(get_fmp(rec), cpu);
> +	}
> +}
> +
> +static int get_system_info(void)
> +{
> +	u8 model = boot_cpu_data.x86_model;

No need for that local var - just use boot_cpu_data.x86_model.

> +	/* Only load on MI300A systems for now. */
> +	if (!(model >= 0x90 && model <= 0x9f))
> +		return -ENODEV;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_AMD_PPIN)) {
> +		pr_debug("PPIN feature not available");
> +		return -ENODEV;
> +	}
> +
> +	/* Use CPU Package (Socket) as FRU for MI300 systems. */
> +	max_nr_fru = topology_max_packages();
> +	if (!max_nr_fru)
> +		return -ENODEV;
> +
> +	if (!max_nr_entries)
> +		max_nr_entries = FMPM_DEFAULT_MAX_NR_ENTRIES;
> +
> +	max_rec_len  = sizeof(struct fru_rec);
> +	max_rec_len += sizeof(struct cper_fru_poison_desc) * max_nr_entries;
> +
> +	pr_debug("max_nr_fru=%u max_nr_entries=%u, max_rec_len=%lu",
> +		 max_nr_fru, max_nr_entries, max_rec_len);
> +	return 0;
> +}
> +
> +static void deallocate_records(void)

free_records

> +{
> +	struct fru_rec *rec;
> +	int i;
> +
> +	for_each_fru(i, rec)
> +		kfree(rec);
> +
> +	kfree(fru_records);
> +}
> +
> +static int allocate_records(void)
> +{
> +	int i, ret = 0;
> +
> +	fru_records = kcalloc(max_nr_fru, sizeof(struct fru_rec *), GFP_KERNEL);
> +	if (!fru_records) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < max_nr_fru; i++) {
> +		fru_records[i] = kzalloc(max_rec_len, GFP_KERNEL);
> +		if (!fru_records[i]) {
> +			ret = -ENOMEM;
> +			goto out_free;
> +		}
> +	}
> +
> +	return ret;
> +
> +out_free:
> +	for (; i >= 0; i--)
> +		kfree(fru_records[i]);
> +
> +	kfree(fru_records);
> +out:
> +	return ret;
> +}
> +
> +static const struct x86_cpu_id fmpm_cpuids[] = {
> +	X86_MATCH_VENDOR_FAM(AMD, 0x19, NULL),

This is why this should depend on AMD in Kconfig.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


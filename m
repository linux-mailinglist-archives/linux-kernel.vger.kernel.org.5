Return-Path: <linux-kernel+bounces-81903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C54867BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50CE1F27B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650DF12CDBF;
	Mon, 26 Feb 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dEYla/AI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F512CD97;
	Mon, 26 Feb 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964749; cv=none; b=GCWIEREILh0X46QI7oRmuQ5dmM52C3nm+sEchRAk3kvZqv2ZL/OfOnx87yEBJ9sOaxPZXT2WDg9k8JvjTsvTJxD8+DBVx0q4PZRwjvkbokzUH5nQudFbiwU23rE5hadGnjW6Yz+z9XAkLu1wE0Z9X2FTmlDcPH7Cv/OZRjf7p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964749; c=relaxed/simple;
	bh=M644AwlcdbJIK6jKjqVty6atIp/A2bidPGf41KXqsw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU1l7i3Zrv5G63UK2+DIfthkBzwR2k4kZ0BRb4V7v846jRKpiOnKkJp2VFTDzCglkrFwZ4AuPlI2FSF1EVjQsQFjdoHsTT7EY2+DAk3w8OkyOybpmZgASvtrr7r+uO6XVW/qOk+IlemI2rksf3Q17CooNyTLg+WCK1Qn3HaueKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dEYla/AI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D26DF40E0192;
	Mon, 26 Feb 2024 16:16:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0nrPwegJ6bWT; Mon, 26 Feb 2024 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708964188; bh=mHQ8bfE6f3nYOsHMRhfypl1NqckUD1JD2a1p01ILVIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEYla/AIA+H46pXvNQR0AR8cr1Tl7325Z2IDiLDcmJVkTCq8kZINw4Rb+eoYEVaWC
	 dQ4/cg/yx/7VpqwUCD8OmPI/BMopgFeds9z7WcsNzkPrSUy8+yoxcn4i03C/Vi2aRU
	 KlIZAuEyG6MkxfHLsEM8CkENvHsNo9r0B+P5QpFMFHtsvv08EYnouhuhe3AmjKUjKy
	 NrVxhocJ7RN0d5dL4qYYog2erYyqAHdfW/zSLhx4VQmdJD520B5EMOP7ucupty5wLn
	 qb35KkQGUtWLcfdwg34JvYY5XkgkEFT4cd6a6++B0R4V44mYk0BjL+laUmiR0XrjRW
	 Am69hO+/oRUnAbXH2DKwmmkON4Zn94gUZuBx7hw6Wj4Gly3feGy1X9mQaQpfv7drV3
	 j3CcOTKRcQ+cs/BOSvOC3+pOStOOI2oRgdvesOsTELxCCiw9yLMksh2vFnVZY7H+5C
	 7nyaNPoVR+/RkOQ74UILw7nN5bAcNDbEplaXPXlAE+ulMUiDDqYJ1j9RmUblzqquOV
	 2xQWrenTnHMwJ6pj6+VwMxoFciTRUWb9MajB/OPGPMnOxI1nDK6g4hWeO6SViRAOWf
	 FFu0/bjew0h1PGEnNoe8Xv/R39OEbuVdglaj6gYlckGvEbc6TeeVDBp/VvJ6cRSZ3w
	 6MLzF7UpuriAiTBOkNUUjvXc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0B9C40E0196;
	Mon, 26 Feb 2024 16:16:19 +0000 (UTC)
Date: Mon, 26 Feb 2024 17:16:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com, sathyapriya.k@amd.com,
	naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 2/3] RAS/AMD/FMPM: Save SPA values
Message-ID: <20240226161612.GDZdy5TH6H5VWRGWOK@fat_crate.local>
References: <20240226152941.2615007-1-yazen.ghannam@amd.com>
 <20240226152941.2615007-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226152941.2615007-3-yazen.ghannam@amd.com>

On Mon, Feb 26, 2024 at 09:29:40AM -0600, Yazen Ghannam wrote:
> @@ -111,6 +111,9 @@ struct fru_rec {
>   */
>  static struct fru_rec **fru_records;
>  
> +#define INVALID_SPA	~0ULL
> +static u64 *sys_addrs;

Let's do:

/* system physical addresses array */
static u64 *spa_addrs;

so that it is self-documenting.

> +
>  #define CPER_CREATOR_FMP						\
>  	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
>  		  0xa0, 0x33, 0x08, 0x75)
> @@ -140,6 +143,9 @@ static unsigned int max_nr_fru;
>  /* Total length of record including headers and list of descriptor entries. */
>  static size_t max_rec_len;
>  
> +/* Total number of entries for the entire system. */
> +static unsigned int sys_nr_entries;

sys_ things are always related to syscalls etc. Since it is a static
var, just call it:

	/* Number of SPA entries */
	nr_entries

or so.

I was gonna say "nr_err_records" but we're calling them entries so...

>  /*
>   * Protect the local records cache in fru_records and prevent concurrent
>   * writes to storage. This is only needed after init once notifier block
> @@ -269,6 +275,40 @@ static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
>  	return false;
>  }
>  
> +static void save_spa(struct fru_rec *rec, unsigned int entry,
> +		     u64 addr, u64 id, unsigned int cpu)
> +{
> +	unsigned int i, fru_idx, sys_entry;
> +	unsigned long sys_addr;
> +	struct atl_err a_err;
> +
> +	memset(&a_err, 0, sizeof(struct atl_err));
> +
> +	a_err.addr = addr;
> +	a_err.ipid = id;
> +	a_err.cpu  = cpu;
> +
> +	sys_addr = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
> +	if (IS_ERR_VALUE(sys_addr)) {
> +		pr_debug("Failed to get system address\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < sys_nr_entries; i += max_nr_entries) {
> +		fru_idx = i / max_nr_entries;
> +		if (fru_records[fru_idx] != rec)
> +			continue;
> +
> +		sys_entry = i + entry;
> +		if (sys_entry < sys_nr_entries) {
> +			sys_addrs[sys_entry] = sys_addr;
> +			pr_debug("fru_idx: %u, entry: %u, sys_entry: %u, sys_addr: 0x%016llx\n",
> +				 fru_idx, entry, sys_entry, sys_addrs[sys_entry]);
> +			break;
> +		}

	else {
		WARN_ON_ONCE("... indexing wrong bla... ");
	}

to catch crap.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


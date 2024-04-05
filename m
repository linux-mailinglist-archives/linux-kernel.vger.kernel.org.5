Return-Path: <linux-kernel+bounces-133154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C384899FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C846A1C22978
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515216EC0A;
	Fri,  5 Apr 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsPznzZH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1516D309;
	Fri,  5 Apr 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327355; cv=none; b=r/+kSHB0SyqgNniWu+ZPSM6VOsvvX921rYPWADlrrx0teujoI6ppmkXPwPA0ry0CTEz02NGs4RJ2K6UcTo1+SuZS3g/f22Obtjpa5ukfnnOiUEUamopBesnBkmGrCq72VkaRblG15m4xwBo1Pefx1HPjX04vir1nIU2Iovg7MEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327355; c=relaxed/simple;
	bh=5y0BhnvtJ68Brn9AI/nFEJjAzF7LQ+w7jtYuu9lht8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PY2j/frT4wA6/9di8eeN45g8yfoDPf0/OJ5JcRCd5/u30X7YnDELWYdLt+FgtXIZzlk30iOYExcSVNj03kheX2MbuqjkOWUoMWQ2gSzoNVyDXmLe/b24xH2HRh5OZF6misNLppP6PmhVVigpPbiNxsh/jM+BqBlLI9iyD1uBx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsPznzZH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712327353; x=1743863353;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5y0BhnvtJ68Brn9AI/nFEJjAzF7LQ+w7jtYuu9lht8E=;
  b=lsPznzZHd9ANQ1MNrW1LTxhM9QxkzCD8RGYaCX/1L3qg5vfB3rxtlQFy
   In8sCjAcE1cd0utwep+o6PdEaBkVlN9A0Jqc+OrRDwwPVSkTCwuiNML+e
   Wcqff3VssaY2FUm8NgPl+SWEj16XCgj/tzsCluu0y0Xl/lCAi03Xnf3YW
   MDcTqWur7q/093ftICTt5akIsQPgaRiNMZzr96VCORwE1m9bJs8d+Ny13
   FVPhoYt99swObIa4mJRv6g4jQkW/zPdXwYAMSWIBgzqRQ3y1GAjNV6Smr
   YWE5OzBLtpJy7ZL9suic/xdbmLhIX6K+2S8rdewEjnGMaiHXmVnSsgvwA
   Q==;
X-CSE-ConnectionGUID: 15Fb+ImQQTmVL83gElouOA==
X-CSE-MsgGUID: w3rJXrbFS0CmP8sI4XL2DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11476024"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11476024"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:29:13 -0700
X-CSE-ConnectionGUID: SVVwHyI9TYuTR7A/KyOZDQ==
X-CSE-MsgGUID: XDCIw93sS2qPAwvDbBOlZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19248766"
Received: from mdawoo-mobl.amr.corp.intel.com (HELO [10.212.152.63]) ([10.212.152.63])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:29:12 -0700
Message-ID: <f2eb6f38-2244-46ed-ad39-be1c41c49c23@linux.intel.com>
Date: Fri, 5 Apr 2024 07:29:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 6/9] tools/arch/x86/intel_sdsi: Fix meter_show display
To: "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
 <20240405032507.2637311-7-david.e.box@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240405032507.2637311-7-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/4/24 8:25 PM, David E. Box wrote:
> Fixes sdsi_meter_cert_show() to correctly decode and display the meter
> certificate output. Adds and displays a missing version field, displays the
> ASCII name of the signature, and fixes the print alignment.
>
> Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading meter certificates")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> V3 - Change patch subject and changelog to clarify changes.
>    - Use new BUNDLE_COUNT #def
>
> V2 - Split of V1 patch 7
>
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 29 +++++++++++++++++---------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 7eaffcbff788..a0711177e1bb 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -153,11 +153,12 @@ struct bundle_encoding {
>  };
>  
>  struct meter_certificate {
> -	uint32_t block_signature;
> +	uint32_t signature;
> +	uint32_t version;
> +	uint64_t ppin;
>  	uint32_t counter_unit;
> -	uint64_t ppin;
>  	uint32_t bundle_length;
> -	uint32_t reserved;
> +	uint64_t reserved;
>  	uint32_t mmrc_encoding;
>  	uint32_t mmrc_counter;
>  };
> @@ -338,6 +339,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  	uint32_t count = 0;
>  	FILE *cert_ptr;
>  	int ret, size;
> +	char name[4];
>  
>  	ret = sdsi_update_registers(s);
>  	if (ret)
> @@ -379,12 +381,19 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  	printf("\n");
>  	printf("Meter certificate for device %s\n", s->dev_name);
>  	printf("\n");
> -	printf("Block Signature:       0x%x\n", mc->block_signature);
> -	printf("Count Unit:            %dms\n", mc->counter_unit);
> -	printf("PPIN:                  0x%lx\n", mc->ppin);
> -	printf("Feature Bundle Length: %d\n", mc->bundle_length);
> -	printf("MMRC encoding:         %d\n", mc->mmrc_encoding);
> -	printf("MMRC counter:          %d\n", mc->mmrc_counter);
> +
> +	get_feature(mc->signature, name);
> +	printf("Signature:                    %.4s\n", name);
> +
> +	printf("Version:                      %d\n", mc->version);
> +	printf("Count Unit:                   %dms\n", mc->counter_unit);
> +	printf("PPIN:                         0x%lx\n", mc->ppin);
> +	printf("Feature Bundle Length:        %d\n", mc->bundle_length);
> +
> +	get_feature(mc->mmrc_encoding, name);
> +	printf("MMRC encoding:                %.4s\n", name);
> +
> +	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
>  	if (mc->bundle_length % 8) {
>  		fprintf(stderr, "Invalid bundle length\n");
>  		return -1;
> @@ -398,7 +407,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  
>  	bec = (void *)(mc) + sizeof(mc);
>  
> -	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
> +	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
>  	while (count++ < mc->bundle_length / 8) {
>  		char feature[5];
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



Return-Path: <linux-kernel+bounces-5003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63681851F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32843285B31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431FD14A84;
	Tue, 19 Dec 2023 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eVXOT55Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2F14275
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702980749; x=1734516749;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=iViKSTdI+ErtrWsDZMtiphCdw44JA/4rWoiQlO3XCQI=;
  b=eVXOT55QPsWRZqMBpS0jVjOnSqGUKMtDTpFcqZN3rOF+EjhqbMn0E6K+
   YwUN+CHBgYyulhEVA+r7NtCmbVNz3KnRoXz0UuenMbA/VUpI6mZVjS1jv
   OHjskCmTxYhP+RvyGxaxniM9DQiW2IqokjutaimjRc3LJEK/KNeLRUhax
   hlNqUNsO3lwWoPlm8ueA7qPhQcyb74JpaQAwvmibiMVrDTn3m9X7b6HJz
   jrXA5wwog4vDjkIxBfyoMpRQz0/RiupIh86N/sVLXMC3FN7qoDRiSb0eJ
   CVNegG0q14DufOb0hQdMsodv79ksetaph7ih6ezGsvlYKv6kd1OI4N0cb
   A==;
X-CSE-ConnectionGUID: vgLW8J4XSHmZoGcu39fnJw==
X-CSE-MsgGUID: gHSyTML2RBeEe3T0U2yfGQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="14516133"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2023 03:12:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 03:12:06 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 19 Dec 2023 03:12:05 -0700
Message-ID: <e4481634-d0b4-427d-a9a2-f3fe5643f2e6@microchip.com>
Date: Tue, 19 Dec 2023 11:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/50] ARM: at91: add support in SoC driver for new
 sam9x7
Content-Language: en-US, fr-FR
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
	<mihai.sain@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20230728102905.267131-1-varshini.rajendran@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230728102905.267131-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2023 at 12:29, Varshini Rajendran wrote:
> Add support for SAM9X7 SoC in the SoC driver.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   drivers/soc/atmel/soc.c | 23 +++++++++++++++++++++++
>   drivers/soc/atmel/soc.h |  9 +++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> index cc9a3e107479..cae3452cbc60 100644
> --- a/drivers/soc/atmel/soc.c
> +++ b/drivers/soc/atmel/soc.c
> @@ -101,6 +101,29 @@ static const struct at91_soc socs[] __initconst = {
>   		 AT91_CIDR_VERSION_MASK, SAM9X60_D6K_EXID_MATCH,
>   		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
>   #endif
> +#ifdef CONFIG_SOC_SAM9X7
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
> +		 "sam9x72", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> +		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
> +		 "sam9x70", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 1Gb DDR3L SiP ", "sam9x7"),

I don't want that we introduce more sizes in "bits" instead of "bytes" 
in this file.
I know it's what is advertised in datasheets, but we're software people 
who count these sizes in bytes, so let's do the conversion for the users.

BTW: this file will need to be updated with this statement in mind.

Best regards,
   Nicolas

> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 512Mb DDR2 SiP", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 128Mb DDR2 SiP", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 2Gb DDR3L SiP", "sam9x7"),
> +#endif
>   #ifdef CONFIG_SOC_SAMA5
>   	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>   		 AT91_CIDR_VERSION_MASK, SAMA5D21CU_EXID_MATCH,
> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
> index 7a9f47ce85fb..26dd26b4f179 100644
> --- a/drivers/soc/atmel/soc.h
> +++ b/drivers/soc/atmel/soc.h
> @@ -45,6 +45,7 @@ at91_soc_init(const struct at91_soc *socs);
>   #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
>   #define SAM9X60_CIDR_MATCH		0x019b35a0
>   #define SAMA7G5_CIDR_MATCH		0x00162100
> +#define SAM9X7_CIDR_MATCH		0x09750020

Apha-numerial order please.

>   
>   #define AT91SAM9M11_EXID_MATCH		0x00000001
>   #define AT91SAM9M10_EXID_MATCH		0x00000002
> @@ -74,6 +75,14 @@ at91_soc_init(const struct at91_soc *socs);
>   #define SAMA7G54_D2G_EXID_MATCH		0x00000020
>   #define SAMA7G54_D4G_EXID_MATCH		0x00000028
>   
> +#define SAM9X75_EXID_MATCH		0x00000000
> +#define SAM9X72_EXID_MATCH		0x00000004
> +#define SAM9X70_EXID_MATCH		0x00000005
> +#define SAM9X75_D1G_EXID_MATCH		0x00000001
> +#define SAM9X75_D5M_EXID_MATCH		0x00000002
> +#define SAM9X75_D1M_EXID_MATCH		0x00000003
> +#define SAM9X75_D2G_EXID_MATCH		0x00000006
> +

Ditto

>   #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
>   #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
>   #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0



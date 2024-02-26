Return-Path: <linux-kernel+bounces-82014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E811A867DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745FC1F24887
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA412DDA8;
	Mon, 26 Feb 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zozBNRb9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77112BE9F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966967; cv=none; b=X7nwc6YuNVt1+KPAYHmV4X2nWyJ82ScWcDaB0mRU8ozsLZHsBtJjLlnKyTLzsJ/Po2I/6kSa89Tedf3gs/rUNsHKBrUUvuzjaDxYgpnWgAKLTX6ZkGaUJAffByniIasVY22Vo9cATRnjZHgZki02leTcvByKhWwFbJ2vyqcwl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966967; c=relaxed/simple;
	bh=PtOqPsnVzJ1VY1JY7qLS12ZY7lQ1eJRkNRobbhPJDEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sCQWFstQGJrjm7dmNNFAMdXX/+GHh+sBkgq4kqdC/a8seYk9vwAonduIh9K87UtBRGDe31yZLgi+jB1tlhHay+NglIR2ifs7aWHNBWsXjwUoayv3KsCdL7Z/FgQiIQy5HxnoqTTHB9r5oTysQsgtKY8kOXAhVzbokMvadga1X40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zozBNRb9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708966966; x=1740502966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PtOqPsnVzJ1VY1JY7qLS12ZY7lQ1eJRkNRobbhPJDEY=;
  b=zozBNRb96n6uzb0FXmkpuhZEWVkbMJF25xgtFcf8fGc6B5gPR7fHUOkw
   G+NQzPYP8eTzV0h11xfSPVocjc5RW22S+DjTs0mjuiMCRXN8BvZffmoPJ
   qRCf3NkcICcGxa2VBChQXUPoJnTSr+wo7yCwKfZOgHyB5y9slhcoKRxtO
   eaYCWfutfS8JHhxaUavru9S3b9plplyuegQUwRw1GRHWsZLVVGOcbxuty
   nYBBQ2N4vCxCE91kI1mV4hWKldghhb1QxcVSIe0AmqZeAu6Yf5k7KM6Wg
   qEAnDHP5peMP/jU6bxeorsjnvv/iuzRP2/aErOsB2mn93bMxAiECDc9MW
   Q==;
X-CSE-ConnectionGUID: +usMHQQ3RByG3mwbmXRohw==
X-CSE-MsgGUID: Coq3DASSR1qrFD28x3eO4g==
X-IronPort-AV: E=Sophos;i="6.06,186,1705388400"; 
   d="scan'208";a="16839304"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 10:02:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 10:02:37 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 10:02:36 -0700
Message-ID: <798ca59b-5d91-41b4-a49f-1f11af14e7ee@microchip.com>
Date: Mon, 26 Feb 2024 18:01:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/39] ARM: at91: add support in SoC driver for new
 sam9x7
Content-Language: en-US, fr-FR
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172722.672592-1-varshini.rajendran@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240223172722.672592-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2024 at 18:27, Varshini Rajendran - I67070 wrote:
> Add support for SAM9X7 SoC in the SoC driver.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> Changes in v4:
> - Sorted the entries alphabetically as per comment from Claudiu
> - Updated EXID
> Note: Did not remove the Reviewed-by tag since the changes were only
> cosmetic and did not affect functionality
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
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 512Mb DDR2 SiP", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 128Mb DDR2 SiP", "sam9x7"),
> +	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
> +		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +		 "sam9x75 2Gb DDR3L SiP", "sam9x7"),

(as highlighted in previous review of this patch):
https://lore.kernel.org/linux-arm-kernel/20230728102905.267131-1-varshini.rajendran@microchip.com/T/#m2dac0ce9e1991c3d714785062a76ccdce11a02a6

I want RAM size in Bytes.

Sorry but NACK.

Best regards,
   Nicolas

> +#endif
>   #ifdef CONFIG_SOC_SAMA5
>   	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>   		 AT91_CIDR_VERSION_MASK, SAMA5D21CU_EXID_MATCH,
> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
> index 7a9f47ce85fb..fc4157c5f6e3 100644
> --- a/drivers/soc/atmel/soc.h
> +++ b/drivers/soc/atmel/soc.h
> @@ -44,6 +44,7 @@ at91_soc_init(const struct at91_soc *socs);
>   #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
>   #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
>   #define SAM9X60_CIDR_MATCH		0x019b35a0
> +#define SAM9X7_CIDR_MATCH		0x09750020
>   #define SAMA7G5_CIDR_MATCH		0x00162100
>   
>   #define AT91SAM9M11_EXID_MATCH		0x00000001
> @@ -74,6 +75,14 @@ at91_soc_init(const struct at91_soc *socs);
>   #define SAMA7G54_D2G_EXID_MATCH		0x00000020
>   #define SAMA7G54_D4G_EXID_MATCH		0x00000028
>   
> +#define SAM9X70_EXID_MATCH		0x00000005
> +#define SAM9X72_EXID_MATCH		0x00000004
> +#define SAM9X75_D1G_EXID_MATCH		0x00000018
> +#define SAM9X75_D2G_EXID_MATCH		0x00000020
> +#define SAM9X75_D1M_EXID_MATCH		0x00000003
> +#define SAM9X75_D5M_EXID_MATCH		0x00000010
> +#define SAM9X75_EXID_MATCH		0x00000000
> +
>   #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
>   #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
>   #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0



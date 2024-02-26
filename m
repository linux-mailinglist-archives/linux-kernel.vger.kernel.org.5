Return-Path: <linux-kernel+bounces-81421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A282F8675C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2B1F252FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E180C05;
	Mon, 26 Feb 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WcPKrZPJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE08005E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952202; cv=none; b=c3718WmK1FXd4FFBeKVQ4l81M3UBuPxTKotw4HDGOKZGwp4FhZ3JpznacX7KMwFd76+zp/6T94bfw4TYE2Qn5vEniaG7JTqjK+9GCAiv96JmyYr21XIAo9j4HOb55wA21ZQVqEuxObWYGaNyW+VTate7AK1U+40T0CCPc2Nu8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952202; c=relaxed/simple;
	bh=ZWGyD5hzgW44HzlR18tI17IUrY8Vy5u5/537CqTcSss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NjoQ5cXgBw8H1REkpdO/eFfarcrSKCYhZBw2DM3ncL/Hg+P+A0zGBQBMgG3dPwCH1ZFZYmzkVj0YFZ3UJm/8ekO6VRmvKCW3RXIrfIA0yTE8huv/tlSmwATKLTiOnhoLc3bdD8n7iX85+CeOpaiGw2c1fCh28ItkdCgXutOEkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WcPKrZPJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708952200; x=1740488200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZWGyD5hzgW44HzlR18tI17IUrY8Vy5u5/537CqTcSss=;
  b=WcPKrZPJWZxeLbkklxZwlt5S4hhddqHn2hVsrFkGFcIWIFp38jX9uEJc
   KbzwWGCcIPUHm/m5ZOrC22aI20x3ddJHs5K+fF+bGObgxS5Se35wNdLhi
   9YHv1bUfBL6ZekU3GtvV9AZImsdwZ2X81RcxSokXdXxjkUgsO1ZPJJJmx
   wMWSJrACTLgyuCpMGKhne7ilOSasJKG8NNMBysgMkKHBKlwaMNN0/zoGU
   cB3iwCsbrqZXAxawjp898PwdUZKrLfVQfv9f/bbQ4shXOJ7nZpfp29WkU
   +Cw4FvwMKSyWBPZJGTMMjc/7oOuqWfyj9JWMtadEDerFBIk6S1AtCxvWX
   Q==;
X-CSE-ConnectionGUID: kHv4xSMiQjOsauQ9YHuS0g==
X-CSE-MsgGUID: Lh8qfODeRFOytOATbH+2rg==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="scan'208";a="184095717"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 05:56:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 05:55:58 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 05:55:57 -0700
Message-ID: <b4fadbb7-5263-4271-9728-b25cc78ebad0@microchip.com>
Date: Mon, 26 Feb 2024 13:54:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: raw: atmel: Fix comment in timings preparation
Content-Language: en-US, fr-FR
To: Alexander Dahl <ada@thorsis.com>, <linux-kernel@vger.kernel.org>
CC: Boris Brezillon <bbrezillon@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240226122537.75097-1-ada@thorsis.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240226122537.75097-1-ada@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 at 13:25, Alexander Dahl wrote:
> Looks like a copy'n'paste mistake introduced when initially adding the
> dynamic timings feature with commit f9ce2eddf176 ("mtd: nand: atmel: Add
> ->setup_data_interface() hooks").  The context around this and
> especially the code itself suggests 'read' is meant instead of write.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Looks indeed valid:
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Alexander. Best regards,
   Nicolas

> ---
>   drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index 4cb478bbee4a..dc75d50d52e8 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1370,23 +1370,23 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>           *
>           * NRD_PULSE = tRP
>           */
>          ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
>          totalcycles += ncycles;
>          ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
>                                            ncycles);
>          if (ret)
>                  return ret;
> 
>          /*
> -        * The write cycle timing is directly matching tWC, but is also
> +        * The read cycle timing is directly matching tRC, but is also
>           * dependent on the setup and hold timings we calculated earlier,
>           * which gives:
>           *
>           * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
>           *
>           * NRD_SETUP is always 0.
>           */
>          ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
>          ncycles = max(totalcycles, ncycles);
>          ret = atmel_smc_cs_conf_set_cycle(smcconf, ATMEL_SMC_NRD_SHIFT,
>                                            ncycles);
> 
> base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
> --
> 2.39.2
> 



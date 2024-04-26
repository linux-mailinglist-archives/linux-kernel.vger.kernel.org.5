Return-Path: <linux-kernel+bounces-159840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1368B3505
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C091C217C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAFE142E68;
	Fri, 26 Apr 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXAfo2nC"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876014264F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126254; cv=none; b=nP++wbdXeUwya9BZbk5xF7SSYZ0JNZeR5p0SFv/jmc4tpSp2teVVLExAJVh/IPvRSXKnZ9nq9jPoJWe+GCQY2ENY+hRbiKUkXVnLcuy50nUmHZl+HsFIGjtIMjwm9UF4D8bVHmO53LcG1Izs7cVyLlu7NhHOi9OdC1ARorc04xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126254; c=relaxed/simple;
	bh=nuH6tTyBoh/6h3XiGSswwpmypfMdz/CImISnCvU2VFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1vPAyb+zGeI5cW3GXXB9sOqPqk0UjoQScOTipsZDc6E0jVS1+yn77UCXZXhbfpk3WfwhWB8wB2G0yMgoPonnjPcQ/i2dv5FVKS4Afk6mtvMSYRkmGBZkIiWbfmNNV6lOPbJwZaQSYPPHgSQlFEAP5wEGGJmuwoVRMSn41UyWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WXAfo2nC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd64d6fe94so21214121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714126251; x=1714731051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTzf8B5xaF9nwt/4/HviUjeHQGltnTZQ9twI2ClHj4c=;
        b=WXAfo2nCi1CPthJrPTMkW9gpdqiLp5QslX6IQMV0jHSUXhOJ0vaQ6Rzic73Zol2OPb
         +KhGAl3zQD/0mSkH08ukaauuwdfRnxgGcgYYYtSo2mzRnOEMK5LGK4PZ2+PLw5KVyQ09
         YRSNhL6r9qhTYIdfT0Uu9Dhlcv9+c40QtRmUG2cVyP8zUlDTssMv7O0KLWVw/BGT73i9
         YOwsU8pTKW8CGDCyvs8tBl920XBnnaN0mbW7Q3jXYhhDMThTzLd2p9d4XuM0gHT5puTt
         oJ5hP2LJ9ne4eSAU9B+ufM2KIVoEhvlMBDpuFAaoCv7ve3uWaFUyQPJX61TK+2+P2/Ze
         vpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714126251; x=1714731051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTzf8B5xaF9nwt/4/HviUjeHQGltnTZQ9twI2ClHj4c=;
        b=MPLC40PaW+KnttBSqOmXRjsNRutADqWOniW7zbjwEdkDWED2oSbdxCk2DiDeFMOz/s
         D+m1+yLyDJOUGxzeqPNqvPkXAFbr/+F2ZWRmgUrEu3aDooAxUn5+BX2MvxsWM8RE5EH9
         SuLCZ0LnPMmhBBmMwak3tSsnLsO6Web0wRX/jHEIESMW3qww3x+bS5hSP4PSv1Z5gbgT
         6k68/CGeIvjsvARKJja7EmPWPxEQvV95H33EQmUw6iESbqoT1L0yT7qLEUDXpodKeA+V
         kFMwL/jej9e99ATNxX+YKcNsiF+q/DQUstM3VkHqH7toLmF0KOHKUM8AcyHgZXqUQsUs
         OUHA==
X-Forwarded-Encrypted: i=1; AJvYcCVFAG9N3Tqe99iKlsPc9tqsziJ7XSSOEy0zLMuJKJBYNrhDfKe+TGz2WKifA9jd2qw6BDmiFJLNQX8DimBPBBqte1Z3gtHGPYCXAqWz
X-Gm-Message-State: AOJu0YxgJ4PIMSh31/I1HgliCTYl4NXuW1BTwn7TH1uGyyWuwNHUujxE
	LJCV7qrGaZGZ3itIf/osgWQh3MK1q5GSO39AvMaah3F2XN5Coqhy4AS9BrPDtcQ=
X-Google-Smtp-Source: AGHT+IETNBTvduNcSZvQ1UED1Wabzp3E86pe63uLXem5m50jD/68R72SdO0dpZh999FcTtsL3zEqXg==
X-Received: by 2002:a05:651c:10d4:b0:2dd:987f:f9d7 with SMTP id l20-20020a05651c10d400b002dd987ff9d7mr1239494ljn.25.1714126250958;
        Fri, 26 Apr 2024 03:10:50 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0041a963bf2cdsm14302754wmo.36.2024.04.26.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 03:10:50 -0700 (PDT)
Message-ID: <4b6e1399-7b1d-4506-9943-32e76aff22f4@linaro.org>
Date: Fri, 26 Apr 2024 11:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SPI Nand patch code of SkyHigh Memory
To: KR Kim <kr.kim@skyhighmemory.com>, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: mika.westerberg@linux.intel.com, michael@walle.cc,
 acelan.kao@canonical.com, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, moh.sardi@skyhighmemory.com,
 zhi.feng@skyhighmemory.com, changsub.shim@skyhighmemory.com
References: <20240426072033.331212-1-kr.kim@skyhighmemory.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240426072033.331212-1-kr.kim@skyhighmemory.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Takahiro, I saw he was quoted as author

Hi, KR,

Thank you for the patch.

Plese run "./scripts/checkpatch.pl --strict" on your patch and fix the
errors and warning that are shown.

Subject is wrong, it should follow how other drivers were introduced.
You may use the following in the next version:
"mtd: spinand: add support for SkyHigh S35ML flashes"

Other comments below.

On 4/26/24 08:20, KR Kim wrote:
> The following list shows the additional features that are required to support Skyhighmemory S35ML0xG3 SPI Nand:
> 
>     [Always ECC On]
>        Always keep the ECC On during Bad Block Marking and Bad Block Checking
>        1. The on-die ECC feature is totally transparent to the host. The ECC parity bits used for this feature do not occupy the NAND spare areas.
>        2. The host is free to have its own ECC engine by using the spare areas that have standard size. 
>        3. We provide this patch to enable users who have limited ECC capabilities on the host side to use the NAND flash. This patch has been tested thoroughly on Linux. 
> 
>     [Change ECC Status information]
>        This patch changes the ECC status information as follows to maintain compatibility.
> 	00 (normal)                               
> 	01(1-2 errors corrected)          
> 	10(3-6 errors corrected)          
> 	11(uncorrectable)

Please read the guide on submitting patches before sending v2:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

It describes how one shall describe the changes. You missed to add your
Signed-of-by tag.

> ---
>  drivers/mtd/nand/spi/Makefile  |   2 +-
>  drivers/mtd/nand/spi/core.c    |  14 +++-
>  drivers/mtd/nand/spi/skyhigh.c | 145 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |   3 +
>  4 files changed, 162 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/mtd/nand/spi/Makefile
>  mode change 100644 => 100755 drivers/mtd/nand/spi/core.c
>  create mode 100644 drivers/mtd/nand/spi/skyhigh.c
>  mode change 100644 => 100755 include/linux/mtd/spinand.h

all these file mode changes are wrong, keep the files as they were.

> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> old mode 100644
> new mode 100755
> index 19cc77288ebb..1e61ab21893a
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
> -spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
> +spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> old mode 100644
> new mode 100755
> index e0b6715e5dfe..d09b2bd05284
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -196,6 +196,17 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
>  static int spinand_ecc_enable(struct spinand_device *spinand,
>  			      bool enable)
>  {
> +	/* 
> +	 * SkyHigh Memory : always ECC on 

how does the configuration register look like, would you please tell us
its fields?

> +	 * The on-die ECC feature is totally transparent to the host. 

this line brings no benefit, remove it

> +	 * The ECC parity bits used for this feature do not occupy the NAND spare areas.

its already implied, remove the line

> +	 * The host is free to have its own ECC engine by using the spare areas that have standard size. 

Why would one want to have both the on-die and on-host ecc engine work
in parallel?

> +	 * We provide this patch to enable users who have limited ECC capabilities on the host side to use the NAND flash. 

remove this line, it brings no value

> +	 * This patch has been tested thoroughly on Linux. 

all code is considered tested, remove this line
> +	 */
> +	if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY)
> +		return 0;

the always on on-die ecc shall be discussed in a dedicated patch, as it
touches the core.
> +
>  	return spinand_upd_cfg(spinand, CFG_ECC_ENABLE,
>  			       enable ? CFG_ECC_ENABLE : 0);
>  }
> @@ -561,7 +572,7 @@ static int spinand_reset_op(struct spinand_device *spinand)
>  			    NULL);
>  }
>  
> -static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
> +int spinand_lock_block(struct spinand_device *spinand, u8 lock)
>  {
>  	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
>  }
> @@ -945,6 +956,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> +	&skyhigh_spinand_manufacturer,
>  	&toshiba_spinand_manufacturer,
>  	&winbond_spinand_manufacturer,
>  	&xtx_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
> new file mode 100644
> index 000000000000..f001357b4d85
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/skyhigh.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 SkyHigh Memory Limited

Copyright followed by (c) is redundant. Update years.
> + *
> + * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>

You shall consider adding Takahiro as author, or co-author, or at least
specify that the patch is derived from Takahiro's work.
> + */
> +

cut

> +static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int section,
> +					 struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	/* SkyHigh's ecc parity is stored in the internal hidden area */
> +	region->length = 0;

what happens when length is zero?

> +	region->offset = mtd->oobsize;
> +
> +	return 0;
> +}

cut

> +};
> +
> +static int skyhigh_spinand_init(struct spinand_device *spinand)
> +{
> +	return spinand_lock_block(spinand, SKYHIGH_CONFIG_PROTECT_EN);

I see the core unlocks all blocks. Thus I assume you can as well remove
the init method altogether, it brings no functional change.

Cheers,
ta


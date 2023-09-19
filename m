Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75367A68A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjISQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:12:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5548A1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:12:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so4117133a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695139945; x=1695744745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2W38CXjFimuUk344mBPsm35p6+nVhboQggc89jf+vgg=;
        b=RAK+r8JWTe83C5wsBU+3QSY5imqVzVJ4zBpf7bJ3vfri9FIhg890v6OdnrBzNemttT
         XkCVa+gEqlUUOQKut3FqBL5N1o6XvFsubQIXgJqEf4wXn87R2g6D1JOQmMZqvhWL9/FF
         RYOWb1qxa+FXO89T1AZO0rgHVRMv1/zoWYwgMHtRDTad+vxvD7fBxCR0Uutb7tUjIukm
         uw4p/F3/ityA+Ih4bPgw6VuiYcF/hN6ipnSoArtx0pRuZdNpXl7xqy1h9DFZLpX5SBHf
         RJkThwoQQvvWBOQW+e41fW7jI/gAmQ6jKhoNc7GYECNG515v+SahbYQ41h6nOdcnhAxK
         M0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695139945; x=1695744745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W38CXjFimuUk344mBPsm35p6+nVhboQggc89jf+vgg=;
        b=vLAmDEKWDf+pGpHfb4MlEkwE/Us3fZLYrM2dkYq3dSFFnW7t2E6bING3zzbYC3JGU7
         19ZqWtYUlTzJzXn3b/52Zw1Tqbbv9BUmUTeFhKb9QxIumtuFBZgmEsNU1n3VbS7UJiKV
         hDigCezRUrJUI3spj3RmdK/qbkk0JQH8+djr4+owZCGNTtNiMWudyT6RGQk0K0qLYgPr
         EC2kVz+B4D7h6ya4QJR/h71BLLqZV+wRMIef42KvoxJLa5TPKHxmF0pxourZjyDWUyqN
         2gU+AOaQ350EYNnpilXpIR7t3C6/oPLhmG6gWBDDGUUjSPBAI2GZaRx7zr1mLZPRM707
         VFjA==
X-Gm-Message-State: AOJu0YzUNzoIua+LCnAw4VaGQ8IAKvSLDgjiyAFpK0Rd5u0ctZUhCQU8
        QoM0i6BQzzrob+euLtz6/EuzqMHWwaKeC4Si3Ivrbw==
X-Google-Smtp-Source: AGHT+IEgICnrUOfTdBjga4HXzzAlrzXcKnDGFHfmp2FVXBZ1kFHupppnYd4zaPlaSJeMPbr2HFmBug==
X-Received: by 2002:a05:6402:4498:b0:532:c6d7:b93c with SMTP id er24-20020a056402449800b00532c6d7b93cmr1663344edb.5.1695139945348;
        Tue, 19 Sep 2023 09:12:25 -0700 (PDT)
Received: from [172.20.101.114] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402149400b0052e1783ab25sm7648500edv.70.2023.09.19.09.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 09:12:24 -0700 (PDT)
Message-ID: <8d72820d-bbaa-abc8-4448-87f0f054c381@linaro.org>
Date:   Tue, 19 Sep 2023 19:12:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] mtd: spi-nor: atmel: add at25ff321a entry
Content-Language: en-US
To:     nicolas.ferre@microchip.com, miquel.raynal@bootlin.com,
        linux-mtd@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230908151400.164470-1-nicolas.ferre@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230908151400.164470-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.09.2023 18:14, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Add the at25ff321a 4MB SPI flash which is able to provide
> SFDP informations.
> Datasheet: https://www.renesas.com/us/en/document/dst/at25ff321a-datasheet
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Hi,
> 

Hi!

> This flash is present on the MikoE flash 10 Click board and was tested on
> sama7g5-ek at spi frequency of 80 MHz:
> 
> Here is the test I ran:
> root@sama7g5ek-sd:~# dd if=/dev/urandom of=./spi_test bs=1M count=3 
> 3+0 records in
> 3+0 records out
> 3145728 bytes (3.1 MB, 3.0 MiB) copied, 0.932896 s, 3.4 MB/s
> root@sama7g5ek-sd:~# mtd_debug write /dev/mtd0 0 3145728 spi_test 
> Copied 3145728 bytes from spi_test to address 0x00000000 in flash
> root@sama7g5ek-sd:~# mtd_debug erase /dev/mtd0 0 3145728 
> Erased 3145728 bytes from address 0x00000000 in flash
> root@sama7g5ek-sd:~# mtd_debug read /dev/mtd0 0 3145728 spi_read 
> Copied 3145728 bytes from address 0x00000000 in flash to spi_read
> root@sama7g5ek-sd:~# hexdump spi_read 
> 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0300000
> root@sama7g5ek-sd:~# mtd_debug write /dev/mtd0 0 3145728 spi_test 
>  Copied 3145728 bytes from spi_test to address 0x00000000 in flash
> root@sama7g5ek-sd:~# mtd_debug read /dev/mtd0 0 3145728 spi_read 
> Copied 3145728 bytes from address 0x00000000 in flash to spi_read
> root@sama7g5ek-sd:~# sha1sum spi_test spi_read 
> 06d5459972d51a2ff4270e612270c6519e797a0b  spi_test
> 06d5459972d51a2ff4270e612270c6519e797a0b  spi_read
> 
> Here are the data from sysfs:
> 
> root@sama7g5ek-sd:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
> at25ff321a
> root@sama7g5ek-sd:~# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
> 1f4708
> root@sama7g5ek-sd:~# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
> atmel
> root@sama7g5ek-sd:~# hexdump -C /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 00000000  53 46 44 50 06 01 00 ff  00 06 01 10 10 00 00 ff  |SFDP............|
> 00000010  e5 20 e1 ff ff ff ff 01  40 eb 08 6b 08 3b 00 ff  |. ......@..k.;..|
> 00000020  ee ff ff ff ff ff 00 ff  ff ff 00 ff 0c 20 0f 52  |............. .R|
> 00000030  10 d8 00 ff 50 2a 2a 01  82 ff 9c d2 64 c1 08 46  |....P**.....d..F|
> 00000040  7a 75 7a 75 f7 c4 d5 5c  00 06 51 ff 88 30 00 00  |zuzu...\..Q..0..|
> 00000050
> root@sama7g5ek-sd:~# md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> d540f07cbfb7c9c19654c453b561b311  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 

Wonderful, thanks Nicolas!

> Best regards,
>   Nicolas
> 
>  drivers/mtd/spi-nor/atmel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 58968c1e7d2f..c94d52951481 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -184,6 +184,10 @@ static const struct flash_info atmel_nor_parts[] = {
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>  		NO_SFDP_FLAGS(SECT_4K)
>  		.fixups = &atmel_nor_global_protection_fixups },
> +	{ "at25ff321a", INFO(0x1f4708, 0, 64 * 1024,  64)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> +		PARSE_SFDP
> +		.fixups = &atmel_nor_global_protection_fixups },

We have recently changed how the flash entries are defined. Would you
please try the following changes instead?

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 95f0e139284e..44218716d81e 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -213,6 +213,12 @@ static const struct flash_info atmel_nor_parts[] = {
                .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
                .no_sfdp_flags = SECT_4K,
                .fixups = &atmel_nor_global_protection_fixups
+       }, {
+               .id = SNOR_ID(0x1f, 0x47, 0x08),
+               .name = "at25ff321a",
+               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+               .fixups = &atmel_nor_global_protection_fixups
+       }, {
        }, {
                .id = SNOR_ID(0x1f, 0x48, 0x00),
                .name = "at25df641",

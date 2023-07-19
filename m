Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB3759960
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjGSPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjGSPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:19:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB51991
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:19:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99342a599e9so980887666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689779939; x=1692371939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRytqqaUij9ITxwuW9TkWneQ35h5ghdHjnPfZyd8QPk=;
        b=cEeuCOZmAZMNyWJot6nkcxlg6qzkB7TQp9dOEsSi8lg2FXG7D56vDcVuv31IwxPV77
         Pn3XHtx82y3nbrDap7j9JqDSLch/iOViVVefBkB4h9RdKFOarUb/yvIavrrr1LMx2mn9
         Y+QmIS0j5UvhJRrKvvl7OaBk2lOR6TklRkSt6okJfxboG3aw5ToSv/xnyKHR5hl/SqoI
         VahpYVOGowdfOP2A20dHQ+im51dHiI7lEOdozNGPwEzQcIKhijBhaoeh2prTAT5Unkn9
         Im4ifAErsEGMqneWeaURYohWIspUhbWJDD/4QqGFsNVjaO3N6KDhv8eJ7XaIoaBNPCq2
         /Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689779939; x=1692371939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRytqqaUij9ITxwuW9TkWneQ35h5ghdHjnPfZyd8QPk=;
        b=QapnGA2mNzyc+jc4rbwODZgF9zJzYbI1LFv3vGTU940t3PDr0Z2G8W/cgfDvLm4BYE
         Vat3lZ1+S5yY8me0Q8vk3p/YXbxOuEy76bGZbgMnmuOi8bdVTrlGAcdyEah/7asZsaJq
         D7HLShhBsTqJxKjtDjepT582A2GifkQLFm9CNTfidAfORnKRLFAvDLxJn22Nea8oWCyZ
         fO+izpLO5R4tA9+j1DwNt36QRnI2UrtSWUgvgIwOa1+uoiby3FsLczLIhdada6UsyYyC
         qH0+t6sxKpTRK4KKc7czT8A2+In1O75udC5pjQ9n7HLR72vPGqPPslc1fDCQLnD+BA5o
         ECsw==
X-Gm-Message-State: ABy/qLZ2EF7kj806yJ/hbhYRTFkrFhS3iVqyY3bHc+4CdtKnaa7aPJkz
        C1QUWAZNDszMMHWq6tmmJWzeNQ==
X-Google-Smtp-Source: APBJJlGnBoh183JIh6x7QGF4A72MAlgN9ApNDAEYcr2MZ0wsAYZslRQwsTGMxjgyAjRO7tEXpQVNzg==
X-Received: by 2002:a17:907:86a7:b0:992:4e20:bca4 with SMTP id qa39-20020a17090786a700b009924e20bca4mr3023326ejc.42.1689779939047;
        Wed, 19 Jul 2023 08:18:59 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id jp16-20020a170906f75000b00997cce73cc7sm2453190ejb.29.2023.07.19.08.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 08:18:58 -0700 (PDT)
Message-ID: <b6725f64-7d08-5966-e0bc-17c5b2e846ad@linaro.org>
Date:   Wed, 19 Jul 2023 16:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] mtd: spi-nor: macronix: Add support for MX77U25650F
To:     mahesh.r.vaidya@intel.com, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jarkko.nikula@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        nandhini.srikandan@intel.com, rashmi.a@intel.com
References: <20230719132700.15274-1-mahesh.r.vaidya@intel.com>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230719132700.15274-1-mahesh.r.vaidya@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/19/23 14:27, mahesh.r.vaidya@intel.com wrote:
> From: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
> 
> The MX7725650F is production chip for new design from Macronix
> with a lesser memory of 256Mbit with unique security features
> like Permanent 4 I/O RPMC, Secured 8K OTP support.
> 
> Validated by read, erase, write and read back.
> Tested on Intel RPL, PASS.
> Tested-by: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
> 
> Signed-off-by: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 04888258e891..995936ba58e2 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -103,6 +103,9 @@ static const struct flash_info macronix_nor_parts[] = {
>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
> +	{ "mx77u25650f",  INFO(0xc27539, 0, 64 * 1024, 512)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>  };
>  

Does this flash support SFDP tables? Here's how you can
determine that:
https://lore.kernel.org/linux-mtd/cover.1686557139.git.Takahiro.Kuwano@infineon.com/

If yes, then you could use the generic spi-nor driver,
thus you won't need to explicitly define a flash entry,
See:
773bbe104497 mtd: spi-nor: add generic flash driver

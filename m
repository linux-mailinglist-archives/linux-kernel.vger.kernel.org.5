Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627A57869D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbjHXIOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbjHXIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:14:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00A1980
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:13:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1329907a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692864802; x=1693469602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytqMFkt9NRr1tsUoax6hHlKtE1GfD7MK/gjyrbIcJVE=;
        b=sf77aHCAGTaPW0IaTYPyHVeZd4EL8VB42KIHkcFS69/Kfb6d+MWeZW88F/RLGwrRlq
         hvMcf70iseNcblbZmI7Gbymh3mF+M4jP3CLyHS8KwC1teD+hTMd2xB5cJ1ScaO46RrJZ
         vTKSkEz7fL8ds7HpjJzMZyezGMEdfCrfL5oGF0QoRhwu/zMTIpm8Sgjw5XrEZs0AZMOg
         Tw4jnqgA0XGZTYyMpZUTTnwMn7+hEJkoAqIqUxzjOKU8AX63gSmFFt/GC+gL1+pTX43i
         KxDLCbTUrogIXWjtj7pOKi9X/ac/WJgM8166GUFO7cT/reFDADoW3EiFuQHVrsht/ICI
         HF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692864802; x=1693469602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytqMFkt9NRr1tsUoax6hHlKtE1GfD7MK/gjyrbIcJVE=;
        b=OpNbz+fCFYFPAhlGtwoHmTtY+GdWFwqwWDhIohrGtBLx5GmLQTwyM9BoVlckBWvFIY
         mhLYzhWCq6gjzk90ELDRV8eiXeYd8pI5asgnI7Mt7aPcUyNDVduMqITwEdq2YPuman8z
         cbnaUkWO9JTLT101PSwfgykx/hx42R6Xg0Oz0Iaj1G8MxxyG9vXyRqdtMBB4nTGxHadZ
         HHfeWYP7k90vQGrRyewdENu2ED/ExFghVS4eAs/0xBqVFlT0IvBVqrrMN3vXXJkWGmMM
         +IS0bl9DJqoQsVLU5UPi5HMurpcvF4D0FdumzRhd0fZAzz44B/s/1fhFFxK0o7IIu+Ie
         JmSw==
X-Gm-Message-State: AOJu0YzhxxeN/vXL6pyCiLaT0EpCaBRd19OlLsD0Zg4XOdhiatj2rkYy
        8wezeZv13/tdJuOFbBUwkLJ4qw==
X-Google-Smtp-Source: AGHT+IGCr0LTxF8ISQ7E+f9ARENyZUwcLzcXKR4z//qwVyMLM32fyosL+zMFmFdLl4JsmjcuIPABuw==
X-Received: by 2002:a05:6402:3447:b0:51d:95ac:22ed with SMTP id l7-20020a056402344700b0051d95ac22edmr18083410edc.1.1692864802621;
        Thu, 24 Aug 2023 01:13:22 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fc0f000000b0051e1660a34esm10134956edr.51.2023.08.24.01.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:13:22 -0700 (PDT)
Message-ID: <01d9e2a0-3db7-3269-84ba-962fad666ee7@linaro.org>
Date:   Thu, 24 Aug 2023 09:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 04/41] mtd: spi-nor: xilinx: remove addr_nbytes from
 S3AN_INFO()
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-4-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-4-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 08:09, Michael Walle wrote:
> The default value of addr_nbytes is already 3. Drop it.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

I noticed that we need this fix in the core. I'll have to think whether
we need to introduce nor->addr_mode_nbytes as well. I let this for after
I finish reviewing your series.

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..85e2a992a9b0 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3221,6 +3221,7 @@ static int spi_nor_init(struct spi_nor *nor)
                err = spi_nor_set_4byte_addr_mode(nor, true);
                if (err)
                        return err;
+               nor->addr_nbytes = nor->params->addr_nbytes;
        }

> ---
>  drivers/mtd/spi-nor/xilinx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> index de5189c38432..34267591282c 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -27,7 +27,6 @@
>  		.n_sectors = (_n_sectors),				\
>  		.page_size = (_page_size),				\
>  		.n_banks = 1,						\
> -		.addr_nbytes = 3,					\
>  		.flags = SPI_NOR_NO_FR
>  
>  /* Xilinx S3AN share MFR with Atmel SPI NOR */
> 

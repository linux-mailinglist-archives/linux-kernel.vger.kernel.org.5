Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C45D7516C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjGMDci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjGMDcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:32:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701B2102
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:32:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9936b3d0286so44006266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689219152; x=1691811152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smbASMP1wavR2fxNdm/uJcjvjfKhnJ6qhTiLInOsKZE=;
        b=I+h+HRvU9jKH5UKZ835EWs5+Pd4SyOvhdqz1nAw9eqcBgT+FCfbFG+uP3AEVnDi4+c
         jM895zWJpaOYuilTDyaxMJ3QtkKVFSf6Zf7pkFLjx+3yD8lcv3+vRO3PSUcwg36nnIog
         Uv8K8pVKv+GMsMiRD6IPb79gOYpiQFmhfbkVkH6zWmigDN0qmoffskuo0wnDesVQQ9gd
         XRxv8nQQMeO+6V9XPGD5/NznFmzxdp0k+GRNI1NypAiqVczkwtTXfBfYBAw1wk4j5mhK
         pQQdkyouAD+/YCgkzyEGhJ58y4yjBX1VW3QjQyAj7Tz+Pw6fkRFWBIclixiwJ9+NVXQN
         IPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689219152; x=1691811152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smbASMP1wavR2fxNdm/uJcjvjfKhnJ6qhTiLInOsKZE=;
        b=XZ9EDYv2iV3jqXEaK7cDvO4ValRKc0b0X1QugAatNsyK4Ad3vAJPFn6BSD0oLqP3CX
         9dZxHH5Q+C7AA78h2+evWsr6mv+r/wCXVOciA68FseTYAjxszRXze1AWM2OkFVNQjwdI
         PvVtsKVh/qXVjuuJgN0MqRowlCRlGVqdvsqBuUW7fIbOCPnUqUM6gyB0hYTN0OfBy5+a
         nKxMdQ47DiY24gbPNYf3Ky8Kux0v6RN2ugQ1f5Q6gpMWS3hS72jhXyENRaTrvu6reG0a
         YMSxt1kKL45pTBje9dFKC9v2BH9ctKg74z+8uSO2X0NwRVRuDmWsccKY1gcG4vLXhWr1
         goUQ==
X-Gm-Message-State: ABy/qLbye9ROtFi7Hu7lwvL0cjeRoX5N1Pfo8pj6yAc5vrfGingRxojQ
        bQm4FtXGHMI/QDXMf+MmGmUcvg==
X-Google-Smtp-Source: APBJJlHyxuGfjJuxgNF5JFaeEz7+vEIs2LMJeBubz6BCjlUfNA27TKT62WBgzES8Y5w/sZZK7n0zhQ==
X-Received: by 2002:a17:906:5dce:b0:992:aab0:533a with SMTP id p14-20020a1709065dce00b00992aab0533amr192001ejv.67.1689219151582;
        Wed, 12 Jul 2023 20:32:31 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090671c700b0098cf565d98asm3344544ejk.22.2023.07.12.20.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 20:32:31 -0700 (PDT)
Message-ID: <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
Date:   Thu, 13 Jul 2023 06:32:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

On 13.07.2023 00:59, Linus Walleij wrote:
> The Winbond "w25q128" (actual vendor name W25Q128JV)
> has exactly the same flags as the sibling device
> "w25q128jv". The devices both require unlocking to
> enable write access.
> 
> The actual product naming between devices vs the
> Linux strings in winbond.c:
> 
> 0xef4018: "w25q128"   W25Q128JV-IM/JM
> 0xef7018: "w25q128jv" W25Q128JV-IN/IQ/JQ
> 
> The latter device, "w25q128jv" supports features
> named DTQ and QPI, otherwise it is the same.
> 
> Not having the right flags has the annoying side
> effect that write access does not work.

I guess you refer to the locking flags. Probably your flash has the non
volatile block protection (BP) bits from the Status Register set, which
means the entire flash is write protected. The factory default for these
bits is 0/disabled on this flash so someone must have played with them.
The reason why one may want write protection set is to avoid inadvertent
writes during power-up.
One can control whether to disable the software write protection at boot
time with the MTD_SPI_NOR_SWP_ configs.
> 
> After this patch I can write to the flash on the
> Inteno XG6846 router.
> 
> The flash memory also supports dual and quad SPI
> modes. This does not currently manifest, but by

The fasted mode is chosen after SFDP parsing, so you should use quad
reads if your controller also supports 4 I/O lines.
> turning on SFDP parsing, the right SPI modes are
> emitted in
> /sys/kernel/debug/spi-nor/spi1.0/capabilities
> for this chip, so we also turn on this.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Only add the write access flags.
> - Use SFDP parsing to properly detect the various
>   available SPI modes.
> - Link to v1: https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org
> ---
>  drivers/mtd/spi-nor/winbond.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 834d6ba5ce70..6c82e525c801 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -121,7 +121,8 @@ static const struct flash_info winbond_nor_parts[] = {
>  	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)

while here try, using INFO with INFO(0xef4018, 0, 0, 0), those
parameters shall be discovered at run-time, so we prepare to get rid of
explicitly setting them sooner or later.

> -		NO_SFDP_FLAGS(SECT_4K) },
> +		PARSE_SFDP
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },

Looks good. Also I would like you to run a small sanity test, just to
make sure the flash works after your changes. You can do that with
mtd_debug utility, see an example on Miquel's commit message from:
https://lore.kernel.org/linux-mtd/d479489736ee193609816dc2003bd0fb@walle.cc/T/#m3550973e0884ec4a288d344fabd4a9c3b64af46e

Cheers,
ta

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE417583D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjGRRtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGRRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:49:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0837C0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:49:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so62437705e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689702591; x=1692294591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofXBG0otArMnc0xQL0OFzIyI9NYt0Dof1HcC6jOBs8Y=;
        b=RmdSF9nfYWZzYHJ21z0iaWahjaKyna5bsyQyHUvlIye253yvu2J9yg6nJv/Fb8jvmy
         HsXhDXpkgUAGWMK3vrmDCUiH3GlWF3XgsochVvAN+RUAys2SgqPZL0dgWCd07tQtmUpr
         SvJztgApBqrQ+tvZSNvvIchHyneQBW1T6z2/pPmNC69Kvx76sjslbuzRz5g8+Jnz/gBB
         zRdcERfYIYR8pPiV2IOl/qNjrg4zgEXxHXFxpM2LJXYSeXNOn6Q4tM+bmiCIs0S+c7qS
         gTQRyXH0Ph58bMg/Riod3Idp9zvdfDm9yc/4VPQ2A9M1+OsxlC5DmARbKzpcAQpyC28u
         YDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702591; x=1692294591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofXBG0otArMnc0xQL0OFzIyI9NYt0Dof1HcC6jOBs8Y=;
        b=RL0bGaNGuz2IKqAeBb9wFPDqqFf/iB5Ad1GoXp96D6S9mUuVbZjG+EYP9mPsffNx06
         N8YI0v3nPPjXMaqE//iLLG3jq37cqidEPvrQg6w1Zl1zhOBmOfj3i9XkKZCbsMYe2IcQ
         V005hm3x8r8i+9YehcZ6E/ndHlu4sbV+ZUZQUz5HVEAEhkICTG4BkGOv7r/TfZSU9XWw
         QVxcjR0kt6KRlKDD59cISOo3kO7EfGHp5bvM2PnBBUo2qDx5XjXPNvZhz1AM9JkE5nVQ
         ae1O+CS2Mwkc6sSZnd4urEOxlQUd48GzLw2fq9u6o51VQWF1XfUD9kohCazvwymfscgq
         Tvqw==
X-Gm-Message-State: ABy/qLbBIKj7nDdha3Jt6nPG3gIFsGceKe3qJz5NPz6skAXxHCFHANzv
        PLD58XHzo9ZIRfx9D6Jnka71Vw==
X-Google-Smtp-Source: APBJJlH6bu15zpd8KmGi1f4dcWUKy7fVGvqG5SkHl32pxLFEF7Ic/hK2AzT3FFt3fPEgsvfH0Ij9kQ==
X-Received: by 2002:a05:600c:b54:b0:3fa:91d2:55b6 with SMTP id k20-20020a05600c0b5400b003fa91d255b6mr2669045wmr.9.1689702591411;
        Tue, 18 Jul 2023 10:49:51 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b00313e4d02be8sm2964713wrs.55.2023.07.18.10.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 10:49:50 -0700 (PDT)
Message-ID: <23fd0aed-784d-85a8-1c45-15ac0f8afe91@linaro.org>
Date:   Tue, 18 Jul 2023 20:49:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mtd: spi-nor: gigadevice: Add support for gd25lb256
To:     Hao Yao <hao.yao@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Md Sadre Alam <mdalam@codeaurora.org>
References: <1612869079-19593-1-git-send-email-mdalam@codeaurora.org>
 <20230613045313.2690342-1-hao.yao@intel.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20230613045313.2690342-1-hao.yao@intel.com>
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

Hi!

On 13.06.2023 07:53, Hao Yao wrote:

You need some commit message here describing your changes. Please read
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
before submitting v3.

We require contributors that submit flash additions or updates to dump
the SFDP tables and do some sanity checks. Here's an example on how to
do it:
https://lore.kernel.org/linux-mtd/20230712161503.448024-1-miquel.raynal@bootlin.com/

> Signed-off-by: Hao Yao <hao.yao@intel.com>
> ---
>  drivers/mtd/spi-nor/gigadevice.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
> index d57ddaf1525b..d56c1876549f 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -62,6 +62,10 @@ static const struct flash_info gigadevice_nor_parts[] = {
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "gd25lb256", INFO(0xc86719, 0, 64 * 1024, 512)

INFO(0xc86719, 0, 0, 0) please, those params can be retrieved at SFDP
parsing time.


> +		PARSE_SFDP
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },

Is the SPI_NOR_4B_OPCODES really needed, isn't the support determined at
SFDP parsing time?

>  	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
>  		PARSE_SFDP
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)

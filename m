Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305975BFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGUHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGUHi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:38:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CBE0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:38:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9939fbb7191so353456766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689925135; x=1690529935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6gaDGm8xhTQW0uR+rpIssaq/WM7/VtmKejL9L9a2xQ=;
        b=q7/wz12nRwrNHUPdeY3QDcwXq11aGczdhpgPkQvgtGBVGRWlHWbqejbpxTOYeTxaOc
         iH0xWYRiVSea5BVd/zn6Lm7/XPyVdEaYqDS3QsXJAv1pRwgjA5izjh3FkbIP8VkHZSIh
         cvl0vBbbkKYqeAhz6rFQpOwwmpJLD/t+WtbVCaorA0Bp62U3nVDy6KpBF9uW7TERhC3y
         BAH7KckBNIzpDJrYaVPVpc4qxBvaQ6CZLqjk5/5JN5geu0Xb2s65Q/vFKvet2HMugrUe
         pTAPB0D/w1EuDwlQRWMghp6xq+OwfCbRo0C2cbV1TuWvKoXCY8jeu5xVvqmmklje5AOm
         xbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925135; x=1690529935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6gaDGm8xhTQW0uR+rpIssaq/WM7/VtmKejL9L9a2xQ=;
        b=clOcOa9gv2OHrt16TwQ4UvYPHmaWcb8khkLqpt6H4fxWyrWLB9lvGP8yjiWcSassmT
         XyvkUCHF1/hOSHak6o38po6OKsIBitkKcOEo/M02cUUinxwzdscRIjPOVTMUbZO/2m3R
         ImkXwFT/kSN1Mu/kOO7dpiWjsWa6F3A5wm4jwAvtvKdEpMQF4nVsl266Wvn45GmH3hMI
         gMeRyleC5jkH2KxnkCPYGVginHTGQN43sA+rvZTYF7gN7orcwbXTyTP9BdBLS2+H4+eg
         c+7C9o4FMU9TpZNwF2nGjeYLDoXAFXBA5C6XvwYn76wQWL8ZsefSQn9Yoape5NXWQ1b3
         T9gA==
X-Gm-Message-State: ABy/qLaQINzZNrgureReYLw/x6a8xzh2BbEE3P/MFWwehJRTeyTl53+O
        auxh+j1QHwDoJOPMCNtVZbiiAQ==
X-Google-Smtp-Source: APBJJlFtQLsBZCvEMhQHeyK6EMv2ZMDsXCkliBTUWmChT7TcmpdOPPQttmpErTW3znz3sro0pEp5zQ==
X-Received: by 2002:a17:907:1c26:b0:98d:4b97:acc8 with SMTP id nc38-20020a1709071c2600b0098d4b97acc8mr7572920ejc.25.1689925135164;
        Fri, 21 Jul 2023 00:38:55 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b009929d998abcsm1767908eju.209.2023.07.21.00.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 00:38:54 -0700 (PDT)
Message-ID: <130b3742-fe0b-2030-654f-0cf8863c1479@linaro.org>
Date:   Fri, 21 Jul 2023 10:38:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
Content-Language: en-US
To:     Vlim <vlim@gigadevice.com>, Michael Walle <michael@walle.cc>
Cc:     "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "akumarma@amd.com" <akumarma@amd.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikhyat.goyal@amd.com" <vikhyat.goyal@amd.com>
References: <20230720042834.12296-1-vlim@gigadevice.com>
 <62663146a51c2beac4eff48abe1f61f8@walle.cc>
 <TY0PR06MB56580D3FEE55389F41E33398BB3EA@TY0PR06MB5658.apcprd06.prod.outlook.com>
 <55d60aec-3b20-d9d3-aeb2-77abbcc47d16@linaro.org>
 <TY0PR06MB56581B9A28DCD7A7270CFC0ABB3FA@TY0PR06MB5658.apcprd06.prod.outlook.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <TY0PR06MB56581B9A28DCD7A7270CFC0ABB3FA@TY0PR06MB5658.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.07.2023 09:51, Vlim wrote:
> Thanks, Tudor,
> 

you're welcome

> Is PARSE_SFDP the command to read the SFDP parameters?

it's a flag, not a command, that when set at probe time the SFDP will be
read.

> It looks to me that the examples below are both using SFDP. But I do not
> see the flag that saying SFDP is used.

not quite

> 
> { "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256)
>             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)

The locking support is not part of the JEDEC SFDP standard, but vendors
can define their own SFDP tables where they describe the locking
support. So for now, if you want to enable locking you have to specify
the locking flags, whatever they are. There are different flavors of
block protection locking, with 3 or 4 block protection bits, their
order, etc. You'll have to check the datasheet.

>             NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>                         SPI_NOR_QUAD_READ) },

If the flash supports SFDP then the flags from above should be replaced
with PARSE_SFDP.

We have some requirements when one updates or adds new flash entries.
They have to dump the sysfs data, including the SFDP tables, and do some
sanity check with mtd_utils. Check the following cover letter to find
out how to do it:
https://lore.kernel.org/linux-mtd/cover.1686557139.git.Takahiro.Kuwano@infineon.com/

>       { "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
>             PARSE_SFDP
>             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
>             FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>             .fixups = &gd25q256_fixups },

these are all different types of flags. Use git blame to find the reason
why some were set.

Cheers,
ta

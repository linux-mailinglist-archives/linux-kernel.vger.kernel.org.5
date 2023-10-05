Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF57BA6FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjJEQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjJEQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:42:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1886449F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:51:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso182445166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696513912; x=1697118712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqy329Cogar5edR2RI7RX06cxB/7bukXjjsqcrAyui4=;
        b=wf05QiYD+lYWoFsjNK8sMQWl1eUo70yJag9LyX+VJ+oS+J8sQMM0Pl3C/fJjB8iC5p
         2UV/D11eaE1BB04YCoG3vSGysGNB8+0FF5rS/ahpwBWuDwGdTO7b65kn8kH9pEbwxmIU
         flOQP/A/JKwhaTQuVlDe5idHD4smrlbl6Zldos5AgCgz5Hb0oftdzZUAi5JBs4/8jx8V
         kIqi7hl54fwebKrSwCxI6Nggf87+GMrD+xUFYrKS/yOiKXF25gYSYqk6a7/hOctlvFs0
         vhzPhmpCWdNFcRc1sml2PTwWF5B+Mam2swb8Hi7ZDhbd9+ezcPXy7WovOIh0Vs0K9u//
         ZFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513912; x=1697118712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqy329Cogar5edR2RI7RX06cxB/7bukXjjsqcrAyui4=;
        b=q9pgVRz0ocllj4GZ8IAzwsG0iyGSgZ+nm4f+3+FEqBAQSMLThk389fY+yHKzwWZptn
         VudIr4BQwGwJwakiHmLTeBqfe/Lly+An7OW/+dROcGG4ExFs42/yM8WlkSZT+ijF1JZ2
         WKHatoNPB3AC5vLnSCPVvEFLMJWIR9yPrngPwXFG694/BQvwwdSitbzSnjF5RSSj46qG
         6tRbVVUBnYZELKN7kiokydDZNSlFGiN7F4ePcsfgUaNMaLvSJwLQeo5wU4PBTnIGKlYi
         WesZbMi1bqp3Q6F/zsxPpd4Y5xYqFUK5apl84+mm5tOw0X/9eUBV+uNKhWAVk7mi9XD1
         ph8w==
X-Gm-Message-State: AOJu0YwQ6IK7WD6WkUK9UiuTq9k4vpChPWvs2SgoIi/wTmcj88Z2IHJ2
        4CHDrmBIAR60YR9S3lDJRxgLHjr+o5GApCN38zw=
X-Google-Smtp-Source: AGHT+IEpUwrkNTiPZ8CpjrfNNTFs5Y6qhkeIF2v42KiS866I2/Kgz/6z8spn/gMS2JdxT3QQsGx+Cw==
X-Received: by 2002:a17:906:308b:b0:9b6:550c:71cb with SMTP id 11-20020a170906308b00b009b6550c71cbmr4400036ejv.52.1696513912297;
        Thu, 05 Oct 2023 06:51:52 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709066d0f00b00982a352f078sm1213209ejr.124.2023.10.05.06.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 06:51:51 -0700 (PDT)
Message-ID: <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
Date:   Thu, 5 Oct 2023 14:51:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
To:     SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
 <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/23 10:21, SHUKLA Mamta Ramendra wrote:

cut

>>
>> and the second one will add just the BP support, something like:
>> diff --git a/drivers/mtd/spi-nor/micron-st.c
>> b/drivers/mtd/spi-nor/micron-st.c
>> index a8da1f18e335..fdafbfa0f936 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -405,6 +405,8 @@ static const struct flash_info st_nor_parts[] = {
>>          }, {
>>                  .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
>>                  .name = "mt25qu512a",
>> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
>> SPI_NOR_4BIT_BP |
>> +                        SPI_NOR_BP3_SR_BIT6,
>>                  .mfr_flags = USE_FSR,
>>          }, {
>>                  .id = SNOR_ID(0x20, 0xbb, 0x20),
>>
>> Of course, I expect you to run again the mtd_debug tests and also verify
>> the locking. Thanks!
> 
> I applied both changes as mentioned above i.e
> 1] Switch to SFDP and 2] Using BP Flags.
> 
> Case 1: Use BP Flags and Switch to SFDP
> With both these changes, the lock/unlock doesn't work.
> 
> ## x86-64-smarc-evk-uwd0j0007 # uname -r
> 6.6.0-rc2
> 
> # flash_lock -i /dev/mtd0
> Device: /dev/mtd0
> Start: 0
> Len: 0x4000000
> Lock status: unlocked
> Return code: 0
> # flash_lock -l /dev/mtd0
> flash_lock: error!: could not lock device: /dev/mtd0
> 
>              error 5 (Input/output error)
> 
> 
> I suspected this is because of miscalculation of BP bits, like the 
> possibility mentioned here: 
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=spi-nor/next&id=3ea3f0ac242c86c0275d347ab8c92bf1eb854b49 
> 
> 
> But further checked size, it is correct:
> 
>   # mtd_debug info /dev/mtd0
> mtd.type = MTD_NORFLASH
> mtd.flags = MTD_CAP_NORFLASH
> mtd.size = 67108864 (64M)
> mtd.erasesize = 4096 (4K)
> mtd.writesize = 1
> mtd.oobsize = 0
> regions = 0
> 
> And rest of read/write functions work as expected.
> 
> Any suggestions about this?
> 
> Case 2: Just added BP flags, rest of the size, mfr_flags, fixup flags 
> kept as it is.

would you please detail what exact definitions you used in case 2? Send
us the diff please.

Cheers,
ta

> Lock/unlock works.
> 
> ## x86-64-smarc-evk-uwd0j0007 # uname -r
> 6.6.0-rc2
> 
> # flash_lock -i /dev/mtd0
> Start: 0
> Len: 0x4000000
> Lock status: unlocked
> Return code: 0
> 
> # flash_lock -l /dev/mtd0
> # flash_lock -i /dev/mtd0
> Device: /dev/mtd0
> Start: 0
> Len: 0x4000000
> Lock status: locked
> Return code: 1
> 
> ## x86-64-smarc-evk-uwd0j0007 # mtd_debug erase /dev/mtd0 0 1048576
> [  413.472411] spi-nor spi-PRP0001:00: Erase operation failed.
> [  413.478084] spi-nor spi-PRP0001:00: Attempted to modify a protected 
> sector.
> MEMERASE: Input/output error
> 
> # flash_lock -u /dev/mtd0
> # flash_lock -i /dev/mtd0
> Device: /dev/mtd0
> Start: 0
> Len: 0x4000000
> Lock status: unlocked
> Return code: 0
> 
> ## x86-64-smarc-evk-uwd0j0007 #  mtd_debug erase /dev/mtd0 0 1048576
> Erased 1048576 bytes from address 0x00000000 in flash
> 
> 
> Further I tested on stable 6.5.5 Kernel with old way of Flash Info 
> Format and which has forced PARSE_SFDP Flag, no issues with lock/unlock.
> 
> 
> ---
> Mamta

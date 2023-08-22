Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555BE78486C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjHVRaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHVRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:30:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E23667C0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:30:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a1681fa868so563470166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692725401; x=1693330201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWmvOza6gjsuYC3fbqv9jfUKP4L6c+PuYoC8WcgK5tM=;
        b=BOwWgIfwtHnkTpBd6W+Dg2CiR6w5oevSFMxcDYG930GdKktLMsMbRo4TU/AwtkYSum
         UDVcsGQTUStPikR7SbwZ4qwKGfqkHbZmTE8HatRw6tKOy9QZsHJY526Yi2SngtemIPtB
         KkpDg9flJ6tMjMS7yfMdc5klHYAHWpqDH5KQVYKV/zLlRixg3aHGkneWA5hwz+64BbUP
         wvzPfFkHwa989XV5UIm7LN/Qb4gC71kZ1ym8kebLpKNt0s3/6MaebJAAKLhZGmzfo9El
         n/RaaMSmYilg4dENPLehz0AtJKrufjQafTsAMtJ6jjgkifzMiugJpKpyhUeMPRc8OHkH
         jaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725401; x=1693330201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWmvOza6gjsuYC3fbqv9jfUKP4L6c+PuYoC8WcgK5tM=;
        b=iwuogJmzXLMQsQEnDu4n7sQvtQW/TN06SqSvI7Jeq/IVKb3QMQC5ZUZx83zhLoBK/R
         ETnuUUjEIty1bSQAGHsDKX8uGvYlbo8oo/DmmtiLfnDgcxyjx/pIcTUcLprqhpS+TRSR
         sEJ0Rnm1TrZ69YEKmDvoR7HR8jYEEaRZ7Nkvdazz3Eclk0Oe5+Hp+Llt7I4auzXxHDD6
         p8GD7P4WIA0xzEyzm3JWguWGG/orXMJPVZ7mEf3zIk3lY1U7NOfFmApVSDxStbwWZmkx
         fuBbTuwmS9RZNJAEbdjcYaXMqvOd/0zr8ynZaZ/gDZBxWyHzRl7JgMiFu5S2oYBQFtT0
         O02w==
X-Gm-Message-State: AOJu0YwiCh7oTnhofDj+ofsHZdSwjui+s+858RrmHpae+2Yl36gpK/ij
        1C/LE/5vQ/DUMriG2Y//CKZihLbkYL/hse7Mmcc=
X-Google-Smtp-Source: AGHT+IGuvA3uDSJ9w9X7WxYpv8HpbTOqs10LgSQNQn+p+OiZf4+6uNZEHnaVjH6Wf1qriNVhaoftcg==
X-Received: by 2002:a17:906:3051:b0:99c:f47a:2354 with SMTP id d17-20020a170906305100b0099cf47a2354mr8371875ejd.70.1692725400682;
        Tue, 22 Aug 2023 10:30:00 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id md21-20020a170906ae9500b009829d2e892csm8552636ejb.15.2023.08.22.10.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:30:00 -0700 (PDT)
Message-ID: <6e3b58d0-4017-9051-9337-7d86a6be55de@linaro.org>
Date:   Tue, 22 Aug 2023 18:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/22] nvmem: patches for v6.6
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
 <2023082217-banter-craftwork-281a@gregkh>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2023082217-banter-craftwork-281a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2023 15:34, Greg KH wrote:
> On Mon, Aug 14, 2023 at 05:52:30PM +0100, Srinivas Kandagatla wrote:
>> Here are some nvmem patches slightly more than usual for 6.6 that includes
>>
>> - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
>> - core level cleanup around error handling and layout creation.
>> - few minor cleanups across providers drivers to use better
>>    apis and a typo fix.
>>
>> Can you please queue them up for 6.6.
> 
> I did, thanks, but your email system needs to be fixed:


Do you mean Attestation failing part or something else?

--srini
> 
>   Link: https://lore.kernel.org/r/20230818124338.37880-1-yuehaibing@huawei.com
>   Base: applies clean to current tree
>         git checkout -b 20230818_yuehaibing_huawei_com HEAD
> Applying: greybus: svc: Remove unused declarations
> Press any key to continue...
> Grabbing thread from lore.kernel.org/all/20230814165252.93422-1-srinivas.kandagatla@linaro.org/t.mbox.gz
> Analyzing 23 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>    ✗ [PATCH 1/22] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
>    ✗ [PATCH 2/22] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
>    ✗ [PATCH 3/22] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH 4/22] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
>    ✗ [PATCH 5/22] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
>    ✗ [PATCH 6/22] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH 7/22] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH 8/22] nvmem: qfprom: do some cleanup
>    ✗ [PATCH 9/22] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
>    ✗ [PATCH 10/22] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
>    ✗ [PATCH 11/22] dt-bindings: nvmem: Add t1023-sfp efuse support
>    ✗ [PATCH 12/22] nvmem: add new NXP QorIQ eFuse driver
>    ✗ [PATCH 13/22] nvmem: Explicitly include correct DT includes
>    ✗ [PATCH 14/22] nvmem: Kconfig: Fix typo "drive" -> "driver"
>    ✗ [PATCH 15/22] dt-bindings: nvmem: Add compatible for QCM2290
>    ✗ [PATCH 16/22] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
>    ✗ [PATCH 17/22] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
>    ✗ [PATCH 18/22] nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
>    ✗ [PATCH 19/22] nvmem: core: Create all cells before adding the nvmem device
>    ✗ [PATCH 20/22] nvmem: core: Return NULL when no nvmem layout is found
>    ✗ [PATCH 21/22] nvmem: core: Do not open-code existing functions
>    ✗ [PATCH 22/22] nvmem: core: Notify when a new layout is registered
>    ---
>    ✗ BADSIG: DKIM/linaro.org

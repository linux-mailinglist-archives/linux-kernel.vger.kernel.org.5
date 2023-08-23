Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8778538D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjHWJLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjHWJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:07:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16331706
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:54:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf1f632b8so719497166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780845; x=1693385645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaN9Yl4WIqy/Z9zG+P/bSUj8CiruvxWP/wFVfyfYE1w=;
        b=PRYeGF4jZr/3AiuXom4wukvEG7mp/bxEvUG5mBtKiKXHpLAIX5BOMPuDJ5hyZfziGb
         an5J1ZpSc7OU+p5jGwk/hO7GRWRhs5BRQaGi/Qn4a5tW6CWHK+5MQbixITEvinK4viea
         X1yyRsShZKDsyFszyI7UdE1PaY2ztYWtdOgzQCsh7gFbL3n8sx8/7ATdKGgqEWFTo3WU
         rKpE5NFfvopCzFZb1pvDOzfbvWQZTr/dAjLuCFvQkoGdUB041Ri8rzqcGPIOFJVtWdl8
         MIld32R+zy2y2MoQsE1CwF3fZP3GX6PB1PPbcahK+E542G6p81ZZH4UWHOA5yitM45/n
         Q2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780845; x=1693385645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaN9Yl4WIqy/Z9zG+P/bSUj8CiruvxWP/wFVfyfYE1w=;
        b=aj1+exUQAFAkn9rGb07ZRA8RAqHAFFxkzeR4YnCXYS2W53s1gxyu19nQIHITt8Q651
         /t8bgANoRlPyHSzJoK6jPFDfDp1d8aT9YnyNWod0TiZq2WmBAt3uNtdwLW5I4gkShCsk
         zdd6jARq6RYvv7UVuCPvRMlcrDB+yDK/U/JrV97m4QpYb3QcAUpdfxi3f/bAhfVTOD8Z
         TwxL82yNOD8CN1YGhwHj9QBTc2zfrRMICjHrQyLzAgc9ZcxU9ILzAd6XBtoVtctu/Bf1
         5Q//0OO5+EQPCAxx8IMrg6CLxlPHOkh65+znKwqHSZSKNU2i23tD9mAsl0YIruwjtmuW
         yjQQ==
X-Gm-Message-State: AOJu0YyJjbLJbntirYd8OIut5v03icPaQ5a6Qy/F8EbrObvlwJezs8h4
        3xsnZOge/EWf1uw+Q2E8CMIqIEywmaZ0XWHMfes=
X-Google-Smtp-Source: AGHT+IEis6Ss40Nzd3tp6z5kBEPdhj3dv4cnfQ8vSdqEPN6IDffVmTXW0Ch7DBb3la6IMkchQ+xfqw==
X-Received: by 2002:a17:906:73d8:b0:99c:e38d:a823 with SMTP id n24-20020a17090673d800b0099ce38da823mr8812499ejl.67.1692780845208;
        Wed, 23 Aug 2023 01:54:05 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id gf2-20020a170906e20200b00993a9a951fasm9605904ejb.11.2023.08.23.01.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 01:54:04 -0700 (PDT)
Message-ID: <a2cd120c-f09e-de58-b3a6-beaadb199ae4@linaro.org>
Date:   Wed, 23 Aug 2023 09:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/22] nvmem: patches for v6.6
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
 <2023082217-banter-craftwork-281a@gregkh>
 <6e3b58d0-4017-9051-9337-7d86a6be55de@linaro.org>
 <2023082220-cavalry-litigate-9fe3@gregkh>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2023082220-cavalry-litigate-9fe3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2023 18:37, Greg KH wrote:
> On Tue, Aug 22, 2023 at 06:29:54PM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 22/08/2023 15:34, Greg KH wrote:
>>> On Mon, Aug 14, 2023 at 05:52:30PM +0100, Srinivas Kandagatla wrote:
>>>> Here are some nvmem patches slightly more than usual for 6.6 that includes
>>>>
>>>> - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
>>>> - core level cleanup around error handling and layout creation.
>>>> - few minor cleanups across providers drivers to use better
>>>>     apis and a typo fix.
>>>>
>>>> Can you please queue them up for 6.6.
>>>
>>> I did, thanks, but your email system needs to be fixed:
>>
>>
>> Do you mean Attestation failing part or something else?
> 
> Yes:
> 
I did not setup patatt in my workflow yet, which is why this is failing 
attestation.
will do that before sending out v2.

thanks,
srini

>>>    Link: https://lore.kernel.org/r/20230818124338.37880-1-yuehaibing@huawei.com
>>>    Base: applies clean to current tree
>>>          git checkout -b 20230818_yuehaibing_huawei_com HEAD
>>> Applying: greybus: svc: Remove unused declarations
>>> Press any key to continue...
>>> Grabbing thread from lore.kernel.org/all/20230814165252.93422-1-srinivas.kandagatla@linaro.org/t.mbox.gz
>>> Analyzing 23 messages in the thread
>>> Checking attestation on all messages, may take a moment...
>>> ---
>>>     ✗ [PATCH 1/22] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
>>>     ✗ [PATCH 2/22] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
>>>     ✗ [PATCH 3/22] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
>>>     ✗ [PATCH 4/22] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
>>>     ✗ [PATCH 5/22] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
>>>     ✗ [PATCH 6/22] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
>>>     ✗ [PATCH 7/22] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
>>>     ✗ [PATCH 8/22] nvmem: qfprom: do some cleanup
>>>     ✗ [PATCH 9/22] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
>>>     ✗ [PATCH 10/22] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
>>>     ✗ [PATCH 11/22] dt-bindings: nvmem: Add t1023-sfp efuse support
>>>     ✗ [PATCH 12/22] nvmem: add new NXP QorIQ eFuse driver
>>>     ✗ [PATCH 13/22] nvmem: Explicitly include correct DT includes
>>>     ✗ [PATCH 14/22] nvmem: Kconfig: Fix typo "drive" -> "driver"
>>>     ✗ [PATCH 15/22] dt-bindings: nvmem: Add compatible for QCM2290
>>>     ✗ [PATCH 16/22] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
>>>     ✗ [PATCH 17/22] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
>>>     ✗ [PATCH 18/22] nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
>>>     ✗ [PATCH 19/22] nvmem: core: Create all cells before adding the nvmem device
>>>     ✗ [PATCH 20/22] nvmem: core: Return NULL when no nvmem layout is found
>>>     ✗ [PATCH 21/22] nvmem: core: Do not open-code existing functions
>>>     ✗ [PATCH 22/22] nvmem: core: Notify when a new layout is registered
>>>     ---
>>>     ✗ BADSIG: DKIM/linaro.org
> 
> Looks like someone is impersonating you, or Linaro's email server is
> broken?  I think other Linaro emails validate properly, so is this
> something with your setup?
> 
> thanks,
> 
> greg k-h

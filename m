Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F576E068
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHCGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHCGlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:41:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9DDC0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:41:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-522ab301692so677749a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 23:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691044872; x=1691649672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3lDHqasLR71p6RjL20g3V1HU00B9G2u701BbTE8dB0=;
        b=JSK0Rb2m9+SiykNVmY0zcUcEzJqMFce01qKjOT2jA2sNtBiDW7Q5wP/8PYb0xAubX5
         OLLWBWb/ZMhfjlQ+ZDPnQtk0+4ELNVckLJ/LmTIwdUra/GbRofxRC/w7/u4vVn3sXhqG
         CEwfm3CPM/VtIWkVqJRrKvaVGRUopBinM0epkU7hVGTVe/LeaoTWVT2g24U18S2O3Nzd
         O0SfJ9q+9i9BvMjroFP3Fwj7dGUPyLqJHfk1Vv9NZl7wdeXYyJJB8JdBHTjpwnr8eggb
         NykE3e755WTkJZuBovR4gaX2U06fXZf/0KnxYcNPE7H4iiqqWhuZejKcJio0NgigCHQV
         fU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691044872; x=1691649672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3lDHqasLR71p6RjL20g3V1HU00B9G2u701BbTE8dB0=;
        b=kZ8hOdddjqwOO8vXNxxz0N1/o1biRy39MmsSGFCpfG4eKs8u28rspaG+2Rzrq7K3HO
         k1FW1erBAJJ9O6CiZvVBF4gaIYFDGrlUTYvLxFwPZUWPTLhg09KyEPiDQQvE2qNeYEvS
         2e+OOIx7BikPOMmXb0X8r/Avpy0PrNHffjVXuUYvrIlfNVn9jc4JxHJ3tayYvjkk2741
         tm0gCbaXV+S+1lDoF3toK91rQmJYesqBKbBTy8qC4CXr0QPtoSw8gNky0pjy+mCCyE93
         Ws26a8OswLmyGuZstYuuzc4Fx8/QCAVhTEwXpDsZBE8nk/p4Dh92BvrJ83QTih+2t5/F
         rxGw==
X-Gm-Message-State: ABy/qLZ4FTiBMQRrFos2xjRnDpjFzyLSPWPSktHNeEBOpuJ9b3B1APMT
        oaWjxIqLx4vo+t/cuqrI6Y1qUg==
X-Google-Smtp-Source: APBJJlGpY86nu/tit00wHwCp6uIvWO0w7bGHc9EPU6c1uYz6cuhy6gZYp6qQQ+A4SgFiqCGgfc81NQ==
X-Received: by 2002:aa7:d705:0:b0:521:e502:baf8 with SMTP id t5-20020aa7d705000000b00521e502baf8mr6868369edq.11.1691044871858;
        Wed, 02 Aug 2023 23:41:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7d1d1000000b00522854fb049sm9705791edp.2.2023.08.02.23.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 23:41:11 -0700 (PDT)
Message-ID: <ca969933-c7f8-a727-3c7e-5ec3548862a0@linaro.org>
Date:   Thu, 3 Aug 2023 08:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Conor Dooley <conor.dooley@microchip.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Conor Dooley <conor@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
 <20230801-varsity-chemo-09cc5e250ded@spud>
 <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
 <20230802-jailer-pavilion-84fb17bb3710@wendy>
 <3534f7b9-0e02-28c1-238a-5a6fdbb95e94@loongson.cn>
 <20230802-bunkbed-siamese-57ee53bdf273@wendy>
 <db7012b2-9156-34ed-ad1f-10a3e5dfe390@loongson.cn>
 <20230802-empathy-wound-70df4990a976@spud>
 <ae74e7b0-26ae-5707-7b85-5dcf733d2bed@loongson.cn>
 <20230803-tartar-tainted-968687047460@wendy>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230803-tartar-tainted-968687047460@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 08:30, Conor Dooley wrote:
>>>>                  gpio0:gpio@0x1fe10430 {
>>>>                          compatible = "loongson,ls2k-gpio";
>>>>                          reg = <0 0x1fe10430 0 0x20>;
>>>>                          gpio-controller;
>>>>                          #gpio-cells = <2>;
>>>> 			interrupt-parent = <&liointc1>;
>>>>                          ngpios = <64>;
>>>>                          loongson,gpio-conf-offset = <0>;
>>>>                          loongson,gpio-out-offset = <0x10>;
>>>>                          loongson,gpio-in-offset = <0x8>;
>>>>                          loongson,gpio-inten-offset = <0xb0>;
>>>> 			loongson,gpio-ctrl-mode = <0x0>;
>>>>                          ...
>>>> 		  }
>>>>
>>>>                  gpio1:gpio@0x1fe10450 {
>>>>                          compatible = "loongson,ls2k-gpio";
>>>>                          reg = <0 0x1fe10450 0 0x20>;
>>>>                          gpio-controller;
>>>>                          #gpio-cells = <2>;
>>>> 			interrupt-parent = <&liointc1>;
>>>>                          ngpios = <64>;
>>>>                          loongson,gpio-conf-offset = <0>;
>>>>                          loongson,gpio-out-offset = <0x10>;
>>>>                          loongson,gpio-in-offset = <0x8>;
>>>
>>> These 3 are the same for both controllers, no?
>>> Is only the inten-offset a variable?
>>>
>>>>                          loongson,gpio-inten-offset = <0x98>;
>>>
>>> These offsets exceed the region that you've got in the reg property for
>>> this controller, do they not?
>>>
>>> Is there some sort of "miscellaneous register area" at 0x1FE104E0, or
>>> just those two interrupt registers and nothing else?
>>
>>
>> 2k500 gpio dts is just an example, like 3a5000, or more other platform,
>> above offset was different but the gpio controller was compatible.
>>
>>                 gpio: gpio@1fe00500 {
>>                         compatible = "loongson,ls2k-gpio";
>>                         reg = <0 0x1fe00500 0xc00>;
>>                         gpio-controller;
>>                         #gpio-cells = <2>;
>>                         ngpios = <16>;
>>                         loongson,gpio-conf-offset = <0x0>;
>>                         loongson,gpio-out-offset = <0x8>;
>>                         loongson,gpio-in-offset = <0xc>;
>> 			...
>> 			}
> 
> That is a different SoC and needs to have a different compatible string.
> "loongson,ls2k-foo" compatible strings were a mistake that only got past
> us because we were not aware it was a family, rather than a specific
> SoC. They certainly should not be used in isolation on a 3a5000!
> 
> Are there more than one GPIO controllers on the 3a5000? If so, what do
> those nodes look like.

Eh, even for the same SoC having different offsets suggest that
programming model is a bit different. Anyway, who designed such
hardware? Really?

Best regards,
Krzysztof


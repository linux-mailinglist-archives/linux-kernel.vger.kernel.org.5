Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957747FEA23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbjK3IDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjK3IDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:03:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36710D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:03:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54afd43c83cso554047a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701331399; x=1701936199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJd9Uk6t7Y5o+xsifWwLGMs7qEY6VjicjwyZWtTxCgQ=;
        b=jd4Xai2E+MMJOfWFGV9yiryo7hYBj1TPk5G3NP3BGZQYHeCCoavUT1chxfOyRuhgPV
         P9tP1WDwX0uVRnhAgq8PGDKGpGNt/6GbKDSFcuCEGnFTAicUPC2TFcCYhaMU6NvfITu8
         p5vs4SVSDLkNV4AlV9z+wn2zV0JilrzyGIduJcufYfsKIrlZ51Xdh0Y5DLUYTso6E2cw
         Usmwn/Suubi8+1T/p7xadmgm6ILQZFpo7s7nXqWCuvD4CHA/tiiQyv+UPjICCk/90TUa
         2hqoiMcTPt0jeGiuixJTTXv1MJFrG+ZKJpn1uTfSHaplAE2D53xtiSQjTWEwyTaVLa1S
         nfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331399; x=1701936199;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJd9Uk6t7Y5o+xsifWwLGMs7qEY6VjicjwyZWtTxCgQ=;
        b=TwhkwalZ2GlZNo1lUyXnHwhHTKV9k9dpSd9YLLIZG8ZO85WPzD8mdb7cTaMYZdsDt4
         ydEsr/KMEYjviRGhIskSzfCttC2iAJXjjISPV0p+geY00bSXPMtuENGUDzJeh24LjF0C
         x3nb3x7WnihcI20Tl8fxEo9USiyGAyOlOb51mGHB5uJKeV/L6Ioao75/qvUY3+erXd+y
         PEbFSbsgHDbFKFyJM+V1LP4b1lki2D3nrb8K1X546G9bMQM9u2UMRY0PDvUeIELkxnoh
         Nyqf620PQLvyqRTZEBuZdI4KV3ucTHS/mPGNimuf7H/oHP6D74sgR0HhIuNqS+XUTrZA
         OpUg==
X-Gm-Message-State: AOJu0Yy9Q5JvMkubqZyo9M8nF8lLtBbx7UMt6+fsbC+qOnM98B/NTT++
        h3ZLNbnOU0eJZiYztNPIfutY2Q==
X-Google-Smtp-Source: AGHT+IEahOaCi8GKojER7yMi7nGU5kYLnxeF+eW+RpCQYnWem49rP6WV1WaWzP3okeX8C53lX+WpsA==
X-Received: by 2002:a50:bb63:0:b0:548:55f0:b5f2 with SMTP id y90-20020a50bb63000000b0054855f0b5f2mr14330965ede.6.1701331399465;
        Thu, 30 Nov 2023 00:03:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7df96000000b0054b3a6243b1sm291363edy.71.2023.11.30.00.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:03:18 -0800 (PST)
Message-ID: <50e56220-8068-4e2e-a586-9d0474963085@linaro.org>
Date:   Thu, 30 Nov 2023 09:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Content-Language: en-US
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
        =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= 
        <bear.wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20231125012303.760-1-chunfeng.yun@mediatek.com>
 <e34c2746-8e93-48b8-9c96-690242fbf6e9@linaro.org>
 <239def9b-437b-9211-7844-af4332651df0@mediatek.com>
 <0dc24d82-e09d-45bc-98ae-1dfb6318cb96@linaro.org>
 <74957a9cc4663815e200d222483541a1eec43bbe.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <74957a9cc4663815e200d222483541a1eec43bbe.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 02:51, Chunfeng Yun (云春峰) wrote:
>>> 3. How about we revise the description as follows for more
>> precisely?
>>>
>>> mediatek,force-mode:
>>>    description:
>>>      The force mode is used to manually switch the shared PHY mode
>>>      between USB and PCIe. When force-mode is set, the USB 3.0 mode
>>>      will be selected. This is typically required for older SoCs
>>>      that do not automatically manage PHY mode switching.
>>>      For newer SoCs that support it, it is preferable to use the
>>>      "mediatek,syscon-type" property instead.
>>>    type: boolean
>>
>> Again, what is force-mode? 
> Our DE describe this behavior as force-mode, as you see, the driver

What is "DE"?

> power down controller and reset pipe to set the mode directly we want,

So force-mode is driver behavior?

> but usually the phy controller switch to the mode automatically
> according to the external signal, e.g. trapping pin, efuse etc.
> 
>> It looks like you wrote bindings for the
>> driver behavior. Bindings describe hardware, not how the driver
>> should
>> behave. The property might be reasonable, but you must describe here
>> hardware characteristics/issue/etc.

You must address this, in such case.



Best regards,
Krzysztof


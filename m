Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD97E3595
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjKGHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:14:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B805C11C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:14:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso40634225e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699341246; x=1699946046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlUBqdRrlVAsgwbLNX4JnMxLG2jvyre0Yux7RYT8Ceo=;
        b=PvOJyXKqXL0rQzAeyAMUCM9+lA4Y2fUdaS/jJfzA0+hZZoexqk6bJltlR+MAd9nbRf
         N12u53DD4rNXmG7tayoDqFxjVNUrZC0PP8ccbvXQ71EISnAT83bUkapfc5e1XuKQnb5d
         UghSeBNOjv9FmPwa6M8DX72FdWHG9T1nnUmoXHJGm63wUptRTZPVHVubcNjeYGbJqyk/
         UKyYau3UdAp67bQC5b0jqMc+UA4cSjwyG/WPPEzWmJ24T4Lveih0uVIo3kSUsbczn/ZM
         rWwzs+gxLgdYSeS4qFMg0Dg4ltpHLlbjEEBb9VHd1MAf/apAx81PVE8e9yej2C53IyxC
         stgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699341246; x=1699946046;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlUBqdRrlVAsgwbLNX4JnMxLG2jvyre0Yux7RYT8Ceo=;
        b=CGXk2Ep6QlhFR420D9cVxZbcUBOIeaays1/aQLpgz062Nb6Ok4fwnwe8W705rEHtz3
         59ifawmFIANEYaXSGkJIgY1Z46oxrkOV0WwcxeKB9QppYD2wfhSKNEB47wmfYJymj4T+
         u81KmGRKqfO93nPRAsLCVFfaCIJPx4VMMA9TJSiMgo4W5AZc4OL/M8SkM33jAdYXzIRd
         i/6X8/PzgU0gYi1iMFWt5WVabVjbYxekq1pbjE6ZFu3A4AaMcGYq/oi1g0s/TtsLH4zD
         c20zX30MvyFdv8rrqcw1VSNVpFCQRUgwSkL+L5KEU4mWK7lB92ydYxvABJSTNN5mEHXK
         f9Fw==
X-Gm-Message-State: AOJu0YxrEkjPoxbEIMrIlBTN7oSN2R8PqM2bAVq6hB79VMgf6siYcadf
        Mk8P8uKirFPBX+E4h+VnMWhn7Q==
X-Google-Smtp-Source: AGHT+IH3CSvw/4yXmXI6MiKV4Q9Qi5/8UvR5mgIKe3bvhZVOr8oGYdE/1bFGh2HTXQZBV1KghjpNdg==
X-Received: by 2002:a7b:c3c8:0:b0:409:67bd:6fa1 with SMTP id t8-20020a7bc3c8000000b0040967bd6fa1mr1442758wmj.18.1699341245980;
        Mon, 06 Nov 2023 23:14:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t13-20020adff60d000000b0032f7c563ffasm1494105wrp.36.2023.11.06.23.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 23:14:05 -0800 (PST)
Message-ID: <78ee82da-bad9-4253-8aba-35ce6a36b65c@linaro.org>
Date:   Tue, 7 Nov 2023 08:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: add vcc supply for
 PCA9534
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231106185736.668966-1-hugo@hugovil.com>
 <e4884c86-0b8c-4e73-9280-296be98d57b1@linaro.org>
 <20231106163633.764707a8140dfe750f875dc3@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231106163633.764707a8140dfe750f875dc3@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2023 22:36, Hugo Villeneuve wrote:
> On Mon, 6 Nov 2023 21:39:42 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 06/11/2023 19:57, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> The following warning is shown when probing device:
>>>
>>>     pca953x 1-0020: supply vcc not found, using dummy regulator
>>>
>>> Add fixed 3.3v regulator as vcc supply to silence the warning.
>>>
>>
>> This is not really a warning. It's perfectly fine to use dummy
>> regulator. Adding such fixed supply has sense in following cases:
>> 1. Bindings require the supply,
>> 2. This is in fact exactly that supply (verified on schematics).
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> this is case #2, but looking more closely at the carrier board
> (symphony) schematics, it is not exactly the "reg_3v3_fixed" supply I
> mentioned in the patch, as "reg_3v3_fixed" is located on the SOM and
> only powers SOM components.
> 
> However, "reg_3v3_fixed", which is an always-on regulator (no software
> enable control), is used as the enable input to a mosfet switch (Q2) on
> the carrier board to generate the 3.3V (label BASE_PER_3V3 on the
> schematics) used by all peripherals on that carrier board.
> 
> I guess I could then define a new "always-on" regulator labeled as,
> for example, base_per_3v3, and then assign the pca953x vcc-supply
> property to it?

I guess this could be the same supply, even if this is not 100% true.
However it would be good if you put above explanation in the commit msg.

Best regards,
Krzysztof


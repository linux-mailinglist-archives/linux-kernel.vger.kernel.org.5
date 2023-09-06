Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A374793765
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjIFIsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjIFIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:48:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F041715
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:48:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso4685467a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693990105; x=1694594905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrCIcjF1rY1mMD/Gu+r4tbPGrpOuOBfXe5P30B5qf1Q=;
        b=gjd3AsiRvJZVpqXBjKKj4V23wJK37HZxuiRhYiR7YhEGsOElHNV3fd/X9IVNNr0Ypt
         bGGZd4fyi7r9EOZiFPl8QHWPSRfCQl1xoD+Y7ecOoY53m1ueuJJb7WRvpR9wotBVL1pc
         YSS9C3fUQ/9RJUN8tPAhtbMeeVQxyrSAy4a5/dsQjDNf/b7ueu2XwSwLd+M6pFPvjaGZ
         w3SDLoKbBa04PLbLbgsv2VZRQYkI90jPNrvOaRSUQ1txLmK0bEKDjbMG8zFOKhIh2wv4
         ch3lS4s9eUlDVAJxVxipVR5hWxCjwzJSJB9nUcZAPS/GsB824pwZcMkQbJb+Z/Fn6eB9
         vTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693990105; x=1694594905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrCIcjF1rY1mMD/Gu+r4tbPGrpOuOBfXe5P30B5qf1Q=;
        b=ReZxs5MqWLHnse98x/ycEcPEPGodg7bSlTT6Ym6c45gZ1DIVAIfLnQeswcMUoOhRqG
         L2OmhGWJrhnRK6p+6lBlN+OkaBCVUpr5vIHhAPb2aR+VVDefVeSQ+g1+4PQZByUQgye1
         6C8SyByw2t6+aEu3gmdin3M+HXgb64ZcFvEZA/Yz77pdiP2mRra49DkAG8nijB/AF5hg
         mrdHWGUW6JUE7CFW2cqrvAen0vgVkncgGzyXI7Xay9HzZzZBFvowlon7Jqx6yhVe9FD2
         StTCWbiskNYksvnbOqjLX4TADHpDlcqBzRIVgtE73pFRKi+vGEkr8ZtTMUVZhT6NUP6r
         S4XQ==
X-Gm-Message-State: AOJu0Yzv/+877LJpJ6oW62W5Ut/g70C8J12pYhwxzghK/0svn81f+0eq
        LbVe0GFcwNYEugtL+GLtWuDnCg==
X-Google-Smtp-Source: AGHT+IH8UP4xS9z1tEun/6EHP9/nk72OwvNjGqpg0zwCljUObKiMg7WpCrPYbEl9OzalF7MYJfPYtA==
X-Received: by 2002:a17:906:cc4e:b0:9a2:292d:ea63 with SMTP id mm14-20020a170906cc4e00b009a2292dea63mr1570271ejb.37.1693990105263;
        Wed, 06 Sep 2023 01:48:25 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id ov22-20020a170906fc1600b00992c92af6f4sm8841374ejb.144.2023.09.06.01.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 01:48:24 -0700 (PDT)
Message-ID: <a3ed9856-a87b-5cf6-26b5-ff2b19234a8a@linaro.org>
Date:   Wed, 6 Sep 2023 10:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
 <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
 <20230906083237.GL7971@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906083237.GL7971@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 10:32, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> On Wed, Sep 06, 2023 at 09:27:07AM +0200, Krzysztof Kozlowski wrote:
>> On 06/09/2023 01:31, Paul Elder wrote:
>>> Add overlays for the Pumpkin i350 to support THP7312 cameras.
>>>
>>> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/Makefile         |  4 +
>>>  .../mt8365-pumpkin-common-thp7312.dtsi        | 23 ++++++
>>>  .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   | 73 +++++++++++++++++++
>>>  .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   | 73 +++++++++++++++++++
>>>  4 files changed, 173 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>> index 20570bc40de8..ceaf24105001 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -56,4 +56,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-pumpkin.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>>>  
>>> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi0-thp7312-imx258.dtbo
>>> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi1-thp7312-imx258.dtbo
>>>  mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
>>> +
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mtk-mt8365-pumpkin.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
>>> new file mode 100644
>>> index 000000000000..478697552617
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
>>> @@ -0,0 +1,23 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2023 Ideas on Board
>>> + * Author: Paul Elder <paul.elder@ideasonboard.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +/plugin/;
>>> +
>>> +&{/} {
>>> +	vsys_v4p2: regulator@0 {
>>
>> Hm? Is this a bus?
> 
> There are multiple instances of "numbered" regulators in upstream DT
> files, for instance arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi

That's the only example I saw... I fixed it now.

> has a regulator@0. There are similar instances for clocks.
> 
> I understand why it may not be a good idea, and how the root node is
> indeed not a bus. In some cases, those regulators and clocks are grouped
> in a regulators or clocks node that has a "simple-bus" compatible. I'm
> not sure if that's a good idea, but at least it should validate.
> 
> What's the best practice for discrete board-level clocks and regulators
> in overlays ? How do we ensure that their node name will not conflict
> with the board to which the overlay is attached ?

Top-level nodes (so under /) do not have unit addresses. If they have -
it's an error, because it is not a bus. Also, unit address requires reg.
No reg? No unit address. DTC reports this as warnings as well.


>>> +		orientation = <0>;
>>> +		rotation = <0>;
>>> +
>>> +		thine,rx,data-lanes = <4 1 3 2>;
>>
>> NAK for this property.
> 
> Please explain why. You commented very briefly in the bindings review,
> and it wasn't clear to me if you were happy or not with the property,
> and if not, why.

Because it is duplicating endpoint. At least from the description.


Best regards,
Krzysztof


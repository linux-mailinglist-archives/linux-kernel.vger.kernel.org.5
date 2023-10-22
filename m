Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE467D2416
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjJVQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjJVQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:01:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220AEF4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 09:01:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5210a1515so38091911fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697990495; x=1698595295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XF8bZOPJInqq5OxQpnzQxfKIpWa2JL/vX2kovDuHNpI=;
        b=Z/Loa9RWaONqFJyCGdaoAcXlUNJX6RrKBk8Ah4sGPY6569tKJ5nFZSbAHVnsWe0zq6
         ZTuIKBY3ZS3/gnMfVYA289/dCAKYh1XVbNLCmSqk+DSD1CiODDO+tyR1dodoZQ7Mbgd9
         5m2kA9wWF9e0ru7vkfXmZ6x090R6nJBakmBsuXfBK5olzB0mIWD+od8ux4TaDgjNZizM
         0oe7HsoYyP61yM9IsKgXktyzm/mOdyewLm4owC7zCMh/DOcXP8gTaJMiDkM7h8pbMUao
         28anNrrWHEK5iegGR/8u7vqJ2LEHcldTw9w0okzcZi5bD2l9VXCDFE75aHz0tadlXuNo
         zbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697990495; x=1698595295;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XF8bZOPJInqq5OxQpnzQxfKIpWa2JL/vX2kovDuHNpI=;
        b=ixF8SPDofcC1WnfPDPQLbcDutxUspQF7WL1rtFQPPp5WRF5mHYel9vOXfpZlBJ0bg5
         cx1u2QVgCExQkVblXtoZKfMB+ENjmBzxIrVR3qvdzuMit9733iL/FlKmJf2THC8SbPkm
         T5ajvN/s6h4nCjf5ZijDbgXw0KY91YeHtL9tvyvoG79amUXRHg3TXLvZ/eODePr+9Orc
         YBgc1H33YL1ixwX+Cy0np5VIRVYnQt4aIfBnbUzWJgUXRD3IvsJuH23yX7pB3cK2Qeqb
         qiQ2GWXMIsZGiny103b3zQWVdMfqmHRa8tKO72XOJGxz5AasA8mcCdII/cN0iWz/GXAC
         59FQ==
X-Gm-Message-State: AOJu0YydA3RpXD0S1/4blNxJAlc6ysz5y9yf96CQKivPkoaNgn2nDgC3
        +gb0nI1i1tXT/TttM6p0h0a91g==
X-Google-Smtp-Source: AGHT+IFThnnzT+oJdgMufKxYNUWxEEEv0x9joP7CgeWVHgINJI/Vzi8Ek8niFS6PfGRnZJVwbmmSYg==
X-Received: by 2002:a05:651c:211d:b0:2bf:e61b:c980 with SMTP id a29-20020a05651c211d00b002bfe61bc980mr6172749ljq.8.1697990495328;
        Sun, 22 Oct 2023 09:01:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b0040775fd5bf9sm7345301wmq.0.2023.10.22.09.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 09:01:34 -0700 (PDT)
Message-ID: <3d465d3c-386d-467b-87e9-806962464ac5@linaro.org>
Date:   Sun, 22 Oct 2023 18:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/8] media: dt-bindings: wave5: add Chips&Media 521c
 codec IP support
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
 <20230929-wave5_v13_media_master-v13-6-5ac60ccbf2ce@collabora.com>
 <b94e3561-f5ef-443f-98c7-9b79a8bbceec@linaro.org>
 <20231016134720.GA2650973-robh@kernel.org>
 <20231021120526.eqe3esyxyi5b3e5d@basti-XPS-13-9310>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231021120526.eqe3esyxyi5b3e5d@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2023 14:05, Sebastian Fricke wrote:
> Hey Rob and Krzysztof,
> 
> On 16.10.2023 08:47, Rob Herring wrote:
>> On Thu, Oct 12, 2023 at 03:24:12PM +0200, Krzysztof Kozlowski wrote:
>>> On 12/10/2023 13:01, Sebastian Fricke wrote:
>>>> From: Robert Beckett <bob.beckett@collabora.com>
>>>>
>>>> Add bindings for the chips&media wave5 codec driver
>>>>
>>>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>>> ---
>>>>  .../devicetree/bindings/media/cnm,wave5.yaml       | 60 ++++++++++++++++++++++
>>>>  1 file changed, 60 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/media/cnm,wave5.yaml b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
>>>> new file mode 100644
>>>> index 000000000000..b31d34aec05b
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
>>>> @@ -0,0 +1,60 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/media/cnm,wave5.yaml#
>>>
>>> Filename matching compatible, so: cnm,cm521c-vpu.yaml
> 
> With which compatible should the filename match? (see below)
> And just to be sure, this means that I rename the file to:
> `.../devicetree/bindings/media/cnm,wave521c.yaml`

With the fallback compatible.

> 
>>>
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Chips&Media Wave 5 Series multi-standard codec IP
>>>> +
>>>> +maintainers:
>>>> +  - Nas Chung <nas.chung@chipsnmedia.com>
>>>> +  - Jackson Lee <jackson.lee@chipsnmedia.com>
>>>> +
>>>> +description:
>>>> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - cnm,cm521c-vpu
>>>
>>> Can this device be anything else? Why VPU suffix?
>>
>> It needs an SoC specific compatible (TI something...) as well (or
>> instead). Unless there's a public spec with details on how many
>> clocks, resets, interrupts, etc. there are.
> 
> Okay so how about this, a bit similar to the Coda driver supplying both
> a general option and a SoC specific version:

Can generic compatible be used alone in board designs? If it is licensed
block, then most likely you want a fallback.

> 
> properties:
>    compatible:
>      enum:
>        - ti,k3-j721sX-wave521c
>        - cnm,wave521c
> 
> (ti,k3-j721sX-wave521c = manufacturer,SoC-codec)
> (tested on j721s2 but should work on other variations as well)
> 
> Another alternative could be: ti,k3-wave521c (less specific on a single
> SoC series but connected to a bigger range of devices)

Best regards,
Krzysztof


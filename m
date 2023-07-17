Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110BC756D91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGQTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:45:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A1D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:45:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so6617260a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689623121; x=1692215121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1S5yFcn7XaVnH1NB6zBxrj5DGFzqHNVY6eSAQKHA3c=;
        b=GjIoeLRCs7hLCzRDWXOKkVLtdm6sw/OZSIr2O5Ymv0U6HyTY+sMkelAW+dPBP/p3lm
         COR5sqbBU25CkNaxn/s1qOxver9CowDMtiP3T9VyD25r21pvc0a5OeBAgLNLk05oxhFk
         2H6rj0HApRZyZkTK+9NtZwa3qkhiQLsfrX3ko1P80F4EhSkwz0PkNUOTx8TDJhDCoRbg
         iVjxXFpYUjRgwSSfqxxbDofBqhWvjxuSsXblZoMe/LBzvuMMuJA1Y2/GiHplh176bmal
         qdG5x/9MJaQNhyQHJsZqQ2DbRZ4BNkRSdo43ggufFqAvfBiTvx7INWvqzeAi//CyYlvY
         QvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623121; x=1692215121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1S5yFcn7XaVnH1NB6zBxrj5DGFzqHNVY6eSAQKHA3c=;
        b=CbPTWD9XB3TwcYskhyrR/qBp1ppqJFmhtFenXyBGu0e1lMkJDjQmRl3pkKr2RP/M5I
         A8SrOBllEy+pidItaP3mMuB2xXYJ4MOGRH6SrZZRbJQmoJ/RBNFKo3I0RIXbF2MDe74Z
         7po18a6j4lXMoFVYmhBF8tRWyfvzWyxyA62lDcRlcGkO/+GV3946HQYiqk8SmondDFJ+
         4mo40Ex56zimD++1AOylYVi4VXXVUHVKoZp70fRBPbssdseMAU9RoRZAijP3VD5ovI/+
         ZOs019tHxwd66UBxA9p0xcNhvKclP/RvtHRYc46bRpInw3KECrqyPyDQSMYTeRFK6Sgk
         0mUQ==
X-Gm-Message-State: ABy/qLb+15FcaF6wM702oR0cpEKAlew+uxD/Lp/slBkkLtLFXy+/CGc3
        5/nvgtSEhOrO0tLZpqM/2erHag==
X-Google-Smtp-Source: APBJJlHBVSrjPfzkbaAp2AaxOr8sQghVbFPvPQLd+hzc5Dv+QGQEUNSA8Inotoqe5CLFf2iaXp5CzA==
X-Received: by 2002:a05:6402:74d:b0:51e:2d16:8473 with SMTP id p13-20020a056402074d00b0051e2d168473mr14156275edy.36.1689623121199;
        Mon, 17 Jul 2023 12:45:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7d6cb000000b0051e0bf5807bsm57722edr.49.2023.07.17.12.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:45:20 -0700 (PDT)
Message-ID: <a9665eb0-f63b-dbbb-c52c-5f3c05b10446@linaro.org>
Date:   Mon, 17 Jul 2023 21:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: fsl: fix DEBIX binding
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-2-m.felsch@pengutronix.de>
 <22d68e14-5198-59ce-44cc-37e9ff5e367c@linaro.org>
 <20230717171423.tf5i7hhjl5thoye7@pengutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717171423.tf5i7hhjl5thoye7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 19:14, Marco Felsch wrote:
> On 23-07-17, Krzysztof Kozlowski wrote:
>> On 17/07/2023 18:51, Marco Felsch wrote:
>>> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
>>> corresponding bindings by adding an own entry for it. Mark
>>> polyhex,imx8mp-debix as deprecated but keep it within the dts file since
>>> we already have a user for it [1].
>>>
>>> [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
>>>     boards/polyhex-debix/board.c#L38
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>
>> Subject: fix is too generic and binding is redundant. You already state
>> this is binding in your prefix. Describe more precise what you are doing.
>>
>>> ---
>>> Changelog:
>>>
>>> v2:
>>> - deprecate polyhex,imx8mp-debix
>>>
>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index 15d4110840654..b29974e3c30b3 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -1019,8 +1019,6 @@ properties:
>>>                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
>>>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
>>>                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
>>> -              - polyhex,imx8mp-debix      # Polyhex Debix boards
>>> -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
>>>                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
>>>                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
>>>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
>>> @@ -1054,6 +1052,14 @@ properties:
>>>            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
>>>            - const: fsl,imx8mp
>>>  
>>> +      - description: Polyhex DEBIX i.MX8MP based SBCs
>>> +        items:
>>> +          - enum:
>>> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
>>> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
>>> +            deprecated: true
>>> +          - const: fsl,imx8mp
>>
>> That's not how it works and it does not look like you tested the DTS

Actually this could pass the test because this is used by DTS. Quite
surprising.

>> against bindings. Please run `make dtbs_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>>
>> Don't deprecate some piece of entire compatible list, but entire list.
>>
>> The commit which deprecates compatible should bring a proper one.
> 
> What did you mean by that?

Exactly what I wrote below:

> 
> Regards,
>   Marco
> 
>> Otherwise at this point we have kernel only with deprecated compatibles.

You now have kernel without proper compatible, because it is deprecated.



Best regards,
Krzysztof


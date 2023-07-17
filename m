Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB3756DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGQTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGQTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:51:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E0DD3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:51:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso6886853a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689623476; x=1692215476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GRG9iOP216h8hNkp80ef+cG8Pcq3A3Xo2N0WkZohN4=;
        b=WBKLVtSP2hwmqIJUbeUHRx90hA/4c13UDgRDiVJX62+IGwK1XVtu+iAslMRnlP2KQu
         2pqZF55bUL9+y/82EQcyV2ZpNd3lQhvT/994ZMo1HyFeoT8Cw9MJwxGe25M8anm3eflr
         4IFEMwSyw+SfyRZzMnZTdewQSq6CplcsoN46VU8t2oHKAoBIsGqzDJCagebKSfyHRRHQ
         baqNnxE6pcAcq43PAwkLQfTsAwdn38zMOx+4S0+j1D6fwrXSpn9ehROLyAQK/Ss0rtsY
         w5tpxc9EFzwLuTOO3n1+wZvTzj92kYIhMs1MbzU3/opKsn2suPZPs0dEoNhNawHMtEWv
         fr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623476; x=1692215476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GRG9iOP216h8hNkp80ef+cG8Pcq3A3Xo2N0WkZohN4=;
        b=IWnv42m+EzmzXF2AbykNbjuPCSVCF457NjnlNdd0IwMa2dUDmNOZptY4fP7vYb3j2e
         XMFRXKMtdE8FPpCJQE4pyCcXdtGz5S2WEaL6llCuboaKGQnG6IUIQDTl6RA111C633sW
         PMI+IPRVuNwHpfCmNpMVeeKJNR0S/oV324maa02j1b7E9RBxuuBobBUUAgqEGceqjsp0
         G9dizblO5Z4kiLILYRYhZu+XBMUFvD6t1icOnu7pQKvkycDj7BS+qRU0U9hWFopz+yfn
         KZjcMm/6CxJpxfIif9ajyjc0eVdR2MTWkTQ2xZRv/FntNyPxeM8YOyzY6i4ng43ZUWUP
         /pSw==
X-Gm-Message-State: ABy/qLa6s0uHUmwl+Grpp0N3gG2ORi2FiDuBiP2X9g9GlZylMjxZk8XE
        xHrNyXexJdvVqKAY5E/V27kqzDzFeh7g/8tc3RAt4g==
X-Google-Smtp-Source: APBJJlEuwYvgVCvNXuxA5VjmKkQFBRHYrK+aCkoCeJFej7viXoOkOWaFHp4rCXYYqDysObD2DLg28A==
X-Received: by 2002:aa7:c709:0:b0:51a:7bcd:a82d with SMTP id i9-20020aa7c709000000b0051a7bcda82dmr11838765edq.23.1689623476573;
        Mon, 17 Jul 2023 12:51:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ccc5000000b0051a1ef536c9sm57733edt.64.2023.07.17.12.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:51:15 -0700 (PDT)
Message-ID: <152926f2-3c53-d788-9443-486fb5ed8024@linaro.org>
Date:   Mon, 17 Jul 2023 21:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-2-m.felsch@pengutronix.de>
 <3d1a260c-bc8c-6347-17be-5558343c85a4@linaro.org>
 <20230717171244.jdqwn5l7tiugxeyo@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717171244.jdqwn5l7tiugxeyo@pengutronix.de>
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

On 17/07/2023 19:12, Marco Felsch wrote:
> On 23-07-17, Krzysztof Kozlowski wrote:
>> On 17/07/2023 18:51, Marco Felsch wrote:
>>> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
>>> corresponding bindings by adding an own entry for it. Mark
>>> polyhex,imx8mp-debix as deprecated but keep it within the dts file since
>>> we already have a user for it [1].
>>>
>>> [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
>>>     boards/polyhex-debix/board.c#L38

Don't wrap links, they are not clickable.

>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
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
>>
>> I cannot find patches which add new compatible to the binding and which
>> fix the DTS. :/
> 
> Please see my commit message, we can't remove the compatible since we
> already have one user of this compatible.


Indeed. I wonder then what is the goal of deprecating this compatible
and what is the plan for dealing with it? There is no cover letter which
would point me to it.

Best regards,
Krzysztof


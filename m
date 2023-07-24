Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832DD75EC50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGXHQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGXHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:16:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D9290
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:16:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso5935239e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690182972; x=1690787772;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJjiLpTiLcLmlDY6EXYdVhyrOy6hWSuU/gTL98LQWAs=;
        b=Gd24sNIj0oDtV+j8vvlaIzwzpX5g16e5B0su1m38z5Eh4/ymC4AQyHc4iOL5GSnsKg
         qqh/KFLB2/ApPKkloUyObuj40XmZRV7Bho4iuxDzwtmNeVG3NtBWe7vYy3Y+VWEcZwLL
         kb7deTAzE3D6/yorBkWrFraCGa0GTCTaXK11D1S2Y7uwJKARNr8LfXmUpUuIcwFYSikR
         dq2WhX0ZRnoGaV2qXPozC5zF2vF2fBRPS8r4wgOgTrhTZXZeYRpyQoE8kSRut4Y1DZM6
         JPFRwhRmXz3Ih+rUTUNRvXegagbcIBRLq+09CAKjRFeGIa6wiBiv/ErzETd/AHJpSoBc
         drig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690182972; x=1690787772;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJjiLpTiLcLmlDY6EXYdVhyrOy6hWSuU/gTL98LQWAs=;
        b=jXN+gswVJxVmbVXi0Rq/opyINSIdX15mghT8amgzZgRZTqeyXeMjn5QNUH9KMoINxr
         IwaWuI/SKdrpDs295ZPm/cord+E/7aOlc2UaiAdgWirvDslDhMFk+Gra6kIjQJK9WKqN
         Xuy140O4sYvIyfm+KQ9aBtl1yfij7ceoKF+I67fH+glcColnOze4bmEAzJCP1GD9PtVG
         hj5nKF+/J5rdJ46E/Aivp1MOIfJ4zIHGm4ZB29VUUNEqDWO7ZQy5LfQ21drQlPmnJl7A
         VqNUFKUWG17Fj3zQxlOAjjxparY9X4574n/ud3i4EEDTjp5eIxSc5+sP01y26Xac80mz
         jQlw==
X-Gm-Message-State: ABy/qLZsFnMUT4jZIz+AlIjfcEGvVKpzX7MmkpminraKj4lCT0tGjNyD
        IDqm6nI3Cg4UJzptzW3pLeES8w==
X-Google-Smtp-Source: APBJJlHFEusndSawbs0I417rvOGJ25UK9yb415P0WNw1Hwu1JevZtKCiq9KD/FsQvDX2NH7fwJ7rgA==
X-Received: by 2002:ac2:4d96:0:b0:4fd:d172:fc2c with SMTP id g22-20020ac24d96000000b004fdd172fc2cmr4036921lfe.21.1690182972321;
        Mon, 24 Jul 2023 00:16:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b1-20020a05640202c100b0051e06693590sm5708715edx.91.2023.07.24.00.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 00:16:11 -0700 (PDT)
Message-ID: <ab767c7e-27f2-061c-fb3a-6566e72f3e63@linaro.org>
Date:   Mon, 24 Jul 2023 09:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw binding
 doc
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-2-pankaj.gupta@nxp.com>
 <f3965cf1-3f0a-15fe-7dd3-e83817a4ba3a@linaro.org>
 <DU2PR04MB863034F3609C9878D2DA5F029502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU2PR04MB863034F3609C9878D2DA5F029502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
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

On 24/07/2023 08:37, Pankaj Gupta wrote:
>>> +examples:
>>> +  - |
>>> +    ele_mu: ele_mu {
>>
>> No underscores in node names, generic node names, e.g. firmware. Look at
>> existing code.
> 
> Changed from:
> -  ele_mu to ele-mu.
> - "ele_mu {" to "se-fw {"

Still not generic. Why do you change it twice? You understand I talk
here about node name?


> 
> Name of yaml file, is se-fw.yaml.
> 
>>
>>> +      compatible = "fsl,imx93-ele";
>>> +      mbox-names = "tx", "rx";
>>> +      mboxes = <&s4muap 2 0
>>> +                &s4muap 3 0>;
>>
>> Two items, not one.
> 
> Corrected it to "mboxes= = <&s4muap 2 0 &s4muap 3 0>;"
> 
>>
>>> +      fsl,mu-did = <1>;
>>> +      fsl,mu-id = <1>;
>>> +    };
>>
>> Plus you clearly did not test the binding and DTS. You said you did some
>> internal review, so I assume this also includes some testing. How did you test
>> your DTS?
>>
> 
> Each version is tested before sent for review here.
> I have tested the DTS file by compiling it and loading the DTB to the board.
> Executed test on the board. 

That's not enough and your colleagues should tell you that... Read our
guides for bindings.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.


Best regards,
Krzysztof


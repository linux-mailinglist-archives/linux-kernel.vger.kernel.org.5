Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25F1781FEB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjHTUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 16:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjHTUiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:38:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA349CE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:33:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9936b3d0286so360080366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692563595; x=1693168395;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEeP1FBLnBDJFadl/8z1r2UI/A7lTke2Ykdg5ppE0XU=;
        b=PNFR65hfsIQJDEu2NTLTCWm8XJzLbb4fr4XQ2ED41tQBAYa70iS50JSCXDRbcimtoN
         nw1/bqB78snJNI2XNAAQ8sPnRi4NAIRvTo9JozB4EanTVAeR2MqlC3SHdYlRfggyxuw0
         V8MEdAvxp0oe+dUeETYp7HvhgbezsAg9wqlrlaeAtBcXe7Ef430Khz1GJioLWto/17Un
         CxUdPdNMUhfnwjHB/DjWkzOXggTgVIOuAfxhkXRKK8uokuEj5JsxSO5fCV6rZfltLLAl
         9QLoxbB6V4czj0xHmmw2ER8FYYdGuXCy5DbYFl1Hn+z39xBXg7MUWITiR0JFt7xQC5GH
         beZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692563595; x=1693168395;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEeP1FBLnBDJFadl/8z1r2UI/A7lTke2Ykdg5ppE0XU=;
        b=Hnw1L/DCBXrQ1qvsI/4Ig24Wmd4+PuoL3QyMpa3LuKtUNCN55fsd95a5kzssxrHyVA
         RVfAjYOeKDML5YiZeu5I/0SMVS94vcLJS8UEDtTXV/YwSssL4QPnxYXVO1OZ46uX8bQ9
         zCT2cn2BAXv8RNlp4ISNp1VGwghOJOVg4/XkDlHqkfrVTDuYU+qHNzrnx2140v9vxJfo
         9VKUQlKWjMPz3m4WnNrMerxMwyfhG3ePiIv/Z8LNuBKb9iWttISTPnxQBcgf5TFN5vHK
         ip8E59URNwBZkXsDw2r7TZY8x0Du9YU0Ub+MGfV6vZab8RyNejpJCN9OonE5/8XeVXUr
         2QAA==
X-Gm-Message-State: AOJu0Yyy81FTd319w+Vo/ENgqKfyfI1Y5bkZ6MVahWJAipmbFYnKUrQW
        Fwx/zxT5Zl0mbM2nnFRa8u8t/A==
X-Google-Smtp-Source: AGHT+IE+vcupZ0WTHAPVWiHnLpzPaCRcD2vfiaEE9k6DuD3H4k5UJj/l+1dARFQGX9/QEHdMwHeY+A==
X-Received: by 2002:a17:906:319a:b0:9a1:697e:4bb2 with SMTP id 26-20020a170906319a00b009a1697e4bb2mr3940826ejy.69.1692563595025;
        Sun, 20 Aug 2023 13:33:15 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906134600b00992d70f8078sm5241599ejb.106.2023.08.20.13.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 13:33:14 -0700 (PDT)
Message-ID: <6089b46d-a580-af52-0cac-84b46fe11e6c@linaro.org>
Date:   Sun, 20 Aug 2023 22:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl_easrc: Add support for
 imx8mp-easrc
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230820175655.206723-1-aford173@gmail.com>
 <f5b16676-04b9-7864-ffa7-1c48f3c2ca9c@linaro.org>
In-Reply-To: <f5b16676-04b9-7864-ffa7-1c48f3c2ca9c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 22:32, Krzysztof Kozlowski wrote:
> On 20/08/2023 19:56, Adam Ford wrote:
>> The i.MX8MP appears to have the same easrc support as the Nano, so
>> add imx8mp as an option with a fallback to imx8mn.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>
>> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
>> index bdde68a1059c..2d53b3b10f2c 100644
>> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
>> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
>> @@ -14,7 +14,11 @@ properties:
>>      pattern: "^easrc@.*"
>>  
>>    compatible:
>> -    const: fsl,imx8mn-easrc
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - fsl,imx8mp-easrc
>> +          - const: fsl,imx8mn-easrc
> 
> You need here also const for fsl,imx8mn-easrc, otherwise you do not
> allow it alone. Test it for fsl,imx8mn-easrc DTS - you will notice warnings.

Actually, I see now Rob's report... you did not have to test DTS even.
It was enough to test your change and this test was missing :(. Please
test your changes before sending.

Best regards,
Krzysztof


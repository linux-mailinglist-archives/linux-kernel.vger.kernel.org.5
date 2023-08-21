Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00610782384
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjHUGS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjHUGS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:18:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F15A2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:18:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3493050a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692598704; x=1693203504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7X2osa/VnJsVrrnV+a+hds4KQ1gcHyl9bFLWZVEWtI=;
        b=D/o0UHsX5R8srkJXZRmBstQyp7M7eRQLI402ny9OwP0Pre/30ybADkVCJ/3Y6DdKHj
         Y85YUkT+t9+2TqyGpy6D0rSaroxijblDV+f21G8Li7ZOAXfPLhLKGQMPZZBDVUlxThva
         pJegViJ2q+XbWSX2XVYZQjSw7PCEcTV0EkrfkC/sIloIbMyyeQ3qsMYTpII8bIwOlGtj
         MUTF3yGTkT8yXLV+D7bkJyo5Lj5kEybteySfYNVYhkfRXfviM836EItXzkEGnCs6iz4L
         eblhA9hBf0SLbyT9iZ+oezluVGb9qkk3XXrWKjZ4r2S3MaHxt7OOKuZj90YKOTS6jDSK
         wTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692598704; x=1693203504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7X2osa/VnJsVrrnV+a+hds4KQ1gcHyl9bFLWZVEWtI=;
        b=Jm30IQKo7FCSZjKUg0GqvAqaesA/KzJyAT4h89vEPPb1pF0C6HYy4md1gXSpQ8FeDU
         r1n8bdd9WH+MbJ8cBLb/4dojCk7UL4G5lfq2wp79p/clKnfnyNiy95gpBoIFvGHhPrRG
         3ExthIL9kne7/iqPtJkC4b9D5X6fruW0HYgwzJeztb4HrcSygP6laG/nu3ofFIj6BTF2
         SNPT7SbwuJhoaFp3YM4fjCoAxDkMChPM8eCOoRZ+I6X1335RK+3gIZLxjotQbt2YlPmB
         CF0GOl1YiFUdvudB2oPLaYi8+i5OKD6ti02TqSQ8cTgy7fHoG69fvVO3cn11fyP06QWy
         VjHA==
X-Gm-Message-State: AOJu0YxkAIyx+zK49inxKkUBSpwLBDXd8t7bbxAjHnLAs7W6aJgPkQ7W
        4wW4seSQ/pyq2tKDQNpfR7w3A+KhSvm6OoTWyaM=
X-Google-Smtp-Source: AGHT+IHwSmx3yGxzilGgKDgibpDPl9dnNP4Fi5wj6jsC6TQOc4RIljouOMWV2EZwX4pqw3kPczpfOQ==
X-Received: by 2002:a05:6402:510:b0:522:2111:1063 with SMTP id m16-20020a056402051000b0052221111063mr3944431edv.18.1692598704177;
        Sun, 20 Aug 2023 23:18:24 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id j5-20020aa7c405000000b005232e637c24sm5475336edq.84.2023.08.20.23.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 23:18:23 -0700 (PDT)
Message-ID: <9cd15a97-7479-bb2b-9b47-8702b1e20e52@linaro.org>
Date:   Mon, 21 Aug 2023 08:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl_easrc: Add support for
 imx8mp-easrc
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Liam Girdwood <lgirdwood@gmail.com>,
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
 <6089b46d-a580-af52-0cac-84b46fe11e6c@linaro.org>
 <CAHCN7xJyOjKSXbm17roAJDbk-gDKQHprE9t1d4VH2uYSMZcEDg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAHCN7xJyOjKSXbm17roAJDbk-gDKQHprE9t1d4VH2uYSMZcEDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 23:05, Adam Ford wrote:
> On Sun, Aug 20, 2023 at 3:33 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/08/2023 22:32, Krzysztof Kozlowski wrote:
>>> On 20/08/2023 19:56, Adam Ford wrote:
>>>> The i.MX8MP appears to have the same easrc support as the Nano, so
>>>> add imx8mp as an option with a fallback to imx8mn.
>>>>
>>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
>>>> index bdde68a1059c..2d53b3b10f2c 100644
>>>> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
>>>> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
>>>> @@ -14,7 +14,11 @@ properties:
>>>>      pattern: "^easrc@.*"
>>>>
>>>>    compatible:
>>>> -    const: fsl,imx8mn-easrc
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - enum:
>>>> +              - fsl,imx8mp-easrc
>>>> +          - const: fsl,imx8mn-easrc
>>>
>>> You need here also const for fsl,imx8mn-easrc, otherwise you do not
>>> allow it alone. Test it for fsl,imx8mn-easrc DTS - you will notice warnings.
>>
>> Actually, I see now Rob's report... you did not have to test DTS even.
>> It was enough to test your change and this test was missing :(. Please
>> test your changes before sending.
> 
> For what it's worth, I did run 'make dt_binding_check', but I didn't
> run it with the extra flags from Rob's e-mail.  The tool didn't return
> any errors.

OK, indeed without the additional flags the example from that binding
won't be reported as undocumented compatible.

Best regards,
Krzysztof


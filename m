Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB763756241
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGQMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGQMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:02:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11802A6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:02:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9922d6f003cso623797166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689595362; x=1692187362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRFjTGIuTQBbKcSIQn8byEVfc3e2ikK3CXB/ejmFCFA=;
        b=ydU4CX/8SVEai1MTilT8mOjNohD1OBoFm/18vOFFl3jG+sqQ2Q5UvAgkHfwu7Bq9Z9
         +q+a0AFTgVkeT7jiHfpZWSvqecTIdkokG3izhDDxvuUyMY6v5TmCIGiTlKOcj24K7crp
         6U6mPFf5b7BOEF+c9Ztv7efBRrx+YxhzNams8iDzSQC5KdGvguCV8fOwqQOTR3ZpunOq
         phiiRICQj46zmUez6XvPj/0xG316MZFxllPGPkdXulwT47InydIb2YZGtfMGyFeyGL+X
         efadqVmH7gXuwMmBAdL99dGaKxkA2X5EhqZ5blhLyzNNn+S5nS9fDfGmyf21eBPwiGVK
         rqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689595362; x=1692187362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRFjTGIuTQBbKcSIQn8byEVfc3e2ikK3CXB/ejmFCFA=;
        b=GV86rjW0lguN3apY5oMZxMQ89BSuSr1cZq17Pkag84v3nRNJvdMbRAYT4+4bWUWo7y
         4825bIMrgnDpf3GGlZEVLNgMK7u6ctClaWSDLjCgiFX46qBsY74YG29xmmdgK1tn8ugi
         To0wgxY81mpJM6QXjhBtH5V4+2Cg2V1Vozb8mL78Ljkp+OKs84UZxHARqBguigk9xraH
         ytYtO0bXSX4xmgIs3wZjDqGNKV5KpzwI8pDCttIckoGh0sFEeZYgvI4it1ximGRqELBr
         1u96zxKwcxyuJ2Od+pKOzGV3q2C6huatqUe+YkatxmDrOK0gDtCQ40viecvy4lH0HnDx
         1Yyw==
X-Gm-Message-State: ABy/qLarf2FXjBMf9NBk8u2MSuxyps2k0alQD+SQtpDd7A4TyBBCyofb
        iwNpBZA3CltXI7D50bTyj7Xj8w==
X-Google-Smtp-Source: APBJJlH5grcbHbGAa4eOIaUofJ1AqLDmGg/hsJthhlRzPFpAwiFBB/N+fD4nsO1NJDB5l/IvGB3bww==
X-Received: by 2002:a17:906:58:b0:994:1fd2:cf96 with SMTP id 24-20020a170906005800b009941fd2cf96mr11662668ejg.0.1689595362522;
        Mon, 17 Jul 2023 05:02:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id mj6-20020a170906af8600b00988781076e2sm9140186ejb.78.2023.07.17.05.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 05:02:41 -0700 (PDT)
Message-ID: <e7c3bb1d-3694-7aa6-901f-47aadda18a20@linaro.org>
Date:   Mon, 17 Jul 2023 14:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: dwc2: combine platform specific data for Intel
 Agilex and Stratix10
To:     "Li, Meng" <Meng.Li@windriver.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230717085053.1075077-1-Meng.Li@windriver.com>
 <9a3dc092-7278-cda1-cd4e-c157e0e2c431@linaro.org>
 <PH0PR11MB5191AA947AAE954FF2169FCCF13BA@PH0PR11MB5191.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB5191AA947AAE954FF2169FCCF13BA@PH0PR11MB5191.namprd11.prod.outlook.com>
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

On 17/07/2023 12:13, Li, Meng wrote:
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml
>>> b/Documentation/devicetree/bindings/usb/dwc2.yaml
>>> index dc4988c0009c..c98ca98d5033 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
>>> @@ -51,6 +51,7 @@ properties:
>>>                - amlogic,meson-gxbb-usb
>>>                - amlogic,meson-g12a-usb
>>>                - intel,socfpga-agilex-hsotg
>>> +              - intel,socfpga-hsotg
>>
>> Where is SoC specific compatible?
>>
> 
> The socfpga is a SoC family, it includes Agilex ad Stratix10 SoCs.
> In fact, we only need the compatible " intel,socfpga-hsotg " is enough.

You now confuse driver and bindings compatibles...


https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

> But in order to avoid breaking the old device tree for agilex platform, I reserve the old compatible.
> So, I think we don't need the Stratix10 compatible like "intel,socfpga-stratix10-hsotg "

You need. See above link.

> 
>>>            - const: snps,dwc2
>>>        - const: amcc,dwc-otg
>>>        - const: apm,apm82181-dwc-otg
>>> @@ -64,6 +65,7 @@ properties:
>>>            - const: snps,dwc2
>>>        - const: samsung,s3c6400-hsotg
>>>        - const: intel,socfpga-agilex-hsotg
>>> +      - const: intel,socfpga-hsotg
>>>
>>>    reg:
>>>      maxItems: 1
>>> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>> b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>> index ea788a920eab..c5a51636f657 100644
>>> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>
>> ...
>>
>>> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
>>> index 8eab5f38b110..6bb27a24e9e1 100644
>>> --- a/drivers/usb/dwc2/params.c
>>> +++ b/drivers/usb/dwc2/params.c
>>> @@ -93,7 +93,7 @@ static void dwc2_set_s3c6400_params(struct
>> dwc2_hsotg *hsotg)
>>>       p->phy_utmi_width = 8;
>>>  }
>>>
>>> -static void dwc2_set_socfpga_agilex_params(struct dwc2_hsotg *hsotg)
>>> +static void dwc2_set_socfpga_params(struct dwc2_hsotg *hsotg)
>>
>> Why? Old name was ok...
>>
> 
> Old name includes string "agilex" that represents only agilex SoC.

No, old name was representing the first compatibility chip.

> This patch is used to combine platform specific data for Intel Agilex and Stratix10, so create a common function name for socfpga family.

And what is wrong with using the previous one? No, don't do this. It
brings no benefits.

> 
>>>  {
>>>       struct dwc2_core_params *p = &hsotg->params;
>>>
>>> @@ -266,7 +266,9 @@ const struct of_device_id dwc2_of_match_table[] = {
>>>       { .compatible = "st,stm32mp15-hsotg",
>>>         .data = dwc2_set_stm32mp15_hsotg_params },
>>>       { .compatible = "intel,socfpga-agilex-hsotg",
>>> -       .data = dwc2_set_socfpga_agilex_params },
>>> +       .data = dwc2_set_socfpga_params },
>>> +     { .compatible = "intel,socfpga-hsotg",
>>> +       .data = dwc2_set_socfpga_params },
>>
>> Aren't they compatible? Why do you need new entry for compatible devices?
>>
> 
> In fact, the usb IP in Agilex and Sratix10 are the same. 

So you do not need new entry. Don't add it.

> But it is not reasonable to use agilex compatible string "intel,socfpga-agilex-hsotg" in Stratix10 dts files.

Why? Why you impose some rule which is different than all other SoCs in
upstream? Why do I have to repeat it every now and then.... ehhh :(

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42


> So, I create a common function name and compatible string for socfpga family that includes Agilex and Stratix10 SoCs.

Nope, sorry.

Best regards,
Krzysztof


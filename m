Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7070F7819A5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjHSNHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHSNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:07:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760961E2F0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:06:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99cdb0fd093so240424666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692450400; x=1693055200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHDDd/fo4FzFy4JxsCF4FnZo7ypY9WWX/ip25zUd2DE=;
        b=TS2k2khJrVzHYVVoqjpw36ahhdErsQv8ZsZr3TdH8KKu1CLB4CsNyMSgpy737ci+Sv
         q+KrpKd/uCNWMwakXLpOz67RuTA1AKVl4DzaHdPEP756WrixnLBydXfaC5MykNz5vBeO
         w32gFm4WPSTn/15QpKpq3iWb65M1BoOm7UWfMxV3PpySJyUewKJ61BcgnMMS35zg+XLb
         mb48D/R7GRYFegb750WN+He+C6cn/FBMw2G6IxsMzI8v6OgyEbdMwo7SHbj+7furDB9m
         Cs64hn14OGl40GqMUgThUp40Qq8We4GFPiZP4g36vLwcwruU0Pq5M7tveBET+yLmZyRC
         Pyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692450400; x=1693055200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHDDd/fo4FzFy4JxsCF4FnZo7ypY9WWX/ip25zUd2DE=;
        b=fzHwHag1HZPxIzx0labu/rUQWoxR9xHgGmcrtynedwmV3oAeANkBaEvg0DBJOZdD8L
         4jrjpKIQDl9hcalROrz8G/6rY6XYqKCQtCOJriGldxdB1VLdvUcG7kMmKZCA8vsu5ZR4
         4egzJhyiJWzSbpl22DeHG4vw9EicZG2LiR0LzwU+uqsLaud1Ko7F8j831ADVz3cx7lct
         vJyAAlQKDQLzMqpl09h/LYFpxGB4LuSW8EORRWR/GjQCPSYUwfPocKYCqjecyjAON1Ra
         dNKXgZCrMPvna5dY8rNBcN91IWXo70pHi60BDmGLxxmL+lhNOJnop8Hl2lrLoKiLDNP8
         coQQ==
X-Gm-Message-State: AOJu0YwZmM7dXpLyFTDU73DwAugs9q0LIBmfn/lphSaV7EEdaRkzjRj+
        nSyXuR8f31VWslhWOCc02NE2CQ==
X-Google-Smtp-Source: AGHT+IFmIuGKAoOzk4W6WrGdbIVA9nfaf1Vt+Us6IpXHHQEoV0jgC2iViYKTYGpTLxfiNXcnvSBOHQ==
X-Received: by 2002:a17:906:76d8:b0:982:c8d0:683f with SMTP id q24-20020a17090676d800b00982c8d0683fmr1528256ejn.18.1692450400016;
        Sat, 19 Aug 2023 06:06:40 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090606c800b0099d959f9536sm2747401ejb.12.2023.08.19.06.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 06:06:39 -0700 (PDT)
Message-ID: <2de9f105-c785-4933-4a0f-c8bc73c63b87@linaro.org>
Date:   Sat, 19 Aug 2023 15:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC v2 1/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
Content-Language: en-US
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
 <20230724-th1520-emmc-v2-1-132ed2e2171e@baylibre.com>
 <ca0b9a19-d7d7-80e5-f47e-f74615cdac86@linaro.org> <ZN1NBE2+HHfatQ/T@x1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZN1NBE2+HHfatQ/T@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 00:26, Drew Fustini wrote:
> On Mon, Aug 07, 2023 at 08:29:21AM +0200, Krzysztof Kozlowski wrote:
>> On 05/08/2023 05:14, Drew Fustini wrote:
>>> Add compatible value for the T-Head TH1520 dwcmshc controller and
>>> thead,io-fixed-1v8 and thead,pull-up properties.
>>>
>>> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> index a43eb837f8da..57602c345cab 100644
>>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> @@ -19,6 +19,7 @@ properties:
>>>        - rockchip,rk3568-dwcmshc
>>>        - rockchip,rk3588-dwcmshc
>>>        - snps,dwcmshc-sdhci
>>> +      - thead,th1520-dwcmshc
>>>  
>>>    reg:
>>>      maxItems: 1
>>> @@ -60,6 +61,14 @@ properties:
>>>      description: Specify the number of delay for tx sampling.
>>>      $ref: /schemas/types.yaml#/definitions/uint8
>>>  
>>> +  thead,io-fixed-1v8:
>>> +    description: SoC PHY pad is fixed 1.8V
>>> +    type: boolean
>>
>> Isn't this duplicating existing properties for MMC modes with 1.8 V?
> 
> Thank you for reviewing. Yes, now that you mention it, I do see those
> properties now in mmc-controller.yaml. It seems like the existing
> mmc-ddr-1_8v property would be appropriate.
> 
>>
>>> +
>>> +  thead,pull-up:
>>> +    description: True if pull-up, false if pull-down
>>
>> This explains me nothing. No clue what you are pulling and why do you
>> need it. Pin pulls should be done via pin controller, not MMC.
> 
> Good point that my description is not helpful. The pull-up property
> determines whether certain phy registers are written to. I need to try
> to can get documentation on the phy so that I can better understand the
> details of the pull-up configuration in the phy registers.
> 
>>
>> Anyway you should have here allOf:if:then (move the allOf: from top to
>> behind "required:") which will disallow these properties for other variants.
> 
> I noticed that nvidia,tegra20-sdhci.yaml has several lines related to
> pull-up/down configuration:
> 
> 218   - if:
> 219       properties:
> 220         compatible:
> 221           contains:
> 222             const: nvidia,tegra210-sdhci
> 223     then:
> 224       properties:
> 225         pinctrl-names:
> 226           oneOf:
> 227             - items:
> 228                 - const: sdmmc-3v3
> 229                   description: pad configuration for 3.3 V
> 230                 - const: sdmmc-1v8
> 231                   description: pad configuration for 1.8 V
> 232                 - const: sdmmc-3v3-drv
> 233                   description: pull-up/down configuration for 3.3 V
> 234                 - const: sdmmc-1v8-drv
> 235                   description: pull-up/down configuration for 1.8 V
> 236             - items:
> 237                 - const: sdmmc-3v3-drv
> 238                   description: pull-up/down configuration for 3.3 V
> 239                 - const: sdmmc-1v8-drv
> 240                   description: pull-up/down configuration for 1.8 V
> 241             - items:
> 242                 - const: sdmmc-1v8-drv
> 243                   description: pull-up/down configuration for 1.8 V
> 
> Do you think creating something like that would be a good approach?

This depends. Does your driver implementation will make use of it? If
yes, then it makes sense.

Best regards,
Krzysztof


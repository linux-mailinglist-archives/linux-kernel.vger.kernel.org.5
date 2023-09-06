Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6422793392
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbjIFCKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:10:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9CC3;
        Tue,  5 Sep 2023 19:10:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0db66af1bso16948965ad.2;
        Tue, 05 Sep 2023 19:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693966242; x=1694571042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGpPqAvRxHlO49Def4EkEw3YsTe5pPmN/itzaU5IvZg=;
        b=r8Iw2bXRU5OSpe5osl9bUZynt5TKdgfeGqQ7Q97gHrhDLskmwrMUzB7p1PuNplGMhi
         Lx9IqH2dAMQi486H0+BvfPIVkWRXW+DP6qHlJQIBz0gHLaOCAyLFikrOTN0xPMtuLvJH
         +e4F8aUehwKLWkkFEnVUdIovk4BshD73IJjuQm1eiBr3hrO5kzKfz+Iz2bD22n9ld+/e
         NFp1bjrqyhyO0grtwx+MwrTr5lrEvrf6ODoTAjpB96nhAuiouMu/hyYOi7N6rmP4P3cV
         28OcsTez9iEvvpUlV02b0hnO6vrH0ZAQZACSHOarsahX9XBdcgmnrugw/dYi8kT8K+Me
         xslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693966242; x=1694571042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGpPqAvRxHlO49Def4EkEw3YsTe5pPmN/itzaU5IvZg=;
        b=M6WTAL9vGBip1/xPqVJAMYOA6H79wxZDyZ5pd28cWjw09+o5pbD6u4wX59Y+vHV1DU
         FD83xV/DUKufjm1eKGFK2SZG84PeyS9ohg9ZxnsHfJlgIgjjSdncHojLWWXUqzNdJOCJ
         nvsucrIHcy30YPsmbe+0i1PRqByQAbisaau6ONRu/cerauVy2MKzZnlUMVwYGRyJSMhC
         zTE2KYewHDDREUDj4sxRrlsBSbSPVV++qb5mstI6cajvOnhlhRJnu2YKwQbltNKrBHrY
         CeSWhTjpPAKue5hkWt2NXPPVRR4u1LQLtNYt1gMCweb0QlfnVwommKOTgcEFL+RWW3l3
         djoQ==
X-Gm-Message-State: AOJu0YxRXOrIc0xJbQMhvzDRfZnaBVXRZgi7rA83w7H1FuQdbwoIbkb/
        B4Sh95iPUmPoXdEEXfgAK3h0M1cKqmpXNQ==
X-Google-Smtp-Source: AGHT+IEgV8v1lML7K5Idv9fbc1OQl1SVxmSAvxGgeshwDMiW/8Y6q23nw0dvdS8QB052XzI/K5+dhA==
X-Received: by 2002:a17:902:6a86:b0:1bf:3c10:1d72 with SMTP id n6-20020a1709026a8600b001bf3c101d72mr10633510plk.66.1693966242433;
        Tue, 05 Sep 2023 19:10:42 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902eb0500b001bf846dd2ebsm9902527plb.303.2023.09.05.19.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 19:10:42 -0700 (PDT)
Message-ID: <136c0434-a588-877e-54e5-dd1078ff94a3@gmail.com>
Date:   Wed, 6 Sep 2023 10:08:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     patrick@stwcx.xyz,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        peter.yin@quantatw.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
 <20230905062223.774871-3-peteryin.openbmc@gmail.com>
 <20230905181637.GA3742088-robh@kernel.org>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <20230905181637.GA3742088-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/23 02:16, Rob Herring wrote:
> On Tue, Sep 05, 2023 at 02:22:22PM +0800, Peter Yin wrote:
>> Document the new compatibles used on Meta Minerva.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>>
> You should not have blank lines between tags.
> Thanks your comment, I will fix it in next version.
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index 68f717670f78..32582ee56264 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -79,6 +79,7 @@ properties:
>>                 - facebook,elbert-bmc
>>                 - facebook,fuji-bmc
>>                 - facebook,greatlakes-bmc
>> +              - facebook,minerva-bmc
>>                 - facebook,yosemite4-bmc
>>                 - ibm,everest-bmc
>>                 - ibm,rainier-bmc
>> -- 
>> 2.25.1
>>

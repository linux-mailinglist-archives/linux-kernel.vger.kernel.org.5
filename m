Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6390A762F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGZIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjGZIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:04:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86974487
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:56:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so5041631a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690358175; x=1690962975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odDg0y6CRPX/kcGTqSC1ZxWdmNVk9khsoq6zYzAM55A=;
        b=f1VfKkdCjdXQ/0hqQTgF7xy8bFn0IDFOCDCCwpCNbnA1SSffTK7WS0k13tQiBk9K4M
         El1lHgoPJ8+IBtxiIJYqdfm/NsrkwII7jzGd2IDrS8Ejpmx0s48Yfe8cTa5TkQ1DmDva
         7YWQ368U6dApD873OGJ3XvPIvgU7j8nx5eHWB/ABL59NFD4GxFmOH4tpfXtlI++p32cf
         SQp5j704NBq8LNECU7MHIHVRqljTkBL3xw0krhHxGmzIZ+rLMeneIoJzSewWAHRapors
         YNmbS1TgvuMxLcmVMSW1sb04jOIlT94YMY5e6VZ/qouTu+AiJafjib40Eo+9PSRGmACM
         lUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358175; x=1690962975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odDg0y6CRPX/kcGTqSC1ZxWdmNVk9khsoq6zYzAM55A=;
        b=bsjhTfBcx1Pc8NiYJVW3pYWJc/+BqaRYJBoYiVBgjH8cc8FPbbNTJSoYT5Ch6/uac8
         IrojEao7hjwhKqw9s/RUp/RD/+bMBjoXObtc1YLt9oAqP4icOx3hA4NHM5yI1u1KdeVg
         5EPOBWZhCUalfNPRgpXizMvEVI2zwIaMUSlaeD7qBuoLqzk24MfJFWL4ZWx4pgKqIjGd
         sQ/PdC6jwZ3BCnKQoCl0mtCxF8nXeG0+ofWViYYwFAhfYg3CXHASVhtK5zWcTN3RgN8j
         /ytpJ0TOZfrWQsMG8g2DWi0+OPiSWRWUuW6Lx4RLk788oSjzCVF85iklFUUlPMZsBQsd
         ZWDA==
X-Gm-Message-State: ABy/qLZx6KzYTnBP4Wo2hP0qgeT1Co242Ve8qCqwXd2P6xCvEpvJcXhN
        D5PhxtSIspwZjOI7L0IMe7eSpQ==
X-Google-Smtp-Source: APBJJlHcQWAr+O5hhPJbuiUnnmQZW0br1GFI8SavYMCyjuPcPPBdNWDJ5iqrexilwQD5pdE9maYWNg==
X-Received: by 2002:aa7:cb55:0:b0:521:e502:baf8 with SMTP id w21-20020aa7cb55000000b00521e502baf8mr987473edt.11.1690358175388;
        Wed, 26 Jul 2023 00:56:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u24-20020a05640207d800b0051a53d7b160sm8566747edy.80.2023.07.26.00.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:56:14 -0700 (PDT)
Message-ID: <013e2bf8-b234-c638-f17d-3e221771f038@linaro.org>
Date:   Wed, 26 Jul 2023 09:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
Content-Language: en-US
To:     richard@bit42.se, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se
References: <20230410082051.2948510-1-richard@bit42.se>
 <e248cd32ba0fe9388a72a732ad252eaa@bit42.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e248cd32ba0fe9388a72a732ad252eaa@bit42.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 07:35, richard@bit42.se wrote:
> On 2023-04-10 10:20, Richard Alpe wrote:
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    efuse@e8000 {
>> +        compatible = "fsl,t1023-sfp";
>> +        reg = <0xe8000 0x1000>;
>> +    };
>> +...
> 
> Gentle ping on this

It is nice to say whom do you ping, so I will not waste time figuring
out that I already reviewed it.

Best regards,
Krzysztof


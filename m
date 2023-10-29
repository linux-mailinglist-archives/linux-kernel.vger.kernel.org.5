Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E67DACFE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjJ2PUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2PUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:20:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9635BF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 08:20:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso2320712f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698592812; x=1699197612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IrmAeWcuBgdSqYW1XCXkxt819eOri/OxbnvejsNDdAM=;
        b=X4iR3LsKwQvCPBr6DJ0oWQ9Gshjf9PJ/jj45AZzztWWVGngsJP+4E1qdO7xhOFIO2o
         PQO5pydjxRRsC6Z9TX85PMouJrIgZUqjqZuyRvPDpL656OaaAQROlG1/AtPCWu9P4K1y
         S9xio15+9PxsVNOpa7avDmO+NfGiQXs+xglp3in2KvAgSAJJ1UGZf9k/i88/A5wIpZUR
         WsnXBCu7RmvSyUuYDMIsNWjLCcIP+75OdXtdT6bZfpQZoan12gh7GCUq6QM6gHRze/FU
         XZ32vfbjC6PFGXCYoNaA2KyaQN4ENe4MKd04+TDCZzhjYpH6xZLfSJWiAb8ZczXIuhfx
         X7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698592812; x=1699197612;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrmAeWcuBgdSqYW1XCXkxt819eOri/OxbnvejsNDdAM=;
        b=RIJ+RFa6Kzf+m8Fh8os+vEXmASot0s82Qzhs9PIhnGuweFNj36EH4kQKVdkvaH49NO
         EqY55WAZQlwMVgmsgVPq3+q0J6Bn0iFp0A3y7gySt6WCoXtjWbuQYh4VesNcSyl70bop
         xz9vAmiLexC0yEhuL8mSCZx5HFqUl1bsPYixRpVXrlzaGIP/ufeIGodaFcFSUv37+oI+
         c0I2589urIAJvmbHTGWGLFJoDTJvopUKZeNLL45q2PfzwASUPk9aHhkV96sGEn/shaC3
         JrOoULd14c3ueX5XJE5++WXaoQ7YOw+4b7wFkC7mVUq2ZgQ+T/HSfqRxp2Br11L/ELCu
         RwyQ==
X-Gm-Message-State: AOJu0YzgnpBBm7pbeNpJ50ewq3Uqp6yrCvkooe+q9ktZIvrnScLaCFng
        8zfqP8+GxFu9/DoN5Y0Z8IF39A==
X-Google-Smtp-Source: AGHT+IGzTAp4Xf8NI/zJBqhS5HC1BclNAwwcWkagunjXn2YOGfvMyUrAn0H5gcY6zYDw4lbEzIjRAQ==
X-Received: by 2002:adf:d1cf:0:b0:32f:796a:b6c6 with SMTP id b15-20020adfd1cf000000b0032f796ab6c6mr3789490wrd.45.1698592812074;
        Sun, 29 Oct 2023 08:20:12 -0700 (PDT)
Received: from [172.50.24.226] (5-226-109-134.static.ip.netia.com.pl. [5.226.109.134])
        by smtp.gmail.com with ESMTPSA id g5-20020a056000118500b0032da022855fsm6190790wrx.111.2023.10.29.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 08:20:11 -0700 (PDT)
Message-ID: <842b5fb7-a43a-4273-88af-6f1571fdaa35@linaro.org>
Date:   Sun, 29 Oct 2023 16:20:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: watchdog: davinci-wdt: convert txt to
 yaml
To:     Nik Bune <n2h9z4@gmail.com>, krzysztof.kozlowski+dt@linaro.org
Cc:     robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        afd@ti.com, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux@roeck-us.net,
        skhan@linuxfoundation.org, wim@linux-watchdog.org
References: <147aebc9-8d76-49d4-a80f-eb6894868688@linaro.org>
 <20231029150905.108531-1-n2h9z4@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231029150905.108531-1-n2h9z4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2023 16:09, Nik Bune wrote:
> Hello! 
> 
>> On Sun, 29 Oct 2023 at 08:31, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On 28/10/2023 19:51, Nik Bune wrote:
>>>>> +  power-domains:
>>>>> +    description:
>>>>> +      A phandle and PM domain specifier as defined by bindings of
>>>>> +      the power controller specified by phandle.
>>>>> +      See Documentation/devicetree/bindings/power/power-domain.yaml for details.
>>>>
>>>> I think you missed Rob's comment in reply to Andrew, about constraining
>>>> and ordering the power-domains:
>>>> https://lore.kernel.org/all/20231026203037.GA327324-robh@kernel.org/
>>>>
>>>> Cheers,
>>>> Conor.
>>>
>>> I didn't get what should be done with respect to the comment above:
>>> Should we wait for the response from Andrew,
>>> or should we skip and remove the the power-domains definition for this binding,
>>> or add "maxItems: 1" to power-domains definition?
>>
>> None of the options above allow to send the same code without maxItems.
>> Sending new version without addressing feedback is basically ignoring
>> the feedback and next time you will have annoyed reviewers...
>>
>> Best regards,
>> Krzysztof
>>
> 
> I didn't ignore. v3 patch was sent 37 minutes before the Rob's comment to v2. 

Ah, sorry, it's good then :). Rob's comment still applies, though.

Best regards,
Krzysztof


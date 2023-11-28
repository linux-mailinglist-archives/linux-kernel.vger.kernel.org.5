Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806917FB8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbjK1LAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjK1LAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:00:10 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2C8197;
        Tue, 28 Nov 2023 03:00:17 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso3841072b3a.0;
        Tue, 28 Nov 2023 03:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701169216; x=1701774016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUB7QgCX9kAMB/Lg9l0EP3qxCwdAvpTXoJYwnDzkTg4=;
        b=izM++sarEPxp0YqHL1kM0mwuWBwTOwH6820Cr55ZWLWu6XPoipNDP+DJ7M2nlZ2soM
         FiTfNn5qtAcp/m1RVKRiWSSZE6TbojS8D8xANOlwLjXbuNv13wcVLnK7JLlc8jd2J9+8
         knsZCqtkq4rhY2jFDzbtFqSYe3ZirVu7LeGGwFeWpRP7Dpfl5xTS7lPk9Wbnm3J+jY8o
         mDi2DQbraDrL6pvoguCeNoA+3F+UzbXj2fWqyJAjKA5f+CQkZfomaX+7Ckzfotfw4hxe
         bymxrcplsuE7G5TMkj5riEvPcxnISSBrpZ93o9ktMY7Cf84tG8UCiyMswc+GxTKyuKzr
         aU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169216; x=1701774016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUB7QgCX9kAMB/Lg9l0EP3qxCwdAvpTXoJYwnDzkTg4=;
        b=tmlUTDgKSEH1Jbi31ai+Tl7fRKWI3E+O81p7Kay4ljxDziicSUluBQXdBp1LqIW2f5
         QQqGorn1nE4d2rE1GnaGM8V1VwnWBRtLLpWAovNrt7SaaSjtIBznVD3UVyn7bcSPafO6
         Yp1ysRB5BztxkQyJkDXU3a6l7tEwo6VoL3GURbUO2zfHu/SdGj53MQOv+KLi55P2Wy1W
         5HFdZsiWplHTvMg1fq1wzw7qecp2kpENL2yFsLcZ/OmTJs+9PvbtdmuoTWCoEJYzW3M9
         Ru6sefDM+aD4GYst2PuEQlKdFO9wYDCgTaQgL8QIGVl5gKVcB+aN3AHM30hvwIIaVYBh
         dd+g==
X-Gm-Message-State: AOJu0YxzvzJ7hAsUKYmSm0kp0d5FD5ip+EQw2UPk0adQZ+vOkey1Sj6p
        iPUGoUw3c+T4zYaT7R7EZKM=
X-Google-Smtp-Source: AGHT+IELZy2cfK9evDSGdPDLQOTm0q44f8N3/c+byMrYR82BkmRcoyiSNcxwqRFBJEoqnyNviZmX+Q==
X-Received: by 2002:a05:6a21:33aa:b0:18b:9428:cd1f with SMTP id yy42-20020a056a2133aa00b0018b9428cd1fmr20906975pzb.21.1701169215950;
        Tue, 28 Nov 2023 03:00:15 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00088300b006cb64908070sm8867824pfj.93.2023.11.28.03.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 03:00:15 -0800 (PST)
Message-ID: <5a96dd2a-53f2-498a-89e8-547e7fbc22d4@gmail.com>
Date:   Tue, 28 Nov 2023 19:00:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-3-ychuang570808@gmail.com>
 <7c24aaf8-8f93-4b93-b7e5-abc88e95682d@linaro.org>
 <ffbaad9b-9a30-4cdd-bb78-8fb7d6ff4e9f@gmail.com>
 <5ac7f79a-68d3-49ef-9615-3c0076591d78@linaro.org>
 <2e0f58cc-0cfa-4957-bac1-c40897d7135b@gmail.com>
 <5109e1ce-9aa9-4c7b-bf22-9be23b5939d8@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <5109e1ce-9aa9-4c7b-bf22-9be23b5939d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/28 下午 05:35, Krzysztof Kozlowski wrote:
> On 28/11/2023 10:32, Jacky Huang wrote:
>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - nuvoton,sys
>>>>> This goes after patternProperties
>>>> I will fix the above two as:
>>>>
>>>> allOf:
>>>>      - $ref: pinctrl.yaml#
>>> Look:
>>>
>>>>> allOf goes before additionalProperties.
>>> Open example-schema.
>>>
>>> ..
>> I found that 'pinctrl.yaml' is not required for this document, so I will
>> drop it.
> Why is it not required? I don't understand where this discussion is going.
>
>
>
> Best regards,
> Krzysztof
>

I read the description of 'pinctrl.yaml'. Yes, it is required. So, I 
will add it to allOf: - $ref: pinctrl.yaml# properties: compatible: 
enum: - nuvoton,ma35d1-pinctrl '#address-cells': const: 1 ... Best 
Regards, Jacky Huang

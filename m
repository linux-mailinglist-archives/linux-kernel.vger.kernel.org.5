Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510E7FD2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjK2J3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjK2J2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:28:44 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9D1FF9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:28:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a132acb67b5so260642166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701250107; x=1701854907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sWY+t7R6FWq3cT1bMI6aLc3NxmK67OlMnTzxt5eSDY=;
        b=t9jREKsEqZA14E1Dav/KEp4VQRU2D+WOoJ5RtlJy61gosUQ1j9gbMEwtt09QLgRP/i
         gu0OEoWyer1ZJyoihRzd7UJidN+SGrzgqibjZY6CtausSESu+xcYhKjy0tIFCr+HN9Sw
         PZjJyw8OP/LQS5LhcaePDZKz3O49L37KyAoeJsiQniKgXyzi+G2kJsCheOpv+Knn0Kri
         76xkk6rHxBIXRAYib8b8k7XcecAQWRCEq5CfGVFjCmzXG0+e+afJykUBR59YTWdCj626
         Vw/zHg7DYsjZK7Z1DzO7kDDAZpa+t/ZfllR6pWFvJWMwgiVQnuKZBkqsuPTWXiAHzSUG
         WzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250107; x=1701854907;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sWY+t7R6FWq3cT1bMI6aLc3NxmK67OlMnTzxt5eSDY=;
        b=xDAOARvA3IQyveyCcxWGbmUtnpqTyPIWNjpUPYc250PqCFK0PgCc2hkjBR7HAmHlZh
         K5TFlfmiR/t2pN67Ex4msQYn3pRmWGFRIVP8+Fxj3W48qmXS47yO0XT+qatM+WWk6sl+
         LijH1wVg3RxvfFmiEUc4pud5SVHr6GBxV9sBE9BJ5pZVJ0bQQLv3AT4zt3Do5e0Oma11
         8nwsXOuHDrvulF8+afNxmx0Yqn4Rb3lEdL6AdnvqxGninM05YVznrzRZtcAfVABdMmFb
         Hhuk2Rb/s8hEBh7S2ZBe+JGtQdlkJtDibHTHJnRJ0YeG4KCX0yIUBYfeNmp0OIc1dkbY
         g6vQ==
X-Gm-Message-State: AOJu0YzwiJap95NTSvhhqCCcMt9956n/3GKTB6CidHnwy9o6YeUaMqnb
        HNkG6fKBDNDx1jqahyU2uJUUdw==
X-Google-Smtp-Source: AGHT+IHwQA/KozZFF7WsHKEv/d4NC5juxPyq7y6I6U2YYOohz9aVAHBstjfSKVyvmYHKl0bOgEWj9g==
X-Received: by 2002:a17:906:53d6:b0:9e0:4910:1666 with SMTP id p22-20020a17090653d600b009e049101666mr13153768ejo.35.1701250107329;
        Wed, 29 Nov 2023 01:28:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id kk9-20020a170907766900b00a0aca3de09fsm5513008ejc.184.2023.11.29.01.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:28:26 -0800 (PST)
Message-ID: <c8a28c72-5c0a-4a67-a4c9-e46a5716cda4@linaro.org>
Date:   Wed, 29 Nov 2023 10:28:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
 <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
 <ZWCpGdJRexnk98IN@hovoldconsulting.com>
 <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
 <ZWW_FOAKp95Cf9vN@hovoldconsulting.com>
 <18965bb9-7afa-4892-8b71-981ba29d2cd4@quicinc.com>
 <ZWXHrvUDnF2dMk6r@hovoldconsulting.com>
 <6d7527bf-8c1a-49b5-a0cf-99a92098c971@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6d7527bf-8c1a-49b5-a0cf-99a92098c971@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 12:32, Krishna Kurapati PSSNV wrote:
> 
>>
>> So back to my initial proposal, with a slight modification moving
>> pwr_event first (e.g. as it is not a wakeup interrupt):
>>
>> qusb2-:
>>
>> 	- const: pwr_event
>> 	- const: qusb2_phy
>> 	- const: ss_phy_irq	(optional)
>>
>> qusb2:
>>
>> 	- const: pwr_event
>> 	- const: hs_phy_irq
>> 	- const: qusb2_phy
>> 	- const: ss_phy_irq	(optional)
>>
>> femto-:
>> 	- const: pwr_event
>> 	- const: dp_hs_phy_irq
>> 	- const: dm_hs_phy_irq
>> 	- const: ss_phy_irq	(optional)
>>
>> femto:
>> 	- const: pwr_event
>> 	- const: hs_phy_irq
>> 	- const: dp_hs_phy_irq
>> 	- const: dm_hs_phy_irq
>> 	- const: ss_phy_irq	(optional)

I did not follow entire thread and I do not know whether you change the
order in existing bindings, but just in case: the entries in existing
bindings cannot change the order. That's a strict ABI requirement
recently also discussed with Bjorn, because we want to have stable DTB
for laptop platforms. If my comment is not relevant, then please ignore.

Best regards,
Krzysztof


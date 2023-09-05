Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6721792BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbjIERC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353604AbjIEGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:51:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D057CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:51:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so324655766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693896667; x=1694501467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TI3fumOulphifA8hP0bCF3NnJrN6piRrNYQj+vzAjx4=;
        b=wEXBzdY87CW4tWRLo/dAq+htfGT6bzlpmwGMs1f7FLDZxwLqbYMvNYtJCB5+ZP/1+F
         erqbctpd0KednsH4IQw+iVQzGkMjKuh7A+R6+AwJc6vhy3DtFRm7dtIZUV2cr+41rfPJ
         dJIyK6fN4pg3T0eYaQpNchp5No+uqynhm4MYXU4o2vMIzPvYqILnxGa7ZS+RM+TM9FHR
         cEPVpSbGZl+GBFPs3Nj71pK+WXWMLmQKr221YUoKakwx28Hjh6RLbgaYD8duOrEGoPWo
         sjuryIc8ZmzgykoOk2vSO4FN/wqwb+SPDxqy2Mev+fpQcHIfOUm/EDl5GYf3tzoYimzU
         oT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693896667; x=1694501467;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TI3fumOulphifA8hP0bCF3NnJrN6piRrNYQj+vzAjx4=;
        b=julf+o/Gvf83wBuqdDMbbO0kG03Yd2CsE4PZUdE1aDxjuzOiv56KqjdhonYo38Ay05
         J0N4TPCh7Ja40W9rqFWugolnRpsWs97rdmHPnbZgg2FgZm1vzKZUSAf283082+T8+GwL
         9M+aTfBZJ/LM0Rc8+ahymRSRlTykl8x6uDldmJcZL/I56lqlcYX74Fn+eId1jq7WoRCu
         McIqNWLk0g6KEwuFgOZVTVKonPCpEOg0bpijU8yzsswAPfuVwnD02UKgfjQ0aguhi3nE
         0HbWvcbkrvgcQ7GOIzBT32Y9/ha/DgkY1YHKOFftkYrk/GAPEEUEDyYShJMHc0kZymTO
         XV3Q==
X-Gm-Message-State: AOJu0YxePFntOFr7WqVhWKCarU4syoYtnZEBL6C7kiqURwNMGSGp5JEc
        CHrXT+QWrKq7axMNCNCcHmkdHQ==
X-Google-Smtp-Source: AGHT+IFak6u0YHk+VTo55HeDc1ShrixofDnPPoc5WNdz9phuG5IwtwKskdApHe67dMkqwxTB5lNnrg==
X-Received: by 2002:a17:907:2bf2:b0:9a1:f96c:4bb2 with SMTP id gv50-20020a1709072bf200b009a1f96c4bb2mr8684469ejc.50.1693896667119;
        Mon, 04 Sep 2023 23:51:07 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id mf25-20020a170906cb9900b0099d804da2e9sm7192399ejb.225.2023.09.04.23.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 23:51:06 -0700 (PDT)
Message-ID: <b8bb019d-6832-a956-b314-e7861748d188@linaro.org>
Date:   Tue, 5 Sep 2023 08:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] dt-bindings: usb: dwc3: Add missing SDX65 compatible
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com
References: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889028-6485-4-git-send-email-quic_rohiagar@quicinc.com>
 <96c76c55-d5d4-e4ef-e7c3-ee35b2d7ad78@linaro.org>
In-Reply-To: <96c76c55-d5d4-e4ef-e7c3-ee35b2d7ad78@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 08:49, Krzysztof Kozlowski wrote:
> On 05/09/2023 06:43, Rohit Agarwal wrote:
>> Add missing SDX65 compatible for specifying the clocks used.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> index 5c13229..fa51f50 100644
>> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> @@ -186,6 +186,7 @@ allOf:
>>                - qcom,sdm670-dwc3
>>                - qcom,sdm845-dwc3
>>                - qcom,sdx55-dwc3
>> +              - qcom,sdx65-dwc3
> 
> That's not a complete change. Update the rest of the file.

Hm, your subject is confusing. The SDX65 is not missing and you do not
add missing compatible.

Best regards,
Krzysztof


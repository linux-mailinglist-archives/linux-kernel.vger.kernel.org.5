Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD50792BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbjIEQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353704AbjIEHUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:20:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5510187
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:20:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so329476166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693898440; x=1694503240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmUoOK0lN5gj+Il6SCFX8BT+dF5nWWi3v992EvHZxAo=;
        b=P1i9qMJEczedLs01wLYVq8NI5mt3WQJIwNGWoizXi38CLzWPKIGMTbq5BYahV3/PCi
         P21JLQHVWjy1Oex1EeH/rsJMODWZBgTxqNZzRwjuu7QnBlqAoDIwb55cnEjKidxeMqSX
         t2jacKHeTSxsaNp4GoapHzEyw1mL4E9FME1lGpCm0jqN7DgTvJEbO2TKVfovV3TiYMdk
         yKx8iKXagbKdqIvP737nyBse7Uy6sNIpRDSGV7td2jVlRh0gByNjFrKezXs7a8Un8SKE
         cWseIC4ggV00c4Mm4RzGKsvf/YzfMIYih262Pof6TN5YbqxZlIGpSlGhlE39LAR2aNql
         iOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898440; x=1694503240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmUoOK0lN5gj+Il6SCFX8BT+dF5nWWi3v992EvHZxAo=;
        b=cuK4PV/iodyk6bkDjtR2cLAathfRX+v0b6GdtF5S8rgxwHk6Q7qUH/PimK04fTSY35
         8hz/ivnuIOCQE13h3oM+xcNPo3IFk9e7osIcbUri1dGZTHfmFlcj3MZwbHfr+RG4DstQ
         3HPbawO41ekev7JRQQt5/nOchNacwr8PNc8DPXFSL/b0jKppuDwnhHdCZF4utd2LMRg5
         Y6Q+yZVgBF34xZsQDFoESCBzZyak8W+mhaAM3UJZbQaFEJI2pdCBeLOjEqTIv2e0jC9A
         GS1sAkBXhwkPFMDmvAsKpIKhvJ0A1KYe3doLySNSaJoUwCbVpriZHc06d75PGmq4ReVx
         KJqg==
X-Gm-Message-State: AOJu0Yz/EUSLOG6XaaZ/6qtdU3JEEQcuQGQh7ICaA67ERXK+E2EIiHOT
        0KxyM/8oxmp+UbgL9T8SlL6rgw==
X-Google-Smtp-Source: AGHT+IH6F3jOPjgAFKoncqqEKzF4um6HfdS5m64nKXUK90MIZJaWRctyovZeFwGPrb0l4SEs5mqa6g==
X-Received: by 2002:a17:906:3101:b0:9a1:cd2e:212 with SMTP id 1-20020a170906310100b009a1cd2e0212mr9270422ejx.60.1693898440476;
        Tue, 05 Sep 2023 00:20:40 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id ox29-20020a170907101d00b00992ea405a79sm7187418ejb.166.2023.09.05.00.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 00:20:40 -0700 (PDT)
Message-ID: <4bd9e859-cbc1-6b8b-9c22-0a1745924475@linaro.org>
Date:   Tue, 5 Sep 2023 09:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add qcom,sdx75-qmp-usb3-uni schema
 file
Content-Language: en-US
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
 <1693889028-6485-3-git-send-email-quic_rohiagar@quicinc.com>
 <0a2fcbc0-4b18-a54c-9f91-9710cc0bea1c@linaro.org>
 <00bf888f-1501-70d6-eaf0-2592a36d1114@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <00bf888f-1501-70d6-eaf0-2592a36d1114@quicinc.com>
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

On 05/09/2023 09:08, Rohit Agarwal wrote:
> 
> On 9/5/2023 12:19 PM, Krzysztof Kozlowski wrote:
>> On 05/09/2023 06:43, Rohit Agarwal wrote:
>>> Add a dt-binding schema for SDX75 SoC.
>>>
>> It's the same as qcom,ipq9574-qmp-usb3-phy.
> Seems like this change is not in the tree. Will rebase my change on top 
> of it and mention the dependency.

??? We do not talk about maintainer tree nor next. This was merged in
mainline. You work on some old tree.

Sorry, rebase and recheck all your patches on latest next. This includes
running smatch, sparse and coccinelle. Do not develop on anything older
than maintainer tree or next.

Best regards,
Krzysztof


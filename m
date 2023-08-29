Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BB478CA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbjH2RHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbjH2RH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:07:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB11AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:07:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf1f632b8so627647766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693328841; x=1693933641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAQIr8pt/5UnnLbqPSKYkJ1Yao70TixJlA2TFwMbYIE=;
        b=lN8MP7iBdCjY4T9ATE0dC0lRwK8QJmt7oSOACLkIHth1TL5encwNmeLoG1xAcR4vHl
         0hE2B3yqkWZH54G1iW3NiyFMA3uHhnBBYgaiX95CPDJxKsPYGsCltcbJ6EJ1eOBEA4d7
         Sus/2Jd9KAz0XouVKpfgOPCqtOWL5sIzTbAwBCvUiIclLfjc166lgm2iksiBz5WBfgpC
         2/fk+BU0zhiXCO2kKJpekzU/NKBtqMQEOBtlCHvbtmaAbg34tY3ZBllNZkUYYh9yyNYn
         Y7QJaIhVYd74+BQcu/nagHptI0ENm0pvYhnykykiwuhkj4SqEkGfQ8RNEIr+4kW7sAQs
         iiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328841; x=1693933641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAQIr8pt/5UnnLbqPSKYkJ1Yao70TixJlA2TFwMbYIE=;
        b=SxNg29vYxRygDpA0PGtShA3l06z14J1IJsRMIUn5sRbgRzh0p4vm1pTV3B0EiQIQ0V
         gUmMTG0kAE0W3YUL+KSiCD4WFwWzzRRAEIpDtw9MwCmgcsrVao6Lcyp6Q9VzB9uRsuut
         CWtK+XIcZSGdS5DwBuDi4zfLc7uvsp3TJdXHRSg2bS42KXIc7AKDNsB+XlvT/lTTMocD
         /wTdbqTDwj0Mhn1PHRGgxWkusNuMWaRXJnq/lyxUGmXva2zom63yOlZKUGMgl7tLEJZb
         EJsjdkDWASrp/sBxWF2pVYewLlanueIkCAKHlKfW9wsvYVCTTwGXff847C9jXw0lEwvz
         AmOw==
X-Gm-Message-State: AOJu0YyOsKMwn9u2UokoJwapOfDrf8/aVu74yN9pf5xVsvqtgrlyqcts
        gfQvqidMICWBfBk4A2paeFFxMQ==
X-Google-Smtp-Source: AGHT+IGDoj0kamMH4ga2ajkfNsBmDp7XZCgAWROLZ5ozex5foVdSYm9okeIqhwudrf2rECP8fhDKIA==
X-Received: by 2002:a17:906:10d6:b0:9a5:da6c:6539 with SMTP id v22-20020a17090610d600b009a5da6c6539mr430704ejv.75.1693328841175;
        Tue, 29 Aug 2023 10:07:21 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090649d800b009930308425csm6152018ejv.31.2023.08.29.10.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:07:20 -0700 (PDT)
Message-ID: <92d97b12-48ba-13c9-de9e-70b6eb330904@linaro.org>
Date:   Tue, 29 Aug 2023 19:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/9] Enable USB3 for IPQ5332
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_varada@quicinc.com
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 15:58, Praveenkumar I wrote:
> IPQ5332 has UNIPHY for USB and PCIe which is similar to the UNIPHY
> present in IPQ4019. Few extra settings like clock, reset delay, mux
> selection and voltage regulator are required for IPQ5332. Hence
> repurposed the IPQ4019 PHY driver for IPQ5332 UNIPHY. Few more Qualcomm
> SoCs are also having the UNIPHY which can use the same driver for both
> USB and PCIe PHY.
> 
> Praveenkumar I (9):
>   dt-bindings: phy: qcom,uniphy: Rename ipq4019 usb PHY to UNIPHY
>   phy: qcom: uniphy: Rename ipq4019 USB phy driver to UNIPHY driver
>   phy: qcom: uniphy: Update UNIPHY driver to be a common driver
>   dt-bindings: phy: qcom,uniphy: Add ipq5332 USB3 SS UNIPHY
>   dt-bindings: usb: dwc3: Update IPQ5332 compatible
>   arm64: dts: qcom: ipq5332: Add USB3 related nodes
>   arm64: dts: qcom: ipq5332: Enable USB SS UNIPHY

DTS does not go before drivers. DTS should be sent separately or as the
last patches. If you stuff it in the middle, means your patchset has
dependencies which it cannot have. Thus it is broken.

Best regards,
Krzysztof


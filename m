Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E808B78AB66
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjH1KaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjH1K3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:29:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CAAB9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:29:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a2185bd83cso392424466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693218589; x=1693823389;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgWbl8lPDl41Al6QpsrWevt2TQ1ACauu918bY4j1z+s=;
        b=bb/1I8Sm+ca97kh3b6g55IZcyB3k/N69Wdcm6OZ5O2Yp8H5f9FhmL3lg+5jbnGhVbl
         /aTvMBwbieOYKlVj7VqcD2DYvC/Sb2uwGOy52Nm81n7mWyAGe8wXxPHQY9cU7hRPbIgZ
         IpSm/Fi+TSeUmBhFZyp6CFHKrjsAFb2MENhkXo9LmULlSXI5J7+G+/sCvPC5ghCRTq49
         5w1GsbIl2CSHsNuFWTlUHtPXfRQMtfWXjbtOaG+rurF3wcLeDJkr8L8/hNiF7qn6jLGU
         UVguUParRgO9JTc5Q9oAlvTZABJDhe+0Zu7M99q2cf4ckB/byeUUkDUQc4R8SQ8TUlaL
         u/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218589; x=1693823389;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgWbl8lPDl41Al6QpsrWevt2TQ1ACauu918bY4j1z+s=;
        b=mEW1fc/aFBvsSZK8v+VzeVicox+mu2C2MQHhrKKx3xdsJ/X+N0NExDx8hOp8Tbw/8/
         0LT/Y+4xstdr7iVpWVA45nznU8ZynzrI65XVFZJKYLUcnHPWqbuYcKvRidsvctbtkbsN
         c7agGVjm50FkIJVZR0VvAFvQsHjwZlEvBzryeAyh6gebukfnnAcBejQIkOm7YBWzUS47
         5dG3S/r0Xs9UiY0dUNPI086c5IHRAdOVC6He9BlxM60eWMIip1wGnNF/CQuOMl41a6tM
         jmJeuFYy+u6vqg2JuVZOuasnZ1a/V3R/2bF4oyGOj1WoxgtoayMrzXXtZKtnkFDMHJPI
         UlCA==
X-Gm-Message-State: AOJu0YzC+Ny59L2HUfSzcRQV3GdLyCa0aEBj246WYqkpAfhZtyeXAp9r
        6T2RhIto6MQxHmSObDOhiHfRNQ==
X-Google-Smtp-Source: AGHT+IEvflAPEhQk9eVSwuVE3hLZKV3uv9/1Nn0BRVXbRA8n/i3Y6qZDfP5ehGeIoJ4+m69+C2I4Ug==
X-Received: by 2002:a17:907:7897:b0:993:f15f:efb7 with SMTP id ku23-20020a170907789700b00993f15fefb7mr19814166ejc.8.1693218589623;
        Mon, 28 Aug 2023 03:29:49 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906044500b0099b8234a9fesm4462264eja.1.2023.08.28.03.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:29:49 -0700 (PDT)
Message-ID: <5cb45ff4-a279-f47e-8d2f-700856cdff0f@linaro.org>
Date:   Mon, 28 Aug 2023 12:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: correct PCIe EP phy-names
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230827114519.48797-1-krzysztof.kozlowski@linaro.org>
 <1c2faca3-d10c-429e-961d-447ae076d319@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1c2faca3-d10c-429e-961d-447ae076d319@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 11:53, Konrad Dybcio wrote:
> On 27.08.2023 13:45, Krzysztof Kozlowski wrote:
>> Qualcomm PCIe endpoint bindings expect phy-names to be "pciephy":
>>
>>   arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dtb: pcie-ep@1c00000: phy-names:0: 'pciephy' was expected
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> drivers/pci/controller/dwc/pcie-qcom-ep.c
> 549:    pcie_ep->phy = devm_phy_optional_get(dev, "pciephy");
> 
> welp looks like this never worked..

And if only it could have been spotted with some automated tooling,
before posting to LKML...

> 
> 
> Fixes: 9c0bb38414a4 ("ARM: dts: qcom: sdx65: Add support for PCIe EP")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Thanks

Best regards,
Krzysztof


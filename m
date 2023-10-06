Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729EF7BC327
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJFX6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJFX6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:58:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AFBC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:58:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50435ad51bbso3302651e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 16:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696636679; x=1697241479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYPUh/Q1TeqvQIJLjORqLOAktxS2uLnBNCEX1Cyn064=;
        b=zpskxg21IQAXhF7HFise0OMsHUIE7755v9Y8ch0X8YtGraz3sHDIkV4bBNTTSQu4AY
         zOHA/v2ph+iWUjNJwmHG5OW7lD73V0ghqnjJsTRROYGS78ZvYDAzuA/bp3qgHTw9yUEB
         K6xkYQ1ne+YPJLhmDnFx6+VRF7TArbQ7V+eAgu879P/f0Pymp/ki9yteRzwk6gT6FihD
         xd70meDFT4l/pdWToH52pu3ZEZG8sh+VRYEuEDqnpDX3vuefDJjBkjP+WfeZtt82hWxk
         QxgdL9OUzJODr6j5RlPKWRgedKiCqUl/9lnAZsBlqaxqYNiqGmvkRBsKVJlyJbEcISLd
         KjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696636679; x=1697241479;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYPUh/Q1TeqvQIJLjORqLOAktxS2uLnBNCEX1Cyn064=;
        b=MjUPy12IA4GKX9KSow8NGJmLi/wFTKXKz/tlnheoIYfEBIj23XzKew/RENBBXCHW/n
         FrYhIqWo098JwMwWS0L3l/FNDGzMSt3ivDKm4U6ss+mjx5ohMz01HXY/1eRWA1viVHqG
         +51FZbJLocRqR3Rltuy6T3Flgwr77w7V9QAyuh1jof0hEYRunOM3s1PhC7EJ3lHy/G+3
         btvj5vYJc2HjPsbVgz8lailbEKNvEGIXOzg4tfPkVdUkI2YB/kPmDi3ZAyvUleCPAEcg
         7Cq0+cZewCc84o7Xb6QOzsro2C0ZnYaCU4qr+0P0NB9ApDXQj0cW5kE6PID67iAH4TVN
         Q8Kg==
X-Gm-Message-State: AOJu0YxlHDrysJQl/3JyijfGnONB5AS6GBdSVFJSmjzysbvs1kuiTB5A
        ePpJKlp1dv8aOTwkb2FII8ToXw==
X-Google-Smtp-Source: AGHT+IHOhwlTfxO0gtbu5R3YxSSzux1ir1D0+XV9LoycquxOEKv33Uk9S1akXB8MDf7rtMqWeM4CXg==
X-Received: by 2002:a05:6512:39c8:b0:4f8:7513:8cac with SMTP id k8-20020a05651239c800b004f875138cacmr11087219lfu.48.1696636679204;
        Fri, 06 Oct 2023 16:57:59 -0700 (PDT)
Received: from [192.168.200.173] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id w21-20020a19c515000000b00502e0ea7174sm479791lfe.186.2023.10.06.16.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 16:57:58 -0700 (PDT)
Message-ID: <0007b5ff-34d4-44c0-80bd-8277d5842c01@linaro.org>
Date:   Sat, 7 Oct 2023 01:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] phy: qcom: Introduce Super-Speed USB UNIPHY driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
        arnd@arndb.de, neil.armstrong@linaro.org, nfraprado@collabora.com,
        u-kumar1@ti.com, peng.fan@nxp.com, quic_wcheng@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kathirav@quicinc.com,
        quic_nsekar@quicinc.com, quic_srichara@quicinc.com
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-3-quic_ipkumar@quicinc.com>
 <412492d1-fcc9-481c-9d28-b208a644ba1d@linaro.org>
 <7975c638-29cf-45ce-9d76-b8a93d750eb7@quicinc.com>
 <CAA8EJprhQz_Tj0Bhv6zhGa7h37Ug-Fp6Tof9tNscTFyZzkbJvw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJprhQz_Tj0Bhv6zhGa7h37Ug-Fp6Tof9tNscTFyZzkbJvw@mail.gmail.com>
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

On 3.10.2023 16:54, Dmitry Baryshkov wrote:
> On Tue, 3 Oct 2023 at 17:22, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>>
>>
>>
>> On 9/30/2023 10:48 PM, Dmitry Baryshkov wrote:
>>> On 29/09/2023 11:42, Praveenkumar I wrote:
>>>> Adds Qualcomm 22ull Super-Speed USB UNIPHY driver support which
>>>> is present in Qualcomm IPQ5332 SoC. This PHY is interfaced with
>>>> SNPS DWC3 USB and SNPS DWC PCIe. Either one of the interface
>>>> can use the it and selection is done via mux present in TCSR
>>>> register. This driver selects the PHY for DWC3 USB and handles
>>>> the reset, clocks and regulator.
>>>>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> ---
>>>>   drivers/phy/qualcomm/Kconfig               |  11 +
>>>>   drivers/phy/qualcomm/Makefile              |   1 +
>>>>   drivers/phy/qualcomm/phy-qcom-uniphy-usb.c | 322 +++++++++++++++++++++
>>>>   3 files changed, 334 insertions(+)
>>>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>>>>
>>>> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
>>>> index d891058b7c39..7257c8455c53 100644
>>>> --- a/drivers/phy/qualcomm/Kconfig
>>>> +++ b/drivers/phy/qualcomm/Kconfig
>>>> @@ -154,6 +154,17 @@ config PHY_QCOM_M31_USB
>>>>         management. This driver is required even for peripheral only or
>>>>         host only mode configurations.
>>>>   +config PHY_QCOM_UNIPHY_USB
>>>> +    tristate "Qualcomm USB Super-Speed UNIPHY driver"
>>>
>>> Can we please have more specific driver name? As I wrote earlier,
>>> there are two other (different) kinds of Qualcomm UNI PHY devices:
>>> - DSI / HDMI UNIPHY on apq8064 / msm8974 / msm8960 (?)
>>> - USB QMP UNI PHY drivers
>>>
>>> Adding a driver called UNIPHY, which is not related to those two kinds
>>> sounds pretty confusing to me.
>> This UNIPHY is different from above mentioned ones. This a custom
>> version for 22nm on Qualcomm IPQ5332.
>> Can we name the driver as phy-qcom-uniphy-usb-ss-22ull.c /
>> phy-qcom-usb-ss-22ull.c ?
> 
> usb-ss-22ull sounds better. Or maybe usb-ipq-ss
usb-ipq-ss is as safe as usb-msm-ss

We can not rely on the hardware never ever changing down the
product line :D

Konrad

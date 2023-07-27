Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEA764759
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjG0G45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjG0G4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:56:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E416D2691
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:56:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52256241b76so732374a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690441012; x=1691045812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6cPtMEPBxlBiHf/EIzV/+O7GL0ZnIZPX9tstH2PvO4=;
        b=IMkVrWgafqnnFUibpUTCAHk0wQuhTQFyuEyzXwJPL5LDBnEdYLqv0fJAAw1icgOr5C
         ap5GO0oKKpRxZJflqvBRIUR1hwBgxPgBZejk+NzafCVhL5Xvmt0lWHnq5/GTZZBByfZ/
         vapJVetgc3KcWMRx8YKsKW43OdYniWMNX/DB295Kzd2iq7nZzCwJMQRB6TzpFL+JaXKF
         OGLJdWf5hV5vTQRnr/rAz48ietGMEyjowMCXMJ6YcnIo/o/oBGK28LhlR4OdWXEfOYIG
         JCnZNxv2sQoUFQ/fjcbSUEKlzz2uoCYkgr4T7NNPss7a55Ri4KKf3D7lQnpPfccdf/Cj
         kqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690441012; x=1691045812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6cPtMEPBxlBiHf/EIzV/+O7GL0ZnIZPX9tstH2PvO4=;
        b=TpIEN+9gl2oWLJqM6u7qRhp9ufiMHcBcA6D2RSCgDDMEwsUC0nf8oer1JjqQjvHyW0
         YpphcphzDRSnzNjWhZdlsugPerFO2zf9nWihJgz0b9ezcjdKZGvopz7yDmEShFYBZIDM
         2ls9h3i95KBUQG0040QntDHh7NnOv0MxL4OYBj4VhMQ9PL4bTxXLuqJlcfsHmdduRzWq
         jXwGjaAxV0k8asnMe/9NUkP6lb10Ucp2qmiIs/6TIuFVbOyk0ZYKKZARH8agW3klf5MT
         QI5T2XwYBFrPlrABg2dVEcaeNoW1sBkYtjot5kkse1jlAa5Yd+JrkjMob3vILuue+fBB
         pQIw==
X-Gm-Message-State: ABy/qLYzi1ujgC5wnG4Gi3oXY0zoUuSmkojjl+5eaBAi1x/9R+sKGQ30
        fwTTVT4+SUK2NzDMA1ZsAYQ7MQ==
X-Google-Smtp-Source: APBJJlGFbW4wB9NS8ig+/D62uIMcuf+bTA4t6Gegu+0aVI9luFRvDJ3idhIyOJyTxqwz4BNytwFDBQ==
X-Received: by 2002:a05:6402:326:b0:522:2111:105d with SMTP id q6-20020a056402032600b005222111105dmr1071856edw.20.1690441012198;
        Wed, 26 Jul 2023 23:56:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o5-20020a056402038500b005221b918e33sm292546edv.22.2023.07.26.23.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 23:56:51 -0700 (PDT)
Message-ID: <f974f48a-05b0-530d-25a0-7ccf1b1ad113@linaro.org>
Date:   Thu, 27 Jul 2023 08:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: Add base SM4450 QRD DTS
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727023508.18002-1-quic_tengfan@quicinc.com>
 <20230727023508.18002-5-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727023508.18002-5-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 04:35, Tengfei Fan wrote:
> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |  1 +
>  arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 337abc4ceb17..db805d0929c8 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -186,6 +186,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> new file mode 100644
> index 000000000000..04ad1dd4285a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sm4450.dtsi"
> +/ {
> +	model = "Qualcomm Technologies, Inc. SM4450 QRD";
> +	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
> +
> +	aliases { };
> +
> +	chosen {
> +		bootargs = "console=hvc0 earlycon=hvc0 hvc_dcc.enable=1 cpuidle.off=1";

No earlycon, no hvc.enable (there is no such parameter), no cpuidle.off
(again don't add fake stuff). So the only suitable argument is console,
but this should be actually used via stdout path, although it seems
there is no device node for such usage?



Best regards,
Krzysztof


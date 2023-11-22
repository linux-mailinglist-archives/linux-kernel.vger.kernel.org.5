Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF767F5156
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjKVUNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:13:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20B4191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:13:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507962561adso175304e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700684015; x=1701288815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxaMqeODr1UhKHrPKp0+oaZPp53OiEhtu1sJuNSc+9o=;
        b=DsY91IqbuCILFJuyZrfwaWpvN/IiB9efZcvPU0TnRIPRak9x+mOBAseKx4pW9fZtZ2
         eg22yOHd6yGPlumGa9U2Lnq2ciWQqp0ODRrNJVVL//SUP1mzrBvMtwPUqxNwPezmngNT
         14c8R62QoudWXg8NtDVV1Et08HwUOPIC+i6gVVfKwaz2TjPpKLCQsS2JPDd/dxTO81xF
         46KNI7cmlv3+zzZSAe1jzVXXZAKQLEv4WkwM7vNq+44xtD6eg2L1NeISH2W8w5sr3usu
         b97HB4OBy3n+hw9XwTe2ARVGNlDTTnZcRL3oEeyPv1LqBstZqUVffOMnY6TLO9/BXz8Q
         3BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684015; x=1701288815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxaMqeODr1UhKHrPKp0+oaZPp53OiEhtu1sJuNSc+9o=;
        b=RBrV0XP3lePTGdMAN5g26BZqZZObujzbRuJMpXmNDxUKdE+Xyrf2/dT1DTzfgKq4um
         2dBOi2XaNql6tkSDYATjFsKlTDUFb5Gm2Vq7qV/zuxkZ99/55KuOqpfF+gldykq36mX/
         y3owsipfWqgVZ15DbRmI7BBfFSU2xXLmCDW4g2xFex/rbipzJwEXqinrSmZlBcupNQY+
         mxa7V28bST9BIfeV90X0r42biOvpw7P36su45yjAnnEtFZ10x4O70Q+fVJTY48RCHTuO
         /ACftT7imfMQjOcO3W61LtUZIciZLnLlzSwWlGln1nviq9KdSvN1UQ96oqLeaCLKWUA2
         rVEA==
X-Gm-Message-State: AOJu0YwXOu//EifQQ2pbupPD2s1P9VZ14Jor9uSObl8mpy+XGc4JQdoC
        yB4ljzJakJ6ZPSEu+f3it1rBgQ==
X-Google-Smtp-Source: AGHT+IEHZowoNQL9s85M08y91XIFjWkmGnKTVbKCkQbqr9w1y6hTUUfsnrS1vUjvGlgkfj2MbCWmRg==
X-Received: by 2002:a05:6512:ac3:b0:507:9640:f256 with SMTP id n3-20020a0565120ac300b005079640f256mr1193823lfu.36.1700684014991;
        Wed, 22 Nov 2023 12:13:34 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w8-20020a197b08000000b005048f11892dsm1911889lfc.171.2023.11.22.12.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:13:34 -0800 (PST)
Message-ID: <35ca2ef2-7613-4ddb-b863-2e429337fee3@linaro.org>
Date:   Wed, 22 Nov 2023 21:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sc7280: add slimbus DT node
Content-Language: en-US
To:     Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-sm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vnivarth@quicinc.com, msavaliy@quicinc.com, vtanuku@quicinc.com,
        cchiluve@quicinc.com, dkammath@quicinc.com
References: <20231116183909.32179-1-quic_vdadhani@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231116183909.32179-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/23 19:39, Viken Dadhaniya wrote:
> Add slimbus DT node to enable slimbus usecase on Bluetooth
> for audio streaming and playback.
How can I test this?

> 
> Based on requirement, client team can enable slimbus node
> on target specific dt file.
You can even enable it if you're not part of the client team!
This paragraph is a bit obvious for what it describes

> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 04bf85b0399a..fba352504f3f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2528,6 +2528,31 @@
>   			status = "disabled";
>   		};
>   
> +		slimbam: dma-controller@3a84000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x0 0x03a84000 0x0 0x20000>;
0x0 -> 0 to be consistent with other nodes

> +			#dma-cells = <1>;
> +			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
interrupts should come after reg

> +			qcom,controlled-remotely;
> +			num-channels  = <31>;
> +			qcom,ee = <1>;
> +			qcom,num-ees = <2>;
> +			iommus = <&apps_smmu 0x1826 0x0>;
> +			status = "disabled";
> +		};
> +
> +		slim_msm: slim-ngd@3ac0000 {
slim_msm -> slim

> +			compatible = "qcom,slim-ngd-v1.5.0";
> +			reg = <0x0 0x03ac0000 0x0 0x2c000>;
ditto

> +			#address-cells = <1>;
> +			#size-cells = <0>;
these two properties should go before the status property

> +			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&slimbam 3>, <&slimbam 4>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x1826 0x0>;
> +			status = "disabled";
> +		};
Konrad

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA77D80E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjJZKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjJZKg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:36:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB3189
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:36:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507bd64814fso959643e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698316614; x=1698921414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUjNYugWXfB4iPjrQerwJC5Hgqu+kEPnTtwC5PAjmHM=;
        b=p3pQMpwfnFqb2K5aHx3zyaRGxaEs6o/n/DLkGLJgHcmPXcGdr84CA7Sk6GPfBnYLL6
         HzlXk28OSS9EYlgoqwEoL13lJp2184Ci52hhJsaCMTiAr957IFr4e5/YLP5N7UTDxk58
         72dqL+KV54jXC7BBKOYa0XOliiabqsYRpndeF+d2USXrouOTcdxNsi849ZWN1ElGDTsb
         0C0czCnIXubacTSZrwsctCz3rUTSSKHYpf3BpFTlDXVCL76t11m4JbAVDFTrtt5RLgF6
         /GkwgEAakDoEQYLnSvuTkMsEVCcvgiqcERk5VYe5zS+X0EplWS4rmXL51dKq7XUoxIEK
         pbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698316614; x=1698921414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUjNYugWXfB4iPjrQerwJC5Hgqu+kEPnTtwC5PAjmHM=;
        b=g74lr5XyjtVXlK7D/w25vdHc/Or8upF3frnst5vpX3kxRg7lKnIY1PBcHzjVgbMe7O
         mE2wcEqR9cdtmGJloCb9LttCtQuuozaE9D/OL+V+E4V44iddEiH+hjHNVRpW/R/Q+wFp
         BqzAMpWIdG4N+kf/gmKAHql9amg0GTvksCyvttDGvlVM8FJzsY7jvm3he7X1LXrT0ib6
         tBEz8Z593sY2PGiesbNmAiH/zZQYg5FnEjlkQCy56/fGd3OB3KDT2zkps1LuC+Fl0vDC
         Gv0u3nIJUsz1T35mgzk9+zefhU8nftaeAjoGMJ7eHm8b5IVQKvsaQqhXlwKpZRVVvDvW
         WiFA==
X-Gm-Message-State: AOJu0YwtnysY/Hap4Pha2LTW1s60LJ0wXPKg/LBTiLVVxG+4Jzw5OtYL
        WN5c14R5Zhtx1erXmfRjecrcOQ==
X-Google-Smtp-Source: AGHT+IFR0kYrbz9KcWn983kcAAoVAZwmsmcMvoxTT7Cvu2H6TdPX2KPUjQ3lbuBZaawGsE3WlDdQZw==
X-Received: by 2002:a19:4f04:0:b0:507:a001:792e with SMTP id d4-20020a194f04000000b00507a001792emr12867972lfb.46.1698316613735;
        Thu, 26 Oct 2023 03:36:53 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n24-20020a05651203f800b00501c8959f6asm2954228lfq.98.2023.10.26.03.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 03:36:53 -0700 (PDT)
Message-ID: <f3661605-ea2f-4681-8486-b83bd042568c@linaro.org>
Date:   Thu, 26 Oct 2023 12:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: Add base SC8380XP dtsi and the QCP
 dts
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, ulf.hansson@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, ayan.kumar.halder@amd.com,
        j@jannau.net, dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
References: <20231025142427.2661-1-quic_sibis@quicinc.com>
 <20231025142427.2661-4-quic_sibis@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025142427.2661-4-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 16:24, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add base dtsi and QCP board (Qualcomm Compute Platform) dts file for
> SC8380XP SoC, describing the CPUs, GCC and RPMHCC clock controllers,
> geni UART, interrupt controller, TLMM, reserved memory, interconnects,
> SMMU and LLCC nodes.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
[...]

> +&tlmm {
> +	gpio-reserved-ranges = <33 3>, <44 4>, <238 1>;
It would be really cool if you added an explanation on why these
GPIOs need to be reserved, especially since you can see what's
connected on there on schematics. So, like:

gpio-reserved-ranges = <33 3>, /* something */
		       <44 4>, /* something else (fp scanner?)
		       <238 1>; /* UFS reset? */


[...]

> +			compatible = "qcom,oryon";
Again, this compatible won't fly unless all of these cores
are totally identical and Oryon is only a name for this
generation on this SoC (which I believe not to be the case).

> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L1_0>;
> +
> +			L1_0: l1-cache {
> +				compatible = "cache";
I'm not sure if L1 is supposed to be described in the DT,
Krzysztof should know.

> +				next-level-cache = <&L2_0>;
> +
> +				L2_0: l2-cache-0 {
> +					compatible = "cache";
cache-level?
cache-unified?

[...]

> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0 0x80000000 0 0x80000000>;
That contradicts the comment you made above. Plus, 2 GiB seems a
bit low for this SoC :D

[...]

> +		gunyah_hyp_mem: gunyah-hyp-region@80000000 {
you can probably strip the "-region" part, as this is implied by
being a child of /reserved-memory

> +		pld_pep_mem: pld-pep-region@81f30000 {
What's PLD?

What's this region used for? PEP is a Windows invention.

[...]

> +		av1_encoder_mem: av1-encoder-region@8e900000 {
Is AV1enc hardware separate from iris?

[...]

> +		gcc: clock-controller@100000 {
> +			compatible = "qcom,sc8380xp-gcc";
> +			reg = <0 0x100000 0 0x200000>;
The address part of reg should be padded to 8 hex digits.

> +
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
QCOM_ICC_TAG_ALWAYS would be nicer than 0 (see sa8775p)

[...]

> +
> +			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
One space after and before '='

Konrad

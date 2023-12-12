Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E482080F255
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjLLQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjLLQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:21:17 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7516B4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:21:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso5808255e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702398082; x=1703002882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXvboew3vx5kJ+1t8nLLmNj474Lqcvv3Ol8gm0lk6Ck=;
        b=TfwnVGxToCWf4ERBwbkgP6dkrLxnYYCkSPOMqcm0+OpS9VydLUdGERKhF186G92Nua
         JU/3YTDt8U+EocrkIF0aNJErwHyssV81+9MCd7yfWZcG4EB1kp32LQo+W0xNVXZUNiuc
         MZUfx3l1eAX75jDYWvbSayNuzbu4S3bj+bI06+pTc8+dAfxFobsaJCQjMskHUqOSgQlY
         L9h0E8/NuQNfsYSk4XYdYxzL2GdtURmtixyfCA2C2I2zklYkhBd0gJJHX70nxC7Pgawo
         AasUmTwF8DzT6bl+bKXGmB7VpcuYoKxZPKSw0Ks8Isn6CubaCZMwTKAHs6orqC1+lky1
         P1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398082; x=1703002882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXvboew3vx5kJ+1t8nLLmNj474Lqcvv3Ol8gm0lk6Ck=;
        b=QfxGSJaT9xVsIahTCWqlyHNZ2phdjeI2V8uAo53ykTZ1ca7ucMb4mldBeyLPsYYraf
         Dcc1SAYQFcj8DHu5OjcpCP9S7WrJnY28JIt5TuCIm0Y9MzQXM0rGpg6Ub40yCMNG8aae
         3LucmZPGXcpkj19F42aarIOAq/40e/4vyfMFpFNY3Hj/NgNknhw+mrqV/CZLVVHfidGZ
         ZxOzyOj7SfJoUsHebo0ya51p7zZvmP60if41Ne2/2bnFRUhsKP5NWab6AvS/ZHH3x7Pn
         vIswJVQahllCQGpXnow4Jvzml/HFRXS76CPIqXorCN0KJFsZEsdK9whZpgBm80Dkw/+S
         UTdQ==
X-Gm-Message-State: AOJu0Yy32sR3VOgcwFQoYh5Bro2v2YrD8mI9WWFWwAYXLvsgSM24w3dI
        zYEsW7siwOcdgSXQ+EkigFTRaw==
X-Google-Smtp-Source: AGHT+IFi+2fskjgDBiYkYmqQcbu3wZdEEC+Qx5qBur+AMajd+X1+WeLdysVYcaq0unDwbDbj0vyOFg==
X-Received: by 2002:a05:6512:3f03:b0:50b:ed31:72a4 with SMTP id y3-20020a0565123f0300b0050bed3172a4mr4739191lfa.28.1702398082036;
        Tue, 12 Dec 2023 08:21:22 -0800 (PST)
Received: from [172.30.205.64] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h8-20020ac24da8000000b0050beffaa549sm1368848lfe.255.2023.12.12.08.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:21:21 -0800 (PST)
Message-ID: <9c8e887b-429c-4226-9851-5f1cbb93524a@linaro.org>
Date:   Tue, 12 Dec 2023 17:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100: Add all missing nodes
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org>
 <20231212-x1e80100-dts-missing-nodes-v1-1-1472efec2b08@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231212-x1e80100-dts-missing-nodes-v1-1-1472efec2b08@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/23 11:24, Abel Vesa wrote:
> Add all missing nodes which describe entire X1E80100 platform.
"all" doesn't really mean all :|

couple of patch-wide observations below

[...]

>   
> +		gpucc: clock-controller@3d90000 {
> +			compatible = "qcom,x1e80100-gpucc";
> +			reg = <0 0x3d90000 0 0xa000>;
Please make sure the address part is padded to 8 hex digits
[...]

> +		usb_1_ss2_hsphy: phy@fde000 {
> +			compatible = "qcom,x1e80100-snps-eusb2-phy",
> +				     "qcom,sm8550-snps-eusb2-phy";
> +			reg = <0x0 0x0fde000 0x0 0x154>;
and please choose 0x0 vs 0 and stick to one (which seems to
be 0 in this file)

[...]

> +		pcie6a: pci@1bf8000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-x1e80100";
> +			reg = <0x0 0x01bf8000 0x0 0x3000>,
> +			      <0x0 0x70000000 0x0 0xf1d>,
> +			      <0x0 0x70000f20 0x0 0xa8>,
> +			      <0x0 0x70001000 0x0 0x1000>,
> +			      <0x0 0x70100000 0x0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
one per line, please

> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x70200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x70300000 0x0 0x70300000 0x0 0x3d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <7>;
> +			num-lanes = <2>;
> +
> +			interrupts = <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 843 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 0 844 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 0 845 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 0 772 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
you can drop these comments
[...]

> +				clocks = <&gcc GCC_DISP_AHB_CLK>,
> +					 <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
you probably should list the ROT clock here too
[...]

> +		cpucp_mbox: mailbox@18830000 {
> +			compatible = "qcom,x1e80100-cpucp-mbox", "qcom,cpucp-mbox";
This is not upstream

> +			reg = <0 0x18830000 0 0x300>, <0 0x17430000 0 0x4C08>;
lowercase hex

Konrad

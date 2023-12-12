Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7680E7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjLLJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:42:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B45DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:42:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1e83adfe72so509715266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702374154; x=1702978954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ab1u+8M+Dm9uo1aZ0FRCSc/hdRD8QsyXXMToKdHn3YM=;
        b=sXlhNgXoixdSf7bmuoCfidYEGBfDbhddNEIgG6d9J+0eu+C2m0wOvPbJNutDjFLqk6
         L5hHrsaSItsCKoP9qN6qSXxsYpzwPOLpCzXYfO/MFBnmAWgOYoWV5V86wmvyOce0aNIC
         C1cj4TVVyHEGOp1Z2Wf8yfmc63Cll6C5SmiSGxn7QAP0zoitZeKSoG5juXVCXojvEe23
         ktSMr9alBCDsGJPCH54GpSWs3DpkW9pS0hBnbfWBeU9zjCzPaSshe7INCTsG3/HY6Eef
         wiIR8XJoVLjTvuJK6IsDULF5f0/+3d1NJK8VemiqIhTkpUHPp037HE03iMmj6vmGiw7Q
         uc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374154; x=1702978954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab1u+8M+Dm9uo1aZ0FRCSc/hdRD8QsyXXMToKdHn3YM=;
        b=mgCnZN6HmmnBLhqsEz3kLX/0ocObZVpkDjRksBVhNEobRHdsAenOB/mPqTuyNIN3dn
         7gme82nJNXxVJXazd0gPEvAQ3/JovZOaXfEBkob3dV6MXVkhtC/V9TvPVml89YqZ+6cG
         uXIte1Z6yKA/0GON/ycsug01vC5gvIE6+ZMib7f2gu/Znh3yHS1fE0AvPQoKM4MZcART
         LZFPsrXxNisVqbDm3yQ2Bv64da8Vj5WhhcKRIviO3xdAWjxNe1Ig+t3Ko9IUWfiFH/CZ
         GQDkkdIefKbyb39BXbpQ4rliRNim5N9+vP19yvu+RJEb233zhc96ipDKuopgtae5yCDR
         l2VQ==
X-Gm-Message-State: AOJu0YyirfUF5rp5Hn6CmzXD2y72qWBfzYIoLo3hTWPkg7U9Qc+JsUsx
        7EkMmz5cO2JujPWw0keH/aZucw==
X-Google-Smtp-Source: AGHT+IGjSOz4SSTqu+GJBYnhLwGCVarT1qCJVfjUEnwNzA+f3tfpoT0jrkRQZSZGaQUqCStgg5FLNQ==
X-Received: by 2002:a17:906:7392:b0:a00:773c:3f09 with SMTP id f18-20020a170906739200b00a00773c3f09mr3444594ejl.17.1702374154403;
        Tue, 12 Dec 2023 01:42:34 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vc12-20020a170907d08c00b00a1d4a920dffsm5933659ejc.88.2023.12.12.01.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:42:34 -0800 (PST)
Date:   Tue, 12 Dec 2023 11:42:32 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add SMB2360 pmic dtsi
Message-ID: <ZXgrCHNkz20Weqjq@linaro.org>
References: <20231212-x1e80100-dts-smb2360-v1-1-c28bb4d7105e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-x1e80100-dts-smb2360-v1-1-c28bb4d7105e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-12 11:39:52, Abel Vesa wrote:
> Add nodes for SMB2360 in separate dtsi file.
> Also add the eUSB2 repeater nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

On a second thought, please ignore this one.

This depends on the SPMI multi master work.

Will send proper version later on.

>  arch/arm64/boot/dts/qcom/smb2360.dtsi | 51 +++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/smb2360.dtsi b/arch/arm64/boot/dts/qcom/smb2360.dtsi
> new file mode 100644
> index 000000000000..782746a20403
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/smb2360.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +};
> +
> +&spmi1_bus {
> +	smb2360h: pmic@7 {
> +		compatible = "qcom,sm2360", "qcom,spmi-pmic";
> +		reg = <0x7 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		smb2360_1_eusb2_repeater: phy@fd00 {
> +			compatible = "qcom,smb2360-eusb2-repeater";
> +			reg = <0xfd00>;
> +			#phy-cells = <0>;
> +		};
> +	};
> +
> +	smb2360k: pmic@a {
> +		compatible = "qcom,sm2360", "qcom,spmi-pmic";
> +		reg = <0xa SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		smb2360_2_eusb2_repeater: phy@fd00 {
> +			compatible = "qcom,smb2360-eusb2-repeater";
> +			reg = <0xfd00>;
> +			#phy-cells = <0>;
> +		};
> +	};
> +
> +	smb2360l: pmic@b {
> +		compatible = "qcom,sm2360", "qcom,spmi-pmic";
> +		reg = <0xb SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		smb2360_3_eusb2_repeater: phy@fd00 {
> +			compatible = "qcom,smb2360-eusb2-repeater";
> +			reg = <0xfd00>;
> +			#phy-cells = <0>;
> +		};
> +	};
> +};
> 
> ---
> base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
> change-id: 20231201-x1e80100-dts-smb2360-0c7c25f2e0a7
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

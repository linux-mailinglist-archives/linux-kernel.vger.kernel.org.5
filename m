Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18797B8D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbjJDTKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbjJDTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:10:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8830D5;
        Wed,  4 Oct 2023 12:09:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so182558a12.3;
        Wed, 04 Oct 2023 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696446541; x=1697051341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuJ2CLb6+MUVtdnSy1rgrDtPNCbJpfpGSVNkFiavsuM=;
        b=ShK2h3SVwRonGRHd58RWYx0kASOLQ4U6bUmzl/yyF3cXbMDzKc1xVC1husWUzJqmD5
         j6ibFNVuJHsNlsYN4x1h8m6jJlkn4fUhGPC8obtIF6MV5U9hjee/JMgh3MTy2JhY3BKV
         pvP1RP0UMgbfDNbXo2cSeqEJ+F9q2ByIuA7spiCYRPG1etP2iswOX0cX9gxwqL1BFXwl
         BI0QHgFklGIj2p6hvArnUpFlEUxOkYaEwzBME3ydBwKzT8FtVHb4mR85OY20ZeQ9FEEe
         qjhdaXbTn345DvpCGgDU8CUeI+e6QHPwEUNvGZbuqPBz8ZIoP2Q4pQVDIX2xQ40VRTbX
         Hf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446541; x=1697051341;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJ2CLb6+MUVtdnSy1rgrDtPNCbJpfpGSVNkFiavsuM=;
        b=IhdJ4l4rRxI92Sd1323eT/33jpUwpdG1QV5HMSn4AYh73Na7nzcKgn9u1BACYZ3PQz
         ypthYMGwaVNhKXVZqKLkk/NzOKdSRNuwfmXfkXDbRkE5Zw3cNeWYZT85tS6yUOubOhQG
         sHK4Yw9ByBxMqYLSDc/xNgNLbW0p21kyrUOVXa29b/Tbv9M4WEBpXrtN2hkaH0s9ZS9J
         3iCz64ZdQCC1DzYyxqmSMgJkLNsF3RtFnm65kzl7lUYb4lAPMh7sRVTcXJ2+C97ERNt3
         cBDXbWyDyJqPwyr/3ZJtx+w4VbhynBc3fYh4BpVe+uOIng6sc2+yiXklvgcStBdITqAg
         W3Wg==
X-Gm-Message-State: AOJu0YyEw40MfOO+PMGNEyrjiJHd1XJeVxz8K6UIFyZWh7994tLsIhh8
        9SgrivvmFCim1lBE0eprPo8=
X-Google-Smtp-Source: AGHT+IHSi8Q6UpsWldn23PzMnBl9MWjowK+IxaoR933B6zBeB0WwS/khLi2m0aSoDcvuYKB6ehca6A==
X-Received: by 2002:aa7:db95:0:b0:526:9cfb:c12 with SMTP id u21-20020aa7db95000000b005269cfb0c12mr3077590edt.38.1696446540940;
        Wed, 04 Oct 2023 12:09:00 -0700 (PDT)
Received: from [192.168.3.32] (cpezg-94-253-131-161-cbl.xnet.hr. [94.253.131.161])
        by smtp.gmail.com with ESMTPSA id e10-20020a50fb8a000000b0053404772535sm270964edq.81.2023.10.04.12.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:09:00 -0700 (PDT)
Message-ID: <1c6ecc92-89d3-3b7e-c2d0-e2fded9b446d@gmail.com>
Date:   Wed, 4 Oct 2023 21:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>,
        krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22. 09. 2023. 13:51, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>
> IPQ5018 has tsens V1.0 IP with 4 sensors.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot. Adding all
> the 4 zones here.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>   [v3] Ordered the qfprom device node properties as per
>        Krzysztof's comments
>
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>   1 file changed, 169 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..9e28b54ebcbd 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -93,6 +93,117 @@ soc: soc@0 {
>   		#size-cells = <1>;
>   		ranges = <0 0 0 0xffffffff>;
>   
> +		qfprom: qfprom@a0000 {
> +			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
Hi,

"qcom,ipq5018-qfprom" needs to be documented in QFPROM bindings first.

Regards,
Robert

> +			reg = <0xa0000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			tsens_base1: base1@249 {
> +				reg = <0x249 2>;
> +				bits = <3 8>;
> +			};
> +
> +			tsens_base2: base2@24a {
> +				reg = <0x24a 2>;
> +				bits = <3 8>;
> +			};
> +
> +			tsens_mode: mode@249 {
> +				reg = <0x249 1>;
> +				bits = <0 3>;
> +			};
> +
> +			tsens_s0_p1: s0-p1@24b {
> +				reg = <0x24b 0x2>;
> +				bits = <2 6>;
> +			};
> +
> +			tsens_s0_p2: s0-p2@24c {
> +				reg = <0x24c 0x1>;
> +				bits = <1 6>;
> +			};
> +
> +			tsens_s1_p1: s1-p1@24c {
> +				reg = <0x24c 0x2>;
> +				bits = <7 6>;
> +			};
> +
> +			tsens_s1_p2: s1-p2@24d {
> +				reg = <0x24d 0x2>;
> +				bits = <5 6>;
> +			};
> +
> +			tsens_s2_p1: s2-p1@24e {
> +				reg = <0x24e 0x2>;
> +				bits = <3 6>;
> +			};
> +
> +			tsens_s2_p2: s2-p2@24f {
> +				reg = <0x24f 0x1>;
> +				bits = <1 6>;
> +			};
> +
> +			tsens_s3_p1: s3-p1@24f {
> +				reg = <0x24f 0x2>;
> +				bits = <7 6>;
> +			};
> +
> +			tsens_s3_p2: s3-p2@250 {
> +				reg = <0x250 0x2>;
> +				bits = <5 6>;
> +			};
> +
> +			tsens_s4_p1: s4-p1@251 {
> +				reg = <0x251 0x2>;
> +				bits = <3 6>;
> +			};
> +
> +			tsens_s4_p2: s4-p2@254 {
> +				reg = <0x254 0x1>;
> +				bits = <0 6>;
> +			};
> +		};
> +
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq5018-tsens";
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SORT */
> +
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base1>,
> +				      <&tsens_base2>,
> +				      <&tsens_s0_p1>,
> +				      <&tsens_s0_p2>,
> +				      <&tsens_s1_p1>,
> +				      <&tsens_s1_p2>,
> +				      <&tsens_s2_p1>,
> +				      <&tsens_s2_p2>,
> +				      <&tsens_s3_p1>,
> +				      <&tsens_s3_p2>,
> +				      <&tsens_s4_p1>,
> +				      <&tsens_s4_p2>;
> +
> +			nvmem-cell-names = "mode",
> +					   "base1",
> +					   "base2",
> +					   "s0_p1",
> +					   "s0_p2",
> +					   "s1_p1",
> +					   "s1_p2",
> +					   "s2_p1",
> +					   "s2_p2",
> +					   "s3_p1",
> +					   "s3_p2",
> +					   "s4_p1",
> +					   "s4_p2";
> +
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "uplow";
> +			#qcom,sensors = <5>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>   		tlmm: pinctrl@1000000 {
>   			compatible = "qcom,ipq5018-tlmm";
>   			reg = <0x01000000 0x300000>;
> @@ -240,6 +351,64 @@ frame@b128000 {
>   		};
>   	};
>   
> +	thermal-zones {
> +		ubi32-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 1>;
> +
> +			trips {
> +				ubi32-critical {
> +					temperature = <120000>;
> +					hysteresis = <2>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 2>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <2>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		top-glue-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 3>;
> +
> +			trips {
> +				top_glue-critical {
> +					temperature = <120000>;
> +					hysteresis = <2>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gephy-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 4>;
> +
> +			trips {
> +				gephy-critical {
> +					temperature = <120000>;
> +					hysteresis = <2>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

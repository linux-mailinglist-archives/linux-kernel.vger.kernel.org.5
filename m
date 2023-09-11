Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582CC79B40E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbjIKVKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjIKNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:15:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E69CD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:15:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso74238361fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694438112; x=1695042912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YL6EQgEy3tU456+JOD18a+m3T5ccWapszSBNRkdsmHI=;
        b=vHXNjYDzKOqcrn+XNPyUE8dUN6iSLRGOgkGduve+2Vl6HYAwqoSmASwtSEPt4r7xld
         BNp5fZNgi8ZfR76pkGpk9b618vvZretLDMSAtaJTD7cjisIQv5+dIRnaT/D/fpCYBymt
         OxuqW/rEAZQIJ7jWFUfs7CvKk2m/FvDSZQLv9WJ99w6TnPvuk2ampIYxFXbCbEWH2YMh
         pr7firIk7xBadI1aqRJ/hTJQbXupUNBfC32kd1lpcB2XRLdsC5BORce6hPvGbiWceJId
         5rpoia8SGhdZjUhHIt2R6hI73X2M63l3mVnbr1mfKkn0qrExZzmU69F3AZ/3quCKg5Qy
         q1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438112; x=1695042912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YL6EQgEy3tU456+JOD18a+m3T5ccWapszSBNRkdsmHI=;
        b=HDvS27cok+oeEg5nLOtfFB6KuJovsFYaCiDdkhxOQeLy+vgwWyqV9R6jZS0+/V+2de
         xpHJ47TqZ+hwl0zpeYnlZ+3cDN0Y8algGedSYwg7fqFny800xQhHlSSQm/wwj+aCbWSZ
         OdpaKdh2ED3R3pBE8tnxsLgejez7ijHp7YFprT7FVqPFf8t42TS+31L3/U1pLe4/lU8C
         D1sUQk+ICImujwH2FFik0FpR0s36D44OUlMn2+tn9LYWZ+9sV/Cwk9GK+KD/BAaA0Fn7
         CMkZwKFXavEuNXm99OQkVmlqTf2jsgLmF9bM5xV0R8CkULZGmHVxPZA/u+zdMYrdTWBx
         Xr9Q==
X-Gm-Message-State: AOJu0Yx9wpTF2iZxYEs1huFNAjUBYA5SGG29HPW/6mXlaWyL7akVd8MB
        vc0BbwQaCNFA0cwVxTTx5czOmg==
X-Google-Smtp-Source: AGHT+IHgPjvN+UWeNyYfeTibcUFW047uMqqj3CXvvMBXFOfU+Wn748lBxSTCSiRTpolOZ0ariUm+vA==
X-Received: by 2002:a05:651c:14b:b0:2bc:da4a:4649 with SMTP id c11-20020a05651c014b00b002bcda4a4649mr8568770ljd.22.1694438112248;
        Mon, 11 Sep 2023 06:15:12 -0700 (PDT)
Received: from [10.2.145.31] ([193.65.47.217])
        by smtp.gmail.com with ESMTPSA id p17-20020a2ea411000000b002b70aff9a97sm1533510ljn.16.2023.09.11.06.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:15:11 -0700 (PDT)
Message-ID: <04eb9f71-78f0-41f2-96a6-fc759ba296fa@linaro.org>
Date:   Mon, 11 Sep 2023 16:15:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: sdm845: Add OPP table support to
 UFSHC
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
References: <20230731163357.49045-1-manivannan.sadhasivam@linaro.org>
 <20230731163357.49045-6-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230731163357.49045-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 19:33, Manivannan Sadhasivam wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> UFS host controller, when scaling gears, should choose appropriate
> performance state of RPMh power domain controller along with clock
> frequency. So let's add the OPP table support to specify both clock
> frequency and RPMh performance states replacing the old "freq-table-hz"
> property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> [mani: Splitted pd change and used rpmhpd_opp_low_svs]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 42 +++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 055ca80c0075..2ea6eb44953e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2605,22 +2605,44 @@ ufs_mem_hc: ufshc@1d84000 {
>   				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>   				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
>   				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> -			freq-table-hz =
> -				<50000000 200000000>,
> -				<0 0>,
> -				<0 0>,
> -				<37500000 150000000>,
> -				<0 0>,
> -				<0 0>,
> -				<0 0>,
> -				<0 0>,
> -				<75000000 300000000>;
> +
> +			operating-points-v2 = <&ufs_opp_table>;
>   
>   			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mem_noc SLAVE_EBI1 0>,
>   					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
>   			interconnect-names = "ufs-ddr", "cpu-ufs";
>   
>   			status = "disabled";
> +
> +			ufs_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-50000000 {
> +					opp-hz = /bits/ 64 <50000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <37500000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <75000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};

I'd say, I'm still slightly unhappy about the 0 clock rates here.
We need only three clocks here: core, core_clk_unipro and optional 
ice_core_clk. Can we modify ufshcd_parse_operating_points() to pass only 
these two or three clock names to devm_pm_opp_set_config() ? The OPP 
core doesn't need to know about all the rest of the clocks.

> +
> +				opp-200000000 {
> +					opp-hz = /bits/ 64 <200000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <150000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <300000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
>   		};
>   
>   		ufs_mem_phy: phy@1d87000 {

-- 
With best wishes
Dmitry


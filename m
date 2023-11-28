Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0CE7FBB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbjK1NP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbjK1NPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:15:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF610CC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:16:00 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50aab3bf71fso7419276e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177358; x=1701782158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2U0Dw+C6h6+RoUlbLOMo/lv9uHPeB9SLzHDaRTZV7s=;
        b=aq4aBjShzauCTPcrw1rBmEmFJRHOZAvJt92AhlThn+N+MBM/k1/D2ClUuo/oIiLVlk
         ZoS9400FlRyjHk6VaNgyfV3BO3qyUWFTehddU0TwpMUVzdULBViISpeoNlnAO6dfNc5M
         Ep19/2B7gGFoVHIcBwbr/PMzKvGWGLe8K/2/0VxjuTLkTWIwRCAta+YCrhUnmZEl3Ude
         n4CI9rMo7RYVlq5NC8lt0+b/BgLqLXNBxtItNssBlnLIquZYBJJ7ZWjZ2CgSus9yezBL
         Ua9es5B5T/ja87fcsFOiCOicDItstxAG0sBEUpE5VOhrlUFLl7rFMVX+2zEk7CywknB3
         W4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177358; x=1701782158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2U0Dw+C6h6+RoUlbLOMo/lv9uHPeB9SLzHDaRTZV7s=;
        b=F8uOryOgInfrTEnQu4gc08VrP4GrPLz6SVTu+defl9hcE9Qc01Fy0JWyY9MDYdS70M
         g452TmkOSyTYKqFowdjZPv12CdSrl68MMb/V9QIPQnWj5546jLp2IvjCugGr5K4uRLm9
         uhXj1mARGrY1Lgxa/U35v10u95Kn9VTb6gEPcxlO0Pg+sP3cpKtCt8pA/+Rbejhinl6R
         muySevqQdcWlvpcTj9CE2tieIHrI+44L82RqrNFWz8umhc7iW5y0ad65Owrki5IBVVgo
         LKn4H1DZDl03dzEMc67QG6IGsSclhH6f68Cm9zW4wNTWJBi13PSLZO9SJfryQXvoWYql
         Y+Rg==
X-Gm-Message-State: AOJu0YyJL7CSkXryfW/RCPzBYJdbwoJnpXZFYR0RlENcFRU4dVHjlGxk
        qOu7rSd+Ebg/95wicWrj8U+/dQ==
X-Google-Smtp-Source: AGHT+IEzEaz+EEBfeJx7la23pJ4m/XXEUN3X5Za/9Q6XMgt9Zg15Eol47FvI5Utk4vk+9djDSK1vPg==
X-Received: by 2002:a2e:888f:0:b0:2c9:b96e:16e4 with SMTP id k15-20020a2e888f000000b002c9b96e16e4mr403296lji.42.1701177358355;
        Tue, 28 Nov 2023 05:15:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:15:57 -0800 (PST)
Message-ID: <37bfdc21-8d2a-4a6c-a2eb-9eaa1e808496@linaro.org>
Date:   Tue, 28 Nov 2023 15:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: qrb2210-rb1: add wifi variant
 property
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
 <20231125-topic-rb1_feat-v2-12-979b28f35e4a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-12-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 17:28, Konrad Dybcio wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> The RB1 platform doesn't have board-specific board-id programmed, it uses
> generic 0xff. Thus add the property with the 'variant' of the
> calibration data.
> 
> Note: the driver will check for the calibration data for the following
> IDs, so existing board-2.bin files will continue to work.
> 
> - 'bus=snoc,qmi-board-id=ff,qmi-chip-id=120,variant=Thundercomm_RB1'
> - 'bus=snoc,qmi-board-id=ff,qmi-chip-id=120'
> - 'bus=snoc,qmi-board-id=ff'
> 
> For the reference, the board is identified by the driver in the
> following way:
> 
> ath10k_snoc c800000.wifi: qmi chip_id 0x120 chip_family 0x4007 board_id 0xff soc_id 0x40670000
> ath10k_snoc c800000.wifi: qmi fw_version 0x337302d3 fw_build_timestamp 2023-01-06 01:50 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.3.3.7.c2-00723-QCAHLSWMTPLZ-1
> ath10k_snoc c800000.wifi: wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
> ath10k_snoc c800000.wifi: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> ath10k_snoc c800000.wifi: firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
> ath10k_snoc c800000.wifi: htt-ver 3.114 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

As you are resending this patch, you should add your S-o-b.

> ---
>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> index ac597eb3fe9d..bd7bcf803654 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> @@ -535,6 +535,7 @@ &wifi {
>   	vdd-1.8-xo-supply = <&pm2250_l13>;
>   	vdd-1.3-rfa-supply = <&pm2250_l10>;
>   	vdd-3.3-ch0-supply = <&pm2250_l22>;
> +	qcom,ath10k-calibration-variant = "Thundercomm_RB1";
>   	status = "okay";
>   };
>   
> 

-- 
With best wishes
Dmitry


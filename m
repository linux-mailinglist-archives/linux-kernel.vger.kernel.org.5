Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D548091D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjLGTrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGTro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:47:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B210F7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:47:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50be9e6427dso1247763e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701978469; x=1702583269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3WBG6P4B+HyjaL3nLuFPklzfCpTWZN+xQc43lrIQPM=;
        b=H2TDXcAPWkUd2ujORFK3iwG9wk1Yo3tvYorEwaLAlVtDZ1fZuYcowHfUIwEU15fscN
         tk+hrigcneRsXH/hXSXk1D8m5d8FZT7FgK5YGnMEzLlHdtXKFlaeovEI8YPUtKwLNLwr
         jkxRPLDbJqcPKa8heMbfq95MlwrvF4tW9zfgr5M9S5LSb9ccGBari8NF4/ekGDAVBkpN
         0NqGvoBKl0FNSB0n3ZHudowS2fT44x4O9qLaFLUa6cgqPbNsngAW3HJz2GIx3pOlBQge
         mefH/y/kYs4K0n7eEv6pCUYmrBkNOD6idQp5lAhpjPPc5Y/YO62hO/Y8tAmA1ex9xDD6
         TTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978469; x=1702583269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3WBG6P4B+HyjaL3nLuFPklzfCpTWZN+xQc43lrIQPM=;
        b=nvUllqZCdiqXlfPifeU6mEbPx7BCzP3s00LwfZ1NZKg5jhwVLsST4lICDbod98kjbu
         I3RG5mCkIqAJB4KdHl0ET2UA4khCPUrX+Ru51jq0Eggk2JBE2PuJ7Vmq5wEzbC+PYMBh
         yRf1L3KX+S1PRdfYWArTek4I+Vlq6fCxNi84FEBNg9kA8em2IIgjHWID4RbPlUbpEOWx
         Gm7NIlRx4wv4uOv7R8V1LQBayzLnhNRLJzR+OuQMzp6SK6VCxLAOZhwKelsGhe0Z/i/J
         /kTv/VThldazjF8ELdBP6QWkzyJp1J4+IiY3r2zAUrUBGmq4Qy+taOyUYJe+QdivpEje
         nByQ==
X-Gm-Message-State: AOJu0YwO0gROTvx8QSm74lrymBVpJIeh7qazOdNuweEE98RSJiyI/oq3
        By8z/lL3Ujm1C0KX/6D1MC320g==
X-Google-Smtp-Source: AGHT+IFgIMwXaG8n6KMWKKM5krd/gIX+69hDdwcMcOcBO9EJj+QioXq77mIeRXK2/1tYXKcWKw5aAA==
X-Received: by 2002:a05:6512:3b14:b0:50b:f51b:91f7 with SMTP id f20-20020a0565123b1400b0050bf51b91f7mr2494005lfv.103.1701978469277;
        Thu, 07 Dec 2023 11:47:49 -0800 (PST)
Received: from [172.30.205.181] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i38-20020a0565123e2600b0050bf789f501sm29324lfv.11.2023.12.07.11.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:47:48 -0800 (PST)
Message-ID: <44c36d3f-dacd-4ca9-b92a-5febdc5d1340@linaro.org>
Date:   Thu, 7 Dec 2023 20:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8650: Add DisplayPort device
 nodes
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231207-topic-sm8650-upstream-dp-v1-0-b762c06965bb@linaro.org>
 <20231207-topic-sm8650-upstream-dp-v1-3-b762c06965bb@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231207-topic-sm8650-upstream-dp-v1-3-b762c06965bb@linaro.org>
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



On 12/7/23 17:37, Neil Armstrong wrote:
> Declare the displayport controller present on the Qualcomm SM8650 SoC
> and connected to the USB3/DP Combo PHY.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]

> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
What about PIXEL1 clocks?

[...]

> +					opp-162000000 {
> +						opp-hz = /bits/ 64 <162000000>;
> +						required-opps = <&rpmhpd_opp_low_svs_d1>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
>   		};
>   
>   		dispcc: clock-controller@af00000 {
> @@ -2996,8 +3086,8 @@ dispcc: clock-controller@af00000 {
>   				 <&mdss_dsi0_phy 1>,
>   				 <&mdss_dsi1_phy 0>,
>   				 <&mdss_dsi1_phy 1>,
> -				 <0>, /* dp0 */
> -				 <0>,
> +				 <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +				 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
>   				 <0>, /* dp1 */
>   				 <0>,
>   				 <0>, /* dp2 */
I noticed that this is not in line with your mdss patch [1]
where there are only two DP INTFs available.. Unless all of
these controllers can work using some sharing/only some at
one time...

Konrad

[1] https://lore.kernel.org/all/20231030-topic-sm8650-upstream-mdss-v2-5-43f1887c82b8@linaro.org/

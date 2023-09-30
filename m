Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F57B42A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjI3RWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3RWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:22:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CF6E3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:22:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50573e85ee0so1193932e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696094561; x=1696699361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWtx9dHqmbOflZi0fnqEVpNoq1UTPPJzLzExwXGV3SI=;
        b=IknSE4NhxLd8C0Gi9Fu65zdNIo3A5eb/G8M5qFxaUpcZN+knVIjanOK3H7NJH26L5x
         DYbt/4BSv8gka0/8XyzBuZ/GoPHLNgaqlrp/o1F0gEs1qazFbtgSCByiqfCBdgvrYxgW
         F/5TPGxYyRh5EX+DanwIo45Vp1cV2uEGoaUJl9QxaiZqYamYs/8uQg7hLvdouott4jHV
         kRHLsFfgrRtrUiN/w51R5sltChvXJsFGZyMpfJLTYW8eTVr4Lfkj8+BQ93l1eeHXs9YR
         vZN2GgYdoCgYePnPMan3+EnIs7zWLgO7dKk4RMKzh5gInW8D7eU/l9yqWN9RltHZLVxW
         Ee/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696094561; x=1696699361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWtx9dHqmbOflZi0fnqEVpNoq1UTPPJzLzExwXGV3SI=;
        b=LLsTdcm5qPsDBz5FBeNq7m5qXYLWBrSgzJCSbTTinU/3vzzStnjthXdpVzCtr3s0B9
         RUn3JB8hnB0LBeOnpGXok6VGihyesRKDc2mAPjdARkHIwModTVlyrQ0bJsoLRScg/hUC
         Qhhc2SdO03Y047kX7nIrC7h2peBxu3tAvbjZDEm/zDkW2mUcuXr8f1EE3/6JM5t/BDqu
         n9AAhZ7KehknARYxr+3/efhIXbI76RbKoKrtQLKywv1ltc36smtV+83kOrKjjnOPh1og
         WuARk8VwNOi+8D6DzhXPgAW06WDX1Bn6+Caxqu2STV0k3e/ponjxp/qDM75QkKtOo2Jm
         UWJQ==
X-Gm-Message-State: AOJu0YyL17A8pNmZMKaNir5YFT8pjurWxEwTpbLIYb8jyfhLR1r39fx4
        ZGEYkF76GSvK1yQF5r5+WYL5uw==
X-Google-Smtp-Source: AGHT+IFmPULHC/lTZvEAMtHRivlmdkecp21az20I0qHWTzyMMavZ5xJfz8FMnJKA5soibKeUp+nyEg==
X-Received: by 2002:a05:6512:3a8c:b0:502:cc8d:f20a with SMTP id q12-20020a0565123a8c00b00502cc8df20amr7139739lfu.27.1696094561376;
        Sat, 30 Sep 2023 10:22:41 -0700 (PDT)
Received: from [192.168.246.189] (85-76-98-178-nat.elisa-mobile.fi. [85.76.98.178])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b00500ba43a43asm3994414lfq.86.2023.09.30.10.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 10:22:40 -0700 (PDT)
Message-ID: <5bf11343-6ab4-43a8-b12d-f2b072ce388a@linaro.org>
Date:   Sat, 30 Sep 2023 20:22:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: ipq5332: Add USB Super-Speed PHY
 node
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
        arnd@arndb.de, neil.armstrong@linaro.org, nfraprado@collabora.com,
        u-kumar1@ti.com, peng.fan@nxp.com, quic_wcheng@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_kathirav@quicinc.com, quic_nsekar@quicinc.com,
        quic_srichara@quicinc.com
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-4-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230929084209.3033093-4-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 11:42, Praveenkumar I wrote:
> Add USB Super-Speed UNIPHY node and populate the phandle on
> gcc node for the parent clock map.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index d3fef2f80a81..b08ffd8c094e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -158,6 +158,29 @@ usbphy0: phy@7b000 {
>   			status = "disabled";
>   		};
>   
> +		usbphy1: phy@4b0000 {

Are there other USB PHYs on this platform?

> +			compatible = "qcom,ipq5332-usb-uniphy";
> +			reg = <0x4b0000 0x800>;
> +
> +			clocks = <&gcc GCC_PCIE3X1_PHY_AHB_CLK>,
> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				 <&gcc GCC_USB0_PIPE_CLK>;
> +			clock-names = "ahb",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			resets =  <&gcc GCC_USB0_PHY_BCR>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "usb0_pipe_clk_src";

I'm not sure, what is the best approach her. For QMP USB and PCIe PHYs 
we had to use fixed names historically. On the other hand for QMP DP 
clocks we are fine with the generated names. I'd prefer the latter case.

> +
> +			qcom,phy-usb-mux-sel = <&tcsr 0x10540>;
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>   		qfprom: efuse@a4000 {
>   			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
>   			reg = <0x000a4000 0x721>;
> @@ -200,7 +223,7 @@ gcc: clock-controller@1800000 {
>   				 <&sleep_clk>,
>   				 <0>,
>   				 <0>,
> -				 <0>;
> +				 <&usbphy1>;
>   		};
>   
>   		tcsr_mutex: hwlock@1905000 {

-- 
With best wishes
Dmitry


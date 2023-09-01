Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA58E79016F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbjIAR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIAR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:27:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091DBCDD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:27:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so284188866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693589247; x=1694194047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss+qLANCDr/E1E/sALCGcAu2OPaPDRXb4/ydOTBXzBQ=;
        b=be1P/Setc7BYeSbX+uxLFsvKKJNY0V/zheELmkmFNL24uxotZMEMlPBlixUir1YTvg
         CMhAtsaqX17lKeob3uIEIdnvaWCvte58c1PBWS0mF5bdMn1iokwX2fvaLq3Mx3RgAX1b
         clhRIF9wRtslIctRiUlnuVROCU2rLfal2VU2MwQHHyIZaoVWKgQlrXvkVtOjy7EUXU18
         jIg6/j4Hgqy7rb2xUbAqr4wxGtGie/pTlBBPLGVp77v9vHqpD1Wx0KLoLaB6nd5HXK2Q
         1h2lTbU71ScMrCgHlFZXH7Dw9dnVu1KhHe78ZryopMSMWy6nsCwjxVH/nZmpZ3NQof9r
         vmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693589247; x=1694194047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss+qLANCDr/E1E/sALCGcAu2OPaPDRXb4/ydOTBXzBQ=;
        b=WAPd20MHwyI+e+QecPSJElPwN7Ost8I+pNNcWp66Z92Ih81k52f4QQaOFLnjIqXYBM
         hpgz6oVEnXNO2T996f54CDInCUU9EdVa1OoyL3FAnNQGzMAzrJF0eQuuwW3Sa8iqJfUI
         KFARth3hll3yWESsUzMaV82rIDnnEo12jr8HvHZi6YZd0Kd1/LrvyZjap3e+a3TcpZJ4
         z3eHFy2HFRG0mm9a5HArphuP1l9BX0wkh9XStNpP80uLpG80QmBs6twocW2aDirkJSFU
         k5QRab2QRMcnafn+kUNVOhj0r3BkJa1jxhmRldm2NmJ6eceT4A0XFRRndYU6qiTBs3Hy
         1nuw==
X-Gm-Message-State: AOJu0YxUy2bWmCvpLEom9ssXmsY9pCq4EH4jUxtetLmuPhOAsjwp5p0H
        RqaXa6RVuYVYyc4ocq8A56K+UQ==
X-Google-Smtp-Source: AGHT+IFcGVffPeSk/gYy/neXvresZTi7Jf5x67zGvWyJZLah1F7/YCdkWQjFSzedTTHx9Sne0C2e9g==
X-Received: by 2002:a17:906:8a70:b0:9a1:c00e:60cd with SMTP id hy16-20020a1709068a7000b009a1c00e60cdmr2312887ejc.15.1693589247510;
        Fri, 01 Sep 2023 10:27:27 -0700 (PDT)
Received: from linaro.org ([84.232.191.193])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906229400b0099bd1a78ef5sm2208075eja.74.2023.09.01.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 10:27:26 -0700 (PDT)
Date:   Fri, 1 Sep 2023 20:27:25 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8550: Add missing DWC3 quirks
Message-ID: <ZPIe/W7Bbm9Lv2Zp@linaro.org>
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
 <20230830-topic-8550_dmac2-v1-6-49bb25239fb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-topic-8550_dmac2-v1-6-49bb25239fb1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-30 14:48:45, Konrad Dybcio wrote:
> As expected, Qualcomm DWC3 implementation come with a sizable number
> of quirks. Make sure to account for all of them.
> 
> Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

That is a lot of quirks I missed :D.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 944b4b8c95f5..8ee61c9383ec 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2930,12 +2930,20 @@ usb_1_dwc3: usb@a600000 {
>  				reg = <0x0 0x0a600000 0x0 0xcd00>;
>  				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>  				iommus = <&apps_smmu 0x40 0x0>;
> -				snps,dis_u2_susphy_quirk;
> -				snps,dis_enblslpm_quirk;
> -				snps,usb3_lpm_capable;
>  				phys = <&usb_1_hsphy>,
>  				       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +				snps,hird-threshold = /bits/ 8 <0x0>;
> +				snps,usb2-gadget-lpm-disable;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				snps,dis-u1-entry-quirk;
> +				snps,dis-u2-entry-quirk;
> +				snps,is-utmi-l1-suspend;
> +				snps,usb3_lpm_capable;
> +				snps,usb2-lpm-disable;
> +				snps,has-lpm-erratum;
> +				tx-fifo-resize;
>  
>  				ports {
>  					#address-cells = <1>;
> 
> -- 
> 2.42.0
> 

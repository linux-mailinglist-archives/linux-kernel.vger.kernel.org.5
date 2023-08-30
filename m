Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138D378E067
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjH3UQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjH3UQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:16:42 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F43C198D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:16:11 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7bbaa8efa7so908899276.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693426517; x=1694031317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8kGGZ+yYzic7Nawq3DNrmlWB29Qsh1OZYatVeF7GGM=;
        b=mcsi/u0cGWxkvpG1v+kjxcdu6dtNfhqGy+TSzJNih2Y5t8Balaqz+1fWrtv3sKqCZt
         G2xfNjpHijn5OhfMn8QCdnD7c4ef32t0CISj5LaIW3IlPF9qvgat3OEkq90sRrU2GJP1
         VVGkLH3rydfrhltt3k7yuJB1qx/M+xVXOfCVTfeUzPHYzzNHVmU5BcDeXvwJ1+hjaC2Y
         HVOiYF0yh6h1ZCSO895oGKvdF8kMJplP2Cvrs4kbNGtpYIjiY0kMIaEbXsoTV1zyr3ts
         AJzO9MoVQNkiBEOvea1HtwRE+M/yl0/PPsrT4A8LEljR3AdwcPwMBHtv3nxAd1xduZBS
         k+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426517; x=1694031317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8kGGZ+yYzic7Nawq3DNrmlWB29Qsh1OZYatVeF7GGM=;
        b=aBNEndufs93YLWKZFGcs0OG+hLPlqWPeRPef+g9eXPhT9GCFD/S4a+Qn04Ls7akFIy
         hSJynw3yV1hZk4oG+IaWzq/JDmmlA42yypQ+bL6Guk+V0jTQBN0hi8i7myH+3PJvAsTi
         xF6AhIn2f0sJke/dlQ9KwXSavyh3tW86UJCO8Py+RgEpLkqpXqAHh2dcBAQD9msebjQc
         ghpvN9bchDz5zgPpzV65HlLz1PHC40hhOmSjNi74DV7igIrEwAjLEFfyFtA+vlnjcUHb
         tmp2ABgNMqFO8RmnBkT6S1M+Yzy5nwJ3jm+7TEoOgyd3fRoKhSQc4y0usAgu8ooY0st/
         1KFw==
X-Gm-Message-State: AOJu0YwAu4u5WHTKPe7rblFnpZpqHqaXCKHfOHPXgCRCZd+gKzgPY1YC
        41pUpr7z/eppLaT6/53wzHzDRbWBT1q1SGDw7km69g==
X-Google-Smtp-Source: AGHT+IHUnyWfOFAYID1o0vf2VVLGaIROgv5s/xgle655lK1ZczFXhZacdesCf6ewIfvbJsm//wQo+EaiCbHfEE/5a8w=
X-Received: by 2002:a25:6b07:0:b0:d78:3047:62c6 with SMTP id
 g7-20020a256b07000000b00d78304762c6mr3414264ybc.21.1693426517530; Wed, 30 Aug
 2023 13:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230825093531.7399-1-quic_nsekar@quicinc.com> <20230825093531.7399-5-quic_nsekar@quicinc.com>
In-Reply-To: <20230825093531.7399-5-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 23:15:06 +0300
Message-ID: <CAA8EJprLwi3QKgTksTeSWkjmhFL69PO8Zmc=j3VMfAr_UpXJ=g@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: ipq5018: Add USB related nodes
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Amandeep Singh <quic_amansing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 12:37, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Add USB phy and controller nodes.
>
> Co-developed-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 54 +++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..ff477923a823 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -238,6 +238,60 @@
>                                 status = "disabled";
>                         };
>                 };
> +
> +               usbphy0: phy@5b000 {
> +                       compatible = "qcom,ipq5018-usb-hsphy";
> +                       reg = <0x0005b000 0x120>;
> +
> +                       clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> +
> +                       resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +
> +                       #phy-cells = <0>;
> +
> +                       status = "disabled";
> +               };
> +
> +               usb: usb2@8a00000 {
> +                       compatible = "qcom,ipq5018-dwc3", "qcom,dwc3";
> +                       reg = <0x08af8800 0x400>;
> +
> +                       interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "hs_phy_irq";
> +
> +                       clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +                                <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
> +                                <&gcc GCC_USB0_SLEEP_CLK>,
> +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                       clock-names = "core",
> +                                     "iface",
> +                                     "sleep",
> +                                     "mock_utmi";
> +
> +                       resets = <&gcc GCC_USB0_BCR>;
> +
> +                       qcom,select-utmi-as-pipe-clk;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       status = "disabled";
> +
> +                       usb2_0_dwc: usb@8a00000 {

Could you please remove the `2_0' part of the label?

> +                               compatible = "snps,dwc3";
> +                               reg = <0x08a00000 0xe000>;
> +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                               clock-names = "ref";
> +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +                               phy-names = "usb2-phy";
> +                               phys = <&usbphy0>;
> +                               tx-fifo-resize;
> +                               snps,is-utmi-l1-suspend;
> +                               snps,hird-threshold = /bits/ 8 <0x0>;
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_u3_susphy_quirk;
> +                       };
> +               };
>         };
>
>         timer {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry

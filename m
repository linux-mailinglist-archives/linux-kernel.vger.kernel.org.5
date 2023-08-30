Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688178E0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbjH3UcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbjH3UcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:32:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A618EE99
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:45:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d746ea563f9so5623847276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693424624; x=1694029424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VJiEYvthVUOcpYJPy9yFGFD2aO5cf2VHnVMOssUOmRg=;
        b=ePdmGT9H+NNcqRumPz2z4DfI1stmMgT0TFsHhZg9dyx2Dbv4vAchsHZfwe1mabq9T5
         Xxz/NGz3MtpIzP/2MgoIKFydpia5KtjtiGcr1vlkk762rVmSm2cMs5C9oP9J/+/Du2dm
         XOYzN0gEsukkbZ/eWCg8fic+fe9Z1JBdJJ1QZKGLs1EBfP/iykHjJvICwNB4S60dSSi1
         rNT+AiHCUiP/Va12JdHHFWo94zWbqhVLJV0Y0bVetMOHYnUf8wZGpgfc27+C362mwnSU
         4kccF/9YWX58jJUfef2T+v31A0LHtqH79diMC3nwLGtTCOkyQr5cU+bNDdr9jtKSEzJR
         MqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424624; x=1694029424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJiEYvthVUOcpYJPy9yFGFD2aO5cf2VHnVMOssUOmRg=;
        b=ltzXFTZS1tJGG6omCzQ/5i81yPe9N7ZPbRAVkbEg2AyQE1MmCSUKLU3A5wzoJdzc9x
         Ayp5LT5hd76lyAqEyg2iKB0S+R8wgK120zR/qkIU5UnUs/k3H89wt0SbaVI2P7H9SDnl
         FztwwxhpidiB4IBl9Lleb+Q6mJHWJqYhGZXmd/zrprGtOMpdr4MrG81dxkjXZUMeMPTe
         do2VnguUwgya7rG3LX9WMh9/76gfuXQW9oNVg5lrMxZw1PHkWvAmZ6leBPkS5w6CS6C8
         0hm4sFbyOiLDxEpEdBI7RhE4txlJutJkbzeoTdp+vxMURBz1K73O686LW3q7tToYy4Lm
         PTKQ==
X-Gm-Message-State: AOJu0YwNLqak0i2ufPcypIvtfQWf4v4PWB+Ak5KWdTTNMtEnGls8+qXR
        K/icvmPfWFfRzDhwrTwRSQB5pj0nUjsxpS2jFnz4GQ==
X-Google-Smtp-Source: AGHT+IE2iDDTjFTVDoB3gZ4fX5lg6uyzcQRItrwWgsQ3B9T43cbbiyZMI0KSJ+aavpFonXZjy3iNu1t/WvVG3AWOXxc=
X-Received: by 2002:a05:6902:18cd:b0:d78:48b0:21d2 with SMTP id
 ck13-20020a05690218cd00b00d7848b021d2mr3630806ybb.3.1693424624644; Wed, 30
 Aug 2023 12:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230830111722.19380-1-quic_nsekar@quicinc.com> <20230830111722.19380-4-quic_nsekar@quicinc.com>
In-Reply-To: <20230830111722.19380-4-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 22:43:33 +0300
Message-ID: <CAA8EJpr3SnEXRENAgzdemANnYWvwM7Z-xyZYe335O45Jps91kg@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] arm64: dts: qcom: ipq5018: Add USB related nodes
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 21:30, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Add USB phy and controller nodes.
>
> Co-developed-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
> V2:
>         Fix ordering of the USB related nodes and use
>         generic node names.
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 54 +++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..917e4a2d8e64 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -93,6 +93,19 @@
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
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
>                 tlmm: pinctrl@1000000 {
>                         compatible = "qcom,ipq5018-tlmm";
>                         reg = <0x01000000 0x300000>;
> @@ -155,6 +168,47 @@
>                         status = "disabled";
>                 };
>
> +               usb: usb@8af8800 {
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

As we have seen from the next patchset, this host supports USB 3.0.
Can you please drop the 2_0 part of the label?

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
> +
>                 intc: interrupt-controller@b000000 {
>                         compatible = "qcom,msm-qgic2";
>                         reg = <0x0b000000 0x1000>,  /* GICD */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry

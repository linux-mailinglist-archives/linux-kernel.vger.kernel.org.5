Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B378C7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjH2OrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbjH2Oqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:46:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF695139
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:46:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58cd9d9dbf5so61169407b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693320412; x=1693925212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfw6V7LFqYsw0ItItmPglDYqzrcWxbzlv2UHVUeAG74=;
        b=Qv1HHbYet7wTAy3rg11WkrEiujtXYr/rlXOQu0l/gJM940a/S9fmxO0RASnbW3GEq8
         BxnN5niAf4gYx1bi4jkz+kDIMDSqckjcgHuTDZtLtrQgfbVu0Tebk2+ODGUaC76H6Nhq
         3WA/EyQ89de/fbUR0V3a7CbRHTjQU7r+XeqeMwklyHBDYgsfduboGxtsRm0+chL5yhuT
         nlZCJloJAGoX20Od0JYNDbLAhAAaMVS5gvbl9DShDeVWPbrmrJVY1cpxVZWL+7CLHhf7
         mVCCSZ1GaK/6cR3LP9QUO3S1oR9Ya8sCxVMLkYNzYzgWAs15/b1y1ePcCEHBg5PoBXSx
         YUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320412; x=1693925212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mfw6V7LFqYsw0ItItmPglDYqzrcWxbzlv2UHVUeAG74=;
        b=Sp5s/lRDw78eyIgzIIfhgnd43ma4O1scnshWWqiAr1/5nmcVXNVZckss5KUIYLwaYE
         6GkeIS9ZoDKENEcz+sXypyfj348b2ADhUahanXGOGJQUr3bBprFqnXsotceq61xqP0bV
         F/yxhju8YOgr4cat6SrwdTND/dyCNvNCFV3SUjHDOHVZpaA7+KUzxWgGpiEfk4b7X/YH
         87ONp27MyLmlUV6Q1th6OfHoeb8RHqjlV162r8bC4CfPF76H6chAgLTP8rERfQng3J+x
         Id4PS+s4f4noM9UxyeXy88j/MN1ZEnQm3gT5Ao3IGgcRNJFErMrIHk1+4teWwjcBFWiC
         SAjw==
X-Gm-Message-State: AOJu0Yxc6W/OacvM3yxM5B5xhsz07LEdldENajeed/SQGVf3UtqTUOiQ
        gtG/aRsxoeyIepz8DJGnnTjgvGZ3gVxUw0s/6EsBPw==
X-Google-Smtp-Source: AGHT+IEKmemJLC0tOe8DvGL0hEpWvrphbIpLY5kTOZufedvsfBX+7jKL52HwA0mwZ4wzjwkLvezDYDq17DF7cpctlO4=
X-Received: by 2002:a0d:eb0a:0:b0:581:7958:5bda with SMTP id
 u10-20020a0deb0a000000b0058179585bdamr2974154ywe.1.1693320411878; Tue, 29 Aug
 2023 07:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com> <20230829135818.2219438-7-quic_ipkumar@quicinc.com>
In-Reply-To: <20230829135818.2219438-7-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Aug 2023 17:46:41 +0300
Message-ID: <CAA8EJpp1+iHndFO5NVDvn2TxSxCmPG1Oa5o4-aYhQGCSQz8gbQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: qcom: ipq5332: Add USB3 related nodes
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
        peng.fan@nxp.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 17:00, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> Add SS UNIPHY and update controller node for USB3.
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> This patch depends on the below series which adds support for USB2 in
> IPQ5332
> https://lore.kernel.org/all/cover.1692699472.git.quic_varada@quicinc.com/
>
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 39 ++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index e6baf694488c..7fbe6c9f4784 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -158,6 +158,27 @@ usbphy0: phy@7b000 {
>                         status = "disabled";
>                 };
>
> +               ssuniphy0: ssuniphy@4b0000 {
> +                       compatible = "qcom,ipq5332-usb-ssphy";
> +                       reg = <0x4b0000 0x800>;
> +                       clocks = <&gcc GCC_USB0_PIPE_CLK>,
> +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +                                <&gcc GCC_PCIE3X1_PHY_AHB_CLK>;
> +
> +                       #clock-cells = <0>;
> +                       clock-output-names = "usb_pcie_wrapper_pipe_clk";
> +
> +                       clock-names = "pipe",
> +                                     "phy_cfg_ahb",
> +                                     "phy_ahb";
> +
> +                       resets =  <&gcc GCC_USB0_PHY_BCR>;
> +                       reset-names = "por_rst";
> +                       #phy-cells = <0>;
> +                       qcom,phy-mux-sel = <&tcsr 0x10540 0x1>;
> +                       status = "disabled";
> +               };
> +
>                 qfprom: efuse@a4000 {
>                         compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
>                         reg = <0x000a4000 0x721>;
> @@ -313,30 +334,34 @@ usb: usb@8a00000 {
>                         clocks = <&gcc GCC_USB0_MASTER_CLK>,
>                                  <&gcc GCC_SNOC_USB_CLK>,
>                                  <&gcc GCC_USB0_SLEEP_CLK>,
> -                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>,
> +                                <&gcc GCC_USB0_AUX_CLK>,
> +                                <&gcc GCC_USB0_LFPS_CLK>;
> +
>                         clock-names = "core",
>                                       "iface",
>                                       "sleep",
> -                                     "mock_utmi";
> +                                     "mock_utmi",
> +                                     "aux",
> +                                     "lfps";
>
>                         resets = <&gcc GCC_USB_BCR>;
>
> -                       qcom,select-utmi-as-pipe-clk;
> -
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
>
>                         status = "disabled";
>
> -                       usb2_0_dwc: usb@8a00000 {
> +                       usb3_0_dwc: usb@8a00000 {

At this point you have broken compilation of all ipq5332 DT files.
Don't. The kernel should be bisectable. At each point, after each
commit it should compile and work.

>                                 compatible = "snps,dwc3";
>                                 reg = <0x08a00000 0xe000>;
>                                 clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>                                 clock-names = "ref";
>                                 interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> -                               phy-names = "usb2-phy";
> -                               phys = <&usbphy0>;
> +                               phy-names = "usb2-phy", "usb3-phy";
> +                               phys = <&usbphy0>, <&ssuniphy0>;
> +
>                                 tx-fifo-resize;
>                                 snps,is-utmi-l1-suspend;
>                                 snps,hird-threshold = /bits/ 8 <0x0>;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

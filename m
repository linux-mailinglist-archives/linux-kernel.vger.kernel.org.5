Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BBF78E61D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjHaGH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbjHaGH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:07:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC971B1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:07:23 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d7bb34576b9so250032276.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693462042; x=1694066842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1po/VyT6CW/FcG+zIoswNK/rMTYjq0FDJTy3vZvpoPU=;
        b=C7qJ1A83fguHBpkifHIBu7qVWAqNxjbxDg/T27I4pweuopWEDWNclF5mAM3efR56zD
         eRdaVDZFHVDCFgTbzdx4Ucz4cVwV2r/5Cil98oqdKyxrVp++q3xtp9VLP9Kv0k3rG5cM
         YXN/f0mfzldSceI5CE6EfUJvYkABRYsyfYmKOCMJQH5evqVpcdBj5tPkR0jl8m3p7B5P
         E0QOCUyi2lyllDhB7ypRHN+OyrWoe2q1F5oySiu3IJhe24EWfQuVJBEM3idp8fV0oYcX
         WmR/BvLy1gOX7kgLPgdLa8oC8Y14QsMgeSNK0YIH/tzQjBrI9Eh233WP7AOkOEW+hlp5
         X2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693462042; x=1694066842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1po/VyT6CW/FcG+zIoswNK/rMTYjq0FDJTy3vZvpoPU=;
        b=Enk0SqmRB0vvSnDEcurhWJ6ARVER1FR0BveAT3WYCG1XcvafFgJkYfd0wnx4B8VPbV
         3Jl3QNcUF7D6DcaC+m7022GPRjjhKHelwUtWoyRUPQKC1VKvrp/Bo24lV/awJOiNzIfn
         r+ekfyvBb2UJGbwUA0Scn+zGZZvzWp5QMTMH/M46kYw9Cu/HTFiWRZLx4/Qo9x7ZhazT
         X13sUlUaTRAXmL+di35XTka6mA2zDTSPyEZyUYRKhgvu4aTfA3yVwOYvt7QK6IUqqf6i
         +isPbJ2HDHEPxkw5cUqeeBcNJTQQXTx91x/ffX1gHC0U81U5gYysFIt7remgLw0fE9+8
         iXYw==
X-Gm-Message-State: AOJu0YybxXUKmvX60DzsTCDxeFG3WWlneDWixsN16N51x9NtD7QqUWYN
        xP/qnx6aD10E1TLPk1/DCLLEkLFgSeNNTDcppR5sSw==
X-Google-Smtp-Source: AGHT+IGulseHwScThc3GA3p1UbyuFfZB7vLDPIIRlpt10tOewAolI9c+b8dZgUmCzK/Ra6yIpEiIpBuImZC0m1BhJWA=
X-Received: by 2002:a25:4655:0:b0:cfd:58aa:b36e with SMTP id
 t82-20020a254655000000b00cfd58aab36emr3944362yba.9.1693462042294; Wed, 30 Aug
 2023 23:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693459976.git.quic_varada@quicinc.com> <c914b91c82ce51023571b701a5b91606a0791025.1693459976.git.quic_varada@quicinc.com>
In-Reply-To: <c914b91c82ce51023571b701a5b91606a0791025.1693459976.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 09:07:11 +0300
Message-ID: <CAA8EJpqRfgh5Ss696Vi=jAR-yFmBhCrpveD8txHGHoc8gRsJxQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] arm64: dts: qcom: ipq5332: Add USB related nodes
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
        peng.fan@nxp.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
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

On Thu, 31 Aug 2023 at 08:39, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Add USB phy and controller nodes.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v10:
>         usb@8a00000 -> usb@8af8800
>         "make W=1 ARCH=arm64 -j 16 CHECK_DTBS=y DT_SCHEMA_FILES=qcom,ipq5332-usb-hsphy.yaml dtbs_check" passed
> v9:
>         usb2@8a00000 -> usb@8a00000
>         "make ARCH=arm64 -j 16 CHECK_DTBS=y DT_SCHEMA_FILES=qcom,ipq5332-usb-hsphy.yaml dtbs_check" passed
> v6:
>         Remove clock names
>         Move the nodes to address sorted location
> v5:
>         Use generic phy instead of usb-phy
>         'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom dtbs_check' passed
>         'DT_CHECKER_FLAGS='-v -m' DT_SCHEMA_FILES=qcom dt_binding_check' passed
> v4:
>         Change node name
>         Remove blank line
>         'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom qcom/ipq5332-rdp441.dtb' passed
> v1:
>         Rename phy node
>         Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
>         Remove 'qscratch' from phy node
>         Fix alignment and upper-case hex no.s
>         Add clock definition for the phy
>         Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
>         in dwc3/core.c takes the frequency from ref clock and calculates fladj
>         as appropriate.
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 55 +++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db..6593865 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -145,6 +145,19 @@
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               usbphy0: phy@7b000 {
> +                       compatible = "qcom,ipq5332-usb-hsphy";
> +                       reg = <0x0007b000 0x12c>;
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
>                 qfprom: efuse@a4000 {
>                         compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
>                         reg = <0x000a4000 0x721>;
> @@ -290,6 +303,48 @@
>                         status = "disabled";
>                 };
>
> +               usb: usb@8af8800 {
> +                       compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> +                       reg = <0x08af8800 0x400>;
> +
> +                       interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "hs_phy_irq";
> +
> +                       clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +                                <&gcc GCC_SNOC_USB_CLK>,
> +                                <&gcc GCC_USB0_SLEEP_CLK>,
> +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                       clock-names = "core",
> +                                     "iface",
> +                                     "sleep",
> +                                     "mock_utmi";
> +
> +                       resets = <&gcc GCC_USB_BCR>;
> +
> +                       qcom,select-utmi-as-pipe-clk;
> +
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       status = "disabled";
> +
> +                       usb2_0_dwc: usb@8a00000 {

Since we have just seen a patch series adding USB 3 support to
ipq5332, we know that the host is not 2.0-only. Thus the `2_0` part of
the label doesn't make sense.

Could you please change the label to be just usb_dwc (or usb0_dwc)?

> +                               compatible = "snps,dwc3";
> +                               reg = <0x08a00000 0xe000>;
> +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                               clock-names = "ref";
> +                               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
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
>                         reg = <0x0b000000 0x1000>,      /* GICD */
> --
> 2.7.4
>


-- 
With best wishes
Dmitry

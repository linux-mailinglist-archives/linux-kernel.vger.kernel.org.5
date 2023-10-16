Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE37CB38A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJPTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjJPTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:53:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D038F;
        Mon, 16 Oct 2023 12:53:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso2527234b3a.2;
        Mon, 16 Oct 2023 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486015; x=1698090815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Aw9zCawXUb/8I2OxKfjM/e6GKyR+BjkOIZEQ62H2Zw=;
        b=c7tgnsvt7Q3YjLOBpGVzi/iW2Ezp6z2oCizvoyPiSnU71FEU0j83JbIeu38Tf1wGFr
         V9oKf3UVWfAXzrxadmdisyyUTuLHLwCdU3/23juOhQe956z8ki0PHclHjBD8D3XYURQI
         78ZciA07hrs5me/ddfCXDFhmmHx2eGM8yLECbe7WKvjZ3VI8cptcLoAf2b5Jpm5IsG+7
         j3swQ0YUdwesL+XqkYZrm9FWO1yE7QU17O3WKAN8D4O0h1iqEbODNhZeNj38ZABMO5/a
         GO2nOp0hsZSwKK3QXLCPnjsIsM6AcLPDYcTmqX0uruCgqi3SnFciWz2w7ZQaPWOw0Xgu
         TX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486015; x=1698090815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Aw9zCawXUb/8I2OxKfjM/e6GKyR+BjkOIZEQ62H2Zw=;
        b=dahy8KlyYDmzm/TTu8haK+4vacDyrEQAamOQkL5Tsv2a2sJj7CsgK6dLnj977K32VO
         fv+kxE5YxD/ZUSbnBnE6pA0AOhx8kwp/71C4qzwXj7GAi6HFBz6dcI2STdq7Gq8tRwLd
         UpZa/ZrNi5Ci/mV64ZVKDXOgMX3yQTpaKX4afhmkDb4f0evY72jwSbMBQBRm8TjzUcma
         Q1EK8Lozd+nELFElQfe0u9S0N/Hvhfj1TcIbE/HayMM/ojgBJ9OC9yyAKKcrGgN842eL
         S+dwpDpwjeVH6hOP364USRBHMY0RmO9xLi4hVTRWk7QEMatzE6kqooCUag3GW6O06Pef
         nC/w==
X-Gm-Message-State: AOJu0Ywc2CUDX1OPlkplZYRvLyrlIszbfL1KwMALGrSTGEf5HlSYpvPU
        2pmi8q/3aAVCnRquVzwJZC5AThkUfRAv4qSkF+79H6Z1CXE=
X-Google-Smtp-Source: AGHT+IEQOEZXdolJNp1JITV8/L9l/6LP67wZMyacV/ckwildAEdj1yGHe4CN91DLgyD7Ws2aOy1t252iVGeg8QtSGT8=
X-Received: by 2002:a05:6a20:441b:b0:15e:d84:1c5e with SMTP id
 ce27-20020a056a20441b00b0015e0d841c5emr41050pzb.38.1697486014585; Mon, 16 Oct
 2023 12:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231004191303.331055-1-robimarko@gmail.com> <jxvpt2xo3fc2k7kflfsdov6uxpjpgqpomgmfvfgxwytejvkcgu@xwnfrg7be6qi>
In-Reply-To: <jxvpt2xo3fc2k7kflfsdov6uxpjpgqpomgmfvfgxwytejvkcgu@xwnfrg7be6qi>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 16 Oct 2023 21:53:23 +0200
Message-ID: <CAOX2RU6KfMeJRFKdo_Kmb2OxZ12TrB+mARo_1uLJB8JuFsv_3w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018: add QUP1 SPI controller
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 20:54, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Oct 04, 2023 at 09:12:30PM +0200, Robert Marko wrote:
> > Add the required BAM and QUP nodes for the QUP1 SPI controller on IPQ5018.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> I padded the spi node to 8 digits, and applied the patch.

Thank you for this, it was in my TODO but that is quite long.

Regards,
Robert
>
> Thanks,
> Bjorn
>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > index 38ffdc3cbdcd..484034e65f4f 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > @@ -146,6 +146,16 @@ sdhc_1: mmc@7804000 {
> >                       status = "disabled";
> >               };
> >
> > +             blsp_dma: dma-controller@7884000 {
> > +                     compatible = "qcom,bam-v1.7.0";
> > +                     reg = <0x07884000 0x1d000>;
> > +                     interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&gcc GCC_BLSP1_AHB_CLK>;
> > +                     clock-names = "bam_clk";
> > +                     #dma-cells = <1>;
> > +                     qcom,ee = <0>;
> > +             };
> > +
> >               blsp1_uart1: serial@78af000 {
> >                       compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> >                       reg = <0x078af000 0x200>;
> > @@ -156,6 +166,20 @@ blsp1_uart1: serial@78af000 {
> >                       status = "disabled";
> >               };
> >
> > +             blsp1_spi1: spi@78b5000 {
> > +                     compatible = "qcom,spi-qup-v2.2.1";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     reg = <0x78b5000 0x600>;
> > +                     interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
> > +                              <&gcc GCC_BLSP1_AHB_CLK>;
> > +                     clock-names = "core", "iface";
> > +                     dmas = <&blsp_dma 4>, <&blsp_dma 5>;
> > +                     dma-names = "tx", "rx";
> > +                     status = "disabled";
> > +             };
> > +
> >               intc: interrupt-controller@b000000 {
> >                       compatible = "qcom,msm-qgic2";
> >                       reg = <0x0b000000 0x1000>,  /* GICD */
> > --
> > 2.41.0
> >

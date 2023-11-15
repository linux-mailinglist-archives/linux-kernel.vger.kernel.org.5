Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A07EC501
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjKOOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344164AbjKOOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:20:49 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCFB3;
        Wed, 15 Nov 2023 06:20:46 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5875e2b27c5so3791983eaf.3;
        Wed, 15 Nov 2023 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058045; x=1700662845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zRzhPm3c+M8Un/Zr8NOWsl1w43drdEa/57A2+6LhAR0=;
        b=dv8YCuXrap5u0x0Cj8pBiPQWFcH76K0GnoQCnVulFJx6FgyyQC34z9b2KeYQ0XgwEk
         9Md07tho5ZdhBS39Wv5+/RkTZ24cnnoOrlYJBVMLF3TenhlbiiqmHbKdBF4HMrFqLYyE
         0RJmi9z5qaPwMo4dLLvKHyj6jXcNE8zlVJy8tObS3ebt9JvgRlHd/QXIx7t84RWrhHHJ
         NVYCzYQOnP7bbCjWkbrOwP2I1pCFC5BtUkuU/8/l5UU0Jn42o7Kvlz75vWpC6BG0z9sw
         feItmXbEcPjoroRXRmm8Hdkx5LmpvFi2gxYUxPA79LpBZOI3C16+b+o3k6+ozaAmR3SM
         lX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058045; x=1700662845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRzhPm3c+M8Un/Zr8NOWsl1w43drdEa/57A2+6LhAR0=;
        b=iAVVepGUh1QaHszsKfV5AT1PkSESEZUddhNbKxIfOmv4EjfqaDwc2VLzR35E57TkQI
         YEBbYylvGowqCbBCvJDPTn23k/StT0xzDhy6OjeJTAelyIZvvhBGB01xD8jLoai9kulr
         6Is3D9nXkhXL8DtLhYDxrMxlgnWk5M8QsacFs/Grw+VI3epncfhRq8Ig4UQbJor/htKw
         CE4DTI2fSspeWELvEb6J0VyjsZlyEPbMbCe+tN42mjlU5zy8s9tzk82fKeuIsAZjV26g
         zJdcebycZ9Fsu/j/U9Avt9/u1kmOyH5j9XCCzVoQNmZjikv0I0u9T79oon6qIaIm6egh
         4ToA==
X-Gm-Message-State: AOJu0YzzjSPITbgHUh5ZU5UqxQXyRLYHevLSu3jIeyhSu40AaKHOog3f
        +AIQPTjcNyPwpy3ShXl6R10pvUPcoGA3dQWGXwjPoQcPxvxAU6tVvqs=
X-Google-Smtp-Source: AGHT+IGgCQPO5AGAzVWQreep4+f8Cf5JoFhr99TFbJsA3HA10dx/TSsjPzMArk/MdWLinmM1y+jmvPo8Gx9x1KM32vo=
X-Received: by 2002:a05:6358:5e08:b0:16b:c4c9:1bfb with SMTP id
 q8-20020a0563585e0800b0016bc4c91bfbmr4707254rwn.30.1700058045535; Wed, 15 Nov
 2023 06:20:45 -0800 (PST)
MIME-Version: 1.0
References: <CACDmYyf4hxbuw+cpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com>
 <a3e35d3b-906a-4540-924c-0103cf32efa4@linaro.org> <CACDmYydnLQd0n9ACnTQ6P4wYf38eMzokyHrF7r6LisG4oTFtyg@mail.gmail.com>
 <5cd19f5e-baa6-47da-8730-fe0ddedff364@linaro.org> <CACDmYyeBbGVPxLh+dmWus=BEiM6rp-1Qn17_RhSyDywrWf8uLw@mail.gmail.com>
In-Reply-To: <CACDmYyeBbGVPxLh+dmWus=BEiM6rp-1Qn17_RhSyDywrWf8uLw@mail.gmail.com>
From:   Legale Legale <legale.legale@gmail.com>
Date:   Wed, 15 Nov 2023 17:20:33 +0300
Message-ID: <CACDmYycHgu8JKjRM6xrMeNkruEHMba+afXtSqLq5TCw3y-b0Zw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add QUP5 I2C node
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong file. sorry. This one is correct:

---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index e59b9df96..00a61de9d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -506,6 +506,21 @@ blsp1_i2c3: i2c@78b7000 {
                        dma-names = "tx", "rx";
                        status = "disabled";
                };
+
+               blsp1_i2c6: i2c@78ba000 {
+                       compatible = "qcom,i2c-qup-v2.2.1";
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+                       reg = <0x0 0x078ba000 0x0 0x600>;
+                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+                       clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+                                <&gcc GCC_BLSP1_AHB_CLK>;
+                       clock-names = "core", "iface";
+                       clock-frequency = <400000>;
+                       dmas = <&blsp_dma 22>, <&blsp_dma 23>;
+                       dma-names = "tx", "rx";
+                       status = "disabled";
+               };

                qpic_bam: dma-controller@7984000 {
                        compatible = "qcom,bam-v1.7.0";
--
2.42.0

On Wed, 15 Nov 2023 at 17:18, Legale Legale <legale.legale@gmail.com> wrote:
>
> update again:
>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index e59b9df96..822ac51a0 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -506,6 +506,21 @@ blsp1_i2c3: i2c@78b7000 {
>                         dma-names = "tx", "rx";
>                         status = "disabled";
>                 };
> +
> +               blsp1_i2c6: i2c@78ba000 {
> +                       compatible = "qcom,i2c-qup-v2.2.1";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x078ba000 0x600>;
> +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
> +                                <&gcc GCC_BLSP1_AHB_CLK>;
> +                       clock-names = "core", "iface";
> +                       clock-frequency = <400000>;
> +                       dmas = <&blsp_dma 22>, <&blsp_dma 23>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };
>
>                 qpic_bam: dma-controller@7984000 {
>                         compatible = "qcom,bam-v1.7.0";
> --
> 2.42.0
>
> On Wed, 15 Nov 2023 at 17:16, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
> >
> > On 15/11/2023 13:58, Legale Legale wrote:
> > > + reg = <0x078ba000 0x600>;
> >
> > This still doesn't look right.
> >
> > ---
> > bod

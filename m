Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7F7799A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjHKVio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbjHKVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:38:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B692684;
        Fri, 11 Aug 2023 14:38:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9e478e122so2212822a34.1;
        Fri, 11 Aug 2023 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691789916; x=1692394716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tOIRygGHqJzlUzfF/uSkWdJqqS+9A9x+HYIEeOFIdgQ=;
        b=CbRz4pVtl82kk6LQFp3kwV6MQgGJmdMyYkZ9VTwOFLDQX4hmx9PjsLpTcjnucJAeii
         NTjWxxhb66utGDicfd4v6Z/JmfI7RlxNVmMijP0zd8Xk9JZ2Zx5dI3u5n7smPlBki5x8
         97MXEgz0ohz+wm1dYIOUHppjO3FfJFp3Oi5VqTiyOSh1bydP+g7cEZb7Yif2dDjTlJdo
         DRSq+rFAy0nvPh4EVOpab0xWl1ONoMzbsP0YHTc4Pe6HLm71vArsJU3aEQsrSAsOytKL
         XGuVVUfxjJewDCwHZF/lTyh57Pa+dyitARSCLSdH8QSLRWYv1eFOIJvHb/pkpG3SK/He
         zRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789916; x=1692394716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOIRygGHqJzlUzfF/uSkWdJqqS+9A9x+HYIEeOFIdgQ=;
        b=D28s1VLZAVNhQbOpm3o0ERx+zZw7JYmDAskeErXkb5XGQDEhI7gK0pYphJv9JKChAG
         jTALkSSYw6Farrh6Gpr3xcyuhfRPRFz5MnIvdh1HLGr+IWf7EjKxcQfV65hKW0uIndcN
         QuY/tT4w8hXg063SzEqIVmnKvHSigJnnub6ggSNGvZhne65GwmGYeStrrQnkdKX7Jr9T
         r6WW4zOQY38LvaqkiPVQuCC+d9YpAKpOwCVvubwcl/O/TetlOYC3FitA1ug0N1H0RyU1
         SwlEMpLuDJWGuvo/AVVdwkHAo6UkL/M9OlfY4oIwTZHyVPfrajCvGbzuG7CI5Vk7PJhj
         v7bA==
X-Gm-Message-State: AOJu0YyC0sun4S9oDGJzOz75UOiy1dDDcqLld66ueLGXyUStfoqKQQVa
        ZrpGnut0E/8l8iDV/4WcAqJ7jh9/zTNPFgha0Y8thCps
X-Google-Smtp-Source: AGHT+IE8vPpyI7lFt0RBcu+1H2xBkTSKBvxWIdd7j9ZUa1W3hyhHQHCzrxLmztWrodQr9rFzSLUNX8h3VcXBYck5E5I=
X-Received: by 2002:a9d:6d81:0:b0:6b9:2869:bd81 with SMTP id
 x1-20020a9d6d81000000b006b92869bd81mr3087262otp.18.1691789915894; Fri, 11 Aug
 2023 14:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230811210142.403160-1-robimarko@gmail.com> <52fada0e-eb54-48de-88a9-0747a15ed1ce@linaro.org>
In-Reply-To: <52fada0e-eb54-48de-88a9-0747a15ed1ce@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 11 Aug 2023 23:38:24 +0200
Message-ID: <CAOX2RU7GPGMjqioKMR-pnTidztoCJ43UuLMJoG=DSph5EYvQvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq4019-ap.dk01.1: use existing
 labels for nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
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

On Fri, 11 Aug 2023 at 23:27, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 11.08.2023 23:01, Robert Marko wrote:
> > All of the nodes under soc already have existing labels so use those
> > instead.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> dtx_diff returns an empty diff, nice
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Couple further suggestions:
>
> - wdog can probably enabled unconditionally
> - same for blsp dma since there's only one host so it must be
>   used by something
> - same for crypto engine as it's a common piece of hw
> - you can drop mux{}, pinmux{}, pinconf{} from pin nodes, just add
>   the properties directly under the pin nodes
> - this devicetree could use some schema warnings cleanup (make dtbs_check
>   plus things like no underscores in node names)

Hi,
Yeah, I am planning a follow-up to clean up the pinctrl and most of
the stuff you mentioned
for the SoC DTSI itself.
I wanted to keep the diff clean here and just use the labels.

Regards,
Robert
>
> Konrad
> >  .../boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi | 140 +++++++++---------
> >  1 file changed, 69 insertions(+), 71 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> > index 0505270cf508..0714616c9e45 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> > +++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> > @@ -27,87 +27,85 @@ aliases {
> >       chosen {
> >               stdout-path = "serial0:115200n8";
> >       };
> > +};
> >
> > -     soc {
> > -             rng@22000 {
> > -                     status = "okay";
> > -             };
> > +&prng {
> > +     status = "okay";
> > +};
> >
> > -             pinctrl@1000000 {
> > -                     serial_pins: serial_pinmux {
> > -                             mux {
> > -                                     pins = "gpio60", "gpio61";
> > -                                     function = "blsp_uart0";
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     spi_0_pins: spi_0_pinmux {
> > -                             pinmux {
> > -                                     function = "blsp_spi0";
> > -                                     pins = "gpio55", "gpio56", "gpio57";
> > -                             };
> > -                             pinmux_cs {
> > -                                     function = "gpio";
> > -                                     pins = "gpio54";
> > -                             };
> > -                             pinconf {
> > -                                     pins = "gpio55", "gpio56", "gpio57";
> > -                                     drive-strength = <12>;
> > -                                     bias-disable;
> > -                             };
> > -                             pinconf_cs {
> > -                                     pins = "gpio54";
> > -                                     drive-strength = <2>;
> > -                                     bias-disable;
> > -                                     output-high;
> > -                             };
> > -                     };
> > +&tlmm {
> > +     serial_pins: serial_pinmux {
> > +             mux {
> > +                     pins = "gpio60", "gpio61";
> > +                     function = "blsp_uart0";
> > +                     bias-disable;
> >               };
> > +     };
> >
> > -             blsp_dma: dma-controller@7884000 {
> > -                     status = "okay";
> > +     spi_0_pins: spi_0_pinmux {
> > +             pinmux {
> > +                     function = "blsp_spi0";
> > +                     pins = "gpio55", "gpio56", "gpio57";
> >               };
> > -
> > -             spi@78b5000 {
> > -                     pinctrl-0 = <&spi_0_pins>;
> > -                     pinctrl-names = "default";
> > -                     status = "okay";
> > -                     cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
> > -
> > -                     mx25l25635e@0 {
> > -                             #address-cells = <1>;
> > -                             #size-cells = <1>;
> > -                             reg = <0>;
> > -                             compatible = "mx25l25635e";
> > -                             spi-max-frequency = <24000000>;
> > -                     };
> > +             pinmux_cs {
> > +                     function = "gpio";
> > +                     pins = "gpio54";
> >               };
> > -
> > -             serial@78af000 {
> > -                     pinctrl-0 = <&serial_pins>;
> > -                     pinctrl-names = "default";
> > -                     status = "okay";
> > +             pinconf {
> > +                     pins = "gpio55", "gpio56", "gpio57";
> > +                     drive-strength = <12>;
> > +                     bias-disable;
> >               };
> > -
> > -             cryptobam: dma-controller@8e04000 {
> > -                     status = "okay";
> > +             pinconf_cs {
> > +                     pins = "gpio54";
> > +                     drive-strength = <2>;
> > +                     bias-disable;
> > +                     output-high;
> >               };
> > +     };
> > +};
> >
> > -             crypto@8e3a000 {
> > -                     status = "okay";
> > -             };
> > +&blsp_dma {
> > +     status = "okay";
> > +};
> >
> > -             watchdog@b017000 {
> > -                     status = "okay";
> > -             };
> > +&blsp1_spi1 {
> > +     pinctrl-0 = <&spi_0_pins>;
> > +     pinctrl-names = "default";
> > +     status = "okay";
> > +     cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
> > +
> > +     mx25l25635e@0 {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             reg = <0>;
> > +             compatible = "mx25l25635e";
> > +             spi-max-frequency = <24000000>;
> > +     };
> > +};
> >
> > -             wifi@a000000 {
> > -                     status = "okay";
> > -             };
> > +&blsp1_uart1 {
> > +     pinctrl-0 = <&serial_pins>;
> > +     pinctrl-names = "default";
> > +     status = "okay";
> > +};
> >
> > -             wifi@a800000 {
> > -                     status = "okay";
> > -             };
> > -     };
> > +&cryptobam {
> > +     status = "okay";
> > +};
> > +
> > +&crypto {
> > +     status = "okay";
> > +};
> > +
> > +&watchdog {
> > +     status = "okay";
> > +};
> > +
> > +&wifi0 {
> > +     status = "okay";
> > +};
> > +
> > +&wifi1 {
> > +     status = "okay";
> >  };

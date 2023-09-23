Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B1C7AC485
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjIWSsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIWSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:48:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C2113
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:48:45 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f6492b415so3768517b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695494924; x=1696099724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEdulFVPqufczcNIh97Tnh5EKpIOJaJF3BWCbk1EgmM=;
        b=KBqKhDZ9TQ6AZwV9DsRZhWddDPzkpob5LW7Ggb+dqVckBBV2ZN5HEvwBzziuIcz0jE
         JH51sNacgZRnDfSGRLwJ2mtFSHNflqGwVZ+hxLy9usc0Bsvjym7ToFCjgKPM3QhPIzW+
         Ocf+mM2XYScA6knABUaYxx4WEfDin7nIJciCOrpnxUK1uaPvElPeg8ibU+RD8nACqjQM
         n6G8one1jWfZOUOMRQZAH5VU5J/yzVBR7Ne5pNRsKV2J1RLPLeisSqAvnHEq6GolDV7a
         xwes0EmEqGYwKtvvBPQjaceq6DnqWg8W9VC1jw1j+TMCudODH3o769d7ovP6mLHE2Wh+
         tTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695494924; x=1696099724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEdulFVPqufczcNIh97Tnh5EKpIOJaJF3BWCbk1EgmM=;
        b=tCtzOZu9BE53Oh3szTITgJR2NwhJwGzMXIb7/onZ4b8fqYhVCg/nbP1f6FsnTpVOk9
         mHqZomRd8StftsIiMkJgUoiSQYc5nxNomx1KqgVuKMyMbtJcVxCiv+JHuAx7ut0sgmJJ
         O0NFYt57i24NaYCOQRGrgk5bfB+Pvsx3E+HN4yzoKat9jleMsG7wofeOQTLwFOfGHQ1A
         cxtaV+Zq9RYah7IFsc+Rb2Y6TbCWuL9aXcv6ULP35g99EpDqX8S80UnmsvBG3SKEU/RU
         hwKCoxP3O2K2gAGtgS31IbGQsBKKEDcl/2L3KAoXtSrEK8Usi6jwCQ+Ql1kWG3uqGQqK
         qGbg==
X-Gm-Message-State: AOJu0YyWhhgwvfYq6FCAm/9b1CJnHAwknYGWg8qVG/17tPktUX6cp/8d
        oGyMQ6JKgcvwkBHXZgSQ8BTBSKVf1BGDtJ+wK4meJg==
X-Google-Smtp-Source: AGHT+IHhdpKMpRZAdSULnS8f0jLHBDk5yqdX16RMk5skeCvJAmb+6hR+raZSKvjfh/GAzFgsapmuINqufWxvhqn0Aso=
X-Received: by 2002:a0d:d949:0:b0:583:8c61:de8 with SMTP id
 b70-20020a0dd949000000b005838c610de8mr1910953ywe.16.1695494924153; Sat, 23
 Sep 2023 11:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
In-Reply-To: <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 21:48:33 +0300
Message-ID: <CAA8EJprMP5KW80Qfc6DQDhjsoHQzeXm9H4UiRPexQNqsPtUzbA@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq5018: Add tsens node
To:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_srichara@quicinc.com
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

On Fri, 22 Sept 2023 at 14:51, Sricharan R
<srichara@win-platform-upstream01.qualcomm.com> wrote:
>
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>
> IPQ5018 has tsens V1.0 IP with 4 sensors.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot. Adding all
> the 4 zones here.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Ordered the qfprom device node properties as per
>       Krzysztof's comments
>
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..9e28b54ebcbd 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -93,6 +93,117 @@ soc: soc@0 {
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               qfprom: qfprom@a0000 {
> +                       compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
> +                       reg = <0xa0000 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       tsens_base1: base1@249 {
> +                               reg = <0x249 2>;
> +                               bits = <3 8>;
> +                       };
> +
> +                       tsens_base2: base2@24a {
> +                               reg = <0x24a 2>;
> +                               bits = <3 8>;
> +                       };

Sort by the address, please, as usual.

> +
> +                       tsens_mode: mode@249 {
> +                               reg = <0x249 1>;
> +                               bits = <0 3>;
> +                       };
> +
> +                       tsens_s0_p1: s0-p1@24b {
> +                               reg = <0x24b 0x2>;
> +                               bits = <2 6>;
> +                       };
> +
> +                       tsens_s0_p2: s0-p2@24c {
> +                               reg = <0x24c 0x1>;
> +                               bits = <1 6>;
> +                       };
> +
> +                       tsens_s1_p1: s1-p1@24c {
> +                               reg = <0x24c 0x2>;
> +                               bits = <7 6>;
> +                       };
> +
> +                       tsens_s1_p2: s1-p2@24d {
> +                               reg = <0x24d 0x2>;
> +                               bits = <5 6>;
> +                       };
> +
> +                       tsens_s2_p1: s2-p1@24e {
> +                               reg = <0x24e 0x2>;
> +                               bits = <3 6>;
> +                       };
> +
> +                       tsens_s2_p2: s2-p2@24f {
> +                               reg = <0x24f 0x1>;
> +                               bits = <1 6>;
> +                       };
> +
> +                       tsens_s3_p1: s3-p1@24f {
> +                               reg = <0x24f 0x2>;
> +                               bits = <7 6>;
> +                       };
> +
> +                       tsens_s3_p2: s3-p2@250 {
> +                               reg = <0x250 0x2>;
> +                               bits = <5 6>;
> +                       };
> +
> +                       tsens_s4_p1: s4-p1@251 {
> +                               reg = <0x251 0x2>;
> +                               bits = <3 6>;
> +                       };
> +
> +                       tsens_s4_p2: s4-p2@254 {
> +                               reg = <0x254 0x1>;
> +                               bits = <0 6>;
> +                       };
> +               };
> +
> +               tsens: thermal-sensor@4a9000 {
> +                       compatible = "qcom,ipq5018-tsens";
> +                       reg = <0x4a9000 0x1000>, /* TM */
> +                             <0x4a8000 0x1000>; /* SORT */
> +
> +                       nvmem-cells = <&tsens_mode>,
> +                                     <&tsens_base1>,
> +                                     <&tsens_base2>,
> +                                     <&tsens_s0_p1>,
> +                                     <&tsens_s0_p2>,
> +                                     <&tsens_s1_p1>,
> +                                     <&tsens_s1_p2>,
> +                                     <&tsens_s2_p1>,
> +                                     <&tsens_s2_p2>,
> +                                     <&tsens_s3_p1>,
> +                                     <&tsens_s3_p2>,
> +                                     <&tsens_s4_p1>,
> +                                     <&tsens_s4_p2>;
> +
> +                       nvmem-cell-names = "mode",
> +                                          "base1",
> +                                          "base2",
> +                                          "s0_p1",
> +                                          "s0_p2",
> +                                          "s1_p1",
> +                                          "s1_p2",
> +                                          "s2_p1",
> +                                          "s2_p2",
> +                                          "s3_p1",
> +                                          "s3_p2",
> +                                          "s4_p1",
> +                                          "s4_p2";
> +
> +                       interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "uplow";
> +                       #qcom,sensors = <5>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
>                 tlmm: pinctrl@1000000 {
>                         compatible = "qcom,ipq5018-tlmm";
>                         reg = <0x01000000 0x300000>;
> @@ -240,6 +351,64 @@ frame@b128000 {
>                 };
>         };
>
> +       thermal-zones {
> +               ubi32-thermal {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&tsens 1>;
> +
> +                       trips {
> +                               ubi32-critical {
> +                                       temperature = <120000>;
> +                                       hysteresis = <2>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal {

'c' < 'u'. Please sort the nodes here.

> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&tsens 2>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature = <120000>;
> +                                       hysteresis = <2>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               top-glue-thermal {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&tsens 3>;
> +
> +                       trips {
> +                               top_glue-critical {
> +                                       temperature = <120000>;
> +                                       hysteresis = <2>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               gephy-thermal {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&tsens 4>;
> +
> +                       trips {
> +                               gephy-critical {
> +                                       temperature = <120000>;
> +                                       hysteresis = <2>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

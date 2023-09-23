Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780BC7AC4BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjIWTPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIWTPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:15:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F6FA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:15:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59be6605e1dso48442187b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695496537; x=1696101337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+4948fb5jd6vDg1SAZPDxyt4nxtgF6FkvMKpdW2w8s=;
        b=KdbjIevkTAtX45Cu/xTTpaH3+z+vLVFAgWGSIcWx5tre7v4awWVpbGn2xfQHVbZbcz
         3FYqLYJujgz0AnSEHuwe2XAYwJom6gEBbnM592/vMzhJEj3jpQIbPUiAuDcjAeMMIzK2
         3idKHB0vDVg4Fsna5E0ZOLt8zwiuEBRWBikcfWty8KWrLAAglIcSg42cbQXMe6eYNFki
         Ixeqss4yyMkuM48Pd7sQinupbU/OlhcycYYyL5lZXiGG51ZU6uw0yFBL8eda8fw0j/Gd
         m2Qf79QC9H4qp9ELuU2/FJcOOCG3yOYmnqOzpRJR/rVJCthostktm6o/QP1ne0zVnv1h
         Dhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695496537; x=1696101337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+4948fb5jd6vDg1SAZPDxyt4nxtgF6FkvMKpdW2w8s=;
        b=gIsYvVZOZB3Vrbqk8HWMs5/hvIlGWQaRfVnVn4R138AHjVvERyF7kYt+sIvlZgHM29
         WFeiiEZst5VBT1yr/xBe7GZHXnLUuIP5Ygh8mrSg8Puxcu6Y6daWHnQ+alFNdr9KrJb1
         DMPEb55k3V5ZSos8B7Gmwa/ehfGl3mZVktkmIcPw5TsYs8O4adbJZKL8ER7qgttMCXpi
         veQimF/5/VDHqoftym1xNEC2O22oEtxLRTgDGQ8Cb/wthmtPgu3R2mrnQ1+H9QiANSro
         4+UrkE9WhG5NJfLJNn/7ZRpJgRFs87/TOQ2C/QQ3r629TqQG5xNaYb9xEyo/+wUC/3ip
         YI3Q==
X-Gm-Message-State: AOJu0Ywo0CpZCffEbzfoDfGl/NxYsbSt96cldEtKPFstfJQpmgIvDQhJ
        N8MkK7oV+ybKHpj6dN0Lc2wHvkW2WbWXv8Ky8Qj0CA==
X-Google-Smtp-Source: AGHT+IE8chIe7tAZKiZeDtjzNPGf2QR43o43Y/GHZc7OAzvmh6HD54FasTjUGa4qUcnG4i/wOgwZAQRcwq7ZPmBNp5U=
X-Received: by 2002:a81:5385:0:b0:58a:f135:a4d8 with SMTP id
 h127-20020a815385000000b0058af135a4d8mr2772596ywb.38.1695496536875; Sat, 23
 Sep 2023 12:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230922084303.4164046-1-quic_gokulsri@quicinc.com> <20230922084303.4164046-4-quic_gokulsri@quicinc.com>
In-Reply-To: <20230922084303.4164046-4-quic_gokulsri@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 22:15:25 +0300
Message-ID: <CAA8EJpqpQkFLm13cf=4tOakCV2q1-FZv4vzBmfQURXNi5-do7A@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
To:     Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 11:44, Gokul Sriram Palanisamy
<quic_gokulsri@quicinc.com> wrote:
>
> Add the APCS, A53 PLL, cpu-opp-table nodes to set
> the CPU frequency at 800MHz (idle) or 1.008GHz.
>
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..a04b2019c779 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2023 The Linux Foundation. All rights reserved.
>   */
>
> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>  #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> @@ -36,6 +37,8 @@ CPU0: cpu@0 {
>                         reg = <0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_0>;
> +                       clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +                       operating-points-v2 = <&cpu_opp_table>;
>                 };
>
>                 CPU1: cpu@1 {
> @@ -44,6 +47,8 @@ CPU1: cpu@1 {
>                         reg = <0x1>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_0>;
> +                       clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +                       operating-points-v2 = <&cpu_opp_table>;
>                 };
>
>                 L2_0: l2-cache {
> @@ -54,6 +59,23 @@ L2_0: l2-cache {
>                 };
>         };
>
> +       cpu_opp_table: opp-table-cpu {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp-800000000 {
> +                       opp-hz = /bits/ 64 <800000000>;
> +                       opp-microvolt = <1100000>;
> +                       clock-latency-ns = <200000>;
> +               };
> +
> +               opp-1008000000 {
> +                       opp-hz = /bits/ 64 <1008000000>;
> +                       opp-microvolt = <1100000>;
> +                       clock-latency-ns = <200000>;
> +               };
> +       };
> +
>         firmware {
>                 scm {
>                         compatible = "qcom,scm-ipq5018", "qcom,scm";
> @@ -181,6 +203,24 @@ v2m1: v2m@1000 {
>                         };
>                 };
>
> +               a53pll: clock@b116000 {
> +                       compatible = "qcom,ipq5018-a53pll";
> +                       reg = <0x0b116000 0x40>;
> +                       #clock-cells = <0>;
> +                       clocks = <&xo_board_clk>;
> +                       clock-names = "xo";
> +               };
> +
> +               apcs_glb: mailbox@b111000 {
> +                       compatible = "qcom,ipq5018-apcs-apps-global",
> +                                    "qcom,ipq6018-apcs-apps-global";
> +                       reg = <0x0b111000 0x1000>;
> +                       #clock-cells = <1>;
> +                       clocks = <&a53pll>, <&xo_board_clk>, <&gcc GPLL0>;
> +                       clock-names = "pll", "xo", "gpll0";
> +                       #mbox-cells = <1>;
> +               };

Hmm, no, I was too quick to R-B. 0xb111 < 0xb116, please change these two nodes.

> +
>                 timer@b120000 {
>                         compatible = "arm,armv7-timer-mem";
>                         reg = <0x0b120000 0x1000>;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

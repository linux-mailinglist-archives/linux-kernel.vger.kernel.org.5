Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7CB78C32C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjH2LSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjH2LSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:18:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD5D7;
        Tue, 29 Aug 2023 04:18:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2040507a12.2;
        Tue, 29 Aug 2023 04:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693307899; x=1693912699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vlk1i2cYsDELx2MCzK/sMyn/sCrZUvmtF70BjbSKltI=;
        b=Ok8rveqqsGZjACqBaeopZj3bvjNSU8Zn6H7Pwh0eIGM1bQPTlwGdC3MigqGHofsPfX
         lRqUDQ5txtzYwtsz/E5L0pPYRB/BcMD/t3YxcmoTV2sAKvIk/m7ABF+obk3TGLN1L1kT
         unWFu1FIkO7Fpbs4PWsl3kLeKXtPEwKimtx6eBtkH0d7zVBVB6rsLlsBVv8MUGGTuGCj
         e9uwDYJxXEKTt7vB01yh7ldsrNYJArg4leMUrOqcWmowEmQ+MlY5smPQNnJdzz4RzKt6
         WmCZp0mmewtEbKy6dP/a2czGtEZqLlNyphVLPiRlaRcOIktP3ETNmSR5SdGcz+KezOoF
         9a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693307899; x=1693912699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlk1i2cYsDELx2MCzK/sMyn/sCrZUvmtF70BjbSKltI=;
        b=OEtt811KkvY0CGvRG+SZsdSaEFIj39Xlize31C6ClfAjVU+BUpIIMMzAap9yGt74fc
         vmPLBtaY24lrfSu7N8XAZ3I7imQvYgziohYKv2qvyVlD54+1x8+0JSbCybMQuybGw6BT
         W1XqiszlE+w5ce3YDdcEuz8Q3t5iM8JBXvIN4+JVKSPWqiTSrbX8poetlb4qEYixZoUy
         acVLH8Ha+4aEZMOsbq2tRKi6s0B+JW4DzZo3fvQzgMe5fM4Z4znPUdP2FwCGuLoNYrn3
         Ml/8QgUJdzis+8NrXklTtIEG4q6Ms7DlQdRM5767URT9LgmodgG/eLZQhLgmNkjo4xSl
         abRg==
X-Gm-Message-State: AOJu0YxEMm2e+oa+eFdIRpAbdPO+bCyh9RDXti1VLApqQO68Yc8S3Ejr
        ayXE35kP/dvZ7Kg9F/raneaYIt1Q+pqVVsRoy8s=
X-Google-Smtp-Source: AGHT+IEeEakQb1xWdvoU7KZagwPuUvUZCyMskARI53xS84/U8EOmnXk5P2yMYwR2Tnp+ni4coHCsFBkPUzDeN/Mfvp4=
X-Received: by 2002:a05:6a20:3d13:b0:14c:6a05:dfbf with SMTP id
 y19-20020a056a203d1300b0014c6a05dfbfmr11121964pzi.60.1693307898627; Tue, 29
 Aug 2023 04:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-4-quic_gokulsri@quicinc.com> <f457ee94-81d0-bd28-1432-ba2828dabb79@linaro.org>
 <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com> <0941e2f4-6b58-a4e7-3dda-c1723f5503ac@linaro.org>
In-Reply-To: <0941e2f4-6b58-a4e7-3dda-c1723f5503ac@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 29 Aug 2023 13:18:07 +0200
Message-ID: <CAOX2RU4j57H51ceYdKk9K-2ZNO7N4MDA6BOKrP2N3DNbphQAow@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 13:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/08/2023 12:56, Robert Marko wrote:
> >
> > On 29. 08. 2023. 12:12, Krzysztof Kozlowski wrote:
> >> On 29/08/2023 11:54, Gokul Sriram Palanisamy wrote:
> >>> Add the APCS, A53 PLL, cpu-opp-table nodes to set
> >>> the CPU frequency at optimal range.
> >>>
> >>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >>> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> >>> ---
> >>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 34 +++++++++++++++++++++++++++
> >>>   1 file changed, 34 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >>> index 9f13d2dcdfd5..05843517312c 100644
> >>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >>> @@ -8,6 +8,7 @@
> >>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>>   #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> >>>   #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> >>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
> >> c is before r.
> >>
> >>>
> >>>   / {
> >>>     interrupt-parent = <&intc>;
> >>> @@ -36,6 +37,8 @@ CPU0: cpu@0 {
> >>>                     reg = <0x0>;
> >>>                     enable-method = "psci";
> >>>                     next-level-cache = <&L2_0>;
> >>> +                   clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> >>> +                   operating-points-v2 = <&cpu_opp_table>;
> >>>             };
> >>>
> >>>             CPU1: cpu@1 {
> >>> @@ -44,6 +47,8 @@ CPU1: cpu@1 {
> >>>                     reg = <0x1>;
> >>>                     enable-method = "psci";
> >>>                     next-level-cache = <&L2_0>;
> >>> +                   clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> >>> +                   operating-points-v2 = <&cpu_opp_table>;
> >>>             };
> >>>
> >>>             L2_0: l2-cache {
> >>> @@ -54,6 +59,17 @@ L2_0: l2-cache {
> >>>             };
> >>>     };
> >>>
> >>> +   cpu_opp_table: opp-table-cpu {
> >>> +           compatible = "operating-points-v2";
> >>> +           opp-shared;
> >>> +
> >>> +           opp-1008000000 {
> >>> +                   opp-hz = /bits/ 64 <1008000000>;
> >>> +                   opp-microvolt = <1100000>;
> >>> +                   clock-latency-ns = <200000>;
> >> And the rest of OPPs?
> > Hi Krzysztof,
> > IPQ5018 only supports running at 1.1GHz, but its running at 800MHz
> > by default from the bootloader so there is only one OPP.
>
> Isn't this contradictory? If it is running at 800 initially, then it
> supports running at 800...

I can only guess that it's not validated at 800MHz.

Regards,
Robert
>
>
> Best regards,
> Krzysztof
>

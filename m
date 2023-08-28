Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2F78BA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjH1VUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjH1VUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:20:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2E3C3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:20:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a8614fe8c4so2838523b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693257603; x=1693862403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIuUKH5HwO1E9pbfeUQWlkWarmbqHgkNrbIq8Hrhtq0=;
        b=CZvl4j7uUfhlKcrWlrFV4x5q2sR/53TDV8j+rSvYGkY5OgkurpqG4/9LkRSmuTF+wx
         LjgtGQXk9xttxTEqVcurzxUWGAhiiV2Fb4HEngM2syV81d4G2zdmNym+YTfxBvLhMNhl
         3jvHyaFaOMhgT3Iuvr8eS56b6A1mZ0Ciya6noHmy2eruo1SjvKsv2XbOGdyom5aY1c2g
         nSCBfZSgWOp5ZMdaOb0+2IgfE6zzpuurhWNDjZqH3hw4ZvfXKby5q6IUnWL2NMj3gvKj
         HGJsYnnvV87BG4gJOg/2c/0sse7a+nktaBCQX8EvP7zS4zlmHRoSXBx6Y3WR1GRPPyQa
         HoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693257603; x=1693862403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIuUKH5HwO1E9pbfeUQWlkWarmbqHgkNrbIq8Hrhtq0=;
        b=MEbL3/9YEvZNT82qS6DQf8dkeZQRx1FYC3cLjNcxK+BeZRE2VM/4hlh9BLyR5KFv0E
         l5r+ygH6t79JUdLN6bk1h7asH1WvTWZRlZ4K6rt+GUWEDAEmyXRiFhgvWL5ABTRlSESt
         uL8dagws9ZPU5+WuMBmR/UcbSBAo13O+zjA4Gb7myB7d6dSGTmr1KhAyfkuZGTlgmQeF
         htRbNReo52L3mbwcXoUy/bgEPTg2hVQQha4Ya6SlJrZNRsOBCzxvu3ox1a+ZvAEJzcle
         Sna0TVQ0rUNoUO3jQEVZQ6o3kMWyuz2dLyD1Ug/2MfKoV+TsbJfTBzLoJBT1szOL8k72
         KiPg==
X-Gm-Message-State: AOJu0Yywoi7l0eGQOVagcK+aptcrSlPnuybjrtuVmV5bryozlbOh+gKo
        GsdepN5SLsavjiVH20NhVKAzhAttso7oTthGqbxF+g==
X-Google-Smtp-Source: AGHT+IFIR0wXTVo7lMdzb5cG9k85zy4w+X97lE+LJI5iBgLY8WXAYFNAyZCGRtaAEQNN8D/64HoFn6+DFjhGTKznGg4=
X-Received: by 2002:a05:6358:7248:b0:134:d282:92e9 with SMTP id
 i8-20020a056358724800b00134d28292e9mr30904076rwa.29.1693257602734; Mon, 28
 Aug 2023 14:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com> <1693250307-8910-7-git-send-email-quic_srichara@quicinc.com>
In-Reply-To: <1693250307-8910-7-git-send-email-quic_srichara@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Aug 2023 00:19:51 +0300
Message-ID: <CAA8EJpoxQkQFaF5qsqMF-fofkH2T+hVoOax_27DGuaVC1M+riQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: qcom: ipq5018: Add tsens node
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 22:20, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> IPQ5018 has tsens V1.0 IP with 4 sensors.
> There is no RPM, so tsens has to manually enabled.
> Adding the tsens and nvmem node.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..277b3cfc7f72 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -93,6 +93,29 @@ soc: soc@0 {
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               qfprom_nvmem: qfprom_nvmem@a0000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
> +                       reg = <0xa0000 0x1000>;
> +
> +                       tsens_calib: calib@248 {
> +                               reg = <0x248 0x10>;
> +                       };

NAK. Please define per-sensor fields here.

> +               };
> +
> +               tsens: thermal-sensor@4a9000 {
> +                       compatible = "qcom,ipq5018-tsens", "qcom,tsens-v1";
> +                       reg = <0x4a9000 0x1000>, /* TM */
> +                             <0x4a8000 0x1000>; /* SORT */
> +                       nvmem-cells = <&tsens_calib>;
> +                       nvmem-cell-names = "calib";
> +                       interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "uplow";
> +                       #qcom,sensors = <5>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
>                 tlmm: pinctrl@1000000 {
>                         compatible = "qcom,ipq5018-tlmm";
>                         reg = <0x01000000 0x300000>;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

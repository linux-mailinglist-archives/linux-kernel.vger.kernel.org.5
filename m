Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F137E3601
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjKGHkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKGHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:40:33 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F07EFC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:40:30 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-da2e786743aso5498680276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699342829; x=1699947629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmjk2S1gx+Mc5+ahgQ713WeG4CHwIeelidOIJhG+yrU=;
        b=gpbngZQoHZASwVRGuasiLGM2AJsGXd8wIwBhG3LDz013w6XGvRpn3XyuHQa6XKlvEL
         gt8itovHaqH3V0PDyvhQB3Z1SI2f3Z/FQBKKTNqddgydE5KNiwOoOpJTlliKqZnBKGOu
         30KX4mJbzoWSq5e4F5cnaErudG8FHVd1iN1V8QKljHU+Ss7DruYxEtQY9K5qBfCZnQtw
         KrbIJUwx23E4CHOxNvdKM3Y3kcXJ1FQ7sDlk0ShFeQN6A7Km4pnJAJ6pZa9ClynnTYHO
         qcDEd2iP3SCojjOpxjyGKhqa/IbvHOs6hM5xaHzS1vFv0e/uY5dP8rz8r6NBLeKQ0efu
         IfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699342829; x=1699947629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmjk2S1gx+Mc5+ahgQ713WeG4CHwIeelidOIJhG+yrU=;
        b=p/HYAlR9ROaQ3xf+FUEMlC+1r/evjiXgBmPoyemrufLw5bKlFVVWVxzd0YnizXCQsB
         e4tzq8ar125oLz2EofNBbbhwkJ2+zv2BJJgCAObow0ns2sQF4qzJO38/4UZVsFayefdG
         TJ3LstOAfotMEQ1Op8xItIxTOCOIee9JKQBrKbhDaJxRTyKD2ofuTq2lZBiY9r9k95bQ
         Ch4tFT0Sztzb1Cbp4jES0MqKkeu7jJWIl5rAjT9hBo2Le9Hud/B10SRpsUvk8Em6B0G+
         RuRE2uzMYJP5js5D7LnunyXb9LBLcKMP9Hq/pb7m2Lh6CcBX9dWKU75iJYrCXTFi3hws
         KX8Q==
X-Gm-Message-State: AOJu0YxxT+Lqhcp4KrSYMhvLTUJ4LW/Dn1s08GSqfPg9LK2ZbLqMLuqz
        ngaCrvuHYTf8o5hT18WB9DMgZTxmGdCFQWCk4RmKHw==
X-Google-Smtp-Source: AGHT+IEkezaO3xn+bZBw5zU5yiH9kZRM2ERBEPQaE0eEGpN1fDLHKGTNDxCLoAWK+RBxtSNwmsD3XxAQ4jHLyeMD6ow=
X-Received: by 2002:a25:25cd:0:b0:d9a:f949:45d1 with SMTP id
 l196-20020a2525cd000000b00d9af94945d1mr29426309ybl.13.1699342829481; Mon, 06
 Nov 2023 23:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231106144335.v2.6.I909b7c4453d7b7fb0db4b6e49aa21666279d827d@changeid>
In-Reply-To: <20231106144335.v2.6.I909b7c4453d7b7fb0db4b6e49aa21666279d827d@changeid>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 7 Nov 2023 08:40:18 +0100
Message-ID: <CACMJSeupvs4zkz9GiBwL5r+fN9qiqdpbcRgnifsBrZrQiFEaQg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] arm64: dts: qcom: sa8775p: Make watchdog bark
 interrupt edge triggered
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, swboyd@chromium.org,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 23:44, Douglas Anderson <dianders@chromium.org> wrote:
>
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
>
> Fixes: 09b701b89a76 ("arm64: dts: qcom: sa8775p: add the watchdog node")
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 13dd44dd9ed1..6b92f9083104 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -2235,7 +2235,7 @@ watchdog@17c10000 {
>                         compatible = "qcom,apss-wdt-sa8775p", "qcom,kpss-wdt";
>                         reg = <0x0 0x17c10000 0x0 0x1000>;
>                         clocks = <&sleep_clk>;
> -                       interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>                 };
>
>                 memtimer: timer@17c20000 {
> --
> 2.42.0.869.gea05f2083d-goog
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6F77F205
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbjHQIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348854AbjHQIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:24:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D72D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:24:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6874a386ec7so1404453b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692260675; x=1692865475;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtlgCIuryLaOllepBHuZqfvLXaBJxG5kP8A128x7u5w=;
        b=xjJFtNEn6A2iwld+nKGeQs3/p2ybWbTg3Dj9U+5W0saQV7IvsQxlfy5bir48RgqMjQ
         wKW7YRIPYUL8xAoxN7fP+9ItmpFP4HtE8HDh7NRxgcsD4XQrpn0VCcmtd0wuKAg/Y19D
         v45+N15hby6TF5peiRvF4Txdqu7lS7hXndpLX8ACz9BQeMWQBCTnLLbbP0uB6nv6Ij7X
         k33/tbBMqfoW54UA4xYm4F7H32Kinnz9KrRb6gc99IfTADI3U9ulW9DdW8TV4ydubOlV
         O65Roj7GnEOuXj32WLeGtMiyy2Aa4fx8INNogdlFelvdbSR7GNk2yXKN1LumAh+nHh0E
         G5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260675; x=1692865475;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtlgCIuryLaOllepBHuZqfvLXaBJxG5kP8A128x7u5w=;
        b=PZxUjSr2+2Y0HIwluAA46SZglwodvGh2DJmnZ3a9Fd8Q74+62zfiM6MUg3drdzwV4Z
         DB0IM4d/o//vKO6jP3ASTq/FRRo+nnotqkycPaotphuJqDcH5iuCUB/3JvhYyUW3BOf2
         7zbsvTC0XD5ADjIWufAH7Q0zM6hCX4fCOWBQIYBi0/HbrYt6IouJ0VChAUUnvfvzY3RV
         AxW3nUWx/hphpIQHOLp5kVbvS2wwnWlsL+XaaQNXu/qd9dagwb6DUvXv+dnCGUBv7pmZ
         BITWiR1xt1MjaL48161aGockOgrQjlGP42C5VrY7mD3Qbj0Osinb7QkxcFwix7oREQfW
         hsaQ==
X-Gm-Message-State: AOJu0YxJjD5ypT2FlbiGop2y3OpM219GF4IpQ/2ZgFCpvJqA+hkVKeSF
        daRMtzbgxX7YAIKTkLfUjJc57w==
X-Google-Smtp-Source: AGHT+IGbKSuG9QUnW5n7HhYT5Yo39hvyPnt3KADftYUSDRjRTT/dV+ZAQvNEpD/l4Tk+nLysp/mhwQ==
X-Received: by 2002:a05:6a00:4891:b0:668:834d:4bd with SMTP id dk17-20020a056a00489100b00668834d04bdmr4468593pfb.0.1692260675016;
        Thu, 17 Aug 2023 01:24:35 -0700 (PDT)
Received: from [192.168.0.224] (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id i15-20020a63a84f000000b005634343cd9esm13256965pgp.44.2023.08.17.01.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:24:34 -0700 (PDT)
Message-ID: <54f9b8db-e5e5-a109-3c96-1a215979661f@quanta.corp-partner.google.com>
Date:   Thu, 17 Aug 2023 16:24:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Move trogdor rt5682s bits
 to a fragment
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sheng-liang.pan@quanta.corp-partner.google.com
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
In-Reply-To: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Several trogdor boards have moved from the older rt5862i to the newer
> rt5862s, at least on newer revisions of boards. Let's get rid of the
> dts duplication across boards and promote this to a fragment.
>
> Note: The old boards used to override the "compatible" in the "sound"
> node with the exact same thing that was in "sc7180-trogdor.dtsi"
> ("google,sc7180-trogdor"). I got rid of that.
>
> This is validated to produce the same result when taking the dtbs
> generated by the kernel build and then doing:
>
>    for dtb in *trogdor*.dtb; do
>      dtc -I dtb -O dts $dtb -o out/$dtb.dts;
>    done
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   .../boot/dts/qcom/sc7180-trogdor-kingoftown.dts | 13 +------------
>   .../dts/qcom/sc7180-trogdor-pazquel360.dtsi     | 13 +------------
>   .../dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi    | 17 +++++++++++++++++
>   ...180-trogdor-wormdingler-rev1-boe-rt5682s.dts | 13 +------------
>   ...180-trogdor-wormdingler-rev1-inx-rt5682s.dts | 13 +------------
>   5 files changed, 21 insertions(+), 48 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
> index 36326ef972dc..d6db7d83adcf 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
> @@ -11,19 +11,13 @@
>   #include "sc7180-trogdor-parade-ps8640.dtsi"
>   #include <arm/cros-ec-keyboard.dtsi>
>   #include "sc7180-trogdor-lte-sku.dtsi"
> +#include "sc7180-trogdor-rt5682s-sku.dtsi"
>   
>   / {
>   	model = "Google Kingoftown";
>   	compatible = "google,kingoftown", "qcom,sc7180";
>   };
>   
> -&alc5682 {
> -	compatible = "realtek,rt5682s";
> -	/delete-property/ VBAT-supply;
> -	realtek,dmic1-clk-pin = <2>;
> -	realtek,dmic-clk-rate-hz = <2048000>;
> -};
> -
>   &ap_tp_i2c {
>   	status = "okay";
>   };
> @@ -84,11 +78,6 @@ &pp3300_dx_edp {
>   	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
>   };
>   
> -&sound {
> -	compatible = "google,sc7180-trogdor";
> -	model = "sc7180-rt5682s-max98357a-1mic";
> -};
> -
>   &wifi {
>   	qcom,ath10k-calibration-variant = "GO_KINGOFTOWN";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> index 273e2249f018..89034b6702f4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> @@ -7,13 +7,7 @@
>   
>   /* This file must be included after sc7180-trogdor.dtsi */
>   #include "sc7180-trogdor-pazquel.dtsi"
> -
> -&alc5682 {
> -	compatible = "realtek,rt5682s";
> -	realtek,dmic1-clk-pin = <2>;
> -	realtek,dmic-clk-rate-hz = <2048000>;
> -	/delete-property/ VBAT-supply;
> -};
> +#include "sc7180-trogdor-rt5682s-sku.dtsi"
>   
>   ap_ts_pen_1v8: &i2c4 {
>   	clock-frequency = <400000>;
> @@ -64,11 +58,6 @@ CROS_STD_MAIN_KEYMAP
>   	>;
>   };
>   
> -&sound {
> -	compatible = "google,sc7180-trogdor";
> -	model = "sc7180-rt5682s-max98357a-1mic";
> -};
> -
>   &wifi {
>   	qcom,ath10k-calibration-variant = "GO_PAZQUEL360";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
> new file mode 100644
> index 000000000000..66b8773309d4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Trogdor dts fragment for SKUs with
> + *
> + * Copyright 2023 Google LLC.
> + */
> +
> +&alc5682 {
> +	compatible = "realtek,rt5682s";
> +	/delete-property/ VBAT-supply;
> +	realtek,dmic1-clk-pin = <2>;
> +	realtek,dmic-clk-rate-hz = <2048000>;
> +};
> +
> +&sound {
> +	model = "sc7180-rt5682s-max98357a-1mic";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
> index 6225ab8329c3..842f07f16ed1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
> @@ -11,20 +11,9 @@
>   /dts-v1/;
>   
>   #include "sc7180-trogdor-wormdingler-rev1-boe.dts"
> +#include "sc7180-trogdor-rt5682s-sku.dtsi"
>   
>   / {
>   	model = "Google Wormdingler rev1+ (BOE, rt5682s)";
>   	compatible = "google,wormdingler-sku1025", "qcom,sc7180";
>   };
> -
> -&alc5682 {
> -	compatible = "realtek,rt5682s";
> -	/delete-property/ VBAT-supply;
> -	realtek,dmic1-clk-pin = <2>;
> -	realtek,dmic-clk-rate-hz = <2048000>;
> -};
> -
> -&sound {
> -	compatible = "google,sc7180-trogdor";
> -	model = "sc7180-rt5682s-max98357a-1mic";
> -};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
> index b40b068dad6a..084870323606 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
> @@ -11,20 +11,9 @@
>   /dts-v1/;
>   
>   #include "sc7180-trogdor-wormdingler-rev1-inx.dts"
> +#include "sc7180-trogdor-rt5682s-sku.dtsi"
>   
>   / {
>   	model = "Google Wormdingler rev1+ (INX, rt5682s)";
>   	compatible = "google,wormdingler-sku1", "qcom,sc7180";
>   };
> -
> -&alc5682 {
> -	compatible = "realtek,rt5682s";
> -	/delete-property/ VBAT-supply;
> -	realtek,dmic1-clk-pin = <2>;
> -	realtek,dmic-clk-rate-hz = <2048000>;
> -};
> -
> -&sound {
> -	compatible = "google,sc7180-trogdor";
> -	model = "sc7180-rt5682s-max98357a-1mic";
> -};

Reviewed-by: Sheng-Liang Pan 
<sheng-liang.pan@quanta.corp-partner.google.com>


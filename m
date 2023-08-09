Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D110776465
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjHIPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjHIPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:50:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A571FF7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:50:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b962535808so106117831fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691596240; x=1692201040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46f4DOm5f8bjmAikrqpO11mnxF7dM63WOtlMHZn0C0Q=;
        b=HN1zxTJCP/2vAz7dmEKE+hL704ePcs5q1/r/j7uDadccbVBrvTNMc54fhJjB4Y5yM2
         Ii/gf9Cpjc1vDsVRNBxnrPrzYPeuQSDznh1Sj1sJ5atU9DrDGFF29tOmtQMLdb4/YLGK
         +3G3WvPCyNRyPMIS6nkgLKN0fPTph75Joo854Wd3JKsbLgFrHqRLHcB7ogNHLmV5o5BF
         htSw72zWhVVf7/NzW44edc3nEOiWu/+W0YR8v7kQ0mBrDS893jNtRu+v7dn9Q3vLyV8g
         xqvSAIYJMuFvjHX7oTDItZkjQJ53NcKCYtzNypwWpH9wD9dHKR6BC+2AMOmFejSmc+j7
         Zx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596240; x=1692201040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46f4DOm5f8bjmAikrqpO11mnxF7dM63WOtlMHZn0C0Q=;
        b=kxE+9Wl94LBdjXDLLQvJHaJDBzios+dzJdyMGOMoMhDY+8tbqs90LDC3v5KUJ02bi5
         jRJQ7jGaLHxf1fS54+iO1nu2c4SUtV/Kj0EdKajbz8f9qg/wIand+evneF40A8P5I9n6
         wXdaM7M4Yqdb2vjL24eFGNlWIR5f8PW+n1XHl6cfcJuuRySqgk05URCCnak6bdpIAZ4/
         NbGQHz74NCYiHi0/pfAZgYxAvRXSwIhyB2mtsxJmKZYtkyFIS3hHtLFe5+k0TnIAvW6z
         6pIuDTpuOxwjLcYwN05pv/hG6AftlmpKVmGXLtDYbKXg1rQMPfHzpTrVQVSE0jWulkwc
         O5Tg==
X-Gm-Message-State: AOJu0YzmG9B/FTS6lsQNIWMX4KwcuOVOO78qFRcmTHQ/kbgaCIOlPOCs
        /bSBFiokiVzV6YJI552eO9s7zg==
X-Google-Smtp-Source: AGHT+IG+S1gR0OpIbx4BDE7ZzlDR2Xd7INlEvFqIR5HBZ0S2LxOMX0jaSQ+dl1QEP/FlWi/WBRmzrQ==
X-Received: by 2002:a2e:9395:0:b0:2b6:eefc:3e4f with SMTP id g21-20020a2e9395000000b002b6eefc3e4fmr2352748ljh.21.1691596240151;
        Wed, 09 Aug 2023 08:50:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090652c100b009927a49ba94sm8114047ejn.169.2023.08.09.08.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:50:39 -0700 (PDT)
Message-ID: <cd15df3a-eadc-13d6-7088-3ad785ea733e@linaro.org>
Date:   Wed, 9 Aug 2023 17:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc7180: Add board id for
 lazor/limozeen
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230809144516.v3.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809144516.v3.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 08:49, Sheng-Liang Pan wrote:
> add BRD_ID(0, Z, 0) = 10 for new board with ALC5682i-VS
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - sort out the node order alphabetically
> 
> Changes in v2:
> - correct newly create dts files
> 
>  arch/arm64/boot/dts/qcom/Makefile             |  5 ++
>  ...sc7180-trogdor-lazor-limozeen-nots-r10.dts | 40 +++++++++++++
>  .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  4 +-
>  .../sc7180-trogdor-lazor-limozeen-r10.dts     | 56 +++++++++++++++++++
>  .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts |  4 +-
>  .../dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 34 +++++++++++
>  .../dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 38 +++++++++++++
>  .../dts/qcom/sc7180-trogdor-lazor-r10.dts     | 30 ++++++++++
>  .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  4 +-
>  .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  4 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  4 +-
>  11 files changed, 213 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 337abc4ceb17..73e745fb1ff0 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -109,11 +109,16 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-kb.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-kb.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r4.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
> new file mode 100644
> index 000000000000..bfeddd287aaf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Lazor Limozeen board device tree source
> + *
> + * Copyright 2023 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180-trogdor.dtsi"
> +#include "sc7180-trogdor-parade-ps8640.dtsi"
> +#include "sc7180-trogdor-lazor.dtsi"
> +#include "sc7180-trogdor-lte-sku.dtsi"
> +
> +/ {
> +	model = "Google Lazor Limozeen without Touchscreen (rev10+)";
> +	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";

Isn't this duplicated with r9? Probably other places as well... or....

> +};
> +
> +/delete-node/&ap_ts;
> +
> +&alc5682 {
> +	compatible = "realtek,rt5682s";
> +	/delete-property/ VBAT-supply;
> +	realtek,dmic1-clk-pin = <2>;
> +	realtek,dmic-clk-rate-hz = <2048000>;
> +};
> +
> +&panel {
> +	compatible = "edp-panel";
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +};
> +
> +&sound {
> +	compatible = "google,sc7180-trogdor";
> +	model = "sc7180-rt5682s-max98357a-1mic";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
> index cef57c15b70b..e3f1f30a7fc3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
> @@ -13,8 +13,8 @@
>  #include "sc7180-trogdor-lte-sku.dtsi"
>  
>  / {
> -	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
> -	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
> +	model = "Google Lazor Limozeen without Touchscreen (rev9)";
> +	compatible = "google,lazor-rev9-sku6", "google,lazor-rev9-sku18", "qcom,sc7180";

Your patch 2 does not make any sense. Didn't you touch it in patch 2?
Really, what is happening here?



Best regards,
Krzysztof


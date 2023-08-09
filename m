Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1F775E82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjHIMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHIMJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:09:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328CDF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:09:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso11139756e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691582970; x=1692187770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbUhZJRH2Swt1RzSf7B35hlDtwAL49/ygLDb80eFcP4=;
        b=BkgaNaoHXX0hlw11AgXWgj0m0u7VA77dSFhiUp0EGHb3RCBjiyeiVdWwG8o71Yr8Zt
         wnNHEE7oJX2MqFtB7MmScpLRH2MadvADY4DrxMr+eEjkFyhUaI5W/3UbWemlQHuDLbGu
         CCpm8q8izp/dyh7iSb4A3SSS5j6EgNkLRO/2H9X4s1sZTubNZjQd4zilciYRJISn/nXo
         /OIr3yHmqnQ/yyw0rJWpENSZXj5PlUWDzHe73nwy86ntrWfMZ1f1kCS79DNhozyMondg
         iEh5JWPPALLRSturHgUO8b0PqmlBKe91NfT/huvi7CYyeatXJjAcOcvwtTZJMSLvZbyh
         Mq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582970; x=1692187770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbUhZJRH2Swt1RzSf7B35hlDtwAL49/ygLDb80eFcP4=;
        b=WODNwF3MTA6N756JTBD27wXTPEgW0nleiNXeXQeWXNI+nGSUWjoxZR9xt/Z+Hf0Iwe
         iOnDD62az85z2ZLHvfOS23FTjoEshbLBZKt0Vj4DGTM5nTUjLmxfZl04q0B36/Y8IKk8
         mbOO/UU8XbHZxrVN6RTxXq1ueEFh+Rvrj3VbWsZ6bzUjKSSBJ8ZWsatJpxEqCFnA8W1/
         uKaHpeeRkyPMPcFbaGYHDxjd9AUSf2cKo8B73hJY5Xc6CGWi6OF+L0+FoMjL/IJqGuF1
         h/1o69p+ZnBQv84FFJ0KBRdOzVGeVrAZbXtxQXlDcpHd3s2/Nt3AYiLOYzv2juN0+HBZ
         SY3A==
X-Gm-Message-State: AOJu0YziWeYCFSDOScY0kBnp70mY0Snl07/BKH2DzmgPNIofFSa9ZxT6
        E9T+D2gostK2vTjY73nUZAQ3fw==
X-Google-Smtp-Source: AGHT+IF29E3OmnCuwjbvDt3aIMmzcYelyrHGi1ocGJeV7t8JAzJn0TKLb2F/R2U9yb+6cTNYUqbSpw==
X-Received: by 2002:a05:6512:2094:b0:4f8:75cf:fdd7 with SMTP id t20-20020a056512209400b004f875cffdd7mr1646124lfr.22.1691582969858;
        Wed, 09 Aug 2023 05:09:29 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id c6-20020ac244a6000000b004fb8603f6e0sm2304491lfm.12.2023.08.09.05.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:09:29 -0700 (PDT)
Message-ID: <df22dd29-1e4c-4cce-952a-f513a86f0da5@linaro.org>
Date:   Wed, 9 Aug 2023 14:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine:
 Move default ov5640 to a standalone dts
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
 <20230809120432.1036405-6-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230809120432.1036405-6-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.08.2023 14:04, Bryan O'Donoghue wrote:
> At the moment we define a single ov5640 sensor in the apq8016-sbc and
> disable that sensor.
> 
> The sensor mezzanine for this is a D3 Engineering Dual ov5640 mezzanine
> card. Move the definition from the apq8016-sbc where it shouldn't be to a
> standalone dts.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 57 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 49 ----------------
>  3 files changed, 58 insertions(+), 49 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f15548dbfa56e..19016765ba4c6 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
> new file mode 100644
> index 0000000000000..6155fa92c717f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "apq8016-sbc.dts"
> +
> +&camss {
> +	status = "okay";
> +	ports {
If there's going to be a v2, please add a newline after status here.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

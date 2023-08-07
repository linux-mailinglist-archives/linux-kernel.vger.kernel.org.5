Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B23771A78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHGGes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHGGep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:34:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5F171B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:34:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso5763237a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691390081; x=1691994881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VckXP9ih2gwufm6/QhL4dWWMWgXntEp4Dns74V0TzJ4=;
        b=tJR+hd+xF0yj4KJR39+0WqH/oepHfK84vQ6Y68KrgJNCmFSPj2ZdNSvjTgtexwzukF
         bnOLEzszGnbqpyjoCaBBZroJq6hHgkHhTGsXvj1vr1D5Zst+Z6uLQVqg0xUeqZ9rTnxQ
         V2Dg7Zjo9MPawNMNA4winf+tQoEZ3yZoPmV0jwRa9NNM/4uplqt/ckOUvCTS/p/TOPuq
         CkRF4hkbsWhF4bVLkqlQdwDE1jXFpx40Vi5A3S4Iw6ByF0eNBIChs8Qkk9fAGvaeGyMJ
         br79r6MI2fRxd5XQURoGxhtWmS/WJM6RF6v7VLndZUEm8w+3UpCBWJdbQaLwRtBnWcT+
         5Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691390081; x=1691994881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VckXP9ih2gwufm6/QhL4dWWMWgXntEp4Dns74V0TzJ4=;
        b=eFDRoKQRrKE52qdg6gJeBRf1bKMT/gtcFQuStElOZ0GU1PxAKKxKoffkQB9xfaZFTH
         x2a3mx+KftQCWVtXsBue5NrQ4o0cG15jjKis3JbvDY7JjYqXH7ALB1Conq+OvJ9RQyO+
         cDHRonJlZndwxl+DrnLouK3npSUGYB5wUgoiCF5aqPc4vDIUaGkCJa1MtlkbljROMKiE
         Oh3VfPB0NBdyTmGinpN+JIU+MRvuaV7QxqNhZVmwp8Ra5SfLyKTVCBwqRfPA8jhEmrMI
         Z+x3C8BwPhk46hAvyzbIVsDA2JtUazL56d2Erp0pXhPk4slRzvyRxRsr/MPvq0AI9f8R
         YzQw==
X-Gm-Message-State: AOJu0YyQvShiIVfcbV5dVMhNANPkiaiqRR+JMBi6vmKsYNg+hhz6LT1U
        Ma62q9KmRPqC5FgiwIQn9q6rvg==
X-Google-Smtp-Source: AGHT+IHTINgxyjOOoNrLZot8r8/xIvRPrel16VzQDL9tJdMYNeKTjKgR2WsR49TfL56D48RgPuyLIQ==
X-Received: by 2002:aa7:c243:0:b0:522:3ebc:84b8 with SMTP id y3-20020aa7c243000000b005223ebc84b8mr7376875edo.12.1691390080734;
        Sun, 06 Aug 2023 23:34:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402015900b0052237dfa82fsm4723694edu.64.2023.08.06.23.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:34:40 -0700 (PDT)
Message-ID: <0cc71595-ba11-11d4-1fcd-865721ede3f9@linaro.org>
Date:   Mon, 7 Aug 2023 08:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Add board id for
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
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 11:58, Sheng-Liang Pan wrote:
> add BRD_ID(0, Z, 0) = 10 for new board with ALC5682i-VS
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
> 
> Changes in v2:
> - correct newly create dts files
> 


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
> new file mode 100644
> index 000000000000..5a58e94c228e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Lazor board device tree source
> + *
> + * Copyright 2023 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180-trogdor.dtsi"
> +#include "sc7180-trogdor-parade-ps8640.dtsi"
> +#include "sc7180-trogdor-lazor.dtsi"
> +#include "sc7180-lite.dtsi"
> +
> +/ {
> +	model = "Google Lazor (rev10+)";
> +	compatible = "google,lazor", "qcom,sc7180";
> +};
> +
> +&alc5682 {
> +	compatible = "realtek,rt5682s";
> +	/delete-property/ VBAT-supply;

No, don't delete properties. First of all, why you do not have this
supply here? I doubt it... Especially that this DTS has vbat-supply
regulator!

Second, define the properties where applicable instead.

> +	realtek,dmic1-clk-pin = <2>;
> +	realtek,dmic-clk-rate-hz = <2048000>;
> +};
> +
> +&sound {
> +	compatible = "google,sc7180-trogdor";
> +	model = "sc7180-rt5682s-max98357a-1mic";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
> index 960f7b7ce094..f74a1985cac6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
> @@ -13,8 +13,8 @@
>  #include "sc7180-lite.dtsi"
>  
>  / {
> -	model = "Google Lazor (rev9+) with KB Backlight";
> -	compatible = "google,lazor-sku2", "qcom,sc7180";
> +	model = "Google Lazor (rev9) with KB Backlight";
> +	compatible = "google,lazor-rev9-sku2", "qcom,sc7180";
>  };
>  
>  &keyboard_backlight {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
> index 438ab9cd3389..15dcf95da311 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
> @@ -13,8 +13,8 @@
>  #include "sc7180-trogdor-lte-sku.dtsi"
>  
>  / {
> -	model = "Google Lazor (rev9+) with LTE";
> -	compatible = "google,lazor-sku0", "google,lazor-sku10", "qcom,sc7180";
> +	model = "Google Lazor (rev9) with LTE";
> +	compatible = "google,lazor-rev9-sku0", "google,lazor-rev9-sku10", "qcom,sc7180";


This is not what your binding is saying. You just introduced new
dtbs_check warnings :(

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


Best regards,
Krzysztof


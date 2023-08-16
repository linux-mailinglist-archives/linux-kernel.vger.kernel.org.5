Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8587177D7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbjHPBcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241139AbjHPBcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:32:18 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34159272A;
        Tue, 15 Aug 2023 18:31:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76ad8892d49so486845485a.1;
        Tue, 15 Aug 2023 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692149511; x=1692754311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KC/cApFMvEYrEIpnwwSkCOWAaT1//dyx1th4I4Q+dsY=;
        b=D2FClF8/+NQzLwtJdJ+P9ZDqGWRgQfz4fcbWeXMybL1L6NldUSCuPVbn/I140LaqhO
         cXVo9rGv3MeiPYPzqfN8llzwOpVuSuVjn+sHGprngJZNqngouwNi96z3kkIWlY/aWJZ6
         slUrVEtJwkceETz0/AWe/8gN3CgvYRMeO7skJ19OmFOmIw6JtVE4dEbrEO5R9ZEE58xx
         GXqFgj9vyUyxY7ZfCsTAgEFNYOEjyUQkaUSL4NLjK1YcS89Urpmj0UgWAehJXAwCReFO
         omTENNYEvzUAFAmyoW93GIiOm2gnS9KbJF/t6JYHeZbzvNhQdTPP2UkNW/CJsH1tYe1N
         zcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692149511; x=1692754311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC/cApFMvEYrEIpnwwSkCOWAaT1//dyx1th4I4Q+dsY=;
        b=cBofYitUSDWHtg11m2JlhI+CPZRp1RcNShtWD88ZZRlGpBUctQ6tJQ3nUsglaPiJ73
         sYvbUCtYPB6PHJ5MT+6j12vQGXvIi/yLJzk51LlGxCrjO0uA7N18Ljh8v2o2+tQ+Aypu
         PEEO4lYsRchqcuRn9iCYcVkRjF2xA1bUP+n5EQqkned3PpLJlWGO/cqSN0p3rkYR6JoY
         DVZDT6vmgIkzXGL/KD+nyCm89MP9d9bCsJodkr5qMcSsLuiHe3t/LuqMiRK/e3zFyg8u
         n671t3PTl5HZLp0p+DzM3CMnW33fntcEYdqh7RG/Lef0CSjjTjTKja/+P62WlXFy4HC/
         qK3Q==
X-Gm-Message-State: AOJu0YxysvjdHzrokXsBkQyQE6/Z9M7QubF0jcDuE+ta2AAHBKML/TwD
        9+cAQFdlLSwJj5d6DOQ5QlBBgJ6aXmI=
X-Google-Smtp-Source: AGHT+IECe6gu8XItzWbODdfYRK/vYBZ7bFoQEUsWlillTnyh3Dz8ePUGXSXeV20G5qWlTM4QhDeItw==
X-Received: by 2002:a05:620a:40d2:b0:76c:d05f:99f5 with SMTP id g18-20020a05620a40d200b0076cd05f99f5mr629426qko.52.1692149511217;
        Tue, 15 Aug 2023 18:31:51 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::bdee])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a13c300b0075cd80fde9esm4123037qkl.89.2023.08.15.18.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 18:31:50 -0700 (PDT)
Date:   Tue, 15 Aug 2023 21:31:48 -0400
From:   Richard Acayan <mailingradian@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 2/6] arm64: dts: qcom: sdm670: Add PDC
Message-ID: <ZNwnBIDGZi11QT0P@radian>
References: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
 <20230811-topic-tlmm_wakeup-v1-2-5616a7da1fff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-topic-tlmm_wakeup-v1-2-5616a7da1fff@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:48:35PM +0200, Konrad Dybcio wrote:
> Add support for the PDC to enable deep sleep wakeup from external sources.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Apologies for not testing this. I am not subscribed to the mailing list
and just found this patch. You may CC me or ping me on #linux-msm if you
want anything tested on SDM670 hardware.

>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> index a1c207c0266d..da10f0a6d92e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -1169,6 +1169,16 @@ usb_1_dwc3: usb@a600000 {
>  			};
>  		};
>  
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sdm670-pdc", "qcom,pdc";
> +			reg = <0 0x0b220000 0 0x30000>;
> +			qcom,pdc-ranges = <0 480 40>, <41 521 7>, <49 529 4>,
> +					  <54 534 24>, <79 559 30>, <115 630 7>;

The <79 559 30> range is not continuous, just like on SDM845. While PDC
interrupt 93 is on hwirq 573, PDC interrupt 94 is on hwirq 609.

Another patch is needed to fix this because this was already applied.
This does not cause a regression, though, because the pinctrl driver has
no wakeirq map yet.

https://android.googlesource.com/kernel/msm/+/d8e93ac1450a783fc095f082b0e5324cedee2e75/drivers/irqchip/qcom/pdc-sdm670.c#108

> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0 0x0c440000 0 0x1100>,
>
> -- 
> 2.41.0
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D57D72BF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjJYR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:59:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E589137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:59:25 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2b1ae4c21so4126599b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698256764; x=1698861564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJzSg1LCsZbgXYBBMfyCHmwEzikv9hbs4ziD6OXdr+4=;
        b=BJp5dXz80mpNXyvvB8t4eANRcUTRAy7Poxq3k7K8j7prJ6jKan0a3YaoT3Vm2iV8+Y
         CA9lWspRP8+5epM2IoahpepKODDREJEmefCmeTjgJSHwCccLuxJ6a/Q2UyKITq3RP8bD
         k05aJ/o5LvWIfw7WZxlAsVI1bnO5DN1LtdZLsXY0wu/zmRcW7qLnN742zW4GU7QNdSSj
         4rCjlY1Oqdas28yjxTxahM1xTsu2WjtTVARjHP+x4j5wbVW/n1I835QladWEkZuFxfi7
         xrHUN8FnvByKPjJBxcpm4tE7fQDt0xK4qCTNeTbZpnS5zRWH6Yf6A4DmJSK6o8+pT4kr
         Y4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698256764; x=1698861564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJzSg1LCsZbgXYBBMfyCHmwEzikv9hbs4ziD6OXdr+4=;
        b=PLVLMvqtNqE+i5PSm9PdJiBIT3xE/gXBmFIKytENfM43mK9YY/GfSiGKEl5cYqq0Kc
         DOC+kQC44smivx4FlNdslA3rDD5oSxyxtB25cwyCEXZK2+doft6/4BcH0pLNwaOgExZb
         ED0RBrLG6rBKv7Ly0xcoAMZub3krtiE/7eRn/B6uZT7QAHax0lFuujofsGbpXMWp9AUw
         00zP2xQCmrRpEiCgPeIlM6S3+IM8+w79I2J4E1bIlGbhIkZnFJ9oR1bGkDJJc9fYwTM+
         fZoxCaq3DC3WedxqKflE0t5DO1u0RCVob1Jm9H20YdzP9h2aEAn721qP8QYuWUKCXwdK
         ExDg==
X-Gm-Message-State: AOJu0YzAGxLnJIyM3GDlmsJSDWswgT4CN9jvCKnud8DK2TQ+p/6Dc7YE
        wh54ccbAcmG4+UZfU6jJNpXQpvHv+PkUhIv6oVkRpA==
X-Google-Smtp-Source: AGHT+IHoB/2KCx6OrtNoY48m9+ezpWkb7vcjXpWehDBM+dTZ052IM8ZBnRON4E2iL8WXry/B9ZzrDaFkvElNc2CgCYQ=
X-Received: by 2002:a05:6808:1a1d:b0:3ae:1351:d0f with SMTP id
 bk29-20020a0568081a1d00b003ae13510d0fmr21772906oib.22.1698256764617; Wed, 25
 Oct 2023 10:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <1698253601-11957-1-git-send-email-quic_mojha@quicinc.com> <1698253601-11957-2-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1698253601-11957-2-git-send-email-quic_mojha@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 20:59:13 +0300
Message-ID: <CAA8EJpoeV9bqX=mZZ3RMrzqGQ+Hq1Nc_pr=vBjJbarNC4J+FRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8250: Add TCSR halt register space
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 25 Oct 2023 at 20:07, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> Enable download mode for sm8250 which can help collect
> ramdump for this SoC.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>  - Improved commit text.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index be970472f6c4..76f470a78608 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -671,6 +671,7 @@
>         firmware {
>                 scm: scm {
>                         compatible = "qcom,scm-sm8250", "qcom,scm";
> +                       qcom,dload-mode = <&tcsr 0x13000>;
>                         #reset-cells = <1>;
>                 };
>         };
> @@ -2543,6 +2544,11 @@
>                         #hwlock-cells = <1>;
>                 };
>
> +               tcsr: syscon@1fc0000 {
> +                       compatible = "qcom,sm8250-tcsr", "syscon";
> +                       reg = <0x0 0x1fc0000 0x0 0x30000>;
> +               };
> +
>                 wsamacro: codec@3240000 {
>                         compatible = "qcom,sm8250-lpass-wsa-macro";
>                         reg = <0 0x03240000 0 0x1000>;
> --
> 2.7.4
>


-- 
With best wishes
Dmitry

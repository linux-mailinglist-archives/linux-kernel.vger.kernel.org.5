Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C675B7F070C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjKSPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjKSPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:10:29 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43015126;
        Sun, 19 Nov 2023 07:10:25 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-586a516755aso2294739eaf.0;
        Sun, 19 Nov 2023 07:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406624; x=1701011424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UIvR5MQTDyaoA0l7ADQGaaV9mvqedh+AvuYjdvmLpY=;
        b=m7JztmLkFTijE0xXO+PJkmMC2FV8jeV1IzrRmwUwgutduUdK3J6sNMqyqF71UivZ1P
         72g5pH5p43Sf5ASeitM0NIPvHAfncWPyhuiUm/ihKMjZ8LsWEqan5YEPtEc4p02rr7Kd
         J1PyZF7HAh3udjcoFZx3rLOE0nD0l+VIyISuUDFgr/6oBOTMbVxVZ7SfDDFKYjekjNr4
         dyKxN2qEYlGLXIudsfocjb2B/gwe5HD/7ag8RZvccm4xg5QrpcZ/UG4Lv7Iv5sjDtbq7
         bMiDa+blMkZcC3CrqU7dy9uolBIpYfxNn0HIeVR+fPpr2HlqShqr0z/i4ahRBWZ7iZ7U
         p64w==
X-Gm-Message-State: AOJu0YzmQH6WQAf3A/MLDfYlWAzBhRTKso8ha7AsSgtZWasjUJDg7e2L
        IPxvoyEmyXwu0OxmEfLCsA==
X-Google-Smtp-Source: AGHT+IE54AGxoyNmjush3LIBd25JOSFJEyVezI5EOKIVvgtCLmSTCTzHFX2sqcg1lU5JohP7sA/wCw==
X-Received: by 2002:a05:6870:568d:b0:1e9:d5ac:dc9b with SMTP id p13-20020a056870568d00b001e9d5acdc9bmr2296357oao.25.1700406624495;
        Sun, 19 Nov 2023 07:10:24 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id s40-20020a05687050e800b001f938e6d904sm39749oaf.44.2023.11.19.07.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:10:23 -0800 (PST)
Received: (nullmailer pid 208689 invoked by uid 1000);
        Sun, 19 Nov 2023 15:10:19 -0000
Date:   Sun, 19 Nov 2023 09:10:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     conor+dt@kernel.org, luca@z3ntu.xyz, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        quic_kamalw@quicinc.com, andersson@kernel.org,
        andriy.shevchenko@linux.intel.com, sboyd@kernel.org,
        lee@kernel.org, cros-qcom-dts-watchers@chromium.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        linux-arm-msm@vger.kernel.org, lars@metafoo.de, agross@kernel.org,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, marijn.suijten@somainline.org,
        dmitry.baryshkov@linaro.org, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        quic_subbaram@quicinc.com, quic_amelende@quicinc.com,
        kernel@quicinc.com, konrad.dybcio@linaro.org, rafael@kernel.org,
        lukasz.luba@arm.com, robh+dt@kernel.org
Subject: Re: [PATCH V2 3/3] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Message-ID: <170040661849.208630.9288743740827489507.robh@kernel.org>
References: <20231116032644.753370-1-quic_jprakash@quicinc.com>
 <20231116032644.753370-2-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116032644.753370-2-quic_jprakash@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2023 08:56:44 +0530, Jishnu Prakash wrote:
> There are several files containing QCOM ADC macros for channel names
> right now in the include/dt-bindings/iio folder. Since all of these
> are specifically for adc, move the files to the
> include/dt-bindings/iio/adc folder.
> 
> Also update all affected devicetree and driver files to fix compilation
> errors seen with this move and update documentation files to fix
> dtbinding check errors for the same.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml       | 4 ++--
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml  | 2 +-
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml    | 6 +++---
>  arch/arm64/boot/dts/qcom/pm2250.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6125.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6150.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm660.dtsi                       | 2 +-
>  arch/arm64/boot/dts/qcom/pm660l.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8953.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8994.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8998.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pmi632.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi                 | 2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts                   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                | 4 ++--
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi               | 2 +-
>  .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 +++---
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts         | 2 +-
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                   | 8 ++++----
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c                     | 2 +-
>  drivers/iio/adc/qcom-spmi-adc5.c                          | 2 +-
>  drivers/iio/adc/qcom-spmi-vadc.c                          | 2 +-
>  include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h  | 2 +-
>  include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h | 2 +-
>  .../dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    | 2 +-
>  include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h | 2 +-
>  include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    | 0
>  include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h        | 0
>  44 files changed, 51 insertions(+), 51 deletions(-)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)
> 

Acked-by: Rob Herring <robh@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A784B7F9B72
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjK0IOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjK0IOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:14:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF9138;
        Mon, 27 Nov 2023 00:14:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9366C433C7;
        Mon, 27 Nov 2023 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701072881;
        bh=3qTRy2F6nIzhohgL6U9JKBvv0/WyY8i9YB8Pa1jwqoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HjLj4Es8Qcz0nTYQn5qvj64G45BJZTp09Oq/G8YT0WFtwaBlK4/9G/6sty4THEUQq
         17ABHg2kuSgGEqBkuDdykyrPL23ayOp112E8QAwGZQRu8ATu9Tni6Cmd9KjibhskGe
         EBYVsoX6S9VO1XziXK8idk+GeAx+L5ykVZ+qUNJDHLdWuq4LFQLwqgwuBpVk4xJZCS
         v83tYF5wpwBflqyROjIihArZG4RSYVa1zDJDbTWZ6rx1fU2LbDwEN0x3l5Kl9l7mv9
         SsWErUG8r0uDCzLug+efrQDwo944+KIqHfzgoPvX9aMt45ava8pradQ9oKKCHkSiT9
         Dsp9hjAdD3rKA==
Date:   Mon, 27 Nov 2023 08:14:32 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        daniel.lezcano@linaro.org, dmitry.baryshkov@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, quic_subbaram@quicinc.com,
        quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
        quic_kamalw@quicinc.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        lars@metafoo.de, luca@z3ntu.xyz, linux-iio@vger.kernel.org,
        rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        cros-qcom-dts-watchers@chromium.org, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [PATCH V2 3/3] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Message-ID: <20231127081432.GC1470173@google.com>
References: <20231116032644.753370-1-quic_jprakash@quicinc.com>
 <20231116032644.753370-2-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116032644.753370-2-quic_jprakash@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023, Jishnu Prakash wrote:

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

Acked-by: Lee Jones <lee@kernel.org>

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

-- 
Lee Jones [李琼斯]

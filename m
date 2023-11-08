Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C417E50B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjKHG70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:59:24 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D88170C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:59:21 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5ac376d311aso76273887b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699426761; x=1700031561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVTIO8c7GDpbBUI5Au96zNg85/4FppbjNNWZjh3ilek=;
        b=LKtcPnic6Ev+LKTVbdL6G4hsHjrDDD2+oozlgKOMsrHLKJxQ+yhnUPNj9hl57MSdE6
         bxElxJyBHoxRUiOH/M7RPlZxrlUDTEPnhxAP4lVgZVkCmReWsRZa5XDOgujCwMvMtGQN
         s008oKYPaOPkcvLP02CMqn9WXT5GBy6nqmapwr/Q+gTrbeLc+lvQpWqhVEaSFzDJLGCW
         6SesNurG7Ghj5HX5ymRktmqoo7bQHl+PN4/EhOiZ64kjA450WBvrhwa3UaF82C+/g304
         Qs1BVbslSMhg3yQyMRjPHJu4eGIT5LX9AOrlgXmxXielcPxTR2A2w24dDMqtsrNpEBQP
         uKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426761; x=1700031561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVTIO8c7GDpbBUI5Au96zNg85/4FppbjNNWZjh3ilek=;
        b=Z/s3ruUM7PwQUU/3j5Zfx9IfJejSDLvDWCkKjbXxaLnla0sjbHEpmjTpYulM63AG9U
         p8UMe2ToqXRaGaNzs42QuglkI9yPqcyZrKHdkfTBWjrMSJgxSDX9W29rDJ9eP6XXNQFR
         YDN6S1m/AwO8XGMv4aE3QdAy6MkWnd/cJlfH/fOQd2tk14sPv8MEn8w3AM55wKZA7Now
         iJhBVhP+odPyJncMdCd6szvdaMS7qCGQeq6urF0RpNuVs2Nr81EvvpMDnXBUd0ra72Tn
         S9fkj9syX83nHxTfnCdnmbiWE3D/z/NtoV8yIWNd5uwxs2KcCjhh7PVW63zHk0q+nGEP
         +fIQ==
X-Gm-Message-State: AOJu0Yz0NoxotRH5ZVZ97/NZYz9OnxPgXd08fcfPasqqnNI4pi58Q5+U
        tPOVjrpdap85ahESRwEEgl42IBO8+WfVBEYRTo2lWg==
X-Google-Smtp-Source: AGHT+IHMTyWcF003jwFaQ1bAeHP9M6YrhPGc1QmKasSSTMAJrurijP6q4ahDeWynBpe7JlLmpcc5pLYWoxPytUliSF0=
X-Received: by 2002:a0d:c7c4:0:b0:5a7:fd05:2af2 with SMTP id
 j187-20020a0dc7c4000000b005a7fd052af2mr847380ywd.2.1699426761166; Tue, 07 Nov
 2023 22:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com>
In-Reply-To: <20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 8 Nov 2023 08:59:10 +0200
Message-ID: <CAA8EJpogiYXVPCNXSu+kq29nbn1uxGDAYMn9+qk8CwDz0bfyjg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: Add LPG LED device description
To:     quic_huliu@quicinc.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        quic_uchheda@quicinc.com, kamalw@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 at 08:05, Hui Liu via B4 Relay
<devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>
> From: Hui Liu <quic_huliu@quicinc.com>
>
> Add LPG LED device description.

No. You are not adding "LPG LED device description". You are adding
definition for three LEDs.

>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/pm8350c.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> index f28e71487d5c..11b9f384d99c 100644
> --- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/spmi/spmi.h>
>
>  &spmi_bus {
> @@ -34,6 +35,27 @@ pm8350c_pwm: pwm {
>                         compatible = "qcom,pm8350c-pwm";
>                         #pwm-cells = <2>;
>                         status = "disabled";
> +
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       led@1 {
> +                               reg = <1>;
> +                               color = <LED_COLOR_ID_RED>;
> +                               label = "red";
> +                       };
> +
> +                       led@2 {
> +                               reg = <2>;
> +                               color = <LED_COLOR_ID_GREEN>;
> +                               label = "green";
> +                       };
> +
> +                       led@3 {
> +                               reg = <3>;
> +                               color = <LED_COLOR_ID_BLUE>;
> +                               label = "blue";

... and these particular LEDs are board-specific. Please fill them in
the board file instead.

> +                       };
>                 };
>         };
>  };
>
> ---
> base-commit: b9604be241587fb29c0f40450e53d0a37dc611b5
> change-id: 20231108-qcom_leds-c3b0b7029008
>
> Best regards,
> --
> Hui Liu <quic_huliu@quicinc.com>
>
>


-- 
With best wishes
Dmitry

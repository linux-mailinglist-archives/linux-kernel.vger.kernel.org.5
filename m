Return-Path: <linux-kernel+bounces-23037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D8082A68D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E27C288A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117910FD;
	Thu, 11 Jan 2024 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGRD47wE"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF0EC4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed4b84667so4298185276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704944297; x=1705549097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pAKdqWiRt7Jt8ttzovOLnTm2MmS1cXyP0ylsS3FmwGc=;
        b=YGRD47wEjY7pYsUEox5Yh+/B60QM2XFJD+T3COZ5FUGGoMC0IfSvCOYZObj73/6UMR
         DEEKtP3Lp/mfRCwDH+iV8CgH+nLK0AX0RyK/JzKh5m1YeEoALJGZTaZ2Uk32eZuwJIjI
         5T/Z4FIciwQ5pJLe4/9LISQojjAsDdKD8XLeOGJja+m3ZZ5AftiOSASp9It51PwY4ZdN
         cGXDtYTuuj+ZVHQBlrQhP75zGJKGyJOxdT9GEZtIjIz+kfQX0Dpmfenx2znCUmeaOxi+
         XC9dfpDN03l+kGFp2wpFgrMo75EXd/oUkVstBhPtQTwadHVuHJHXLIqIRmEHxh+SmKhL
         ZYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704944297; x=1705549097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAKdqWiRt7Jt8ttzovOLnTm2MmS1cXyP0ylsS3FmwGc=;
        b=b9QfjWUnZ/HvLECSi5Cqlmsju42Qov7osIGm1bhnlmYXHzASkmWYSCB/jHdNkyrFbz
         /chQEqkGVMFvl/jn63fYXnK4bckqIxL8CYRt7ro5lyZWUta4YL2b8zs5KoCKFF5DVXwc
         PlOz3vZBeD9xfpLsSLr9kX0Bo/xnHfu3NqV/Pl2pDAkeZhJ9WeN6GdcfwkhuMHGBjC3Y
         NDObUcVoqFxkLzHWf6JU6vhRsnPtNd4RZUyTP7j/dy4XVloXyzPVJHC7/8hUCADbkYJk
         qF7pcbl42Z+v47EdFc9+qFsuCpwgDQpti11yifi5O7xuGzuBsxc1Z80ZYA31pSFCFteO
         wDbQ==
X-Gm-Message-State: AOJu0YzzK0EO3cODvZSIcMfS/gCyp0tKO+C6YSacVVyhwHNhiq9TR9Ak
	JOnck8MHTbztKcEH3FRH1DB1pt35zdwpkYy8SUQMmtDvm8R/Ig==
X-Google-Smtp-Source: AGHT+IFUPrQKhx3J+D6Zwfbk/UcEPw4iBwmtCyH6Ehsmm5XNg5mxGl9snqDtKuIKAJQbpgFkfIkXaDarbOEB6KttQ4Q=
X-Received: by 2002:a25:ea4b:0:b0:dbd:bf0d:d97f with SMTP id
 o11-20020a25ea4b000000b00dbdbf0dd97fmr493340ybe.126.1704944296914; Wed, 10
 Jan 2024 19:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111-lpg-v3-1-811c9e82dae4@quicinc.com>
In-Reply-To: <20240111-lpg-v3-1-811c9e82dae4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jan 2024 05:38:05 +0200
Message-ID: <CAA8EJpq-hYrM-JzJ5-0iSfH3gYYJawsDWDj51N1H7_fCJQvaCA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] arm64: dts: qcom: qcs6490-idp: Add definition
 for three LEDs.
To: quic_huliu@quicinc.com
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 04:54, Hui Liu via B4 Relay
<devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>
> From: Hui Liu <quic_huliu@quicinc.com>
>
> Add definition for three LEDs to make sure they can
> be enabled base on QCOM LPG LED driver.
>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
> Changes in v3:
> - Rephrased commit text and updated the nodes to qcm6490-idp board file.

The commit message is the same as in v2.

Commit subject mentions non-existing board, "qcs6490-idp"

> - Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/
>
> Changes in v2:
> - Rephrased commit text and updated the nodes to board file.
> - Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 37c91fdf3ab9..f801144a1556 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -5,6 +5,7 @@
>
>  /dts-v1/;
>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
>  #include "pm7325.dtsi"
> @@ -414,6 +415,30 @@ vreg_bob_3p296: bob {
>         };
>  };
>
> +&pm8350c_pwm {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       status = "okay";
> +
> +       led@1 {
> +               reg = <1>;
> +               color = <LED_COLOR_ID_RED>;
> +               label = "red";

Is there any reason why Krzysztof's review for v2 was ignored? Let me
repeat it here: "Drop labels. You already have color, so you miss
function."


> +       };
> +
> +       led@2 {
> +               reg = <2>;
> +               color = <LED_COLOR_ID_GREEN>;
> +               label = "green";
> +       };
> +
> +       led@3 {
> +               reg = <3>;
> +               color = <LED_COLOR_ID_BLUE>;
> +               label = "blue";
> +       };
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
>
> ---
> base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
> change-id: 20231215-lpg-4aadd374811a
>
> Best regards,
> --
> Hui Liu <quic_huliu@quicinc.com>
>
>


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-94070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309B873962
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FAA2893CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A58134CFE;
	Wed,  6 Mar 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1xOPHrw"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B2134742
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735934; cv=none; b=GFYcVE1H76l4UJp8YNgOOzq+cWq9KWTCwP2kKnuL7xP/sj2BQ+sDTuwZXnTqUFPpF5yU+Xvzdjba5bH6dmYqD/KF7yqJK8qRGlayeEhnxn9PrEOWi4W6t8Si90ddfa6mDJpPOQNLbz+dY35qUFwR/VMA5+7QBP7imzvbpY7OpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735934; c=relaxed/simple;
	bh=MpDhnAN5CnsD+9jk7y8K5Rh89xQkvphbiPN/Uv8voGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRLmEztFyUcr8o85klbYjPT+/YM9eAiXyKCUYKa0MQnUoNBd4rqbJjmIwcdqNzV9uwIrK/coYtLmp7NyymsO3htFm52zjJl5cDa3ogfmPG3MvOZZOjBtsZ0omX0dJ6N4ASJ+BmBnNQjprPjHCnL81wMJGJyO0HVwffO09jDnVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r1xOPHrw; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6098b9ed2a3so45119867b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709735931; x=1710340731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rgn+fbiALcH1MSWgsS+x3nP7X4DPXs1x86Sf7OmjGBo=;
        b=r1xOPHrwgV5dM3UbpeRD/cFuvB5DcPkxwBKDLU+KUmIAaq4AQdiopCEq8k6+7h2tzY
         5aF17Arp0Jtdqp363qHRHkuyQiJZTFOLPdGrECcDmZL/bibf5u5eqoG9yB4y9o3AJVK5
         etAcR7eKEnsEbSxMNBYmQutLfxil9HyA615ynE80O/FioF+Gv4Jhd9Ly0iw2Ii8hZQ0e
         IBhBFnItBiDieLB/ivt5w9ZgRQdoKldwbm4UHtG5HR9ECrZhNrkMHBWju3w/+D5ytkBi
         APs2V0RuhUg6jpXTgwTYsr8KGkhODSCgPedMf1hfB4bupMbwmY+4mcVnnS4g+K8eRaaB
         0SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735931; x=1710340731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgn+fbiALcH1MSWgsS+x3nP7X4DPXs1x86Sf7OmjGBo=;
        b=HKk/7gUeGdgGbNDA40KST97RSBAWj/O4AhDiTblzyxqP74DZMrB+/HeTFr1FqAp+Sz
         M3ucnU/Wes2UYJAB1QZKA04I9SdwlhWmpjpBymF3E3Ewxf27thR/rhfa6oys3RR7Pk/P
         USegwKejqqSW43l8CAxpxyOKTbP0pry2Vznlz+DMemoVXWm3RjulcHjTGHeMHbwyeB1i
         r9lrekSMTZzMapmLZHuD7Fu3mzLDobdt/92lyDLCHsH8NjI0lrH/fD1+q1IMchCAy0QZ
         mvMp2fZfH9Yl9Wl3idl0ei631Q9rITpNri1k3BaDUarauDJRSkjL7YP8g88g5Li2MtCf
         /1NA==
X-Forwarded-Encrypted: i=1; AJvYcCVLg0kvNjJUTkWbXdTwpeFVXKRmf5FmidbeoBiBjws4YBiO2nfYYAZR+cZ/UM5ba60hVzzfBg0RuA6luRDdxEdZc8kwgxhd/YmTP9XZ
X-Gm-Message-State: AOJu0Yw7RCxRI/uRqzhC3J5JPvXO/O42ukeR4Otz8sxSaKXyTYhgHq71
	TpIeJ+9j9gshCCw6ZHXFb5IvMCcJAWoIpEw0xMqMyQyEFKBuMJ5otcGfy3kekM3qdLLE5xi3yNf
	bS6ZyP1kss72xwWHbPW/8tMqffZhxKMfCDsFWBg==
X-Google-Smtp-Source: AGHT+IFU4SEZqLUrGH6c45A1ZNc5qs3PQbwPEvpYh7FSf640PTQvR0Ll56BpqrWHESawBKra7g21wOXC08a/J9trnYQ=
X-Received: by 2002:a0d:d341:0:b0:609:7354:6b11 with SMTP id
 v62-20020a0dd341000000b0060973546b11mr14830225ywd.52.1709735931599; Wed, 06
 Mar 2024 06:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306140306.876188-1-amadeus@jmu.edu.cn> <20240306140306.876188-4-amadeus@jmu.edu.cn>
In-Reply-To: <20240306140306.876188-4-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 16:38:41 +0200
Message-ID: <CAA8EJprc_xjejMANBjDkA2_FnRcYSJYsmM4VOvsKu1FkuMvGeg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: ipq6018: move mp5496 regulator
 outside soc dtsi
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 16:04, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Some IPQ60xx SoCs don't have the mp5496 pmic chips. The mp5496
> pmic is not part of the ipq60xx SoC, and the mp5496 node is
> the same for devices with pmic, so create a common dtsi.

Please inline this dtsi file into the board file. While it might seem
to make life easier, having such includes makes following regulator
settings much harder. Especially once a board or two start overriding
or expanding those settings.

>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts |  1 +
>  arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi | 29 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 14 ----------
>  3 files changed, 30 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> index f5f4827c0e17..8331890e529e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>
>  #include "ipq6018.dtsi"
> +#include "ipq6018-mp5496.dtsi"
>
>  / {
>         model = "Qualcomm Technologies, Inc. IPQ6018/AP-CP01-C1";
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi b/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
> new file mode 100644
> index 000000000000..841fd757bee7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +&rpm_requests {
> +       regulators {
> +               compatible = "qcom,rpm-mp5496-regulators";
> +
> +               ipq6018_s2: s2 {
> +                       regulator-min-microvolt = <725000>;
> +                       regulator-max-microvolt = <1062500>;
> +                       regulator-always-on;
> +               };
> +       };
> +};
> +
> +&CPU0 {
> +       cpu-supply = <&ipq6018_s2>;
> +};
> +
> +&CPU1 {
> +       cpu-supply = <&ipq6018_s2>;
> +};
> +
> +&CPU2 {
> +       cpu-supply = <&ipq6018_s2>;
> +};
> +
> +&CPU3 {
> +       cpu-supply = <&ipq6018_s2>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 064b5706a289..823b87fdcefd 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -43,7 +43,6 @@ CPU0: cpu@0 {
>                         clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>                         clock-names = "cpu";
>                         operating-points-v2 = <&cpu_opp_table>;
> -                       cpu-supply = <&ipq6018_s2>;
>                         #cooling-cells = <2>;
>                 };
>
> @@ -56,7 +55,6 @@ CPU1: cpu@1 {
>                         clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>                         clock-names = "cpu";
>                         operating-points-v2 = <&cpu_opp_table>;
> -                       cpu-supply = <&ipq6018_s2>;
>                         #cooling-cells = <2>;
>                 };
>
> @@ -69,7 +67,6 @@ CPU2: cpu@2 {
>                         clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>                         clock-names = "cpu";
>                         operating-points-v2 = <&cpu_opp_table>;
> -                       cpu-supply = <&ipq6018_s2>;
>                         #cooling-cells = <2>;
>                 };
>
> @@ -82,7 +79,6 @@ CPU3: cpu@3 {
>                         clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>                         clock-names = "cpu";
>                         operating-points-v2 = <&cpu_opp_table>;
> -                       cpu-supply = <&ipq6018_s2>;
>                         #cooling-cells = <2>;
>                 };
>
> @@ -184,16 +180,6 @@ glink-edge {
>                         rpm_requests: rpm-requests {
>                                 compatible = "qcom,rpm-ipq6018";
>                                 qcom,glink-channels = "rpm_requests";
> -
> -                               regulators {
> -                                       compatible = "qcom,rpm-mp5496-regulators";
> -
> -                                       ipq6018_s2: s2 {
> -                                               regulator-min-microvolt = <725000>;
> -                                               regulator-max-microvolt = <1062500>;
> -                                               regulator-always-on;
> -                                       };
> -                               };
>                         };
>                 };
>         };
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry


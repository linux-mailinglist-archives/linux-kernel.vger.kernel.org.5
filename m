Return-Path: <linux-kernel+bounces-58070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EA84E0D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E162862E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B96E2DE;
	Thu,  8 Feb 2024 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uassgZjt"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C537602B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396084; cv=none; b=LsZkDlcBB+FL52g26JTRkDPtXC4Gr/Mnj5IAVjEqSjaFT6C9OFsPUlxTmCUSsNiK3rk+NSz4pbWSYW4UDAh3y7bu0tdoltSrWh7+VpOui0MeJH0n6FzqY2Z661qL2+cdpJ13w88TXS3mvyqjA8DX4dADoQCfUWsuvoo/0lRQnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396084; c=relaxed/simple;
	bh=qDk7UEWrlqaGwCuD8ABX2X5AjVW+Rcn6ztsH2olqobc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izN+uJ0n6mBT6lYyVXlcM2P8XqJGm+MLQoWK4c+ug1mqgVJ3ukUAwQI1yVEc9Bi30xMQTjngeJMN/zemDcXMJW2/3ITGkwKCfB1xWOMBHV91YqhiBEPsXnciXq3OhYuSw4oPAmBAdd/fCNEIOqgdN8ax3l6u4FLSUy3cmldxO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uassgZjt; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1253793a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707396082; x=1708000882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py4LQQCjOD+63xICQgoe8LGjtYSfgfgYUdsYohF9IsI=;
        b=uassgZjtbWN7S7eEJl7Oc7Wk+gn19vhaaInRkry38+Qqvp2nZSgOWtERJtdusd7mfC
         5KV829x0o3/qdAGOlVolWRwoZNJksuOygT5XAiU67evpnqAO5nkiC6w3JqEb9IWlqmns
         jmYFsMEfqiDgM484LEaokB+Bo49/nO1sgx3e33HNmR0RTizGxtIDQR7SfuPBHVQ8XPMv
         RZfYO7QJE3DeR/+la0EhNb+yzXz9RaJKUBKQ+HGvtrdfOIm5vWQ5+Juohjr1vHUUQ5f2
         s+53DCPEJDmrZJinscCJHq+d/jighw4oE6xka2tTmtODdEbE4YwmSEiP+sz6a3AoCH9P
         CLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396082; x=1708000882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py4LQQCjOD+63xICQgoe8LGjtYSfgfgYUdsYohF9IsI=;
        b=dEjgBfcxOonXaS34uX4kwZb1FfAoQP3bDQkxv5bPqJUj1SpwvhPh5A2t2M7Ngthrxw
         Cuq+saAlToAOnLJ1ZZxUq9yn/N/6/ZlmmGvpMyXdCtC2JJ5mi/hpgpNO2x6wcuVP+rJn
         6bdeRnEfcxMLfhc+BYa2PpTsh8V4hGU77ffzXEg+kHG3xWkuDGLD1qZrVwW7yKWdEEu1
         ECDNpCDyxRdMLGgyNcbZ37qVL5ZuBklara3h97Fk9zHQhujNmeAe5i7/Z/0n4qv65mYr
         Z7v8NTo8sWJwkB0rLzeAoOKixcZzEg+uMApMHIUh51431OU1QCKoxnAF7JjYvT+B5nUC
         c4wA==
X-Gm-Message-State: AOJu0YzQXJDHGMsa9Us/GBhYU6yedi9MQLFT235VaxHnwQVjJNEix4jG
	/XJohnJq+2pQRxEk4YWTkzl0Of3GN1SPWJTEHokodW7H8gNC9wt5bsVSeeV8jVsc0OZZQvlvVUB
	HVLhllsouyj4m5J3BLVN/wZgyEamvPM9QeLVbyw==
X-Google-Smtp-Source: AGHT+IFTVbn9MROnjZ4NEuMlDyJg8O7OWSiIXi5sJ9EP3ohJj7o0qEJihfhAu8IXeI2TFNlGpHudI04RAgjFiq2t5+0=
X-Received: by 2002:a17:90a:fb87:b0:290:7739:b886 with SMTP id
 cp7-20020a17090afb8700b002907739b886mr5369282pjb.29.1707396081873; Thu, 08
 Feb 2024 04:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208105243.128875-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208105243.128875-1-krzysztof.kozlowski@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 8 Feb 2024 06:41:10 -0600
Message-ID: <CAPLW+4n5LqENFgUZYDb2rF+Db59Ry4tdAfKLiL-W-ZG6mP=kjw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 4:55=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DTS code coding style expects exactly one space before '{' and
> around '=3D' characters.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../boot/dts/exynos/google/gs101-pinctrl.dtsi    |  2 +-
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi     | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi b/arch/=
arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
> index e6a9776d4d62..a675f822acec 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
> @@ -251,7 +251,7 @@ gph1: gph1-gpio-bank {
>                 #interrupt-cells =3D <2>;
>         };
>
> -       pcie0_clkreq: pcie0-clkreq-pins{
> +       pcie0_clkreq: pcie0-clkreq-pins {
>                 samsung,pins =3D "gph0-1";
>                 samsung,pin-function =3D <GS101_PIN_FUNC_2>;
>                 samsung,pin-pud =3D <GS101_PIN_PULL_UP>;
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index c7a9e81d23b9..80cc933cca3d 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -73,7 +73,7 @@ cpu0: cpu@0 {
>                         compatible =3D "arm,cortex-a55";
>                         reg =3D <0x0000>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <250>;
>                         dynamic-power-coefficient =3D <70>;
>                 };
> @@ -83,7 +83,7 @@ cpu1: cpu@100 {
>                         compatible =3D "arm,cortex-a55";
>                         reg =3D <0x0100>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <250>;
>                         dynamic-power-coefficient =3D <70>;
>                 };
> @@ -93,7 +93,7 @@ cpu2: cpu@200 {
>                         compatible =3D "arm,cortex-a55";
>                         reg =3D <0x0200>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <250>;
>                         dynamic-power-coefficient =3D <70>;
>                 };
> @@ -103,7 +103,7 @@ cpu3: cpu@300 {
>                         compatible =3D "arm,cortex-a55";
>                         reg =3D <0x0300>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <250>;
>                         dynamic-power-coefficient =3D <70>;
>                 };
> @@ -113,7 +113,7 @@ cpu4: cpu@400 {
>                         compatible =3D "arm,cortex-a76";
>                         reg =3D <0x0400>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&ENYO_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&ENYO_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <620>;
>                         dynamic-power-coefficient =3D <284>;
>                 };
> @@ -123,7 +123,7 @@ cpu5: cpu@500 {
>                         compatible =3D "arm,cortex-a76";
>                         reg =3D <0x0500>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&ENYO_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&ENYO_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <620>;
>                         dynamic-power-coefficient =3D <284>;
>                 };
> @@ -133,7 +133,7 @@ cpu6: cpu@600 {
>                         compatible =3D "arm,cortex-x1";
>                         reg =3D <0x0600>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&HERA_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&HERA_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <1024>;
>                         dynamic-power-coefficient =3D <650>;
>                 };
> @@ -143,7 +143,7 @@ cpu7: cpu@700 {
>                         compatible =3D "arm,cortex-x1";
>                         reg =3D <0x0700>;
>                         enable-method =3D "psci";
> -                       cpu-idle-states =3D  <&HERA_CPU_SLEEP>;
> +                       cpu-idle-states =3D <&HERA_CPU_SLEEP>;
>                         capacity-dmips-mhz =3D <1024>;
>                         dynamic-power-coefficient =3D <650>;
>                 };
> --
> 2.34.1
>
>


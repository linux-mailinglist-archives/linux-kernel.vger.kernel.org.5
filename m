Return-Path: <linux-kernel+bounces-48319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D166B845A47
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708AD1F24FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547715F474;
	Thu,  1 Feb 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzcxDK2Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF65B66E;
	Thu,  1 Feb 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797567; cv=none; b=rl/ViTOSso0h0hFtnWmonXerdP7jnhHWI/YG1eoKIEs50MnsalUQKEEX0F/lg6tM/imqZVE0asH8SR1Bj0Sh4YRgxalqyxBVbaNQ695KzF0AGS8jZ11FatIannO/6ixFt8xOT5MtovnpgRRkL/ZQ9ntRkUDuBqa3SphEdj7B0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797567; c=relaxed/simple;
	bh=u8hZb1KY0acvINicwcOlLX6sBnV2lOH0PfaW//UVPBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMNspi2Q4Xenc1uqBSZ22kmoFuZNouMyreojjSMMHUoQGPTDPLJdnvYax2Zw+G77d6dAW6Wp4XJoeI9LpBD3oNX5MEjsEo+X4L1IBeeT7+0AmTfyNERB/8NB8fuob5yS35tvxltyu6d9gk82e0syft83nv724scQ5JU/ACCAa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzcxDK2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07231C43390;
	Thu,  1 Feb 2024 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797567;
	bh=u8hZb1KY0acvINicwcOlLX6sBnV2lOH0PfaW//UVPBk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=uzcxDK2YySJRUJ/KdXk5MZPQAIsI8rzec3nTqmSfnmQRlcFCwrYZ/bQfwiS9yaST0
	 Q5yG6m31Mg1NEqNslE1BZOeskSWtV0T8qx3clsYtj7LORzgTUEfJvUskeiWlCuyIvr
	 fBM5bjF0r/UWZEreHIEfMVnOvbA1t1tcYPbM/yDlyKEFT4aPfCN0avR4QmDRgm2RQT
	 EGszEUlW9ie5uNl1mFLhJsuRG568ySDeWfgnW0FdNkHO5wNAHIlmnkmnPRwMMJx30P
	 Rv04U3BFHUHFBZzX22RBia96MV2b2HverdfgRb2jSIkmfEhCUwtkhGh0swYPhHWAQc
	 SJOubzAF+UbJA==
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6de0f53f8e8so1686195b3a.0;
        Thu, 01 Feb 2024 06:26:06 -0800 (PST)
X-Gm-Message-State: AOJu0YyKdSA/Trr1PO5Ukg+hcQPFBwY75Fru1EKGWWr63qh9ErPbV2X1
	H34YG9QP9Qh18UHa7t0Dcd9pCzSwPD4rHNOnRDWBtPaW8yls2dlzJwOOuTkcD7fvJeXWe4yMgPD
	kSmQ2HrgzI3/Lm7GPwM2aS3mpN5I=
X-Google-Smtp-Source: AGHT+IEQ57LFCXx03pmPY0BiaAVWqsmooCa8JnBK4SyQoscvPIE/4caLjfgkMTh91ldy8kJvhymf6n8Ec+0Xv8T1yH8=
X-Received: by 2002:a05:6a00:981:b0:6d9:a074:659f with SMTP id
 u1-20020a056a00098100b006d9a074659fmr10435698pfg.13.1706797566559; Thu, 01
 Feb 2024 06:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com> <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
In-Reply-To: <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 1 Feb 2024 22:26:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
Message-ID: <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven
 fan control on Rock 5B
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 2:22=E2=80=AFAM Alexey Charkov <alchark@gmail.com> =
wrote:
>
> This enables thermal monitoring on Radxa Rock 5B and links the PWM
> fan as an active cooling device managed automatically by the thermal
> subsystem, with a target SoC temperature of 65C and a minimum-spin
> interval from 55C to 65C to ensure airflow when the system gets warm
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34 +++++++++++++++++++=
+++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64=
/boot/dts/rockchip/rk3588-rock-5b.dts
> index a0e303c3a1dc..b485edeef876 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -52,7 +52,7 @@ led_rgb_b {
>
>         fan: pwm-fan {
>                 compatible =3D "pwm-fan";
> -               cooling-levels =3D <0 95 145 195 255>;
> +               cooling-levels =3D <0 120 150 180 210 240 255>;
>                 fan-supply =3D <&vcc5v0_sys>;
>                 pwms =3D <&pwm1 0 50000 0>;
>                 #cooling-cells =3D <2>;
> @@ -173,6 +173,34 @@ &cpu_l3 {
>         cpu-supply =3D <&vdd_cpu_lit_s0>;
>  };
>
> +&package_thermal {
> +       polling-delay =3D <1000>;
> +
> +       trips {
> +               package_fan0: package-fan0 {
> +                       temperature =3D <55000>;
> +                       hysteresis =3D <2000>;
> +                       type =3D "active";
> +               };
> +               package_fan1: package-fan1 {
> +                       temperature =3D <65000>;
> +                       hysteresis =3D <2000>;
> +                       type =3D "active";
> +               };
> +       };
> +
> +       cooling-maps {
> +               map0 {
> +                       trip =3D <&package_fan0>;
> +                       cooling-device =3D <&fan THERMAL_NO_LIMIT 1>;
> +               };
> +               map1 {
> +                       trip =3D <&package_fan1>;
> +                       cooling-device =3D <&fan 1 THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> +
>  &i2c0 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&i2c0m2_xfer>;
> @@ -731,6 +759,10 @@ regulator-state-mem {
>         };
>  };
>
> +&tsadc {
> +       status =3D "okay";
> +};
> +

Is there any reason this can't be enabled by default in the .dtsi file?
The thermal sensor doesn't depend on anything external, so there should
be no reason to push this down to the board level.

ChenYu

>  &uart2 {
>         pinctrl-0 =3D <&uart2m0_xfer>;
>         status =3D "okay";
>
> --
> 2.43.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


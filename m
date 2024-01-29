Return-Path: <linux-kernel+bounces-43392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA41841325
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C401F2513E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873C4C63D;
	Mon, 29 Jan 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMJWo5EW"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17647F50
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555959; cv=none; b=t3UvhZG/xW+TwZyy+Z/Klc7O8rV3gMUJQFdU+VmZDn5smUOMi9Y64P29+sPkZWNPcBJ41h3Kk+3vHsdU9gf2KfouuRU2yOwJULOT8WOPCC7KiyE4W+GprDsp/DPaHbDRZ4w7vC8cgiilbooSAdmLygIU6t9ywPtTqg+7H3nDtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555959; c=relaxed/simple;
	bh=MU9MmIrHw/67BHQXkTPiEw0LVm/53Y+HFvPTcTiByUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RI5OxJGwl6zBVG40gAuu1PYSDAmwnNwuwKkoRtirvU7OgFtX+gT0BrJQEHMTN9tcsuED51Gkxc5gaS5p2AHMsaq4IcfRrfvd2wSRDsJyDl3otmIYd/Toov3/NpidLBMKzoEG9CMFrEpoLyh+erbOlI4GpeQ73BCoNtOWlE5pJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMJWo5EW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so2750949a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706555957; x=1707160757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwNx3opXJ2ZzqtnsIO+tSlRh7ps3K7+odFH9qGLZcmk=;
        b=dMJWo5EWp0G8AZCj11YBTvPKCS1jbvFZjd+LDLxLuvzdhZy9L2t/C5GpEzmS7fm72k
         WXZRGF/PpBishLnb1AnB0yCadAMEiSsJ1zzXIA0/q+eFK+oZKhPXMojIiPYNh+VMsMy8
         fcX2Fuol1mR/5KiaZPVhMYvdNFZuDXR5GDjXOlBF5RCcfTeyFgm2+cwY7kAUndGqmeNx
         rpyw6su5nMuK1XzKFFZ5XIrcBO08uHfYKbzLlnyIZ7CympM1FT4TbJaNh1aUrTw+CBN9
         NY1Pgscc2iNM79Y/ticootDwlf9qL8LYzQPvDMbwmgvYN0orI/YRg+qpmn2+P7+fDe5Q
         QUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706555957; x=1707160757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwNx3opXJ2ZzqtnsIO+tSlRh7ps3K7+odFH9qGLZcmk=;
        b=mYt4qfyHo5CwBkzPKY3En27TwRA+jn34gdT7ebjqapepsTg4cP2uZpd0PurDn01PDJ
         PE3sgY5sJDtKzQyuA+Szbi7Hu/AkTA5lM9RJtWOXR8r7hZTYZEdnFZ8uyt0sDkzWr3ZT
         WZLFyoulsrQHUnuvZbQDav/jNYZFqWnYlUrjiPpnhjftFH4WzxOx77SXmbQetv3AIGx1
         1maZHcN6/XivVU7N0oNAh/M5LG+hU4SYvrjTIrWJWO18npxg/9iXvgapLztKFk2z0uX6
         cD9hkJ/MX70MkE+lhQQ/kBs7SHe1KG/YrRUMVOdfkCwJgKen97D9ErYRgua/Jy0TwN0P
         x8oQ==
X-Gm-Message-State: AOJu0Yzcqwko1liNoO9kxgllvCK18iKmbGViou5MALHOy9y4XH97j55X
	0grvCSPORrpaZVVv3h1aTGK4FUPABl4ojhGkycHUhmgyA6G422EhqhDvaHis8X8K1xiHDNZYhLj
	avNLMYAcqiST+WEp9vPahT61vpwm3eUJBgVYTYw==
X-Google-Smtp-Source: AGHT+IFb+2auluVYwWdveInazsXdiUFS1f7RHCk7mnkvW5QfiCQG437C2AdCz9+T7D1GFFP6s4m9rmFXc/Q+dxa9rI4=
X-Received: by 2002:a05:6a21:1506:b0:19c:a47d:874f with SMTP id
 nq6-20020a056a21150600b0019ca47d874fmr4648484pzb.34.1706555957344; Mon, 29
 Jan 2024 11:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129174151.1174248-1-andre.draszik@linaro.org> <20240129174151.1174248-8-andre.draszik@linaro.org>
In-Reply-To: <20240129174151.1174248-8-andre.draszik@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 29 Jan 2024 13:19:06 -0600
Message-ID: <CAPLW+4nA4kzwdE5neOPvgEDAZ4RG0MBAkGKzFK=u3WG5FfZuMQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: exynos: gs101: enable i2c bus 12 on gs101-oriole
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, 
	inux-kernel@vger.kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
	tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:42=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:
>
> This bus has three USB-related devices attached to it:
>     0x25: Maxim 77759 Type-C port controller
>     0x35: Maxim 20339EWB Surge protection IC
>     0x36: Maxim 77759 Fuel gauge
>     0x57: NXP PCA9468 Battery charger
>     0x66: Maxim 77759 PMIC
>     0x69: Maxim 77759 Charger
> where the Maxim 77759 has multiple i2c slave addresses.
>
> These don't have (upstream) Linux drivers yet, but nevertheless we can
> enable the bus so as to allow working on them (and to make i2cdetect /
> i2cdump / etc. work).
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v2:
> * add short summary of devices attached to this bus & add TODO
> * collect Reviewed-by: tags
> ---
>  arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/ar=
m64/boot/dts/exynos/google/gs101-oriole.dts
> index cb4d17339b6b..6ccade2c8cb4 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -72,6 +72,11 @@ eeprom: eeprom@50 {
>         };
>  };
>
> +&hsi2c_12 {
> +       status =3D "okay";
> +       /* TODO: add the devices once drivers exist */
> +};
> +
>  &pinctrl_far_alive {
>         key_voldown: key-voldown-pins {
>                 samsung,pins =3D "gpa7-3";
> @@ -113,6 +118,11 @@ &usi8 {
>         status =3D "okay";
>  };
>
> +&usi12 {
> +       samsung,mode =3D <USI_V2_I2C>;
> +       status =3D "okay";
> +};
> +
>  &watchdog_cl0 {
>         timeout-sec =3D <30>;
>         status =3D "okay";
> --
> 2.43.0.429.g432eaa2c6b-goog
>


Return-Path: <linux-kernel+bounces-9931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4EF81CD69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F9D1F239FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17CA286B2;
	Fri, 22 Dec 2023 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bervrMY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F628DBC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28c17b6f91bso302581a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703264388; x=1703869188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuszQHofzpx+eEflqAJILsyJnJgQIE3F/nW1KqPO/FA=;
        b=bervrMY65dNi6zWslUSUshNj5AGz+p5ytJ1OVWwU993J+x9JiXGeKDXsl174uvwj0X
         HVgOTqYlMkX2FV6U+H7BLMVavKggmQJXYACY1zkSK7F63POcC+hkQUeq/PAb4xscxjuZ
         xgqvEGIxPe6FC2hQYTG7WzgGq0P7v3mlUFXc0+9qTyO1gVkA1KA2HBe2HsYl34mB6xs+
         Xr1FuIuVabr6EJ7sSsjgespxCmxQWTXnyJa114qQShPjuT3hIv9rcj4hItE4gN99hMlS
         WTPLk8MLSlfHbsMmoPxuDM6eyC2qHYid2/F5PUWvFC7hxf+5PAGgoYXarjw+ZAtgUllT
         6CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264388; x=1703869188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuszQHofzpx+eEflqAJILsyJnJgQIE3F/nW1KqPO/FA=;
        b=eW76RGgIwODET02axffRK9W49JqpKfvpyu69ZCgPNsXGuL2AOxADInT1LlTs0QQtPz
         Yr1zgbnn7gaLVcXVW4SgxnRuF9Z076dDLdhGUgh62x0+fV+rBQHkyplBWEQR56OeQcq7
         N6liZf8JKYNZ9XXAa3MYxAcSncnUCEoTL802P8BcSgrEZBxNG8hdj2WukU+dPK2AYrJw
         sY9bM9G32/4mq/1NzauZwj86GvqWJIz1uub8ZfurDL6u3YwLkqydWMxqVKvo2iUq1jJW
         eP8lFYWWoarBdZhb5XNUwUPb6MCwkAop1/mdKUHX4zuAQsXeyHql/hj5GZLT/2wapIkb
         gybA==
X-Gm-Message-State: AOJu0YxwCiCxhGnpfXXul9nlaf7o1sXSnUo4dQ8E981gzj6HfrWgfbRF
	mk7MUjrEcf5duqo30oaEfTSGRrTMfEiVt1JHIlqPGxyiypamPw==
X-Google-Smtp-Source: AGHT+IF1XHuTpYzUp4iOd/xTGtwwth5YJnhCHTZjBMG4kuAWdGXzF7hJdHw8znlpoFdT38YluNJ2YUrJlNB9teZFkUo=
X-Received: by 2002:a17:90a:9741:b0:288:8bdb:31c6 with SMTP id
 i1-20020a17090a974100b002888bdb31c6mr974534pjw.83.1703264388185; Fri, 22 Dec
 2023 08:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222165355.1462740-1-peter.griffin@linaro.org> <20231222165355.1462740-4-peter.griffin@linaro.org>
In-Reply-To: <20231222165355.1462740-4-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 22 Dec 2023 10:59:37 -0600
Message-ID: <CAPLW+4khNwA=480_69XU5vPOY=Zw=4ytA4stF7gvRfUDCEGE5Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: exynos: gs101: define Multi Core Timer
 (MCT) node
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	daniel.lezcano@linaro.org, tglx@linutronix.de, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 10:54=E2=80=AFAM Peter Griffin <peter.griffin@linar=
o.org> wrote:
>
> MCT has one global timer and 8 CPU local timers. The global timer
> can generate 4 interrupts, and each local timer can generate an
> interrupt making 12 interrupts in total.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index 9747cb3fa03a..4b09e740b58a 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -292,6 +292,26 @@ cmu_misc: clock-controller@10010000 {
>                         clock-names =3D "dout_cmu_misc_bus", "dout_cmu_mi=
sc_sss";
>                 };
>
> +               timer@10050000 {
> +                       compatible =3D "google,gs101-mct",
> +                                    "samsung,exynos4210-mct";
> +                       reg =3D <0x10050000 0x800>;
> +                       interrupts =3D <GIC_SPI 753 IRQ_TYPE_LEVEL_HIGH 0=
>,
> +                                    <GIC_SPI 754 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 755 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 756 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 757 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 760 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 761 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 762 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 763 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks =3D <&ext_24_5m>, <&cmu_misc CLK_GOUT_MISC=
_MCT_PCLK>;
> +                       clock-names =3D "fin_pll", "mct";
> +               };
> +
>                 watchdog_cl0: watchdog@10060000 {
>                         compatible =3D "google,gs101-wdt";
>                         reg =3D <0x10060000 0x100>;
> --
> 2.43.0.472.g3155946c3a-goog
>


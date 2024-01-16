Return-Path: <linux-kernel+bounces-27451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193F82F045
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C311C22D52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85A1BDED;
	Tue, 16 Jan 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5xLWFMd"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9301BDE1;
	Tue, 16 Jan 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d437a2a4c7so17431155ad.0;
        Tue, 16 Jan 2024 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705414054; x=1706018854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsOKv/Vxb9mcA7C3H9l7epqyWP3kXoySv0wP/X5WTR4=;
        b=T5xLWFMd1OXNj0eu/OnjCcvZy8hDPbeyoTcqc/Y7WL1kcjMNtVEa3VwkoUBR3WRxZN
         iavfyJcvI+I+LhjBFGTunqf1ClYFP+6iqdDZNxCbpzyWZX8OV2gKRm082DJblYWkv8kL
         yWMgKHfxn2DcILM3AUvzEmcUCifFxq6GCJcaSxVO7hJ/YuI6kvs6PnBnz8NphkpkfJzf
         ruQjlSoHK0v0eJMufFjaEW3GmnCM7EO42kA3F2sn75rF7kCNZqplGvCG+R5xYO9thxCK
         fCsfPUbGQIh6oca3bgWQhO2cRkWk2jN2+Nun56IMVudUSK0D3YySrJOoOz4LHtHh0QnU
         qCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705414054; x=1706018854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsOKv/Vxb9mcA7C3H9l7epqyWP3kXoySv0wP/X5WTR4=;
        b=sRXA4mtZApFGi/1D90HxLCPzg+8OjzMu9gR212l5RsCeJE2xBF7KzQE9nz8dhrI0vY
         O/Tvxm5eOWG+mMJSZF8PCbHtHUgkWbcjtiRFCq3X8eLhY8jHA/XikZqe36WXq2DMANTe
         Tnfdp1NDN5kQGBOHm792yCyGdFNFZXh1+aQFFNz6vU/lqXzd30TNgcrex5FFGaIvlkcF
         sVcr7YFAHO6iGltcCTMQKEwxR1OxAbJ/yRsq4pdzd6splSYfV8KAbV9kVgTVRrWAEzo+
         QgewcAy06vF3gGdHeIMkUSeZ/8qIrZvVorQ2xS3mbtn0L0OAyiG+TSDip2VgS62b7JB6
         FKkw==
X-Gm-Message-State: AOJu0YwTodi8MBskBSkDV5/IG1QgW7gU4nTmecWYTNI2xr0T44uwJt0J
	fDffN0AWyK/B/DNa2F2yG7d1YMivVN6fQhhOd6M=
X-Google-Smtp-Source: AGHT+IGLf50pduapbwucTrllXOiAuUEuar9PfEcbOri0Jr6Hz9e8v5PxtAOTTQmT+zQ+v7z92e7eGcVHOKsLcHvc7Do=
X-Received: by 2002:a17:90b:1bd1:b0:28e:42cf:37ce with SMTP id
 oa17-20020a17090b1bd100b0028e42cf37cemr6842339pjb.4.1705414053750; Tue, 16
 Jan 2024 06:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116113939.17339-1-othacehe@gnu.org> <20240116113939.17339-3-othacehe@gnu.org>
In-Reply-To: <20240116113939.17339-3-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 16 Jan 2024 11:07:22 -0300
Message-ID: <CAOMZO5CsJzQNsW2wgSU6HxE0kVczXBFdZUdGgsMp1xTVPh2-zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx93-phycore-segin: Add Phytec i.MX93 Segin
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 8:39=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:

> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts=
/freescale/Makefile
> index 2e027675d7bb..6cb6d9f8783e 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phycore-segin.dtb

Please keep this in alphabetical order.

> +#include "imx93-phycore-som.dtsi"
> +
> +/{
> +       model =3D "PHYTEC phyBOARD-Segin-i.MX93";
> +       compatible =3D "phytec,imx93-phycore-segin",
> +                    "phytec,imx93-phycore-som", "fsl,imx93";

Can't the compatible be in a single line?

> +       model =3D "PHYTEC phyCORE-i.MX93";
> +       compatible =3D "phytec,imx93-phycore-som", "fsl,imx93";
> +
> +       reserved-memory {
> +               ranges;
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;

Is this needed?

> +&iomuxc {
> +       pinctrl_usdhc1: usdhc1grp {
> +               fsl,pins =3D <
> +                       MX93_PAD_SD1_CLK__USDHC1_CLK            0x15fe
> +                       MX93_PAD_SD1_CMD__USDHC1_CMD            0x13fe
> +                       MX93_PAD_SD1_DATA0__USDHC1_DATA0        0x13fe
> +                       MX93_PAD_SD1_DATA1__USDHC1_DATA1        0x13fe
> +                       MX93_PAD_SD1_DATA2__USDHC1_DATA2        0x13fe
> +                       MX93_PAD_SD1_DATA3__USDHC1_DATA3        0x13fe
> +                       MX93_PAD_SD1_DATA4__USDHC1_DATA4        0x13fe
> +                       MX93_PAD_SD1_DATA5__USDHC1_DATA5        0x13fe
> +                       MX93_PAD_SD1_DATA6__USDHC1_DATA6        0x13fe
> +                       MX93_PAD_SD1_DATA7__USDHC1_DATA7        0x13fe
> +                       MX93_PAD_SD1_STROBE__USDHC1_STROBE      0x15fe
> +               >;
> +       };
> +

Please remove this blank line.
> +};


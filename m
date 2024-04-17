Return-Path: <linux-kernel+bounces-147879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D068A7AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B21C21F39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C779FE;
	Wed, 17 Apr 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT4QOrJc"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155EF6FB9;
	Wed, 17 Apr 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323396; cv=none; b=ggcmxTSv6Cn3XfXp50pFu5ZGjXSKuOeQ7oOhXoFksQhlSsq1DTjcSVu26H7ZocOnO1qbZX5/ctpUi2FbJxmxnpJ+3I2QTXk9OhVdcb/ziETeJ7hCBItclrMs18iLl6Sc4IG/Jt7tecppy+8CFWxs4d2oArf9gUVqi2cnjv0gtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323396; c=relaxed/simple;
	bh=ilqZuJ6ogECkzvhjA0tE68aZRZnI2Mc/Wgeelwe14/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPUn0nKFRHWN5ea8H3udCWa1vdtwUsKaDE+bWF6mss6r0FRdec0YruyHoPU/lBoOh4BjfcgxI0YnS7np2YVlGvmY8Z1Bk+zZkphCUfvLd5W1ns382zp8d3iEmAVAOfXLAKsgDvmpzaFpPlrVw1tpFV5zTBcK6BToxX1At41SUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT4QOrJc; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22ec8db3803so446768fac.1;
        Tue, 16 Apr 2024 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713323394; x=1713928194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmF/RSeCiJgO8DT8EUwS01DU8BP0OT36dIP7pCjzgmY=;
        b=dT4QOrJcvYezNl5phmDeMOjFT1f809LVUOLvjtJ4FoPedG1SGGLfpuj2Ys+L4EpwE4
         bv0en4nqZ5PzwJSTLOH3alQtf0FHt8UQZD7JWN75wCcBtgJPil+uGBE+lVEtOu4q1/NU
         O0jqjqnvpFlcisAVnHOc1Yhm0L6joudiBgUph9vPdxXAH0J9+p52FpwBbzBpP7XNKy+n
         ajUGgKPGaSXul/9pPunFUytxAxxArszmiEE0xWLLu7De6TvTD3eobq21cbnDz/9vNZP+
         n0Ffd4ZC8xG4/gvHKeywyYG/70hz3WHqEHrmofldz04Ijvpjv1CovFt1CF8KyefPUMD3
         9New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713323394; x=1713928194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmF/RSeCiJgO8DT8EUwS01DU8BP0OT36dIP7pCjzgmY=;
        b=hPkNI2Is8lA2bRQ+XNnpNkv652gUDmb0aPJo5om/PrBesJizjiJPV1fesfJSoCVjmg
         UxPzMy+3MXPnCBFCikZ3xnhWf7VQDmkwmb8MvNkj9KXx/CCvEQ3m+xJFbFdI3i7u9lxg
         Zz1Hi7Co2p0AWqoFRc8iqLCjRIhYiYIBJ9ZIkifIQowQHuN34gs+S7zlb8+XPpoXnfz2
         hqiyXRjrKO2MP3Wvi035mJJWg9FS7vjOYoZ/YuoYE8woN+tV+bM56pdnHaHEj6dhdbjj
         cApJz0P/LKEOBneyOBnsZCkInWEtneGi4baS1CZwudHVMA+S3tjdQiADd3WYb0Xd0/6G
         VYHA==
X-Forwarded-Encrypted: i=1; AJvYcCXvGMrtAJFgCD2/7qU3jrTUxLVpUkgodOkO/bnB9ZOLBijsV1FFX9twFliFXADI99ORQBeP31Yo2ZvyLCwJ4NOzP4csl/UuwhIE1woe1UACaj9eBV9D6BFxA10pITL7Q2SR4PQF/Xwtnw==
X-Gm-Message-State: AOJu0YwTEKXHZV5AOrpKkk7yf6LY6I+DSCp75qHauqZgf6tHadW/yT2C
	+ap82guoW1Hlekqpay+/rfaS0/HzcZ2zobbHMZJd5kzFMt26MovwK7rX+WcA+6/RtrH1BJ4nN1b
	x/Ll6LUIPoObPZB8ZF4ir3ZB/h08=
X-Google-Smtp-Source: AGHT+IHFquYN+ximwLzLvhQHpR6/Uk/1sIAf74vffhGuh/w5zl5ZlLPz3m/jczMWZ14P5znQhl9qgkYbXICI+fwIuag=
X-Received: by 2002:a05:6870:e9a9:b0:229:e46d:763a with SMTP id
 r41-20020a056870e9a900b00229e46d763amr17319691oao.0.1713323394195; Tue, 16
 Apr 2024 20:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417031455.3177778-1-joy.zou@nxp.com> <20240417031455.3177778-2-joy.zou@nxp.com>
In-Reply-To: <20240417031455.3177778-2-joy.zou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Apr 2024 00:09:42 -0300
Message-ID: <CAOMZO5BGNcbxA4gH0r_AsoAHNVAcCAAo8JFshzxd86naOaOYhg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131 support
To: Joy Zou <joy.zou@nxp.com>
Cc: m.felsch@pengutronix.de, frank.li@nxp.com, ping.bai@nxp.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	linux-imx@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:07=E2=80=AFAM Joy Zou <joy.zou@nxp.com> wrote:
>
> Support rtc PCF2131 on imx93-11x11-evk.

s/rtc/RTC

> +&lpi2c3 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       clock-frequency =3D <400000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_lpi2c3>;
> +       pinctrl-1 =3D <&pinctrl_lpi2c3>;

Why is the pinctrl-1 still here?


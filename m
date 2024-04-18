Return-Path: <linux-kernel+bounces-150848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB898AA597
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E3528520B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52054907;
	Thu, 18 Apr 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyk06M5r"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BF26ACF;
	Thu, 18 Apr 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481447; cv=none; b=aDgNi1NHT1Q2MfiMic+QkFEJkc2hZ9L0rZ+t3kWDhyd+zapmvYkBNgYgunP+NslZ+mPecmFbWT3R92tFhwZWqSoQhkK+4rxNkTF4FrXdhTk2N844eJbBzQEavNiGQgDR0lU2w/IETEphkfvu//bCP7/Nc++cHyHbHv9RnvdKnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481447; c=relaxed/simple;
	bh=RfeAuSUpmfu0WRBe7DT6Sv0gtgqSBIVaALtYeKQvVJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtG/xMYuI4O+Q5GTMiAia9cV2qg8bhW2/HFmazBXzzI2uDRbtL68KUn2LVHBNCROmc+U0S/IDZ1q9XUBMVkHTcmN6Sieb6CrPoEdByPzHBDdyaZYXOnPbhZvm3VLb/X1jv7HCMlHgXeS1Kaoi9IwdjT9XwQghhd9ZpKt1Y0xlv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyk06M5r; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a698b0948fso330518a91.1;
        Thu, 18 Apr 2024 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713481445; x=1714086245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOoy0hO8+lD9h8lCjd5Iw9f3kWZjnuEqmyoLJv0b/Bc=;
        b=Cyk06M5rUJy0ZM7Cf9vcxbb0w+RtSufUTb8Iv+um6pBm6+BgWjnNHjzFKg+TYhIMbB
         66Ne2ONwaue9sUVJ7N3RdKU9CnDazTa9XuVuldSar0UV2xv/dwjcjZinBmjgWzvTPS16
         Gs0joIyKk3SNJh1XcnrLG8+qSqPJFTdIolWaBS9VsSrfBRbYtOc/uOVKbb7PaX0a6JEm
         PijlwSQ7D+IwjaO/LAJoSctpSX3jAf4C0iSGtjTwjrptuiUfBMrFiEAB/Pd+rWZsu0PB
         4Ie1vaBqhzGmDE3eyX1RcLjwjhK6NDRFHG+RuHNytoI/3hDWmtvL1JYEH/k+B5y2dGbq
         ZDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713481445; x=1714086245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOoy0hO8+lD9h8lCjd5Iw9f3kWZjnuEqmyoLJv0b/Bc=;
        b=IinxjqqPLsAu7A9uuf7dMI2y982XVHBtOKkD+j1ax/kAFL0TjV6QdxEsdLabkV0Ei9
         DtiiW/VzFEKFAK7jnGdhfXO50Rdo5h4PZLQB7ICmssLlgv1IojTTAMnLDjjNv8NnG2Vn
         XTcTYRcFyCB4JEhissQQdKrxqkzZX14qSmkLIAZl4J+qPZ7BmJUzTvRGgYfO+W+r3rKi
         9JylH8vcr34AraDj/UReKwZ4XkCbjB87hAEOAyjp11vMq2Kmww3Iw5NidkUkU0FK2Sg8
         P1eH0y+h8qUey8beF+9JA7//BTQYbZzaIc+eLyMconTMNiZElv3THppnrBsBb3SxMM58
         Ab4g==
X-Forwarded-Encrypted: i=1; AJvYcCWv9CxluhgdGsGeGboFCTHNFyRPXsPDvAsmStvVX3Gf+KVHXp4Ufiv1qtBJbMzLx2KEOLC9pmNTi3Pl8uUs5PBwBdUH25y7ICx49Zju+tkLaMJr43i4F8DIjb/qTiiiR1HAXRzwDFa7GA==
X-Gm-Message-State: AOJu0YxIo5Oel7oJ5Cy50pMparfGF1krTmb+zJN5k1PVm78Y8W99LcHv
	qRXm9E66vCNUWexOYufRhVakbe+K6VLRPgEOWlvBCaYd6AyrSAxcC6xfnOP/8zHI55Vui+Q6sRA
	FZ1l7h+GJnHTj73upSXORYCT/kws=
X-Google-Smtp-Source: AGHT+IEZWuZcNHGIAt7bjEfLeZJO7FNyPair0s9RD9/fgTlHp3tR67gTi8MgSWkn+QnB8hxBAOgHyPOHsoBJEnVwKVQ=
X-Received: by 2002:a17:90a:b292:b0:29c:7487:43b8 with SMTP id
 c18-20020a17090ab29200b0029c748743b8mr590686pjr.1.1713481445035; Thu, 18 Apr
 2024 16:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com> <20240418-dts_8qm_audio-v2-5-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-5-e40fe76b60a6@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Apr 2024 20:03:52 -0300
Message-ID: <CAOMZO5B97mYVfh_JsWUOY7GE+Ag7x83mV167T3xEOY1o9YMmJQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] arm64: dts: imx8qm-mek: add i2c0 and children devices
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:37=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +       lsm303arg@19 {
> +               compatible =3D "st,lsm303agr-accel";
> +               reg =3D <0x19>;
> +       };
> +
> +       fxas21002c@20 {
> +               compatible =3D "nxp,fxas21002c";
> +               reg =3D <0x20>;
> +       };
> +
> +       isl29023@44 {
> +               compatible =3D "isil,isl29023";
> +               reg =3D <0x44>;
> +               interrupt-parent =3D <&lsio_gpio4>;
> +               interrupts =3D <11 2>;
> +       };
> +
> +       mpl3115@60 {
> +               compatible =3D "fsl,mpl3115";
> +               reg =3D <0x60>;
> +       };
> +
> +       max7322: gpio@68 {
> +               compatible =3D "maxim,max7322";
> +               reg =3D <0x68>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +       };
> +
> +       l3g4250@69 {
> +               compatible =3D "st,l3g4200d-gyro";
> +               reg =3D <0x69>;
> +       };

Same comment I did yesterday on another patch from you: none of these
node names are generic.


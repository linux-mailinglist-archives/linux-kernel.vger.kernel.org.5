Return-Path: <linux-kernel+bounces-167490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57088BAA58
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CEC1F2216A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A014F9F2;
	Fri,  3 May 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akKAKZ2R"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E414F9CF;
	Fri,  3 May 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730052; cv=none; b=oyn3xLvVGvdf2EUp4h3+SU4/Xk7hbUCxJl2UUCUlYHmpq30hpwXimOsHhXJlBmhySiyUkX7c4ztEmGdrR0hrGxgp6Ff5OUCEG4krDKj+jyYt1vWSMQT7DD21Rf7mrV+6uMwxpYdmzXvDg7oSulnpJBliIVPBN/TiUCHWqHjMm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730052; c=relaxed/simple;
	bh=oO6o2rpfHPOdGQjocbJm7nYQ52Uy5WZClOTnFXN9Xxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAlZzDCwS6nO1eHm496d4jg59hE8dGgs+QN0sydNJisJyqRsg+eo3oMqJS5U0AFi6fqxcEFkT1W5NIDh1PsO8P/XjS52TzXrqBjKt0ohKJ855qaDt5bPOg08rqHtPrdZCc1rLudWE5L57HxWMHi5MHDcIZqWUrtVtFjAklZDHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akKAKZ2R; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b3e2d3d05cso268326a91.3;
        Fri, 03 May 2024 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714730051; x=1715334851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPOCU02o4FkaTy8IAzYtzHqtONKNgZRbMXSkFgP/UHc=;
        b=akKAKZ2RmqIZ6oa9lFoFm3nt4l9S4uLfHrKgRW6G90gHSaW62bD44tsIdiFDGZjhME
         6rwwLtdHJkJWrR8oLxbrFG02aAUyITBZTwGH5AqFSF8Ysud6VORGPC72MyddwMn7dXiA
         T2IeW/ihoEdDFCgt1NTFjcQAPzm0yPj9nZB9KYjkRxBXd2mMN3avcw0VavyBBwtGgtWb
         buvG3CWL7UFpGRZHAkmEsYb66wNNfRJU+XaYzglGtIscxOCzaz7HuB+My1lK6qNYAkm8
         v4NALE0Ys7xqsGtAKrilsUlIytZT/ov8m32aTAi41Kx0FXrLKlkVq2asfHPLD+GPau/T
         17JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714730051; x=1715334851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPOCU02o4FkaTy8IAzYtzHqtONKNgZRbMXSkFgP/UHc=;
        b=fGpjX6++zlXoYw0pFe/UCS22xPmqbR3sEkGCfSwCkMKDMLAgybzCNSgZt9zLb10ffZ
         LAe5ISxiITXbqvOjuh5WZ5zMcjVA15IkKQc6E1caDNAU1ZVif8iv96wZYxvK3IDRfYSf
         5avZ7TQntL0SEqy6Qba9/9h2L85wvJkFe9ci5dEySnvT1lkvZyhCkCgiVkdVH7Jcjgi1
         06K+X2JnXepY40yODkiJAO2Q+LWo+1B8SZO1SqYiXunHuDXS7qFE0fEE/z20qqZhmD42
         tjTnIcI3KF/4vputNHoO05AL7Z5Qkq5kuxVT9Ga7dr7ay2Tou7+yo8I+VCt62ZkDZJjl
         ihVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1vWevEYx2eZU/ZyTrzY1BC3ECKOjJ/CGllfP1afgIp0DMcIGTlB7NZMlhCKNmZLCVQVKetr9VL/KUK/vQ6taNVh2ded8MqBRDKheMSwE6ejJYMdAZ2xR/kt8bsPtxDodc3jy53qpPw==
X-Gm-Message-State: AOJu0Yx6EIgV8KTGu5G6uw3DCX9ZY6WtoJRYPGKViZyqSP1psAVuyXMH
	VfWpOovu6b/a7PGBRvYEAFnrmXyLxAc8G8SGldbuB/GlEcnbDU51vr9/xPX4tPEACiHwddlp4lb
	XubREWrj0Y/t72rxfWtcuZgjUvG8=
X-Google-Smtp-Source: AGHT+IEgM4iEd4jMMm+EgDh0hlCsdUSzQF59auS/YHpn16luP+NkPzAahk8j/ytqswvKTeU0s2kUrOhGLUSUYfIcevQ=
X-Received: by 2002:a17:90a:f195:b0:2b2:760d:9507 with SMTP id
 bv21-20020a17090af19500b002b2760d9507mr2255240pjb.0.1714730050781; Fri, 03
 May 2024 02:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com> <20240503-imx95-dts-v3-v4-3-535ddc2bde73@nxp.com>
In-Reply-To: <20240503-imx95-dts-v3-v4-3-535ddc2bde73@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 3 May 2024 06:53:58 -0300
Message-ID: <CAOMZO5D9i8LG7-4X6D+oHfZrJj+QoKa0DTusMX-H32227_s_4Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK
 minimal board dts
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

On Thu, May 2, 2024 at 10:29=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> +       aliases {
> +               gpio0 =3D &gpio1;
> +               gpio1 =3D &gpio2;
> +               gpio2 =3D &gpio3;
> +               gpio3 =3D &gpio4;
> +               gpio4 =3D &gpio5;
> +               i2c0 =3D &lpi2c1;
> +               i2c1 =3D &lpi2c2;
> +               i2c2 =3D &lpi2c3;
> +               i2c3 =3D &lpi2c4;
> +               i2c4 =3D &lpi2c5;
> +               i2c5 =3D &lpi2c6;
> +               i2c6 =3D &lpi2c7;
> +               i2c7 =3D &lpi2c8;
> +               mmc0 =3D &usdhc1;
> +               mmc1 =3D &usdhc2;
> +               mmc2 =3D &usdhc3;
> +               serial0 =3D &lpuart1;
> +               serial1 =3D &lpuart2;
> +               serial2 =3D &lpuart3;
> +               serial3 =3D &lpuart4;
> +               serial4 =3D &lpuart5;
> +               serial5 =3D &lpuart6;
> +               serial6 =3D &lpuart7;
> +               serial7 =3D &lpuart8;
> +       };

This looks like an excessive aliases list.
Can't you just have serial0, mmc0, and mmc1 instead?

> +       reg_1p8v: regulator-1p8v {
> +               compatible =3D "regulator-fixed";
> +               regulator-max-microvolt =3D <1800000>;
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-name =3D "+V1.8_SW";
> +       };
> +
> +       reg_3p3v: regulator-3p3v {
> +               compatible =3D "regulator-fixed";
> +               regulator-max-microvolt =3D <3300000>;
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-name =3D "+V3.3_SW";
> +       };
> +
> +       reg_vref_1v8: regulator-adc-vref {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vref_1v8";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +       };

These regulators are not used anywhere.

Please add them when they have consumers for them.


Return-Path: <linux-kernel+bounces-79918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15178628B4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4779EB21682
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7B91C06;
	Sun, 25 Feb 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdA7En2t"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9241361;
	Sun, 25 Feb 2024 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708823477; cv=none; b=ZCSOoS+kHGBj48QgCNRSJD95Ix5OhQtNK0mxdsMV8TeXZVW55BCoMRy0LxTK5BmvLU1PU5EXXrOlhHGZ3RDJkre4ilT+9u0scqi3fXROY7pRj+qowyUWrwdxYX3GQHtkQGipBFZobVyMSPojAEHWeKyFZ3c4L/qZloKYn/K+uLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708823477; c=relaxed/simple;
	bh=MYWyneyj/6bPXH9E47eOEXQ0aJWVsRAWnf4GALu6ZDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKMEe7xNK8MJB/fmGSZYZFV2qFU0MVs5C/45tAkFMoEdj9l2mWwhNPsfMsp58tKoUIXFjFbEm9hJExrTjzTzpeNiKyY0LC4qkpmqq9WzmT8JqW56iPqLnOzJ6wNxLO1ViL9xR6Mlb3SGNi+/1m4++uA+tJkDM7F289SIaXGQCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdA7En2t; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso870327a12.0;
        Sat, 24 Feb 2024 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708823475; x=1709428275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LtTTzazovHI2g3CNqT0DXTYhb/bE1LgNvtv2ROcmq4=;
        b=UdA7En2tJYt+mJOiVjmagZ5cWXMg/p0YOAZbxx829jM6zCOphoZtnS17hXagQDzgwO
         glz2oFBP/uUvkQ/eieHUqNrZ2dTeTOyR14Zd6DHyj6PtSG7RSf0h+peds3FXK6EhwZzi
         oPL7VngjbaTf6PVBMgM0Fwd9qN5lMG3RiH1YX9VIUF6UsNBc0ywHGmoTqjfG3RPinhFu
         GtFSNY5hUvrzGjORp7HLE8xdiyqpWo3Y1/XmMTG1pYniM/zTuMGfY3kyUwmslNWeZ9IB
         P0gpJUCvcRqEleloRGiUCung1C0Btd63kjdGq6AF5Lwnv3rYxpCFpIIBWdFe4vMvRKEq
         P4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708823475; x=1709428275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LtTTzazovHI2g3CNqT0DXTYhb/bE1LgNvtv2ROcmq4=;
        b=dknBkvIslVjtwvLjWwgnh4WOqibS9Y4+tcxZ8/XdP5zw18nBchW0hDDhaSidAhZmDu
         EfA/fjHgnDU+c+Ksy4JJqIij+FgpnbbTfD3njuvJxDB5ybs/9bLVLmfxkGjh/c2mvmqZ
         NdBzxBwgWbZK8qnHO+MwvYMJtt2famphiGMmWCDlH0FIyU7Is10hg3eKFEiRaxZQ7cWU
         NOIPSYB9c9aC537OoGox4caK/daQ46lgmFI6BNXOSCjKVKR2coexT87LNdPy1quia+WO
         POJSgDzgJ92GwMg2WpfSqo5tissUW4MPHxpiF2Mbdriqrng3O2/fouPgy5U6byDNtLWP
         5svQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhpCsqRmC/WU9lfKC13XKCCc2TzAfVwtV+siRMpqpJCoRNNXq5NIQ2jxfyV7Szn+UhLYVXS810wonCKXfKCQO1oMLrK8GEYYYSu//xrrpdnVTEkhIFgXcsJLT+JPiDp0jKwC+arUmQjA==
X-Gm-Message-State: AOJu0YyvbVAK9Y0zKMoX73h9XjrgH1v3Ot9zjxJ7722CgFa8B+BTJm9B
	JRwOe3ersW6y8c6w6ZGsUJ/Y3YSoV/zyRAVS7lwyjxJTcpiwfAZ1Q5XNwFOfs/DZZ12KhYpwQa0
	OlgY9n/0xlfpTwNXhOz4zp5bDwAs=
X-Google-Smtp-Source: AGHT+IE99RSW7JiYYDXQLSC/vA3BGmE2bgYYJlwv6gfmBoXARGf2DXgOzKcf7LoYuRujarA12d7p0TE17k2cC4UoRBc=
X-Received: by 2002:a17:90a:6787:b0:298:c3b4:f6ab with SMTP id
 o7-20020a17090a678700b00298c3b4f6abmr2761456pjj.2.1708823475446; Sat, 24 Feb
 2024 17:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224213240.1854709-1-sre@kernel.org> <20240224213240.1854709-17-sre@kernel.org>
In-Reply-To: <20240224213240.1854709-17-sre@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 22:11:03 -0300
Message-ID: <CAOMZO5CWQk8__qwHF8ysXnY4zAfd_FvW+Znd1sdoPc_uPJJE4A@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] ARM: dts: imx6ull-uti260b: Add board
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 6:33=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> +&gpio2 {
> +       /* configuring this to output-high results in poweroff */
> +       power-en-hog {
> +               gpio-hog;
> +               gpios =3D <6 GPIO_ACTIVE_HIGH>;
> +               line-name =3D "power-en-gpio";
> +               output-low;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&mux_poweroff2>;
> +       };
> +};
> +
> +&ecspi3 {

It is recommended to put the nodes in alphabetical order (except
iomuxc, which is the last one).

> +       mux_gc0308: gc0308grp {
> +               fsl,pins =3D <
> +                       MX6UL_PAD_CSI_MCLK__CSI_MCLK                    0=
x1e038
> +                       MX6UL_PAD_GPIO1_IO05__GPIO1_IO05                0=
x1b088
> +                       MX6UL_PAD_GPIO1_IO06__GPIO1_IO06                0=
x1b088
> +               >;
> +       };
> +
> +

There is an extra blank line here.

Reviewed-by: Fabio Estevam <festevam@gmail.com>


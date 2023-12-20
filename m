Return-Path: <linux-kernel+bounces-6837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100FA819E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CCEB23BED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1F219EE;
	Wed, 20 Dec 2023 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6PfQ08l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9C219EA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e74b4d5445so22851367b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703072558; x=1703677358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FLRBJiNc6al0xeoGFcYf16xBZK82GduG3jNIF84OAQ=;
        b=e6PfQ08lwOZZ7MX7LkhGnQFyUDXjnsM2BvakPJ70/70UltcOnwAyD8DdtGuYwX+d3D
         9g3fqIE9uH+Li5zkJw5D3VuJQn08FkDe+iyRk9LOnU/vFAnLEn+a6n4PDbD2e7vceFUS
         87rqldDxqeeh22XAiWpEF8HKoZ/MWo09H1uh6pGIaXas2uPwvlCPe/M3PrE/XmJ1iC0h
         fadTU49A5Dei1r6FjT6iv2mYsaM8hLna/mxuID24cJ1L9ue0pWRs3gSxfGgSVyIgYtzY
         P6M2H4y9Qm0XeB4XrTykcN4Z6Mc8nH49W+ONO2OC1qj2MsVORprClaEFpIYH50jcqmJg
         jQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072558; x=1703677358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FLRBJiNc6al0xeoGFcYf16xBZK82GduG3jNIF84OAQ=;
        b=ahDDvvHqv5hKXYhltWE/iCXd9njhUzEGTyH+SywNOs6uLW9VKd5C9eLfTXuIgHGzma
         wUJLL7IiAGpsQDDxmuqfbAnNVcvhx/LnO9/L+c+YcP+9A/iuaxZTzQHwuARJrQrEMLQs
         gMjDblY/9BLydXw/1jhLomXBUV6GK9n2hRoHGa4P2AVZfju9eu++J5/hKanDN3/bhUtC
         va2ynwgYhjdp9qBhFTKT9gM4INWCPPjpuMCHxOhPRZa5mbvTUm3iZYDHHjhwSSUhJ1e6
         zGdZ+eygt2gYfohJI3KZcRhElIcLCENTfgeKMbFAQSugs+qSkIgb2D/IO0HnOtdUFv8A
         T0rA==
X-Gm-Message-State: AOJu0YzyeDg3Up6j+VOJXAA9NehRp05zSXu2TIk0h026nJBr3SBLc2+u
	bYOcpa8sK3xIzqm+rB0gfc9ITHC8jANnY+OO4FbQZA==
X-Google-Smtp-Source: AGHT+IH3m7OJl+wThf8u3VljPqCG95kkRpc/xctYLP3ucKD0Kbqc3CXmlXTyhUH1P63lrHUB2J1XyLYIBc+4z1ycFC8=
X-Received: by 2002:a0d:c704:0:b0:5d7:1940:53c4 with SMTP id
 j4-20020a0dc704000000b005d7194053c4mr16842637ywd.60.1703072558142; Wed, 20
 Dec 2023 03:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com> <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
In-Reply-To: <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:42:27 +0100
Message-ID: <CACRpkdbpcwADJnZz1Q0KQ-gJv8FvnvJS=4PpMF+Np4rNCN3x+w@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl protocol
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Takahiro Akashi <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

On Fri, Dec 15, 2023 at 12:52=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

In this example, as it is not intended to reflect any specific hardware,
use the latest canonical naming:

> +
> +            scmi_pinctrl: protocol@19 {
> +                reg =3D <0x19>;
> +                #pinctrl-cells =3D <0>;
> +
> +                i2c2-pins {
> +                    groups =3D "i2c2_a", "i2c2_b";

groups =3D "g_i2c2_a", "g_i2c2_b";

> +                    function =3D "i2c2";

function =3D "f_i2c2";

> +                };
> +
> +                mdio-pins {
> +                    groups =3D "avb_mdio";

groups =3D "g_avb_mdio";

> +                    drive-strength =3D <24>;
> +                };
> +
> +                keys_pins: keys-pins {
> +                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";

pins =3D "gpio_5_17", "gpio_5_20", "gpio_5_22", "gpio_2_1";

These names look odd to me, like these are actually groups
with pins 5..17 etc. Should it be groups =3D "g_gpio_5_17" etc?

Yours,
Linus Walleij


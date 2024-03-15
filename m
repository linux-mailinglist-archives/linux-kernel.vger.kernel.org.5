Return-Path: <linux-kernel+bounces-104968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5787D6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCFEB21A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227085810A;
	Fri, 15 Mar 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8l9mfb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1AE542;
	Fri, 15 Mar 2024 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542477; cv=none; b=cl/RcBqkGxZUxsmZY/uXobYGvhjqlNrBzM5awDAMJKE8bo7M48tRDMARPaiEcIvC3KjvIeamrZk5XFgjR4b9P2M21aCSsg/QBlfbw+MzcMXQk0aOCsDPskwItu7/0J5XO6qOuNyVLKqtz8lbYhYGX/+61fWzDAIQjaHxfY0b/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542477; c=relaxed/simple;
	bh=+d8f7ozp1fczAC9vBPCNIiDBAqrIkkfS0UnjmlXtzwU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=SCkQZ3EHZS67WOpkVPo0lY44zeMnJMXmLfv62UMABuIRvk1LgRmEIjzH8jTpMbGeATZdQusPkpHCc/Rg/GDXq+gKfP0L38orlm6JD1mEfNiBYdYptpz+8IgzSdwFrFcm66r/B1QI0fKKLmX7QLjc2kHRui/b2UuP8NmN9Nd3GVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8l9mfb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A938EC433F1;
	Fri, 15 Mar 2024 22:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710542476;
	bh=+d8f7ozp1fczAC9vBPCNIiDBAqrIkkfS0UnjmlXtzwU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=e8l9mfb65Jxs98ZTM68IIz8f57uo0DoJOlcSADkTgiKJGrRoguFcFGgrdtO94MZLL
	 yUQ1Y8ExfoREnO7PParl5J7v1hNubPSVQjZeV3sk3Trk9waECS/1a0m/gYwjo+93PY
	 1eOUeZVB8OBde9pSImLddiZaQX3oxyAt9rcHTCH3ekRglFIP9nNJZRz9Z0Uy9iHqB7
	 nrfbj4PZVHBZWMLmECgMabXWu9KY4TymyOBUGuMrIV8WrUjlwAPvWC29iOm45MZt+5
	 MPQrGyacW+5U+BAYTYlX4MBPCejDQzpxEfl2HXJJezJW1rh+4W0tldYBFcC1GxLi+0
	 hIod0XdaiSTkg==
Message-ID: <3cd275cb1f53a5fdfbf7028f233f4fd7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240315222754.22366-2-wafgo01@gmail.com>
References: <20240315222754.22366-1-wafgo01@gmail.com> <20240315222754.22366-2-wafgo01@gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3
From: Stephen Boyd <sboyd@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Chester Lin <chester62515@gmail.com>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Andrew Halaney <ahalaney@redhat.com>, Bartosz Golaszewski <bartosz.golaszewski@linar
 o.org>, Johannes Zink <j.zink@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>, Russell King (Oracle) <rmk+kernel@armlinux.org.uk>, Swee Leong Ching <leong.ching.swee@intel.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
To: Wadim Mueller <wafgo01@gmail.com>
Date: Fri, 15 Mar 2024 15:41:14 -0700
User-Agent: alot/0.10

Quoting Wadim Mueller (2024-03-15 15:27:47)
> diff --git a/include/dt-bindings/clock/nxp,s32-scmi-clock.h b/include/dt-=
bindings/clock/nxp,s32-scmi-clock.h
> new file mode 100644
> index 000000000000..240022c1f109
> --- /dev/null
> +++ b/include/dt-bindings/clock/nxp,s32-scmi-clock.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +
> +#ifndef __DT_BINDINGS_NXP_SCMI_CLOCK_S32_H
> +#define __DT_BINDINGS_NXP_SCMI_CLOCK_S32_H
> +
> +#define S32_SCMI_COMPLEX_CLK           0xFFFFFFFFU
> +#define S32_SCMI_NOT_IMPLEMENTED_CLK   0xFFFFFFFEU
> +
> +#define S32_SCMI_CLK_BASE_ID           0U
> +#define S32_SCMI_CLK(N)                        ((N) + S32_SCMI_CLK_BASE_=
ID)
> +#define S32_PLAT_SCMI_CLK(N)           ((N) + S32_SCMI_PLAT_CLK_BASE_ID)

I think we've been recommending that scmi clk consumers simply list the
number instead of making up defines for them.

> +
> +#define S32_SCMI_CLK_VERSION_MAJOR     (1)
> +#define S32_SCMI_CLK_VERSION_MINOR     (0)

Why is this part of the dt binding?


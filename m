Return-Path: <linux-kernel+bounces-7840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61281AE15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4E11F2479E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2668BED;
	Thu, 21 Dec 2023 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUwqrrQw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AA8C00;
	Thu, 21 Dec 2023 04:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67187C433C8;
	Thu, 21 Dec 2023 04:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703133494;
	bh=EoN6l1+DooB0CJ/UZoJpfudxWXvrGj8uF1Np3H6ZHmE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cUwqrrQwQh8SPx3VgsGUy7jxNJDcj4wMWHpM5mIiU1Lu/YzJ2tqGwxykGIBTFk67z
	 kIwB74j0yhQdLBp6HGAwdte9/dYFssNjaWcZsaLLbjDQihG2HrD5W9s5fd2NY3sFS7
	 BLnRtm4/uhcABV6V6qyDetDJFIOyomef7vA53jasWi7HyUO9a4tgfUA7n8s7WTuaNp
	 E8rJDIPrjVVvPStejHSsI7U8bqB4N0DBzE3sZU2Yl6uE0O57je90tO5zjywGO6rzRY
	 EvideAuyhMoruVqVGgSdZvxigk7lXySpx5lwa8dsoQdUEkpwH78njGpXEorI36PsZp
	 jgR5FEu04FWcw==
Message-ID: <2c37cada9bb4be59bf06fa9a9df81e07.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231219232442.2460166-2-cristian.ciocaltea@collabora.com>
References: <20231219232442.2460166-1-cristian.ciocaltea@collabora.com> <20231219232442.2460166-2-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 1/2] clk: starfive: Add flags argument to JH71X0__MUX macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jacob Keller <jacob.e.keller@intel.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 20 Dec 2023 20:38:12 -0800
User-Agent: alot/0.10

Quoting Cristian Ciocaltea (2023-12-19 15:24:39)
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>=20
> This flag is needed to add the CLK_SET_RATE_PARENT flag on the gmac_tx
> clock on the JH7100, which in turn is needed by the dwmac-starfive
> driver to set the clock properly for 1000, 100 and 10 Mbps links.
>=20
> This change was mostly made using coccinelle:
>=20
> @ match @
> expression idx, name, nparents;
> @@
>  JH71X0__MUX(
> -idx, name, nparents,
> +idx, name, 0, nparents,
>  ...)
>=20
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Applied to clk-next


Return-Path: <linux-kernel+bounces-152081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43968AB88E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE1281D23
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC00610E;
	Sat, 20 Apr 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSWaSrWE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14A2CA4;
	Sat, 20 Apr 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713578035; cv=none; b=bDUQNetjTjBdYE8tQggdM32b29M/Fw8lqCDrV6Zhp6WGZxHImSZuq4h+4mNonN7YpThfz9AWwKJkjzjzbzGG02zwXowPGL2uLg6IU0mzJTATNjxTzmenciCJdgC+GvrmvQOr25hXGwuxPmZ1C+lMtp60t+IfiQHux86NdeQJhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713578035; c=relaxed/simple;
	bh=H0U+uv4/liInL2qHfZyN5D6gZvXyBkXxbB3CdMD+QWQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=HEkSHRYdlGPPD/LdeJx5TYzgNAmGstYBSCYQm9R8rrbcYnJwN8PxT/p3QEsE6Kshr2kNTzlNEib94oOfsdiRnjYiZ7nUpCIHXTJOYFkrTfZwio8n6F4br7vvElvMMvgx8LIcyCiAhM9LRd8v/4tfHn+483O5LPokJt7hdvSL3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSWaSrWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1849BC072AA;
	Sat, 20 Apr 2024 01:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713578035;
	bh=H0U+uv4/liInL2qHfZyN5D6gZvXyBkXxbB3CdMD+QWQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BSWaSrWED8YZ5BJ94DbOdp3O+QP/RcjxY+1SHo09SPwpyLWeImGQ5AuD0UaPeo4J9
	 3OmOqXalwx00c1YgvjAm+xATatXkZdzAo2YlDPib69qM3mswDnS+qYg32gBh/X3lUs
	 NYo6CkLLUW8im8oIQwROY8sqjMoXHWzn1SoXdE3dCEjb4Ac4P5tPdnnm/lJviSVoM+
	 u+X3uD7taONV2JYCblkEBSfsTsPcjfR0znFJtwy3rUNv+DPkLBSwgICiAb1pEhi0uh
	 B/D+id7DKnby3m7uEm8TiCOzUcenSbbQ11c5Llk4gLck0AR8sQcffT8jjyKIDJO1CR
	 dJUP28Nq7KZdw==
Message-ID: <8a305f2938f64ab084b3e92c6d066c1f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231023-display-support-v3-12-53388f3ed34b@baylibre.com>
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com> <20231023-display-support-v3-12-53388f3ed34b@baylibre.com>
Subject: Re: [PATCH v3 12/17] clk: mediatek: mt8365-mm: fix DPI0 parent
From: Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
To: Alexandre Mergnat <amergnat@baylibre.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Fabien Parent <fparent@baylibre.com>, Jitao Shi <jitao.shi@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Markus Schneider-Pargmann <msp@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Will Deacon <will@kernel.org>
Date: Fri, 19 Apr 2024 18:53:52 -0700
User-Agent: alot/0.10

Quoting Alexandre Mergnat (2024-04-18 07:17:00)
> To have a working display through DPI, a workaround has been
> implemented downstream to add "mm_dpi0_dpi0" and "dpi0_sel" to
> the DPI node. Shortly, that add an extra clock.
>=20
> It seems consistent to have the "dpi0_sel" as parent.
> Additionnaly, "vpll_dpix" isn't used/managed.
>=20
> Then, set the "mm_dpi0_dpi0" parent clock to "dpi0_sel".
>=20
> The new clock tree is:
>=20
> clk26m
>   lvdspll
>     lvdspll_X (2, 4, 8, 16)
>       dpi0_sel
>         mm_dpi0_dpi0
>=20
> Fixes: d46adccb7966 ("clk: mediatek: add driver for MT8365 SoC")
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---

Applied to clk-next


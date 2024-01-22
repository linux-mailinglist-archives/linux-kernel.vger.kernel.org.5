Return-Path: <linux-kernel+bounces-32777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01C835FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AEB1C21D02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485733A269;
	Mon, 22 Jan 2024 10:44:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D703A1BF;
	Mon, 22 Jan 2024 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920298; cv=none; b=Q+bqxO9kfjpjL4wuoAEUFGWCRxa3wiZx9ivZiQpnNijP+yvVfqj1b/N/ouDWx44Qf4NbTxzlHKsSaVEOBxQq6wKSzYpP7dqHAOZT/jzNXZ0ukIj41XTvqIx945+DVn0nhnY/5s1roSQQfnahphWe9wfh6jXZEV3vm+ETtQ9r1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920298; c=relaxed/simple;
	bh=Oo9JvPel0eUrGXufOdPEuMNLinBUN4aQEBFsMu9+TLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osOhFdQwB2DSsOLBvF0/uec105GAwR8aH5mqJIB1LTr0y7DLWmfqss1cuDe8f0pPtKBJhvPZFqIm2z+j7zSdyGc6JfV3zlhHPF0WADDBSARcrVx6B6ZXYqzE/NFDOGqG5FseMJtek7Far0qTey6hSBthbrQVpJ090D9NhPxCk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 960351FB;
	Mon, 22 Jan 2024 02:45:42 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2247F3F5A1;
	Mon, 22 Jan 2024 02:44:55 -0800 (PST)
Date: Mon, 22 Jan 2024 10:44:52 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Emilio =?UTF-8?B?TMOzcGV6?=
 <emilio@elopez.com.ar>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: a20-gmac: fix kernel-doc warnings
Message-ID: <20240122104452.2fc420ac@donnerap.manchester.arm.com>
In-Reply-To: <20240121051837.17564-1-rdunlap@infradead.org>
References: <20240121051837.17564-1-rdunlap@infradead.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Jan 2024 21:18:35 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Move the function kernel-doc comment to be immediately before the
> function implementation, then add a function parameter description
> to prevent kernel-doc warnings:
>=20
> clk-a20-gmac.c:43: warning: expecting prototype for sun7i_a20_gmac_clk_se=
tup(). Prototype was for SUN7I_A20_GMAC_GPIT() instead
> clk-a20-gmac.c:53: warning: Function parameter or struct member 'node' no=
t described in 'sun7i_a20_gmac_clk_setup'

Confirmed to be just the move, plus the added parameter description.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre
=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Emilio L=C3=B3pez <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> ---
>  drivers/clk/sunxi/clk-a20-gmac.c |   21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff -- a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gm=
ac.c
> --- a/drivers/clk/sunxi/clk-a20-gmac.c
> +++ b/drivers/clk/sunxi/clk-a20-gmac.c
> @@ -15,8 +15,19 @@
> =20
>  static DEFINE_SPINLOCK(gmac_lock);
> =20
> +
> +#define SUN7I_A20_GMAC_GPIT	2
> +#define SUN7I_A20_GMAC_MASK	0x3
> +#define SUN7I_A20_GMAC_PARENTS	2
> +
> +static u32 sun7i_a20_gmac_mux_table[SUN7I_A20_GMAC_PARENTS] =3D {
> +	0x00, /* Select mii_phy_tx_clk */
> +	0x02, /* Select gmac_int_tx_clk */
> +};
> +
>  /**
>   * sun7i_a20_gmac_clk_setup - Setup function for A20/A31 GMAC clock modu=
le
> + * @node: &struct device_node for the clock
>   *
>   * This clock looks something like this
>   *                               ________________________
> @@ -39,16 +50,6 @@ static DEFINE_SPINLOCK(gmac_lock);
>   * enable/disable this clock to configure the required state. The clock
>   * driver then responds by auto-reparenting the clock.
>   */
> -
> -#define SUN7I_A20_GMAC_GPIT	2
> -#define SUN7I_A20_GMAC_MASK	0x3
> -#define SUN7I_A20_GMAC_PARENTS	2
> -
> -static u32 sun7i_a20_gmac_mux_table[SUN7I_A20_GMAC_PARENTS] =3D {
> -	0x00, /* Select mii_phy_tx_clk */
> -	0x02, /* Select gmac_int_tx_clk */
> -};
> -
>  static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
>  {
>  	struct clk *clk;
>=20



Return-Path: <linux-kernel+bounces-32778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE41C835FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95643287679
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024873A1DA;
	Mon, 22 Jan 2024 10:45:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FD73A8F3;
	Mon, 22 Jan 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920310; cv=none; b=CIXsSCj+05MbIoWxIzNQzkI0CSMEwaZDBNh5iQUBmJ5U8E3T/D4fz0er59XPQZ51+RN+L3P6rzcWmFdLrXgPnEB2g0VU9X8i/FoEkbwDw4qjrd6ojbNrPU4/iteeV5RMXNMGpNl/thybsxHxiw1WEvqq2Ddth5+VC2WeFKuTNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920310; c=relaxed/simple;
	bh=MP9qblO7l0EcL4VDFXP1Rehwt0w//Bdd/37L+LCTm34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2cIYVADwGDypVOfd8KBGM3r5eN+kO5qG+U8JozFm5vFpN+YDPGVzwZgNJKtjL9FzPwKNZolYdALuOa2xHihJyjnpJwy7GdbrQf/+D9KbLvILJtH9uUqP0NN+140bGpQ7v5BptTliOM0w9ZTz5/idzBNLl5lrA/s5s0MzHonCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 017DF1FB;
	Mon, 22 Jan 2024 02:45:54 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E0853F5A1;
	Mon, 22 Jan 2024 02:45:06 -0800 (PST)
Date: Mon, 22 Jan 2024 10:45:04 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Emilio =?UTF-8?B?TMOzcGV6?=
 <emilio@elopez.com.ar>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: sun9i-cpus: fix kernel-doc warnings
Message-ID: <20240122104504.1f84ed98@donnerap.manchester.arm.com>
In-Reply-To: <20240121051845.17603-1-rdunlap@infradead.org>
References: <20240121051845.17603-1-rdunlap@infradead.org>
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

On Sat, 20 Jan 2024 21:18:44 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Move the function description kernel-doc comment to immediately above
> the function implementation, correct the function name in the comment,
> then add a function parameter description to prevent these kernel-doc
> warnings:
>=20
> drivers/clk/sunxi/clk-sun9i-cpus.c:25: warning: expecting prototype for s=
un9i_a80_cpus_clk_setup(). Prototype was for SUN9I_CPUS_MAX_PARENTS() inste=
ad
> clk-sun9i-cpus.c:184: warning: Function parameter or struct member 'node'=
 not described in 'sun9i_a80_cpus_setup'

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

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
>  drivers/clk/sunxi/clk-sun9i-cpus.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff -- a/drivers/clk/sunxi/clk-sun9i-cpus.c b/drivers/clk/sunxi/clk-sun9=
i-cpus.c
> --- a/drivers/clk/sunxi/clk-sun9i-cpus.c
> +++ b/drivers/clk/sunxi/clk-sun9i-cpus.c
> @@ -18,9 +18,6 @@
> =20
>  static DEFINE_SPINLOCK(sun9i_a80_cpus_lock);
> =20
> -/**
> - * sun9i_a80_cpus_clk_setup() - Setup function for a80 cpus composite clk
> - */
> =20
>  #define SUN9I_CPUS_MAX_PARENTS		4
>  #define SUN9I_CPUS_MUX_PARENT_PLL4	3
> @@ -180,6 +177,10 @@ static const struct clk_ops sun9i_a80_cp
>  	.set_rate	=3D sun9i_a80_cpus_clk_set_rate,
>  };
> =20
> +/**
> + * sun9i_a80_cpus_setup() - Setup function for a80 cpus composite clk
> + * @node: &struct device_node for the clock
> + */
>  static void sun9i_a80_cpus_setup(struct device_node *node)
>  {
>  	const char *clk_name =3D node->name;
>=20



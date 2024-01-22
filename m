Return-Path: <linux-kernel+bounces-32779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46843835FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DD41C260E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762563A8E3;
	Mon, 22 Jan 2024 10:45:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228A3A8CF;
	Mon, 22 Jan 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920327; cv=none; b=H3eWHQie30oiBW0WQqRFvsICHaB++1+9fOG6MJqiqEHu5QacqN661sH2+7gnVZ4NeI59B/fWF2lnVho8OEgA5hZAeCcEhq4fPueV7fD6MUAV5bDTqHGsaUh9JM+BlyDX7qxsumLf5qpClKmS3EaJBwLSZzE7xL7bhlJKFrQNG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920327; c=relaxed/simple;
	bh=DsPCBfxhfwqn5+KUS4+3J9IPplxIlTdI3o7BZcP1A7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMgV5z1tffisudhmZe9l8dijLFP4EE541E4JH3MYM83OssuiB+Z5OXudSRdD1NVrwTIu+MK330mV1FYZM1zBl0KRZcNBl8vGomcGgY15LHtU5Xfw5W6Xf3bjJjt1eQe88rkHncuXgTR1coSw3vKxSaTlO9m5GlGHdo6iv1af/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0B191FB;
	Mon, 22 Jan 2024 02:46:09 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696DA3F5A1;
	Mon, 22 Jan 2024 02:45:22 -0800 (PST)
Date: Mon, 22 Jan 2024 10:45:19 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Emilio =?UTF-8?B?TMOzcGV6?=
 <emilio@elopez.com.ar>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: usb: fix kernel-doc warnings
Message-ID: <20240122104519.66116259@donnerap.manchester.arm.com>
In-Reply-To: <20240121051858.17647-1-rdunlap@infradead.org>
References: <20240121051858.17647-1-rdunlap@infradead.org>
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

On Sat, 20 Jan 2024 21:18:57 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Move the function description comment to immediately above the
> function implementation, the add function parameter descriptions to
> prevent kernel-doc warnings:
>=20
> clk-usb.c:80: warning: expecting prototype for sunxi_usb_clk_setup(). Pro=
totype was for SUNXI_USB_MAX_SIZE() instead
> clk-usb.c:91: warning: Function parameter or struct member 'node' not des=
cribed in 'sunxi_usb_clk_setup'
> clk-usb.c:91: warning: Function parameter or struct member 'data' not des=
cribed in 'sunxi_usb_clk_setup'
> clk-usb.c:91: warning: Function parameter or struct member 'lock' not des=
cribed in 'sunxi_usb_clk_setup'

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
>  drivers/clk/sunxi/clk-usb.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff -- a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
> --- a/drivers/clk/sunxi/clk-usb.c
> +++ b/drivers/clk/sunxi/clk-usb.c
> @@ -73,9 +73,6 @@ static const struct reset_control_ops su
>  	.deassert	=3D sunxi_usb_reset_deassert,
>  };
> =20
> -/**
> - * sunxi_usb_clk_setup() - Setup function for usb gate clocks
> - */
> =20
>  #define SUNXI_USB_MAX_SIZE 32
> =20
> @@ -85,6 +82,12 @@ struct usb_clk_data {
>  	bool reset_needs_clk;
>  };
> =20
> +/**
> + * sunxi_usb_clk_setup() - Setup function for usb gate clocks
> + * @node: &struct device_node for the clock
> + * @data: &struct usb_clk_data for the clock
> + * @lock: spinlock for the clock
> + */
>  static void __init sunxi_usb_clk_setup(struct device_node *node,
>  				       const struct usb_clk_data *data,
>  				       spinlock_t *lock)
>=20



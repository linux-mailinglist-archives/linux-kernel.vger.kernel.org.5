Return-Path: <linux-kernel+bounces-139946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD08A0974
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E70281F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B813DDB7;
	Thu, 11 Apr 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3XzKZJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938963D;
	Thu, 11 Apr 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819723; cv=none; b=k0+wuQh3xAHOWAIwpcltWeUvIF9qYjO3Wohql16/UV8E4H3+fd+I+ManSnyyWycPgZ+A+2RSefy5K+0yOII92bQXPTTsDwUaLXqcr0oMQaxwbnWKg6bkV1lS6oMrdq8b2pXEM1PIqR8Nene0Scx5rvdDMidIewJRMMXX5o2tY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819723; c=relaxed/simple;
	bh=322ODHpdo41MdbG+o0rwogPFPp8094HEwxEDulubhH8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FUJW/e3IYqHAjUfxb8HafK1qP7VCo8+GD15l+4GKBNvAcc1nS1h0HAumXP5gpk9C24b6mckUjJ1C7S708P3wfTkPRilhcbhP2cvZ6JQMoiyDYfGay+W/a6uGFmAcb+I6dBEcC3Uhr1rhZYcsKypKDKUwtkI/GZlCXpxU8PKoM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3XzKZJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214FCC433C7;
	Thu, 11 Apr 2024 07:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819723;
	bh=322ODHpdo41MdbG+o0rwogPFPp8094HEwxEDulubhH8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=G3XzKZJ2YWk6dCHgiw28ZM4uAf9YhgHyFukvTnHvtwwCzjSZryqCjZa3Mh3YPqTm+
	 AMGf7oQTLrk2RNmj2uZY8Ti5gBCrCLOmtlCT0cugFV66F1KzmTgvIUpRTfiLd6ftMq
	 H6OWwdRF86bD725youkdkdgwAi2gyGwOZQ83MrOKSyTMg/A0ZcKJaCwTO6AffcB9dO
	 lERBq9xsfotL8RBLjjRuAC2aj8x1ssAmUt4OANnvSE1Vn0TaczvGBH+ho39C97mRkn
	 VwWB0q1r9YxbkDvq8pOTSP2bGMpk237KhYnuStIwqGysTPgGWnjD899ajZkFB587KF
	 WVhtzisEd8eeQ==
Message-ID: <276bd3d76b57cf2916ba968e99499096.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240411070503.38093-11-mmyangfl@gmail.com>
References: <20240411070503.38093-2-mmyangfl@gmail.com> <20240411070503.38093-11-mmyangfl@gmail.com>
Subject: Re: [PATCH v8 09/13] clk: hisilicon: hi3620: Convert into platform driver module
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, David Yang <mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date: Thu, 11 Apr 2024 00:15:21 -0700
User-Agent: alot/0.10

Quoting David Yang (2024-04-11 00:04:54)
> Use common helper functions and register clks with a single of_device_id
> data.
>=20
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/clk/hisilicon/clk-hi3620.c | 191 +++++++++++++++--------------
>  1 file changed, 96 insertions(+), 95 deletions(-)
>=20
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/c=
lk-hi3620.c
> index 5d0226530fdb..8832cdd6bd57 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/slab.h>

You need to include linux/platform_device.h if you're making it into a
platform driver.


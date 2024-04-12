Return-Path: <linux-kernel+bounces-142006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D178A2608
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5A61F22DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153811CD04;
	Fri, 12 Apr 2024 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6LU2fnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51C1BC37;
	Fri, 12 Apr 2024 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901308; cv=none; b=KkojGIli2psDGR2yXJQ7L8Fb3kIKaG6VdOnKZSlDDCSn5rTMpLG9dLzJH67HyT8QTyuZLn5MYNU+VKueQev4grJOJjyH40X7AYthLIl6/SqpS/swwKZzt5ygcl2nf+YeZiyjBVYJ7zf03mf0AMMAyOdZXug+INt/QNmr+Dsl+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901308; c=relaxed/simple;
	bh=JQfz7/d2ng00GhHS3NyTYEkGb3OA5UK1hgQL93R0kkQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=I2pI2Lt5wu0El0Yusf8ypiZrPhcx3oUbA6r0wsBRXf6FKrMYTeYjztkYBQXjkihGEeMC9l5bpjYd1qurU6uh183mRb7nsLRBth9EiMdJcYlCet9McUxpRiJCxCRWZ6OuGeVChakvMFZNCKIYKOfAZnElyuBNpBcwN1+qgKaKYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6LU2fnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58A5C2BBFC;
	Fri, 12 Apr 2024 05:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712901307;
	bh=JQfz7/d2ng00GhHS3NyTYEkGb3OA5UK1hgQL93R0kkQ=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=o6LU2fnb99yOU2DGXXl4CaIGRYOU8kJ0Qnx4M0pnseswKGLRDhngbAk+QiLBy5BHz
	 WjRPTkYjPrDcOrbjyDcHPBfgCyTjmRyEzW85mz+28WR3Vn4h+Rbb7kzqDObhHLX0Iy
	 dY200DAjrfmrcbQI4g7YBYpAzk8bEeul9Jj62MzoHHw0i8FR0IRzkiDAXXjMHiz5L7
	 Mq9Zp4nE3y6sc6yQsG8YvIxbaPAHHfNgF7vGdRXi2w73qay4y3gb6y4V7yp6JuFBxo
	 7BY613fW8v+8IGw9S63yYpfTsnv9X8YYAtOXnr8Gd/3dasgSr2ZX6GAKjGQgbbmyMs
	 wzBinFu+Bm6/Q==
Message-ID: <58956ebc474b993e6da1d6689ecb9324.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <MA0P287MB2822BC109267BD20922FB581FE052@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
References: <cover.1711692169.git.unicorn_wang@outlook.com> <816122e9f22ddd9927e81e627be7f4683ba5c9e8.1711692169.git.unicorn_wang@outlook.com> <433e01f22ce5472aeb28cf0182d951bd.sboyd@kernel.org> <MA0P287MB2822BC109267BD20922FB581FE052@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v13 4/5] clk: sophgo: Add SG2042 clock driver
From: Stephen Boyd <sboyd@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com, inochiama@outlook.com, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com, xiaoguang.xing@sophgo.com
Date: Thu, 11 Apr 2024 22:55:05 -0700
User-Agent: alot/0.10

Quoting Chen Wang (2024-04-11 05:58:05)
>=20
> On 2024/4/11 12:11, Stephen Boyd wrote:
> > Quoting Chen Wang (2024-03-28 23:21:40)
> >> +static const u32 sg2042_mux_table[] =3D {1, 0};
> >> +
> >> +static const char *const clk_mux_ddr01_p[] =3D {
> >> +                       "clk_div_ddr01_0", "clk_div_ddr01_1"};
> >> +static const char *const clk_mux_ddr23_p[] =3D {
> >> +                       "clk_div_ddr23_0", "clk_div_ddr23_1"};
> >> +static const char *const clk_mux_rp_cpu_normal_p[] =3D {
> >> +                       "clk_div_rp_cpu_normal_0", "clk_div_rp_cpu_nor=
mal_1"};
> >> +static const char *const clk_mux_axi_ddr_p[] =3D {
> >> +                       "clk_div_axi_ddr_0", "clk_div_axi_ddr_1"};
> >> +
> >> +static struct sg2042_mux_clock sg2042_mux_clks[] =3D {
> >> +       SG2042_MUX(MUX_CLK_DDR01, "clk_mux_ddr01", clk_mux_ddr01_p,
> > Please use struct clk_parent_data or struct clk_hw directly instead of
> > string names.
>=20
> Hi, Stephen,
>=20
> I understand that for clk_init_data, parent_names/parent_data/parent_hws =

> are all acceptable. Why do you only suggest me to use=20
> parent_data/parent_hws here? Can you please explain?

Using parent_names requires a global string search for that clk. Using
clk_parent_data or parent_hws reduces that search significantly,
speeding things up. Not using any strings furthermore speeds it up, i.e.
using an index when the clk is external to the device and a clk_hw
pointer when the clk is internal to the device. We speed things up by
removing string comparisons, of which there are many. Any new code
should be using direct pointers or an index, no strings.


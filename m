Return-Path: <linux-kernel+bounces-140031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02A8A0A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965CC2834C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BD13E8A6;
	Thu, 11 Apr 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdjzMzsr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385EF13E04F;
	Thu, 11 Apr 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821984; cv=none; b=qkWtokyUjmkC6zvcCOFIihKs3pmCr4bgyPrkYfGH6KmaqKjr+fH1zbdJ2iiTdvoxJU8vojF2DzsJOJh0vW8EC//PdNf4ZEp84zYT5vhHEKi06WlBdj68kuEovQB3PSvrP7VZS5b9r4hiefG2/Ulaz9IkfjdRh9PkR2laSYqhAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821984; c=relaxed/simple;
	bh=3ImRIqYkB4b7VDBaog19HQRqWdwgMXfhcOiygPLA9zw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=en/Nc2T+KnpJHg76xIIRC69MMYHzNx7UaYJ0x8hJeZtvkRQe5KnZQV3EwK08mQzMc/oW3dpv2wo/RJnxkcBr3JP1Meoye1HvQ3EBEl/8eoT/5DJ5LmbHHBakNyoLDxHE+P+igKH+6mjC8klOM1mXNfPuCDIKBNIZCQ4JZDS1ZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdjzMzsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C9CC433F1;
	Thu, 11 Apr 2024 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821983;
	bh=3ImRIqYkB4b7VDBaog19HQRqWdwgMXfhcOiygPLA9zw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bdjzMzsrJ82+Dk+l0GgaVH/AI2FEi5SYevVWiyQDRlnQgmufeMJj4Qz33E8FamsFR
	 N8bD2AKRdykvkWzP/B81JnS0KaMSd8vU/0obrCU7cLQfRk2duWGJ/TzH04sRekILUx
	 G/bWFHbVhFxYcsY9M1hv/NjUK3lEZQ10/cq3gxXIcsYKDnpzqgtEUAMFdnVxosRotS
	 Awk5OWroHTZyqk2F/oQJcszrXbMF8pKViuQ2WPX7uJVUyRFsG+FK3NG5CPVcOdZtku
	 9ArTWn/vv91+wSSGBrq/DeS4BUUCMcvY+YkywvzWaH2mz2Vc7HtmaXUAMnAas3mxik
	 DZ7/OEemH8u8A==
Message-ID: <fa5fe57faeda3323174e4caddc1ac2a6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SEZPR06MB6959E563B692827A3E5152DD96052@SEZPR06MB6959.apcprd06.prod.outlook.com>
References: <20240225-pll-v1-0-fad6511479c6@outlook.com> <20240225-pll-v1-1-fad6511479c6@outlook.com> <d8dc639c2c6d188d2ce3728573d9a53d.sboyd@kernel.org> <SEZPR06MB6959E563B692827A3E5152DD96052@SEZPR06MB6959.apcprd06.prod.outlook.com>
Subject: Re: [PATCH RFC 1/2] clk: hisilicon: rename hi3519 PLL registration function
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Yang Xiwen <forbidden405@outlook.com>, Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 11 Apr 2024 00:53:01 -0700
User-Agent: alot/0.10

Quoting Yang Xiwen (2024-04-11 00:44:33)
> On 4/11/2024 2:52 PM, Stephen Boyd wrote:
> > Quoting Yang Xiwen via B4 Relay (2024-02-24 08:56:09)
> >> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilic=
on/clk-hi3559a.c
> >> index ff4ca0edce06..77fa4203a428 100644
> >> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> >> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> >> @@ -452,7 +452,7 @@ static const struct clk_ops hisi_clk_pll_ops =3D {
> >>          .recalc_rate =3D clk_pll_recalc_rate,
> >>   };
> >>  =20
> >> -static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
> >> +static void _hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
> > Prefix it with hi3559a then to be SoC specific please. But this is also
> > static so I'm not sure why this patch is needed at all.
>=20
>=20
> it includes the header that marks this function non-static. Also the=20
> prototype is incompatible.

What is 'it'?

 $ git grep hisi_clk_register_pll
 drivers/clk/hisilicon/clk-hi3559a.c:static void hisi_clk_register_pll(stru=
ct hi3559av100_pll_clock *clks,
 drivers/clk/hisilicon/clk-hi3559a.c:    hisi_clk_register_pll(hi3559av100_=
pll_clks,


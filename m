Return-Path: <linux-kernel+bounces-141971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019448A25A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3DC1C22640
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851231B95B;
	Fri, 12 Apr 2024 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0eg+fB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F317BCE;
	Fri, 12 Apr 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899191; cv=none; b=uSACbe4/8teJa2BcNgNp/+Rr0kv3oiqm0T4fW4TzsS/o1FX+jOkHIJtoUU4OHZRZhMksTzdWSWbYF7lFILI4KQyHotC42iEg3gWSlTY0X+bR/SsKn+pKSCgKGstKRuqRxaViCrpCJX4K+AziqkUAjc+/DUHof9x6kpfvy7BODW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899191; c=relaxed/simple;
	bh=JnUwlu3hA8OWMeLa8KCW3yju2ShEzFTZuW+pPMy4qJU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=QD2AMySp98HsoFUKv2W8V/6aVpSEjD+finfvHo5DEfL/X3g7sxuu5vhxX2qA6xIWE4JdqP8z0+dGefnpKxtUHqtqHQboIU6zNamvfkeGONL8QWbjzls2IclmloUB6ffMH7GbnP+UcJQ9FPJrYFO9HhWxnF2UL9zU7ivt/x0oFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0eg+fB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6608AC2BBFC;
	Fri, 12 Apr 2024 05:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712899191;
	bh=JnUwlu3hA8OWMeLa8KCW3yju2ShEzFTZuW+pPMy4qJU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=J0eg+fB9JaQywMndycZ6ohhjdQC1DvGQG//bGfPBvI17dD7Fh7ivnskva2zGeo78F
	 g8r6mVScCv0aNZvOmVfY5nyDDruzh/GLJKQwTvKzE8AbrfxxOcgbsbCW+t3t+zxYj7
	 xhaXcAVZCpKt5viKAByf8mv62xRXoYMcMQKeEIMLHq04iN47t7p4IMXXkbRyMvlEUm
	 2PweoigGphpnbm30iCN0k7+gBtjMFwofoKKLAi8R+Qy3hdyEupHBtzO+qR7pvgDv+k
	 DWYbiV4ilGXM3qv2dPtYyiOvf3BI6iDFVZLWZk8x8JPdOJ4rzWSAhqBb14m8qE4oFb
	 W/F8WDlR+Mhjg==
Message-ID: <32dec29a9a29ad204930fbf9eefd2b89.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D0H7PXOXYNXI.2QM4E0O02FK34@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com> <20240410-mbly-olb-v1-4-335e496d7be3@bootlin.com> <4ce9f3cea1ecd3777cf3e291cc865210.sboyd@kernel.org> <D0H7PXOXYNXI.2QM4E0O02FK34@bootlin.com>
Subject: Re: [PATCH 04/11] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 11 Apr 2024 22:19:49 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-04-11 03:14:09)
> Hello,
>=20
> On Thu Apr 11, 2024 at 5:06 AM CEST, Stephen Boyd wrote:
> > Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:33)
> > > index 4a537260f655..cb348e502e41 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -675,13 +675,15 @@ struct clk_div_table {
> > >   * CLK_DIVIDER_BIG_ENDIAN - By default little endian register access=
es are used
> > >   *     for the divider register.  Setting this flag makes the regist=
er accesses
> > >   *     big endian.
> > > + * CLK_DIVIDER_EVEN_INTEGERS - clock divisor is 2, 4, 6, 8, 10, etc.
> > > + *     Formula is 2 * (value read from hardware + 1).
> > >   */
> > >  struct clk_divider {
> > >         struct clk_hw   hw;
> > >         void __iomem    *reg;
> > >         u8              shift;
> > >         u8              width;
> > > -       u8              flags;
> > > +       u16             flags;
> >
> > This can stay u8
>=20
> It is unclear to me why it can stay u8? __clk_hw_register_divider() puts
> clk_divider_flags into flags field of struct clk_divider.
> BIT(8) overflows u8.

Oh, I missed that part.

>=20
> >
> > >         const struct clk_div_table      *table;
> > >         spinlock_t      *lock;
> > >  };
> >
> > We should add a kunit test.
>=20
> Will look into how this works and try something for next revision. I
> guess you are talking about adding clk_divider tests, not only tests
> for this flag? I cannot find any existing kunit tests for clk_divider.
>=20

Right, there aren't any tests today. Thanks.


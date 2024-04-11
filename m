Return-Path: <linux-kernel+bounces-139758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C48A075E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9492891D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4497013C3F4;
	Thu, 11 Apr 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8VqGLgX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1713BAE2;
	Thu, 11 Apr 2024 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811087; cv=none; b=L35U2zFXY8z6j3Zo3GJZ+AiBJUzDFk64ShGcrYc7NGDtAwMjyqJxmz5FWzWNcxq0Hk0ySC7oGCx6o7/FhAba9RTi0RpBz2W5o5KuASjuUSEmKsCDbB81fYE84u0Q/LzT7ENXdXlnIDeMC29najzlvboaiFSOIJr6HN8SA2SwTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811087; c=relaxed/simple;
	bh=GUxfCzNobyGC5VcWk513iZKVan8O3e+IeiUp4CdtYLk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Ox2vVC3OTevgwG2LDMtP/zW0f8vrE/j9GWYDfPoasqZ3Ljt9wgOObBKVCFXUhc4vBxxlNipPuiSzApcacCfRGPs8Xw3dwaUtrKDC+mFIMb3Rpz5QxQqmNjIgtx0idIuJvL/ifNhLDEgsCCCwk6p8ZqI7KnQejfD2IVm204U73Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8VqGLgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D200CC433F1;
	Thu, 11 Apr 2024 04:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712811087;
	bh=GUxfCzNobyGC5VcWk513iZKVan8O3e+IeiUp4CdtYLk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=b8VqGLgXa2uRDbIsxmNSEsx4zA5+/iDwI6SOLu+w8zQTw9+WewG6kT3Q75D7WGJL/
	 TH/ZWHffaBZf4TtPtv063/KFMtcvgZG+zRgt4S9EHP/z8mF6xOevdRvqaB0Dvzb5Sx
	 2TeQAGrZmAsDBwBe1ADEe2PfHgCnzfEN4WtUPnuXuq7ofvL8OUsF1KI6v6P07OnxdH
	 1XeIa0f/M/DewCvnAEw9IRTlhadSmiTamZ/CAYaWmSDeOODc3WnZLJDNqkERYTUG3q
	 dU2v27sDWR+WL0pbWeNlq35Mtmvn69p+WMi74N16r86r0FP+NsHHLJpM5RJZVg2PwT
	 /VjcZIxQSymYA==
Message-ID: <6709fe217cfbd78543e7dfe7c3acec6e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1htKQ5v0tH9HGRejnKwJ5ZauUWG_CzYUKegkVL4Ek8UxA@mail.gmail.com>
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-4-tmaimon77@gmail.com> <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org> <CAP6Zq1g5gwXvYzO5fnHxG-6__gSCpNBY7VeEPyr4Qtijya6EfQ@mail.gmail.com> <8acf846e767884978f3bb98646433551.sboyd@kernel.org> <CAP6Zq1htKQ5v0tH9HGRejnKwJ5ZauUWG_CzYUKegkVL4Ek8UxA@mail.gmail.com>
Subject: Re: [PATCH v23 3/3] clk: npcm8xx: add clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 10 Apr 2024 21:51:24 -0700
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-02-29 13:29:46)
> Hi Stephen,
>=20
> Thanks for your reply.
>=20
> On Thu, 29 Feb 2024 at 00:48, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2024-02-25 10:00:35)
> > > Hi Stephen,
> > >
> > > On Thu, 22 Feb 2024 at 07:58, Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Tomer Maimon (2024-01-31 10:26:53)
> > > > > +
> > > > > +static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *h=
w,
> > > > > +                                               unsigned long par=
ent_rate)
> > > > > +{
> > > > > +       struct npcm8xx_clk *div =3D to_npcm8xx_clk(hw);
> > > > > +       unsigned int val;
> > > > > +
> > > > > +       regmap_read(div->clk_regmap, div->offset, &val);
> > > > > +       val =3D val >> div->shift;
> > > > > +       val &=3D clk_div_mask(div->width);
> > > > > +
> > > > > +       return divider_recalc_rate(hw, parent_rate, val, NULL, di=
v->flags,
> > > > > +                                  div->width);
> > > > > +}
> > > > > +
> > > > > +static const struct clk_ops npcm8xx_clk_div_ops =3D {
> > > > > +       .recalc_rate =3D npcm8xx_clk_div_get_parent,
> > > > > +};
> > > > > +
> > > > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct device_node *parent_np =3D of_get_parent(pdev->dev=
of_node);
> > > >
> > > > The parent of this device is not a syscon.
> > > Once I have registered the map that handles both reset and the clock
> > > in general is syscon, this is why we will modify the DTS so the clock
> > > and the reset will be under syscon father node
> > >                 sysctrl: system-controller@f0801000 {
> > >                         compatible =3D "syscon", "simple-mfd";
> > >                         reg =3D <0x0 0xf0801000 0x0 0x1000>;
> > >
> > >                         rstc: reset-controller {
> > >                                 compatible =3D "nuvoton,npcm845-reset=
";
> > >                                 reg =3D <0x0 0xf0801000 0x0 0xC4>;
> > >                                 #reset-cells =3D <2>;
> > >                                 nuvoton,sysgcr =3D <&gcr>;
> > >                         };
> > >
> > >                         clk: clock-controller {
> > >                                 compatible =3D "nuvoton,npcm845-clk";
> > >                                 #clock-cells =3D <1>;
> > >                                 clocks =3D <&refclk>;
> > >                                 clock-names =3D "refclk";
> > >                         };
> > >                 };
> > > You can see other drivers that using the same method like
> > > https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/device=
tree/bindings/clock/socionext,uniphier-clock.yaml
> >
> > You will need a similar file like
> > Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-peri=
ctrl.yaml
> > then to describe the child nodes.
> I can do it.
> >
> > Socionext may not be the best example to follow. I generally try to
> > avoid syscon and simply put #reset-cells and #clock-cells in the node
> If I remove syscon I can't use syscon_node_to_regmap function, What
> should I use If I remove syscon? auxiliary bus? something else?

You should use auxiliary bus. You can make a regmap in the parent
driver and pass that to the child auxiliary devices still.

> > for the device. You can use the auxiliary bus to register drivers for
> > clk and reset and put them into the resepective driver directories.
> I little bit confused, what is an auxiliary bus to register drivers,
> can you provide me an example?

$ git grep -l auxiliary_ -- drivers/clk/
drivers/clk/microchip/clk-mpfs.c
drivers/clk/starfive/clk-starfive-jh7110-sys.c

You can decide to make either the clk or the reset driver the "main"
driver that registers the other auxiliary devices. Either way the DT
binding has a single node instead of one per logical driver in the
kernel.

> > Avoid syscon means random drivers can't reach into the device with a
> > regmap handle and read/write registers that they're not supposed to.
> Indeed, but the drivers could use the reset and clock memory map only
> if the module is also a child node.
>=20
> Please let me know what is your preferred way to handle it:
> 1. stick with syscon and upstream-defined documentation for the rst clk s=
yscon.
> 2. avoid syscon and use an auxiliary bus, appreciate if you could give
> me an example of how it should be done.
> 3. Avoid sycon and handle it differently.

I prefer 2


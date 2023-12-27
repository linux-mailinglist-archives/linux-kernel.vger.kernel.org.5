Return-Path: <linux-kernel+bounces-12138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E281F071
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F0128202B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207102576B;
	Wed, 27 Dec 2023 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BKKblfMm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F011DFC9;
	Wed, 27 Dec 2023 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 126EA60002;
	Wed, 27 Dec 2023 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703694622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QessdMBPnjzb5s9ZGKryHBBqE6qV0TJfrHNj00DkgTQ=;
	b=BKKblfMmPg+v0sWG14C1m4ICUEmMvk1dxZBPc5ojdko88JICk8J3zB63p5dwB91DiFaLsr
	F9ABXAtMFzEBYUjCYK8TqsGJUZKQX3PlLFvt0JA1ZwLR/frDs1uG+ULI4k87CXw60qHo6O
	AP4DYO7nQJWKO2BgBH6M6hqi2GihRCrwRP4dR8NSNhRlyiuIhb5Z0MUlGgZGcpGcVlh6Ph
	vjytMHkeY07DX+pobSOiM7Z3N7iooOh2bQZ634jXjX8nzzOEiiu7W8GCKU52rRkFNDnKL6
	qqB83x0lI+JDeBK3rtQjCTKcVQvbuvjyJD2UIs/C/ueWdZM9Ae5ZTauBD4UGGA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Dec 2023 17:30:20 +0100
Message-Id: <CXZ9C7Y8QT0D.38ZNTXUY0HWUW@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Rob Herring" <robh+dt@kernel.org>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/5] clk: eyeq5: add controller
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
 <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com>
 <a8f740c7a8c1222d4a42bad588c75e87.sboyd@kernel.org>
 <CXUTPV1ZOSID.323RSEP4BL2AT@bootlin.com>
In-Reply-To: <CXUTPV1ZOSID.323RSEP4BL2AT@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Fri Dec 22, 2023 at 12:25 PM CET, Th=C3=A9o Lebrun wrote:
> Hello,
>
> I've seen all your comments, thanks for that. I have a follow up about
> one:
>
> On Wed Dec 20, 2023 at 12:09 AM CET, Stephen Boyd wrote:
> > Quoting Th=C3=A9o Lebrun (2023-12-18 09:14:18)
> > > Add the Mobileye EyeQ5 clock controller driver. See the header commen=
t
> > > for more information on how it works.
> >
> > "See the header" is like saying "Read the code" which is pretty obvious=
.
> > Remove this sentence and tell us why only the PLLs are supported at the
> > moment or something like that.
> >
> > > This driver is specific to this
> > > platform; it might grow to add later support of other platforms from
> > > Mobileye.
> > >=20
> > > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > > ---
> > >  MAINTAINERS             |   1 +
> > >  drivers/clk/Kconfig     |  11 +++
> > >  drivers/clk/Makefile    |   1 +
> > >  drivers/clk/clk-eyeq5.c | 211 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  4 files changed, 224 insertions(+)
> > >=20
>
> [...]
>
> > > diff --git a/drivers/clk/clk-eyeq5.c b/drivers/clk/clk-eyeq5.c
> > > new file mode 100644
> > > index 000000000000..74bcb8cec5c1
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-eyeq5.c
>
> [...]
>
> > > +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
> > > +}
> > > +
> > > +CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);
> >
> > Please use a platform driver.
>
> I've been trying to do that but I had a stall at boot. I initially
> associated it with the UART driver acquiring a clock too early but
> instead it is the CPU timer clocksource driver that consumes one of our
> clock way earlier than any platform driver initialisation.
>
> The clocksource driver we are talking about is this one for reference:
> https://elixir.bootlin.com/linux/v6.6.8/source/drivers/clocksource/mips-g=
ic-timer.c
>
> Its usage of TIMER_OF_DECLARE means it gets probed by timer_probe ->
> plat_time_init -> time_init -> start_kernel. This is way before any
> initcalls. Our prior use of CLK_OF_DECLARE_DRIVER meant that we got
> probed by of_clk_init -> plat_time_init.
>
> I'm guessing we are not the first one in this situation; any advice on
> how to deal with it?

I went ahead with a V2, feeling it would be more productive to come up
with something and gather comments on concrete stuff. There were many
other things to address anyway.

I've addressed this point by declaring a dummy fixed-clock in the
devicetree that gets fed to the GIC timer. It is pretty much the same
thing as using `clock-frequency` which this specific clocksource uses
if `of_clk_get(node, 0)` fails. With the sent approach we have the
timer appear in the clock tree as a consumer.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


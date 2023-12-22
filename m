Return-Path: <linux-kernel+bounces-9658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0981C90D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10775B23C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F68A17735;
	Fri, 22 Dec 2023 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pTNTeZ3F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3B182A8;
	Fri, 22 Dec 2023 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93301E0009;
	Fri, 22 Dec 2023 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703244313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XK/HZcj+ulUoisKiFJSL4FfIuOQN1JBlybYK7NvCE1U=;
	b=pTNTeZ3F8iO+oHNN0CFGBJv6rwoAwkO6bzR/4fsL86vHWakDr0HsGN+CqCAaebxJUI9qh/
	mkdST+E723X8dDwaYOjc/kchkXOk0BazEgmInUQwYiFVXPTcRy+nWGTg4yAhc5A0NvxuUR
	c0Tp3uDrS3vfpNbsAqJz+yDYAzjlXsBJ85JnRqgqhAIeH18Ch6/1COci4Olq56yUTND80k
	dSHfp0OnYi1NMaklVkyT5dHWMTWc/AhrhQ+aEvvpiw5ixxYvjprJbolDMTzqMnMo0vITJt
	ylcktyWEU+uxTvYGGo8ed4d5bwvkeoUnJ3LFy2QjWqCMxirMSAs3syGWRCw//w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Dec 2023 12:25:12 +0100
Message-Id: <CXUTPV1ZOSID.323RSEP4BL2AT@bootlin.com>
Subject: Re: [PATCH 3/5] clk: eyeq5: add controller
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Rob Herring" <robh+dt@kernel.org>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
 <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com>
 <a8f740c7a8c1222d4a42bad588c75e87.sboyd@kernel.org>
In-Reply-To: <a8f740c7a8c1222d4a42bad588c75e87.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

I've seen all your comments, thanks for that. I have a follow up about
one:

On Wed Dec 20, 2023 at 12:09 AM CET, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2023-12-18 09:14:18)
> > Add the Mobileye EyeQ5 clock controller driver. See the header comment
> > for more information on how it works.
>
> "See the header" is like saying "Read the code" which is pretty obvious.
> Remove this sentence and tell us why only the PLLs are supported at the
> moment or something like that.
>
> > This driver is specific to this
> > platform; it might grow to add later support of other platforms from
> > Mobileye.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  MAINTAINERS             |   1 +
> >  drivers/clk/Kconfig     |  11 +++
> >  drivers/clk/Makefile    |   1 +
> >  drivers/clk/clk-eyeq5.c | 211 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 224 insertions(+)
> >=20

[...]

> > diff --git a/drivers/clk/clk-eyeq5.c b/drivers/clk/clk-eyeq5.c
> > new file mode 100644
> > index 000000000000..74bcb8cec5c1
> > --- /dev/null
> > +++ b/drivers/clk/clk-eyeq5.c

[...]

> > +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
> > +}
> > +
> > +CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);
>
> Please use a platform driver.

I've been trying to do that but I had a stall at boot. I initially
associated it with the UART driver acquiring a clock too early but
instead it is the CPU timer clocksource driver that consumes one of our
clock way earlier than any platform driver initialisation.

The clocksource driver we are talking about is this one for reference:
https://elixir.bootlin.com/linux/v6.6.8/source/drivers/clocksource/mips-gic=
-timer.c

Its usage of TIMER_OF_DECLARE means it gets probed by timer_probe ->
plat_time_init -> time_init -> start_kernel. This is way before any
initcalls. Our prior use of CLK_OF_DECLARE_DRIVER meant that we got
probed by of_clk_init -> plat_time_init.

I'm guessing we are not the first one in this situation; any advice on
how to deal with it?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-87776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D540486D8E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61831C2108C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A922E632;
	Fri,  1 Mar 2024 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQdmN5Xf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47AD39FCE;
	Fri,  1 Mar 2024 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256793; cv=none; b=dPW1Va2j+QeUXvK0YWj+mvRDOyBETbV+ruHf9xHGrXWGNp+p12Ai/PyUo/e2NhoqN/nB4QWyHk0FM5PKUxYHD5zJqHu3TfV2hsS8AXf3oRD2oRNk80VH7aLNrBYvjh7+fqMmr8VFQ9wpepaB7vALp1rBdwRp34u2jbGxOmFiU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256793; c=relaxed/simple;
	bh=EPalguZMNI5Njq+cA0Z5vHIwAsvdVkw9Z6GsK4GJQw4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kZxJMcbUL5KqgOb1h60k6G6iW1+qkAnU8vF38V8Xdp+deL8b0FVpXlussYuIsJXaWz6/+3EEqxrx+7LbzBhIhkfc88qOZ+6jEkfUMKJy3l7jxkQDWWk2ZmoE3L6GEbUDyIL26z6NbajTxLhODReg/32RYSHBANzvyuNeLEAeRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQdmN5Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C741C433C7;
	Fri,  1 Mar 2024 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256792;
	bh=EPalguZMNI5Njq+cA0Z5vHIwAsvdVkw9Z6GsK4GJQw4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sQdmN5XfBeohDiRuXg5jE9JTzQsZoaXW1+rWjcvDXhcqo0t0yVw0gar/D1ZB3nu26
	 cxMusPCGjm08abajYAE0U4MgNR/V1Pmdi6uNjsxzyN8Dvmd5v1OKTv8Mgn4oPmRvfY
	 cvjHN8ZXEuY+1TRGf4c3uJXbrWDefmvYHzsal6HdPNkTd8tjf+5QLYwLgisTBAj8ZO
	 zjE02xJbtMd+6zJ4HnXG+ifBOHEICZqbQ5+CqgFTI6n/2DO6bC9Of+e5wmBaoP7ljc
	 3DT7VI6hBdI1CPLWeH7NBcTakqp2ujqHIn6kmrYFNCRR56K4MdAY7f2PvhQOQiHn6s
	 fNisvaChiDmVg==
Message-ID: <cd72dbb31387cd4e2551189d8d10d3a6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CZHOCV35A23S.14HL07U73EH6X@bootlin.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com> <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com> <Zd4X3NnBoEl0wu2H@smile.fi.intel.com> <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com> <ZeBnX2upNRN0xXH4@smile.fi.intel.com> <CZHMSNWMH4KJ.2J6ZMWKMSZYH2@bootlin.com> <ZeCbvgWY6x1o17Kq@smile.fi.intel.com> <CZHOCV35A23S.14HL07U73EH6X@bootlin.com>
Subject: Re: [PATCH v8 03/10] clk: eyeq5: add platform driver, and init routine at of_clk_init()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Linus Walleij <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 29 Feb 2024 17:33:10 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-02-29 07:40:25)
> Hello,
>=20
> On Thu Feb 29, 2024 at 3:59 PM CET, Andy Shevchenko wrote:
> > On Thu, Feb 29, 2024 at 03:27:01PM +0100, Th=C3=A9o Lebrun wrote:
> > > On Wed, Feb 28, 2024 at 03:33:29PM +0100, Th=C3=A9o Lebrun wrote:
> > > > On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> > > > > On Tue, Feb 27, 2024 at 03:55:24PM +0100, Th=C3=A9o Lebrun wrote:
>=20
> > 2) Still I see a benefit from using lo_hi_readq() and friends directly.
>=20
> So it is:
>=20
>         u32 r0 =3D readl(base_plls + pll->reg64);
>         u32 r1 =3D readl(base_plls + pll->reg64 + sizeof(r0));
>=20
> vs:
>=20
>         u64 r =3D lo_hi_readq(base_plls + pll->regs64);
>         u32 r0 =3D r;
>         u32 r1 =3D r >> 32;
>=20
> One is straight forward, the other uses an obscure helper that code
> readers must understand and follows that with bit manipulation.
>=20

Just use readq() and include the correct header please. We know what
readq() is in the kernel.


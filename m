Return-Path: <linux-kernel+bounces-152003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19068AB73D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A782E1F2254D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160913D2BE;
	Fri, 19 Apr 2024 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ+nSZZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378313D2A1;
	Fri, 19 Apr 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565485; cv=none; b=ucXaqSyNP+dyyq9EfNnB7goKP4jLvc2I28c5F6oZN3ANmYOgkvWFgm8r+u9Tp3VAQ6LpdzvDZSwUULPY78pzoR0RVOfd+AvJFEatmOCMdEHTi/UebD2cQde++O37LSL29rGkIaOpLne/SSqPUfoHZWTYu+rRJvswDKUeeMW3698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565485; c=relaxed/simple;
	bh=0pD1drXQj39EFN70jQBI3yqld3d3RmDOuileOMRvtOA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=n9rjERSm4DljifxfOpjS61yxfcWaUe1T1ck6yM8TfevGihERsJ4G7AZVjE41JQqWcrpnGHJFmVZQ7cKXalgQd4cUmHNahEob8T73lnSStX0Oz+3sOwAA8/G1gFfwjUHr0P4BfgqTr57ZmrxBArWGMz/hhugw7Uf0wMv0KQdNZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ+nSZZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25F0C116B1;
	Fri, 19 Apr 2024 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713565484;
	bh=0pD1drXQj39EFN70jQBI3yqld3d3RmDOuileOMRvtOA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rJ+nSZZoJx3f6EJuiigZuYRjPe0R+Glwm9i+QGpOqc7TGdsye5yFeaoD736tqv9He
	 MCSyZ4VcJFcULkULRxpuZLMiivKub3KLxbSTZNIJrcHc1BYs/oWBqcIhQi7YhpCKrd
	 bn8BQNsVc6iHexGOxLVjtppPRXvK1+F5a506CSPqpRJ5BtS86jg5DeArHC7L7b5XyP
	 5gJTx93tQjPKjLCNLCHee/v4Y/bD9nRTpM+BpPOilpkJliu5tpDgsCZmWtywNNOyOU
	 X1QN7XerODRFMluOIZto5hzj6Woeqhpcq/LNa2an4nDdBL95/yr8Qpxe8g9z55eZWS
	 UJNmsj9flPzjA==
Message-ID: <d7ff7dd609cd1b9a50e5ffa882d05b90.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3287993.aeNJFYEL58@radijator>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr> <de4c56a8-488d-4cdb-9d6c-e9d6e63b22b9@skole.hr> <58b23157c088cb4774d579cc8700de85.sboyd@kernel.org> <3287993.aeNJFYEL58@radijator>
Subject: Re: [PATCH v9 5/9] clk: mmp: Add Marvell PXA1908 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, Guilherme G. Piccoli <gpiccoli@igalia.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Date: Fri, 19 Apr 2024 15:24:42 -0700
User-Agent: alot/0.10

Quoting Duje Mihanovi=C4=87 (2024-04-19 07:31:14)
> On Friday, April 12, 2024 4:57:09=E2=80=AFAM GMT+2 Stephen Boyd wrote:
> > Quoting Duje Mihanovi=C4=87 (2024-04-11 03:15:34)
> >=20
> > > On 4/11/2024 10:00 AM, Stephen Boyd wrote:
> > > > Is there a reason this file can't be a platform driver?
> > >=20
> > > Not that I know of, I did it like this only because the other in-tree
> > > MMP clk drivers do so. I guess the initialization should look like any
> > > of the qcom GCC drivers then?
> >=20
> > Yes.
>=20
> With the entire clock driver code in one file this is quite messy as I al=
so=20
> needed to add module_init and module_exit functions to (un)register each =

> platform driver, presumably because the module_platform_driver macro does=
n't=20
> work with multiple platform drivers in one module. If I split up the driv=
er=20
> code for each clock controller block into its own file (such as clk-of-
> pxa1908-apbc.c) as I believe is the best option, should the commits be sp=
lit=20
> up accordingly as well?

Sure. Why is 'of' in the name? Maybe that is unnecessary?

>=20
> > > While at it, do you think the other MMP clk drivers could use a=20
> conversion?
> >=20
> > I'm a little wary if the conversion cannot be tested though.
>=20
> I'd rather leave it to someone with the hardware then, especially since t=
he=20
> only reason I found out about the above is that the board I'm working on =

> failed to boot completely without the module_init function.
>=20

Ok, sounds fine.


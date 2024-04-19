Return-Path: <linux-kernel+bounces-151997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B41F8AB72B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2710E1F2226B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC4713D294;
	Fri, 19 Apr 2024 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLGFzaVQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4D13D250;
	Fri, 19 Apr 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565236; cv=none; b=VP98RSdTgqBxZzI/cmqKUIO8hVAEJXvaN0cDdBfCRrC/NLt5canxSzq/fF3SsETsjpCLYj4Oi9bKdXlxmUtwENRO1qFzP2DCLdyPApKjHQXCP5qTsApjn4glsSFYSiaY5sINADSob7Y9+ivJCCDaDtASQtbjB9LrBKWwd+UO1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565236; c=relaxed/simple;
	bh=oTRsnAA4EcTptyTfIK6CeSWLM3KSlF4hdWKZZyS/K/M=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=nGAU2MPDtDzTcVmH2GSbo7yeKyQyC9mpqzF6Dp5zG1YEtTJc5URfQDecCx4Lzt/BAf5qbagHjNtL+TWvHwUPMNV8058pTmERsGNpqVqCCpid/2PQUKnVXEJTAgH8K1V8xkaQIAkRR8IxMy80UzdJmNqso/gV+YvnZ+n8oCqge2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLGFzaVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D48C072AA;
	Fri, 19 Apr 2024 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713565235;
	bh=oTRsnAA4EcTptyTfIK6CeSWLM3KSlF4hdWKZZyS/K/M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=XLGFzaVQvpo9LawydhkulZvZhw62K/zP6NJBYc+oeZzaoxiPrHDI/Ej+qRbqiIR5z
	 IDiTvA9Lx9ImKP8kOIZmzMJLT99ezI+IZVA8BBXWJhbluOk4yTMseAwHhhYdiix8vL
	 KR4GzM7BLpys2p7kOIw38T3elM17Rd7PrKhEGkvCQ0QZdiWFrpI9TcMimaypkPn/Bd
	 5aMmnLnyckrEL4ClQhp6eJ4/zXkXzuW9ZFbX5F5Vtn+bVSclfGO1oVeHmh6bub6COC
	 Lu3FGvJyKPLs6ydaiN1e0og4OeE8HfhrUxoUkwCYOVXE/EKSn/DyItJJZ3NCwtxViu
	 YV9qFMtnDjr5Q==
Message-ID: <77272c635a928f3582ce53766b20c747.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <y7i7vwl7h2xop2ifh72vj5brtq7vd7tf72tst7k7r74plguhgn@cqs5fzplfk5i>
References: <202403270305.ydvX9xq1-lkp@intel.com> <20240327073310.520950-2-u.kleine-koenig@pengutronix.de> <d95554f623f023a2f5499fa2f6f76567.sboyd@kernel.org> <xfaf22rf6gnrxpinkciybsyk4dx2bfqgozv6udwymegtcgd26i@jq5be7fm5lhi> <y7i7vwl7h2xop2ifh72vj5brtq7vd7tf72tst7k7r74plguhgn@cqs5fzplfk5i>
Subject: Re: [PATCH] clk: Provide !COMMON_CLK dummy for devm_clk_rate_exclusive_get()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>, kernel@pengutronix.de
To: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 19 Apr 2024 15:20:33 -0700
User-Agent: alot/0.10

Quoting Uwe Kleine-K=C3=B6nig (2024-04-19 13:00:19)
> Hello Stephen,
>=20
> On Fri, Apr 12, 2024 at 10:49:35PM +0200, Uwe Kleine-K=EF=BF=BDnig wrote:
> > On Thu, Mar 28, 2024 at 03:35:57PM -0700, Stephen Boyd wrote:
> > > Quoting Uwe Kleine-K=EF=BF=BDnig (2024-03-27 00:33:10)
> > > > To be able to compile drivers using devm_clk_rate_exclusive_get() a=
lso
> > > > on platforms without the common clk framework, add a dummy
> > > > implementation that does the same as clk_rate_exclusive_get() in th=
at
> > > > case (i.e. nothing).
> > > >=20
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202403270305.ydvX9xq1=
-lkp@intel.com/
> > > > Fixes: b0cde62e4c54 ("clk: Add a devm variant of clk_rate_exclusive=
_get()")
> > > > Signed-off-by: Uwe Kleine-K=EF=BF=BDnig <u.kleine-koenig@pengutroni=
x.de>
> > > > ---
> > >=20
> > > Applied to clk-fixes
> >=20
> > I assume that means it will be sent to Linus before 6.9? That would be
> > great because I want to make use of this function in some drivers and
> > the build bots nag about my for-next branch that in some configurations
> > this function is missing.

Yes.

>=20
> Gentle ping. I'd like to get the patches I intend to send to Linus for
> v6.10-rc1 into shape. To have these unmodified in my for-next branch for
> some time it would be great to know your plans for the clk-fixes branch. =

> Alternatively: Can I expect the commit not to be changed any more and
> pull it into my pwm tree?
>=20

clk-fixes is sent to Linus during the rc cycle. I'm sending a PR today.


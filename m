Return-Path: <linux-kernel+bounces-122856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3488FE7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167AB1C2867C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543587E58F;
	Thu, 28 Mar 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/GsYOkp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82B657CE;
	Thu, 28 Mar 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627217; cv=none; b=esXW35aYfMG4ihLLHw+6Mr9+oaEZash7Bkl7fK6ne2Zw/nLDg4NpMgHgpza38kw+LskACBBNKu5XWAnWA8RzEe7MXoL88wEfU8sRUtxXqg5ynZLS9sNboseAIi6jHw+hENB8OZ/5ijmovqs+Uvl7Jir4vCBDKtBSzSPMQV2S0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627217; c=relaxed/simple;
	bh=8b7pqk930R8E8yQ2t5Oy9IoPCP561nVG0BIS05bsseY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNhqJdwE9JlsUvIJBxq9oiffBghslEY/vGOgpugHPc9BDEhNvMU0PohPFuLzLjIM7gv9qjSPVOXkaplkBCj/mXNz9jyLoXrFy0q8stn7wIrE9v7Q3wJx7cg7SQBoSdKmdWAPUn89KlFKpEcgSNiD+S1sVY/pn8CcQoWY1cJZEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/GsYOkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CED6C433F1;
	Thu, 28 Mar 2024 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711627217;
	bh=8b7pqk930R8E8yQ2t5Oy9IoPCP561nVG0BIS05bsseY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/GsYOkphZyoGQZ7xarQ0Z708uvlSorqefD3ho8akQtdHOKnfrqMIGCEsFDP+cmHw
	 NndOlszvHha0HW2O8DoMMO382nMuqkE7oLtt2jtPT/9SBv5n1FSs7eATkxYKDpV9OP
	 m9LHXsppYV99doh0ofdFeJsMHChtji0wyFZyaO29FYlUx4bT4sBlMwwH19hnvrQbo4
	 9yUUYUPya6lnLpM5FuRoxyEMw8rIjTjTWhlkZCWzMAOOmWFMcUFwR8JhV3LQpxoN1t
	 nBvXFQVqXmJHU/Aad9q9UCQ2gUzZ4Uh45Voj8VHA5CfSRI5riqfmZnqYftcRb95wJv
	 cksCMkt2KJsbQ==
Date: Thu, 28 Mar 2024 12:00:11 +0000
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Ryan Walklin <ryan@testtoast.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Regulator due for
 the v6.9 merge window:wq
Message-ID: <20240328120011.GE13211@google.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240328095631.GW13211@google.com>
 <20240328111108.5ddfa073@minigeek.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328111108.5ddfa073@minigeek.lan>

On Thu, 28 Mar 2024, Andre Przywara wrote:

> On Thu, 28 Mar 2024 09:56:31 +0000
> Lee Jones <lee@kernel.org> wrote:
> 
> Hi Lee,
> 
> many thanks for picking this up!
> 
> > Enjoy!
> > 
> > The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> > 
> >   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v6.9
> > 
> > for you to fetch changes up to d2ac3df75c3a995064cfac0171e082a30d8c4c66:
> > 
> >   regulator: axp20x: add support for the AXP717 (2024-03-28 09:51:03 +0000)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD and Regulator due for the v6.9 merge window
> 
> Did you mean v6.10 merge window? Or is there a plan to merge this into
> 6.9 still?

Yes - off-by-one!

> Also I found some issue with the LDOs' supply voltage: there are not
> all the same, as described right now. Fix is quite easy, how do you
> want to take this? As a follow up patch? And would this be squashed or
> kept separate?
> Or do you want we to send a new version? If yes, based on what branch?

Please submit a fix-up.

I'll sent out a new (ib-mfd-regulator-v6.9-1) PR based on this one.

> > ----------------------------------------------------------------
> > Andre Przywara (4):
> >       regulator: axp20x: fix typo-ed identifier
> >       dt-bindings: mfd: x-powers,axp152: Document AXP717
> >       mfd: axp20x: Add support for AXP717 PMIC
> >       regulator: axp20x: add support for the AXP717
> > 
> >  .../devicetree/bindings/mfd/x-powers,axp152.yaml   |  2 +
> >  drivers/mfd/axp20x-i2c.c                           |  2 +
> >  drivers/mfd/axp20x-rsb.c                           |  1 +
> >  drivers/mfd/axp20x.c                               | 90 ++++++++++++++++++++
> >  drivers/regulator/axp20x-regulator.c               | 94 +++++++++++++++++++--
> >  include/linux/mfd/axp20x.h                         | 98 ++++++++++++++++++++--
> >  6 files changed, 277 insertions(+), 10 deletions(-)
> > 
> 

-- 
Lee Jones [李琼斯]


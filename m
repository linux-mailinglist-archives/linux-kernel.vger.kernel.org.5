Return-Path: <linux-kernel+bounces-111104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134888867F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B031C21B69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0FC1643E;
	Fri, 22 Mar 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6UpjQ4F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE715E80;
	Fri, 22 Mar 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095042; cv=none; b=cX0r6nbWVVaaGe6w98H+y6iWBHq97qOYfTUBdkEmxyAbJ4BLBTBZ+vvNxV80znfQct9C0fJN9ez9jHBV2bdkVvu8N8Zy25eoM+e8O0shRTzI6PaZB+qjyava+prIDCR6rTdAPebF69hpw/zbBSjzjQBIEZb/TZp+yhgb7wUgU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095042; c=relaxed/simple;
	bh=YCnOfA/n2e27zR5vgkB9gg9Jx2TJzBRBGHJZDA9Wlo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVc5W2B4SJ33Wp6cIMkEI7kCBHWWIPKmd+0N3m0xXAqXuwFoo/iDdsMojHGD3znVudppZMjVoG7l9VBUI0vYsXyFMAQQa5brLEzFKqg1voJ+4P5qWDR6iFCPFsuC73PXb6Q3sYW9pJOmyBi9kpMhLNDmy4kbBdbxH1VR8CSXBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6UpjQ4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403DFC433F1;
	Fri, 22 Mar 2024 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711095041;
	bh=YCnOfA/n2e27zR5vgkB9gg9Jx2TJzBRBGHJZDA9Wlo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6UpjQ4FWlkaobX17/QSZHPkLwUGN8UPdo2UxJbEKxgonJN1wRJfjY4ytn0U57niD
	 9wNTd30twOeABmsKXVooxX4wzk2tYdBylEKcz/VCjvd5UDSmuJfTXeJomj9k+Tl5XE
	 uHF5KiqlDLCpRwmkPUL3iGTNiw4K7RVoMsfLfJ59VWpPl0YnRsRApT/+k82qHtSasq
	 MpQNAF+CtaP81Gl7LM9Kwg5wzk6xDamkmhCg/kyJo0bLNu2aB+c92Aj4c6hoUYAwKi
	 cZCYyocVdBm9kzOfhcEYTmbsqiML6XlWgsrNWT4OCn2pmNCZ7Nl4hpziyHIBwZ+ePU
	 BXOGnB/R5scQg==
Date: Fri, 22 Mar 2024 08:10:36 +0000
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/4] regulator: Add X-Powers AXP717 PMIC support
Message-ID: <20240322081036.GL13211@google.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240321171048.GD13211@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321171048.GD13211@google.com>

On Thu, 21 Mar 2024, Lee Jones wrote:

> On Sun, 10 Mar 2024, Andre Przywara wrote:
> 
> > This patch series adds support for the X-Powers AXP717 PMIC, which is 
> > used recently on new boards with Allwinner SoCs.
> > Allwinner's BSP code often speaks of the AXP2202, this seems to be the
> > same chip, at least a boot0 AXP2202 driver happily drove a chip labelled
> > AXP717.
> > 
> > Patch 1 fixes a typo in some macro names for the AXP313a PMIC, I just
> > realised that during some copy&paste action. It's just an identifier
> > rename, so not a backport candidate, I'd say.
> > Patch 2 adds the compatible string to the binding document.
> > Patch 3 is the MFD part, describing the regmap and all the interrupts.
> > So far we support the regulator and power key devices, the USB and
> > charging devices will follow later.
> > Patch 4 adds the voltage regulator rails, this part is crucial to enable
> > any board using this PMIC, as we depend on those rails even for basic
> > devices.
> > 
> > Please note that I could not test this driver myself, but had success
> > messages from others. It would be good to hear from Ryan and Chris
> > here on the list, with a Tested-by: tag.
> > 
> > This series is based on next-20240308 for now. I will send a rebased
> > update after the merge window, but wanted to start discussion and review
> > now.
> > 
> > Please have a look!
> > 
> > Cheers,
> > Andre
> > 
> > Andre Przywara (4):
> >   regulator: axp20x: fix typo-ed identifier
> >   dt-bindings: mfd: x-powers,axp152: document AXP717
> >   mfd: axp20x: add support for AXP717 PMIC
> >   regulator: axp20x: add support for the AXP717
> > 
> >  .../bindings/mfd/x-powers,axp152.yaml         |  2 +
> >  drivers/mfd/axp20x-i2c.c                      |  2 +
> >  drivers/mfd/axp20x-rsb.c                      |  1 +
> >  drivers/mfd/axp20x.c                          | 90 +++++++++++++++++
> >  drivers/regulator/axp20x-regulator.c          | 94 +++++++++++++++++-
> >  include/linux/mfd/axp20x.h                    | 98 ++++++++++++++++++-
> >  6 files changed, 277 insertions(+), 10 deletions(-)
> 
> All applied and sent for build testing.  If everything works out, I'll
> send out a pull-request to an immutable branch shortly.

Okay, these are building okay based on v6.8.

I'll send out a PR once I can rebase tem onto v6.9-rc1.

Note to self: ib-mfd-regulator-6.9

-- 
Lee Jones [李琼斯]


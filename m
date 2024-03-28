Return-Path: <linux-kernel+bounces-122817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D088FDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168A0297A73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556347E0F3;
	Thu, 28 Mar 2024 11:11:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EDB7D40A;
	Thu, 28 Mar 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624285; cv=none; b=ZHtPKcIf6smAUdw8dIouw/BodyGOxIzHQm0DGYI4zDsndFYwqkzSdRQILNm82GfjY6cSU2rUGeEzhRsohpEF88z7xOZ/EhHcdizxdlTDCDc4iXUrnWcPm1nH0vYNspN0myeFk/hE5xENw0/tKfUe2liQiV0uAHATzdvjXJHFblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624285; c=relaxed/simple;
	bh=P4ft4oBc3+32IVQ5rUTrQBmxc3xK+sDrzil/RtTJlUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrH4Kkmc58tU9NEFzeFr8EtDHnXocbvIqkqG1YgISMhFxtmObTbTlKxbr4TyFWW9G7QXh62WFixk2o3EamFmffXrAImeHtwkXsXG8TLUQ9h9dHWFVaJRd6rZFIoH9FLPASz4Wc0GWWulw28VKDLx4eAOjDaY0rxr1RoC0OlxgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 713671476;
	Thu, 28 Mar 2024 04:11:54 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7B073F7BD;
	Thu, 28 Mar 2024 04:11:18 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:11:08 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, Samuel Holland
 <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Ryan Walklin <ryan@testtoast.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Regulator due for
 the v6.9 merge window:wq
Message-ID: <20240328111108.5ddfa073@minigeek.lan>
In-Reply-To: <20240328095631.GW13211@google.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
	<20240328095631.GW13211@google.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 09:56:31 +0000
Lee Jones <lee@kernel.org> wrote:

Hi Lee,

many thanks for picking this up!

> Enjoy!
> 
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v6.9
> 
> for you to fetch changes up to d2ac3df75c3a995064cfac0171e082a30d8c4c66:
> 
>   regulator: axp20x: add support for the AXP717 (2024-03-28 09:51:03 +0000)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Regulator due for the v6.9 merge window

Did you mean v6.10 merge window? Or is there a plan to merge this into
6.9 still?

Also I found some issue with the LDOs' supply voltage: there are not
all the same, as described right now. Fix is quite easy, how do you
want to take this? As a follow up patch? And would this be squashed or
kept separate?
Or do you want we to send a new version? If yes, based on what branch?

Thanks,
Andre

> 
> ----------------------------------------------------------------
> Andre Przywara (4):
>       regulator: axp20x: fix typo-ed identifier
>       dt-bindings: mfd: x-powers,axp152: Document AXP717
>       mfd: axp20x: Add support for AXP717 PMIC
>       regulator: axp20x: add support for the AXP717
> 
>  .../devicetree/bindings/mfd/x-powers,axp152.yaml   |  2 +
>  drivers/mfd/axp20x-i2c.c                           |  2 +
>  drivers/mfd/axp20x-rsb.c                           |  1 +
>  drivers/mfd/axp20x.c                               | 90 ++++++++++++++++++++
>  drivers/regulator/axp20x-regulator.c               | 94 +++++++++++++++++++--
>  include/linux/mfd/axp20x.h                         | 98 ++++++++++++++++++++--
>  6 files changed, 277 insertions(+), 10 deletions(-)
> 



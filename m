Return-Path: <linux-kernel+bounces-93852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF128735AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F0B22841
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E57FBDB;
	Wed,  6 Mar 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qd7s+P0c";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qd7s+P0c"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7E7FBB4;
	Wed,  6 Mar 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725196; cv=none; b=Vz4FtXkXDXMP5/6newE3+CsbsBkKrqWE8C12l1IXA5jd/PNCrOy5RoifTAWqLictAZSMscGKREW10TQPsPsECplyV7OcP3CUEeS/d4ntbds9Yq785+LMOBUdgHQGYIM8yjAQfjxmPDqIrJusWpYuQ7GSPMzSe+BztL6x9CUpwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725196; c=relaxed/simple;
	bh=xwoFzPsHeZCk2y4J/x89E9mHH56JSmXj2yHhGVcCVyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHrW6pntP8UjKKHZkuVLJBoqDmoqnI5mwVJJtzqAc9NswObrrzkag4jDdtK26l36pO/Kb2BB6E0HLaft3cmovMk85ftszgrZrrlKan1Yd3SvQHv+CsCzcFBnXwNxPjUAP4rD2dpevzvO99GgbSdUOJw8xSsRXYnc4V1sXvMlAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qd7s+P0c; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qd7s+P0c; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id DE277C01B; Wed,  6 Mar 2024 12:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709725191; bh=M24mEXhEijJg73gWUpW6KA+Popv3l8CYmbbCO5rEZZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qd7s+P0cWX1xdYZUCxiiKX9bBF4pIaMd6U7LCsMAwda6rils2ZVEu/fezpefjRM88
	 NfambXuo3ZHK1u2KpXY+p6P2w3bW0HyKRGlp5KlNktlDo5qgAZvLBRpAU7ev2mlW3I
	 aCZrJdnqvuGPnCK37namJfsymVf4N477ftHBkSryt/U+xph8+DqZerSADOoRyRurAy
	 2G2UtdPrxIDVQ85CeHwn+zX8Ok/S2UYw3tvJrg97pRlb5mX+72sr9KfUnxXZpKfrCG
	 VYVOvh+QmuIab+vNOir6jL9c3uu2EedFxHBX6dW0HnfDbBQuBeWIhsOb9ZjVSpYUvA
	 lpXJCDXJ7toDw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 4E49FC009;
	Wed,  6 Mar 2024 12:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709725191; bh=M24mEXhEijJg73gWUpW6KA+Popv3l8CYmbbCO5rEZZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qd7s+P0cWX1xdYZUCxiiKX9bBF4pIaMd6U7LCsMAwda6rils2ZVEu/fezpefjRM88
	 NfambXuo3ZHK1u2KpXY+p6P2w3bW0HyKRGlp5KlNktlDo5qgAZvLBRpAU7ev2mlW3I
	 aCZrJdnqvuGPnCK37namJfsymVf4N477ftHBkSryt/U+xph8+DqZerSADOoRyRurAy
	 2G2UtdPrxIDVQ85CeHwn+zX8Ok/S2UYw3tvJrg97pRlb5mX+72sr9KfUnxXZpKfrCG
	 VYVOvh+QmuIab+vNOir6jL9c3uu2EedFxHBX6dW0HnfDbBQuBeWIhsOb9ZjVSpYUvA
	 lpXJCDXJ7toDw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 01e7a05f;
	Wed, 6 Mar 2024 11:39:44 +0000 (UTC)
Date: Wed, 6 Mar 2024 20:39:29 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
Message-ID: <ZehV8RrGdM9a1hO4@codewreck.org>
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zegx5PCtg6hs8zyp@trax>

Jorge Ramirez-Ortiz, Foundries wrote on Wed, Mar 06, 2024 at 10:05:40AM +0100:
> > the part_type values of interest here are defined as follow:
> > main  0
> > boot0 1
> > boot1 2
> > rpmb  3
> > gp0   4
> > gp1   5
> > gp2   6
> > gp3   7
> 
> right, the patch I originally sent didn't consider anything after GP0 as per
> the definitions below.
> 
> #define EXT_CSD_PART_CONFIG_ACC_MASK	(0x7)
> #define EXT_CSD_PART_CONFIG_ACC_BOOT0	(0x1)
> #define EXT_CSD_PART_CONFIG_ACC_RPMB	(0x3)
> #define EXT_CSD_PART_CONFIG_ACC_GP0	(0x4)

Yes, as far as I can see these are used in drivers/mmc/core/mmc.c
for example for GP0, below snippet:
                        mmc_part_add(card, part_size << 19,
                                EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
                                "gp%d", idx, false,
                                MMC_BLK_DATA_AREA_GP);

where idx is in [0;3], so we've got 4-7 for GP partitions in the part's
part_cfg.

(similarly, boot has BOOT0 + [0-1], and RPMB has RPMB without anything
added -- so as far as this field is concerned there seems to be a single
RPMB)

> That looked strange as there should be support for 4 GP but this code
> kind of convinced me of the opposite.
> 
> 	if (idata->rpmb) {
> 		/* Support multiple RPMB partitions */
> 		target_part = idata->rpmb->part_index;
> 		target_part |= EXT_CSD_PART_CONFIG_ACC_RPMB;
> 	}
>
> So if we apply the fix that you propose, how are multiple RPMB
> partitions (ie, 4) going to be identified as RPMB? Unless there can't be
> more than 3?

Hmm, that code is definitely odd.
Reading this I'd normally assume that idata->rpmb->part_index ought to
be in a range separate fom EXT_CSD_PART_CONFIG_ACC_MASK -- so we've got
the ACC_RPMB "flag" that identifies it as RPMB within the mask, and then
it can target a given index within that.

But as far as I'm seeing in the code, rpmb->part_index always comes from
mmc_blk_alloc_rpmb_part (set to part's part_cfg), which in turn is only
called if area_type is MMC_BLK_DATA_AREA_RPMB, which is only set for
mmc_part_add() for rpmb with ACC_RPMB as part_index.. So we've got
target_part = 3 and then target_part |= 3 which will leave the value
unchanged.

Even assuming part_index was something else than 3 (let's say 1 or 2),
we'd end up with target_part = 4 or 5 which won't match the
PART_CONFIG_ACC_MASK check (&3 != 3), so it doesn't make sense until
something is shifted somewhere outside of the mask, and I see no trace
of part_index being shifted.

So the if (idata->rpmb) itself makes sense as per the comment, but we
could just have target_part take either values here as far as I
understand.



I've never actually used the rpmb partition of my MMCs so I'm not sure
how multiple RPMB partitions is supposed to work in the first place,
sorry.
That code is authored by Linus W (in 2017), perhaps he'll remember
something?

-- 
Dominique


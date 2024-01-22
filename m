Return-Path: <linux-kernel+bounces-32716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C51835F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C491F26535
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB5A3A8C8;
	Mon, 22 Jan 2024 10:16:26 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAEF3A1A9;
	Mon, 22 Jan 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918585; cv=none; b=PiMpntOGwKDq59D07PSjxHg4otTtomOr374RRSJ+Bqmbbg9VQC5I4smS/UyjtWHNUdYniITluA0/wadIibydmwrCYO/YRjTd0JrpvEV+at+qSCb1sluPpG4JgceF+tI+pupkJTgFe5lXC3f9Tf8a9xALx7a9cJ5Lyf6C5uVqRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918585; c=relaxed/simple;
	bh=Z9YZSMcv09QPVSHCStJEBNSuKdEaMXl1kZD3GfXL9TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccxy6FBK/0kfeu7Qq3Ot0N5pG7r0rdiagVxYTGZtweRJibBPlH9M28xPET6jyDrUboFalpvTeeCZ49ji59EM874AdtoUeAKs0arSEltEI0dAfNHy9ldX9g2yRornea3mhQK4PVxcHNPB/PcArXnHhsxZ2TuLHyH67PI9LfnU3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rRrLi-0000Sa-00; Mon, 22 Jan 2024 11:16:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 66D34C04A1; Mon, 22 Jan 2024 11:13:59 +0100 (CET)
Date: Mon, 22 Jan 2024 11:13:59 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Alchemy: Fix missing prototypes
Message-ID: <Za4/5/uZ18poliXu@alpha.franken.de>
References: <20240117234948.923273-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117234948.923273-1-f.fainelli@gmail.com>

On Wed, Jan 17, 2024 at 03:49:44PM -0800, Florian Fainelli wrote:
> We have a number of missing prototypes warnings for board_setup(),
> alchemy_set_lpj() and prom_init_cmdline(), prom_getenv() and
> prom_get_ethernet_addr(). Fix those by providing definitions for the
> first two functions in au1000.h which is included everywhere relevant,
> and including prom.h for the last three.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/alchemy/common/prom.c            | 1 +
>  arch/mips/alchemy/common/setup.c           | 4 +---
>  arch/mips/include/asm/mach-au1x00/au1000.h | 3 +++
>  3 files changed, 5 insertions(+), 3 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]


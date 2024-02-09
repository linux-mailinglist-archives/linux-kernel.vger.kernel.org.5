Return-Path: <linux-kernel+bounces-59371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E1084F600
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A711F240B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD13C099;
	Fri,  9 Feb 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqhVnpYg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048C38DC3;
	Fri,  9 Feb 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485323; cv=none; b=U8JmrWmvZGhlnFwOLq4BjnpFHOCARYajBz0eOOSZhQfRi4SDhwudlk2akLItqTr6t9ZbS1tuBNxuUdFqTa6UTBVVekLSvFKzGRzmiKwYDdTZiqqwaQFSEM13F9KUgfMWOxG486ftvz6FQ/diCchYGCzXjjz+U0yjA+rwigbNH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485323; c=relaxed/simple;
	bh=lNwTY81xFGQbjGbLm8+cb2M71UePFXEZSG+wq4uR8/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjJ8yRS6Lgy6pChBPK5dyFMTnxatzZRUPMeTuV/hO26oBmCH8t1wSP+Zc+XDgtZN9t2WcdNQ9lGD50c8FxOGoabrpeutpCyT4d2d6f1bzWgmhH0D9Bc1LqcoNuQo0t5VOCgTEusj5CSIFhYeLk9PfeV0z9NsBzRmqDa1r4bD8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqhVnpYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C573C433C7;
	Fri,  9 Feb 2024 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485322;
	bh=lNwTY81xFGQbjGbLm8+cb2M71UePFXEZSG+wq4uR8/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqhVnpYgBK7Pzno8i3+QFBdi4DvhtmjwhZHCbUT7XLZBPkEJzVlY7NWZqa/ojIXn9
	 BXyH6d0TcfN8YiiqCmJsBkLGfGul+YOUJlkH/tbJpgK/ex8QiFah4ZxVqH2ZnhSrWj
	 OGojN55a+WWcakscLCPcVsEdfDRMCF9pCtj6upqZsLhQcL8gQFODqS5GlSsq66lwDC
	 jXIMtSydrg0DMk85WAS7hguZdP7THZaTEOErrKI2d63mVyF/l4O+mgJsCDxyXi+R9e
	 31RzfGeWMoHM1vWuQ+8dmreuAGFIO+fxcHEv8UKEvpWOP+rBLUtW8euDmV6WMz6+8s
	 CLDcn7O++RlyA==
Date: Fri, 9 Feb 2024 13:28:37 +0000
From: Lee Jones <lee@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
Message-ID: <20240209132837.GJ689448@google.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <CAPDyKFpmfgwJ5dJFmORhg1tBewzhB_jrWikpX=b23r-joN91SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpmfgwJ5dJFmORhg1tBewzhB_jrWikpX=b23r-joN91SA@mail.gmail.com>

On Fri, 09 Feb 2024, Ulf Hansson wrote:

> On Fri, 9 Feb 2024 at 02:59, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> >
> > The MFD parts of the TMIO have been removed by Arnd, so that only the
> > SD/MMC related functionality is left. Remove the outdated remains in the
> > public header file and then move it to platform_data as the data is now
> > specific for the SD/MMC part.
> >
> > Based on 6.8-rc3, build bot is happy. Branch is here:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tmio-simplification
> >
> > I'd suggest this goes via the MFD tree, so the series would need acks
> > from the MMC and SH maintainers. Is that okay with everyone?
> 
> Wouldn't it be better to funnel this via the mmc tree? In that way, we
> can easily avoid conflicts with additional renesas-mmc driver changes
> that we have in pipe.

You could say the same about changes SH, MFD and Platform Data have in
the pipe.

> Or perhaps there are other changes that make the mfd tree preferred?

MFD is usually preferred since the parent device usually lives there and
we are well accustomed to merging multi-subsystem related sets.

It doesn't really matter how this is merged.  The only stipulation is
that whoever applies the set does so on a succinct, immutable, tagged
branch and sends out a pull-request for everyone else to pull from.

If you want to do that, there are no complains from me.

> > All the best!
> >
> >    Wolfram
> >
> >
> > Wolfram Sang (6):
> >   mfd: tmio: remove obsolete platform_data
> >   mfd: tmio: remove obsolete io accessors
> >   mmc: tmio/sdhi: fix includes
> >   mfd: tmio: update include files
> >   mfd: tmio: sanitize comments
> >   mfd: tmio: move header to platform_data
> >
> >  MAINTAINERS                                   |   2 +-
> >  arch/sh/boards/board-sh7757lcr.c              |   2 +-
> >  arch/sh/boards/mach-ap325rxa/setup.c          |   2 +-
> >  arch/sh/boards/mach-ecovec24/setup.c          |   2 +-
> >  arch/sh/boards/mach-kfr2r09/setup.c           |   2 +-
> >  arch/sh/boards/mach-migor/setup.c             |   2 +-
> >  arch/sh/boards/mach-se/7724/setup.c           |   2 +-
> >  drivers/mmc/host/renesas_sdhi_core.c          |   2 +-
> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c |   5 +-
> >  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   5 +-
> >  drivers/mmc/host/tmio_mmc_core.c              |   3 +-
> >  drivers/mmc/host/uniphier-sd.c                |   2 +-
> >  include/linux/mfd/tmio.h                      | 133 ------------------
> >  include/linux/platform_data/tmio.h            |  64 +++++++++
> >  14 files changed, 81 insertions(+), 147 deletions(-)
> >  delete mode 100644 include/linux/mfd/tmio.h
> >  create mode 100644 include/linux/platform_data/tmio.h
> >
> > --
> > 2.43.0
> >
> >

-- 
Lee Jones [李琼斯]


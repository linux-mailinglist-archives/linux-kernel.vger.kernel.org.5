Return-Path: <linux-kernel+bounces-59097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75584F129
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761A11F22154
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61865BB8;
	Fri,  9 Feb 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH1y9szQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602B657C1;
	Fri,  9 Feb 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465524; cv=none; b=H0N3gyZY08aYgcCD3YjKYaucvmdWVuWp+/giLxi1n3LqMwJSXEppKs2Py1LKTHX2In5MBTFGWpKeTjcWvT0ijB3WVJE/uv5J/1t9iN5l5HznvVj1ebRHr2l73uRLtOp6jncqatuKhwhDPgUHW6MlJ/H7szFUKlJxckz0oF8HGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465524; c=relaxed/simple;
	bh=zC4vJqhKzh8zYZVO1NjC42ET5CixSGPHkBx39aoAX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8pN2MyGxRileAx6wSWMyOzX/YhF+F1FRppdbc3EnYIfG4ERa3hJC1UK2mJ5rNCS5e2Wci2XSv2X3zZ7MOl0B3o5txpkQ9n98xuIY3j6NsFSVJt1S3/bfdBVzGUBZPpelQw+qGCtKe43vMLWguFzqeX4McTu2wMLoXfCrckosPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH1y9szQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198DAC433C7;
	Fri,  9 Feb 2024 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465523;
	bh=zC4vJqhKzh8zYZVO1NjC42ET5CixSGPHkBx39aoAX78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WH1y9szQrWIhjBy3mfW60nJijr+lOa/zjSKO0SS1PJqO4Wq9wuYB6dZO/j0Q1rgMj
	 0Mb0PIFyHyXAnCXuCtPIH7rHV2oiYwUOFOtduefJ1jM2avrdfIRwWr8uKGIvB2I16C
	 nB+DbZshFsoeq98av7ylWk8CfZI6s7L7DiwpTPrbd0EWQgUwJdbx5+hiCPGyLtsscx
	 OfYi0YYHTsTugo2OrhCz2RAD4AoiSYWRffEAuwVsOVxEiRpkODyR1R2H28wd14k0RT
	 0CQ/+rQdOdb1avEbgQFEiiNcx7w1a7RB/dI/mH0tXfovu3fK6SOPL3d5My1ICIhRQg
	 hIoBv5r4gdIsQ==
Date: Fri, 9 Feb 2024 07:58:39 +0000
From: Lee Jones <lee@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
Message-ID: <20240209075839.GH689448@google.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>

On Fri, 09 Feb 2024, Wolfram Sang wrote:

> The MFD parts of the TMIO have been removed by Arnd, so that only the
> SD/MMC related functionality is left. Remove the outdated remains in the
> public header file and then move it to platform_data as the data is now
> specific for the SD/MMC part.
> 
> Based on 6.8-rc3, build bot is happy. Branch is here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tmio-simplification
> 
> I'd suggest this goes via the MFD tree, so the series would need acks
> from the MMC and SH maintainers. Is that okay with everyone?
> 
> All the best!
> 
>    Wolfram

Could you please change all of the subject lines with "mfd" in them
i.e. all of the commits which touch include/linux/mfd and ensure the
description starts with an upper case char?

I like all commits that touch drivers/mfd and include/linux/mfd to have
the same formatting structure.

Thanks.

> Wolfram Sang (6):
>   mfd: tmio: remove obsolete platform_data
>   mfd: tmio: remove obsolete io accessors
>   mmc: tmio/sdhi: fix includes
>   mfd: tmio: update include files
>   mfd: tmio: sanitize comments
>   mfd: tmio: move header to platform_data
> 
>  MAINTAINERS                                   |   2 +-
>  arch/sh/boards/board-sh7757lcr.c              |   2 +-
>  arch/sh/boards/mach-ap325rxa/setup.c          |   2 +-
>  arch/sh/boards/mach-ecovec24/setup.c          |   2 +-
>  arch/sh/boards/mach-kfr2r09/setup.c           |   2 +-
>  arch/sh/boards/mach-migor/setup.c             |   2 +-
>  arch/sh/boards/mach-se/7724/setup.c           |   2 +-
>  drivers/mmc/host/renesas_sdhi_core.c          |   2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |   5 +-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   5 +-
>  drivers/mmc/host/tmio_mmc_core.c              |   3 +-
>  drivers/mmc/host/uniphier-sd.c                |   2 +-
>  include/linux/mfd/tmio.h                      | 133 ------------------
>  include/linux/platform_data/tmio.h            |  64 +++++++++
>  14 files changed, 81 insertions(+), 147 deletions(-)
>  delete mode 100644 include/linux/mfd/tmio.h
>  create mode 100644 include/linux/platform_data/tmio.h
> 
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]


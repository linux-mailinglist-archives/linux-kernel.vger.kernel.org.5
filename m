Return-Path: <linux-kernel+bounces-57973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0484DFD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790601F28338
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CED6F093;
	Thu,  8 Feb 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otMJJuv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9806EB70;
	Thu,  8 Feb 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392070; cv=none; b=T3yTm/ngIIqdnYCgxaHESbXWm9IiCuKfjBAEVpwBH4JSpE2vX2KPVrZCwfXAH7T9b+ni9o6PmzF55rls6yNBaBRED8mlLWy/q075K4wR27tBb1Y+s+Ouxmb2K3293/U8bHNFYL5dHJ3XkYyRz8WNKoF5qIMMjgmgts7Qs8y1+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392070; c=relaxed/simple;
	bh=yyQjmff7mDe+PFwHUjspM3GhT+PcMskz98VGgV0pDXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rawt/v8GtrDvArAAkfszDo2ZGMWZ0e5/0yNJbP8B9zUo3iDb8VwE/wMeWPMWJm3u2UvCoGAEP4BnJsy+12aYKcNX9K3I4bQewTMAcwX4xzVStjYTRRsfDHe/YC/eElyxhsVQPaElVZ9piR5a5h3Uz49w/segacQfUVGLUtJ+DtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otMJJuv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209BEC433F1;
	Thu,  8 Feb 2024 11:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707392069;
	bh=yyQjmff7mDe+PFwHUjspM3GhT+PcMskz98VGgV0pDXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otMJJuv7xmoVBxGBtHlNHS60vRtgbaz98hCw3I7+YzfJQaSpyfJeT1zQgiIFs47jZ
	 EYWZn6Um2d+JCdWamZy7zfyEzMm6WIBZzTi7vCgQgEDHToI59x+8MxL95urvBQ6ta4
	 0Os/gPU9xbgj1J6ryDeUwEjUfP0if1AQ8vwO9pEdDvYh7AUFUmoSO6WHhCH+9luC2h
	 ZZirBBZm90ey9nXVvQaOjQAGVLrFRRRNdyfk++m4VU2xXTuJ2R84XNsMbUdqskxHi7
	 3EVMEOYWaiTLgP9eOINvOWb2QcUiCbFsrYSAcwFr4HS8/CSKPJK09ugsIAKVpgx2eQ
	 sh+iz4fazo2/w==
Date: Thu, 8 Feb 2024 11:34:25 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-ID: <20240208113425.GK689448@google.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>

On Thu, 01 Feb 2024, Andy Shevchenko wrote:

> Allow to use driver on non-OF platforms and other cleanups.
> 
> Changelog v2:
> - rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)
> - add tags (Daniel, Flavio)
> - new patch 2
> 
> Andy Shevchenko (3):
>   backlight: mp3309c: Make use of device properties
>   backlight: mp3309c: use dev_err_probe() instead of dev_err()
>   backlight: mp3309c: Utilise temporary variable for struct device
> 
>  drivers/video/backlight/mp3309c.c | 88 ++++++++++++-------------------
>  1 file changed, 35 insertions(+), 53 deletions(-)

Set no longer applies.  Please rebase, thanks.

-- 
Lee Jones [李琼斯]


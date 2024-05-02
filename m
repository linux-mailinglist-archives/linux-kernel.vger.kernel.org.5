Return-Path: <linux-kernel+bounces-166233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F28B97DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB451F21B28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F8B55C08;
	Thu,  2 May 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHHbkWFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33872548E7;
	Thu,  2 May 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642589; cv=none; b=n1trFi6N/JTC+K0awBYQJv3i8CUfNo8mmGc9biwxdggG9oXRkM1eibaaFInnE1bcvzODuyT/jvksZj+7C28Qjv0PyxNGxFUbmrYwRTPgm5R+hJ6reaKSdbWSyRTpjOEhvJPJJvBB0X3wfB675Pnmbk50BkHsnJPu2h7YQo+Lv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642589; c=relaxed/simple;
	bh=92VZfd5MbP7gUyNvWNYUCKmDjm4qFnwsQ27VX0zyuGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdUSqgIMiZl/i7qHVgrxfXUAWHolTpKyw5vTltcQ1CIGKd/VQgJvJab13y+BtOSeDCZ2rekxMpf3rrDbNuC+wT6sCO6wkzp4ZwWBT53BjTVn5B5GtSBce2QRqFGm9gi1PFgE5OLWjN9VMO7JmjLJPJPWpKo1Y0bJ24+6C/BKaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHHbkWFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA35C113CC;
	Thu,  2 May 2024 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642588;
	bh=92VZfd5MbP7gUyNvWNYUCKmDjm4qFnwsQ27VX0zyuGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHHbkWFYGXuKehF59l+08AI4Ps88TEcMSkY5b2JwplXbRYC7gIY1D6ZWr84d6t56B
	 jCTzvLnx9p4fwUhRoag62QB/CW/5VMWljKphY2RdvDD1kjb964RR4n19/N7wtc5aVN
	 8Nvk4qyP2ikeIGPVGMt+Ff2ZbZxjMiAqhJZrzfiwpvezO34waWIJNdhnTSmvETahLG
	 CuBI1373h1TJeDQEU2li3Hke0JdDH5Po3vivXdjUdKoNPPsFw/rsmFnC3sNhJH0F2X
	 +lX5WN2yhfCUMtdmaQsiG77RyEh45cOPuCyHWmp4Dyr4DXNLqsz8uEGQJgIwxk+hwc
	 61Mx0v1nKNPrw==
Date: Thu, 2 May 2024 10:36:23 +0100
From: Lee Jones <lee@kernel.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org, julia.lawall@inria.fr
Subject: Re: [PATCH v3][next] backlight: sky81452-backlight: Remove
 unnecessary call to of_node_get
Message-ID: <20240502093623.GJ5338@google.com>
References: <20240502063621.65687-2-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502063621.65687-2-shresthprasad7@gmail.com>

On Thu, 02 May 2024, Shresth Prasad wrote:

> `dev->of_node` already has a reference to the device_node and calling
> of_node_get on it is unnecessary. All conresponding calls to
> of_node_put are also removed.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Changes in v3:
>     - Remove unnecessary braces
> 
>  drivers/video/backlight/sky81452-backlight.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

No idea what you're talking about.

This patch/version doesn't exist in either my inbox or LORE:

  https://lore.kernel.org/all/?q=%22%5BPATCH+v3%5D%5Bnext%5D+backlight%3A+sky81452-backlight%3A+Remove+unnecessary+call+to+of_node_get%22

-- 
Lee Jones [李琼斯]


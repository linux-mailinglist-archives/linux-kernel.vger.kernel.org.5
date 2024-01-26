Return-Path: <linux-kernel+bounces-39988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211183D828
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DAC1C2C0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B11CD26;
	Fri, 26 Jan 2024 10:16:04 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3B1CD16;
	Fri, 26 Jan 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264164; cv=none; b=PiHay5YutfrrnAmEjtHNYSyUab5hHWmvIGNLouRo/FCV5p2quXyc2Eh2RSB/b6+Uei2CNi0JvsB42Tf704jfW6jnxcU0wHRFcmFiERuEVp+7QfjKdwzAUoJ9Kbey1WyoQwIOFZzNBb1wwyPm8iAsx4K3s1q+8HxypM41hvwVkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264164; c=relaxed/simple;
	bh=ngM/3k/+1ku0C5kXqBcpID4zlTiXaRD3W3n801qRemY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfyUt0txTVU3lnQyqCAA+9uhMgRIqoWN2SXTw8hzrJFJ2OIXrJlH3ok2l01nQMNyNlKJ8ZOxiUDyjhcR+4NfHO/FtEMod94g9K5lZoDJKGW0Jt/htYo69ja5R9ba8a3bCWiIndQ2fy/kvdiCbDdp2oXd8dLoNmMDP2uVEtQ2XwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rTJFY-0003wm-00; Fri, 26 Jan 2024 11:15:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 85708C04B4; Fri, 26 Jan 2024 11:13:23 +0100 (CET)
Date: Fri, 26 Jan 2024 11:13:23 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, jonas.gorski@gmail.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: BCM63XX: Fix missing prototypes
Message-ID: <ZbOFw7m7CX8SHy4F@alpha.franken.de>
References: <20240123174701.210922-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123174701.210922-1-f.fainelli@gmail.com>

On Tue, Jan 23, 2024 at 09:46:54AM -0800, Florian Fainelli wrote:
> Most of the symbols for which we do not have a prototype can actually be
> made static and for the few that cannot, there is already a declaration
> in a header for it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/bcm63xx/boards/board_bcm963xx.c | 2 +-
>  arch/mips/bcm63xx/dev-rng.c               | 2 +-
>  arch/mips/bcm63xx/dev-uart.c              | 1 +
>  arch/mips/bcm63xx/dev-wdt.c               | 2 +-
>  arch/mips/bcm63xx/irq.c                   | 2 +-
>  arch/mips/bcm63xx/setup.c                 | 2 +-
>  arch/mips/bcm63xx/timer.c                 | 2 +-
>  7 files changed, 7 insertions(+), 6 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]


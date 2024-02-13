Return-Path: <linux-kernel+bounces-63702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48AC853373
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B611C26882
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BAE5DF19;
	Tue, 13 Feb 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPS/Lasm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598958124;
	Tue, 13 Feb 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835468; cv=none; b=OoBMVKGt1OSRfkHwHsX584PW4gAf4SU6vCJXzOS48E2H/w+I6WtWGjAYmta9PVUABcuB6IEeMl7enKqP7UzHLEaGP8MKDld+dbt+d2HXN9h+S21Hz2Xevo9R1h2imjwDx8+cxSdnQt4MtFNS1EriqL5e+Ou1wCXD63yCXo2NRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835468; c=relaxed/simple;
	bh=V4zHtxpagFTSsO4FJDZDl2e3AjDYrOT8ZsV+wFFx6DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVfSJ+f8Cr0h8otU7KVB9VyXQKyhUN6JoIBXBJ+XLZpC2Jtj/hGD+cav9IZJr/H+dCs9UsB3KKR4Ju1jGIpFa/zUkr9XabJCJZO9iY1+Mpos7N+2jEkPL5TTegl5/w++jfq56EDAaxOAWHH3gkVpaDK4wrVWsQw0Bm6F3VKCvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPS/Lasm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20C4C433F1;
	Tue, 13 Feb 2024 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707835468;
	bh=V4zHtxpagFTSsO4FJDZDl2e3AjDYrOT8ZsV+wFFx6DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPS/LasmSMMOACrMEim5NP3opwIVzDNE8aeKqdOMpPZetUne8qUjq3Hl+ELQ5wFJh
	 5OHtjUE9KOEuyX7bl8kBTeV6KNCFmOPdvDwkdI/19Ry7CjZpOALRBk9cuWtm09UPOV
	 yCvW1VbbY8zRvm6uo8goJpNzncltvl73q3WakaXHHJgjB9S78u3KWTkZbWnVUyVIaB
	 0R5PvMkb3h5ZiOu9+1GaBtRBmfde2fJodDTZdn7w/drSYtgrjiYv8/SoxtHJHKlaKs
	 708mlo0aOKpWg5neoTVoanYzKMoqxQRJn6/PwexFT4pGxRraEUHCnted5iOrAN2tmS
	 tFiSygxqLzWfw==
Date: Tue, 13 Feb 2024 08:44:25 -0600
From: Rob Herring <robh@kernel.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: lkp@intel.com, frowand.list@gmail.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, stephen.boyd@linaro.org,
	robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Make explicit cpu_to_be32 conversion to mute sparse
 warning
Message-ID: <170783546379.1178222.11395927035166507245.robh@kernel.org>
References: <202402042134.GEb3Bgwl-lkp@intel.com>
 <20240205024033.3572617-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205024033.3572617-1-dawei.li@shingroup.cn>


On Mon, 05 Feb 2024 10:40:33 +0800, Dawei Li wrote:
> Kernel test robot reports sparse warning:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/of/base.c:1337:73: sparse: sparse: incorrect type in initializer
>    (different base types) @@  expected restricted __be32 @@  got int @@
>    drivers/of/base.c:1337:73: sparse:     expected restricted __be32
>    drivers/of/base.c:1337:73: sparse:     got int
> 
> Thus, Make explicit conversions to mute warning(Although BE and LE are
> exactly same in binary representation for 0/~0).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402042134.GEb3Bgwl-lkp@intel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/of/base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!



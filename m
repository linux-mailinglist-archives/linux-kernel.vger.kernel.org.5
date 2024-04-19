Return-Path: <linux-kernel+bounces-150929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F598AA6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319A5B2229F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5A4C6B;
	Fri, 19 Apr 2024 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ITMi5GGU";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KnhBJAbi"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10615C9;
	Fri, 19 Apr 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492398; cv=none; b=nIcj3YI2Ty3xCU9lZh4VgJI/fZ8HbhXqDdWvyNKHd/1LAiG5BVVjapnOxns0V4fG/kpHCk9QvnTaAkdSytxhSsp7ZrhNRI/yhJWCvNvdMZ3ZqDp/vH7SVvGBClfwXulnT9ndUriCzuLgekRReTBhueWi+HS3X+NlM/B7b2OHfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492398; c=relaxed/simple;
	bh=Y2/s4WAiydW6QBiopUoU1XVzzehaD4MVwOtscaPf80c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up9AeGyj9fPKjPIUUAyF7gWZ0UV2RSJ9ZgHZ3SXEvTvQZi9jbO6J+ACyYsy7UwitvY6Mswo+uZNzsn3me0/DDSJHhZTp61K6ukmhtxdr/hMwIr3kEFMwUCAwZM/X0CWpwjT85fnDh5/Zng0vyzpSyibUlFVCIzWqlYgODpvkjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ITMi5GGU; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=KnhBJAbi; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 8EAF5C028; Fri, 19 Apr 2024 04:06:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1713492387; bh=KpqMVThaIWBdhLUdSPYvCvTYHHBX94PAOEp7ltD0JSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITMi5GGUb/dh+Iglk8Ly2f1C3k+o4Xh/qD46xpCYek/d139l9hWoLaEzWRQDDUAid
	 zeRuiV9ijlV/UMt980z66XnA5W1khjwa+GCH7gsUvf9M8JLojlfjlpuzXcdeGrhaoE
	 ySYU85zXy9y5+VMVFtV5xnSHiMWT4OTMc4TQr2h7dm1VrzXiKcQoD4dxQsvSoFN06r
	 gAUoYKWNRYDhc2F6WH800QP4cNSTVUILss9q3sacWzr+Hfk5OzrX1QryiXPmP+QT79
	 jKCDiUWCZ231/DyRnZVUiooGyInMStGbvydBTwXENARZs4fQaFhUCX/TeB4vOKZ+BI
	 s8XzSZjmpOQHQ==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 419BAC009;
	Fri, 19 Apr 2024 04:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1713492386; bh=KpqMVThaIWBdhLUdSPYvCvTYHHBX94PAOEp7ltD0JSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnhBJAbijWsbehQ0m5ys2wsqXkVqpojDVgvUZcq3/8bfQ6GYhUYiGbeKBpTS5VMwk
	 XdWOJskfq/XzJMdTDDnttyj8D0HwLdz9bGPVK66VK+sOUIKyAv9OpoNRi1cDYpQ2N0
	 plWQ5+4Au9d16bLOLiJjuBxe17CAzGLmKap0Q2n314dj5qCeQD4gGDt7gxGmbGp1MU
	 lsVk6HKNqQuwnr6qfJ0/Pga7o4lQenBBDGILz0XLsqWzqSsXFyEqYFSd1b5b4xoVED
	 O9wZkDTSBfVdH4oiyJdE7+nO40hE+V6XfAU/Z/G2UVzKebVoRrjmbrPcyoogIdbCAJ
	 WxicTz2Faln9A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 86916471;
	Fri, 19 Apr 2024 02:06:13 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:05:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@denx.de>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	alex.williamson@redhat.com, seanjc@google.com, jpoimboe@redhat.com,
	michael.roth@amd.com, dsterba@suse.com, aric.cyr@amd.com
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
Message-ID: <ZiHRhg0TOvh0cUn3@codewreck.org>
References: <20240411095435.633465671@linuxfoundation.org>
 <Zh/HpAGFqa7YAFuM@duo.ucw.cz>
 <2024041739-faceted-sandpit-0818@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024041739-faceted-sandpit-0818@gregkh>

Greg Kroah-Hartman wrote on Wed, Apr 17, 2024 at 03:28:04PM +0200:
> > > David Sterba <dsterba@suse.com>
> > >     btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
> > 
> > (This applies to 4.19, too). mutex_unlock() is needed before "goto
> > error" here.

ugh, I need to look more at the context when reviewing these, btrfs is
part of what I'm more or less looking at when updating...

> So can you provide that fix please?

This bug affects upstream as well and I don't see any upstream fix for
it yet on linux-btrfs@vger, I'll send a patch with Pavel's reported at.

-- 
Dominique Martinet


Return-Path: <linux-kernel+bounces-143584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702F8A3B25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FBC1C215CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109091CA8B;
	Sat, 13 Apr 2024 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gqMeWgwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E11C6A7;
	Sat, 13 Apr 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712986751; cv=none; b=SN4zV6iKPZ3UcGi6NbgCOj3fDt65MrO5lJby/cGgcIiYS3NafNr5j40rjYuC0q1fe/r1cJZ93Y+UnKYSU5xuslYICdawbTcmVLZwdD4DEAX4sDtd8fMdY+9iJAWk3stfuar975FYJ6S/jk7LzRRDEJtHXmLeInrGKCJXby9fNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712986751; c=relaxed/simple;
	bh=RVBtwytKv5pM3iqM/6sQFK3t+qskV/3MED11/zJmXKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKLrkpZ/3VsHxWzP3ThTE+1b1uWiuHM4CwefEfoRf3iuCQJedJ1NiySTj5QXRptOoWou4JHT2O6nL0q9Taz8xWSX5d/hZAB/LllWyQuc4Z130dBJbOyXs4qSzIgSXAtg8k1SlHuPy9OnrbUV58ym8l1WhQvnv3Y8nlOm9LonHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gqMeWgwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F126EC113CD;
	Sat, 13 Apr 2024 05:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712986750;
	bh=RVBtwytKv5pM3iqM/6sQFK3t+qskV/3MED11/zJmXKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqMeWgwpsmJhAC1TigbHV8gDfgGsDW/6uCQ8mmobgtUaP98UjH0zRlyzgP2VpY3dM
	 sNcoz5P1j5UY1ezZgECu41KEoil0t8Ff86Rdj9Gy/fTBr4R3k2tohFLt1pYTyiCuHy
	 kSdg9ZzrOCyIzfLHNuNwtvuK5VhYyASAcAdn6ESg=
Date: Sat, 13 Apr 2024 07:39:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>, Genjian Zhang <zhanggenjian@kylinos.cn>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	maco@android.com, tglx@linutronix.de, christophe.jaillet@wanadoo.fr,
	sean.anderson@linux.dev
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
Message-ID: <2024041358-unhelpful-grub-d4a9@gregkh>
References: <20240411095419.532012976@linuxfoundation.org>
 <ZhmPpo+EI9Ce3bI1@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmPpo+EI9Ce3bI1@duo.ucw.cz>

On Fri, Apr 12, 2024 at 09:46:46PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 4.19.312 release.
> > There are 175 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> > Martijn Coenen <maco@android.com>
> >     loop: Remove sector_t truncation checks
> 
> AFAICT, in 4.19, sector_t is not guaranteed to be u64, see
> include/linux/types.h. So we can't take this.

It's more helpful if you cc: the people on the commit that you are
asking about, so that they can explain why they asked for it, or did the
backport.

Genjian, any thoughts about this one?

thanks,

greg k-h


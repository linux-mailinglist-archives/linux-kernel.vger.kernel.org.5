Return-Path: <linux-kernel+bounces-166021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0188B94DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDD1C215D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC411CAB9;
	Thu,  2 May 2024 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ISh8Kvc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520831B800;
	Thu,  2 May 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632639; cv=none; b=XjMM9bAGSYH86/w75tEmZj3Ds4yxY585ySxtyatAUkAlAdb9SxVYNEKuiNkdj/lTLKPFl1+1kW5TKKL1uY8a96R6yAy28vEnqj3ym/vxPceIm052Fpe+g9ZuFv+sQl0BoQ0E3ZxqE1gQ+dMz3wlwByvtFa6wcfqqfyxaIKKFUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632639; c=relaxed/simple;
	bh=xUROgI/ZajIQoWeMQfgRdgy7GUCyUj9o84+NUFZWShg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWQhT5WhkVqEhJQztuN7Q540DumAOV4cq8L5hd4aLPUR3yEuUkPZQTyXR6cDEUrvpaQG0IVLadYjGtmlVZrVOeMGrRouZIuN8iPVdnldSMiF/NT9g26i+fetZyiOEYIbubfdd/zv06ZyLnmN/FvR3sbOixanZYp4VHMdnztNjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ISh8Kvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DD8C116B1;
	Thu,  2 May 2024 06:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714632638;
	bh=xUROgI/ZajIQoWeMQfgRdgy7GUCyUj9o84+NUFZWShg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ISh8Kvc7tFScTfj1qNpowrdqd9YJtVVwTKt9D2knXCMaNvSDvtmboOIA9fU+V0A6
	 0rVOwJD4w9ZH4rjIh6LB4eC6Z4VlU+yul3zgJFYaH5RenGrFT5IS3spafDwBG5IBgb
	 eoTSA4zGQ+vTQ6wfzIPIiOh+Ev6zYayRRkFDKHiU=
Date: Thu, 2 May 2024 08:50:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
Message-ID: <2024050218-olive-majestic-f64b@gregkh>
References: <20240430103058.010791820@linuxfoundation.org>
 <356c4202-875f-4277-885e-31fdbfd746c1@hardfalcon.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356c4202-875f-4277-885e-31fdbfd746c1@hardfalcon.net>

On Thu, May 02, 2024 at 08:44:30AM +0200, Pascal Ernster wrote:
> [2024-04-30 12:37] Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 6.6.30 release.
> > There are 186 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> > Anything received after that time might be too late.
> 
> Hi, 6.6.30-rc1 is running fine on an x86_64 Haswell VM.
> 
> Note that I have *not* tested building the kernel documentation, and I
> suspect that building the documentation with docutils >= 0.21 would likely
> fail without the patch from
> 
> https://lore.kernel.org/all/faf5fa45-2a9d-4573-9d2e-3930bdc1ed65@gmail.com/

What is the git id of this in Linus's tree?

thanks,

greg k-h


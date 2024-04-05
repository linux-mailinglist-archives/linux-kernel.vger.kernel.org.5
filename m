Return-Path: <linux-kernel+bounces-132410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C189942F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD1C1C259CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7130E22F00;
	Fri,  5 Apr 2024 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X0h+sQCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010422EE0;
	Fri,  5 Apr 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291854; cv=none; b=RcQXXmehdd7/ga9UJWxuH46ShotNWsd842SVETI8IUCdMBKwDlDOKLbKdNN1NUOujV16l/29zcCYPgm0kxdhdZcERZcnz+LrMPIvVpAAOneisP62Na7NfTXsiQTsm6J0SbvCIZcyEvdwZP2XLa3xj4OjCSFHsxQwRw5Q34e1j5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291854; c=relaxed/simple;
	bh=fQSJmR5fXeT1gKRT6xVc9s6XAIrv64NLyk1tAD9C5N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4uxno4ImL/yRulRrtySeGQuodunnUWJgbc5QoEcubZdna4RKpSvkOxq8SlqHibJLaFyly+mqsz3KEkIYgoDJ+01RfmjD5/LLgN1Pvt/SghySa/S+C9cGllhV/p3trUI8rG7Y2PCjDLloN82KGjVn02gTawPlCyhw7mzROwgj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X0h+sQCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8622EC43390;
	Fri,  5 Apr 2024 04:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712291854;
	bh=fQSJmR5fXeT1gKRT6xVc9s6XAIrv64NLyk1tAD9C5N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0h+sQCaGpjBLPFOm2xQNQMCU5oLeDF03fPj6tAlY6RTNfQnrK5F6BapIWUPLXnWP
	 2uWu+p9v4S3+ywP1x4IR/M/2xI5CBMayVe6Q5E84QciliA8B1mr8zqykyLNhqPhZU0
	 AIOnC0lmtTp0k0nJJXScRmV5o7i55Dp7io+zr3cY=
Date: Fri, 5 Apr 2024 06:37:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Cc: mripard@kernel.org, 1054514@bugs.debian.org, airlied@redhat.com,
	carnil@debian.org, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	kraxel@redhat.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org, timo.lindfors@iki.fi,
	tzimmermann@suse.de, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/1] Revert "drm/qxl: simplify qxl_fence_wait"
Message-ID: <2024040515-salvage-uncounted-8164@gregkh>
References: <20240327-cuddly-smooth-trogon-59c02d@houat>
 <20240404181448.1643-1-dreaming.about.electric.sheep@gmail.com>
 <20240404181448.1643-2-dreaming.about.electric.sheep@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404181448.1643-2-dreaming.about.electric.sheep@gmail.com>

On Thu, Apr 04, 2024 at 07:14:48PM +0100, Alex Constantino wrote:
> This reverts commit 5a838e5d5825c85556011478abde708251cc0776.
> 
> Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
> result in a '[TTM] Buffer eviction failed' exception whenever it reached a
> timeout.
> Due to a dependency to DMA_FENCE_WARN this also restores some code deleted
> by commit d72277b6c37d ("dma-buf: nuke DMA_FENCE_TRACE macros v2").
> 
> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Link: https://lore.kernel.org/regressions/ZTgydqRlK6WX_b29@eldamar.lan/
> Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
> Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
> ---
>  drivers/gpu/drm/qxl/qxl_release.c | 50 +++++++++++++++++++++++++++----
>  include/linux/dma-fence.h         |  7 +++++
>  2 files changed, 52 insertions(+), 5 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


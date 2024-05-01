Return-Path: <linux-kernel+bounces-165201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEEF8B8969
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB9285DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7381AD2;
	Wed,  1 May 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Yd2yYiy2"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FE1758D;
	Wed,  1 May 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714564054; cv=none; b=rUFk1/6tTQ6vLi24uYK8UBrcxc5Bj6o+ut+N2I5zORaIuEXSS403xM4dHRigcO+3EmXjAeUap60mFJYJqmUNl+hT40WwPA42EvIM79UKEWOlLK1oLE2k1S351DSjfUchfP+t+q90QEWdrqP6oRV+veBxE/pmHghIPZ5iQpE8SuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714564054; c=relaxed/simple;
	bh=1qvnq8BYqrVzZ+c/6mc11hPFXliDCWNW1o9mQOt1OwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4CLUGbVnIbuSOAzil2g21kiLIR11VZLwPkYZYF9bQSHWnzhr7KVLvFhOY5AOs9/1DaDYxHd/ysdlkPwE4qFXKaQ0bWb57yGaRdu1JxLtEQBbxugYDTWsuBrGJl+7mDjoB+0+nOjroR4AUZmRo8xcicBVbPf+TqkbzHMlas6GmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Yd2yYiy2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-79-44-nat.elisa-mobile.fi [85.76.79.44])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A465E524;
	Wed,  1 May 2024 13:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714563987;
	bh=1qvnq8BYqrVzZ+c/6mc11hPFXliDCWNW1o9mQOt1OwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yd2yYiy2b1M2LU+PeBmv8gAJ8BBty8NRithDHJHLETyTL9a2MioAjCthW88vAcxT1
	 hRt1xiaOsey4r+2dc5nnWn9B4rvgs5300IRu2hLLY8mtD9JSCm650S8ZbARpRADWBA
	 RgH1GVY6AtdqV/9S3CGjdECP16JLetDsnGGotU8Q=
Date: Wed, 1 May 2024 14:47:15 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: linux-media@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: bcm2835-unicam: Include v4l2-subdev.h
Message-ID: <20240501114715.GG17852@pendragon.ideasonboard.com>
References: <20240430213146.23187-1-laurent.pinchart@ideasonboard.com>
 <20240430213633.23767-1-laurent.pinchart@ideasonboard.com>
 <20240430213633.23767-2-laurent.pinchart@ideasonboard.com>
 <CAPybu_2xjWg8sUW9jk7n1UXLTsoGXfftxVqLaZcWzn+ZcCRhOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_2xjWg8sUW9jk7n1UXLTsoGXfftxVqLaZcWzn+ZcCRhOg@mail.gmail.com>

Hi Ricardo,

On Wed, May 01, 2024 at 01:07:29PM +0200, Ricardo Ribalda Delgado wrote:
> Hi Laurent
> 
> I have to send a v2 of
> https://patchwork.linuxtv.org/project/linux-media/list/?series=12759 I
> can include this patch in that set if you want

Fine with me.

> On Tue, Apr 30, 2024 at 11:39 PM Laurent Pinchart wrote:
> >
> > The unicam driver uses the v4l2_subdev structure. Include the
> > corresponding header instead of relying on indirect includes.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404302324.8aTC84kE-lkp@intel.com/
> > ---
> >  drivers/media/platform/broadcom/bcm2835-unicam.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
> > index c590e26fe2cf..3c7878d8d79b 100644
> > --- a/drivers/media/platform/broadcom/bcm2835-unicam.c
> > +++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
> > @@ -55,6 +55,7 @@
> >  #include <media/v4l2-ioctl.h>
> >  #include <media/v4l2-fwnode.h>
> >  #include <media/v4l2-mc.h>
> > +#include <media/v4l2-subdev.h>
> >  #include <media/videobuf2-dma-contig.h>
> >
> >  #include "bcm2835-unicam-regs.h"

-- 
Regards,

Laurent Pinchart


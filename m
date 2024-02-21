Return-Path: <linux-kernel+bounces-75235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D185E4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00DC1C24162
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEBC84FDF;
	Wed, 21 Feb 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em/88Spr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AE84A20;
	Wed, 21 Feb 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538162; cv=none; b=LuIFhzB9+0xXGSACr3Q8DhMmPTgV86iPaVx4x4GiwQvuUwD0A76FRHOwGtrO7bk2owUrmzzkINuGAqn/U3VDyVDlDTleb9z4kD9hR8/uffZ2lwkGRZsiYiJcQPuZIhmHoVaHFeGBT3YMaBdQECYjsLRvQyDtZ5goYVQmu20j5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538162; c=relaxed/simple;
	bh=oWcHp9x73YgPSkwDaaqgBgFV5ftpC961IK+EKxw6ysQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubuQXHoeOO62/qnARJQ1/z+xOhEchGklU+1Wj0IHWIt7UcQmVvL/DIY8YY2rmvNnfZqOwj5PapWDMAJn6ot1lOUwa5dUI5ZbR40dS1zkOAYd+7RdGrwmEkA2ad+3fsiXkh1ANgBS2Rs4W9htqbW5OPVpfUt2/UE48qtXUWBnfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em/88Spr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so1255481e87.0;
        Wed, 21 Feb 2024 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708538158; x=1709142958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKaICofgbZiOHVrYBW4vGimCtoDYXpJFcZwodVsVwYU=;
        b=em/88Spr4osdbCdzIvEgyOHwhxprgqLn8AxPweLnkIaVPBj1Gh7GtM1eZj0ldwjrpr
         ts0H03OKKKfekPJchfygxFHRMO4zsYSnFe9ibndtQfQMvpEetI2dxu4sGRuRZGNJtLeI
         n1wF4U/QjctShUNrmqBq4dSzLVcNtxng14PPfl7vc0C1PJkvO4JZvK0mvuSjZQe8GCU8
         hCpi5I2hwGJn48bVJZIF5WhHCcyyFKCmoiNNbadr72UUDMH5ucPIyOvsx2YCgj8wo2Gk
         aVKYC54Bc3rXvw0/2tau9Kw56UGffURwMV5xMcZAKPwMo6weK/DpwXro+geGSzWyJeXu
         r54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538158; x=1709142958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKaICofgbZiOHVrYBW4vGimCtoDYXpJFcZwodVsVwYU=;
        b=NCWwePyoO2/UxH4M1ayccZCadq0qBOIpjfS5uNtUuzMXBiCRn8BLtWt617D3kGOmtv
         tUdTzZClUTprh+k56gebzL24gh9uQjZoPOCnaXAxI8yydzOAlchYFOtYxGQj/o7SGVqE
         OYF4AQL0PcQBBAr0neDHSR9xH1pkkTSd8ZHOB2RPBOd9mRTg9ueuX03NngFPZ7YLypQI
         kFyX2B7pdMbLVCyMxSkYR7W683axXKSLBtHKddqcg3A5tdTLItX6rwWLWhWWNy93vhsp
         7X5lWwcwfBr6jVOymNyglvRBY0YTfz9B1H5jVOH4l1OBtQQOvt6zkO9W9lQ0b1dFIAr1
         8Ubg==
X-Forwarded-Encrypted: i=1; AJvYcCVhXL5/4Tumxh0orGJyCGwH5jgRn26nCMhKb+L2KZFyeoDmMw4AFo5frkhKkVAg2poqvM3aTplI+UyzgHD7X/xX00kn+usMmzx9lQh+mt0G/4o2knKfpxeGT4VlaZKln+BMovlFDD29V9A7KUhEmPjGxjwdi7smAa4DCNQKxZJUAu3X962w
X-Gm-Message-State: AOJu0YyAWJY4okL4n9o/OUGZQ3djNe33YjwfVUf17ap3WXovMETzy6om
	t3Dxc23oW6m62AdsgT62xiNtsmWCoRaCcwDaD+SlfZ39LkW82mmp
X-Google-Smtp-Source: AGHT+IHT0T5QwNsj80FDj3EmVL9eSCoNrJrN3sGsIorv+ViafW5ew9e3wUllwIpY1jpjnstYlPki/Q==
X-Received: by 2002:ac2:5e77:0:b0:512:bb2a:c977 with SMTP id a23-20020ac25e77000000b00512bb2ac977mr4334429lfr.56.1708538158223;
        Wed, 21 Feb 2024 09:55:58 -0800 (PST)
Received: from mehdi-archlinux ([2a02:8109:aa27:2d00::d069])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00564da28dfe2sm1290742edb.19.2024.02.21.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:55:57 -0800 (PST)
Date: Wed, 21 Feb 2024 18:55:54 +0100
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net, laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait@bootlin.com>
Subject: Re: [RESEND Patch v13 2/3] media: rockchip: Add a driver for
 Rockchip's camera interface
Message-ID: <ZdY5KrTfss4lTjPO@mehdi-archlinux>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <715d89214d1ed6a8bb16cbb6268718a737485560.1707677804.git.mehdi.djait.k@gmail.com>
 <Zctwo3s9hso6mQvT@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zctwo3s9hso6mQvT@valkosipuli.retiisi.eu>

Hi Sakari,

Thank you for the review!

On Tue, Feb 13, 2024 at 01:37:39PM +0000, Sakari Ailus wrote:
> Hi Mahdi,
> 
> On Sun, Feb 11, 2024 at 08:03:31PM +0100, Mehdi Djait wrote:
> > From: Mehdi Djait <mehdi.djait@bootlin.com>
> > 
> > This introduces a V4L2 driver for the Rockchip CIF video capture controller.
> > 
> > This controller supports multiple parallel interfaces, but for now only the
> > BT.656 interface could be tested, hence it's the only one that's supported
> > in the first version of this driver.
> > 
> > This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> > but for now it's only been tested on the PX30.
> > 
> > CIF is implemented as a video node-centric driver.
> > 
> > Most of this driver was written following the BSP driver from Rockchip,
> > removing the parts that either didn't fit correctly the guidelines, or that
> > couldn't be tested.
> > 
> > This basic version doesn't support cropping nor scaling and is only
> > designed with one SDTV video decoder being attached to it at any time.
> > 
> > This version uses the "pingpong" mode of the controller, which is a
> > double-buffering mechanism.
> > 
> > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> >  MAINTAINERS                                   |    7 +
> >  drivers/media/platform/rockchip/Kconfig       |    1 +
> >  drivers/media/platform/rockchip/Makefile      |    1 +
> >  drivers/media/platform/rockchip/cif/Kconfig   |   14 +
> >  drivers/media/platform/rockchip/cif/Makefile  |    3 +
> >  .../media/platform/rockchip/cif/cif-capture.c | 1111 +++++++++++++++++
> >  .../media/platform/rockchip/cif/cif-capture.h |   20 +
> >  .../media/platform/rockchip/cif/cif-common.h  |  128 ++
> >  drivers/media/platform/rockchip/cif/cif-dev.c |  308 +++++
> >  .../media/platform/rockchip/cif/cif-regs.h    |  127 ++
> >  10 files changed, 1720 insertions(+)
> >  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
> >  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
> >  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.c
> >  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.h
> >  create mode 100644 drivers/media/platform/rockchip/cif/cif-common.h
> >  create mode 100644 drivers/media/platform/rockchip/cif/cif-dev.c
> >  create mode 100644 drivers/media/platform/rockchip/cif/cif-regs.h
> > 
> > +static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
> > +{
> > +	struct cif_stream *stream = queue->drv_priv;
> > +	struct cif_device *cif_dev = stream->cifdev;
> > +	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
> > +	struct v4l2_subdev *sd;
> > +	int ret;
> > +
> > +	if (!cif_dev->remote.sd) {
> > +		ret = -ENODEV;
> > +		v4l2_err(v4l2_dev, "No remote subdev detected\n");
> > +		goto destroy_buf;
> > +	}
> > +
> > +	ret = pm_runtime_resume_and_get(cif_dev->dev);
> > +	if (ret < 0) {
> > +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
> > +		goto destroy_buf;
> > +	}
> > +
> > +	sd = cif_dev->remote.sd;
> > +
> > +	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
> 
> You should use the format on the local pad, not get it from a remote
> sub-device.
> 
> Link validation ensures they're the same (or at least compatible).
> 
> Speaking of which---you don't have link_validate callbacks set for the
> sub-device. See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an
> example.
> 

..

> > +	if (!stream->cif_fmt_in)
> > +		goto runtime_put;
> > +
> > +	ret = cif_stream_start(stream);
> > +	if (ret < 0)
> > +		goto stop_stream;
> > +
> > +	ret = v4l2_subdev_call(sd, video, s_stream, 1);
> > +	if (ret < 0)
> > +		goto stop_stream;
> > +
> > +	return 0;
> > +
> > +stop_stream:
> > +	cif_stream_stop(stream);
> > +runtime_put:
> > +	pm_runtime_put(cif_dev->dev);
> > +destroy_buf:
> > +	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
> > +
> > +	return ret;
> > +}
> > +
> > +static int cif_set_fmt(struct cif_stream *stream,
> > +		       struct v4l2_pix_format *pix)
> > +{
> > +	struct cif_device *cif_dev = stream->cifdev;
> > +	struct v4l2_subdev_format sd_fmt;
> > +	struct cif_output_fmt *fmt;
> > +	int ret;
> > +
> > +	if (vb2_is_streaming(&stream->buf_queue))
> > +		return -EBUSY;
> > +
> > +	fmt = find_output_fmt(stream, pix->pixelformat);
> > +	if (!fmt)
> > +		fmt = &out_fmts[0];
> > +
> > +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> > +	sd_fmt.pad = 0;
> > +	sd_fmt.format.width = pix->width;
> > +	sd_fmt.format.height = pix->height;
> > +
> > +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fmt);
> 
> The user space is responsible for controlling the sensor i.e. you shouldn't
> call set_fmt sub-device op from this driver.
> 
> As the driver is MC-enabled, generally the sub-devices act as a control
> interface and the V4L2 video nodes are a data interface.
> 

While this is true for MC-centric (Media Controller) drivers, this driver is
video-node-centric (I mentioned this in the commit msg)

From the Kernel Documentation: https://docs.kernel.org/userspace-api/media/v4l/open.html

1 - The devices that are fully controlled via V4L2 device nodes are called video-node-centric.

2- Note:
A video-node-centric may still provide media-controller and sub-device interfaces as well.
However, in that case the media-controller and the sub-device interfaces are read-only and just
provide information about the device. The actual configuration is done via the video nodes.

> > +	if (ret)
> > +		return ret;
> > +
> > +	cif_update_pix(stream, fmt, pix);
> > +	stream->pix = *pix;
> > +	stream->cif_fmt_out = fmt;
> > +
> > +	return 0;
> > +}

--
Kind Regards
Mehdi Djait


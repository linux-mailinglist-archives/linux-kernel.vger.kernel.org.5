Return-Path: <linux-kernel+bounces-89437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A71886F058
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CFEB23E7F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85861756D;
	Sat,  2 Mar 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+tNjvCi"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9D171D8;
	Sat,  2 Mar 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709380289; cv=none; b=oi/Yk679NDt8vPOllWMeZvK3rB5FMi7FpI+NuNMWwmkD4sU1Y0R1cMrbmoMWVCdXlEh3YQ0HxjxjFSVCKqJ6M5tpmzKFxL1MiJHolr1Ue4bS9qzF13xKBeZlEZBNyQknxxZbEqK+NHCU9Nu2D66MAUxNk+Kyxaq4R7KF8Ev+O7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709380289; c=relaxed/simple;
	bh=rSoQeHsKvblcLObyPUnZ+IeINndMLkvAGZH5AvF5igk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRjJYW2LuexYZH2ONWJ6AGktivYZAouu2+QqxZiJoPPR1xJn1frDn3lvda2SQ3OxQlL4BnTt/p+U6s9xN9/56K1mCqLPbfFt1tIIn6onmIdrgYXRDlONJpYfs8ahnJyV9XQwYakF6wSgyiJTu3NXLacGYByS8eshonirqgt5W6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+tNjvCi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44cf608a39so54966466b.0;
        Sat, 02 Mar 2024 03:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709380286; x=1709985086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pn1t2MCqh3EwDFn3L7PI72aDd7hbifVx/K7JMBf7ihw=;
        b=a+tNjvCiZIGrVfy9cJlCHArsMV/jDR+fkcpDfg6OfPjq4hU3K4TBRrg7SlhJkKvJka
         r2pIaA/oqOiwtUtO6y4jp7Ti2GseVAjB+v9bwn0XLgsrgk2uTZ4Zup+UIiEEYMkll1Wt
         f7Cj/jLyERETuUTxS7z0JBR9J21IvKuKz14AzHaSiGYzpj/xdanPTnNukSWJttqPakV0
         ePK0jRAnEpRnu7JwBVRvx61yruwxtDFAY4wTh10b0TDmlK6vmnBov6knRd5lanJQoBMo
         9Lc7H5jOIec3wDqTNxtFs17pEWVYZc0ipS149St8B8Y4DhW7Uj2K7R38tEomJ2gI8DW6
         TaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709380286; x=1709985086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn1t2MCqh3EwDFn3L7PI72aDd7hbifVx/K7JMBf7ihw=;
        b=ks9Lzc2MfQ1RL54Az8ElHRkLmp4siy98Y3HMmIki/gUTyxQXnf5njXwZXNjkbY91ZD
         f3t5ZSfGPm9mSMN8r+p/+W43yfQdE8uG69BGJ0kXFvqmxM9NU37VqyLTzmog5OpHbTrR
         KdBcRROatx3FVkmGCN+vlrOjUvZ94W2ImT0fA/m2kBYhE9JzLyVDMA4N5DrSXLBfquIW
         GU8SJT1B4Q+1drcZudJm+sgJW7dTQO3D9J2862ezLmhXdDRnx1J+Qaz6hLBAkEX0/lDy
         GO+WpNQfW0BIcCIutJ4p76cr2eM8LtXC2+Tco2ytStH3i+M0Rb/i1hOLF7n/Wrq55i5Z
         6xcA==
X-Forwarded-Encrypted: i=1; AJvYcCWvU3r1vALxMS0IIOHpntnVQ/sQuoe3m2iSaI9INebzYX8wKOQsxIb6xpxwNLckfAfAji89MMMOIQbadoTW7rUJUJ2V0k7YjOuCDqY+Ssxg8FQRJvMdbJ4O/GpkOVn6zKs0WzpI8VT8kSyKWArJGksiwaBNJuELIfzsxogZn4Qhj9LJjGDT
X-Gm-Message-State: AOJu0YzRP4mSO3XAgQlupEefrmNGjhLqtHV1+qhDlFfHHLN6JuQoI+JC
	tf92FjXF+slpupvoOCcCIQ5GskTJk/V6dwzKoUcbmbv5/8ONFxwr
X-Google-Smtp-Source: AGHT+IGtJm5wQabNPfMkCUTKune5knKZdBx7da/Zn9OAIG6Cq2UqF1lMTXv8zj0dl++dYwkikt1wxg==
X-Received: by 2002:a17:906:f754:b0:a43:76d4:806c with SMTP id jp20-20020a170906f75400b00a4376d4806cmr3262555ejb.74.1709380285919;
        Sat, 02 Mar 2024 03:51:25 -0800 (PST)
Received: from mehdi-archlinux ([2a02:8109:aa27:2d00::e094])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090680c400b00a446b59af63sm1924660ejx.13.2024.03.02.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 03:51:25 -0800 (PST)
Date: Sat, 2 Mar 2024 12:51:22 +0100
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
Message-ID: <ZeMSuihjcS_wXONr@mehdi-archlinux>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <715d89214d1ed6a8bb16cbb6268718a737485560.1707677804.git.mehdi.djait.k@gmail.com>
 <Zctwo3s9hso6mQvT@valkosipuli.retiisi.eu>
 <ZdY5KrTfss4lTjPO@mehdi-archlinux>
 <Zd24MhLYJlSTRysr@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd24MhLYJlSTRysr@valkosipuli.retiisi.eu>

Hi Sakari,

On Tue, Feb 27, 2024 at 10:23:46AM +0000, Sakari Ailus wrote:
> Hi Mehdi,
> 
> On Wed, Feb 21, 2024 at 06:55:54PM +0100, Mehdi Djait wrote:
> > Hi Sakari,
> > 
> > Thank you for the review!
> > 
> > On Tue, Feb 13, 2024 at 01:37:39PM +0000, Sakari Ailus wrote:
> > > Hi Mahdi,
> > > 
> > > On Sun, Feb 11, 2024 at 08:03:31PM +0100, Mehdi Djait wrote:
> > > > From: Mehdi Djait <mehdi.djait@bootlin.com>
> > > > 
> > > > This introduces a V4L2 driver for the Rockchip CIF video capture controller.
> > > > 
> > > > This controller supports multiple parallel interfaces, but for now only the
> > > > BT.656 interface could be tested, hence it's the only one that's supported
> > > > in the first version of this driver.
> > > > 
> > > > This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> > > > but for now it's only been tested on the PX30.
> > > > 
> > > > CIF is implemented as a video node-centric driver.
> > > > 
> > > > Most of this driver was written following the BSP driver from Rockchip,
> > > > removing the parts that either didn't fit correctly the guidelines, or that
> > > > couldn't be tested.
> > > > 
> > > > This basic version doesn't support cropping nor scaling and is only
> > > > designed with one SDTV video decoder being attached to it at any time.
> > > > 
> > > > This version uses the "pingpong" mode of the controller, which is a
> > > > double-buffering mechanism.
> > > > 
> > > > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > > > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > > ---
> > > >  MAINTAINERS                                   |    7 +
> > > >  drivers/media/platform/rockchip/Kconfig       |    1 +
> > > >  drivers/media/platform/rockchip/Makefile      |    1 +
> > > >  drivers/media/platform/rockchip/cif/Kconfig   |   14 +
> > > >  drivers/media/platform/rockchip/cif/Makefile  |    3 +
> > > >  .../media/platform/rockchip/cif/cif-capture.c | 1111 +++++++++++++++++
> > > >  .../media/platform/rockchip/cif/cif-capture.h |   20 +
> > > >  .../media/platform/rockchip/cif/cif-common.h  |  128 ++
> > > >  drivers/media/platform/rockchip/cif/cif-dev.c |  308 +++++
> > > >  .../media/platform/rockchip/cif/cif-regs.h    |  127 ++
> > > >  10 files changed, 1720 insertions(+)
> > > >  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
> > > >  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
> > > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.c
> > > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.h
> > > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-common.h
> > > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-dev.c
> > > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-regs.h
> > > > 
> > > > +static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
> > > > +{
> > > > +	struct cif_stream *stream = queue->drv_priv;
> > > > +	struct cif_device *cif_dev = stream->cifdev;
> > > > +	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
> > > > +	struct v4l2_subdev *sd;
> > > > +	int ret;
> > > > +
> > > > +	if (!cif_dev->remote.sd) {
> > > > +		ret = -ENODEV;
> > > > +		v4l2_err(v4l2_dev, "No remote subdev detected\n");
> > > > +		goto destroy_buf;
> > > > +	}
> > > > +
> > > > +	ret = pm_runtime_resume_and_get(cif_dev->dev);
> > > > +	if (ret < 0) {
> > > > +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
> > > > +		goto destroy_buf;
> > > > +	}
> > > > +
> > > > +	sd = cif_dev->remote.sd;
> > > > +
> > > > +	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
> > > 
> > > You should use the format on the local pad, not get it from a remote
> > > sub-device.
> > > 
> > > Link validation ensures they're the same (or at least compatible).
> > > 
> > > Speaking of which---you don't have link_validate callbacks set for the
> > > sub-device. See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an
> > > example.
> > > 
> > 
> > ...
> > 
> > > > +	if (!stream->cif_fmt_in)
> > > > +		goto runtime_put;
> > > > +
> > > > +	ret = cif_stream_start(stream);
> > > > +	if (ret < 0)
> > > > +		goto stop_stream;
> > > > +
> > > > +	ret = v4l2_subdev_call(sd, video, s_stream, 1);
> > > > +	if (ret < 0)
> > > > +		goto stop_stream;
> > > > +
> > > > +	return 0;
> > > > +
> > > > +stop_stream:
> > > > +	cif_stream_stop(stream);
> > > > +runtime_put:
> > > > +	pm_runtime_put(cif_dev->dev);
> > > > +destroy_buf:
> > > > +	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int cif_set_fmt(struct cif_stream *stream,
> > > > +		       struct v4l2_pix_format *pix)
> > > > +{
> > > > +	struct cif_device *cif_dev = stream->cifdev;
> > > > +	struct v4l2_subdev_format sd_fmt;
> > > > +	struct cif_output_fmt *fmt;
> > > > +	int ret;
> > > > +
> > > > +	if (vb2_is_streaming(&stream->buf_queue))
> > > > +		return -EBUSY;
> > > > +
> > > > +	fmt = find_output_fmt(stream, pix->pixelformat);
> > > > +	if (!fmt)
> > > > +		fmt = &out_fmts[0];
> > > > +
> > > > +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > +	sd_fmt.pad = 0;
> > > > +	sd_fmt.format.width = pix->width;
> > > > +	sd_fmt.format.height = pix->height;
> > > > +
> > > > +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fmt);
> > > 
> > > The user space is responsible for controlling the sensor i.e. you shouldn't
> > > call set_fmt sub-device op from this driver.
> > > 
> > > As the driver is MC-enabled, generally the sub-devices act as a control
> > > interface and the V4L2 video nodes are a data interface.
> > > 
> > 
> > While this is true for MC-centric (Media Controller) drivers, this driver is
> > video-node-centric (I mentioned this in the commit msg)
> > 
> > From the Kernel Documentation:
> > https://docs.kernel.org/userspace-api/media/v4l/open.html
> > 
> > 1 - The devices that are fully controlled via V4L2 device nodes are
> > called video-node-centric.
> > 
> > 2- Note: A video-node-centric may still provide media-controller and
> > sub-device interfaces as well. However, in that case the media-controller
> > and the sub-device interfaces are read-only and just provide information
> > about the device. The actual configuration is done via the video nodes.
> 
> Are you sure you even want to do this?
> 
> It'll limit what kind of sensors you can attach to the device and even more
> so in the future as we're reworking the sensor APIs to allow better control
> of the sensors, using internal pads (that require MC).
> 
> There have been some such drivers in the past but many have been already
> converted, or in some cases the newer hardware generation uses MC. Keeping
> API compatibility is a requirement so you can't just "add support" later
> on.

I totally agree that using the MC approach is better but this has nothing to
do with me wanting this but due to constraints I unfortunately cannot control
it is impossible to convert it now.

I would say the px30 driver is still very useful and people are going to use it: a follow-up patch series to
add support for the Rockchip RK3568 Video Capture has already been sent:
https://lore.kernel.org/linux-media/20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net/

--
Kind Regards
Mehdi Djait


Return-Path: <linux-kernel+bounces-83026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B261E868D76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BF01C22F62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E561384B6;
	Tue, 27 Feb 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rwJ0DVXJ"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C0138492;
	Tue, 27 Feb 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029438; cv=pass; b=AlnfIuFlC4bo1dpbcH3dsQY/J2Oy4dsjs4YJcOLSyEhXK4nqH0FKzgPCfUD4d8ugWdkbK+leTaUy4BV4fi1p5xONBTVlZQk2iQhR0pt/G+wde+TiXWbgc8HdGCFyzJPjL2xlpeCfg8PVGUdbQ+LGtkcs9DNCZZw1mCzqUY9Lg1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029438; c=relaxed/simple;
	bh=i8Z3BJKTqV2tpEnLiU8y6wyHC2OVAz1euRNw4C3obPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q55IWnehwRdoaeKbg7atuMe12DMVJzNc/U40b29RtP+eICWdsHyNyM1H9P401DwQARlKhSXQzleGoovDiGEi9IEW2gk1dWnFTI+Nh8mJoYV2Ap56pU/tes/1ObAkzOWntssdLCN9uN2WZQlZjmoRgrrqhNDtFNMymiRLG0Pgyco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rwJ0DVXJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TkYVX4hLfzyRk;
	Tue, 27 Feb 2024 12:23:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709029431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7CJlVsWqknG0VD0bGsDCpWj600Be6wheaK7cV+aA3M=;
	b=rwJ0DVXJtnAhe42Af1YIFXFp77CJUlD92dcKhC3JitX+5DvfjefalGkQARQl9oIgIf1r08
	VJAL4f0eipvO3NkhpNN9PwI/OAQBJzZkEHEGHaf3zpXwYmcNLKVjWCLFcwReSV++PJbyAO
	2KJb78YlceMtFyBQbQoSaTZaQPUsXB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709029431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7CJlVsWqknG0VD0bGsDCpWj600Be6wheaK7cV+aA3M=;
	b=WJi0u4Wr2KVXQJXA7dm8vI/PfmsJJDbukRMN0AqPfcwXD2RE7b8PVXZGOTx5UqsgGbT78R
	StL1I7WN17yJ15kK4rnnJoc6Q3BJUfkOZqa6CB38jgrENS21Roe8JYlEPNsmEsJ8tv2fc1
	bTRhQCoKmS9wFeiuMNahLTkV0t5reAU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709029431; a=rsa-sha256; cv=none;
	b=YJL/5RLtrNIVyJpo0whQkcfPlKbrn5iuqqqAOEbsqFmOkee0c+GqPRHLKkxlIyjDZZiJFI
	wwvAJt8V9x0c8nOmyxfSWAMyMV1Zqj9UH+7oySOCS1JQD75fR/bh05UlVoy/9x+hhEDg3X
	cwHpWgGeN4qFDXBgQEerE+/9c7H124o=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 1A552634C94;
	Tue, 27 Feb 2024 12:23:47 +0200 (EET)
Date: Tue, 27 Feb 2024 10:23:46 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Mehdi Djait <mehdi.djait.k@gmail.com>
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
Message-ID: <Zd24MhLYJlSTRysr@valkosipuli.retiisi.eu>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <715d89214d1ed6a8bb16cbb6268718a737485560.1707677804.git.mehdi.djait.k@gmail.com>
 <Zctwo3s9hso6mQvT@valkosipuli.retiisi.eu>
 <ZdY5KrTfss4lTjPO@mehdi-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdY5KrTfss4lTjPO@mehdi-archlinux>

Hi Mehdi,

On Wed, Feb 21, 2024 at 06:55:54PM +0100, Mehdi Djait wrote:
> Hi Sakari,
> 
> Thank you for the review!
> 
> On Tue, Feb 13, 2024 at 01:37:39PM +0000, Sakari Ailus wrote:
> > Hi Mahdi,
> > 
> > On Sun, Feb 11, 2024 at 08:03:31PM +0100, Mehdi Djait wrote:
> > > From: Mehdi Djait <mehdi.djait@bootlin.com>
> > > 
> > > This introduces a V4L2 driver for the Rockchip CIF video capture controller.
> > > 
> > > This controller supports multiple parallel interfaces, but for now only the
> > > BT.656 interface could be tested, hence it's the only one that's supported
> > > in the first version of this driver.
> > > 
> > > This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> > > but for now it's only been tested on the PX30.
> > > 
> > > CIF is implemented as a video node-centric driver.
> > > 
> > > Most of this driver was written following the BSP driver from Rockchip,
> > > removing the parts that either didn't fit correctly the guidelines, or that
> > > couldn't be tested.
> > > 
> > > This basic version doesn't support cropping nor scaling and is only
> > > designed with one SDTV video decoder being attached to it at any time.
> > > 
> > > This version uses the "pingpong" mode of the controller, which is a
> > > double-buffering mechanism.
> > > 
> > > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > ---
> > >  MAINTAINERS                                   |    7 +
> > >  drivers/media/platform/rockchip/Kconfig       |    1 +
> > >  drivers/media/platform/rockchip/Makefile      |    1 +
> > >  drivers/media/platform/rockchip/cif/Kconfig   |   14 +
> > >  drivers/media/platform/rockchip/cif/Makefile  |    3 +
> > >  .../media/platform/rockchip/cif/cif-capture.c | 1111 +++++++++++++++++
> > >  .../media/platform/rockchip/cif/cif-capture.h |   20 +
> > >  .../media/platform/rockchip/cif/cif-common.h  |  128 ++
> > >  drivers/media/platform/rockchip/cif/cif-dev.c |  308 +++++
> > >  .../media/platform/rockchip/cif/cif-regs.h    |  127 ++
> > >  10 files changed, 1720 insertions(+)
> > >  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
> > >  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
> > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.c
> > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.h
> > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-common.h
> > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-dev.c
> > >  create mode 100644 drivers/media/platform/rockchip/cif/cif-regs.h
> > > 
> > > +static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
> > > +{
> > > +	struct cif_stream *stream = queue->drv_priv;
> > > +	struct cif_device *cif_dev = stream->cifdev;
> > > +	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
> > > +	struct v4l2_subdev *sd;
> > > +	int ret;
> > > +
> > > +	if (!cif_dev->remote.sd) {
> > > +		ret = -ENODEV;
> > > +		v4l2_err(v4l2_dev, "No remote subdev detected\n");
> > > +		goto destroy_buf;
> > > +	}
> > > +
> > > +	ret = pm_runtime_resume_and_get(cif_dev->dev);
> > > +	if (ret < 0) {
> > > +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
> > > +		goto destroy_buf;
> > > +	}
> > > +
> > > +	sd = cif_dev->remote.sd;
> > > +
> > > +	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
> > 
> > You should use the format on the local pad, not get it from a remote
> > sub-device.
> > 
> > Link validation ensures they're the same (or at least compatible).
> > 
> > Speaking of which---you don't have link_validate callbacks set for the
> > sub-device. See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an
> > example.
> > 
> 
> ...
> 
> > > +	if (!stream->cif_fmt_in)
> > > +		goto runtime_put;
> > > +
> > > +	ret = cif_stream_start(stream);
> > > +	if (ret < 0)
> > > +		goto stop_stream;
> > > +
> > > +	ret = v4l2_subdev_call(sd, video, s_stream, 1);
> > > +	if (ret < 0)
> > > +		goto stop_stream;
> > > +
> > > +	return 0;
> > > +
> > > +stop_stream:
> > > +	cif_stream_stop(stream);
> > > +runtime_put:
> > > +	pm_runtime_put(cif_dev->dev);
> > > +destroy_buf:
> > > +	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int cif_set_fmt(struct cif_stream *stream,
> > > +		       struct v4l2_pix_format *pix)
> > > +{
> > > +	struct cif_device *cif_dev = stream->cifdev;
> > > +	struct v4l2_subdev_format sd_fmt;
> > > +	struct cif_output_fmt *fmt;
> > > +	int ret;
> > > +
> > > +	if (vb2_is_streaming(&stream->buf_queue))
> > > +		return -EBUSY;
> > > +
> > > +	fmt = find_output_fmt(stream, pix->pixelformat);
> > > +	if (!fmt)
> > > +		fmt = &out_fmts[0];
> > > +
> > > +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> > > +	sd_fmt.pad = 0;
> > > +	sd_fmt.format.width = pix->width;
> > > +	sd_fmt.format.height = pix->height;
> > > +
> > > +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fmt);
> > 
> > The user space is responsible for controlling the sensor i.e. you shouldn't
> > call set_fmt sub-device op from this driver.
> > 
> > As the driver is MC-enabled, generally the sub-devices act as a control
> > interface and the V4L2 video nodes are a data interface.
> > 
> 
> While this is true for MC-centric (Media Controller) drivers, this driver is
> video-node-centric (I mentioned this in the commit msg)
> 
> From the Kernel Documentation:
> https://docs.kernel.org/userspace-api/media/v4l/open.html
> 
> 1 - The devices that are fully controlled via V4L2 device nodes are
> called video-node-centric.
> 
> 2- Note: A video-node-centric may still provide media-controller and
> sub-device interfaces as well. However, in that case the media-controller
> and the sub-device interfaces are read-only and just provide information
> about the device. The actual configuration is done via the video nodes.

Are you sure you even want to do this?

It'll limit what kind of sensors you can attach to the device and even more
so in the future as we're reworking the sensor APIs to allow better control
of the sensors, using internal pads (that require MC).

There have been some such drivers in the past but many have been already
converted, or in some cases the newer hardware generation uses MC. Keeping
API compatibility is a requirement so you can't just "add support" later
on.

-- 
Regards,

Sakari Ailus


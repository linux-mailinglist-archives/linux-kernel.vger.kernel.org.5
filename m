Return-Path: <linux-kernel+bounces-90473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78186FFB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D9D282A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6C5383B6;
	Mon,  4 Mar 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="svIJcZUi"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5929376F9;
	Mon,  4 Mar 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550117; cv=pass; b=bTkYQRpFci0tus+v+51ILTrX8ryeUItR2f5migDPzpxpGZLUM0gwRMgcWtJs+wViCdCh5+L9djWW22d9xaYcjN0LPS5T6P4uhjkWWeK9IPZlZjsVMjJOxJycc6IwPhjg3wO2c0utFm2XGq/1g2FREYyOL3ce6UaxtNFvVTlORHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550117; c=relaxed/simple;
	bh=E9BN46B+Rj1lKO3CZJlOHqbQerCwOrDcQDZX1K/rk+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbh/qO9annWdAADlQYreOkiF6VEyXdHYanq3Yp7l3Owhd5nYOALFEsEAnSJ3+qpbqaFt9sekTg6HxZgGQAVsgOGjltpv2+jDW611kP/oNpmTgdo2TyIynspQ1Z+CKyuE0lBgc+OZ7P7MwTJ73z9ZFKbb3skRcJc/jKfI6afMM2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=svIJcZUi; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TpG3V51YkzySP;
	Mon,  4 Mar 2024 13:01:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709550105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ihnx46YYG/dRc7H8/r1H+1hFqkaVemFb3zOnrBAgfz8=;
	b=svIJcZUioCJUBjxbGCyVtun8B56hhr9i+TxbEd7QcsaD3FlVB1bq8U8l1xp7KA6jFnU7/+
	dJsaQOjfAT+RYAS++hZtRHHCBeJixMmYWLsBZEBnpGmGWzc58KHEaehSiit+sA8AZoCFD1
	JtGK7okTjoN53gAdRZiomBDy66cPrMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709550105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ihnx46YYG/dRc7H8/r1H+1hFqkaVemFb3zOnrBAgfz8=;
	b=xHVRmXEeSAUKuYAxHPyMLfMr1zXcsMfskKDDB4LohCh2huEmoEwrxP4Y9Vv2LkV1yjaaU8
	Fqf35xp68cHWtUAygRwcXs0+F+LN690dFK4ERtJG3aH9tsKLzBMte/+z3HNln3L/BnUPCG
	RYWtag0GBQIpldWGq0jcF2gd1MxzuWQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709550105; a=rsa-sha256; cv=none;
	b=cxMxodOco+px9kKHNq4Jk2fAiCNr4mKTbIrATWuSHG7A627fNPwMU0hz/Mu+tusgp34F/X
	AXbn70lMBsj5D2zrmNh9yDoysU4FCtrdq5X0aE5D6SEwVu2g/6gunLFd2OUuc7UHstXKrS
	I05Uylwb3VwNimOGGIWvTUCrK5Xfq7s=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 96B89634C94;
	Mon,  4 Mar 2024 13:01:38 +0200 (EET)
Date: Mon, 4 Mar 2024 11:01:38 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: Mehdi Djait <mehdi.djait.k@gmail.com>, mchehab@kernel.org,
	heiko@sntech.de, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
	laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait@bootlin.com>
Subject: Re: [RESEND Patch v13 2/3] media: rockchip: Add a driver for
 Rockchip's camera interface
Message-ID: <ZeWqEkcoYN6gXWS9@valkosipuli.retiisi.eu>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <715d89214d1ed6a8bb16cbb6268718a737485560.1707677804.git.mehdi.djait.k@gmail.com>
 <Zctwo3s9hso6mQvT@valkosipuli.retiisi.eu>
 <ZdY5KrTfss4lTjPO@mehdi-archlinux>
 <Zd24MhLYJlSTRysr@valkosipuli.retiisi.eu>
 <ZeMSuihjcS_wXONr@mehdi-archlinux>
 <0e68d986-8834-4586-9525-18ac99a3ce6d@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e68d986-8834-4586-9525-18ac99a3ce6d@wolfvision.net>

Hi Michael, Mehdi,

On Mon, Mar 04, 2024 at 10:25:23AM +0100, Michael Riesch wrote:
> Hi Mehdi, Sakari,
> 
> On 3/2/24 12:51, Mehdi Djait wrote:
> > Hi Sakari,
> > 
> > On Tue, Feb 27, 2024 at 10:23:46AM +0000, Sakari Ailus wrote:
> >> Hi Mehdi,
> >>
> >> On Wed, Feb 21, 2024 at 06:55:54PM +0100, Mehdi Djait wrote:
> >>> Hi Sakari,
> >>>
> >>> Thank you for the review!
> >>>
> >>> On Tue, Feb 13, 2024 at 01:37:39PM +0000, Sakari Ailus wrote:
> >>>> Hi Mahdi,
> >>>>
> >>>> On Sun, Feb 11, 2024 at 08:03:31PM +0100, Mehdi Djait wrote:
> >>>>> From: Mehdi Djait <mehdi.djait@bootlin.com>
> >>>>>
> >>>>> This introduces a V4L2 driver for the Rockchip CIF video capture controller.
> >>>>>
> >>>>> This controller supports multiple parallel interfaces, but for now only the
> >>>>> BT.656 interface could be tested, hence it's the only one that's supported
> >>>>> in the first version of this driver.
> >>>>>
> >>>>> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> >>>>> but for now it's only been tested on the PX30.
> >>>>>
> >>>>> CIF is implemented as a video node-centric driver.
> >>>>>
> >>>>> Most of this driver was written following the BSP driver from Rockchip,
> >>>>> removing the parts that either didn't fit correctly the guidelines, or that
> >>>>> couldn't be tested.
> >>>>>
> >>>>> This basic version doesn't support cropping nor scaling and is only
> >>>>> designed with one SDTV video decoder being attached to it at any time.
> >>>>>
> >>>>> This version uses the "pingpong" mode of the controller, which is a
> >>>>> double-buffering mechanism.
> >>>>>
> >>>>> Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> >>>>> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> >>>>> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> >>>>> ---
> >>>>>  MAINTAINERS                                   |    7 +
> >>>>>  drivers/media/platform/rockchip/Kconfig       |    1 +
> >>>>>  drivers/media/platform/rockchip/Makefile      |    1 +
> >>>>>  drivers/media/platform/rockchip/cif/Kconfig   |   14 +
> >>>>>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
> >>>>>  .../media/platform/rockchip/cif/cif-capture.c | 1111 +++++++++++++++++
> >>>>>  .../media/platform/rockchip/cif/cif-capture.h |   20 +
> >>>>>  .../media/platform/rockchip/cif/cif-common.h  |  128 ++
> >>>>>  drivers/media/platform/rockchip/cif/cif-dev.c |  308 +++++
> >>>>>  .../media/platform/rockchip/cif/cif-regs.h    |  127 ++
> >>>>>  10 files changed, 1720 insertions(+)
> >>>>>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
> >>>>>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
> >>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.c
> >>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.h
> >>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-common.h
> >>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-dev.c
> >>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-regs.h
> >>>>>
> >>>>> +static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
> >>>>> +{
> >>>>> +	struct cif_stream *stream = queue->drv_priv;
> >>>>> +	struct cif_device *cif_dev = stream->cifdev;
> >>>>> +	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
> >>>>> +	struct v4l2_subdev *sd;
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	if (!cif_dev->remote.sd) {
> >>>>> +		ret = -ENODEV;
> >>>>> +		v4l2_err(v4l2_dev, "No remote subdev detected\n");
> >>>>> +		goto destroy_buf;
> >>>>> +	}
> >>>>> +
> >>>>> +	ret = pm_runtime_resume_and_get(cif_dev->dev);
> >>>>> +	if (ret < 0) {
> >>>>> +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
> >>>>> +		goto destroy_buf;
> >>>>> +	}
> >>>>> +
> >>>>> +	sd = cif_dev->remote.sd;
> >>>>> +
> >>>>> +	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
> >>>>
> >>>> You should use the format on the local pad, not get it from a remote
> >>>> sub-device.
> >>>>
> >>>> Link validation ensures they're the same (or at least compatible).
> >>>>
> >>>> Speaking of which---you don't have link_validate callbacks set for the
> >>>> sub-device. See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an
> >>>> example.
> >>>>
> >>>
> >>> ...
> >>>
> >>>>> +	if (!stream->cif_fmt_in)
> >>>>> +		goto runtime_put;
> >>>>> +
> >>>>> +	ret = cif_stream_start(stream);
> >>>>> +	if (ret < 0)
> >>>>> +		goto stop_stream;
> >>>>> +
> >>>>> +	ret = v4l2_subdev_call(sd, video, s_stream, 1);
> >>>>> +	if (ret < 0)
> >>>>> +		goto stop_stream;
> >>>>> +
> >>>>> +	return 0;
> >>>>> +
> >>>>> +stop_stream:
> >>>>> +	cif_stream_stop(stream);
> >>>>> +runtime_put:
> >>>>> +	pm_runtime_put(cif_dev->dev);
> >>>>> +destroy_buf:
> >>>>> +	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
> >>>>> +
> >>>>> +	return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static int cif_set_fmt(struct cif_stream *stream,
> >>>>> +		       struct v4l2_pix_format *pix)
> >>>>> +{
> >>>>> +	struct cif_device *cif_dev = stream->cifdev;
> >>>>> +	struct v4l2_subdev_format sd_fmt;
> >>>>> +	struct cif_output_fmt *fmt;
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	if (vb2_is_streaming(&stream->buf_queue))
> >>>>> +		return -EBUSY;
> >>>>> +
> >>>>> +	fmt = find_output_fmt(stream, pix->pixelformat);
> >>>>> +	if (!fmt)
> >>>>> +		fmt = &out_fmts[0];
> >>>>> +
> >>>>> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> >>>>> +	sd_fmt.pad = 0;
> >>>>> +	sd_fmt.format.width = pix->width;
> >>>>> +	sd_fmt.format.height = pix->height;
> >>>>> +
> >>>>> +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fmt);
> >>>>
> >>>> The user space is responsible for controlling the sensor i.e. you shouldn't
> >>>> call set_fmt sub-device op from this driver.
> >>>>
> >>>> As the driver is MC-enabled, generally the sub-devices act as a control
> >>>> interface and the V4L2 video nodes are a data interface.
> >>>>
> >>>
> >>> While this is true for MC-centric (Media Controller) drivers, this driver is
> >>> video-node-centric (I mentioned this in the commit msg)
> >>>
> >>> From the Kernel Documentation:
> >>> https://docs.kernel.org/userspace-api/media/v4l/open.html
> >>>
> >>> 1 - The devices that are fully controlled via V4L2 device nodes are
> >>> called video-node-centric.
> >>>
> >>> 2- Note: A video-node-centric may still provide media-controller and
> >>> sub-device interfaces as well. However, in that case the media-controller
> >>> and the sub-device interfaces are read-only and just provide information
> >>> about the device. The actual configuration is done via the video nodes.
> >>
> >> Are you sure you even want to do this?
> >>
> >> It'll limit what kind of sensors you can attach to the device and even more
> >> so in the future as we're reworking the sensor APIs to allow better control
> >> of the sensors, using internal pads (that require MC).
> >>
> >> There have been some such drivers in the past but many have been already
> >> converted, or in some cases the newer hardware generation uses MC. Keeping
> >> API compatibility is a requirement so you can't just "add support" later
> >> on.
> > 
> > I totally agree that using the MC approach is better but this has nothing to
> > do with me wanting this but due to constraints I unfortunately cannot control
> > it is impossible to convert it now.
> > 
> > I would say the px30 driver is still very useful and people are going to use it: a follow-up patch series to
> > add support for the Rockchip RK3568 Video Capture has already been sent:
> > https://lore.kernel.org/linux-media/20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net/
> 
> The driver is indeed useful as is, therefore I was rather hoping that it
> would be accepted quickly to facilitate further additions (such as the
> aforementioned RK3568 support series).
> 
> However, I was not aware that the video node centric vs. media
> controller centric approach has significant implications on user space
> and hence on backwards compatibility. Now that Sakari has pointed out
> that one, I am leaning towards converting the driver to MC before it is
> integrated in mainline.
> 
> I fully understand, though, that Mehdi is not in the position to make
> the required changes due to time constraints. Maybe I can fill in and
> invest some time in that, provided that
>  - it is OK for Mehdi and the Bootlin people that I take over the series
>    at hand, leaving the authorship intact of course, but adding my
>    Co-developed-by:
>  - Sakari (or someone else from the linux-media community) can provide a
>    brief overview of what exactly needs to be done to do the conversion
> It should be noted that right now I have no clue what needs to be
> changed, which implies that the conversion will not happen any time soon.

You need to make the driver Media device centric. The V4L2 video nodes will
remain a data interface only. In practice this mostly involves, from the
current driver state, adding a sub-device for CIF device and removing
sensor control via video node. The driver already registers the media
device, that's good

See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an example. There are
probably other minor interface related matters, such as the use of
V4L2_CAP_IO_MC capability flag.

> 
> What do you think?

-- 
Sakari Ailus


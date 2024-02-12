Return-Path: <linux-kernel+bounces-61988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD98519AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B481C20AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80741760;
	Mon, 12 Feb 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="u02bZ6Mz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F473D566;
	Mon, 12 Feb 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755603; cv=none; b=T3ca8x9num26gHFGWBg5G5NhM4YQSMDs5gRaiWYF0Hd/aOtNKPL8smHvgJQ4YUOloJwXoZuz88zXb5UNWnVr32Iio6OmJXBbAuBY6i7FlBOGHmZAatZubu/vm/6fhsl+Uip0tn7Bh0gA/YS7z/oBgcIj6xcCCyNcn8GTLhAQnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755603; c=relaxed/simple;
	bh=B+YBuhuqUOSgESZcvnrhqDgq1djTLds5pMENfQ0P5JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5JB9Xl9rqvroIhv/Jnqmy8M9wfAHx6xdN6L/1KBbc98asdU+B9jtwb1D6jGO/xmafHq/bZC5L9Jxxt0cDuJpOqQXEoq4ZfrtolGvZxv2FVS9IDlJXhbmtRM/kuoMhW73zme7AM4wdim++L3BRTDHbN3pZIDu1b34RpppZ4TwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=u02bZ6Mz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (237.69-130-109.adsl-dyn.isp.belgacom.be [109.130.69.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 41E6263B;
	Mon, 12 Feb 2024 17:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707755598;
	bh=B+YBuhuqUOSgESZcvnrhqDgq1djTLds5pMENfQ0P5JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u02bZ6Mzpx64exzZXhbiJpJ9VclEuCgnoht2HmYeMMN5/jFsrADpIOZLVG/dC7WaZ
	 U/zFQsRUvZYnLwqIIELhzC5XNytWoA16g+tPnM15hL46yHCa0+DJ/BvCiz2shhQxA9
	 Qu63Wn5nr6KFuUE+Mm+phjuPvJZVa9cNHvvuNy7A=
Date: Mon, 12 Feb 2024 18:33:22 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 00/13] Add ISP 3A for StarFive
Message-ID: <20240212163322.GF32016@pendragon.ideasonboard.com>
References: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
 <5940e2cd-64f9-45d6-9e1d-e9a1d14c8ad9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5940e2cd-64f9-45d6-9e1d-e9a1d14c8ad9@gmail.com>

Hi Matthias,

On Mon, Feb 12, 2024 at 01:40:57PM +0100, Matthias Brugger wrote:
> Dear Changhuang,
> 
> On 05/02/2024 10:04, Changhuang Liang wrote:
> > Changhuang Liang (13):
> >    media: starfive: Add JH7110 ISP module definitions
> >    media: Documentation: Add description for StarFive ISP metadata
> >      formats
> >    media: videodev2.h, v4l2-ioctl: Add StarFive ISP meta buffer format
> >    staging: media: starfive: Add a params sink pad and a scd source pad
> >      for ISP
> >    staging: media: starfive: Separate buffer from ISP hardware operation
> >    staging: media: starfive: Separate buffer be a common file
> >    staging: media: starfive: Separate ISP hardware from capture device
> >    staging: media: starfive: Add for StarFive ISP 3A SC
> >    staging: media: starfive: Update ISP initialise config for 3A
> >    staging: media: starfive: Add V4L2_CAP_IO_MC capability
> >    staging: media: starfive: Add ISP params video device
> >    staging: media: starfive: Add ISP parameters hardware configure
> >    admin-guide: media: Update documents for StarFive Camera Subsystem
> 
> I think instead of adding more support on top of the staging driver, the first 
> step would be to get the driver out of staging and make it a regular Linux 
> driver. After that new HW support should be added.

We asked for the driver to be upstreamed in staging first because it was
mising important features, which this patch series implements (at least
partly, I still need to review the series in more details). I would
prefer merging the necessary features first, and destaging the driver
next, right after.

-- 
Regards,

Laurent Pinchart


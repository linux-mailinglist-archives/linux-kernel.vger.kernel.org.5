Return-Path: <linux-kernel+bounces-28363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFC82FD4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1741C24A11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8687767C55;
	Tue, 16 Jan 2024 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NnL9SKcT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391F67C4D;
	Tue, 16 Jan 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705445778; cv=none; b=uXTL6z/QikC6x8rKNIC3V19jWACzebNwJafaRt8ATu5rrwZoyBP04RB6xRWr27IUITlC6tbwEHlU9SSLMBk66rEnuOSJAsImq4LPN2jqGZU3GwoCZpYWw/AvjZ8IUnCK3suzMSfzwhxibGL9iBgM9Pu7tBhIZaDHCn6vdbyXeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705445778; c=relaxed/simple;
	bh=IRwRUQdwBTS2kA8qjwAaxRwBLfowiexvmeyjaSk3fac=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=da1ciGzw0t4IZhtUI4BDtWVOtC70yBFGU7i9Sc6peViB3eHPoZNsUw/WQ3ERXC1Y7YMGh69mVwxxnlqxWtQpW5YDURf4rnAcGrfBwkXzY7XNQW3yD0bH3jmZOG0DlbRDZqWVtGa2dFD3XtPv8iVQqtb0rfhN9BwA83g0Ac6fe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NnL9SKcT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5940BB2A;
	Tue, 16 Jan 2024 23:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705445705;
	bh=IRwRUQdwBTS2kA8qjwAaxRwBLfowiexvmeyjaSk3fac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnL9SKcTkKobGkyR4WrheJwAIF15Z4nZEsqjsFLRxFWVxBUKsxefLH5JFUzkPGQgt
	 4HvyShIWtSuWBFIDB5IWl2PiUl9+LS3H6H19sop54T90O9ZvHdfi/0HaxT7vVpYgNj
	 nu6PPj81LJq5XhAMDtsqoCSPbB5dESMZa2f3qK2M=
Date: Wed, 17 Jan 2024 00:56:18 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Vinay Varma <varmavinaym@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"open list:SONY IMX219 SENSOR DRIVER" <linux-media@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: imx219: implement the v4l2 selection api
Message-ID: <20240116225618.GA4860@pendragon.ideasonboard.com>
References: <kv6yfyahbud474e75y4jaczg64pcowvlz7i52kikknuh6wje5o@4k2hikwcueoy>
 <ZZu2C_lu6TAh-LOf@kekkonen.localdomain>
 <3q6andka2su7i43xz2ok44ejvtb3hdjdn6xretyde7sdcvtd7l@lz2syngckivi>
 <ZabUh0ozhQq-GtEC@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZabUh0ozhQq-GtEC@kekkonen.localdomain>

Hello,

On Tue, Jan 16, 2024 at 07:09:59PM +0000, Sakari Ailus wrote:
> On Mon, Jan 08, 2024 at 10:19:35AM +0100, Jacopo Mondi wrote:
> > Hi Sakari, Vinay,
> > 
> >    a more foundamental question is how this usage of the crop/compose
> > API plays with the fact we enumerate only a limited set of frame
> > sizes, and now you can get an arbitrary output size. We could get away
> > by modifying enum_frame_sizes to return a size range (or ranges) but I
> > wonder if it wouldn't be better to introduce an internal pad to
> > represent the pixel array where to apply TGT_CROP in combination with
> > a source pad where we could apply TGT_COMPOSE and an output format.

I'm working on patches that implement an internal image pad, as part of
the work to add embedded data support. I hope to post this in the near
future.

> My earlier review wasn't focussed on the interface at all...
> 
> To depart from the current restrictions on single-subdev sensor drivers,
> this is one option.
> 
> Sensors implement various steps in different orders and different drivers
> have different capabilities, too. Mainly there are two classes: freely
> configurable drivers such cas CCS and then register list based drivers
> where virtually any dependencies between configurations are possible.
> 
> We probably can't support both classes with the same API semantics and due
> to hardware differencies. The sensor UAPI will be less than uniform it has
> been in the past but I don't think this should be an issue.
> 
> I wonder how much common understanding we have at this point on how this
> API would look like. Probably not much?

-- 
Regards,

Laurent Pinchart


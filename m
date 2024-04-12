Return-Path: <linux-kernel+bounces-142422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47398A2B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F651C20C72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0854E51C4D;
	Fri, 12 Apr 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oyc966U6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC511446B6;
	Fri, 12 Apr 2024 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914742; cv=none; b=TRp4a/8TKGuvU9xljHiVZgHBp6qBBAuhRK2uaU1X31sMqS/okGflYIqmqUi7U0cRzRSJplrSzhQL/ngyBmW8yKpMQrrBI6o3coa3MRPpUiSYE2ryBNp5ISKIFGpZphLDcmX8NEj9yPD+xtqE5MjKOXuvz8is87s6CQSUeTR6LLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914742; c=relaxed/simple;
	bh=xhZLSdqjCJGkrq/1WHroNk1xCdiol0gprEN4wXQPrlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8V/RWzuTUETQYMMEc9Ol0Mw1RVF9ThKLyey0PNqEhUr7Zyx9jVPx4cr2x71McZ5qq2VvKFFWoxrXbvAUDnjrONjuaIwsD9NvQTpcTf1Lj44MlEsjzbIPUCAn4HJVNDEJtKNo2u6S+DGkF6RA2/ffHEYu0d5YPaAyKC7qGesP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oyc966U6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712914741; x=1744450741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhZLSdqjCJGkrq/1WHroNk1xCdiol0gprEN4wXQPrlU=;
  b=Oyc966U6AQSKPXz8WeHsn8245G4djhYxi2VH5JA6pqriz/6kragD1Pul
   MR8UIRYJKr5WlRtJvH+DCpblOhx8phlltOPOKfyxZ+cs8P+zzLG5Iox2F
   dVyMibwEeW5bpSUpelx3bVz8IHL9myFJCI1XazHAz2ctrtFaxSNPuntFt
   YSD0jdA/h1fZ7pjHGR/AbftfKpIdOcUG+ffi+xADANXq0ubkrVnD6pxOQ
   2Na9B9RFM9/06KfFxX+qp/GHFKliUE9Nx05J4WVKL1i5bpinR9mcGDEid
   iBQYuzWOcM6jBvDd18boDuaVTmGk7ogHkHsVMfWjZlgACFtsWVqq85PA7
   A==;
X-CSE-ConnectionGUID: 1NobwrQ+SCuf3UOQvonNDw==
X-CSE-MsgGUID: z0g6NxYJQ5ax2PUGnINwIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12148183"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="12148183"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 02:39:00 -0700
X-CSE-ConnectionGUID: TEnw0//TQtG62goI0XrVyw==
X-CSE-MsgGUID: XWlRxbLtQnW4iW48NYWBHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25988920"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 02:38:53 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 304D911FA58;
	Fri, 12 Apr 2024 12:38:51 +0300 (EEST)
Date: Fri, 12 Apr 2024 09:38:51 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com,
	yaya.chang@mediatek.com, yunkec@chromium.org, 10572168@qq.com
Subject: Re: [PATCH 2/2] media: i2c: Add GT97xx VCM driver
Message-ID: <ZhkBIee2X0UY40yD@kekkonen.localdomain>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
 <20240410104002.1197-3-zhi.mao@mediatek.com>
 <CAHp75VfF0pbrKXjWZg7sTr-T=_CbjP+deFQP-VLCGX8ooahctg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfF0pbrKXjWZg7sTr-T=_CbjP+deFQP-VLCGX8ooahctg@mail.gmail.com>

Hi Andy, Zhi,

On Wed, Apr 10, 2024 at 07:00:02PM +0300, Andy Shevchenko wrote:
> > +static int gt97xx_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> > +{
> > +       return pm_runtime_resume_and_get(sd->dev);
> > +}
> > +
> > +static int gt97xx_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> > +{
> > +       return pm_runtime_put(sd->dev);
> > +}
> 
> Hmm... Shouldn't v4l2 take care about these (PM calls)?

Ideally yes. We don't have a good mechanism for this at the moment as the
lens isn't part of the image pipeline. Non-data links may be used for this
in the future but that's not implemented yet.

-- 
Regards,

Sakari Ailus


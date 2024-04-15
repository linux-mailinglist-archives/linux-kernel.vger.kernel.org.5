Return-Path: <linux-kernel+bounces-144666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76868A48F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AE51F23C62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F61C23763;
	Mon, 15 Apr 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KY5qXEOL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD971E504;
	Mon, 15 Apr 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165953; cv=none; b=Jfk+2FJMhczbgrIh3EWoXrf/AFH5Ppeu00oLCvB10InA9lTF5Vj0vd9XB4sGAW4eMa9QFm4Lc5NhCIPJxIFxBzby93xkaszVHO3Xv95j0xgzLooXL7NlYqvWWNeqpZO/jIRAMDZT5bxidwAjprFEAMSWcqDhKm9EGVdFjAZWgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165953; c=relaxed/simple;
	bh=OqnLGYrmxL1r//qeEKxNpcsT5ecBncxRH0T2KE36LVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIchOBya7hJyLZKabzRyGjwZ9NbHWJv9AHFa3b9UcXev7Otcu+/rT6T4NfMDwZEwWdgrGlQ5/3MveWwfkACR3KKsJduePIGWNHI1ZxTHS9Em7GNOLaGBpVvFiYbInU9yxFe0OrbOpCIYNe4T4Kp0zfI9re1YOdNkh//XK5PXoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KY5qXEOL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713165952; x=1744701952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OqnLGYrmxL1r//qeEKxNpcsT5ecBncxRH0T2KE36LVA=;
  b=KY5qXEOL+4ifkhpS2rSLmkLJxCqvUAAr3iRaUUM6f9H+zETli7g69HbA
   Tn+9e7xmegczYNRqMJfH/lmfjMXGHGUVFSXDEm73LF02CAsO+Gkwvcowy
   vPIQO1Osq/H78r8ph1G7FIyO/ng3Whk3ol1+qzno84j3lQ6N9WX7EeFFq
   ESNIq2IN48bozMEVVefKhWnm3+MwP3K76W1zeJPnwDH/uCp/Pq5v98+EK
   OSUzUigxsm/AKMt9p8uzVF7C1KXLKEYzaSwCBw+TWwZJi9YUseKP7LYh6
   M6z6mtvdXls8/1zbkXnOIoHOKVZukEjedOqgNgCLi99y/raKzA0WyUd4Z
   Q==;
X-CSE-ConnectionGUID: +0f9SbWITayVNE27OyHvMA==
X-CSE-MsgGUID: qZGR78GhRoeFSf1RK4KGGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12327836"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12327836"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:25:51 -0700
X-CSE-ConnectionGUID: hNZHFNF7Stac7Np65aHCjQ==
X-CSE-MsgGUID: GHaQ/P5ASKWRbx+yYAx0zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26628608"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:25:45 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 56B1311F8AF;
	Mon, 15 Apr 2024 10:25:42 +0300 (EEST)
Date: Mon, 15 Apr 2024 07:25:42 +0000
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
Message-ID: <ZhzWdmg8cc1tgtNc@kekkonen.localdomain>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
 <20240410104002.1197-3-zhi.mao@mediatek.com>
 <CAHp75VfF0pbrKXjWZg7sTr-T=_CbjP+deFQP-VLCGX8ooahctg@mail.gmail.com>
 <ZhkBIee2X0UY40yD@kekkonen.localdomain>
 <CAHp75VcKFCvzcESqsc8OQ5SVuO4gJiE5ZEUwkdoqvLzM=2PejQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcKFCvzcESqsc8OQ5SVuO4gJiE5ZEUwkdoqvLzM=2PejQ@mail.gmail.com>

Hi Andy,

On Fri, Apr 12, 2024 at 04:43:43PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 12, 2024 at 12:39 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > On Wed, Apr 10, 2024 at 07:00:02PM +0300, Andy Shevchenko wrote:
> > > > +static int gt97xx_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> > > > +{
> > > > +       return pm_runtime_resume_and_get(sd->dev);
> > > > +}
> > > > +
> > > > +static int gt97xx_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> > > > +{
> > > > +       return pm_runtime_put(sd->dev);
> > > > +}
> > >
> > > Hmm... Shouldn't v4l2 take care about these (PM calls)?
> >
> > Ideally yes. We don't have a good mechanism for this at the moment as the
> > lens isn't part of the image pipeline. Non-data links may be used for this
> > in the future but that's not implemented yet.
> 
> Aren't you using devlinks? It was designed exactly to make sure that
> the PM chain of calls goes in the correct order.

Device links are already used by the IPU bridge, but in the other
direction: the VCM requires the sensor to be powered up in this case.

-- 
Regards,

Sakari Ailus


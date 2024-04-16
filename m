Return-Path: <linux-kernel+bounces-146366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C78A644F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567361F21A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61607FBC6;
	Tue, 16 Apr 2024 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foDHY4IF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC56E5FD;
	Tue, 16 Apr 2024 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250046; cv=none; b=cbTd2BEU2NiQedwViuY2J9Mht4AUHZZaQF4RJu10Em4y+H/T+lys70KOn3cZkzp6oTkScJKV4nbZWG5kcGksiPiKt+WAfQZts2V2PHcJ3Y/eaIKawey8i/NHGYHT7lakoF669lD/bIuMME/u2d8I+FACH5citWx3upnA01rUbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250046; c=relaxed/simple;
	bh=qm9HuIqIHiV0TwCjlaPOkidq7z2qTqokgjceTJw5hJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAAYBiVk3NYX+NTuPodStEIZrkr/r4lehETHZffmNSQqa4dnu2nstIjJydQSuIEg1NK4H5Bq3z7GuGBZJeWhTMBqkkAwLEeVKwmzLI1YZQN67/18dgSHTTCYmSPX+8BbG9e4qVllh1ilCbFtFspSnsgG9gQUFENk2tmEYDdQiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foDHY4IF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713250044; x=1744786044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qm9HuIqIHiV0TwCjlaPOkidq7z2qTqokgjceTJw5hJI=;
  b=foDHY4IFXTrALYFPiDDSemGUTvs7Ldtv96gZeIRFwYQ4u4I1OzgVaEPP
   4ApkpGuhrXpmO2447PMtpF8I1JbsNrH+HhWAEGUhbo052R3FD1YtYLm3W
   u1NwugnSZMKgHFZOX3MJ59G+pBbaBllqJCEyVgk/AOqs0ijww1e8gGkB6
   OE9sKdMDY6Ueqir9xpNG5+UDXH/Tp6wub5JoacUG4+xwgCtdXOqFzO3mo
   oFNXyPSJZfeV/13PlgO2bPorX7Woo6bp+4tcijBE4fGbkLuaoDkUs65ai
   rbM8df8cOdL7rZU4dp8MDtqIerXIQ2YkxxPwo0y94XK37L/ceCHUn0X2k
   w==;
X-CSE-ConnectionGUID: 5G7Sa+wdTxmKIz1fqFbu4A==
X-CSE-MsgGUID: OsEHOtp2TqaRvmQdTli1HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8779795"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8779795"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:47:24 -0700
X-CSE-ConnectionGUID: vpnYdRu+TgO5tYhKGtu/qQ==
X-CSE-MsgGUID: HUe4Q++7TnmFR2np7DFglg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26939988"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:47:21 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 55C0111FAB0;
	Tue, 16 Apr 2024 09:47:18 +0300 (EEST)
Date: Tue, 16 Apr 2024 06:47:18 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v4 17/20] media: i2c: ov4689: Configurable analogue crop
Message-ID: <Zh4e9q_RFIe-JIzz@kekkonen.localdomain>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
 <20240402164552.19171-18-mike.rudenko@gmail.com>
 <ZhzEdXz-R2I6nZXf@kekkonen.localdomain>
 <87ttk274e6.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttk274e6.fsf@gmail.com>

On Mon, Apr 15, 2024 at 11:22:09PM +0300, Mikhail Rudenko wrote:
> 
> Hi Sakari,
> 
> On 2024-04-15 at 06:08 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > Hi Mikhail,
> >
> > On Tue, Apr 02, 2024 at 07:45:48PM +0300, Mikhail Rudenko wrote:
> >> Implement configurable analogue crop via .set_selection call.
> >> ov4689_init_cfg is modified to initialize default subdev selection.
> >> Offsets are aligned to 2 to preserve Bayer order, selection width is
> >> aligned to 4 and height to 2 to meet hardware requirements.
> >>
> >> Experimentally discovered values of the cropping-related registers and
> >> vfifo_read_start for various output sizes are used. Default BLC anchor
> >> positions are used for the default analogue crop, scaling down
> >> proportionally for the smaller crop sizes.
> >>
> >> When analogue crop is adjusted, several consequential actions take
> >> place: the output format is reset, exposure/vblank/hblank control
> >> ranges and default values are adjusted accordingly. Additionally,
> >> ov4689_set_ctrl utilizes pad crop instead of cur_mode width and
> >> height for HTS and VTS calculation. Also, ov4689_enum_frame_sizes is
> >> modified to report crop size as available frame size.
> >
> > We're amidst of a change to the APIs touching sensors with the the
> > introduction of the internal pads.
> > <URL:https://lore.kernel.org/linux-media/20240313072516.241106-1-sakari.ailus@linux.intel.com/T/#t>.
> >
> > I'd therefore postpone this bit so it would align with the new practices
> > (also subject to change in the metadata set).
> >
> > The rest of the patches would seem more or less ready for merging to me.
> 
> Okay, so I'll post a v5 of patches 1-16 with whitespace fixes (as you
> suggested in patch 20) soon, and the remaining patches affected by the
> metadata-related API changes as a separate series as soon those changes
> land in media_stage. Do I get you right?

Yes, please.

-- 
Sakari Ailus


Return-Path: <linux-kernel+bounces-50158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED3847508
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73871F2B7E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512E1487FF;
	Fri,  2 Feb 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLDMYY3q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BD14830B;
	Fri,  2 Feb 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891882; cv=none; b=oK8JSf1qr1ASWciFHRp0hTk8qXSDzHrKxFkqegzUr1myfF6KLV4qQR+7RxzMXzVTO2KMfusOd5WJ9Bft+ioUNgCrJW6Th3LsM51P1F7tKJWDrwjKho1iu33wtshNwuNdqWvgP2kV7dmWQR/MHXwfsfWKlSNGEj7/H1NW4Flbxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891882; c=relaxed/simple;
	bh=DI+vowAp6HxEMoicKFi0dBorFyKWjCm9wzepkmTNs34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYTrOVQ+0B5ukyzMsUBdXn3MNleMK0e+V09t72LLKYvg+eYUCXNPLL6Dke9pdhX2sR8bB3vK2sdlxy1WZwP3OODujWav3QgiZgNeJK+AACcdqx9+5AyPoH/eZgAJNDe7jf3sWTN6dImF+TvNlvLD7oziUtaKyFylSQYN86aCnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLDMYY3q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706891882; x=1738427882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DI+vowAp6HxEMoicKFi0dBorFyKWjCm9wzepkmTNs34=;
  b=HLDMYY3qW9KfFYTZxPLMbqIFj+jvdrbRnmE5dZrYcgpAqc7ZAuOL2cm+
   LYMJ37m8JQlaRbr1CX2fdQKWy9OdkG57G+N8W3Ig9WEEdhsrl8TMb7dkd
   apPEVCQKpPQuzcxoR+m/1lxgzq8o/n15m0RggQBmMHDN2psDgKeNVevHZ
   8IveClGH4QyZfi8p5HdlBU/yhFOYt19GJq6fwwyWC/GWOlHHEJeF56/Oy
   WyOhE9KIFEo8XtCm4ggCyswY0CRTXC/Mt13ck1XZas9g2no4PqGHIxEcU
   rUvvRef4Ldmgs+5qxTBS84fJSd7GpVSZEyCpxp1Bxhfoyap5QLfB0Clkb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="354999"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="354999"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823251802"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823251802"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 02 Feb 2024 08:37:53 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 02 Feb 2024 18:37:52 +0200
Date: Fri, 2 Feb 2024 18:37:52 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <Zb0aYAapkxQ2kopt@intel.com>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
X-Patchwork-Hint: comment

On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrjälä wrote:
> > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > >  /**
> > > > > >   * DOC: HDMI connector properties
> > > > > >   *
> > > > > > + * Broadcast RGB
> > > > > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > > > > + *      Infoframes will be generated according to that value.
> > > > > > + *
> > > > > > + *      The value of this property can be one of the following:
> > > > > > + *
> > > > > > + *      Automatic:
> > > > > > + *              RGB Range is selected automatically based on the mode
> > > > > > + *              according to the HDMI specifications.
> > > > > > + *
> > > > > > + *      Full:
> > > > > > + *              Full RGB Range is forced.
> > > > > > + *
> > > > > > + *      Limited 16:235:
> > > > > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > > > > + *              this works for any number of bits-per-component.
> > > > > > + *
> > > > > > + *      Drivers can set up this property by calling
> > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > + *
> > > > > 
> > > > > This is a good time to document this in more detail. There might be two
> > > > > different things being affected:
> > > > > 
> > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > 2. The color pipeline processing
> > > > > 
> > > > > All values of Broadcast RGB always affect the color pipeline processing
> > > > > such that a full-range input to the CRTC is converted to either full- or
> > > > > limited-range, depending on what the monitor is supposed to accept.
> > > > > 
> > > > > When automatic is selected, does that mean that there is no signalling,
> > > > > or that the signalling matches what the monitor is supposed to accept
> > > > > according to the spec? Also, is this really HDMI specific?
> > > > > 
> > > > > When full or limited is selected and the monitor doesn't support the
> > > > > signalling, what happens?
> > > > 
> > > > Forgot to mention: user-space still has no control over RGB vs YCbCr on
> > > > the cable, so is this only affecting RGB? If not, how does it affect
> > > > YCbCr?
> > > 
> > > So I dug a bit into both the i915 and vc4 drivers, and it looks like if
> > > we're using a YCbCr format, i915 will always use a limited range while
> > > vc4 will follow the value of the property.
> > 
> > The property is literally called "Broadcast *RGB*".
> > That should explain why it's only affecting RGB.
> 
> Right. And the limited range option is called "Limited 16:235" despite
> being usable on bpc > 8 bits. Naming errors occurs, and history happens
> to make names inconsistent too, that's fine and not an argument in
> itself.
> 
> > Full range YCbCr is a much rarer beast so we've never bothered
> > to enable it.
> 
> vc4 supports it.

Someone implemented it incorrectly then.

> 
> > Eg. with DP it only became possible with the introduction of the VSC
> > SDP (and I don't recall if there's additional capability checks that
> > are also required). With DP MSA signalling full range YCbCr is not
> > possible at all.
> 
> This is for HDMI only.
> 
> > I don't recall right now what the HDMI requirements are.
> 
> HDMI has supported it for a while, and it's defined (for example) in the
> HDMI 1.4 spec in Section 6.6 - Video Quantization Ranges. It supports
> limited and full range on both RGB and YCbCr, as long as the EDIDs state
> so and the Infoframes signal it.

I think a good reason for not using a simple boolean like this 
YCbCr is that it doesn't cover the color encoding part at all,
which is probably more important than the quantization range.
So we need a new property anyway.

-- 
Ville Syrjälä
Intel


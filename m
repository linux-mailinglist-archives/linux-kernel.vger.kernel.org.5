Return-Path: <linux-kernel+bounces-161898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42A88B52F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212771C20D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF3171B0;
	Mon, 29 Apr 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="i1bTl/hz"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F16EAE5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378681; cv=none; b=dOXRbLOzKqK+wcWO7btWfZQ1Ks9EEX4y1lElXqksXB5ZfpRCwa1SFRS7N+/Sk1WECmw4iVRdXnZwlP8knNMb/30qhVbodRId9qq2EwjMRjbGZESfcuE4CTL7bkEZPqQXS4/O7rq/w2g7hK4fPM9xiwv2NzqIjwkzkI8woOOcDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378681; c=relaxed/simple;
	bh=A5x73xMVXifBQldh+pFXSQHgUAYimgqBJOZHwxhNbfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZzR+RGQMlPH1xXswe/yKRLY6nJhnFLZUG2lDR6WV0fEx3Ph2riDZDmTJ0hT+obWerl07VvYnzMj+Gys7I6Q0yR/E2GIZ5fq2vTyFKgIir3czIxVgxSzs3zcp2G8qfyklJEX+O8uTdX7JZxfjkoO6FVHtRh7FjTe+n5MBbEZ17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=i1bTl/hz; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=qOH6rUKw03bYbHURcR2tw2iTp/UFU+PE0TGB9GL0+A0=; b=i1bTl/
	hzU7YEUpk67a0CO1xq8fRzf4238DJyWZcUo4jK1lQ2wV98xBhXJHp6Za4xEURIjFsv/IbVJGbls2k
	zqIURChqL6L79qHK9plksvHc9Wh0PTJdDfJSTNcg4mnn2QojKaYTo7f/dDN1WBzysqFERHiHKTByl
	4sCPOqEicXAgG7to1LdRgyUyo1r7ufGi21dpMMCAsRurzyseVh5CrAqOH1HVg20Q7OfogcqzVWIW4
	e4ArVoSwEz01+piN9Lu3mniUY7S9lGDxpEaRolSWSyY85Y7D5tI2amunWqoJ6bqK36c/j6ZWVUtgR
	YY7+85mMbiGvGU3Q/B24yCVeGxtg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1s1MCp-000MfJ-51; Mon, 29 Apr 2024 10:17:47 +0200
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1s1MCo-000MjY-0K;
	Mon, 29 Apr 2024 10:17:46 +0200
Date: Mon, 29 Apr 2024 10:17:45 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Robert Foss <rfoss@kernel.org>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/stm: dsi: relax mode_valid clock tolerance
Message-ID: <cvzecixldubeq7pwn77cggs7tcwc5on3arlnboj4fbpqgdygtu@hat3r6afzu7y>
References: <20240322104732.2327060-1-sean@geanix.com>
 <20240424-famous-fascinating-hyena-8fb3a7@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424-famous-fascinating-hyena-8fb3a7@houat>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27259/Sun Apr 28 10:22:36 2024)

Hi,

On Wed, Apr 24, 2024 at 09:21:17AM UTC, Maxime Ripard wrote:
> Hi,
> 
> Sorry, my previous review didn't go through.
> 
> On Fri, Mar 22, 2024 at 11:47:31AM +0100, Sean Nyekjaer wrote:
> > When using the DSI interface via DSI2LVDS bridge, it seems a bit harsh
> > to reguire the requested and the actual px clock to be within
> > 50Hz. A typical LVDS display requires the px clock to be within +-10%.
> > 
> > In case for HDMI .5% tolerance is required.
> > 
> > Fixes: e01356d18273 ("drm/stm: dsi: provide the implementation of mode_valid()")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > index d5f8c923d7bc..97936b0ef702 100644
> > --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > @@ -322,8 +322,6 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
> >  	return 0;
> >  }
> >  
> > -#define CLK_TOLERANCE_HZ 50
> > -
> >  static enum drm_mode_status
> >  dw_mipi_dsi_stm_mode_valid(void *priv_data,
> >  			   const struct drm_display_mode *mode,
> > @@ -375,9 +373,10 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
> >  		/*
> >  		 * Filter modes according to the clock value, particularly useful for
> >  		 * hdmi modes that require precise pixel clocks.
> > +		 * Check that px_clock is within .5% tolerance.
> >  		 */
> > -		if (px_clock_hz < target_px_clock_hz - CLK_TOLERANCE_HZ ||
> > -		    px_clock_hz > target_px_clock_hz + CLK_TOLERANCE_HZ)
> > +		if (px_clock_hz < mult_frac(target_px_clock_hz, 995, 1000) ||
> > +		    px_clock_hz > mult_frac(target_px_clock_hz, 1005, 1000))
> >  			return MODE_CLOCK_RANGE;
> 
> I wonder if it's not something that should be made into a helper. We
> have a couple of drivers doing it already, so it might be worth creating
> a function that checks for a given struct clk pointer and pixel clock if
> it's within parameters.
> 
> Maxime

Yes agree, if the same calculation is happening other places.
I can't identify where it happens though.

Would that helper function exist in drivers/gpu/drm/drm_hdmi_helper.c ?

I will give the implementation a shot.

/Sean


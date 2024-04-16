Return-Path: <linux-kernel+bounces-146905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E98A6CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DEC1C210AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C55A12CDAF;
	Tue, 16 Apr 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnEZ9Ww7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6212C7FB;
	Tue, 16 Apr 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275069; cv=none; b=hTODmIRRJTA0hFwErqompjKuNwbZTaz4pIUtICxs+VWXMXkuf7PTnPTMDtHH5t7/yoQU6tV8WfT5uAHgFBsrhD40M4G8AAnZwe9a7hNwHaO/M4jnsbKORgI3CSMKTow28sg6snMAjrDT3qO404D8EmGhAwK/4+cm943VwsRgjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275069; c=relaxed/simple;
	bh=yIT1Hq1Q+QFvhkrUGnRLbVn2bvPzGMAzhArPVhVcvS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTF/jLQSoagCGmHCEeJxqo96URRyb1K3lcgnIcH2P0NJi1JWqfJiWPy69gfydI5qF04RBKeeMhfyMAfZzh9gy5qByYmPwnuCeUcoVSR0jft9LZHKTKIKMzszfWSKwjdvrkq7BYzDfYhgGnx+MzJeA5YvCZXRWpxJ0lrEY9RgzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnEZ9Ww7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713275067; x=1744811067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yIT1Hq1Q+QFvhkrUGnRLbVn2bvPzGMAzhArPVhVcvS4=;
  b=dnEZ9Ww7byrw/ooxpfYc3KaclMCfbp7m+MQ3x0tHkp74OGJVbfpH6IqR
   WP/dYGWNQoy90HnQ2EiZj76Fu27nlcS+eJjqyFMECIvZ3wa3mnCuuCTNo
   liYh7OuTA3m7M7qyChUGOWvWGrb0xobj/PKXs2EB8c4bbSyqZ2FD+Vggf
   KvOIGz4XeazO+1fK7Zq5MXiMIunL+mGKkXYY1IsWQmpLcB90JQOX1++PE
   stT7eayy2u/pRWLtTCPM6xN5ShQQK4LRUgdLICQn5O0jYT4hCXY9Sb0ON
   HC6Icmbn4QgcOTkR9AINWVVvzy3tQWdSmnvcJmhASxPGl668Nq/RLIpAt
   A==;
X-CSE-ConnectionGUID: duIRvNvxQBWOlCMvFRm0Sw==
X-CSE-MsgGUID: YlW5INnFSbOzJOgN/o+9vQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8823866"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8823866"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 06:44:26 -0700
X-CSE-ConnectionGUID: 6KgPAxkdTZi56IQwb7BkxQ==
X-CSE-MsgGUID: 8H3eU6/hQGW/35RqtA+D7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22330276"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 16 Apr 2024 06:44:15 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 16 Apr 2024 16:44:14 +0300
Date: Tue, 16 Apr 2024 16:44:14 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sebastian Wick <sebastian.wick@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v11 09/28] drm/display: hdmi: Add HDMI compute clock
 helper
Message-ID: <Zh6Ars8z1ESz-LQO@intel.com>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
 <20240326-kms-hdmi-connector-state-v11-9-c5680ffcf261@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326-kms-hdmi-connector-state-v11-9-c5680ffcf261@kernel.org>
X-Patchwork-Hint: comment

On Tue, Mar 26, 2024 at 04:40:13PM +0100, Maxime Ripard wrote:
> A lot of HDMI drivers have some variation of the formula to calculate
> the TMDS character rate from a mode, but few of them actually take all
> parameters into account.
> 
> Let's create a helper to provide that rate taking all parameters into
> account.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_helper.c | 70 +++++++++++++++++++++++++++++++
>  include/drm/display/drm_hdmi_helper.h     |  4 ++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
> index faf5e9efa7d3..2518dd1a07e7 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> @@ -193,5 +193,75 @@ void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
>  	}
>  
>  	frame->itc = conn_state->content_type != DRM_MODE_CONTENT_TYPE_NO_DATA;
>  }
>  EXPORT_SYMBOL(drm_hdmi_avi_infoframe_content_type);
> +
> +/**
> + * drm_hdmi_compute_mode_clock() - Computes the TMDS Character Rate
> + * @mode: Display mode to compute the clock for
> + * @bpc: Bits per character
> + * @fmt: Output Pixel Format used
> + *
> + * Returns the TMDS Character Rate for a given mode, bpc count and output format.
> + *
> + * RETURNS:
> + * The TMDS Character Rate, in Hertz, or 0 on error.

Everything generally uses kHz. Sticking to common units
would be better.

> + */
> +unsigned long long
> +drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> +			    unsigned int bpc, enum hdmi_colorspace fmt)
> +{
> +	unsigned long long clock = mode->clock * 1000ULL;
> +	unsigned int vic = drm_match_cea_mode(mode);
> +
> +	/*
> +	 * CTA-861-G Spec, section 5.4 - Color Coding and Quantization
> +	 * mandates that VIC 1 always uses 8 bpc.
> +	 */
> +	if (vic == 1 && bpc != 8)
> +		return 0;
> +
> +	/*
> +	 * HDMI 2.0 Spec, section 7.1 - YCbCr 4:2:0 Pixel Encoding
> +	 * specifies that YUV420 encoding is only available for those
> +	 * VICs.
> +	 */
> +	if (fmt == HDMI_COLORSPACE_YUV420 &&
> +	    !(vic == 96 || vic == 97 || vic == 101 ||
> +	      vic == 102 || vic == 106 || vic == 107))
> +		return 0;

I believe that is already outdated. I would just rip this out since the 
sink is anyway required to declare for which timings it will support
4:2:0 via the Y420CMDB/VDB data blocks (see
drm_mode_is_420_{only,also}().

> +
> +	if (fmt == HDMI_COLORSPACE_YUV422) {
> +		/*
> +		 * HDMI 1.4b Spec, section 6.2.3 - Pixel Encoding Requirements
> +		 * specifies that YUV422 is 36-bit only.
> +		 */
> +		if (bpc != 12)
> +			return 0;
> +
> +		/*
> +		 * HDMI 1.0 Spec, section 6.5 - Pixel Encoding
> +		 * specifies that YUV422 requires two 12-bits components per
> +		 * pixel clock, which is equivalent in our calculation to three
> +		 * 8-bits components
> +		 */
> +		bpc = 8;
> +	}
> +
> +	/*
> +	 * HDMI 2.0 Spec, Section 7.1 - YCbCr 4:2:0 Pixel Encoding
> +	 * specifies that YUV420 encoding is carried at a TMDS Character Rate
> +	 * equal to half the pixel clock rate.
> +	 */
> +	if (fmt == HDMI_COLORSPACE_YUV420)
> +		clock = clock / 2;
> +
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
> +		clock = clock * 2;
> +
> +	clock = clock * bpc;
> +	do_div(clock, 8);

IMO one shouldn't use bare do_div(). There are
more sensible wrappers for it.

In this case I would use DIV_ROUND_CLOSEST_ULL().

Although the 64bit math is not even required if you
just stick to kHz like everyone else.

> +
> +	return clock;
> +}
> +EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
> index 76d234826e22..57e3b18c15ec 100644
> --- a/include/drm/display/drm_hdmi_helper.h
> +++ b/include/drm/display/drm_hdmi_helper.h
> @@ -22,6 +22,10 @@ drm_hdmi_infoframe_set_hdr_metadata(struct hdmi_drm_infoframe *frame,
>  				    const struct drm_connector_state *conn_state);
>  
>  void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
>  					 const struct drm_connector_state *conn_state);
>  
> +unsigned long long
> +drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> +			    unsigned int bpc, enum hdmi_colorspace fmt);
> +
>  #endif
> 
> -- 
> 2.44.0

-- 
Ville Syrjälä
Intel


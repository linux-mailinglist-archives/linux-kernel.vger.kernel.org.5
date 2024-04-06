Return-Path: <linux-kernel+bounces-133943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807489AB42
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013351F21A03
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73863770C;
	Sat,  6 Apr 2024 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="XI7Hmtt2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t8gRcORh"
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFC3714C;
	Sat,  6 Apr 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412251; cv=none; b=FPabuC718aI+Nu2BB17sZoPgHfk9RIhg7mwQhtOw2Vu3mGuaors8Qdiv876yUFxDYz13f0nvxRCbW4YF3sLSK93YX5EK0mCvX90eRhCJ3jl/4fuLv8VsTC54R0qPq5uncuKGdOVaaTLb6xciDz1H4i+MYF/eNuYec/6l+wWStxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412251; c=relaxed/simple;
	bh=3GMEDOspjGEnx9tQo6f8nKMvFoIm2A8BD4lJ9jAtlaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LppkUWiqFnOW1/Q4vEZeulDyUoOUrS3yVGnywWnw9f5sIHSN5keiddQXwVjjL2GwAAcDRtg9wNJt0qf+3s9lyGuasINeGI8hka2iuggQJATmk2ureNbBvxLobFwjsV5KH4exQjXpLzefZkmkNJr58rOiX1Gtpu5QSsGrT7Nhrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=XI7Hmtt2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t8gRcORh; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id B516D20043D;
	Sat,  6 Apr 2024 10:04:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 06 Apr 2024 10:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712412247;
	 x=1712415847; bh=1M5WlcAIuxUkkwrN7ouvw0OLceBGIcQz5A2HvoNVA5w=; b=
	XI7Hmtt2hJkqZ6YcB8vccJrkELeKGGzoIOE9yEIiIke3Z5PlbVMWBg2ySTI5pOR6
	wNFWGNzgBsTDKAGzVdK1n99+xZP7dQNMJULVo/1JGV9riCNXwXHV6A0FuLzZtFgp
	qD+EXZnpGTHySnZjL42AugLhrb0JLI6jjoFSFQPZfyMdFEGyp6tlEno3AnETU4rF
	Co12sxP699iMs5YDNTJhtptBnFO27q7aiXgon/vaFrD3OGBHjozUZAV+xm0dTCqc
	pdbzf55/iK0fD1qedot+OwIhYTaUK41zMi3JPeyfKCwBXB+nK30AqlhuFxE8EH4q
	+Ab6UjVt94vvNrUcAP27EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712412247; x=
	1712415847; bh=1M5WlcAIuxUkkwrN7ouvw0OLceBGIcQz5A2HvoNVA5w=; b=t
	8gRcORhOnRa4V7F2W4qj9xcWeLYcv/V3v5x+mJ2ETFJkEdDQbPuMSbnfTiqNJKSL
	mLHketyAtxNum1LvaSZ4TsxpdYlpL+Q5stiaYxwp5ic0VjiQCgupX5LSjz3oiW6X
	6MAN06AvUqREMOu0P/+l6j/k+vEqMmaQl0QSYr9EHWowrhcTZ8sKA43lH0J9NLLB
	6on7Md3USl4mX1nVPsfgfoDiTwP57RscYVkt7caMqRaa/IOhi5QVdZlvDzKBVktg
	v7B/9kEJn/u7SYPfCYlsQ/iqGbUgp4ovU1vpIzQAguL9uouon0YvXMkOTKWif+sn
	8lPhIUBaa85hiZolnKRdw==
X-ME-Sender: <xms:V1YRZryj3xBkbi8nTLeB6cZrozHP_I3-GO24AtiZ1az3N7xBB7Kg4w>
    <xme:V1YRZjS7mV1ZbPuwVwEmFjNjl0inev1uiMKtKqVwy00QzpF-5W-w5t3sUzrDP5Tnl
    f8itg5mbINdpKBYavw>
X-ME-Received: <xmr:V1YRZlXF9ZuyK9nNNgFqrhDSj2LDC2V6fbaLvFRWI6wKogTxwGYXXcq6BrjhZMus4CHKvQto4VaU_t6SIFwaxvdtpki4_tU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrgh
    hnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeef
    heetheekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgr
    ghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:V1YRZljPLhxglnhf6Bf-R17USPaj7Q4uF0V39KxCGkSqQ9FoU9iJ1Q>
    <xmx:V1YRZtAcm78li_cDyvHPlCmQ7iFHzWdo-4gOsNG8USeFucmqQbU-uQ>
    <xmx:V1YRZuLAlGERNy4SfrA-L49xiEqpqYU00oNArC2i5pl9ERaXgqqTyA>
    <xmx:V1YRZsC9lnAhoITqzw6uuLHiu5DYFn_dp0TfVyA0kTcM7kWahdI2Ww>
    <xmx:V1YRZh6ubWWkLKHUeMDFLhRlRXs5U-tdCWBVeRVH4jnDJSPb-HlQ5l1e>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Apr 2024 10:04:06 -0400 (EDT)
Date: Sat, 6 Apr 2024 16:04:05 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, tharvey@gateworks.com,
	prabhakar.csengg@gmail.com, charles-antoine.couret@nexvision.fr,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	skomatineni@nvidia.com, luca.ceresoli@bootlin.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	chromeos-krk-upstreaming@google.com
Subject: Re: [PATCH 02/16] media: i2c: adv748x: Switch dv timing callbacks to
 pad ops
Message-ID: <20240406140405.GC2024639@ragnatech.se>
References: <20240405141411.1807189-1-panikiel@google.com>
 <20240405141411.1807189-3-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405141411.1807189-3-panikiel@google.com>

Hi Paweł,

Thanks for your work.

On 2024-04-05 14:13:57 +0000, Paweł Anikiel wrote:
> Change all (s|g|query)_dv_timings subdev callbacks to include
> a pad argument.
> 
> Signed-off-by: Paweł Anikiel <panikiel@google.com>

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/i2c/adv748x/adv748x-hdmi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/adv748x/adv748x-hdmi.c
> index ec151dc69c23..a4db9bae5f79 100644
> --- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
> +++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
> @@ -214,7 +214,7 @@ static int adv748x_hdmi_set_video_timings(struct adv748x_state *state,
>   * v4l2_subdev_video_ops
>   */
>  
> -static int adv748x_hdmi_s_dv_timings(struct v4l2_subdev *sd,
> +static int adv748x_hdmi_s_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
>  				     struct v4l2_dv_timings *timings)
>  {
>  	struct adv748x_hdmi *hdmi = adv748x_sd_to_hdmi(sd);
> @@ -254,7 +254,7 @@ static int adv748x_hdmi_s_dv_timings(struct v4l2_subdev *sd,
>  	return ret;
>  }
>  
> -static int adv748x_hdmi_g_dv_timings(struct v4l2_subdev *sd,
> +static int adv748x_hdmi_g_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
>  				     struct v4l2_dv_timings *timings)
>  {
>  	struct adv748x_hdmi *hdmi = adv748x_sd_to_hdmi(sd);
> @@ -269,7 +269,7 @@ static int adv748x_hdmi_g_dv_timings(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> -static int adv748x_hdmi_query_dv_timings(struct v4l2_subdev *sd,
> +static int adv748x_hdmi_query_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
>  					 struct v4l2_dv_timings *timings)
>  {
>  	struct adv748x_hdmi *hdmi = adv748x_sd_to_hdmi(sd);
> @@ -392,9 +392,6 @@ static int adv748x_hdmi_g_pixelaspect(struct v4l2_subdev *sd,
>  }
>  
>  static const struct v4l2_subdev_video_ops adv748x_video_ops_hdmi = {
> -	.s_dv_timings = adv748x_hdmi_s_dv_timings,
> -	.g_dv_timings = adv748x_hdmi_g_dv_timings,
> -	.query_dv_timings = adv748x_hdmi_query_dv_timings,
>  	.g_input_status = adv748x_hdmi_g_input_status,
>  	.s_stream = adv748x_hdmi_s_stream,
>  	.g_pixelaspect = adv748x_hdmi_g_pixelaspect,
> @@ -413,7 +410,7 @@ static int adv748x_hdmi_propagate_pixelrate(struct adv748x_hdmi *hdmi)
>  	if (!tx)
>  		return -ENOLINK;
>  
> -	adv748x_hdmi_query_dv_timings(&hdmi->sd, &timings);
> +	adv748x_hdmi_query_dv_timings(&hdmi->sd, 0, &timings);
>  
>  	return adv748x_csi2_set_pixelrate(tx, timings.bt.pixelclock);
>  }
> @@ -610,6 +607,9 @@ static const struct v4l2_subdev_pad_ops adv748x_pad_ops_hdmi = {
>  	.get_fmt = adv748x_hdmi_get_format,
>  	.get_edid = adv748x_hdmi_get_edid,
>  	.set_edid = adv748x_hdmi_set_edid,
> +	.s_dv_timings = adv748x_hdmi_s_dv_timings,
> +	.g_dv_timings = adv748x_hdmi_g_dv_timings,
> +	.query_dv_timings = adv748x_hdmi_query_dv_timings,
>  	.dv_timings_cap = adv748x_hdmi_dv_timings_cap,
>  	.enum_dv_timings = adv748x_hdmi_enum_dv_timings,
>  };
> @@ -734,7 +734,7 @@ int adv748x_hdmi_init(struct adv748x_hdmi *hdmi)
>  	struct v4l2_dv_timings cea1280x720 = V4L2_DV_BT_CEA_1280X720P30;
>  	int ret;
>  
> -	adv748x_hdmi_s_dv_timings(&hdmi->sd, &cea1280x720);
> +	adv748x_hdmi_s_dv_timings(&hdmi->sd, 0, &cea1280x720);
>  
>  	/* Initialise a default 16:9 aspect ratio */
>  	hdmi->aspect_ratio.numerator = 16;
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

-- 
Kind Regards,
Niklas Söderlund


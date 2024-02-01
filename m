Return-Path: <linux-kernel+bounces-48613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBFD845ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AE1C22AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619B7C6D9;
	Thu,  1 Feb 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IT+5QloK"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958B7C6C3;
	Thu,  1 Feb 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809604; cv=none; b=HKVb3H7HQhqO4StzFrAXWY0W28sVNeXrPJGZ/g4IYHI4WPYlAVh0sWedZh2nzHIpb4fd7Xkg/23lkCU6Kf/qwueGBcZYXFKneYrK54n/pZK8EiYTvN0Ws5Qx1K+0/Lmj+MXcOUolgPWeA6KsAVdTDvt+ZP0ihZBfdld0rmGPUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809604; c=relaxed/simple;
	bh=eeBtSFHjOvovJvizQTkE8r6Y6KQdJcg3niSkzZyYvq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIx0tmHJhnET+9tQ5qgAvDixvzMQTfB1/eW/UTWsXaOI2iHx9n6NHAlDf422en5bOAtobaHQ3z6VDEOrxWC+ZIyIDcadYcJSXutVQZYxPXB1Qk73JL98uiSJyRodEquxFMD/eAUmyocL47w9zbY7WzitHoJJnQ25sfpE3ZVpB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IT+5QloK; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72D8CFF80B;
	Thu,  1 Feb 2024 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706809600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJtHDJMAIjYne+Wpy9ELnPjDgsMPZsdJCj8jeRX7IKg=;
	b=IT+5QloK6fRzRQzJ7Awhi5KYa2C9GPYm90MnqIe+7bFDpi0c2iyVZceRq3+RstzDdI57ad
	gJcmAcqRyq0Hzwh7XwomXLmj/yaVfcxllmitLR7N8jiL7KxRDZOeBK+z6kqpAqFn2WaJi6
	spadqeijE59+618+ToghWPZwzD7v4KZY5IXjifRY9YBpb8Ll4JXjA7u6ZSAZBXaEz3t0hN
	Ze/wS8Y15xfY3HNgrp+3uOAkoTCgMSVdf5jewuQmX11E4GLtbCPpt9G4Mm5G1jZpqDqq6N
	7e7dkMVPVU0cmM2OW67iQj7Hc4uMLFBUZ7l/yP7HjdDfbjOlKkw8ZLSveDRbOg==
Date: Thu, 1 Feb 2024 18:46:37 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 6/7] drm/vkms: Drop YUV formats TODO
Message-ID: <ZbvY_bqvpLFXVXKF@localhost.localdomain>
Mail-Followup-To: Arthur Grillo <arthurgrillo@riseup.net>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
References: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
 <20240110-vkms-yuv-v2-6-952fcaa5a193@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110-vkms-yuv-v2-6-952fcaa5a193@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 10/01/24 - 14:44, Arthur Grillo a écrit :
> VKMS has support for YUV formats now. Remove the task from the TODO
> list.
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  Documentation/gpu/vkms.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index ba04ac7c2167..13b866c3617c 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -122,8 +122,7 @@ There's lots of plane features we could add support for:
>  
>  - Scaling.
>  
> -- Additional buffer formats, especially YUV formats for video like NV12.
> -  Low/high bpp RGB formats would also be interesting.
> +- Additional buffer formats. Low/high bpp RGB formats would be interesting.
>  
>  - Async updates (currently only possible on cursor plane using the legacy
>    cursor api).
> 
> -- 
> 2.43.0
> 

(Sorry Arthur for the double mail, I miss the reply-all in the previous 
mail)

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>


Return-Path: <linux-kernel+bounces-151493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234F8AAF97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB228478A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0212BE93;
	Fri, 19 Apr 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="P5wnIWlP"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014612A151
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534131; cv=none; b=cOqzdhpsPSEyVRlkY0NJwVL6evQh6GjQidfP1RY6ewkaSYf9LGZi9GIKmzQWZmjRmet6Px7qffebm75El+a5XvJ8M2FiAly0CkecqgacOUKD4JFkKHLtb7dekwQIiSbVk9DDjLwk3eXVUpXaIlSNfzNxpNiDzlMzCo+T3R0ftaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534131; c=relaxed/simple;
	bh=m+aW3ZV1GbE1e9yfgDFlcGvNARGgqlrucJS6VWZSudI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za8zTRXppOYxsI3xdiHUm0eYr2cnrs1OVrwLLNOPfcMjVA9oxKkA2Oi2Qobp2DQXjNdAeK+9+IMaoTtsaBwl7LzWdFWQ5ETVp9DpKyAuCGcO8yz2lsB9aYrcd3EkUZu2qLv3Nu211SytnoYpPqE25FNnYQ622q6xIMefu9P7Nto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=P5wnIWlP; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1713533777; bh=m+aW3ZV1GbE1e9yfgDFlcGvNARGgqlrucJS6VWZSudI=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=P5wnIWlPxezCqS2wvKd6KcgnwYxU+XsjnFt1xIkJTx20A17TE15EBcLuNpCOoDYTg
	 emXzPzvLZcjc6Xsxsz7PDpNeXjd2K7Umcx+vH7JxALRvh9aTEY9SA5u8qu+mh959mq
	 HcUbOxybGwzDSnFgggrKIbiola9mUZSyr2J8ISbc=
Date: Fri, 19 Apr 2024 15:36:17 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/3] Move blender setup from individual planes to crtc
 commit in sun4i-drm
Message-ID: <wynuwtyn2skchb7gc5qixql2pxnb2nqvbmrda6s53u7nt5ki7n@hqb46kttkhee>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240224150604.3855534-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240224150604.3855534-1-megi@xff.cz>

Hi,

On Sat, Feb 24, 2024 at 04:05:57PM GMT, megi xff wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> This series refactors blender setup from individual planes to a common
> place where it can be performed at once and is easier to reason about.
> 
> In the process this fixes a few bugs that allowed blender pipes to be
> disabled while corresponding DRM planes were requested to be enabled.
> 
> Please take a look. :)
> 
> v2:
> - use regmap_write where possible
> - add review tags

It would be nice to have this applied.

Kind regards,
	o.

> Thank you very much,
> 	Ondřej Jirman
> 
> Ondrej Jirman (3):
>   drm/sun4i: Unify sun8i_*_layer structs
>   drm/sun4i: Add more parameters to sunxi_engine commit callback
>   drm/sun4i: Fix layer zpos change/atomic modesetting
> 
>  drivers/gpu/drm/sun4i/sun4i_backend.c  |  4 +-
>  drivers/gpu/drm/sun4i/sun4i_crtc.c     |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 70 ++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun8i_mixer.h    | 20 ++++++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 85 +++----------------------
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.h | 20 ++----
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 86 +++-----------------------
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 20 ++----
>  drivers/gpu/drm/sun4i/sunxi_engine.h   | 13 +++-
>  9 files changed, 125 insertions(+), 195 deletions(-)
> 
> -- 
> 2.44.0
> 


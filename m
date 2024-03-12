Return-Path: <linux-kernel+bounces-100752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F3879CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F209E1C21890
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83171428F9;
	Tue, 12 Mar 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CRUkd854"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426967E104
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274599; cv=none; b=LWCL9znszmytFraowBZyIc6A3Es9FzsmpGHKLCSYrQYb2a8bO7oFOzB96CH2KtdxnkkBvncyoe8/BuaIuUz3XjI992XwXgm2oAEYJSm4NZupUCZBqyLPSbfYlQ8LuQisj79t+Er2YfXJ7JX0s7HlSz1Wo2steCYob6xrj0uAsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274599; c=relaxed/simple;
	bh=+e8AniSaQWLlkyHKk8x3jYF5zupwMoaIeiUhEeWHoi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPtHt4Rrk0lttzRPNZMVJWaq5QjCz+rfBcwmz76fBSXIpY4EpDoadcbvBAbGRt+eNFZmEDizG2iqaPBDQdC9q0pjN3tdE2V6QHQawX2GYHtzFSPwX+Q6A3w5Tor8KGNs95COcADVi4ZwN8mRGtdwm4bn7TDK6AMZNFqEekpibbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CRUkd854; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=icJZII2NzZ8YTpuhYylAOUy/6nsXY8cVerNtIDwM3N0=; b=CRUkd854ft2j4bz3Ta5s9wxdpW
	KZuvLszbFxDwC1rbr1BFT8JX1mnOL+WEVb+YD6QUy7MYhqPzIMUxjR75lAEYMoi5qzKwkzhjUgHww
	d6hPK0z/ufuR8dR32hsPazYwRrvbrJ3fs/Kw8WpviryU1FfXaTrp8dnKSbAvNm0bVhAxE0hg0JSPf
	1Ioz89EYCUK2NEkWLuHL4xNEJkBXUVy13nyhw34zdpL8U5XfKUyjZuZh8y+pfp3n2cBD6C9NxxinN
	xqivvzWOMTQEY9UXoz6lFRPSOvk6zfXPSbRynlYziCP4Cu0P93xCZP9+ohaqe9juLchDaIgfecLue
	ggVquWyg==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rk8Xk-009VhK-IL; Tue, 12 Mar 2024 21:16:13 +0100
Date: Tue, 12 Mar 2024 17:16:01 -0300
From: Melissa Wen <mwen@igalia.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
	Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH 6/7] drm/vkms: Change the gray RGB representation
Message-ID: <4jvdfkfnqsn6dcuybruyvexop5du4sd6mmmjvtmeso5kyg4sdi@klimifhnenqm>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <20240306-louis-vkms-conv-v1-6-5bfe7d129fdd@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-louis-vkms-conv-v1-6-5bfe7d129fdd@riseup.net>

On 03/06, Arthur Grillo wrote:
> Using the drm_fixed calls, this needs to be changed. Which in fact is
> more correct, colour.YCbCr_to_RGB() gives 0x8080 for same the yuv
> parameters.

Hi Arthur,

For consistency, shouldn't this change be together with the previous
patch that uses the drm_fixed api? I mean, a single patch that changes
to drm_fixed calls and adjust the color values accordingly, avoiding
room for mismatches?

Melissa
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> index 66cdd83c3d25..49125cf76eb5 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -48,7 +48,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>  		.n_colors = 6,
>  		.colors = {
>  			{"white", {0xff, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
> -			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
> +			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
>  			{"black", {0x00, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
>  			{"red",   {0x4c, 0x55, 0xff}, {0xffff, 0xffff, 0x0000, 0x0000}},
>  			{"green", {0x96, 0x2c, 0x15}, {0xffff, 0x0000, 0xffff, 0x0000}},
> @@ -71,7 +71,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>  		.n_colors = 6,
>  		.colors = {
>  			{"white", {0xeb, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
> -			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
> +			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
>  			{"black", {0x10, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
>  			{"red",   {0x51, 0x5a, 0xf0}, {0xffff, 0xffff, 0x0000, 0x0000}},
>  			{"green", {0x91, 0x36, 0x22}, {0xffff, 0x0000, 0xffff, 0x0000}},
> @@ -94,7 +94,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>  		.n_colors = 4,
>  		.colors = {
>  			{"white", {0xff, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
> -			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
> +			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
>  			{"black", {0x00, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
>  			{"red",   {0x36, 0x63, 0xff}, {0xffff, 0xffff, 0x0000, 0x0000}},
>  			{"green", {0xb6, 0x1e, 0x0c}, {0xffff, 0x0000, 0xffff, 0x0000}},
> @@ -117,7 +117,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>  		.n_colors = 4,
>  		.colors = {
>  			{"white", {0xeb, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
> -			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
> +			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
>  			{"black", {0x10, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
>  			{"red",   {0x3f, 0x66, 0xf0}, {0xffff, 0xffff, 0x0000, 0x0000}},
>  			{"green", {0xad, 0x2a, 0x1a}, {0xffff, 0x0000, 0xffff, 0x0000}},
> @@ -140,7 +140,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>  		.n_colors = 4,
>  		.colors = {
>  			{"white", {0xff, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
> -			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
> +			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
>  			{"black", {0x00, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
>  			{"red",   {0x43, 0x5c, 0xff}, {0xffff, 0xffff, 0x0000, 0x0000}},
>  			{"green", {0xad, 0x24, 0x0b}, {0xffff, 0x0000, 0xffff, 0x0000}},
> @@ -163,7 +163,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
>  		.n_colors = 4,
>  		.colors = {
>  			{"white", {0xeb, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
> -			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
> +			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
>  			{"black", {0x10, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
>  			{"red",   {0x4a, 0x61, 0xf0}, {0xffff, 0xffff, 0x0000, 0x0000}},
>  			{"green", {0xa4, 0x2f, 0x19}, {0xffff, 0x0000, 0xffff, 0x0000}},
> 
> -- 
> 2.43.0
> 


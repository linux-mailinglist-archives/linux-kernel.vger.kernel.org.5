Return-Path: <linux-kernel+bounces-125120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43389212C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADDAB26101
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6251DA37;
	Fri, 29 Mar 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="x5tk8xFW"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670B12B6C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725476; cv=none; b=NmMqtHtI5eSwqkEnNahsArfJmAZlNNVLC/4O6r4X9WgZ1FAPy4VoPD3E6wTJj7+4HIRvdna/mxqqBfHiASf3T30NdeMggvg/4eiAo48TIGzcSMffvp7Mc4Up7Uf4LIA1sc4cR5tfwho+EkY0rxdFvnxzR4tGUCK5aXdhpPKe3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725476; c=relaxed/simple;
	bh=kyo1Ad43BuOTHxWe5GQYqSLm6b3RV5mvNXTMTY5jNjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbbaIALoQbjMnwkW6Cr3nuJfSZbwzqNao1fflzr6eceX5/6Ujvb/p7WVdy81Rbu5dQ0uQZH6JJpjWfjD9fUjbICMgkBWIVTCJYFyUY7Dap2dc9otyvJ4wQhOcjEKimsb92ZUbN5LHxFrYAcLHZdldd+sRcTZX0rMSkHaAnRcg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=x5tk8xFW; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
Received: from [192.168.0.100] (dslb-088-068-075-039.088.068.pools.vodafone-ip.de [88.68.75.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 8B44860613;
	Fri, 29 Mar 2024 16:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1711724885;
	bh=kyo1Ad43BuOTHxWe5GQYqSLm6b3RV5mvNXTMTY5jNjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x5tk8xFWVOxpyM+tom2a5qJURqK5k0iyba7xZAEMqnkyGvMfgGDyGa9ChvkzpFn1C
	 tcB4hxgfFnjd485lw27m/yCQunGjkFRbUgGQxRhuOA5LNJyAV6S0pFoZEv7CTtFshz
	 wJvDuTziUK57qnqPHv74qZ/xtiYX69tJfHiimJVGB9YRmA7Ud6R/aECmr2UWcjhVNJ
	 4pD6+DD0vgz7h/d34lUqFIUk+NuAd82f7M1P0CfUePc0tuBwFb/WhBg/74BTA2Ni2o
	 WCLMHWmXkzhqLwfDuSRM/JqCewrHHSiBqgzT8lRkUCQg+IjoHpg8m94W+OBAHzi/Zs
	 STFzgRCaWDIRw==
Message-ID: <ced3a1dc-4e09-467a-a8f8-0747f707b68f@math.uni-bielefeld.de>
Date: Fri, 29 Mar 2024 16:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add MSF panel to DPCD 0x317 patch list
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240309014732.722139-1-tjakobi@math.uni-bielefeld.de>
Content-Language: en-US
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; keydata=
 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
 JRHWPGCL3BhOxQ==
In-Reply-To: <20240309014732.722139-1-tjakobi@math.uni-bielefeld.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/9/24 02:47, tjakobi@math.uni-bielefeld.de wrote:

> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> This 8.4 inch panel is integrated in the Ayaneo Kun handheld
> device. The panel resolution is 2560×1600, i.e. it has
> portrait dimensions.
>
> Decoding the EDID shows:
> Manufacturer: MSF
> Model: 4099
> Display Product Name: 'TV080WUM-NL0 '
>
> Judging from the product name this might be a clone of a
> BOE panel, but with larger dimensions.
>
> Panel frequently shows non-functional backlight control. Adding
> some debug prints to update_connector_ext_caps() shows that
> something the OLED bit of ext_caps is set, and then the driver
> assumes that backlight is controlled via AUX.
>
> Forcing backlight control to PWM via amdgpu.backlight=0 restores
> backlight operation.
>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 7a09a72e182f..5a017ba94e3c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -68,6 +68,7 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
>   	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
>   	case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
>   	case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
> +	case drm_edid_encode_panel_id('M', 'S', 'F', 0x1003):
>   		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
>   		edid_caps->panel_patch.remove_sink_ext_caps = true;
>   		break;
Gentle ping...



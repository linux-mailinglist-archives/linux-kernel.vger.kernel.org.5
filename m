Return-Path: <linux-kernel+bounces-108485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7109A880B19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37994B22470
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC617BDA;
	Wed, 20 Mar 2024 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Aa9VgBo5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC88179B7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915255; cv=none; b=GYf/ujmQz28sfQbpZ1no5/rgQSqNV3Lfadx+YmVVT73t0BUat7Ff7yoo1mIj4Dg88UH7YV3zLU4g0mvrz8SbhI9A8X5bNZWmKMbcrAFIkJD09OqMbHzhEfUhiP8n3FS4YfA8K2KvVnJjQLDhuz5g5er3VeVQ1Dfk6ZFtY660Gxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915255; c=relaxed/simple;
	bh=snOyPHld+qgFruG1hDUnAYVoP1xl95J5yKDm39XL5Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5hELZWJWV5x/DKYc9KajAZgKxZ/ZCsRpE+M6yX808+6q7j9dIFc9aWdvQaOo8lIq0F5hegjvCrOLgOx9BOPRXPKzZ5c/REns1hjJaUrmUtDkkdbumFAVMQ9seGAc8h65QWoPOYGu4ONCS4qKn56lgvHFYv0a9PDP2zblpYjkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Aa9VgBo5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 16D353F1;
	Wed, 20 Mar 2024 07:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710915224;
	bh=snOyPHld+qgFruG1hDUnAYVoP1xl95J5yKDm39XL5Kg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aa9VgBo5kgJXZbZS8oWTc0Rdeu+GwUcp1l/Wy3A6cccUgR4rZBEDRT+0Q8/Hud/SJ
	 FmfwGh+Tbc4+0IOESvXIle8Qz5uinbqQ/BA4Lsv4x6TbYQuHgw/wguHz0CTQQWVuPo
	 mZxEXZbX9kr9yaI5Y9hYW3FAJSIIYu25/xR/jiwY=
Message-ID: <0fdbb6e4-6be8-4a21-8cf3-2a419b4b44ed@ideasonboard.com>
Date: Wed, 20 Mar 2024 08:14:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm: zynqmp_dp: Rearrange zynqmp_dp for better
 padding
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
 <20240319225122.3048400-5-sean.anderson@linux.dev>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240319225122.3048400-5-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2024 00:51, Sean Anderson wrote:
> Sort the members of struct zynqmp_dp to reduce padding necessary for
> alignment.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - New
> 
>   drivers/gpu/drm/xlnx/zynqmp_dp.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 8635b5673386..f1834c8e3c02 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -255,10 +255,10 @@ struct zynqmp_dp_link_config {
>    * @fmt: format identifier string
>    */
>   struct zynqmp_dp_mode {
> -	u8 bw_code;
> -	u8 lane_cnt;
> -	int pclock;
>   	const char *fmt;
> +	int pclock;
> +	u8 bw_code;
> +	u8 lane_cnt;
>   };
>   
>   /**
> @@ -295,27 +295,27 @@ struct zynqmp_dp_config {
>    * @train_set: set of training data
>    */
>   struct zynqmp_dp {
> +	struct drm_dp_aux aux;
> +	struct drm_bridge bridge;
> +	struct delayed_work hpd_work;
> +
> +	struct drm_bridge *next_bridge;
>   	struct device *dev;
>   	struct zynqmp_dpsub *dpsub;
>   	void __iomem *iomem;
>   	struct reset_control *reset;
> -	int irq;
> -
> -	struct drm_bridge bridge;
> -	struct drm_bridge *next_bridge;
> -
> -	struct zynqmp_dp_config config;
> -	struct drm_dp_aux aux;
>   	struct phy *phy[ZYNQMP_DP_MAX_LANES];
> -	u8 num_lanes;
> -	struct delayed_work hpd_work;
> +
>   	enum drm_connector_status status;
> +	int irq;
>   	bool enabled;
>   
> -	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> -	struct zynqmp_dp_link_config link_config;
>   	struct zynqmp_dp_mode mode;
> +	struct zynqmp_dp_link_config link_config;
> +	struct zynqmp_dp_config config;
> +	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>   	u8 train_set[ZYNQMP_DP_MAX_LANES];
> +	u8 num_lanes;
>   };
>   
>   static inline struct zynqmp_dp *bridge_to_dp(struct drm_bridge *bridge)

If you change the order of the fields, you should change the order in 
the kernel doc accordingly.

To be honest, I'm not sure if I like this patch. We have usually one 
instance of these structs allocated. How many bytes do we save?

I'm fine with getting easy savings by changing the field order in some 
cases, but I think the "human" side of the order is important too: 
usually the fields are grouped in some way, and ordered so that the more 
base or generic ones are first, and fields for some specific feature are 
later. And fields protected by a lock should be grouped together, with 
their lock being first/last in that group.

Looking at the zynqmp_dp struct with this patch, I get an urge to start 
moving things around: dev, dpsub, iomem, etc first, hpd somewhere later. 
Base config fields like config, num_lanes, irq would be grouped 
together. Etc.

  Tomi



Return-Path: <linux-kernel+bounces-102643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2EE87B538
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C37C1C21179
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BF25D74E;
	Wed, 13 Mar 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZlnC1hRU"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F15D72F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372880; cv=none; b=LkXHsk2LF7Ji6e2XJjKyuZdxR7xdptVLS5rQxn1M4vOpacVTMhdaaHdXyr27jF4inRYJcRv3rIDjy/wLJ6mJ7AOwvwouxSpS9lcxrEjnpk92IQNPdD96EQ1rM+JAQ+EEVi+7Ssw83Aa5yHUwWY+DrXygVhOrcrmg+z5VXOHRFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372880; c=relaxed/simple;
	bh=mk/0nw43f/X5dq41JsZS2ZjvqVj6m4MuDsowqHXmhBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuznOrvf0i/KJSWWzIJA532tM4Yp0E+i62K8jz/kKx9berRmb+l8NRzRN2tchERKCL36fqCjnWmhdpl9utAErRnUS6rWZXgKWIpE3pk1SomDoxqbGEUccT/oflLkG/ionchnHyIM0f2Gs8n4DdCn5wyzct87E9EhO79WT4RLb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZlnC1hRU; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b1c71bd-10fb-4177-bacf-44ce77ae1c52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710372875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXQaEFsum6OMqBMgCJr/1CyC37B3P/uDQXWPsVF6tQE=;
	b=ZlnC1hRUo5KNFY1GdEQxvESkKLLFy9LfseRTKgurcQl5VqEAS6NqtJ23muCOZCtFNcVyx5
	Hgz0dsyvNEqIn/lPi6JC0iuMzOy4GDuZcbBmtjPssNR0X6rvxpZJS+dxntt0oAuAjRY2GK
	kVFTgeWNsYzTiABktxLawoErr4pl6mI=
Date: Thu, 14 Mar 2024 07:34:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v9,01/27] drm/connector: Introduce an HDMI connector
 initialization function
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20240311-kms-hdmi-connector-state-v9-1-d45890323344@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240311-kms-hdmi-connector-state-v9-1-d45890323344@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/11 22:49, Maxime Ripard wrote:
> A lot of the various HDMI drivers duplicate some logic that depends on
> the HDMI spec itself and not really a particular hardware
> implementation.
>
> Output BPC or format selection, infoframe generation are good examples
> of such areas.
>
> This creates a lot of boilerplate, with a lot of variations, which makes
> it hard for userspace to rely on, and makes it difficult to get it right
> for drivers.
>
> In the next patches, we'll add a lot of infrastructure around the
> drm_connector and drm_connector_state structures, which will allow to
> abstract away the duplicated logic. This infrastructure comes with a few
> requirements though, and thus we need a new initialization function.
>
> Hopefully, this will make drivers simpler to handle, and their behaviour
> more consistent.
>
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>


Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>

-- 
Best regards,
Sui



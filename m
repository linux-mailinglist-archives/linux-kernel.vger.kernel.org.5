Return-Path: <linux-kernel+bounces-102657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF287B56D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0BCB20FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47AA5F870;
	Wed, 13 Mar 2024 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bvX/By1g"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D55E09B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374078; cv=none; b=RjcQ3tBx/IawiYxqQxPn4uE0a5v5oeKMAdEb+E9YAZEgOzzzUBnCIM11WzhlZ0k95RSEcJg1HMmbQRmC4KuXP4Y6OlxgC/gEIj70rozTtoQTOxmUIEtcqKU1jmgh//ENR6ix6uKCdDfG6q1hDw6koiis+xXMii2dpFZbOd+VZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374078; c=relaxed/simple;
	bh=agsMjUee/f3mka2P9D+cfgrCYVLTGyQ1fDgitr3d64k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4xDYtML0kI9cJirwFjU2XjsfGBmp30OHFjX5avCLFb8+Fo8E7FCWgDlgPeRIMjud8TWcafpypGpuryO/RaVdaBXYobq+xI5fJyKR2aG6ov5tkoluyBuGDlI/aokThGorbXEXX9wSUzyR9SZphB6Nv43EGTZr/JS/Y8nMM7mQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bvX/By1g; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22f5c178-5c7b-4971-a93c-020913decfa0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710374074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKbcUpCMjFnZRisiSg2oV2LxlfIvDrhVcsFE8vaadrE=;
	b=bvX/By1gaQjqJ3GwgA2ebPhlrc8TYjpI9pXhYZbFTtAg0b5O3cvI0IsH+y+wV50DwNbn9n
	lZUhWobGPAWNrR/IqL8/tK6QK2S2+Ws/VZRF9C/+9CTHqWftoAMwckKhqpwOnLEhMMBd5Q
	p+oRXN01WLRuJ8tPvZ5Ukyvuj0oj934=
Date: Thu, 14 Mar 2024 07:54:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v9,23/27] drm/vc4: hdmi: Switch to HDMI connector
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
 linux-sunxi@lists.linux.dev
References: <20240311-kms-hdmi-connector-state-v9-23-d45890323344@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240311-kms-hdmi-connector-state-v9-23-d45890323344@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


LGTM,


On 2024/3/11 22:49, Maxime Ripard wrote:
> The new HDMI connector infrastructure allows us to remove a lot of
> boilerplate, so let's switch to it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>


Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>


-- 
Best regards,
Sui



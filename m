Return-Path: <linux-kernel+bounces-111368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B4886B53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B44F2812B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1F43F9C2;
	Fri, 22 Mar 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="okH1hJuq"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8663EA71
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107247; cv=none; b=lW/NnsYbA0GJjg5fwSz52aTGPqt3MmH7Ngh0eccNOnIjbhQRE62VjaOJsr03N/5+RlSA4Y8hW0f5zHrDu6LV3VU0LiB7WMeV8ikh+yEwR9AW/U++DvoEBNOwChUjNGJKQ2q2cZygl5f+3A5P5Wl+8tZYLwBQS1T+A93uvrUs9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107247; c=relaxed/simple;
	bh=EDLSzvHWzWJckccgae9InvdeABzJhvqCfI6ieGm1XfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cItyCMWGfI+rB/Rv21qz1B9yVNusjIQc5DdjArJyYC9QAi5rAeftaCPPH7ohW2VvOC4sAKDdB6h/Q4g+XibXDYRtm34kfbRfFRNfGvxduu732QZDNpO15/NayMWWvbslNC85zg6vS/lO32UV51BC068dvs6NpJ8is8Q6wIHGZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=okH1hJuq; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3140f17b-f7b4-4705-877f-df2c0af460d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711107243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t678LVHSCoxay4XYSJ0VwadhX/XRd8hTe6DYJoC6mOo=;
	b=okH1hJuq01MrIEXSupw5A53MiUW/2sSEI/CQAe86vH5rhfU/RMX0OWgs5aFfX1JjGmV2GW
	SLYsrw6Wch8TknYz3eqO+exU46APFpUXiNS0KqhsZ8WqnLI/kjuUBetNm2TSieVCaO4XK3
	p0X42SIwucnQ0gwKMSL3lOtd9lGMAVM=
Date: Fri, 22 Mar 2024 19:33:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [next] drm/gma500: Fix spelling mistake "patter" -> "pattern"
To: Colin Ian King <colin.i.king@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314163511.2372458-1-colin.i.king@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240314163511.2372458-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/15 00:35, Colin Ian King wrote:
> There is a spelling mistake in a DRM_DEBUG_KMS message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>


Reviewed-by:Sui Jingfeng <sui.jingfeng@linux.dev>

-- 
Best regards,
Sui



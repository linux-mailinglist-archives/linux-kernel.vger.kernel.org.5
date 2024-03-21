Return-Path: <linux-kernel+bounces-110763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85959886358
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D991C2227A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED71860;
	Thu, 21 Mar 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L9TjzxIn"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAAD1C33
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060377; cv=none; b=OdBxqM7oWzFaQKZDWMeO4o1iK5Nhkb/A4agtP+eTuhM+P1MP9eKGedjwtCUHPYK6hPrd5t2vcvJBE57FPQifC5znS3TK3g+GQXd6u7bG2cCVXCEr8t2GcY2Wi8eDzw8iHyh+KMFK+IPqumLiMw11SzEgrvJ+MlX0EOVu2M73Pxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060377; c=relaxed/simple;
	bh=LDByoXQP6mgfnNEdlwk8vFKwzCc7LziPCgnb5onUzqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=au4D2N7waWaVpngahEDQp5dVnjhvpmJSNHgbZJOcacC7KGaiOnj/g0Ex/q6NUrkMYDsjtxs63dshq06EErsI1kfsTTQr1Sk0TVwhuXYfhZ5t++hhlEC8XPTtpJtd3fj/QIAdT4f6WV9cTT12UCoZ54wEjH/8V04lNinxUFvxt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L9TjzxIn; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a757ab17-e6ca-48f0-ac15-3bd97a4b542e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711060373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/Lr4E9a605vheRZplDHsft6Dy8a9yDcfkpMMdUcuvw=;
	b=L9TjzxInk/TWB9VgFgEsXwG/f8FNriy5FvYadItSTwGcAzvoA12wkLZQ4HgoyF2dDba9Jg
	9uJgbyLizdtOIowlXJswVABXh0SqjoMlBM65MuohRBtPLZryPEFL5UivhGX4b6j/OLwY4o
	zRhmZjc9BKnN5wdOGT6U55vpnnWFvWQ=
Date: Fri, 22 Mar 2024 06:32:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v10,03/27] drm/connector: hdmi: Create an HDMI sub-state
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
References: <20240321-kms-hdmi-connector-state-v10-3-e6c178361898@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240321-kms-hdmi-connector-state-v10-3-e6c178361898@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/21 23:28, Maxime Ripard wrote:
> The next features we will need to share across drivers will need to
> store some parameters for drivers to use, such as the selected output
> format.
>
> Let's create a new connector sub-state dedicated to HDMI controllers,
> that will eventually store everything we need.
>
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>

-- 
Best regards,
Sui



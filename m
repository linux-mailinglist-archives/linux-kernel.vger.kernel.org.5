Return-Path: <linux-kernel+bounces-164476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE688B7DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA561B21C76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2718132F;
	Tue, 30 Apr 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VG+g27BU"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A64180A9C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496064; cv=none; b=V3U9eesMyiLOgatCxE7kRNSbBg2Yo91FqG3gXFCbxDnZ57cHuZqMbllbTJcLtRu1g8VT/Ng+kWeaye1ZRzie+KNzTshWgaRpJGADWEaVtSmen/vCewf0DG+tzEmHDMESwnub+QdXWqaGYbGg5ezyq9ws3GFqLVgeGyuskVj4KR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496064; c=relaxed/simple;
	bh=AOcwnrKDematRJJsqW6AOYw6rw2oBxyq7cWn17MElS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gP0CfIxIB08eiBwPbMaEIMiGRigExOmqqTxiAG7GxFI65RkcSteSREHgyZxVDYBs6RmC+g4j57nPMUNL5BA+A+YeYAD3lQFDYDm4QZfOQEHAwiCTlri1+Hhi+vfg1o37DfVQzOYNfqDx/yQsqxDj+P8v3bnop0bFcyGxGiK95Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VG+g27BU; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f811953a-ce63-40cd-9de3-ecd5e1c1727a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714496059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2dRrH9qKVGQoxOqBcj9HzqTG/K2CTzhuVPxDntmNss=;
	b=VG+g27BUebASR+hbkSLsh6v6EIge7sNujIkGIcECbi5+HIegi8Pj79UsDExA1YqfWYyaea
	nxCYLUL8kTG0y54CXgc4Kq2w+VT1yYUiT1RZQunRFa5+wVGLer5VSLZnwG8ZHUlW/FLrP7
	mlld3BCAtR3fptHhI9RITfab2p64ehg=
Date: Wed, 1 May 2024 00:54:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,3/3] drm/panel: ili9341: Use predefined error codes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240425142706.2440113-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/4/25 22:26, Andy Shevchenko wrote:
> In one case the -1 is returned which is quite confusing code for
> the wrong device ID, in another the ret is returning instead of
> plain 0 that also confusing as readed may ask the possible meaning
> of positive codes, which are never the case there. Convert both
> to use explicit predefined error codes to make it clear what's going
> on there.
>
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>


-- 
Best regards,
Sui



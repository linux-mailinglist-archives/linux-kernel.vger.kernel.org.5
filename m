Return-Path: <linux-kernel+bounces-159198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2B8B2A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325281F21FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ED815575C;
	Thu, 25 Apr 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kEEX3I+M"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4A15250D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079643; cv=none; b=ay8scXghwZSwXy59c/XaehBjnbkxULhk82vuOHt5EjPe3mv1GXqC8OvoIV7MphpCdyi3XC1OVHQKLTVWLmfMMj+2gePK6Fbr592uahPnMyhy8q785NF7S/ZyPkdgO3qGuJdbmIDfX4nycvRl3gIPuwf0FSAhuZ7ZTbHotlDjFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079643; c=relaxed/simple;
	bh=AeG56uVFyyntK5nYKOlngFLCNZ/j6pt77ZKNiGCZxgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ynk1xiL48zjHEs6RWVkLxe6cqLjUyPIz8thO3CvjdHNPZYtJo2KUtC9+0E5WtILXV/FoJ6j9WGyYL9+rB+cR8HnzjNG+OEipSAARjsL0UiYnAuS6m09MugR4HN1wrYUExTKcl+jLwCdrzpNxzBmNQwFkP1RVRxuXmwye6l68ADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kEEX3I+M; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b5ffd984-4031-4a8a-adbc-75a1e1dfe765@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714079639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J76MnMVIJlI0gv+q1JeGEsHaLLINN3L3MN1gfgnkVec=;
	b=kEEX3I+MfQAQorpZQKFqFgOoyVx5v5JiEspZso99d7xz1SnkdI7qoymNr1/OVt5hZKi6bI
	w+sRc96P7rI1XkTvAy/AGrQGtyl/mZb4CN64O6JnK+wX34E12JhxF0lbfkt3iXMFErca2/
	qyTbpUP7TjNEdfwA5l1aXqEkapKlPAU=
Date: Fri, 26 Apr 2024 05:13:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
 <ZiqrLfezhns4UycR@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZiqrLfezhns4UycR@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/26 03:12, Andy Shevchenko wrote:
> On Fri, Apr 26, 2024 at 02:53:22AM +0800, Sui Jingfeng wrote:
>> On 2024/4/26 02:08, Sui Jingfeng wrote:
> Are you speaking to yourself? I'm totally lost.
>
> Please, if you want to give a constructive feedback, try to understand
> the topic from different aspects and then clearly express it.
>

OK,

The previous email analysis the non-DT cases exhaustively, this email intend to
demonstrate the more frequently use case.

That is, in the *DT('OF')* based systems,
device_get_match_data() is completely equivalent to 
of_device_get_match_data().
So the net results of applying this patch are "no gains and no lost".

Things will become clear if we divide the whole problem into two cases(DT and non-DT)
to discuss, that's it. That's all I can tell.

Sorry about my broken written and sorry for the noise. Thanks for your education in
the past.

-- 
Best regards,
Sui



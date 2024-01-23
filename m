Return-Path: <linux-kernel+bounces-34858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1483886A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763831F23593
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B4E55E70;
	Tue, 23 Jan 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="doQx0DWe"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1552F86
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996900; cv=none; b=nfnqPbi2wO7vMBTdU8fei+W+lRUEE6fTx71Ax/bG3hmMIHc4nWSZVQR1q2Gvkns8vyXsbHqed2FVxfO3HLJ/rC1FDmD6EWifDGbwVNWSBsbOuTqQtA7jyOB3c67xH06nB3YgTOUH/MKMQsykMvpOfSaW3qW7JgJfe250p4oHEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996900; c=relaxed/simple;
	bh=67l2M1HaeJ+asThnndVHn1G09ODvFjMH6pEAjXPnAkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNIhUKfz1Id/duRYYjvuGrla3lV9dmvxKEKx1J9GJGRlUyWZMg0mV8kemO+a3A3BTlPx0KfIewEmIQpRim5tEVt5RH4HU/5n0L4T+pFa9u5nmYXswNskoV1HFeJf/idzhyRLxVhUoRqc4now7G91Ax1cQ9iLa8QBP/p+lwxJSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=doQx0DWe; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c999fed3-b6bd-4499-b508-cf524372fbdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705996896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67l2M1HaeJ+asThnndVHn1G09ODvFjMH6pEAjXPnAkg=;
	b=doQx0DWesFQKU/CE1PDURDBvCPxCb7YfllzioaQOBRIsFdY397G2ZWkKxHSaXTuqeVM5s8
	aIvjbLok1ldH19qjGp73DIBiZ3cTqysEVZAIHBlyZar5pQ+ugoepzakApSyGTadLiBuGUe
	WYD72Jv4zZg0Kcy93h4vdPjAtTA6Of4=
Date: Tue, 23 Jan 2024 16:01:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] drm/bridge: Add drm_bridge_find_by_fwnode() helper
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-2-sui.jingfeng@linux.dev>
 <20240123011710.GA22880@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240123011710.GA22880@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


Thanks a lot for your review :-)


On 2024/1/23 09:17, Laurent Pinchart wrote:
> Hi Sui,
>
> Thank you for the patch.
>
> On Tue, Jan 23, 2024 at 12:32:16AM +0800, Sui Jingfeng wrote:
>> Because ACPI based systems only has the fwnode associated, the of_node
>> member of struct device is NULL. To order to move things forward, we add
>> drm_bridge_find_by_fwnode() to extend the support.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Could we switch completely to fwnode, instead of maintaining the fwnode
> and OF options side-by-side ?


The side-by-side approach allow us to migrate smoothly,
the main consideration is that the OF approach has been
works very well, it is flexible and very successful in
the embedded world.

It seems that the fwnode API could NOT replace the OF
options completely. For example, the'of_device_id' and 'of_match_table' related things are always there, there
are large well-established helpers and subroutines and
already formed as a standard. Some part of it may suffer
from backward compatibility problems.

So I want to leave some space to other programmers.
Maybe there are other programmers who feel that using
OF alone is enough for a specific problem(domain).



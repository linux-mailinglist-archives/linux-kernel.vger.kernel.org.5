Return-Path: <linux-kernel+bounces-110351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40120885D90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9761F21408
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858D68C0A;
	Thu, 21 Mar 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tNlPkdk9"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF62C80
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038928; cv=none; b=W6QGMwxadVMSizXPhxdqzVQKnja50Th0GfSCOIULo8obb+XsOY82OmkkCFILn4z2dZrFP0kcMltMjzLZj6KUymE9vDwxVA4yHcrhWaFNtUc1qfYAEvQh0RCjuQfTHUXXAIZZeMhMY/9Mh+sBoYJPS1qYtBzukzKq3oi5yQ8WPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038928; c=relaxed/simple;
	bh=lJdB0lQOeW6FIOveDvwdGLKWA9MXOQA168fe5u8Q/DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNhbO2Rvc8J/1fp3oD1JD2V/hl28AG4sLv0YEh46ulfeIalttOLfN3hFKo7/m4h5oaQ856i7eWahztiOAIUgVTHytWtT9OTIE4tACMieULZXYeLzzvohXaUG+NXp5lNvz73UbrrXRBKTDq1CwDwUtTgh7cCrnfPZV0GvgVJ6znA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tNlPkdk9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9990db8b-ec05-4557-aa8c-654ed6cf9ab4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711038924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65hUeG8OX6ql2/GX16GupJklYGDvMlauJgw18xRPFmI=;
	b=tNlPkdk9LOBP9JJygHsaW3toD5a18XuWBNbevoDMet1kmCy7TfmZyvz0NtGAgQbIlQrfOh
	bfnQhfnlzyUGbgSLOxbnzAtwlBDQY8n6olMmHKOhWs+uy8TfTPylonyX/imCUyIRlyVYFk
	1jxHrHFUZNFzU0v0QclBvcCY1Vc9Ux4=
Date: Thu, 21 Mar 2024 12:35:18 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 8/8] drm: zynqmp_dp: Add debugfs interface for
 compliance testing
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Michal Simek <michal.simek@amd.com>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
 <20240319225122.3048400-9-sean.anderson@linux.dev>
 <7aa16340-6a87-4110-8114-c1b863b100c9@ideasonboard.com>
 <76831c1e-216f-430b-bacd-2d50f352e61f@linux.dev>
 <aa559c02-b8df-41f8-9439-d7182ac55ffe@ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aa559c02-b8df-41f8-9439-d7182ac55ffe@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/21/24 12:31, Tomi Valkeinen wrote:
> On 21/03/2024 18:08, Sean Anderson wrote:
>> On 3/20/24 03:49, Tomi Valkeinen wrote:
>>> On 20/03/2024 00:51, Sean Anderson wrote:
>>>
>>>> +/**
>>>> + * enum test_pattern - Test patterns for test testing
>>>
>>> "for test testing"? =)
>>>
>>>> @@ -1655,6 +2321,9 @@ static void zynqmp_dp_hpd_irq_work_func(struct work_struct *work)
>>>>        u8 status[DP_LINK_STATUS_SIZE + 2];
>>>>        int err;
>>>>    +    if (READ_ONCE(dp->ignore_hpd))
>>>> +        return;
>>>> +
>>>>        mutex_lock(&dp->lock);
>>>>        err = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, status,
>>>>                       DP_LINK_STATUS_SIZE + 2);
>>>
>>> Why do you need READ/WRITE_ONCE() for ignore_hpd?
>>
>> It's not protected by dp->lock so we don't have to take it for
>> zynqmp_dp_hpd_work_func. Although maybe we should make a version of
>> zynqmp_dp_bridge_detect which assumes we already hold the lock.
> 
> Does using the macros solve some potential issue, or is it just for documenting that this variable is accessed without lock?

Without this the compiler is free to issue multiple loads for this
variable, which could be incorrect.

--Sean



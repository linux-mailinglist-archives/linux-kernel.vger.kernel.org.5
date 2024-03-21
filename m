Return-Path: <linux-kernel+bounces-110311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B94885D02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B081F213C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6D12BF26;
	Thu, 21 Mar 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TGlqxFn8"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433748662F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037336; cv=none; b=EHnEHExKu7SS1Thq0gcncGDD2UL6WdP1U96logzkIgCYqeZimLc9HNy68V9DdGiScLu80OjeK+RTmP+HZqXTv3nehX/aPUrqmhM/eHbGVnVn1aYtXNN9auZmK9/hcb9xXy0dQVaoJkqIgjMRACOMqhyjAfi+rtvTObBHLVRMSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037336; c=relaxed/simple;
	bh=Q9gMT2+hbazlKA/kuIHmYSPxFl1qWt7jCrvNYESr4l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOxtzlJlJLXeLWFqtODFKs+nmJ/TZEm0XvrEpVQeLvH/u5IOmQVW/0Njk6uxwHSr6rozkNJarQ52VsIPYHkHl0tJ4ZbRyM/mWk0JLsU02+I70OkGvVJqsq6cMWbGTHvMkRTa0mFFgdmcnC93gR4xd3R5xOeDbyGmysZX0nycPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TGlqxFn8; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <76831c1e-216f-430b-bacd-2d50f352e61f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711037331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYGs6j1CcJBZpXqqpvnZVExRCl/iMQ6GtORK4GaVepw=;
	b=TGlqxFn8rv4WjNNL+kr5zeS2uvA9xjrL/AHHaAsiK+u4aCpDCFl/lLQwqqfKew/PAgKd6i
	h2BG1OVzI3HWvHRBnzpGgGbl7a2NFHZbuZDP/SUhcfBZxardWlIVB5JgFmrue+WtCjvcwm
	KAII2X78oz7JI4lt6vzOWy7op1WzAyU=
Date: Thu, 21 Mar 2024 12:08:44 -0400
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <7aa16340-6a87-4110-8114-c1b863b100c9@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/20/24 03:49, Tomi Valkeinen wrote:
> On 20/03/2024 00:51, Sean Anderson wrote:
> 
>> +/**
>> + * enum test_pattern - Test patterns for test testing
> 
> "for test testing"? =)
> 
>> @@ -1655,6 +2321,9 @@ static void zynqmp_dp_hpd_irq_work_func(struct work_struct *work)
>>       u8 status[DP_LINK_STATUS_SIZE + 2];
>>       int err;
>>   +    if (READ_ONCE(dp->ignore_hpd))
>> +        return;
>> +
>>       mutex_lock(&dp->lock);
>>       err = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, status,
>>                      DP_LINK_STATUS_SIZE + 2);
> 
> Why do you need READ/WRITE_ONCE() for ignore_hpd?

It's not protected by dp->lock so we don't have to take it for
zynqmp_dp_hpd_work_func. Although maybe we should make a version of
zynqmp_dp_bridge_detect which assumes we already hold the lock.

--Sean


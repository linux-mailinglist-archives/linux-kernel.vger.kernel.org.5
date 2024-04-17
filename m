Return-Path: <linux-kernel+bounces-148646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED28A857D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F27D1C215C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FCF1411E9;
	Wed, 17 Apr 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NLVL4IPY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E31411C6;
	Wed, 17 Apr 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362459; cv=none; b=SGFe9B6vlynXmg8zEUeAWcW7/B/a3q+TNGHbqRMzCRk4HDUCFrqKkYtLcB5h8TbCe8NZJF7WW5bT2o4RPX9seZlRiM4mC2x5MHPMQOKQ9hrLRS6qRPOoYvZoZyDuNbxlejFwFRd67H0lO8tu3IBgMiOau8UF2c7OSSK82qLtDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362459; c=relaxed/simple;
	bh=XXSBrpKeFBW0Wr5Obr1HrJ42x0q+ZIDydmMbpFUeZJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EL0P+zqFxRAFwxf3DUPujA4tv4DvYw8NH1HV/ka71vy7ZOIvPCtT4xsumU7o2uxHK4K+leCe8sgeZQ6V0RKWauT3PiFHozD9tGaTL+17ObuQj99OPhX1YBI3UoIaca0fPTgr1/XcOEWWb3lScceVlHJOIOwIHjxzdCYV8tLCRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NLVL4IPY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.7])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99AA9182C;
	Wed, 17 Apr 2024 16:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713362404;
	bh=XXSBrpKeFBW0Wr5Obr1HrJ42x0q+ZIDydmMbpFUeZJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NLVL4IPYAXZL7hCQkg+pADK/52DfGJelKFUFhCQXfXYZynagJ2FBdnqY/Cvhbxf7J
	 QWqBz4aHGxrW8NcAt4k5m4u5TXpdrkfbUFfNohIshteXcGLflmxQGkLLNUKsT2yqPy
	 YaU/1Ya/gtgRmouKBUpgVymYTE8UPkYUWxQZVIws=
Message-ID: <17f78148-f534-47fe-b59e-d6474b0dd62e@ideasonboard.com>
Date: Wed, 17 Apr 2024 19:30:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] media: subdev: Improve stream enable/disable
 machinery
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

On 16/04/24 7:25 pm, Tomi Valkeinen wrote:
> This series works on the .s_stream, .enable_streams, .disable_streams
> related code. The main feature introduced here, in the last two patchs,
> is adding support for .enable/disable_streams() for subdevs that do not
> implement full streams support.
>
> Additionally we add support for the privacy led when
> v4l2_subdev_enable/disable_streams() is used.
>
> I have tested this on RPi5.

I have also tested the series on i.MX8MP with IMX283 hence,

Tested-by: Umang Jain <umang.jain@ideasonboard.com>
>
>   Tomi
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v5:
> - Fix issues with non-routing case:
>    - Always set 'found_streams' variable instead of leaving it
>      uninitialized in "Support single-stream case in
>      v4l2_subdev_enable/disable_streams()"
>    - Fix the "implicit" stream from bit 1 to bit 0 in "Support
>      non-routing subdevs in v4l2_subdev_s_stream_helper()"
> - Link to v4: https://lore.kernel.org/r/20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com
>
> Changes in v4:
> - Added Rb tags
> - Rename 'streaming_enabled' to 's_stream_enabled'
> - Cosmetic changes (comments / patch descs)
> - Added new patch "media: subdev: Support non-routing subdevs in  v4l2_subdev_s_stream_helper()".
> - Link to v3: https://lore.kernel.org/r/20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com
>
> Changes in v3:
> - Rebased on top of "[PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon fails"
> - Drop extra "!!" in "media: subdev: Fix use of sd->enabled_streams in  call_s_stream()"
> - Enable privacy LED after a succesfull stream enable in  "media: subdev: Support privacy led in v4l2_subdev_enable/disable_streams()"
> - Init 'cfg' variable when declaring in "media: subdev: Refactor v4l2_subdev_enable/disable_streams()"
> - Link to v2: https://lore.kernel.org/r/20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com
>
> Changes in v2:
> - New patches for privacy led
> - Use v4l2_subdev_has_op()
> - Use BITS_PER_BYTE instead of 8
> - Fix 80+ line issues
> - Fix typos
> - Check for pad < 64 also in the non-routing .enable/disable_streams code path
> - Dropped "media: subdev: Support enable/disable_streams for non-streams
>    subdevs", which is implemented in a different way in new patches in this series
> - Link to v1: https://lore.kernel.org/r/20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com
>
> ---
> Tomi Valkeinen (10):
>        media: subdev: Add privacy led helpers
>        media: subdev: Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams()
>        media: subdev: Add checks for subdev features
>        media: subdev: Fix use of sd->enabled_streams in call_s_stream()
>        media: subdev: Improve v4l2_subdev_enable/disable_streams_fallback
>        media: subdev: Add v4l2_subdev_is_streaming()
>        media: subdev: Support privacy led in v4l2_subdev_enable/disable_streams()
>        media: subdev: Refactor v4l2_subdev_enable/disable_streams()
>        media: subdev: Support single-stream case in v4l2_subdev_enable/disable_streams()
>        media: subdev: Support non-routing subdevs in v4l2_subdev_s_stream_helper()
>
>   drivers/media/v4l2-core/v4l2-subdev.c | 378 ++++++++++++++++++++--------------
>   include/media/v4l2-subdev.h           |  25 ++-
>   2 files changed, 245 insertions(+), 158 deletions(-)
> ---
> base-commit: 6547a87b1ffc9b3c3a17f20f71016de98c169bbb
> change-id: 20240404-enable-streams-impro-db8bcd898471
>
> Best regards,



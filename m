Return-Path: <linux-kernel+bounces-153874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7A8AD45F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1CF288160
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E3154BFF;
	Mon, 22 Apr 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PxXZV2b5"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AF15539D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811698; cv=none; b=idgndGlxCUYL9aIYWqNVnCdolQUW+dxlMUOqu1wVKncAPEAB0Dp+/6xLEK/t+HNE4OY2ysWYCQEXwC92b94W5cZVhKXHbu+DlzxpSFeZ8gdlFVup6p4JUf5yYL8ozUU+7zWY6echQTudewhl8eZCSYAtN9Z4rVcTbdjcvaKdWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811698; c=relaxed/simple;
	bh=ddXHa4rfbhfTPXo1QCqQLVUeH3qumUcibVvlFy1xjy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr3g5PxSH/mHW8y1gLXD+SG/YhEvXdu3kHvqcuIhaqO5XoSuB8sxTAVWCgL4YbiC4Zng0CC5lVjnTg0fbFTP3qmXIuzaa+XZGXyfYSf+nhjXEtRKpgq8eWH18XUOXw2Ze5LSvcpTAMf+5ikzL73Jiq8fsCg+we87pi+wOoNeCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PxXZV2b5; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4cfbbbd5-fd76-4426-a6be-ad6a82dae8bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEt+IUNNZ0s58xLemUV9lCabZNCE/TtBPyT3EKRdZWM=;
	b=PxXZV2b564EDYUZ1cMNfuPA3OWIDzAXHwpCVn9d5yL26gmg5e/sP0UhkD+uek5jr3Zs5u4
	6xKjAZ8B9lK6jeZJ6Uz89ckvuGiQ+NYt0bpU8AiZGzU20cQ5D7SQ6xsJr5AtBludBQf8U9
	+68nXwN+aEtknkmVAbIUP9zzmmEbyLM=
Date: Mon, 22 Apr 2024 14:48:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/13] drm: zynqmp_dp: IRQ cleanups and debugfs support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>
References: <20240422184553.3573009-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240422184553.3573009-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 14:45, Sean Anderson wrote:
> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
> that's done, it adds debugfs support. The intent is to enable compliance
> testing or to help debug signal-integrity issues.
> 
> Last time I discussed converting the HPD work(s) to a threaded IRQ. I
> did not end up doing that for this series since the steps would be
> 
> - Add locking
> - Move link retraining to a work function
> - Harden the IRQ
> - Merge the works into a threaded IRQ (omitted)
> 
> Which with the exception of the final step is the same as leaving those
> works as-is. Conversion to a threaded IRQ can be done as a follow-up.
> 
> Changes in v3:
> - Store base pointers in zynqmp_disp directly
> - Don't delay work
> - Convert to a hard IRQ
> - Use AUX IRQs instead of polling
> - Take dp->lock in zynqmp_dp_hpd_work_func
> 
> Changes in v2:
> - Fix kerneldoc
> - Rearrange zynqmp_dp for better padding
> - Split off the HPD IRQ work into another commit
> - Expand the commit message
> - Document hpd_irq_work
> - Document debugfs files
> - Add ignore_aux_errors and ignore_hpd debugfs files to replace earlier
>   implicit functionality
> - Attempt to fix unreproducable, spurious build warning
> - Drop "Optionally ignore DPCD errors" in favor of a debugfs file
>   directly affecting zynqmp_dp_aux_transfer.
> 
> Sean Anderson (13):
>   drm: xlnx: Store base pointers in zynqmp_disp directly
>   drm: xlnx: Fix kerneldoc
>   drm: zynqmp_dp: Downgrade log level for aux retries message
>   drm: zynqmp_dp: Adjust training values per-lane
>   drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
>   drm: zynqmp_dp: Don't delay work
>   drm: zynqmp_dp: Add locking
>   drm: zynqmp_dp: Don't retrain the link in our IRQ
>   drm: zynqmp_dp: Convert to a hard IRQ
>   drm: zynqmp_dp: Use AUX IRQs instead of polling
>   drm: zynqmp_dp: Split off several helper functions
>   drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
>   drm: zynqmp_dp: Add debugfs interface for compliance testing
> 
>  Documentation/gpu/drivers.rst       |   1 +
>  Documentation/gpu/zynqmp.rst        | 149 +++++
>  MAINTAINERS                         |   1 +
>  drivers/gpu/drm/xlnx/zynqmp_disp.c  |  44 +-
>  drivers/gpu/drm/xlnx/zynqmp_dp.c    | 909 +++++++++++++++++++++++++---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.h |   1 +
>  drivers/gpu/drm/xlnx/zynqmp_kms.h   |   4 +-
>  7 files changed, 1000 insertions(+), 109 deletions(-)
>  create mode 100644 Documentation/gpu/zynqmp.rst
> 

+CC Tomi, who I forgot to add initially...


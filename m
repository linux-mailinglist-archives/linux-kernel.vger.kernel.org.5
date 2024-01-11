Return-Path: <linux-kernel+bounces-23353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE0682AB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4462820D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8412B95;
	Thu, 11 Jan 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br1yYQqp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CB12B75
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704967330; x=1736503330;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HnlymRMYb6iBEZkAa/8e5vTHfW9TBEzgwzS94R+//1Y=;
  b=Br1yYQqpnBUhbEc7b24KLwjln+tuTRxUI05ngKjx7VQnqsUcYvXHu71Y
   moQudrefWas8prjjEFZM6M9Jeu1JCsr5rUqcvb89e1CXpoPO8sXcR33lo
   uVFoMDDOpLu4XJDPcqzFhCrQOHeAcr4NHHENIPqM26BqiiSLotN0ERzSk
   iEC1cdarQK4h+8P7rXrsZIP7J3Ai7ixOTjyzy0UxOvAzDUIbUOW8yeQB3
   0/S0pUCCIH1umg92qYXxFFHdSUF1vUpRJtB/HvJWeVfND5REYeURe+i1g
   2bhyTQJIbIxZc5S/tTsVSBG76DEnz9BcpnefNFmtvfLo6PQJ5KJPlIL8Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12157033"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12157033"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:02:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1029485678"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1029485678"
Received: from gaertgee-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.206])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:02:05 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: chenxuebing <chenxb_99091@126.com>, daniel@ffwll.ch, airlied@gmail.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 chenxuebing <chenxb_99091@126.com>
Subject: Re: [PATCH] drm/edid: Clean up errors in drm_edid.h
In-Reply-To: <20240111063921.8701-1-chenxb_99091@126.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111063921.8701-1-chenxb_99091@126.com>
Date: Thu, 11 Jan 2024 12:02:03 +0200
Message-ID: <8734v4ur1g.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 11 Jan 2024, chenxuebing <chenxb_99091@126.com> wrote:
> Fix the following errors reported by checkpatch:
>
> ERROR: do not use assignment in if condition
>
> Signed-off-by: chenxuebing <chenxb_99091@126.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_edid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 69c68804023f..9bcaf76f10fc 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -3611,7 +3611,8 @@ static bool mode_in_range(const struct drm_display_mode *mode,
>  	if (!mode_in_vsync_range(mode, edid, t))
>  		return false;
>  
> -	if ((max_clock = range_pixel_clock(edid, t)))
> +	max_clock = range_pixel_clock(edid, t);
> +	if (max_clock)
>  		if (mode->clock > max_clock)
>  			return false;

-- 
Jani Nikula, Intel


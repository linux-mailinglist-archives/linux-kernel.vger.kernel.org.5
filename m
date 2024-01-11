Return-Path: <linux-kernel+bounces-23349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027B82AB72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B9CB22650
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577F125DA;
	Thu, 11 Jan 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYDiGKcn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F212E6B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704967177; x=1736503177;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wWtjtpvLpCpNq6v6WPPTrwuiaHZ9+Yn/ZZKrzAQXEDo=;
  b=XYDiGKcnNutdLGi4OZPb2N/dnzrmfFYD570fsPl3jzDXnlGPCWwHkt42
   7ROI9med6L8rJL5hfYeMs/1N50k0KimkmfAXjXpagYKcXfWkLDceRmP6a
   sBamzBB+4sLCFxb7hVbgk8GlgotWYjXHCsqPBe6CaabpjExQy5eR2/XRs
   862/qyqpq1PzrgBNX+FXxRJ6T4pyqMxko9pvQQuQkNj0NqaQE4UIK+2rB
   4JLFL6KHCLeKiAFJuyajq9HoOHVDxlTT6/FsFR+GoIkZA8tMWyYEC0AmL
   Ju8FRrL2PjOBUZXaspzH07+rjSenr0hXcsFFut6PyNYcXbtKbmrc9LfeG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5530914"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5530914"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="782568762"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="782568762"
Received: from gaertgee-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:59:24 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: chenxuebing <chenxb_99091@126.com>, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, daniel@ffwll.ch,
 tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 chenxuebing <chenxb_99091@126.com>
Subject: Re: [PATCH] drm: Clean up errors in drm_dp_mst_topology.h
In-Reply-To: <20240111064245.8789-1-chenxb_99091@126.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111064245.8789-1-chenxb_99091@126.com>
Date: Thu, 11 Jan 2024 11:59:21 +0200
Message-ID: <875y00ur5y.fsf@intel.com>
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
> ERROR: space prohibited before open square bracket '['

Same here, checkpatch just isn't clever enough to realize it's within a
macro.

BR,
Jani.

>
> Signed-off-by: chenxuebing <chenxb_99091@126.com>
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index bd6c24d4213c..a4a24ec11b80 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -100,7 +100,7 @@ static bool drm_dp_mst_port_downstream_of_branch(struct drm_dp_mst_port *port,
>  
>  #define DBG_PREFIX "[dp_mst]"
>  
> -#define DP_STR(x) [DP_ ## x] = #x
> +#define DP_STR(x)[DP_ ## x] = #x
>  
>  static const char *drm_dp_mst_req_type_str(u8 req_type)
>  {
> @@ -131,7 +131,7 @@ static const char *drm_dp_mst_req_type_str(u8 req_type)
>  }
>  
>  #undef DP_STR
> -#define DP_STR(x) [DP_NAK_ ## x] = #x
> +#define DP_STR(x)[DP_NAK_ ## x] = #x
>  
>  static const char *drm_dp_mst_nak_reason_str(u8 nak_reason)
>  {
> @@ -156,7 +156,7 @@ static const char *drm_dp_mst_nak_reason_str(u8 nak_reason)
>  }
>  
>  #undef DP_STR
> -#define DP_STR(x) [DRM_DP_SIDEBAND_TX_ ## x] = #x
> +#define DP_STR(x)[DRM_DP_SIDEBAND_TX_ ## x] = #x
>  
>  static const char *drm_dp_mst_sideband_tx_state_str(int state)
>  {

-- 
Jani Nikula, Intel


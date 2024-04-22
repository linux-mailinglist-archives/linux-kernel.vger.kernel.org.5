Return-Path: <linux-kernel+bounces-153309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF558ACC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED24B1C215FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C40E146A85;
	Mon, 22 Apr 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k02c+1bR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746314430B;
	Mon, 22 Apr 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786618; cv=none; b=LLuTDUTAMfR3yXbrSTvSo2i/v1vaHjzI5m+Uas4vOi4T7pYV5ceyNMK6Z34mfLDOMDhzPvt4gB2WGjiwvL+fFtHSzlIDDyQnFVs3lZ9MEOAuYEKL0652zrhOgf3M7hTbQdmAjc0q11XyyJtBwUSd0l9UcZjRo1VW3bXwhBnW67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786618; c=relaxed/simple;
	bh=Gd76lsOo4VGGSyfVLdRqHseFbsa9HDkzoH11UyZQ6eI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R8KKAxHqHYijFvzCz/bJ/clcfRH69+ZIFguz0W0TuxY/p5sNY6y5J3LmFsOC7dGkyq/vWelcYzHlo7YrERMMbTRe5mt5tNhT2RGCR2DlHU4XvkvJof5WkAxwLlhAyciewrT8uMwTjdzykyURKK5zhcqV31qQvQPRldpVGpHkfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k02c+1bR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713786616; x=1745322616;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Gd76lsOo4VGGSyfVLdRqHseFbsa9HDkzoH11UyZQ6eI=;
  b=k02c+1bR1AwwnYXD2Bx6YaoGLP3gX0qQC5imjXLVI8JAxgca1Ig0j6Ca
   DX0oLr9XJIOp71gHASgBlkf7JgAdFr49encfXXFsRWZX0aXbzbTgIUaqp
   jaHLwBGtdZO7kvu8cq43WCfwHZqKml5mMBWwFNsGJRt/EBF8tg7yceTyi
   RzrGv9RxESjBeVvLCi55xtoduwBWijrccmP6BckuUNYre3PkbnHlki4HE
   bSlw8GuOLwr+JFnXlGUezngqSd5Kbh4vem2V19vGmgyti2PKa+CQZRpPP
   21zFlikf5GvX6NQCfSPu3YF7uhxVI/sdpsty1Z7YJp+txAeEwzVhXV/NF
   w==;
X-CSE-ConnectionGUID: WjbBLBOjTUipXiKfRLfhaw==
X-CSE-MsgGUID: 9Bj/l9ZxTTOHPleKOLZY/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="19871596"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="19871596"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:50:16 -0700
X-CSE-ConnectionGUID: ClJyYI3LQfiTqjN1U6lXYw==
X-CSE-MsgGUID: KltWatPSRn+GzrwENKC0qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="61438122"
Received: from ralbanes-mobl.ger.corp.intel.com (HELO localhost) ([10.252.63.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:50:12 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven
 <geert+renesas@glider.be>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
In-Reply-To: <cover.1713780345.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1713780345.git.geert+renesas@glider.be>
Date: Mon, 22 Apr 2024 14:50:09 +0300
Message-ID: <87il09ty4u.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Apr 2024, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 	Hi all,
>
> As discussed on IRC with Maxime and Arnd, this series reverts the
> conversion of select to depends for various DRM helpers in series
> "[PATCH v3 00/13] drm/display: Convert helpers Kconfig symbols to
> depends on"[1], and various fixes for it.  This conversion introduced a
> big usability issue when configuring a kernel and enabling DRM drivers
> that use DRM helper code: as drivers now depend on helpers, the user
> needs to know which helpers to enable, before the driver he is
> interested even becomes visible.  The user should not need to know that,
> and drivers should select the helpers they need.
>
> Hence revert back to what we had before, where drivers selected the
> helpers (and any of their dependencies, if they can be met) they need.
> In general, when a symbol selects another symbol, it should just make
> sure the dependencies of the target symbol are met, which may mean
> adding dependencies to the source symbol.

I still disagree with this, because fundamentally the source symbol
really should not have to care about the dependencies of the target
symbol.

That said, I'm not going to keep arguing against this. Whatever.


BR,
Jani.


>
> Thanks for applying!
>
> [1] https://lore.kernel.org/r/20240327-kms-kconfig-helpers-v3-0-eafee11b84b3@kernel.org/
>
> Geert Uytterhoeven (11):
>   Revert "drm: fix DRM_DISPLAY_DP_HELPER dependencies, part 2"
>   Revert "drm/display: Select DRM_KMS_HELPER for DP helpers"
>   Revert "drm/bridge: dw-hdmi: Make DRM_DW_HDMI selectable"
>   Revert "drm: fix DRM_DISPLAY_DP_HELPER dependencies"
>   Revert "drm: Switch DRM_DISPLAY_HDMI_HELPER to depends on"
>   Revert "drm: Switch DRM_DISPLAY_HDCP_HELPER to depends on"
>   Revert "drm: Switch DRM_DISPLAY_DP_HELPER to depends on"
>   Revert "drm: Switch DRM_DISPLAY_DP_AUX_BUS to depends on"
>   Revert "drm: Switch DRM_DISPLAY_HELPER to depends on"
>   Revert "drm: Make drivers depends on DRM_DW_HDMI"
>   Revert "drm/display: Make all helpers visible and switch to depends
>     on"
>
>  drivers/gpu/drm/Kconfig                 |  8 +++----
>  drivers/gpu/drm/amd/amdgpu/Kconfig      | 12 ++++------
>  drivers/gpu/drm/bridge/Kconfig          | 28 +++++++++++-----------
>  drivers/gpu/drm/bridge/analogix/Kconfig | 18 +++++++-------
>  drivers/gpu/drm/bridge/cadence/Kconfig  |  8 +++----
>  drivers/gpu/drm/bridge/imx/Kconfig      |  4 ++--
>  drivers/gpu/drm/bridge/synopsys/Kconfig |  6 ++---
>  drivers/gpu/drm/display/Kconfig         | 32 ++++++++++---------------
>  drivers/gpu/drm/exynos/Kconfig          |  4 ++--
>  drivers/gpu/drm/i915/Kconfig            |  8 +++----
>  drivers/gpu/drm/imx/ipuv3/Kconfig       |  5 ++--
>  drivers/gpu/drm/ingenic/Kconfig         |  2 +-
>  drivers/gpu/drm/mediatek/Kconfig        |  6 ++---
>  drivers/gpu/drm/meson/Kconfig           |  2 +-
>  drivers/gpu/drm/msm/Kconfig             |  8 +++----
>  drivers/gpu/drm/nouveau/Kconfig         | 10 ++++----
>  drivers/gpu/drm/panel/Kconfig           | 32 ++++++++++++-------------
>  drivers/gpu/drm/radeon/Kconfig          |  8 +++----
>  drivers/gpu/drm/renesas/rcar-du/Kconfig |  2 +-
>  drivers/gpu/drm/rockchip/Kconfig        | 10 ++++----
>  drivers/gpu/drm/sun4i/Kconfig           |  2 +-
>  drivers/gpu/drm/tegra/Kconfig           |  8 +++----
>  drivers/gpu/drm/vc4/Kconfig             | 10 ++++----
>  drivers/gpu/drm/xe/Kconfig              | 13 ++++------
>  drivers/gpu/drm/xlnx/Kconfig            |  8 +++----
>  25 files changed, 116 insertions(+), 138 deletions(-)

-- 
Jani Nikula, Intel


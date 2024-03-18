Return-Path: <linux-kernel+bounces-106253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF687EB73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593331F2195B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABFC4EB32;
	Mon, 18 Mar 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kilj8Lpi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DE4BA88
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773693; cv=none; b=iWjxxyVA0FSo292+PNKgI0X3pYEXMfoQIHItNgSzRxjwvfjfpAWovBX+pxcHlj5A5cLQBSKuMbMTSlqLXo6saTA7VBQah+zge1bmChoiKwqKBbubIEc626iQYqTO1uR4pjQWF1ZAFxtbQsE5TFu74oQGpp6qQYGZ6Gxljs2XBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773693; c=relaxed/simple;
	bh=H0x4rZpZdEgTOzMqO16a9P1LKpGfuBCG6aau50yGdNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=phcI9fJsBQB9gG9zZg/4JbnmaGLc8oeOzbINWlksZGqUF9XxLQNzHsySWcYCs3YaeuLOyPPo6YhNy37NqGvIwjXRH43TDjGt/z4THC9brDTmXnyU7olap84pMH8V3hxkfpi3xpF+EX2mC0k8nh4v6YTxBh8H6zOQ8HAz3SJ9ojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kilj8Lpi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710773691; x=1742309691;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=H0x4rZpZdEgTOzMqO16a9P1LKpGfuBCG6aau50yGdNE=;
  b=Kilj8Lpi2Zj1++s6VB4PGwscAjHUTlxeHemXUXYVWL6bDsxh2M1Q5sHJ
   yKN4nTB2gsIvT+j4h26M9f/tFi07oAcFh6e6QY0DSFPahJe90PZctteQN
   iH7IDlGrq8SuFIjG9zxwKIJxZJtp/q9WxjbETyXWaRdrGlUYpr31vnOyN
   vybPRdRXUJW1CY5SUowpEuB35WsslMjtyAm+QtHRNE2SuRLtNmBeCZpqq
   4u0+fQLFSzoCr4PKmJ/SxNCGEgppWJbP5/dWahjoEBJ9rELdzBjFhq4yU
   92FKQ7rliZFjbUA9QWZ+A0tN2lxcHzXH0Ww74cCnG9otinM5SSZITtSmr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5721801"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5721801"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 07:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13443005"
Received: from ahmedess-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 07:54:45 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Luca Weiss
 <luca.weiss@fairphone.com>
Cc: Imre Deak <imre.deak@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] Revert "drm/bridge: Select DRM_KMS_HELPER for
 DRM_PANEL_BRIDGE"
In-Reply-To: <20240318-revert-select-drm_kms_helper-for-drm_panel_bridge-v1-1-52a42a116286@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240318-revert-select-drm_kms_helper-for-drm_panel_bridge-v1-1-52a42a116286@linaro.org>
Date: Mon, 18 Mar 2024 16:54:42 +0200
Message-ID: <875xxjpp3h.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Mar 2024, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> This reverts commit e3f18b0dd1db242791afbc3bd173026163ce0ccc.
>
> Selecting DRM_KMS_HELPER for DRM_PANEL_BRIDGE leads to:
> WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
>   Depends on [m]: HAS_IOMEM [=3Dy] && DRM [=3Dm]
>   ...
>
> and builds with CONFIG_DRM=3Dm will fail with the above kconfig
> warns and then multiple linker error.
>
> Reported-by: Imre Deak <imre.deak@intel.com>
> Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Fixes: e3f18b0dd1db ("drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRI=
DGE")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Jani Nikula <jani.nikula@intel.com>
Tested-by: Jani Nikula <jani.nikula@intel.com>


> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 1d4f010af97b..efd996f6c138 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -8,7 +8,6 @@ config DRM_BRIDGE
>  config DRM_PANEL_BRIDGE
>  	def_bool y
>  	depends on DRM_BRIDGE
> -	select DRM_KMS_HELPER
>  	select DRM_PANEL
>  	help
>  	  DRM bridge wrapper of DRM panels
>
> ---
> base-commit: e3f18b0dd1db242791afbc3bd173026163ce0ccc
> change-id: 20240318-revert-select-drm_kms_helper-for-drm_panel_bridge-0e4=
ad7c73496
>
> Best regards,

--=20
Jani Nikula, Intel


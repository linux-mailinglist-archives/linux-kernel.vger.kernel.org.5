Return-Path: <linux-kernel+bounces-158710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C18B2418
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B047B2C471
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376614A4E0;
	Thu, 25 Apr 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKWg8Ru6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44A14A09A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055235; cv=none; b=N9NdhIhdwr4LSXOhLkVfRx5A0iOBzjMtep9iYBd3L+IU4wrOgZJ09dGzhAx9Q04H8yLJlkFqkD+fcOYgReVu/ricHIsO2KwmX6W/fykiD6UC37n9qC1IO3GiicAIzuaYSvxL4f6km54p7/7YkCeojbeKbO/Y7YXBXBFjOJ2SUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055235; c=relaxed/simple;
	bh=Wqkixd+I8NnZZhvtO5vNvN0lkMlJWXalpNMQ17i+pvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGFYHVJkrX5FlupRMB2uooNOqJsE1jzfOxz26ZS41htfv8hkVmUnrpjMhc4uZZdQsksdoutiHCni2a56TlGbqRBNCB0qdU4uHau+I8pT7Jbp2PvCjbcoTHxN+clJkDFwg/YdTskCQfuLpkU7fxAH4M+52M267zWkwELOA3meekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKWg8Ru6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714055234; x=1745591234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wqkixd+I8NnZZhvtO5vNvN0lkMlJWXalpNMQ17i+pvY=;
  b=dKWg8Ru66myzIbdtJuEDhSdDiDjLBlfxfni8rgpov2N7efnXdCjrO2gO
   SjtMh5c8/QiBwBNTFIxpn20b+95NMmJgBooqTAELkgF1cJ95vc3kDibQs
   PvpdjiPraf/QYFqhR93vgBv7yIoG+456lYEriCJbRUsmadpiiHEqtNpAp
   RpSCoyHrz8qFcCJP1GBfaTFdRmFV1j/4imtA3YoimODr+YaBPOsJ/HWHp
   4RDz6Fzr8mLSHn0XLTitIf2rusQxD/CUm8ZvHaSmqOXDEyWlNYu1HzDo+
   PJAgnckrXjt9QoUHR088VQd0zx1GU7ZTgbx5GXH/N4RQc7UAszcXdcRIE
   A==;
X-CSE-ConnectionGUID: xEIUaNQMREa1qEOq3K2t1A==
X-CSE-MsgGUID: V/rD0k+8TGygrnN8cpGxSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10281363"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="10281363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 07:27:11 -0700
X-CSE-ConnectionGUID: l5RaI+T3Q36ko0vgLIA/hA==
X-CSE-MsgGUID: b22RoA9cQ1CL9Ir+2tJIjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="56027430"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 25 Apr 2024 07:27:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1C3E079F; Thu, 25 Apr 2024 17:27:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 3/3] drm/panel: ili9341: Use predefined error codes
Date: Thu, 25 Apr 2024 17:26:19 +0300
Message-ID: <20240425142706.2440113-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one case the -1 is returned which is quite confusing code for
the wrong device ID, in another the ret is returning instead of
plain 0 that also confusing as readed may ask the possible meaning
of positive codes, which are never the case there. Convert both
to use explicit predefined error codes to make it clear what's going
on there.

Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 24c74c56e564..b933380b7eb7 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -422,7 +422,7 @@ static int ili9341_dpi_prepare(struct drm_panel *panel)
 
 	ili9341_dpi_init(ili);
 
-	return ret;
+	return 0;
 }
 
 static int ili9341_dpi_enable(struct drm_panel *panel)
@@ -726,7 +726,7 @@ static int ili9341_probe(struct spi_device *spi)
 	else if (!strcmp(id->name, "yx240qv29"))
 		return ili9341_dbi_probe(spi, dc, reset);
 
-	return -1;
+	return -ENODEV;
 }
 
 static void ili9341_remove(struct spi_device *spi)
-- 
2.43.0.rc1.1336.g36b5255a03ac



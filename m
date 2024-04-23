Return-Path: <linux-kernel+bounces-155651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC63F8AF537
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8CF28313B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293013DDD4;
	Tue, 23 Apr 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eW8PLUpj"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F269313BC30
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892758; cv=none; b=DRr9qyT0xxxuh6YUBU5g2pF6I8QSGh5pIyOaQkIMIFbsXLi2aqoFe276peMtT0k+Iqu44Lhy4aEv5cz+qhMG0pZaCWzhqIVi0cl8nUGOOINI79wC6lpBKur+sTgusTbHz6pGzORES5soGnVfo32j6CaAao2iX/nTTqvw0RPU2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892758; c=relaxed/simple;
	bh=zN++VdkMyLtbeXgnTUOrq6jHuzACGSXflVwwieYvMJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjfQE1xEbHjwu7eb3HluckacMZinp56ZIDw5xhcp8BGVI6whj2zf0l/7olAq+hgFpHCRysOYJBGnHi/RjS4bh5XcnPU4RbgSnn/rtVyXBhATYT75fG3bWyHloWcLJsqX3lBG8vuv4nst2WDA95DPlKDUNw8NDrrqdXZIbwsaayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eW8PLUpj; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSn3G3LeyolwbW8KWPdFVdC4d5M1QZCs+pau0q++UOw=;
	b=eW8PLUpjwEIFYIWIc/OQWfJKP8y89xGZ2KdKulfa8kMLlGc76Y4aFFgEqTjYG5FYMOg50b
	OzMSrIQevf8bJRckkfgo69Xge5itiTri8HxDlxZ/ftENksd7ZzJohdy5J54pqDuIFdX1AW
	keilVo5ESn/5mU/LrvP6CE7eyYeAb1M=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 02/13] drm: xlnx: Fix kerneldoc
Date: Tue, 23 Apr 2024 13:18:48 -0400
Message-Id: <20240423171859.3953024-3-sean.anderson@linux.dev>
In-Reply-To: <20240423171859.3953024-1-sean.anderson@linux.dev>
References: <20240423171859.3953024-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix a few errors in the kerneldoc. Mostly this addresses missing/renamed
members.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

(no changes since v3)

Changes in v3:
- Split off documentation for base pointers to previous commit

Changes in v2:
- New

 drivers/gpu/drm/xlnx/zynqmp_dpsub.h | 1 +
 drivers/gpu/drm/xlnx/zynqmp_kms.h   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.h b/drivers/gpu/drm/xlnx/zynqmp_dpsub.h
index 09ea01878f2a..b18554467e9c 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.h
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.h
@@ -53,6 +53,7 @@ enum zynqmp_dpsub_format {
  * @drm: The DRM/KMS device data
  * @bridge: The DP encoder bridge
  * @disp: The display controller
+ * @layers: Video and graphics layers
  * @dp: The DisplayPort controller
  * @dma_align: DMA alignment constraint (must be a power of 2)
  */
diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.h b/drivers/gpu/drm/xlnx/zynqmp_kms.h
index 01be96b00e3f..cb13c6b8008e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.h
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.h
@@ -22,9 +22,9 @@
 struct zynqmp_dpsub;
 
 /**
- * struct zynqmp_dpsub - ZynqMP DisplayPort Subsystem DRM/KMS data
+ * struct zynqmp_dpsub_drm - ZynqMP DisplayPort Subsystem DRM/KMS data
  * @dpsub: Backpointer to the DisplayPort subsystem
- * @drm: The DRM/KMS device
+ * @dev: The DRM/KMS device
  * @planes: The DRM planes
  * @crtc: The DRM CRTC
  * @encoder: The dummy DRM encoder
-- 
2.35.1.1320.gc452695387.dirty



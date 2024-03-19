Return-Path: <linux-kernel+bounces-108200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE32880767
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB0F1C22566
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BE5F860;
	Tue, 19 Mar 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bs7PSUBU"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132A3FBAF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888702; cv=none; b=rATBKQJGjG/DK58KLoT6aB9i2KLlqOoEe4W2bBH9+nIyVdKuIwiMrjRB10YNn7wwg/rQ6Xsa+oMxXg3lIOVSrP7sKPGrof0e1mbd9plP6lAP/65jZGvECn6L90ZTbnhxYrZNyDBsCAx1YEqXI84vdxJO7basnZEAbDLZ8YYHWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888702; c=relaxed/simple;
	bh=4ZwdW+R5TLFHqhi0Xkvjk7VMbIqajRCxXjjSRZz6IfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxY0bmOHR5CH7kmNI5XdjyfJ0/3HAPvMqvG7qnN2nM7pGW6YsK4VwthJsNSQBfbpUIcD5cwLkumPu0jiKpFdHBJvYQU6xiSDiBn9zlh2vUd+fuHF1dI/sraCTvJ/PKkCXKciDQ9NgjRdBfxRBh6aqpLNaRrWWQLoCA10zad5f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bs7PSUBU; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710888698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xw8Fntem9pkDBQcyshBBdVCFOeEC0CMZHCoG76llOU=;
	b=Bs7PSUBUIXrXkjTLE5WLdo6LBfa+uEoI75OrXRWCzQEJzQWGrvLZV/TqLZwFcIM5/3C6Kr
	WhNIc6WRlC3f/Qp7g7mWDP9mHc5QftM0oOYTMGy/oUUp/iJYJaJUddUY2cdab4qgKxytkH
	CjAhzCa1wtms7/Drx2Y5nhVOoV5dGO0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Michal Simek <michal.simek@amd.com>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 1/8] drm: xlnx: Fix kerneldoc
Date: Tue, 19 Mar 2024 18:51:14 -0400
Message-Id: <20240319225122.3048400-2-sean.anderson@linux.dev>
In-Reply-To: <20240319225122.3048400-1-sean.anderson@linux.dev>
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
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
---

Changes in v2:
- New

 drivers/gpu/drm/xlnx/zynqmp_disp.c  | 6 +++---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.h | 1 +
 drivers/gpu/drm/xlnx/zynqmp_kms.h   | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 407bc07cec69..f79bf3fb8110 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -128,9 +128,9 @@ struct zynqmp_disp_layer {
  * struct zynqmp_disp - Display controller
  * @dev: Device structure
  * @dpsub: Display subsystem
- * @blend.base: Register I/O base address for the blender
- * @avbuf.base: Register I/O base address for the audio/video buffer manager
- * @audio.base: Registers I/O base address for the audio mixer
+ * @blend: Register I/O base address for the blender
+ * @avbuf: Register I/O base address for the audio/video buffer manager
+ * @audio: Registers I/O base address for the audio mixer
  * @layers: Layers (planes)
  */
 struct zynqmp_disp {
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



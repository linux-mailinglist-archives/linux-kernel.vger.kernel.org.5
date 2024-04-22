Return-Path: <linux-kernel+bounces-153858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C238AD441
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239A7281910
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78D155343;
	Mon, 22 Apr 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKcDkwV0"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1C155314
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811566; cv=none; b=jUvMBjNoh39EBOFt44bSH487GOWBYvYJHlJ9pbaAOp8xlvBNuM1+JWX0aEB3cgjrNHY+Q0Ot7vwF96GDW5MaT4wA1mzN0+g8yukra3l1uAY33APN9vH59vpn5CdaKqDMRYdDafbE0c1gjoudxmKbepKSKCmX6+EnemdCU8sydhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811566; c=relaxed/simple;
	bh=cn8fy6EMLQWF1+gi6jORrGEiTK0efefaMlUe2NbO2bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f993VvsFzSj7gvbbFevAAtgc+Lk3yLve50Z2zcXBAp7d5k3ElMZUGh49rPDeSTCHUnty51EMob9+wpbVsPRCVRtLJF5BgU7MaEohBx+lFQCNgWt9kmdo+qYLKGiU2T3IWLs063ZXFGGY293J7D6HBr3iSizzjXmnlSvjxnaMOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKcDkwV0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwhTRGcgO4r+0jygil58EKFMf8jk2PflSWuwh+0+9vw=;
	b=bKcDkwV0P+EIwJr0piI648JPdmKFtfNPz+qHAu/8kuc/JLpJyQGjFdPwYQhijWYCY0+m+3
	JOHwNwUjv1z81yyJ7gu0twnhVh5Y0Kb/VX6ZO/OuXu/yAxwHjAaNmx9ocENcLKmUeSenZg
	9tTQenhQWCMLCYycB6/+md+R80bhE6g=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 02/13] drm: xlnx: Fix kerneldoc
Date: Mon, 22 Apr 2024 14:45:42 -0400
Message-Id: <20240422184553.3573009-3-sean.anderson@linux.dev>
In-Reply-To: <20240422184553.3573009-1-sean.anderson@linux.dev>
References: <20240422184553.3573009-1-sean.anderson@linux.dev>
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



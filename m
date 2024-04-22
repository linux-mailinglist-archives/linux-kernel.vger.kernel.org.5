Return-Path: <linux-kernel+bounces-153176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DF8ACA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E941C21441
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F66144300;
	Mon, 22 Apr 2024 10:30:51 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C2143C51
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781851; cv=none; b=REplN5yLvEZ5QzFl0tSCRBLtASLLucS242DrKEGg9gsm7GQ3QhCoCzIpHJrb6G4FuADgB9A1aXwFXpkkrFXNgKGCFyPFzf2F0v72ssErUL1Nt/Xa5Z/KjeHtDgfCfGzKWkcjVHjqVxBmBpT8HmjTLa17JjTfErV/qePjnhK/+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781851; c=relaxed/simple;
	bh=XUpU/WsAuGiRymcAesknj0rNtivwE8CJFMdxaXR4K1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wu18C+ZPTM4pnZiDXOK2etW4x8hC8pP4jklJGHVjFVompK7Tm3Ax8ZmtnzBmY8FKZsK5mE1vDHtpB+RFUXarqSbpI5X3gR8wtyiPBLUjyIfXjtP7zYFIXqo7GuYJks6pU+BNJgcY4SsI9rvl+iL2x43mWtk4g0uj6yitqGbZiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by baptiste.telenet-ops.be with bizsmtp
	id EAWj2C00N0SSLxL01AWjQj; Mon, 22 Apr 2024 12:30:45 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqw1-001cw4-8e;
	Mon, 22 Apr 2024 12:30:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqwd-005i3l-9B;
	Mon, 22 Apr 2024 12:30:43 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 05/11] Revert "drm: Switch DRM_DISPLAY_HDMI_HELPER to depends on"
Date: Mon, 22 Apr 2024 12:30:33 +0200
Message-Id: <bd288a5943dab8609f2d1f2bf413595a61df727a.1713780345.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713780345.git.geert+renesas@glider.be>
References: <cover.1713780345.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f6d2dc03fa8546b284dd8c1af027d9fac5725921, as helper
code should always be selected by the driver that needs it, for the
convenience of the final user configuring a kernel.

The user who configures a kernel should not need to know which helpers
are needed for the driver he is interested in.  Making a driver depend
on helper code means that the user needs to know which helpers to enable
first, which is very user-unfriendly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 2 +-
 drivers/gpu/drm/bridge/synopsys/Kconfig | 2 +-
 drivers/gpu/drm/display/Kconfig         | 1 -
 drivers/gpu/drm/i915/Kconfig            | 2 +-
 drivers/gpu/drm/nouveau/Kconfig         | 2 +-
 drivers/gpu/drm/tegra/Kconfig           | 2 +-
 drivers/gpu/drm/vc4/Kconfig             | 2 +-
 drivers/gpu/drm/xe/Kconfig              | 2 +-
 8 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index b0365cc1374ee50a..1662dc49f18ed11e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -5,12 +5,12 @@ config DRM_AMDGPU
 	depends on DRM
 	depends on DRM_DISPLAY_DP_HELPER
 	depends on DRM_DISPLAY_HDCP_HELPER
-	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	depends on MMU
 	depends on PCI
 	depends on !UML
 	select FW_LOADER
+	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_KMS_HELPER
 	select DRM_SCHED
 	select DRM_TTM
diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
index 387f5bd86089fb5c..f366ece471462a70 100644
--- a/drivers/gpu/drm/bridge/synopsys/Kconfig
+++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_DW_HDMI
 	tristate
-	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_KMS_HELPER
 	select REGMAP_MMIO
 	select CEC_CORE if CEC_NOTIFIER
diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index 01f2a231aa5f04bd..d65f1a37c08c7cf8 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -74,6 +74,5 @@ config DRM_DISPLAY_HDCP_HELPER
 config DRM_DISPLAY_HDMI_HELPER
 	bool "DRM HDMI Helpers"
 	depends on DRM_DISPLAY_HELPER
-	default y
 	help
 	  DRM display helpers for HDMI.
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 4f0d18a16b0f4f99..87ef8c4d72a53768 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -4,7 +4,6 @@ config DRM_I915
 	depends on DRM
 	depends on DRM_DISPLAY_DP_HELPER
 	depends on DRM_DISPLAY_HDCP_HELPER
-	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	depends on X86 && PCI
 	depends on !PREEMPT_RT
@@ -14,6 +13,7 @@ config DRM_I915
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
 	select TMPFS
+	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	select DRM_MIPI_DSI
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 4c10b400658c519c..7cc305b2826d6abc 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -3,12 +3,12 @@ config DRM_NOUVEAU
 	tristate "Nouveau (NVIDIA) cards"
 	depends on DRM
 	depends on DRM_DISPLAY_DP_HELPER
-	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	depends on PCI
 	depends on MMU
 	select IOMMU_API
 	select FW_LOADER
+	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select DRM_TTM_HELPER
diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 6974caa99ece94e1..bb6e35261f1144b1 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -6,9 +6,9 @@ config DRM_TEGRA
 	depends on DRM
 	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_DP_HELPER
-	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
+	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
index 4801f8b64d3d70cd..98772a6b5bf0df54 100644
--- a/drivers/gpu/drm/vc4/Kconfig
+++ b/drivers/gpu/drm/vc4/Kconfig
@@ -4,13 +4,13 @@ config DRM_VC4
 	depends on ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on DRM
-	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	depends on PM
 	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
 	# happen when COMPILE_TEST=y, hence the added !RASPBERRYPI_FIRMWARE.
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	depends on SND && SND_SOC
+	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_PANEL_BRIDGE
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index bfa0e9d4bd64f83b..1fa8ef75823c7a6b 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -5,7 +5,6 @@ config DRM_XE
 	depends on DRM
 	depends on DRM_DISPLAY_DP_HELPER
 	depends on DRM_DISPLAY_HDCP_HELPER
-	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	depends on MMU
 	depends on PCI
@@ -20,6 +19,7 @@ config DRM_XE
 	select DRM_KUNIT_TEST_HELPERS if DRM_XE_KUNIT_TEST != n
 	select DRM_PANEL
 	select DRM_SUBALLOC_HELPER
+	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_MIPI_DSI
 	select RELAY
 	select IRQ_WORK
-- 
2.34.1



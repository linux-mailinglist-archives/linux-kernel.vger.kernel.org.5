Return-Path: <linux-kernel+bounces-153187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30908ACAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208941C21037
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E841474B4;
	Mon, 22 Apr 2024 10:31:01 +0000 (UTC)
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790E146A64
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781861; cv=none; b=JgwiDrjmbrev8JzDornlF6fMhoCD+dnAMQnfPcJz3Te5MsuDsK9feI8GVPclUJg1A4sVLQtG5YnOsYrnNLRxeQQwxiTqeAh+2OsvZVT/JuhHObAbLlAbw8yfCMa9zFnzcuRKMysNLHPPONC56DC+2y/WSF07KAa3j7OPAkCb8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781861; c=relaxed/simple;
	bh=t6bE9D/9V+hTMJnLOjbZez/lE8xZv1fJAq5Agn8AEu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXkDLvwCJopRoCnUkMKJRnd1T+wsV1a8sxAM2cFzwj9cUN+J8jAbBgDfuMDPWmpXgxIh4+jFpET4j1GjdS8a6U+YrmW/r4a3fhg9u9adst7Xs+z/8LGyMQeVAg9ftqeQOqISL3AeRQt6OPwj/0280j2KeC2IKyhu+PrxKv26coM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4VNM3J2VHDz4wxLq
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:30:52 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id EAWj2C00C0SSLxL06AWjTs; Mon, 22 Apr 2024 12:30:45 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqw1-001cvu-64;
	Mon, 22 Apr 2024 12:30:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqwd-005i3d-7J;
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
Subject: [PATCH 03/11] Revert "drm/bridge: dw-hdmi: Make DRM_DW_HDMI selectable"
Date: Mon, 22 Apr 2024 12:30:31 +0200
Message-Id: <b2d1a7a765e4af249f4c450383de6e8422647e2e.1713780345.git.geert+renesas@glider.be>
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

This reverts commit 0209df3b4731516fe77638bfc52ba2e9629c67cd, as the
commit it fixes (which is BTW not the commit in the Fixes: tag!) will be
reverted, too.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/bridge/synopsys/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
index 1252fd30d4a4b461..387f5bd86089fb5c 100644
--- a/drivers/gpu/drm/bridge/synopsys/Kconfig
+++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_DW_HDMI
-	tristate "Synopsys Designware HDMI TX Controller"
+	tristate
 	depends on DRM_DISPLAY_HDMI_HELPER
 	depends on DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
-- 
2.34.1



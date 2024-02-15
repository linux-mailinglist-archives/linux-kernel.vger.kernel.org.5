Return-Path: <linux-kernel+bounces-66974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C899C85643F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C01F21FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2190130AC3;
	Thu, 15 Feb 2024 13:24:30 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B34128837
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003470; cv=none; b=Gax4dlhpicAX1rno7+AePQWRUdADaMlm4we1uLE7RPBwvINPgG5p1Pg97DId6JTG/qVk2xB1hJ6vvIlTSsbQYSZnc5crHXhl4gN5nyYzIq6FLUMTf3NUcBAZMOvsoEsyMdHa4zrghO7VQsZXXTwyBXQTYItLAqjW4Qt4mW8uJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003470; c=relaxed/simple;
	bh=ud5zx639kh7LwVIwoAyowojHtt9A2TaQ1M0GVxIgQ2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6HdWakTvsdXWhofxAEHurvaSoe3Z/11Re0Cq6Y6hV9337qr9D2DBTk2VS0UkHiL3V/k/552mwBXZEJ+EuDcOjLQjOpUUfPylm0uMPESDQP3rTXcJsWHePrmCoI6r4P0PIQSu6fhq/bcXspIDEX/mYhO2ZcQLerdASGcCPu7OQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by xavier.telenet-ops.be with bizsmtp
	id nRQG2B00U0LVNSS01RQGbY; Thu, 15 Feb 2024 14:24:21 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabij-000gyw-E4;
	Thu, 15 Feb 2024 14:24:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabiq-00HZgK-PB;
	Thu, 15 Feb 2024 14:24:16 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] drm: Spelling s/hardward/hardware/g
Date: Thu, 15 Feb 2024 14:24:15 +0100
Message-Id: <94c9b76ee906d1b790dfcc435f4221b1197df586.1708003402.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspellings of "hardware".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
v2:
  - Add Reviewed-by.
---
 include/drm/drm_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index e39da5807ba71c2d..57d647722cf79704 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -107,7 +107,7 @@ struct drm_bridge_funcs {
 	 * Since this function is both called from the check phase of an atomic
 	 * commit, and the mode validation in the probe paths it is not allowed
 	 * to look at anything else but the passed-in mode, and validate it
-	 * against configuration-invariant hardward constraints. Any further
+	 * against configuration-invariant hardware constraints. Any further
 	 * limits which depend upon the configuration can only be checked in
 	 * @mode_fixup.
 	 *
-- 
2.34.1



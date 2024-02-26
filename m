Return-Path: <linux-kernel+bounces-80996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E8866EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B330D1F26464
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92AF76044;
	Mon, 26 Feb 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hwLbvwyC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SYY/3zp7"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1E73F38
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938085; cv=none; b=rVwgdPDLkfPHtLXtoUHBMIPTeEEqn0sRy1ZU/BZLU0KQbYRjrJy+j44/YjuTYj6fcGi6KLMHxrUhG0ax64GOq83XdgwNGYtqroY9g3RRF3duHOXTcqXHDBFi0208jRGLKrfJAYYYmG/NvUZVHI4KUHLKsNfBGQmlcaLxXNMrb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938085; c=relaxed/simple;
	bh=AekaovUwYdpBZWADqweYZwJLmuNvX/G38sf66ZdKDjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L9MESH4kzqoHONK2QsmkVBHooxVUw5danMhAFE6e7QPkz1diqQf0a9j4MDDKtYgZlR7W2Veo8H7B1Qxuef8NAJb463dxoLJsp+9dQRaHHEJIFIwLXVPrr849Pvde78y2Coeaz90mQWlqWw5+vUcFDgF1tpb9lBzo4y49KEfp6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=hwLbvwyC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=SYY/3zp7 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708938082; x=1740474082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1dfSttFAckwOQAmC1ve5LgiPNLJsHK4JP7XZDTkYNuA=;
  b=hwLbvwyC73Ihtbj6LFaqNANAmr+kcOFYCNLuiCRdfPk9pFIzymiwCqWw
   nsO7wS9Y0Dtp+GayKHo4XfJ/mU1a5mSROJosftN+G0YNJrI1X5qqvHJgu
   dJ9TIZxY9S73QONnJxpLVR/A9vTExzGSs/bznBudTzudOJ1M96ujkTkr4
   IYSgDcQNlVw6ZYafG8AtU6ipxox34nNLLAaN++5DvjliN+wP/bk08TRSF
   Mvb+8fNV+MAa1wa7hcNUmlqHmXgagsHMbpUZd0f/zfF3zt+Iy9XbU+Bok
   M0r9ywuvDBDsRRsyt3ACO+7d5G7cZQ9kxEmmzyTA3UH3eyMmHbt2pYdup
   A==;
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="35589021"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Feb 2024 10:01:13 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08F11161427;
	Mon, 26 Feb 2024 10:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708938069; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1dfSttFAckwOQAmC1ve5LgiPNLJsHK4JP7XZDTkYNuA=;
	b=SYY/3zp7x8QiKOHJcB7rCv+tbl44IANZ19yC++/0yXIFGaNJht1DExfMIudv0YEJsgcTBc
	1zVxrLvigteiBy5ovJvSZSqeuHsKgd27UHkG2IAcVwUliifs7Q/UfP9AlrNxJPzNztl6bc
	m4s/ZKYvK2zchPUylpzkp0C4Vou/1c8o3+UNw/RXixLWXqV94Zo58VjhQqKA1FzC1PqB9X
	ntxhnIWtwK3aUe+CER7IZAw0eaK9ByEilq9Feowl+oDBFdh1/29P+65MPGqDF2LwD2/win
	WKNPk48agcvc9+H9npwk5nSDFu3IKjdKCZbqqXT0e2AxwJ4cvbPK9PJU7b9ULA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] drm/bridge: Silence error messages upon probe deferral
Date: Mon, 26 Feb 2024 09:59:18 +0100
Message-Id: <20240226085918.264205-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When -EPROBE_DEFER is returned do not raise an error, but silently return
this error instead. Fixes error like this:
[drm:drm_bridge_attach] *ERROR* failed to attach bridge
  /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517
[drm:drm_bridge_attach] *ERROR* failed to attach bridge
  /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
Changes in v3:
* Adjust the indentation
* Proper line breaks in commit messages

 drivers/gpu/drm/drm_bridge.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 521a71c61b164..08b474d82c9fc 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -353,13 +353,15 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	bridge->encoder = NULL;
 	list_del(&bridge->chain_node);
 
+	if (ret != -EPROBE_DEFER) {
 #ifdef CONFIG_OF
-	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
-		  bridge->of_node, encoder->name, ret);
+		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
+			  bridge->of_node, encoder->name, ret);
 #else
-	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
-		  encoder->name, ret);
+		DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
+			  encoder->name, ret);
 #endif
+	}
 
 	return ret;
 }
-- 
2.34.1



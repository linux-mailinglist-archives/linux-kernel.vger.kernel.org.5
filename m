Return-Path: <linux-kernel+bounces-111347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94878886AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506B5282F54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D23E479;
	Fri, 22 Mar 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EGI2bvKt"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5CF3D0D9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105540; cv=none; b=WRQamMTg8zGBIOqp2V0eN5+La73lA6p2+CjSIoKbzqr+toH6a/DYvBefAskSYybGSk84IUkCQJDQFhFmM3IhXI85zbYDg8rqufS6TRw0oGsotXxK+bwOf6Hj6yl3Rwhkc0CVDz2pFiADuXWKh4FAnH2RIIbNEi5BONrvtq/hNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105540; c=relaxed/simple;
	bh=Was4C+ESu5JAiwUHW6xmTjdvg1OJtFhRQJ3CzQTJRjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bn59egfQVFFkKH223NRNdbkQCQdjzyNmWsM86Mw9kaLBPfQjIacSrHyCuMU3vBozuOrYDIwngVZNjPK15MA3FxsjlbVFpIGjzOwNfV+gw/XH57O5UHI1OK6Tpyly0BqbwvmS6P3qbjlPkHQqSW7uerkkPwdv0cs5twnPrig/uQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EGI2bvKt; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=J9CuZ33LUi+k6FzE7felhvKpLH81dmZUIoVLkX9iVZc=; b=EGI2bvKt0dsRuvymeSTE44Lu0C
	0dY91Sy6D7CK+hkso1Zc+qs3iwd2r8eSK48LENFGHkTjwZdiDjZ7+yx1AoUVhC8q4hBiCAQkWYbJS
	wrH8OKsCg1NdlTi8egsT96mJyYWS0/3XkZPGHG4VbD7NBE6KryqudkAty571UJoz6tja6gOdhzyAD
	DTwM0GQRaQ5+SFWH9dHvORKJ+nk8wsCixkvZPLOlUSYF5gOLnXG0lTt+lktVXLkCRIdlPXLUbtfid
	fmUSGQg7AtwpXEUZbt4c+zts15I1jhjPAhRro7UEeVSvRQvnY87RDefXL6XnST34mgRnqWsG4aYcI
	DySFbOHw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1rncRL-000B01-On; Fri, 22 Mar 2024 11:47:59 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1rncRK-00G8Yg-1h;
	Fri, 22 Mar 2024 11:47:58 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Robert Foss <rfoss@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Sean Nyekjaer <sean@geanix.com>,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/stm: dsi: relax mode_valid clock tolerance
Date: Fri, 22 Mar 2024 11:47:31 +0100
Message-ID: <20240322104732.2327060-1-sean@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27222/Fri Mar 22 09:30:59 2024)

When using the DSI interface via DSI2LVDS bridge, it seems a bit harsh
to reguire the requested and the actual px clock to be within
50Hz. A typical LVDS display requires the px clock to be within +-10%.

In case for HDMI .5% tolerance is required.

Fixes: e01356d18273 ("drm/stm: dsi: provide the implementation of mode_valid()")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index d5f8c923d7bc..97936b0ef702 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -322,8 +322,6 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
 	return 0;
 }
 
-#define CLK_TOLERANCE_HZ 50
-
 static enum drm_mode_status
 dw_mipi_dsi_stm_mode_valid(void *priv_data,
 			   const struct drm_display_mode *mode,
@@ -375,9 +373,10 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
 		/*
 		 * Filter modes according to the clock value, particularly useful for
 		 * hdmi modes that require precise pixel clocks.
+		 * Check that px_clock is within .5% tolerance.
 		 */
-		if (px_clock_hz < target_px_clock_hz - CLK_TOLERANCE_HZ ||
-		    px_clock_hz > target_px_clock_hz + CLK_TOLERANCE_HZ)
+		if (px_clock_hz < mult_frac(target_px_clock_hz, 995, 1000) ||
+		    px_clock_hz > mult_frac(target_px_clock_hz, 1005, 1000))
 			return MODE_CLOCK_RANGE;
 
 		/* sync packets are codes as DSI short packets (4 bytes) */
-- 
2.44.0



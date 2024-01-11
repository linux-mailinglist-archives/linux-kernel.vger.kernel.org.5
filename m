Return-Path: <linux-kernel+bounces-23225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F40F82A92C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13731F24CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1669D101C5;
	Thu, 11 Jan 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fw+AI9iV"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55482FC02
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=hIIhJMzptMNoGjn+eB
	6+tS402J6MeF/y18vxlmoiacU=; b=fw+AI9iVomMHhAjUctpac32C9CXrLB4EU/
	J7YOg3q4dr/uzgK7xlqI2+awoVzvYrIlt2xrxoHH95cHxrh9p3o4qGAOifuFwDJO
	gJtE9MgL+XgaN5NMscWCEe/rhYPp8Wm6NESaUhYbmrLVUwYYJyCTaUO/fjy7svM1
	hsMvKvP/Q=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3P2elp59lm66VAA--.22689S2;
	Thu, 11 Jan 2024 16:32:37 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in radeon_audio.c
Date: Thu, 11 Jan 2024 08:32:35 +0000
Message-Id: <20240111083235.12152-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P2elp59lm66VAA--.22689S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy5Xry5ZFyxGr4UJryDtrb_yoW8tryrpa
	17ua9YyrZIk34DWryxAFZxJFWYgw1kJa1xZrWDuw1fG393tryDXa4aqryUCFyrJFyFgay7
	tr1kKw12v3Wvkr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFdgAUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEg1i1mVOBk-vRgAAsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"
ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 91b58fbc2be7..74753bb26d33 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -37,15 +37,14 @@
 
 void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin *pin,
 		u8 enable_mask);
-struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
-struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
+struct r600_audio_pin *r600_audio_get_pin(struct radeon_device *rdev);
+struct r600_audio_pin *dce6_audio_get_pin(struct radeon_device *rdev);
 static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode);
 
-static const u32 pin_offsets[7] =
-{
+static const u32 pin_offsets[7] = {
 	(0x5e00 - 0x5e00),
 	(0x5e18 - 0x5e00),
 	(0x5e30 - 0x5e00),
@@ -361,7 +360,7 @@ static void radeon_audio_write_latency_fields(struct drm_encoder *encoder,
 		radeon_encoder->audio->write_latency_fields(encoder, connector, mode);
 }
 
-struct r600_audio_pin* radeon_audio_get_pin(struct drm_encoder *encoder)
+struct r600_audio_pin *radeon_audio_get_pin(struct drm_encoder *encoder)
 {
 	struct radeon_device *rdev = encoder->dev->dev_private;
 	struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
@@ -528,7 +527,7 @@ static void radeon_audio_calc_cts(unsigned int clock, int *CTS, int *N, int freq
 		*N, *CTS, freq);
 }
 
-static const struct radeon_hdmi_acr* radeon_audio_acr(unsigned int clock)
+static const struct radeon_hdmi_acr *radeon_audio_acr(unsigned int clock)
 {
 	static struct radeon_hdmi_acr res;
 	u8 i;
-- 
2.17.1



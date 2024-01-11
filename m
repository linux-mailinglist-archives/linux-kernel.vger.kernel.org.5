Return-Path: <linux-kernel+bounces-23221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317AF82A91D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBADF28580F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2640DF57;
	Thu, 11 Jan 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TlJiP1Vo"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEDDF4F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=2uSs31ukJxhgyhtx6q
	nqpA4J3ZjguzlrdPXS+K8YQ9U=; b=TlJiP1Von4h/wT+OnnmoWgc/c2Rdmi2Twf
	PElX1EvXVD9+iONV8/jINPYq/QXhMfcvpBKJjngVWx5GM1aZDcAXR3TQU3YQ6TT1
	fir6xSkOencFfWjg9cbo9tuh/W6L+x2H0p85BEGBpusrYR++FdqTvQgi/L/7Idm7
	jzHmzEcmc=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3XwaRpp9lI7mVAA--.18703S2;
	Thu, 11 Jan 2024 16:28:01 +0800 (CST)
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
Subject: [PATCH] drm/radeon: Clean up errors in radeon_audio.h
Date: Thu, 11 Jan 2024 08:27:59 +0000
Message-Id: <20240111082759.11978-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3XwaRpp9lI7mVAA--.18703S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF1kXF13tr13Wr4rXF47Arb_yoW8JF4Upa
	17u3s0yrZxK347WryxAFZ8Ar43K3W8Ja18uFWDuw15ursxtry8XFyaqr1rAF1rJr1Sk39r
	trn7K347Za40yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFdgAUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEhxi1mVOBk+X-AAEs3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/radeon_audio.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.h b/drivers/gpu/drm/radeon/radeon_audio.h
index dacaaa007051..a073dadd0638 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.h
+++ b/drivers/gpu/drm/radeon/radeon_audio.h
@@ -34,8 +34,7 @@ struct cea_sad;
 #define WREG32_ENDPOINT(block, reg, v)	\
 	radeon_audio_endpoint_wreg(rdev, (block), (reg), (v))
 
-struct radeon_audio_basic_funcs
-{
+struct radeon_audio_basic_funcs {
 	u32  (*endpoint_rreg)(struct radeon_device *rdev, u32 offset, u32 reg);
 	void (*endpoint_wreg)(struct radeon_device *rdev,
 		u32 offset, u32 reg, u32 v);
@@ -43,8 +42,7 @@ struct radeon_audio_basic_funcs
 		struct r600_audio_pin *pin, u8 enable_mask);
 };
 
-struct radeon_audio_funcs
-{
+struct radeon_audio_funcs {
 	void (*select_pin)(struct drm_encoder *encoder);
 	struct r600_audio_pin* (*get_pin)(struct radeon_device *rdev);
 	void (*write_latency_fields)(struct drm_encoder *encoder,
-- 
2.17.1



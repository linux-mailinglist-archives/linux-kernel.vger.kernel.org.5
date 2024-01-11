Return-Path: <linux-kernel+bounces-23290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C982AA83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F90A1F22B66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAE111A5;
	Thu, 11 Jan 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HZWDLfxE"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF311719
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=mLot53AR6aiH5Wu6Ry
	wzmhBMvsIGYJAJhAMQ1/Sq9gY=; b=HZWDLfxEy0lzzfSLeDN2b1JqyKcD/l6VKF
	aSJsMuvz1/7N73jCF+Ir161PXR4zP7LP6TJ/UFjiO4bMWoU72vmwTpwonvAGk/94
	+EJvtmYMuoMNMLU5dWmdutQRA67zwRTxlys7e6uUHFeZoDvUMol9aWsW9bvP/srg
	40uOm10BQ=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3H6Vir59ldLCXAA--.13381S2;
	Thu, 11 Jan 2024 17:05:38 +0800 (CST)
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
Subject: [PATCH] drm/radeon/kms: Clean up errors in smu7.h
Date: Thu, 11 Jan 2024 09:05:36 +0000
Message-Id: <20240111090536.13410-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H6Vir59ldLCXAA--.13381S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kXF13tr13WF4fCr1kGrg_yoWDZFb_CF
	1qg3Z5WrZFkFyvqr17AFW7CFZIyF4qvw1xK34Fg34fXrnIqa13urWvkrW7Xw1rWayfXF90
	yan0vF1fAFsxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU9mR7UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEhVi1mVOBlC+9wAAsH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/smu7.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/smu7.h b/drivers/gpu/drm/radeon/smu7.h
index 75a380a15292..985d720dbc0d 100644
--- a/drivers/gpu/drm/radeon/smu7.h
+++ b/drivers/gpu/drm/radeon/smu7.h
@@ -82,8 +82,7 @@
 #define SCRATCH_B_CURR_SAMU_INDEX_MASK  (0x7<<SCRATCH_B_CURR_SAMU_INDEX_SHIFT)
 
 
-struct SMU7_PIDController
-{
+struct SMU7_PIDController {
     uint32_t Ki;
     int32_t LFWindupUL;
     int32_t LFWindupLL;
@@ -117,8 +116,7 @@ typedef struct SMU7_PIDController SMU7_PIDController;
 #define SMU7_VCE_MCLK_HANDSHAKE_DISABLE                  0x00010000
 #define SMU7_VCE_SCLK_HANDSHAKE_DISABLE                  0x00020000
 
-struct SMU7_Firmware_Header
-{
+struct SMU7_Firmware_Header {
     uint32_t Digest[5];
     uint32_t Version;
     uint32_t HeaderSize;
-- 
2.17.1



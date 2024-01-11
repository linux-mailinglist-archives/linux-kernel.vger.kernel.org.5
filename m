Return-Path: <linux-kernel+bounces-23246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC0A82A9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749652866D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980FFC1D;
	Thu, 11 Jan 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AW1ay7qq"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7BF9EA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=3mOu7B5TwCh/UrgYIi
	3ICtQsQIqk+hEu+An0A0r7hSw=; b=AW1ay7qqTvcGT6WUmCA0QvWg8WY6fVXao4
	bclxgHc13473aBhFimqN4S6KxS1rfxa4ancI5KDC4sl10ro1xuzA9ZP0dMufZZca
	uvI2DcDmY7LMXB+DBiH6dqkSqmvHM+IA676JeLqb5RhqSgAnTQNGhFipKxYQas05
	rSxiCcGng=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wC3R+YvrJ9lZyuXAA--.19791S2;
	Thu, 11 Jan 2024 16:52:00 +0800 (CST)
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
Subject: [PATCH] drm/radeon: Clean up errors in evergreen.c
Date: Thu, 11 Jan 2024 08:51:58 +0000
Message-Id: <20240111085158.12719-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wC3R+YvrJ9lZyuXAA--.19791S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4DGryxZF4xtr4rury3urg_yoWrXr15pr
	Z7XFyfKrsYy3Z0y3yxAF9rXFWUK3s3Za4IkF43Gw4xua45WryaqFyxu347Aa4UXrW2qa42
	y3Z8try7XrWFya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwFxUUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBBi1mVOBlBgeAAAsR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: spaces required around that '&=' (ctx:WxO)
ERROR: space required before that '~' (ctx:OxV)
ERROR: space prohibited before that close parenthesis ')'
ERROR: space required after that ',' (ctx:WxO)
ERROR: space required before that '&' (ctx:OxV)
ERROR: need consistent spacing around '*' (ctx:VxW)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/evergreen.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index a424b86008b8..c634dc28e6c3 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -2514,8 +2514,7 @@ static void evergreen_agp_enable(struct radeon_device *rdev)
 	WREG32(VM_CONTEXT1_CNTL, 0);
 }
 
-static const unsigned ni_dig_offsets[] =
-{
+static const unsigned ni_dig_offsets[] = {
 	NI_DIG0_REGISTER_OFFSET,
 	NI_DIG1_REGISTER_OFFSET,
 	NI_DIG2_REGISTER_OFFSET,
@@ -2524,8 +2523,7 @@ static const unsigned ni_dig_offsets[] =
 	NI_DIG5_REGISTER_OFFSET
 };
 
-static const unsigned ni_tx_offsets[] =
-{
+static const unsigned ni_tx_offsets[] = {
 	NI_DCIO_UNIPHY0_UNIPHY_TX_CONTROL1,
 	NI_DCIO_UNIPHY1_UNIPHY_TX_CONTROL1,
 	NI_DCIO_UNIPHY2_UNIPHY_TX_CONTROL1,
@@ -2534,8 +2532,7 @@ static const unsigned ni_tx_offsets[] =
 	NI_DCIO_UNIPHY5_UNIPHY_TX_CONTROL1
 };
 
-static const unsigned evergreen_dp_offsets[] =
-{
+static const unsigned evergreen_dp_offsets[] = {
 	EVERGREEN_DP0_REGISTER_OFFSET,
 	EVERGREEN_DP1_REGISTER_OFFSET,
 	EVERGREEN_DP2_REGISTER_OFFSET,
@@ -2544,8 +2541,7 @@ static const unsigned evergreen_dp_offsets[] =
 	EVERGREEN_DP5_REGISTER_OFFSET
 };
 
-static const unsigned evergreen_disp_int_status[] =
-{
+static const unsigned evergreen_disp_int_status[] = {
 	DISP_INTERRUPT_STATUS,
 	DISP_INTERRUPT_STATUS_CONTINUE,
 	DISP_INTERRUPT_STATUS_CONTINUE2,
@@ -2643,7 +2639,7 @@ static void evergreen_blank_dp_output(struct radeon_device *rdev,
 		return;
 	}
 
-	stream_ctrl &=~EVERGREEN_DP_VID_STREAM_CNTL_ENABLE;
+	stream_ctrl &= ~EVERGREEN_DP_VID_STREAM_CNTL_ENABLE;
 	WREG32(EVERGREEN_DP_VID_STREAM_CNTL +
 	       evergreen_dp_offsets[dig_fe], stream_ctrl);
 
@@ -2655,7 +2651,7 @@ static void evergreen_blank_dp_output(struct radeon_device *rdev,
 		stream_ctrl = RREG32(EVERGREEN_DP_VID_STREAM_CNTL +
 				     evergreen_dp_offsets[dig_fe]);
 	}
-	if (counter >= 32 )
+	if (counter >= 32)
 		DRM_ERROR("counter exceeds %d\n", counter);
 
 	fifo_ctrl = RREG32(EVERGREEN_DP_STEER_FIFO + evergreen_dp_offsets[dig_fe]);
@@ -2716,7 +2712,7 @@ void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_save *sav
 			/*for now we do it this manually*/
 			/**/
 			if (ASIC_IS_DCE5(rdev) &&
-			    evergreen_is_dp_sst_stream_enabled(rdev, i ,&dig_fe))
+			    evergreen_is_dp_sst_stream_enabled(rdev, i, &dig_fe))
 				evergreen_blank_dp_output(rdev, dig_fe);
 			/*we could remove 6 lines below*/
 			/* XXX this is a hack to avoid strange behavior with EFI on certain systems */
@@ -3597,7 +3593,7 @@ static void evergreen_gpu_init(struct radeon_device *rdev)
 
 	sq_lds_resource_mgmt = RREG32(SQ_LDS_RESOURCE_MGMT);
 
-	sq_gpr_resource_mgmt_1 = NUM_PS_GPRS((rdev->config.evergreen.max_gprs - (4 * 2))* 12 / 32);
+	sq_gpr_resource_mgmt_1 = NUM_PS_GPRS((rdev->config.evergreen.max_gprs - (4 * 2)) * 12 / 32);
 	sq_gpr_resource_mgmt_1 |= NUM_VS_GPRS((rdev->config.evergreen.max_gprs - (4 * 2)) * 6 / 32);
 	sq_gpr_resource_mgmt_1 |= NUM_CLAUSE_TEMP_GPRS(4);
 	sq_gpr_resource_mgmt_2 = NUM_GS_GPRS((rdev->config.evergreen.max_gprs - (4 * 2)) * 4 / 32);
-- 
2.17.1



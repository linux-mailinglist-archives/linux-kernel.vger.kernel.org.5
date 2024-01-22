Return-Path: <linux-kernel+bounces-33222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B98366A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D1A1F2459E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535A04879F;
	Mon, 22 Jan 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqTNv0lU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9348793;
	Mon, 22 Jan 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935388; cv=none; b=TqenxX68t0r4qd5RDnmkwbMKFjiZIkXtZOIMGEgt4Stcyc+vAFr6yPbVKKsqO6K5GyeAJJBiIAj5qI5JD6APr+8DN6E4oCMXolFqexq+SrCcYFot3SUPUILFpDFWpqV4WjSksUWpViKSR5TqDhh8M8z59WgHC9cTQemZr+JXk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935388; c=relaxed/simple;
	bh=HRrKJOUg5nC8JCuJ66AxXPoZIyFszxe3CsXBkv7E+Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+FR9HeBcz0spfoffNEz+NBca8uio4iZCq6CZQ5F2Xmq0MNs2/BLX721M+y61Hb+lzSSR9aN2euIYTp500K1Po78+41jo1+UMFpGv/iKkItYQH/r6Dgqo3oM6mOVUHxlFzX+t/2Lu+iwbcT452nQ3LfqNLoiQX2I6hCwtYR1j8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqTNv0lU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25943C433F1;
	Mon, 22 Jan 2024 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935388;
	bh=HRrKJOUg5nC8JCuJ66AxXPoZIyFszxe3CsXBkv7E+Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqTNv0lU+2y1ThhNld+uvVK98uQn39gWVInBjIlv+jhnIh8pAhw+tkTpEDl1lX5fN
	 k1UoagXLHNg3sNCYMD0o/EqPSGUPoWosCCswzSBwztZTRBH+LOcyMDDtZ2Bk6ijIjA
	 bCroKWFlwsBdzpmzAA79cWO4pYV3r1Pod/slL7DPsztSE9Ab785bPNjt4QCY7MMSSZ
	 PEyiIt5BXBweJ0GjErInty5vMZK6yuzaYT0HWXBI3sOpQeEeFvcZfTYxcz4S4xhsw1
	 S0eQypL9yMmL1EdXbGeSB8XBICUrNZTNbfMltfpQISvnasG7Ypt7wPOrGTZLUqpQm2
	 GW9OBXWHElURw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Danylo Piliaiev <dpiliaiev@igalia.com>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	dmitry.baryshkov@linaro.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	konrad.dybcio@linaro.org,
	quic_akhilpo@quicinc.com,
	dianders@chromium.org,
	andersson@kernel.org,
	cwabbott0@gmail.com,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 08/88] drm/msm/a690: Fix reg values for a690
Date: Mon, 22 Jan 2024 09:50:41 -0500
Message-ID: <20240122145608.990137-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Danylo Piliaiev <dpiliaiev@igalia.com>

[ Upstream commit 07e6de738aa6f0e873463e9ca88bdb7081c4bfd4 ]

KGSL doesn't support a690 so all reg values were the same as
on a660. Now we know the values and they are different from the
windows driver.

This fixes hangs on D3D12 games and some CTS tests.

Signed-off-by: Danylo Piliaiev <dpiliaiev@igalia.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/568931/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7a0220d29a23..500ed2d183fc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1312,6 +1312,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 
 	if (adreno_is_a650(adreno_gpu) ||
 	    adreno_is_a660(adreno_gpu) ||
+	    adreno_is_a690(adreno_gpu) ||
 	    adreno_is_a730(adreno_gpu) ||
 	    adreno_is_a740_family(adreno_gpu)) {
 		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
@@ -1321,13 +1322,6 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 		uavflagprd_inv = 2;
 	}
 
-	if (adreno_is_a690(adreno_gpu)) {
-		hbb_lo = 2;
-		amsbc = 1;
-		rgb565_predicator = 1;
-		uavflagprd_inv = 2;
-	}
-
 	if (adreno_is_7c3(adreno_gpu)) {
 		hbb_lo = 1;
 		amsbc = 1;
@@ -1741,7 +1735,9 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Setting the primFifo thresholds default values,
 	 * and vccCacheSkipDis=1 bit (0x200) for A640 and newer
 	*/
-	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu) || adreno_is_a690(adreno_gpu))
+	if (adreno_is_a690(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00800200);
+	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
 	else if (adreno_is_a640_family(adreno_gpu) || adreno_is_7c3(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
@@ -1775,6 +1771,8 @@ static int hw_init(struct msm_gpu *gpu)
 	if (adreno_is_a730(adreno_gpu) ||
 	    adreno_is_a740_family(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0xcfffff);
+	else if (adreno_is_a690(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x4fffff);
 	else if (adreno_is_a619(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3fffff);
 	else if (adreno_is_a610(adreno_gpu))
@@ -1808,12 +1806,17 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_set_cp_protect(gpu);
 
 	if (adreno_is_a660_family(adreno_gpu)) {
-		gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x1);
+		if (adreno_is_a690(adreno_gpu))
+			gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x00028801);
+		else
+			gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x1);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x0);
 	}
 
+	if (adreno_is_a690(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x90);
 	/* Set dualQ + disable afull for A660 GPU */
-	if (adreno_is_a660(adreno_gpu))
+	else if (adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x66906);
 	else if (adreno_is_a7xx(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG,
-- 
2.43.0



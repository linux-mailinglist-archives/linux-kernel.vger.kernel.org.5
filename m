Return-Path: <linux-kernel+bounces-154245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90358AD9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557B0286D12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F291159584;
	Mon, 22 Apr 2024 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol9kyWTF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7246521;
	Mon, 22 Apr 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830101; cv=none; b=jrVK4FLgcnhq3n1H24O0Udqy5IVCCYUFi5QVdrVIAz2CbP2E0aBRnUJOvLp+mF5d8/uQH13CgOkKHXZAdhqDYjS4AXee82MZMeimD1A3im4ipYCO+3T0sPGBX36XH3JDB7e+iXJaoYtvUaux2zDUc2kLtGjes49BSZUeV/pe1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830101; c=relaxed/simple;
	bh=MwuY0hLb+N6b9YB79jB7wWRz6DDBHF+sgVjco9EEbO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXUsLc7w8WdHZ6WTlSFb1BhWCTpQpTxpAfk4OBE5/YiWcoMLtSzHPlPZp1BQMwwwyqwwYHMuqYaHekeEKKAYXKj7Uu3fCvzBwl4coGMH1oM/QNVC4P+dzoPpUyHefhGBOCL5rmHbl4fQykgKsSednJwx790ajuSLZ8YCmM0EGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol9kyWTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F49C3277B;
	Mon, 22 Apr 2024 23:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830101;
	bh=MwuY0hLb+N6b9YB79jB7wWRz6DDBHF+sgVjco9EEbO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ol9kyWTFAm94kQuApkaCUnnP4G+JAueJpcCHG5V7ZIJ2hIyAOB8UbskPyLmg5M63N
	 rMibFgMsrykG9Ls4PPAuclkEOj2W5kZ0ZI9G6/hcUiB3Nvblr+jnblPdLnFgrteG9F
	 CI0nXqORkmoOGnmxUcdA5+0dwZW28bMSTuEeCBIC2diZ+us+ih699vConGmc4Gxiaj
	 uJOTPOu0VDCo2CmW2gGD2+XtJfnlyaw4DlUzIrycu1z494Y4g5xkg9l0j83nIi2Vj6
	 YOtw1sWlM5DwCaLq1vB+fpZ2Uvs6n4WpFu6u1dCEKu2scpduHv9L00z0Yyw5hpAvpS
	 KZ6pCw9KcChaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Ma <li.ma@amd.com>,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	joshua@froggi.es,
	haoping.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 27/43] drm/amd/display: add DCN 351 version for microcode load
Date: Mon, 22 Apr 2024 19:14:13 -0400
Message-ID: <20240422231521.1592991-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Li Ma <li.ma@amd.com>

[ Upstream commit d4396924c3d44f34d0643f650e70892e07f3677f ]

There is a new DCN veriosn 3.5.1 need to load

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 718e533ab46dd..0d3e553647993 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -147,6 +147,9 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 #define FIRMWARE_DCN_35_DMUB "amdgpu/dcn_3_5_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);
 
+#define FIRMWARE_DCN_351_DMUB "amdgpu/dcn_3_5_1_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
+
 /* Number of bytes in PSP header for firmware. */
 #define PSP_HEADER_BYTES 0x100
 
@@ -4776,6 +4779,9 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 0):
 		fw_name_dmub = FIRMWARE_DCN_35_DMUB;
 		break;
+	case IP_VERSION(3, 5, 1):
+		fw_name_dmub = FIRMWARE_DCN_351_DMUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
-- 
2.43.0



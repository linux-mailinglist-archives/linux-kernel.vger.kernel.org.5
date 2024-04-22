Return-Path: <linux-kernel+bounces-154246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333F8AD9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C9B26CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCA15990B;
	Mon, 22 Apr 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLi+Gp7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAE1598FE;
	Mon, 22 Apr 2024 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830104; cv=none; b=kbQyVjXEHOK0wl0avoyNqvJHYuXZ/Al4fBMo27ECbop3lfohkw79H8HkZzdhLmjvrNjwn555/1I1kA0eBfyNL+W40LVHIyfNEt8xNe+Je1OM7Hcghun2jIWBoszrPH7r8PC3y/w2DflRMJa5H1i90KnwYnuYl9Osp5Y/+a9oBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830104; c=relaxed/simple;
	bh=SCqaqHScQMAM4fAgeyxAFEvwYQwaAdVCBYbZCjn+uas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVWZOmUT6lLHO4cGL7AeyU3yU9zBz71+yaFiJFo3jPPuNrMxCYS101Rdr3yeXvnTa/FuRIsqhA37Rt5U62Cdo2Jb/FAekLX3006cw71heqW3pWzBEKRtT3k+8PSOtWQlpaHKgn/zp+mSA4tn7oi2cd0MdL83VJytIsTO78eqZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLi+Gp7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BA8C32782;
	Mon, 22 Apr 2024 23:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830104;
	bh=SCqaqHScQMAM4fAgeyxAFEvwYQwaAdVCBYbZCjn+uas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLi+Gp7oT1k8yUeZM6CeASG+pS3kDKRikzHuSU5W4uOwXiIpboZthsp7cTNkC3LQo
	 EwsyLNhcnzp/wP/dlaABjjD1ydLVSao4tonKhVgP/WV5mHURBdMGLsayteTJn5v3DZ
	 eiUfN6k/ww3mMJ9eBlmX4np/Xt2881FclD2VM8gXJKuGlgSQgq9HEfR5PlnE3wMSnA
	 w9eB4SoU9bmHRdh0E3qlYASnX1qkq0V3y9g2j5NjqH8D4b27bL5Ehav8lg9lypsFJy
	 XTSzKXI9n+oIShZY+kfpCkU1AuIQ2jDls/p3FbRamAnwyvs/fcK426Fo2zbWvc61PE
	 uVj3Lrykj/7RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	Prike.Liang@amd.com,
	Lang.Yu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 28/43] drm/amdgpu: add smu 14.0.1 discovery support
Date: Mon, 22 Apr 2024 19:14:14 -0400
Message-ID: <20240422231521.1592991-28-sashal@kernel.org>
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

From: Yifan Zhang <yifan1.zhang@amd.com>

[ Upstream commit 533eefb9be76c3b23d220ee18edfda8eb56cefff ]

This patch to add smu 14.0.1 support

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4f9900779ef9e..ff28265838ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1867,6 +1867,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	default:
-- 
2.43.0



Return-Path: <linux-kernel+bounces-101999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9887AD76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66AAB21707
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A7464CCB;
	Wed, 13 Mar 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM6OT3mD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9E14AD0E;
	Wed, 13 Mar 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348211; cv=none; b=EIdT+IbhVtox6Xy86EakXqovf/iIaAMgM/80cbaPEKVRJJF9YQVAIREIJxtWfKdF/RgeOwKv6pROAR44MS/hoxSCbAtQQWgw/jFI0KnD+8SUN0BcgcT4bK9lKfGH0NvF1aZ1pYUgZ7LGncczy0Kw+igTIgQ3Dxv+TnKQ9QXShmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348211; c=relaxed/simple;
	bh=XcA4zsHiHN6Jv8wny1OCHvfAqepR6uN0UFEN1AfWYN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg6TdS/aUSGM4HrUxqvA6Ft4ADEGelxOzK37NIsShA/2ny2dSXl4w7Vk3heBx7kfmJ+pIRSrS9+HdKlxEQS2Jy99YCfLirJLH9NcH8jgnx4bRlCgnKrii0dgeTAywv31ZvNzrn9fs6vpLFLE94NaRzAac+ig+QoAJnn/8lCQYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM6OT3mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F0FC433C7;
	Wed, 13 Mar 2024 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348211;
	bh=XcA4zsHiHN6Jv8wny1OCHvfAqepR6uN0UFEN1AfWYN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EM6OT3mDiD/PKKs54seaYwcOjZx2yYGi3Y4+yvlWnAmv7wCleyk9ls4fBFiD/UpKc
	 JG4RwNZz6JPGVpmOJj8aXjORcXlmFmfwny5rGNkJh5RtPa6NZQlYDtCV2y1FhQV/a9
	 YcFowPsLoeSZkvcyCBSOAyQOvE1X1wYzU1ZhG0gcYnd4rwIAuoPSYQJHiSdAnndKN4
	 CUqBEKpRlXaa35OvG5YIbpeW614b/r9j80rVXG/xQzbZXZFwb7N3dmuXOoFVPKpjWv
	 5B39rytLI077LqSpd4d3bltZfOlQ57HxD0zVG9dcV89R1VfG4kr5HeeGzMNcA+wSoP
	 tEystkGAz6h4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Magali Lemes <magalilemes00@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 58/76] drm/amd/display: remove DML Makefile duplicate lines
Date: Wed, 13 Mar 2024 12:42:05 -0400
Message-ID: <20240313164223.615640-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Magali Lemes <magalilemes00@gmail.com>

[ Upstream commit 41ead3e0cdc03d64b7da2dcb1fd70ebb7164228b ]

There are two identical CFLAGS entries for "display_mode_vba_20.o", so
remove one of them. Also, as there's already an entry for
"display_mode_lib.o" CFLAGS, regardless of CONFIG_DRM_AMD_DC_DCN being
defined or not, remove the one entry between CONFIG_DRM_AMD_DC_DCN ifdef
guards.

Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: e63e35f0164c ("drm/amd/display: Increase frame-larger-than for all display_mode_vba files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index c97fdfc36d0fd..93cc3086783fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -60,7 +60,6 @@ ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
@@ -71,7 +70,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
-- 
2.43.0



Return-Path: <linux-kernel+bounces-121227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E388E429
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE222A41C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD6C18C9D5;
	Wed, 27 Mar 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkvKGWKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82451411E1;
	Wed, 27 Mar 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542402; cv=none; b=XBC8kNyPRlwwkLTjfX3WakFETr5PxaLYcKNUTsbzpSP6BEN3TMMIthGW+FrJMf0jUOrITn0TUzHAnZ4N1Ch/VPnE9ICV7hFBg/dSEyoi8GTAr8e1FyIO+pf6hZSNOjH054/cyWImLR0x0YVy/yXRIi3NkaiucFBkeAmjoum1G0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542402; c=relaxed/simple;
	bh=pEtsKa8gK5hqjqregu5jZida+iQIstpz2eDtMNBXCSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwHoJt/Vz+5id6NhVnqUQzUOchodFtp4ghaiMqdFUla8gH6BBa0H0uTdH9d0DSDFpAJYTMN5yurGlKzJGLX5dz76c2GPv22RYJVNVKsCl8eZW5gNS24xQ4l1fqukCQFmgwo6LzPiclbaJTtl1pfK/wfwLx7kL7VOUafH/fuhNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkvKGWKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D62C433F1;
	Wed, 27 Mar 2024 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542402;
	bh=pEtsKa8gK5hqjqregu5jZida+iQIstpz2eDtMNBXCSw=;
	h=From:To:Cc:Subject:Date:From;
	b=SkvKGWKc9uAlAStUs6S8oFSdYAWBiofDWfVMJECdZA4NTF14YlWpJrCVp/WQ9prc+
	 duY35QVS5zFN4+gyuNxjfZqdricSn5tfKJ2gkVutDCFbvU/zpj4WAOWEH7CkTbtRhP
	 iKTCvbaGuFUOy1Ad2Sq6fwukZEivf+WtEXKgXaZyKBAvwr1YdDazAzbH3VcOvI3AhU
	 bpRk6M4b7TMSo0HZYZVmQtSf9+Qev8pwcCDxUlR45i2Zwi0gielAeWYFRdK/nE3Pcv
	 N7BFmeQYPPthWNFmkWBcH87nXiuPfurByrBxxLMBhKumjYfZ7/+vtLi5F9AjthD1zv
	 ubIae3TVrDZKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: FAILED: Patch "drm/amd/display: Increase frame-larger-than for all display_mode_vba files" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:40 -0400
Message-ID: <20240327122640.2841265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 321036db915bc647d04750337eb002022c912857 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 5 Feb 2024 14:54:05 -0700
Subject: [PATCH] drm/amd/display: Increase frame-larger-than for all
 display_mode_vba files

After a recent change in LLVM, allmodconfig (which has CONFIG_KCSAN=y
and CONFIG_WERROR=y enabled) has a few new instances of
-Wframe-larger-than for the mode support and system configuration
functions:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:3393:6: error: stack frame size (2144) exceeds limit (2048) in 'dml20v2_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
   3393 | void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        |      ^
  1 error generated.

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3520:6: error: stack frame size (2192) exceeds limit (2048) in 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
   3520 | void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        |      ^
  1 error generated.

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3286:6: error: stack frame size (2128) exceeds limit (2048) in 'dml20_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
   3286 | void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        |      ^
  1 error generated.

Without the sanitizers enabled, there are no warnings.

This was the catalyst for commit 6740ec97bcdb ("drm/amd/display:
Increase frame warning limit with KASAN or KCSAN in dml2") and that same
change was made to dml in commit 5b750b22530f ("drm/amd/display:
Increase frame warning limit with KASAN or KCSAN in dml") but the
frame_warn_flag variable was not applied to all files. Do so now to
clear up the warnings and make all these files consistent.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issue/1990
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 6042a5a6a44f8..59ade76ffb18d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -72,11 +72,11 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
-- 
2.43.0






Return-Path: <linux-kernel+bounces-120798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42288DDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3D28F5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA021304B8;
	Wed, 27 Mar 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kusuduHC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED812E1CE;
	Wed, 27 Mar 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541232; cv=none; b=sTcvoF4mBuY1c/vd28/NCklpz1Nr3zWSwWyvN82seOdVHmPugdrZAz4iTdz/SUSZYgBv39CujejFQTPpO9JJzWeJXoQF3UejpGES1MoR2WqxzID74mNdnvMmC2dXaDi6B/MhD5uZbuXqzKPF0zBJJqmZPJ+yN9WqUX1HDFZLCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541232; c=relaxed/simple;
	bh=CoSnL3qPQEJOccnboM8Yx9diAo3ePi4BoTAGB2yAXic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRvhJ01oDNgKEgPwGMjXO58pajDUqiGYtastNjJ19fuvzklDn1PVFWr5INHU/fj+5nnHLen+YGGalq8eNUnyf3Eo9xEGjucTPq22QbCju5hlgShn6HqH775HCptwEMI5DenNQHRv9130n9OU66j9gj558G8p0s6yvoKtbCPFF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kusuduHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369F2C433F1;
	Wed, 27 Mar 2024 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541232;
	bh=CoSnL3qPQEJOccnboM8Yx9diAo3ePi4BoTAGB2yAXic=;
	h=From:To:Cc:Subject:Date:From;
	b=kusuduHCFxJ2UTor5ojALVKldcK3CkkUOAGYBHYYY5APRWeU5S2a0qni1b11ZM9VQ
	 arBY6xHXhA9nZlPabBJhR9QTNMbRFLAu0oZcY+S6Zn5qbjOHxAmRTWN4aoB/tQPkp/
	 /N5RQBgCNwNBcHjjmRi/qHLg7gTG8+Yb1mjb3OPj+dARjNoT0tYNpIgceiVMhz19Jx
	 cgTM9SHzReK+iOLkgoqBs59PWHbZiCUAOaDDqJojmXWoZg8gy6k+M0nLKBn+Ovt6GC
	 VMJLplhH/QjcbpglpVlnNpqQxkjovhRVAy1iZfocGPLuFUO8vt8lcGJPnpSmUM/GLK
	 7SX1tdzRbbJyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: FAILED: Patch "drm/amd/display: Increase frame-larger-than for all display_mode_vba files" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:10 -0400
Message-ID: <20240327120710.2825195-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
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






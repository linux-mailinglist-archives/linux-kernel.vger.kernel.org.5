Return-Path: <linux-kernel+bounces-114886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92388928B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44E5B31188
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282B13D8B3;
	Mon, 25 Mar 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L84/x00T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684927CBC8;
	Sun, 24 Mar 2024 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323541; cv=none; b=N81kg+OQt3v4l3h7cWJo6MMeYFkzRvOykoiE4y7vsFPUskYneX/j5/ly9GU16tcuJ/2VcYXL1mRZrlTdq5sdhyrZcekikzRJQf7cAP5iIR8eo6lSgIvfx3IZids0ULFf/J+E3VQAci/wtjLwWxGJPjWZB+LOG8i+C32EIRHKai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323541; c=relaxed/simple;
	bh=jmfwr9b4WGqYyhKL2RJ0GcThkXvWGfJ4utHVDz5KbWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHxImeMJqLhyUOEIdjENbh6qDpo3lQaoWVIaXi1M2JNpJjkrqZjfzErpwqIy93jdzazbCCNrKlFjBSb78sNlaSEO3uTUcVLzoQRTxtdu1zssI5n6CtjNznc9VLAj3DSe3BszARN9NvV7AsL6bxJTsLsxnndd8BOBbHfJEq+00H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L84/x00T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3B6C43399;
	Sun, 24 Mar 2024 23:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323540;
	bh=jmfwr9b4WGqYyhKL2RJ0GcThkXvWGfJ4utHVDz5KbWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L84/x00TNdn09qHM/WIi4a0hMe3QkKwnvjF0Ix/9Szw+2f5IXFg/F6m3NEKOYLDFO
	 OBqwtRj3aWtw4Fmj9ZBxk7YhxM0udicU0aFn3FtQqQ5GXnjHqMVDre957jYT63Eb7t
	 0L2ZuUgnz2g61Bk/NTauzzhr5gCNIp7tjOsQrosm8izpMosYmDkI9ZOxh/dADLMg0m
	 LXcNQBDaIrnKf2jVDn9TfGuWx6XZ3kTjh/fX6HiG5m3xjQuao0IC3s1Ox9QAdXIS3Z
	 2lRkMpl6jW4X1wH961yoIlxIJS8d/OZ7gxRW13YObmuXfSaNh2VjrcbqLugFZnplE9
	 rjUHszIDm0m0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 248/317] arch/powerpc: Remove <linux/fb.h> from backlight code
Date: Sun, 24 Mar 2024 19:33:48 -0400
Message-ID: <20240324233458.1352854-249-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 838f865802b9f26135ea7df4e30f89ac2f50c23e ]

Replace <linux/fb.h> with a forward declaration in <asm/backlight.h> to
resolve an unnecessary dependency. Remove pmac_backlight_curve_lookup()
and struct fb_info from source and header files. The function and the
framebuffer struct are unused. No functional changes.

v3:
	* Add Fixes tag (Christophe)
	* fix typos in commit message (Jani)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d565dd3b0824 ("[PATCH] powerpc: More via-pmu backlight fixes")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> # (powerpc)
Link: https://patchwork.freedesktop.org/patch/msgid/20240306122935.10626-4-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/backlight.h        |  5 ++--
 arch/powerpc/platforms/powermac/backlight.c | 26 ---------------------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/backlight.h b/arch/powerpc/include/asm/backlight.h
index 1b5eab62ed047..061a910d74929 100644
--- a/arch/powerpc/include/asm/backlight.h
+++ b/arch/powerpc/include/asm/backlight.h
@@ -10,15 +10,14 @@
 #define __ASM_POWERPC_BACKLIGHT_H
 #ifdef __KERNEL__
 
-#include <linux/fb.h>
 #include <linux/mutex.h>
 
+struct backlight_device;
+
 /* For locking instructions, see the implementation file */
 extern struct backlight_device *pmac_backlight;
 extern struct mutex pmac_backlight_mutex;
 
-extern int pmac_backlight_curve_lookup(struct fb_info *info, int value);
-
 extern int pmac_has_backlight_type(const char *type);
 
 extern void pmac_backlight_key(int direction);
diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
index 32224cb489d75..eab339d2059d5 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
@@ -73,31 +72,6 @@ int pmac_has_backlight_type(const char *type)
 	return 0;
 }
 
-int pmac_backlight_curve_lookup(struct fb_info *info, int value)
-{
-	int level = (FB_BACKLIGHT_LEVELS - 1);
-
-	if (info && info->bl_dev) {
-		int i, max = 0;
-
-		/* Look for biggest value */
-		for (i = 0; i < FB_BACKLIGHT_LEVELS; i++)
-			max = max((int)info->bl_curve[i], max);
-
-		/* Look for nearest value */
-		for (i = 0; i < FB_BACKLIGHT_LEVELS; i++) {
-			int diff = abs(info->bl_curve[i] - value);
-			if (diff < max) {
-				max = diff;
-				level = i;
-			}
-		}
-
-	}
-
-	return level;
-}
-
 static void pmac_backlight_key_worker(struct work_struct *work)
 {
 	if (atomic_read(&kernel_backlight_disabled))
-- 
2.43.0



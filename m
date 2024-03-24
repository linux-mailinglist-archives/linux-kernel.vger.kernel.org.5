Return-Path: <linux-kernel+bounces-115133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB95888D59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EA928D82D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F22FFFF3;
	Mon, 25 Mar 2024 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc7Ly+Gv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356141826F2;
	Sun, 24 Mar 2024 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324153; cv=none; b=DOe6I/VOYthfdtbwFmh4OiRQbKNBMP76gi1Lu6fj3pj3uEmiHwhEV5TrnYrYwJFvx4Hp2NgAZBU2yqp31bv/8fIKI3/f9eu/hqrlrtv7otrfWnzFeTbOti66CZUJnfS0/xJea2w6vJQK6Yd3Obf2eIwf9k7nRBqSdTHGHHOCGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324153; c=relaxed/simple;
	bh=jmfwr9b4WGqYyhKL2RJ0GcThkXvWGfJ4utHVDz5KbWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/EAhHkiQ8JqcCqsoOYTqUPDSjHS2r5OBN2tdPtmkR9KjNyrDNZUbbAnFdQN3091o/cpOZISqHaCUCmLCjapEaNFo7N/JwJNS8UUZYO/uFGlG1E7+e+kgsTtjs6YQGL+N9WMHlnfOYmqHXGYGwMTAcR681ZNgQ6n8Jo2w2iSfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc7Ly+Gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5819BC43394;
	Sun, 24 Mar 2024 23:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324153;
	bh=jmfwr9b4WGqYyhKL2RJ0GcThkXvWGfJ4utHVDz5KbWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc7Ly+Gv2J3FV1ZoaTKrQlCag/pY97mm+3xeZULVy/LZ6325GmlOxJvGBXcOz/WJu
	 LS6uRTyBisnFXq4kNvldhTgxebINGM4jI6tmAHrC3RcAErJ3LxGGv4HbT24YeLTcec
	 /L4KEAI78ZUcxhwDXhOYpa/LFqNEznzilc2fluu2R9gvuqX8uHadBVv382M5jBA7PQ
	 eXppbTKqGfqLnVwW5auyE4RZmLLrBZs4ViKkaEGzCqPyf7L5fG4yu5wMoi+lUPV/b7
	 Ar6oOKS8igo2QJLjIHGWe6s5HR55ZAGIdp3ZtbemyibmIpV7AUZ6md79/Ni53DWCKN
	 YTxiXRN9Q6FHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 149/183] arch/powerpc: Remove <linux/fb.h> from backlight code
Date: Sun, 24 Mar 2024 19:46:02 -0400
Message-ID: <20240324234638.1355609-150-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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



Return-Path: <linux-kernel+bounces-114368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC87888A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F1B1C28792
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB23A173DB6;
	Sun, 24 Mar 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aamzh9yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1B21691D;
	Sun, 24 Mar 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321763; cv=none; b=jZrXFODA7VQU6lClB7kC6dd7WZXYIlEnQWnca5Xu0vVyF8XgjP828Hj8qio2m26mtsafmW7i+4nGb1CQ5DXMPNwOmY2AM8svbUqX1qNjOCX4IAax+uODr9YMQjU31NKjbt021dkm9NPP2em7TTOJEHuoI23rwYorlJbuEuQIVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321763; c=relaxed/simple;
	bh=iS69dq/pd8SlrD01dtvfdyyqdoXawocA1V9Wz7B0cRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJXzjMqpYJNJnBpz5Eoa1Y6o/E4UVdf1b4qQcMtzjRH6UnuyaTHYDfoEMzhizQzECM2x3BguyxdmiuYqOvghqFbONxVs+7nMaF7c7RNqiJiz7N/cTJADcXfYRLKdRAA/9rw9lmFJb+SnZJH88NY2XmoiAtw55LPwK6QcQgF7Fg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aamzh9yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C18C43390;
	Sun, 24 Mar 2024 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321762;
	bh=iS69dq/pd8SlrD01dtvfdyyqdoXawocA1V9Wz7B0cRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aamzh9yzB0RshpVXZ+vnZZsBrtUqrJcnsMNlILlkHWbFR0G4hsQxqQyY1eVyM2gER
	 qL+IxQdHE5e3JmBT6ozGEwjGVgz1HJJhlJgke36pAXaCPZURYrGQgxL9fhKL2a9/lX
	 hIedIzDM0Q3bBLSTYGBxpUQ+A6uG66B9hIFbS48wCoeapvZcRwNaOB1gf0+3ueoXJp
	 iaF+pOnldoUky1gUMLpmYs/4NnIUrFYL36kWUQEMrTH3rZla1bvi/VjsU4TiBvJlRl
	 9cxN1sF5/RwnzkQwARyUchTKfql2CoRZVeriUld1lv004JXM1A5F82sfCN997LYHPY
	 cDCy0+1zmXe6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 490/638] arch/powerpc: Remove <linux/fb.h> from backlight code
Date: Sun, 24 Mar 2024 18:58:47 -0400
Message-ID: <20240324230116.1348576-491-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index aeb79a8b3e109..12bc01353bd3c 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
@@ -72,31 +71,6 @@ int pmac_has_backlight_type(const char *type)
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



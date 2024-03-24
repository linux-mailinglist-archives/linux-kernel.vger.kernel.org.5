Return-Path: <linux-kernel+bounces-115032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9F888CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA71B2AE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3381C09BB;
	Mon, 25 Mar 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAxfDj0L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246817CF65;
	Sun, 24 Mar 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323810; cv=none; b=C4ZyWrbMQ/q72dcCeOlGpR3Nf/AK8L4VJz+Ow8MciNEu6B63IMfnb/vjHNAW+W4q/nYfn3GHlL+pgBy7DLMIBpJQP63LdBou9VfINC/CsktFl1KedRl4Q7WKIPKr7HWPTEiBqK1Jv7bIwTqZq73TLW/ECf1wdmezwEPGY2re9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323810; c=relaxed/simple;
	bh=jmfwr9b4WGqYyhKL2RJ0GcThkXvWGfJ4utHVDz5KbWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqz6xAblajpYU0CZagMmnmMyd7nQ9bECKlPoZ0Z8kXdWuNdTWOBYirIhPRZRMMoqm9LJegaaISDLXbEOPUOU3wz8b3jKKn5hgmgbuglVzaRKSI4XGURcKw+YC6y+UCF/JizK0nFYM9NFNtBgjkf9H+hwv9HpOnUMUfiksc2C1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAxfDj0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258B4C43390;
	Sun, 24 Mar 2024 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323809;
	bh=jmfwr9b4WGqYyhKL2RJ0GcThkXvWGfJ4utHVDz5KbWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAxfDj0Lw9zUYXselNFbt/IAo6PnzDmfUZjlah7yCpt6eC/c4OIF/Z17SVWnUyI6V
	 AJ5MnvVkYPPlMBXDAJJb755nM/9bQ6WZ/gSr4oyglgtLjDQsuEFaJBTl03d9Qb1U+E
	 KZB40zYrIcmexaGJTa8HQG3pAnHtAZ19pa+26NHU21BoAd/ThhacLlQau+rARb59id
	 Jy1cmCcevfcDUC4UoHdvWeu6ebAjU8fnGJXwkOjC0YcKxboD+z4JvMti5dMiV23YD2
	 4/ZnobaoRD5cZOsjIM5akDFTcn/EN1psHsXCHXoCsGIohenBOk0oBV3XNM1p0r0ED7
	 2bI68kQiWtlmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 188/238] arch/powerpc: Remove <linux/fb.h> from backlight code
Date: Sun, 24 Mar 2024 19:39:36 -0400
Message-ID: <20240324234027.1354210-189-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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



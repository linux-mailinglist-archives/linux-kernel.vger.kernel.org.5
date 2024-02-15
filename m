Return-Path: <linux-kernel+bounces-67175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC0856783
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6121F28EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3453132C17;
	Thu, 15 Feb 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QreJn/2a"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B0132477
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010784; cv=none; b=B6ucx4waCJ0RuUKjigSvRky/9XQgMocso88hO0YNSsTOxkB4Ahv2cQnJ6kFBQMk7qS5KDdw38motoGfusd/DeOHaCDmpB9jPSjdG491EPqMCuZ05ucmUYEkN+5UspEZa7lvslGUR8RZbpi4xI3iXP2yzwuAIvxMDMzTmsfHgckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010784; c=relaxed/simple;
	bh=iRYbVyHYtjE5E5KgWvuST3Myodgvlczi3ADB+2YEC10=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nK6AUAq3QlPN8YE3R/kb3JF72R6QYms9uzmwRq+49oAHuZl3mLBauUgXqqrrCEtGDJsbqNClWHjOdhKnX0R1o8lF8Krc+htgxne+Wm52UeQ9U05ajOtTkKr5NP4lHBC0jul52ie5a15Wxnt9gseDmlYG1qaSyTSERHR9YYOWapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QreJn/2a; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708010471; bh=GdlaqzFKM80ZsVjtRjGY2DrS/4ZVHFTtMqyIKcMEX5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QreJn/2a5M522sNbmTIO0VfHdgHOial4E1isJeceZN26cnm8wjnnutvX0GDbt9hKp
	 kqWDuuZ8fSeQTgCPP9G27VzaMe4f66NA1YOVt1DGz6e9lQ27rzSzV6uw3E1dnd3DOU
	 DM/uanBnV7JPSvEIONKo5Q+KGjiE8bRScbG2qQsk=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 31D23276; Thu, 15 Feb 2024 23:12:29 +0800
X-QQ-mid: xmsmtpt1708009949to99cy6cr
Message-ID: <tencent_C325B38DA11227DDA7DDBE192E4FE88DEC07@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2XJgPSToOrHJXu6orh1i/m37N8he/BSYlqBP1gu3V2ffeK2pdzx
	 gtmkWJsBqyaUPESqEKhxkHe/KtKA5+aRuLaOmAsqjTxy9JwHzMtvFP8VFOh+y0afVj0fUdNilt1H
	 dQsoEjlJFZzzGM3UAZmER6vNallbPcU5g7hK4ShvY6F3UKOn8M9HC9BvZunu9Qzjma13Nhj5UGT4
	 jRIcGtP8/LETUn4nhi+rxuoycg4OzZA8jHu/S5cIk9JGAwIl4Kub9NC1G1SSipPtAVPEAYm2CDbD
	 Ho/wlE94Cm56+dSXdV1gVSkyOgb/MeCPLNBRY8SQ8eZJdjtyXRMfIIiQbPhAnB37LNvKyoiCTM+b
	 WQeRJFwkxrtz6Irf2PQckEoWb2f/YNNZi3E8gt8SWH8wBYiEyramMOPzl4XLJekzR6yoHAiRc1F8
	 CTVmjM8Rn/fbtldI0Zlb6OK64CgFnAEbVDALEIg5NM+CaNn1DnihTo5YIyVjmQCx8ucEoqL1ol/y
	 X6RN9f0BW6b4jJ/jD4NpWlAQLx6hDSj0N2wFVKWy3R5NfSnmFAWB05gbNsLLVWrO7aXO5mpF6Xtf
	 NxdlHYJpWCGgck4dOv9qRhJ3bJCOezfVy+ad290PGR4co9bBqSyUFykqW0V9NnJWIEUK3qQDQPqL
	 oYUOnlO7IsfIiiiOmfWdBRpmKE2xz3NhADvMwMawVdJs7jcMtpZrWk9F5b39lAzVsBR9HQeEG6Tq
	 Zkki5R3L8j7sDDOEXIGU7ZVD27H4ajolWHs6CQ+iB9Vrsv3x1RsbisZc+i8XhSXLwZPs7qOFUq/7
	 NGDoddg1KtdomqAaXPTYQpJgvJrZzH/8jJRe/WRYlH1q3jPIbBgy0A7LgjIdep1x2aLIvwUrXOLw
	 3Y8XzS37elZLpJUO0jQt+2OZUI+ALAmREz7cX3lrB9rUUq2WygSXtMo6WZmSrtQQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	syzkaller-bugs@googlegroups.com,
	tzimmermann@suse.de
Subject: [PATCH v2] drm/atomic-helpers: fix uaf in drm_atomic_helper_wait_for_vblanks
Date: Thu, 15 Feb 2024 23:12:29 +0800
X-OQ-MSGID: <20240215151228.828086-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ec4c32061143ec95@google.com>
References: <000000000000ec4c32061143ec95@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To briefly summarize the issues reported by syzbot, there are two task call stacks
as follows:

Task A                                 Task B
------------------------------------   ----------------------------------
                                       drm_atomic_commit
                                       drm_atomic_helper_commit
commit_work
commit_tail
drm_atomic_helper_commit_tail          commit_tail 
                                       drm_atomic_helper_commit_tail
                                       drm_client_modeset_commit_atomic
                                       drm_atomic_state_default_clear
drm_atomic_helper_wait_for_vblanks

When two prerequisites are met simultaneously, the current issue will be triggered:
1. There is an overlap in the memory range occupied by the crtcs member set contained
   in the instance state of "struct drm_atomic_state" created by Task A and Task B
2. The context of drm_atomic_helper_commit_tail() has no lock protection, resulting
   in the instance state->crtcs sub item being released by other task

The solution is to add a lock in drm_atomic_helper_commit_tail() to ensure that
there is no other task interference when accessing the instance state.

Reported-and-tested-by: syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 39ef0a6addeb..b16ff9020097 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1743,7 +1743,9 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	static DEFINE_MUTEX(lock);
 
+	mutex_lock(&lock);
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
 	drm_atomic_helper_commit_planes(dev, old_state, 0);
@@ -1757,6 +1759,7 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
+	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
 
-- 
2.43.0



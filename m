Return-Path: <linux-kernel+bounces-66967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D685642F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145FD1F28B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F0812E1C7;
	Thu, 15 Feb 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xLlNt7cM"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8112FB13
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003251; cv=none; b=nQ8wYD9rIl1IRRhN2xotJ/v63DSEmH0WFAQpyKuqOgQxM5S8nCn9ON/VIYtIwdSl89o0VBfGnr16UbSOkySvRpHodaYSBfolv0c4+O2WSfg2g4ELIKLTrX8uLz5fyf1D+wb95cjq2JXy78nUIjERZeeyedUls4wBMoqvwr7PSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003251; c=relaxed/simple;
	bh=13KH5H07oc9COrFUMNfc4LQtgoGK3DNw6zWZWS8pPyc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ksQUD31S4oM60YLtGqhyra6RjOw0Kya15NS7SDo262vXrnKaJU7zcvXwE3q7QcDnftyTNuI+ozuNCdcRRxTFLAYtBBOqWfCDHnlNlsQ4EYnFIvS53ovtZ3AapCHgXPmtUVfWBd+lBuRhzI79WftVFHpM92IXJdxKX8E1MR0Gg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xLlNt7cM; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708002940; bh=74lDoTuQg5It9Dyrlq+T3M84frrgQFC8myhCS/1J5CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xLlNt7cMpB007nxeBQgg08jSbyl2bklaBtaXESSLmcZoXOSD4hVi3zDQcO4seOPkF
	 8/q8jkqTv2LmFKt4ArCFjK5MSDrtVZXAjhwIk40iO4TLGa88ax2BpQow/cB1iNZZ+7
	 sjFyNcp2mokrBqQ/N46OR5fwj8DodrgclcDBvSt8=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 8BA8E5C; Thu, 15 Feb 2024 21:02:11 +0800
X-QQ-mid: xmsmtpt1708002131tzf3vszm9
Message-ID: <tencent_9A767366D63D613790969436A84B2C74F509@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTOnUTxJcm5ftnkQHSoEL/UJYcdW9SZwScbnDxQrfu2FZmb6Dmv6
	 Z46P9ZjBHsIB8gnvf/Xd650nMG0ZO8jZU9ATQ8tKfBcjw08/MrWAEgM/PVQv/GNLYLbgJJQpSWhO
	 3CFy6SkNTTYidyDM0cGQ5G5+rZInMTrSVE5mMLcwLiaqQNy01OeV6WE/FgC0MZKYRI5BLS9Slszz
	 MqDX7/3hV2m0sxKsXBDOlMWR2HwxkOircVZ9saEjmi5vQvzAC/tE0rJgv2496kXERx/CuTUrLaiD
	 ooGdPVfXdSzNyEUVBYG/mfywkm2fsbp1sWqG5tM8E+LZUT2LocuXgtdf9xedw9/UNT5EHXRECZaW
	 laHdY+sbEU2xllde563Lk5HDzu54Tn/+8tc+hzx5X66T0O5gxoLwGTKqC/L+vmgdCTL2AbVwRIQd
	 /LYaDabXbF+R57p2RuJihQImvUr3Dz3RYGWz6RmrRc3FvMuKyzJHiTAD3goee25g0ykUU6hX96sW
	 4BeFdblNyNtaTfES+Rc6WeBrNlTyitB/VsodnZ788JKb1UDgA9zBkOQyUo7l3jybnahXuz4+c6Jl
	 qApk7OuScF6jcvy5uzq5E800DkfFor2IP9Z6squ458a8lpTRRU6Rb2Ri7TP0MFmWgpoxou3dl2k6
	 rp6Xq9u5L5bsdY5Fj752BCeiKrQqkx9kYOM4RRdvJrlAkBLB11m0AVx3Ra8D6X7Snm1NbJfYHsJk
	 ZjKnAyFDWF2oGmVjuNnzHn3+SIPNCGNUKV/9vHFnirTCt9OEA/zgnAW3SiyePr5vBgIwchRYtITW
	 RZyy3O+u7hmAQsNxrtIlJQK9COznNcqwthB9M4zork/vWl3+m17xF2XLTYSGxXLhI/5RQ86LkzrE
	 cxjZHTVX8CK6/ivXqnOb96BV0v9DBU+JYdp10ftKsl
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Subject: [PATCH] drm/atomic-helpers: fix uaf in drm_atomic_helper_wait_for_vblanks
Date: Thu, 15 Feb 2024 21:02:12 +0800
X-OQ-MSGID: <20240215130211.769401-2-eadavis@qq.com>
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
drm_atomic_nonblocking_commit          drm_atomic_commit
drm_atomic_helper_commit               drm_atomic_helper_commit
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



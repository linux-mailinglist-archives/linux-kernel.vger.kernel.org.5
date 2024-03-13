Return-Path: <linux-kernel+bounces-102007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C187AD87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EED11C2061D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68F14CAB3;
	Wed, 13 Mar 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4GI888W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582A14C5BF;
	Wed, 13 Mar 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348220; cv=none; b=eQo/axbjsA9dkaggHjEZYh31wLOsevP5Eo8oxErov2YJ5ddDcxJY7pexpK8+L78GrLgm28Bx/ufkgQKP7fxG7/IWWoT6JMp6YyNSrs+Z2bxWUGueKgLjDr7WQcaEdD3QOqJUml5fXvfQZOM3DFR22JnFlI+smdLvw0oIh+qsO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348220; c=relaxed/simple;
	bh=P9DP6IqgYN3+tqfLxffosppibCXgUTe6UqRwTE+IcKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ2XXWl2hpCrnrXSJHZyGlnaBmMn8x8AFywXQHXcKgRnPAQrYgf0tciQkI8UmvKEKYk8aW6odxObyvC+kFdYAmSgfsEWWoMB5d99r47Bclqsi48O+VBYuzOa916dWAiV3NY+jGml7/t4KNvd5drsam0Y80XCG8Ok+wdpt5MNxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4GI888W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62016C433C7;
	Wed, 13 Mar 2024 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348220;
	bh=P9DP6IqgYN3+tqfLxffosppibCXgUTe6UqRwTE+IcKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4GI888WF0so4/myq8YRGYKiCk+RM9ybcZLPUPVB/Tu55SwxE5UyqzJZkBhx47Onm
	 ktSeiY4FWJJrcXmya9ZbmyTxt1dhTs1JHN7YUJjty9RZ46VONKms9fvaITnmgwVGKf
	 uHJIOdu6a6Pole3s4kn7MIpUUsdhAMaMLqRue+l2uUrStV+Dtx/zXquoyLIoeK34Ix
	 ijmK1gARkf3LXpgzLNxwxfjDCie6ZhXtrFxv/tV+yUD2AJTbs7gl2geZ6FBlf9+vrn
	 uwWu1olffNe/AMm5C8+7j+DRse+/WVQzBEpvj2uBlfCvYg39buljgL/9fz6MtB+yKp
	 qD+3TBDYztBrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 66/76] exit: Fix typo in comment: s/sub-theads/sub-threads
Date: Wed, 13 Mar 2024 12:42:13 -0400
Message-ID: <20240313164223.615640-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit dcca34754a3f5290406403b8066e3b15dda9f4bf ]

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Stable-dep-of: c1be35a16b2f ("exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 80efdfda6662b..e982111c489a9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1119,7 +1119,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		 * p->signal fields because the whole thread group is dead
 		 * and nobody can change them.
 		 *
-		 * psig->stats_lock also protects us from our sub-theads
+		 * psig->stats_lock also protects us from our sub-threads
 		 * which can reap other children at the same time. Until
 		 * we change k_getrusage()-like users to rely on this lock
 		 * we have to take ->siglock as well.
-- 
2.43.0



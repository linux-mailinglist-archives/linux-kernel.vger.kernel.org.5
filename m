Return-Path: <linux-kernel+bounces-102224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A987AF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA021C267D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F241A2B6D;
	Wed, 13 Mar 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR+y8a5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034576413;
	Wed, 13 Mar 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349520; cv=none; b=aLmBd/dDQzpCNJAnqZyDcQX32f5Qd6qOgA+/7Fj+MKdAResM+AtbiOn/+jYAhu6cSgqD19VjkOFbnzyCu8xX3ggE1MxtLFKor46dlaN5HtsF+mibc7Eb4rDwpcp+15Qs0EI62AdbEHUgiIsa8ecvvvkeh+KCQc+Sgf7ZLBNLLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349520; c=relaxed/simple;
	bh=MzPy+VdatdXcnhKk7Rsr3P/T59svO5TVS9foousrR8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaFLyWB5VCUfamot6jvYUR9C8aPOnBzJ/hvHtn2mBabIO6oxvy0WQGedWP4lVy3uUhClP+cQqN+aZj2LyCzrk6QtHUjLU0knvN5KphcQcr90q8H1Vz6V9Xi7N5j/KVW6kCw3lJLO7Fgvc5z92Q28hKg5bIH0RKLTL5Qu89zQgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR+y8a5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BEDC43394;
	Wed, 13 Mar 2024 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349519;
	bh=MzPy+VdatdXcnhKk7Rsr3P/T59svO5TVS9foousrR8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uR+y8a5BcMqC1mehR0AfVesB7iiNCCtWqZpHjYD2HvZWfyc2Tr33D94UX5E4eawMd
	 hKgOu/SAVdofJJVrFaA1AQBwrGtY+B0Kxmuq2l8J5GQcOa78lzpJb6YsS0suy6aaaU
	 J3NgeY+Owv87sWZrJhtVCXZROEyY1ypMR+j+WEeIwLPpTgMDXAyt6qqhD+wZaPj7eT
	 3+eNskGqzBCzpo+DjWnz2ga3IFKPTsxuTdHopA4lBhiqh+A9G8mj1YZc4KPppDlbpi
	 7r5MAHMzot3ZfMHNKCD9VhZq8xQ66LGm7Nudks0KchHZXri8cWLp+wBf2LjMDUvXG/
	 PTdfeV2DranAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/41] exit: Fix typo in comment: s/sub-theads/sub-threads
Date: Wed, 13 Mar 2024 13:04:31 -0400
Message-ID: <20240313170435.616724-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
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
index 0d1cca15e66fe..24e6953f606d2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1164,7 +1164,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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



Return-Path: <linux-kernel+bounces-102090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4987AE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7EEB21E98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B018C6E2;
	Wed, 13 Mar 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAtXVKcr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA318C6CB;
	Wed, 13 Mar 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348474; cv=none; b=QMMNmfWOTkJP0i1jyGKaeGNXEwmpj9HT7EzsEZ4kIep3X2uMPdjxn7ZtzYLfTYL1JOxu70lmax1BsBmCQA/E9v58Td3RLreqwq/b/m4p0Gwgw6o2DEQkemFgvmPM7BxmL0tQ7gF4M8ooUvSd5744kgENckdWiQLGHvcDa75rUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348474; c=relaxed/simple;
	bh=+zfMy0qysLkMPDNujoAlE44iCOdr8QUi6rrAux7OqQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0J01X1TsM2ypfb9ZvCW/TzItDJUJ5Td3q9QM9F80+n1B8Fuan1+r7NphHZbPlDL+heZaQ3YheWjqK8s4eM+OSnpPuqrITlnjkgmFrAku16wMXlUMoOIyqZ4F8lbzCTXlLRIQTmopOlBEt6c8lv68SABdfybb7+0TzQUG75MS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAtXVKcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C597DC433C7;
	Wed, 13 Mar 2024 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348474;
	bh=+zfMy0qysLkMPDNujoAlE44iCOdr8QUi6rrAux7OqQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAtXVKcryVhpfRzSTWBCWqIZoTLQf1KNPTdES2BSdv9Ayl6g3GgDu/wBHSWKND87F
	 /kNDCLT96mdd8anZUKsomNV/CYMJeZtHn+ciPXuxTGsqmRyTCfVbCBC54kXvGPwNOE
	 p95ZwvYFvvmfXT7GFTvHLWgPlsvztc0AzB90trTuqghupoEZ34EW6VfpqTrilATJyb
	 TrxOjKOFRm+/6uZuFAZarms0m41TQHM2i3OtvWiJ5CLu7tJDv37xLd1d0g/7sFQLym
	 H3S0Wod6PZcUh2/0s3zk1EWupB4AYxjMnnl8oRcldOT2H9fequyT9OyfvHq4MM+Mt7
	 gHeg3JLMucWFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 64/73] exit: Fix typo in comment: s/sub-theads/sub-threads
Date: Wed, 13 Mar 2024 12:46:31 -0400
Message-ID: <20240313164640.616049-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index bacdaf980933b..c41bdc0a7f06b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1105,7 +1105,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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



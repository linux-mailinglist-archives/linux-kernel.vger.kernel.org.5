Return-Path: <linux-kernel+bounces-102164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E087AEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E491C2342F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1E15016F;
	Wed, 13 Mar 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjUe6qoz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C115016E;
	Wed, 13 Mar 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349382; cv=none; b=U/+9wYmQI4+Efq/dQZOhmL/+D9rlDdgTPmR/zeGOXWDNgUqsw6LpQd4ZGJArih2Ui2e37l5OM1kle5IRLOWPpqv3olQWN14QtBttwWfurvn6IvDuseH/qJPhBustYG2HWzLtBTGHGySQU7a5S1pnAi9gE49jLgRr/oGq6EKw9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349382; c=relaxed/simple;
	bh=U5KI75RrYKkDHuScB67gmzm68FhIjtcTcYt7Z1c6L1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3S7KgBa0ia/LbfGs+aeDWUQfh7ZfzMnSmw/gRmAjH5w7CCRP6+tGYsU9Q5LS3uQfvdXBW8h1BaTNrINW04DgWGcT2jTJJA8aTGvLqdusPVTwyUvmQyMpyxGFNcKG/uw/BbBgruFRL0I2+VjoXPQHiR0Q7PtqV6fIq/AGAu3fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjUe6qoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327DAC43394;
	Wed, 13 Mar 2024 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349381;
	bh=U5KI75RrYKkDHuScB67gmzm68FhIjtcTcYt7Z1c6L1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjUe6qoz22FJcjaLUhd0aN27BV1MwMp60WTi9aO99PWVRBaCEZNmnPwj4lmlpRIOD
	 GsTDnsenox4eHem6A7GHdRm3g2ycdPWxILqnxDhIkvPPrvxm/HKe1WX6OoPpJyK/F9
	 LZSW6pYBxwiXSije0yYeNam59/Yc26VYq7XV64agnQLRZ3qUdZtN9CAqErskluAqQX
	 xuiZ0tVGDTJlR+mEKNmHQrQ113xMmVsK1YIY1nsDS41aw5RN/L79B9uc9aGtI0USdo
	 J3Hn98Iwz6b8dxyIASYDQtAP7xchd2IbwvjQeGfiyllz6NcunU8I0QBJhE0Opg8Y8a
	 CVpjDEme4e0Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 43/51] exit: Fix typo in comment: s/sub-theads/sub-threads
Date: Wed, 13 Mar 2024 13:02:04 -0400
Message-ID: <20240313170212.616443-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index c764d16328f6a..b2a005acb6cda 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1106,7 +1106,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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



Return-Path: <linux-kernel+bounces-93230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFC872C92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19551C229A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309DD29B;
	Wed,  6 Mar 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lfi6C+sx"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCCD272;
	Wed,  6 Mar 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691095; cv=none; b=TOTUrjG/SCzjv32hshwe5F5iMJGHfd8JohyGzIUskzwiSBewEzY9TuWeS+pl5qI44pyw/kYSNnn5v9bdoyOi+tBubNxnGILINMIYdgWlG6lrWMlLCHdzSy4S1IG3Qa/2llSUYXKYqNri0MyAfeZdRAKnzqsabcTIuZFUZ/QwpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691095; c=relaxed/simple;
	bh=Z+/9ljkeSU0oZW5bdtyR6B/2/tSLJ/OhxBOyXh/VRjg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JuIPNI4sIV8s2IXP4YT0FxQbQLL0aetofJu8uBaCf+r3rruIH8FJebMC9V1zDQ//6KoeFntsztf3AG3RWPJ/7BFUB7bSNGY1H5YgRsPnC7Jq/tJePvIzd2/iWCCul0mQ8ZFlp8AJ13HkA414JCDSUX7VWPMyJvcsMBherbmCe24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lfi6C+sx; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709691090; bh=PWmk73R2PGj1OEAHYbuSO5yqqiAnHgDbDoSjsb+aNVQ=;
	h=From:To:Cc:Subject:Date;
	b=lfi6C+sxf2JHJHY1RdKZsPobtRE/7AeVjPQdeFRpO3qmjICLwzFyHzScU+HpXNF22
	 cjQJbHvF4E0pXku3VUEjS8+DqWOLxG2J8Sg79L7+JScllXridbNFqd4Brqt5jZL7Cn
	 4lAI/Bi+LdaLaIAUPAwMq5Efz7IUaNFL451TVDLU=
Received: from localhost.localdomain ([218.94.142.74])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 1562C877; Wed, 06 Mar 2024 10:05:22 +0800
X-QQ-mid: xmsmtpt1709690722twb7dafhj
Message-ID: <tencent_5D8919B7D1F21906868DE81406015360270A@qq.com>
X-QQ-XMAILINFO: NwIPvWX4YDagXilQRA9dEGsmt258n+FOi34HuLOiBHx+Qs9Yjy+ik06aad1BT8
	 SLb11g9yqhYganyejj6G7p411BRbl/dD9PPFrszEaU2R1on2maRETiQ6oLiFqva/YrGqxg6mgNOe
	 ziFlQ4Efbm/gMdG/xZXDlvdMw5nielgeEKO6bO1QC3iVWdV2QwiMIXU5kyUy2H8O9LAYcuV1wBAh
	 Ojwkkxadq7p1cPzO3+r4PYVwHSYH3gda0zv1OsmONVwW9MKzpyi1OJJmRYcVC8Pfyf1CwiFN5rIV
	 irWtlTkHyYkATUkxCF5GM/8oGvz2k27TLI1nOLd87oiyb5X/IGqGhZL9j+66wjQQ7fHDStjsQifY
	 SPya9anWo604GCu/f7FwI0Jfmr7IvQEoetGBN62ffTxV8NoiTxnkcSnbQJ1lHv3jkUjFizgr3cKd
	 0NezBsoeifmjD0/eQLWtlGixTla1y5ell4C/nqAPJPfXR58vk11n3QzPzfYuqlsi6oPFGznbINCm
	 Z0F9th4jKwydIzaajJBoHme6MGDgDUogxaPEjakiXTqyYum5JmT0v9nQacWz0cyPbXwmNqNbLh6M
	 9ARyG/sv1PmKhQD38M6Ms9wHYA/ldYXH0UKbe063tUi79EcLaYUs28ljZON6oNxMyKTDpTKk7xX8
	 Oee94Q4vG2kMnn502F9pkxfjv33UOKGJDmzA/pbGsZiRrmmQ/gS9lVYte0pMuTXPatxbft5TXwdw
	 Hd38fUAAf+fYN8ay3D9/rsvXAuIWSgUcWb99AWd5dge5RvJ016R8K+aD6a/h7iNdzkVnn48GeK8J
	 I+W5CryCR4zjHFfC+DkDm0OnPejjyewGMiZ8UZACeIBMxRJ7BRFvWqy40IoLsOa5tdkbXjH4hZ6G
	 M8vk64SWPsbuEhSHU/EBKzCsH4asm6Yn9Gxc2pDHRk8bzaz4Nkfzt4YbNkzvmAFN6zHmyyVN6wPU
	 ur53HDRK3F0tlYT335duK9VX99w8Y73g+OU45QIRwC+EizJB8Ml7vnJASXdVHxiMXDeh7G2kiAzk
	 aXZYZALpDt7is7etZ+ueBcf87ZnmvwvN32BlbO62dU0QTaxKDN
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH v2] rcutorture: Reuse value read using READ_ONCE instead of re-reading it
Date: Wed,  6 Mar 2024 10:05:20 +0800
X-OQ-MSGID: <20240306020520.40589-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rp->rtort_pipe_count is modified concurrently by rcu_torture_writer(). To
prevent a data race, reuse i which is read using READ_ONCE before instead
of re-reading it.

Signed-off-by: linke li <lilinke99@qq.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1 -> v2: change the patch to focus on data race in rcu_torture_pipe_update_one ; update change log

 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7567ca8e743c..53415121be39 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -466,7 +466,7 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
-	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+	if (i + 1 >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
 	}
-- 
2.39.3 (Apple Git-145)



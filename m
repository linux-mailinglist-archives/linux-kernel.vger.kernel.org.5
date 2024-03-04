Return-Path: <linux-kernel+bounces-90469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D47486FFAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E63C1C2247D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C1381D0;
	Mon,  4 Mar 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hcoYEjrq"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFCA1B814;
	Mon,  4 Mar 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550068; cv=none; b=BmdtvKPxdig2wWl+x6u6+0YPwvvg/XqJCbt0Y0DH+0veEdnfTtVamiJldjRPK8w2iR3SWZ+k/VsTDzO6nhU0+ft3MyFR6amPiB8ws2zp68P4Y9HAgCdgFdArAzo8HwA0/o1DmJ+QSZbtfsKXyJ4RPqa68jA79lBVm74hzstUTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550068; c=relaxed/simple;
	bh=/tWTG1VRLQN+1qsichV/pE5kKWXw53KAsrYYtmgyIu8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TeLAYNDZQDnPek7iifc7UtiM+dYDMrJrImFk7cddHwJ3suX6uQ/j0KOM6K8W0s8RfSe/lfTtpa7fNKQXToARaoPRrcwIfZD9KqAuyrzOgPHFbltd08lmP83zz+Gh0zymJAXpZhG5gB/fsSep5/IPfv3s7XQJIo1TkmuqDrfZsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hcoYEjrq; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709550054; bh=sJKxYdRSOaImCb3LknsmQ+6dfHzPm1FfnhFjMeeoBU4=;
	h=From:To:Cc:Subject:Date;
	b=hcoYEjrqrLhGZDKii23tQJngBSKkcCu+TYXLupgh/TkuvNQJyzgwypZ9cKK5x7DB6
	 K0xKh4Sd5KgZ/0gEkmw+Ky1znPcnk8G/xYLjUdSZZraQC2ruCTRo3gIlEUxyeFjviJ
	 HbtxZblshINwJKzVtYxSwDxOi+48pi2mIMicH+YI=
Received: from localhost.localdomain ([218.94.142.74])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id DB02C6D3; Mon, 04 Mar 2024 18:54:48 +0800
X-QQ-mid: xmsmtpt1709549688tysp3hq2h
Message-ID: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
X-QQ-XMAILINFO: MIOa0ndEC0Bb0Dw3+QvYIBQLmDa4FNQ57dvlB9X9JLGoLNdLUi505MF+0f+BDP
	 Q4drGGSIWkoY21yqYMKwkkxokup1iuVasFKR7+rI3kzSOoQk4Ko55sWSmK0gwXmTUb9sLF/Urbuo
	 fV/+A81Dm9M33fGp48FuQYqj9llnJGFNH1ZnO6gcPxeeCwyG1GAdRygfvv00qb6XOyNggcnsG11A
	 QI9vJi8TMz4KDAV1593eSTHwl23Hmbq4k+w3bVB58dJmrJ7Z0hL87uVL9feN2qvkBU/9sK3UXzNj
	 ZTyOZNKY0otTeHigEevx4Oqn7G/X76fsgmr6pCtaLv0qEeZpEHKirhb1w99/eFSug+b1h97kfmEq
	 mdmYicKMi5gOPXUOCbQ+Isl+mxz8Ag2cda2t2PX2meHF6jghSeowOXVIMDw1ZurCSYy9f6v4RX7N
	 Q7omWZbghgwwjmeGLWRmHctilJWDyjBB+m3djLkBtHeF2zZ3emeFVTiXAljXJcBgna3+PCwIMjrs
	 llEPSdt6M2FYWugvcaG1DwwHWZ0bsx+jxfsK1KDBQK/PeFAraLM1QiHldrItgo2o8r7rdVoAbZkW
	 lQKbqLHtwnEBQcRmzaYX1Gj+bhS/GBmYGQNQwA4HXAHucZT28KxLt/vc9w9NRoAGW4GNN19Rw/C2
	 qEC/DI/ebX81cfSHy2vOk4AHXBvTaEnKsrb3EwyOrkq3hZ47q1jEBQ8FanlHkIE9ItT/nGGMnSKN
	 h3lJ6BcspWjDH7QnojL7XT9XlsI1tth8H7TnxU5BNHGd/kK76wKfk5FuarxhruU7sv5H7mLK/1nW
	 8QKy67x+JGdJKWDsGAlZJ8sS39m3pdf5Aas1FxvQVYVhZb9knfrtgEFMgypC7SvCVBMyglL2ZYtf
	 GOplBsrGpK9Gse1NHN1MOyMeArddh6R1Yi3Sg9CJ2vGyGJqCb32UsV5Rddl+zW3AJjadWXL2V3O/
	 mtbNlIdH5RfcIkwaP4+awTZsP8RNMzQ1qYkZn9z0tqRJGh8q/a+buujsQ8m25/p1Qvgn7hWDLQsi
	 PNnAoQVb9JvVfSRnURUOheiIjFioIr/IkioegauA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency bug
Date: Mon,  4 Mar 2024 18:54:46 +0800
X-OQ-MSGID: <20240304105446.35673-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some changes are done to fix a data race in commit 202489101f2e ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")

 {
 	int i;

-	i = rp->rtort_pipe_count;
+	i = READ_ONCE(rp->rtort_pipe_count);
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
-	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
+	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
 	}

But ++rp->rtort_pipe_count is meant to add itself by 1, not give i+1 to
rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
rcu_torture_writer() concurrently.

Also, rp->rtort_pipe_count in the next line should be read using
READ_ONCE() because of data race.

Signed-off-by: linke li <lilinke99@qq.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7567ca8e743c..00059ace4fd5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
-	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
-	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
+	if (READ_ONCE(rp->rtort_pipe_count) >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
 	}
-- 
2.39.3 (Apple Git-145)



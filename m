Return-Path: <linux-kernel+bounces-44166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E54841E37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D5E28D050
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E31660896;
	Tue, 30 Jan 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uAB2rvgF"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7459147
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604239; cv=none; b=YBv1kjAPeb7SkBixr3idR3TqXgDMg9dk7Klu64ROFrfzdwY7cre7wTXdRWkg/Qbqdp4xjhVf5bI43W/xOFO2gfjohz5OJ+4QCvAPnaGxbbTYuzebFnBEkpvK55l2igx+QBHGHuKSPrl/jfzyN5smiFGt0/mcA1eRUCsDz7GKWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604239; c=relaxed/simple;
	bh=a/doanRbOKE9y+h32FzGqbaLaL/blaSzrUB9qFpcO1s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=k83Y4ObpSPAy4ZYQz0AMqUK6eqmTH65U/8ZbuO8D40NbRvKmqDkFObmtNWKx2JLhFxm1uepj8OxkCynMXYcex0mS7d7t47xdBvpQOFkAJ5VEOD/KOWxszRK18VQYWgSoT/Q98huMqo57pOaGUddkBE6D2v4nh92hQpePBMKK/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uAB2rvgF; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706604235; bh=7+2/BakBVH30cf5o74KBg5/QyuphreIoa2HNDmJDki8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uAB2rvgFQ68v3dnlWVSh/hcV2wR8FfdloIgC2Z0s1lqjPuWDH60BVGN7eLQ0D7jWr
	 ercDkjJX6Epxb9MHSWc/mGPtxRV94zQBp998T4L1i0sKHWqc3PLZRItubKHIaR51id
	 Tt/7k3HGtpdU/phI86bRA0A5DPoH3h1yhAtsytjA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 97038E05; Tue, 30 Jan 2024 16:37:48 +0800
X-QQ-mid: xmsmtpt1706603868trena0m28
Message-ID: <tencent_C16C982E616C44951CE80EEF46CD707B820A@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaP+1mcOH883vPeZzBnKYBWWgdNLkSMZHEAobah0jl9oXTYD9hVp
	 2T9uQPc9bqUnH5dlW6XgA3ib+sUf+VhUseeLTADNCJ99T1G9yLhxS5x3aqffeWJaMeWvl0LXtp/Y
	 Dk38L48K8luGIRiuom/6drCZpwKT5nArSHU4tFgDgMDtUNRWk12IInEopBaVytS6HobalTjZ2unF
	 PIUoz+TkmCnC2EX2Z4iLl6LSb36H/FB4wjDasMBeleZubwXOIdOXXoqlgZJ3GTldhWhfkIzRVzG4
	 cp/uSOcldGZseYrlcPGonn26+r+nHeJJnvPX7cjujI8viqmKa5yK/Skk8m/I5WHRJx7nHXTw/vPb
	 xocwUhpR9IB3K8z754M8GzR+RghK9fvNSfjNK4Pu23HAqucRVqJpyJYgZ+KI80Hy3AMa3dO7NItA
	 yAOQu8KARF4A8I4YpN333OYM5Wt4AI5pWG1j29v83eK7Ku7ibMWZhp1LEoq5fJ/2++9X+dc3T9/0
	 Uy4kpaFdme3gO4GoROngTC+NBpxZvVRjhDh8u9kW7SrMdxrHNR3YGbwLxSPgaf1QqWeonUNZ1vz6
	 fZF8o1R7QqcjpnlDCHJrrREL2+SeGUaC0FyAtp/XZObWrrCYRossXIAfLmX+0jfDfw3GEOCdkQg9
	 wFpyFrr/MgiInpZtLlm7wuNMGxa8IM8Cfiuejr6kuVCxch3Z6MhdFcrfrZTlhB5CTLGS79lY//Nn
	 2E0JD11qH4yF/U+mMqT3YwSkBNPbklxg3/gh6h4xuvyYX5N458bNOjqH2z67v6SdP8XDwJdXVIIY
	 9UnsHd4C6RUtgVPkvDWHRKC18OwNfqbzMdfKohS+oYGUSkw2yHvK9rDdpbOoUFADRtBxP1xgRYBN
	 yja8rIbA/6IKU3PLZzgrn/tA1KM+RfSFSFKd+Q7doA9Jf0C88Muud2D90jUs7RUUARWMraJMpx
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Tue, 30 Jan 2024 16:37:49 +0800
X-OQ-MSGID: <20240130083748.3760265-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
References: <0000000000002b1fc7060fca3adf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in blk_trace_remove

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..9575f19d390d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -330,6 +330,23 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	kfree(bt);
 }
 
+static void blk_trace_free_rcu(struct blk_trace *bt)
+{
+	/*
+	 * If 'bt->dir' is not set, then both 'dropped' and 'msg' are created
+	 * under 'q->debugfs_dir', thus lookup and remove them.
+	 */
+	if (!bt->dir) {
+		debugfs_lookup_and_remove("dropped", bt->debugfs_dir);
+		debugfs_lookup_and_remove("msg", bt->debugfs_dir);
+	} else {
+		debugfs_remove(bt->dir);
+	}
+	free_percpu(bt->sequence);
+	free_percpu(bt->msg_data);
+	kfree(bt);
+}
+
 static void get_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -377,12 +394,26 @@ static int blk_trace_stop(struct blk_trace *bt)
 	return 0;
 }
 
+static void blk_trace_rcu_free(struct rcu_head *rcu)
+{
+	struct blk_trace *bt;
+
+	bt = container_of(rcu, struct blk_trace, rcu);
+	if (bt) {
+		blk_trace_free_rcu(bt);
+		put_probe_ref();
+	}
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
-	synchronize_rcu();
-	blk_trace_free(q, bt);
-	put_probe_ref();
+	if (!bt->dir)
+		bt->debugfs_dir = q->debugfs_dir;
+	mutex_unlock(&q->debugfs_mutex);
+	relay_close(bt->rchan);
+	call_rcu(&bt->rcu, blk_trace_rcu_free);
+	mutex_lock(&q->debugfs_mutex);
 }
 
 static int __blk_trace_remove(struct request_queue *q)
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..4920c201bd12 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -26,6 +26,8 @@ struct blk_trace {
 	struct dentry *dir;
 	struct list_head running_list;
 	atomic_t dropped;
+	struct dentry  *debugfs_dir;
+	struct rcu_head rcu;
 };
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);



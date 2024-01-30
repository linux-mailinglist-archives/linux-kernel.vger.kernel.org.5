Return-Path: <linux-kernel+bounces-43710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BC841829
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915241F23907
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FEB33CCF;
	Tue, 30 Jan 2024 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u0qhlXeD"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA5D266
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577117; cv=none; b=AyKeQq3PKQGJkMFOETfmMMay5w8+VT5BcXKn42/aOaN6bI+5MkrQF61Jw36I8Ed+UXN1WfyWlvGqBH48ewiOHKoa0mdYXGvFTAhxi5y1BtMQG33r9K9SY8mayWU0iEW8M0fPuris5cMcA9Pszu5kDdNfrQZxFU2+UWJoUqW52qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577117; c=relaxed/simple;
	bh=Q941lI8nlLFQAL+xtX6tHTJm4YMyBQkQpd5pKaj8E60=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cgD5PMz8MWEYfkeZcTChmIhQ1ys48zMbFpxm9+/ss26/+8H3RTJjzVDBmADEoi7Svynv3dYejanRD98sEbgQYNx+E4UNfrsmjyFmDd2uIx4n6ZqYHgy0Q3Tn7bmJZ2eqafZbNUqvm+W4iUUQPe5837ddf3XRNm8O8VVvB2VsMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=u0qhlXeD; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706576807; bh=Ph+JMqI9QDGLe2tOGODyVREVCb+Ip05RMDj1QLse+9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u0qhlXeDg3lOSR4qHQdh//CeQwga4vkz4nNKYEILaaHUmqMcQ55MAHjUUf3za2zqV
	 tpyZnKn/gxTZkshp1OHyrGj12K8dnE6K9/6Wbi14bv2pl1pSxO42Pt2Fyha4gXrCY/
	 E+VYBR5AW+rk2k3jJDu2+HnWgY3cKMUogY1nfg+8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 2BA4CA0; Tue, 30 Jan 2024 09:00:43 +0800
X-QQ-mid: xmsmtpt1706576443t7gnnu2py
Message-ID: <tencent_96923BDDBADDD4195E4FA18DB525DB8D9407@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/VlmtfTzmjpgXPDjprb0CBbeC5hHXlW8CUoJ/9pJQ3xWqV/T47B
	 l/yHjGN44KCzu8nj0c+FVLgsPgux7or0SXVs36QDrbPQj2W4/e40fsjcD+1nvaP8GjrlbEWHltPK
	 LrEqugpzGWKMJWz51dWrH4RxflJeFVTWHuFhQcoq8AS2ORJbDU5s8MJAc+N0SmF0FeZnyRNkxooq
	 X2Au4x2fZLLQqEabLIFzrOfou7jwJMaPVw9WJURZ1AgUYuvLPX0heTMLRCvjzaIIbLSCrWxKy6Aj
	 rr+E2edW78ens5nD2pvZaIOiSVApjUWvOYzfMGhmhsMwvGyLjCjqi6pApALBZ/Y8t1Kn8PSRs8eI
	 0uagTqZpVEg3X4yC0OoYAxM/++DYEo6JOlOCj37tpw7pezEQy/VRoGlLXdM8NuQbNCbA0dS98VFA
	 uEBBGDLdnAZBNbGe/QGb04n/0zTAkW6iOf9tLa+EWhZSf0z0ugPah+FbjnyfITMXeZ+8pddwGdCf
	 YjrUpfwxDdw0znrDYWD0sqUhsqGjnKECENhKmfzhgoTngvUVycRPpljjXK6DpAF1x86lOp4yeb0U
	 qMKPZw8/NOrDk91J021y30NaqlMi1kX+NS9x9dK5cUlFk7OblwyGHiYwRVHDS7hNvnqiKoZGGEal
	 kXEHqKRD97h71bQ1OhQEhifCO3Sqd9y2ECrDmXE+8a2vQTpEw24SY4uagg36v1WTY3KSIRZaLl7L
	 CkJ4givEhsqeCvo0uErEP1lQpOXSjk204oIBM8PCqrPMS5c5cL9LOtvu/vDVui2RDSRsWuxDIbtf
	 8NMlo7sSjHdHdMAx5c3VAuGuWoDvg21dY85jU/xr6oKhctksqIZtQe2cJJtYW3Zqo7d3Kgd+yHO0
	 +wugmZ201TjxA4RMxwaKI50gJvwaDPUwWtyBW91AtMKDrr+ESt3gLchtZbJmRcWA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Tue, 30 Jan 2024 09:00:44 +0800
X-OQ-MSGID: <20240130010043.3176371-2-eadavis@qq.com>
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
index d5d94510afd3..43af0e72488c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -320,8 +320,10 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	 * under 'q->debugfs_dir', thus lookup and remove them.
 	 */
 	if (!bt->dir) {
-		debugfs_lookup_and_remove("dropped", q->debugfs_dir);
-		debugfs_lookup_and_remove("msg", q->debugfs_dir);
+		struct dentry *debugfs_dir = q ? q->debugfs_dir : bt->debugfs_dir;
+
+		debugfs_lookup_and_remove("dropped", debugfs_dir);
+		debugfs_lookup_and_remove("msg", debugfs_dir);
 	} else {
 		debugfs_remove(bt->dir);
 	}
@@ -377,12 +379,23 @@ static int blk_trace_stop(struct blk_trace *bt)
 	return 0;
 }
 
+static void blk_trace_rcu_free(struct rcu_head *rcu)
+{
+	struct blk_trace *bt;
+
+	bt = container_of(rcu, struct blk_trace, rcu);
+	if (bt) {
+		blk_trace_free(NULL, bt);
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
+	call_rcu(&bt->rcu, blk_trace_rcu_free);
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



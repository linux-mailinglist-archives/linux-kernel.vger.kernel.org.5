Return-Path: <linux-kernel+bounces-44330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCB84205D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A4B1F227A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CB627F0;
	Tue, 30 Jan 2024 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Y6ZyI1gg"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CCB60BBA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608593; cv=none; b=ZhtZ5sXLplwIbhFvxdUpcpfgYj0IBNMZn74uo4fw29vLhsZUQd0t6CBP8bEDSoaMOh1+qHfVbCwCyA0UXNXKnVPFuj3t2hzuM3rVStdarbdSuFi+8fYxRzAX+MAOE9LGSFeeOsdQq+64gS6TqkfUpvGxv4qZOuAd1Hx4lnfq37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608593; c=relaxed/simple;
	bh=Kq+qHE1Ba8Ar4k6hhNB+prsM31GWQylSWmTHB7dBH+4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iYE/GrM9U8Qkh6v6pE24zsl7OJZJ3/6OI07YM8IH4jCjdMY/fCD7Fzdz5Sho1mIwMpJMBqJ7hm5NYpam4cXcrSKG7lMYgxQtqa8f6wD29tJk67Yb1HnaYSGxDK1mvSUULRH/9xWM4ZwgxP2sPJQ8jyTi3G8nhpw7yZ8BKabseP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Y6ZyI1gg; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706608581; bh=kQ6DufSeGrGifsqBp1AgrFHPj8zDXRFL0QhzoSj2S2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6ZyI1ggNJ9KZRlSAA0ddfNNkWc/A05919+5gl/gmO9vOBbg2pRZCRhphbbZPptTJ
	 EQ4boOQUYViyvzcTkpHhxMNGeieiUem9taCi9PVvxIdiAQ8qf/H8vs6h5qiRHHFgzJ
	 3JIyDI43L0zEdsPrGC4Oe5WzaqFpFdbMqVavIbLk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E13A9E2C; Tue, 30 Jan 2024 17:56:19 +0800
X-QQ-mid: xmsmtpt1706608579tpnj5dme2
Message-ID: <tencent_26AF244CD76BD77646CD337D636D49720305@qq.com>
X-QQ-XMAILINFO: NVd9ZAvGcUb9H79N4e+A9K6KPNbdclVnG0xXzCYDDc/cTm5sTB5TrO4/wuWi8U
	 7g1y7xbEgJJ1ZB16TbI9uVkPCdFmDt5q9ikZnKCZPD22ZkBUjOqQn07vX9IgbfVuBAvW3M5ceCFT
	 9MwLPhUsM2K35Av4nEGJMTHBenkUtmFrd6S2IPOMpOZg7CRsWzjVUJ6Cz/m4+bA6IwpQkSH1VSrP
	 IoK5yCvA8XbG2BGYh0x3Qm451C/bCL+23g6lW0Egq3GQ7l9xwgt40nCwcFoZ6YQp8n6tDkIWTtc0
	 3OPucF/1O7NS1bjvrmfHU8/K3/1rl5FmMqZxc6sd5jLWcf7MFbaYv+NTZF7ERlVXWqoeKBZ7UElv
	 lbr2Hkc1UpPe/wYegGpakNfya4nRViBm+4GbTzZEarrSzcVcRSQquw1mT21wyhp5cJZkZhU5kDp5
	 RjZpS2/EVxMwsapWovoUBbEWlyM0lck10nj/2mYgjNbabCXFK9hlzM8JMlTzJag8xQ3dVJz8YZUU
	 Jh8UtdAuEP8VencpjROOc2X60IshMHa3MrsvY06pLhXFGVYGv0vYkmCPkENbIYQt2/wtd7EDOgWw
	 wMwXoCl5IhQQyWKbulwSKzTXF9Y8+BW2ApokbT2rp+n83XqaC0eanIPmUxmKCeAHNaimKlpEee62
	 zE9PL6TfHMwPyQKishLCKhieVY0dO70JDtawKfvjl0+ILLS8jGR04okmBNtD/ahZMsCoIEqN0Frh
	 dJ/Wv14H6DS5Mp9bRQS9CAetzDkTaky4nwZcvCNXzPbCTJjdL/k9Ke2WtCIpSI75CkPlsDOfc34Q
	 93Y3DxnL5tS6fjXZNZ9PP7XRnOcQK//gtjpT3nHAnKMLjVfQKvsc8OX1mWT1knxz9QrMWCQ69PVj
	 5h6pTHUeIlGGY7mANS8tCk2o0g6pe+LA70k6Uv9Q+bUea0g2v6Dq7pwJRvzCR7i1iCgDcow3O3hH
	 MbuqceAs4HtLvzSJB5CgdZfN45wRA2
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Tue, 30 Jan 2024 17:56:20 +0800
X-OQ-MSGID: <20240130095619.3887178-2-eadavis@qq.com>
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
index d5d94510afd3..f0d55e9b0fc4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -330,6 +330,13 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	kfree(bt);
 }
 
+static void blk_trace_free_rcu(struct blk_trace *bt)
+{
+	free_percpu(bt->sequence);
+	free_percpu(bt->msg_data);
+	kfree(bt);
+}
+
 static void get_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -377,12 +384,36 @@ static int blk_trace_stop(struct blk_trace *bt)
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



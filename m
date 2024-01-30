Return-Path: <linux-kernel+bounces-44008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC754841C29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C65A28C342
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C13F9FF;
	Tue, 30 Jan 2024 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TmHmwp7A"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151F3C46A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597332; cv=none; b=e7H3D9Axh6g6bVhKdtflHBbnBBIckBQl8X0KVKJq1orwooXZxT5JkWLDy/0xw2ts4gtrxZAQEwE2b8N+ZTZBi9qcB6E6Niygn83vPp58V4nika7dX2gb7VDxQTEXfBz7VC48tCRwPtO+LN7vLFIpLS4graLbM3OzsSCpHCZv7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597332; c=relaxed/simple;
	bh=6YF760Pi05L2dMHpTU/8OH8hfrtfGghIMGzlThxl55M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jxeBOe+adNKqMhs7AL88VbJ8eZiRfW+uI9ouHJEm1B0MFReQVdb4kXTk7DDhHKTv2HymUHgB9kM1tSBzXqbZINPVtKwkGjGaITRW9RRhaw3vJPfoTAOm1Ditq5CD5rZ6+yP2uy1Mo6lcCMQzVRS2iauN02aFHsbwmeh8TgvLcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TmHmwp7A; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706597325; bh=JLP6mlEZJuPhaiIgwDOXVR/QBpZ+ke17UGLzsQRY79A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmHmwp7Ajv3hFvfMLpP08iNBCvbpmi3XKz73lHpfHSBuvvv42TZl0h5Wx9muA8Nky
	 fR4be0wJLPC+LiHOPLH45D2Kp5EzJkqJ8c5RbN9YuV8XdWcj3IJPnI1oWEUpCwQhYz
	 rhjBogFkgAS31vwFikjGBOIUZ0XUgkGatusZBvcI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id C2B21C6F; Tue, 30 Jan 2024 14:48:43 +0800
X-QQ-mid: xmsmtpt1706597323t2eqdxsce
Message-ID: <tencent_A9BA7DBB1A33069E111B6F4BF91B38255B08@qq.com>
X-QQ-XMAILINFO: ONeCszOCk2GVZk1NHXN29/yO+WbTGl8qC5wphv1ynVXd+ZaullKKLN0k6U0ZYA
	 9d72e+FLeJzsR3Eb+3lXQxVPV3OWXFzFscdCV/ADqdQAtoj1hb/7csHzh9gwghDv0TfOuWjhZYuj
	 wyCZrWb8l1ZYH6RRwbkdEDrmM9e43pZ7+9n5KQS8O8lwEOr6hDu1IXQsh60IMogzAIt9pci3u/HZ
	 F6+QWZz993kJLOgnpy8sCef7Q6eK9AWp8QozRZCXwWBWn6FF+heEgwEJ5bVDFWS42DAbfOx6nW9H
	 KSWmapebwn1tqPCXhHCYh5fL1TDXfDN0ggNmJ3TVQRGC5jfSxNh1MLHlFHbH3q0d7kL8UlhEGd8C
	 MkL4O75UsYuLW+aTcab2WNHxz6aOzcXT0TA8Zyl/bzrgkKmaKeXEi7uN6d16oripmTIeIkHPr6f+
	 e3LiVBQzRH31dmAXgIzFf8d0Qc0EQK71CQ0KKi02jV1f1CZ8AVioxnpWfmWYFG/sfcT4Uv2WYj+E
	 SbAhSPNEXr/s9tVSiP1P/O3UwVoJ0KyZV1vhK9luT3jmK1HMgoFju8XzqDVKU3MXkXNncd9v2fcx
	 8TBOT432aaqJlLm0EanKxWp2ZQ2w5SEKwteKluFmXYYA5THc5IvPhghvwRAVjMCP9+hCPyvX5pJ5
	 vZwIA71RHvqVWS2ZWIusCuvIZTACNmHLTkUHf76IUP3merBq8Pl+FyG2kiDgJhiCnqemK5x5pfbR
	 mxQF+yOzhBKEAco8jUTVlWHOGI78QJ5QTXqIFKsYG1hMKKLR5y7F/3S1PtijdJneIB60Tm+navBf
	 a3M2PBJGHhPS+up0/tmHUTwuKvgbYJNtIA+pK3i/tQ74qdjMUtO75xUfnZkZxsPixAcq6A4jkqTI
	 7DKdSUHEPabx2sqmjjXDuAefRXee2txpFIaDLnj7iZ1aUMyGKEEWPJvsvx/rOq/WxZgZHUOtGa
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Tue, 30 Jan 2024 14:48:43 +0800
X-OQ-MSGID: <20240130064843.3597953-2-eadavis@qq.com>
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
index d5d94510afd3..ff52ad6c7bf2 100644
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
@@ -377,12 +379,25 @@ static int blk_trace_stop(struct blk_trace *bt)
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
+	mutex_unlock(&q->debugfs_mutex);
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



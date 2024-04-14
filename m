Return-Path: <linux-kernel+bounces-144061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482748A415F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F004E2812F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD4225AE;
	Sun, 14 Apr 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vMOUkO8s"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385621A06
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085329; cv=none; b=c9NyLM2Vh6yONl9ao8icu001dnT0qdiqGf3bv1uIJeFVyuRf58DaCTOpIgQTVe+iC9udxzK9BGTX+wuWXVu15PdcRRneavKTrb8kL9VrDTeqrQLNEqQb4qc32TybI3g/rMsSadJIaf7Fijl0XM/nvIY6gEb16f0Kwvn53mFjJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085329; c=relaxed/simple;
	bh=GdeCl7lKpAyyip9hUe6EaLrBefz1GP2x8c4rjj9MlPk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=d+P1SJsQttHaSYU3dCnazmSIBqnd1TYpTsNdfTgguB1QiFfgj6PBIXGIWIPWFRA2G6o2nClIiWfRP5yu1s9NcHn3M/7dxuGoDi0Y+/R/NlvW5H0CDuJl84bEy4OGzP8NYkRYqUKYTt9tDDQ7X6m39KNSFU1jg76EwtDhDehdKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vMOUkO8s; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713085015; bh=60YJCoNW7ZRMSOrWG6OmlZL5ShYvKrJT+AUIpwBsk0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vMOUkO8sZHWfZBfcJfGu3bggjxA2j8fdiEJNO/M2pfVNRYh4tqyN7+yCS4f3pqlO9
	 zNM+OgJWJtNLBx/FCmGiWw2eCOtNgzXD5HERA98mZcSDtglJ/nOxV8F4cajyqiiEYs
	 ihzsETJKMFsZNRwDNROdNfzJzXRLBojwJaBQs4nE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id E351729D; Sun, 14 Apr 2024 16:56:53 +0800
X-QQ-mid: xmsmtpt1713085013tscbeo3ln
Message-ID: <tencent_3C86D1B360E370E96663A06449F774776B05@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWfHhVPAy5cf+nncrGR9sQ6J9UKFoM8tfIsz5TLTpcPWZ+nLMfVVP
	 WyFVdgsrqKLqCtYEfVibwlnJBi+EQoqQltZdDE+BH1AuBrfDkg+tyGyQo7VNiixhcMxLH3/EHYfD
	 y9uCiGy9YORGcwbvrJLPR8aKMamTusDWUsdGN56bvU1Te2uLHTeoV3r+e0N4yiAJRFtz22QCRJfd
	 T4q9T7a1mdRCdz6um+UiZ0Ht/TiZG59Vr5vERPdmByhs8SR++xEwE+xFyYUZbdYTVHziA0EtDgNl
	 LwSnxnVBPeshINd4k91jmpYf03nVFJuMfPtpXAiKguRJP8gbclCXOb7VZNG7mBnY5E7FXkBcGsMF
	 FIEsBZ+J56+afbhJTMKXnX3BGBJqOFggrfCekMoF9r3xByzKFs6IwmUWksl1LR8iRCcyn27kPnBo
	 QVoPZCUnRzfhvjqXcTWMZAJY9XmmHZFCzZQqQP/1yqSLpcejSI67B1Pe1KkuJNDP9PZrTNcqSQIc
	 vrVWCvsczjspyfUPWKY28Oa0D3LVu8B/N9b5Cs+MYs4A/icRKpN8akyvRyTWabbnGjhM+kLi2Gh3
	 SPxNAxpYWIvjJHyoOR5EMvN7Qx2CUgsv7rLpJLijUvPvKJARSFOsuu4FNaR0AW7THIsbkRJVJSXC
	 +VdSSiG5zc2v1h+A5aGtkNOH7C9kjxDn3oVJXZr81FajhIsu/gnzWNJWC0kc+5am6KSnA+IdczyP
	 hVKAbFYlGmaB+MbEsFMz2yGMV/ShXn446Ef+Fjwf7JsV3hxkNiIVURbn48N8h1sdPNWxQxn3Q6tH
	 L8JeEPGgZWnHYZm+hoUzx39GzEI9ZtQIODmZ7ZR1hBV5Z09LeF8LLpFv9wfwyvITh8iuoe0NqtWF
	 A/kx8PTJaq7z6V7LV2L487PD8abl77v3aivTTRntE7hjZWnjdUbfHn2uC6MhMVam8lDqYuM3sVD2
	 r/dRI+ynA=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
Date: Sun, 14 Apr 2024 16:56:54 +0800
X-OQ-MSGID: <20240414085653.3441364-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004f557c0615d47e6d@google.com>
References: <0000000000004f557c0615d47e6d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in gfs2_invalidate_folio

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e8c39d0f57f3

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 974aca9c8ea8..4ae5e73b6992 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -613,6 +613,7 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	gfs2_log_lock(sdp);
 	clear_buffer_dirty(bh);
 	bd = bh->b_private;
+	printk("bh: %p, bd: %p, %s\n", bh, bd, __func__);
 	if (bd) {
 		if (!list_empty(&bd->bd_list) && !buffer_pinned(bh))
 			list_del_init(&bd->bd_list);
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index aa1626955b2c..d9092692c2fe 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -78,7 +78,9 @@ static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
 			map_bh(bh, inode->i_sb, block);
 
 		set_buffer_uptodate(bh);
+		printk("1.inode: %p, bh: %p, bd: %p, %s\n", ip, bh, bh->b_private, __func__);
 		gfs2_trans_add_data(ip->i_gl, bh);
+		printk("2.inode: %p, bh: %p, bd: %p, %s\n", ip, bh, bh->b_private, __func__);
 	} else {
 		folio_mark_dirty(folio);
 		gfs2_ordered_add_inode(ip);
@@ -105,6 +107,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 
 		unsigned int n = 1;
 		error = gfs2_alloc_blocks(ip, &block, &n, 0);
+		printk("1,inode: %p, n: %d, err: %d, %s\n", ip, n, error, __func__);
 		if (error)
 			goto out_brelse;
 		if (isdir) {
@@ -117,6 +120,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 			brelse(bh);
 		} else {
 			error = gfs2_unstuffer_folio(ip, dibh, block, folio);
+			printk("2,inode: %p, n: %d, err: %d, %s\n", ip, n, error, __func__);
 			if (error)
 				goto out_brelse;
 		}
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8cddf955ebc0..6a65e7f5991a 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1007,6 +1007,7 @@ static void trans_drain(struct gfs2_trans *tr)
 {
 	struct gfs2_bufdata *bd;
 	struct list_head *head;
+	struct buffer_head *bh;
 
 	if (!tr)
 		return;
@@ -1022,6 +1023,8 @@ static void trans_drain(struct gfs2_trans *tr)
 	head = &tr->tr_databuf;
 	while (!list_empty(head)) {
 		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+		bh = container_of((void *)bd, struct buffer_head, b_private);
+		printk("bh: %p, bd: %p, %s\n", bh, bd, __func__);
 		list_del_init(&bd->bd_list);
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index aa9cf0102848..3f18b066cc0d 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1007,6 +1007,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda)
 		gfs2_glock_dq_uninit(&ghs[qx]);
 	inode_unlock(&ip->i_inode);
 	kfree(ghs);
+	printk("err: %d, %s\n", error, __func__);
 	gfs2_log_flush(ip->i_gl->gl_name.ln_sbd, ip->i_gl,
 		       GFS2_LOG_HEAD_FLUSH_NORMAL | GFS2_LFC_DO_SYNC);
 	if (!error) {
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 26d6c1eea559..2b291270817c 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2236,7 +2236,9 @@ static void gfs2_alloc_extent(const struct gfs2_rbm *rbm, bool dinode,
 
 	*n = 1;
 	block = gfs2_rbm_to_block(rbm);
+	printk("1. bh: %p, bd: %p, %s\n", rbm_bi(rbm)->bi_bh, rbm_bi(rbm)->bi_bh->b_private, __func__);
 	gfs2_trans_add_meta(rbm->rgd->rd_gl, rbm_bi(rbm)->bi_bh);
+	printk("2. bh: %p, bd: %p, %s\n", rbm_bi(rbm)->bi_bh, rbm_bi(rbm)->bi_bh->b_private, __func__);
 	gfs2_setbit(rbm, true, dinode ? GFS2_BLKST_DINODE : GFS2_BLKST_USED);
 	block++;
 	while (*n < elen) {
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 192213c7359a..d2353d052d34 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -205,10 +205,14 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 	if (bd == NULL) {
 		gfs2_log_unlock(sdp);
 		unlock_buffer(bh);
-		if (bh->b_private == NULL)
+		if (bh->b_private == NULL) {
 			bd = gfs2_alloc_bufdata(gl, bh);
-		else
+			printk("1bh: %p, bd: %p, %s\n", bh, bd, __func__);
+		}
+		else {
 			bd = bh->b_private;
+			printk("2bh: %p, bd: %p, %s\n", bh, bd, __func__);
+		}
 		lock_buffer(bh);
 		gfs2_log_lock(sdp);
 	}
@@ -247,10 +251,14 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 		gfs2_log_unlock(sdp);
 		unlock_buffer(bh);
 		lock_page(bh->b_page);
-		if (bh->b_private == NULL)
+		if (bh->b_private == NULL) {
 			bd = gfs2_alloc_bufdata(gl, bh);
-		else
+			printk("1bh: %p, bd: %p, %s\n", bh, bd, __func__);
+		}
+		else {
 			bd = bh->b_private;
+			printk("2bh: %p, bd: %p, %s\n", bh, bd, __func__);
+		}
 		unlock_page(bh->b_page);
 		lock_buffer(bh);
 		gfs2_log_lock(sdp);



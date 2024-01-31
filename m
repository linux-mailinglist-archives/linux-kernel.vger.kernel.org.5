Return-Path: <linux-kernel+bounces-46391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F6E843F00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8B1C256C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C67762C;
	Wed, 31 Jan 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rT1Gz1UC"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD9768FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702405; cv=none; b=KPFeWnoeuPc/AiiWWIyIZs0ylKRhXKQIG5vuvGkwqxP9vfNp1WY3KmSI07iYQEkp4LFye7ShGHUqPYlnUkzOLiuSxyNZkbZFPBsU9TRlZpHH7zc2PvVUskIE50fmuknDLOe89gMLqLYSwLWHdcKVap0xsaZYLp2d6ffxzQrEMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702405; c=relaxed/simple;
	bh=oWQhQKQpPRCG6szRCfg++x9P88w7qfedeAfc8hA27VI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=UiQ7KtI6o5J8a0uqFF/un8+95L1gDLBnAiaLipkBpJXM89Bu1vostFzeOunxGxBK/vpNqj0NMpRVGNSsmuP658Gjto7+5vNIuGc8VHH3sK/z2D1FTWFnGGQqnkFdLSXPFGIHH416apkm8YQh0Um0/XjGAlHpdQDW3VlOWEYbx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rT1Gz1UC; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706702398; bh=yazyxRJIRqs2Z51K4OSBPM0fWNpJUGwfkDY5jgcCGBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rT1Gz1UCTHuNTA3hmxwLJJ13G5uAzCXJJeNTa1TmppO3xRLXY+CB3H45K2tYL2uq9
	 ONdZlVODAC0C0ENrWjxnPSl8HRvvacyk61MQ9PfiRUE01edd815ZsTXYGREvirRkGN
	 5kbpG5yfEEhfbhtFbT/48klGWEzthqXduRDTa1Ks=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id D739EE77; Wed, 31 Jan 2024 19:53:51 +0800
X-QQ-mid: xmsmtpt1706702031t9qu06wl3
Message-ID: <tencent_9DB87AFA6C9C2D756D849410E9FEEC26CF0A@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2LwKEFyAx6vot/s2ulIM1f/xr2IAkRRop5rDeX4EX
	 axaa6hnr6R/IAhWup+SQNYqu/69NvauL95KbxbNOiiw9p74zmnRx1kCnEW+wlN+ZHDK2X0QfLCEt
	 HhBYrsR/IIaW+8+1sfsNq8ATe85C5MDlZSNcBDqo2y4YG+AjVq5PnCujrqxKIqMOPAE+bFFW6PwW
	 jwlf1kb47GZfZk95lafHY1CtLsYbuCaj2FBGCxvkiRoL6cd0b79z96Q6JLVj6PfFwFL4lJ0TnK9R
	 ASmpQlLr2SJa85TrQqql2R9mUnUYdTNV/1ob047RoKv95/bpm5PMSstKf5Jy+0L27VDtq6rR8XhT
	 Z8slGIqttDMBhutDtWNequVZMiNERkW+Nx7ImtUxSCt8cH9V8vr+7LIv6+BBJjBnHaZvSTB7kq1N
	 GKCernGwy+IaIEz2dZuDRO/8V6te2OkC31YbiaGKuVVlWXTmrNG9FGAGMTN0pLWpuQqhUG+/V1cH
	 yRaoA9wqxhLKSyNMMcuzpD4JXUIlQoXdeOyxtotxWiQzjOSGfAHJcCy2yLwTRbVspfN/H/p/HONE
	 hwtso2SLHtl2yV6evHm4EqBNvdufTtITu+BvytP6fql7u/oLC4Nh0NzMh+LAtoGA9rAU+QNfLA85
	 cfWBEEygvdQ3Za7goFVGtdpcgYGJdkhnljzjyMrCYctU1IlWCAFHPXB3RB2fdNdkDOfEkyT4lqrG
	 q4B1+mWGfG7SyVq8M4R9LhA0b629IcSc4nQAsbH76DUemY2BmUyjf59lUcQCPg9y/qvB/b1GjkER
	 28qq2l8dtxXOBlsF/Er305Hd3tnCYdlaA7Yt9ljxIKWUKnw66vWjLvsDUneLMb7tCkRxCG4WaZGy
	 Ev5uwglWmgggavKJOWjeLfl0dnWd8DtRYEGatabwDbfoO7JqUUKe4lBtmJ79fYlsXitOD9K2kk7V
	 egC6IO/L7ykQnRQLGQrfUV7iqusp64
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Wed, 31 Jan 2024 19:53:52 +0800
X-OQ-MSGID: <20240131115351.1261875-2-eadavis@qq.com>
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
index d5d94510afd3..4543be718362 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -313,6 +313,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 {
+	mutex_unlock(&q->debugfs_mutex);
 	relay_close(bt->rchan);
 
 	/*
@@ -325,6 +326,7 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	} else {
 		debugfs_remove(bt->dir);
 	}
+	mutex_lock(&q->debugfs_mutex);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
-- 
2.43.0



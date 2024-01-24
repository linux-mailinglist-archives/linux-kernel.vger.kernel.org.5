Return-Path: <linux-kernel+bounces-36283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C19839E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EB91C232C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94815AB;
	Wed, 24 Jan 2024 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pnvcTeRi"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F61FAB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060599; cv=none; b=s6a2QJK9MuAQAtbMloYpakI+4HP2D4RQd595I4O7y89sQb7XlhLljDi4m0WmIfcsJwt7IgDdJU7YmssfhFwe+TaZWudiM11elxfXMm/Mkiwek7p3+QO2h4aBqK1lO/cy+55/6n9pnZ7eamCIqT8Zymk8BrLvIv+ACruE5ECXovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060599; c=relaxed/simple;
	bh=8OnCyaSQq84w8+o6m9YMJ+zbIz/+t+gj9Zl6GIqxIaY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Qu1JRtWbOUCzkefMUPqAQlFydmBm/KaMfx3ZuypJCbGjNbHp/innunrdBz83k+ycS4IT+TaflvmkG/VWlHdy5YJmzSsyAoh9GT5o0CnUpCL5xxOfFxx4R5PR4HZP5omZ5d+pAvym2oYKBEUrOQIJhj1EVVIzcFjcbildDKJW54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pnvcTeRi; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706060593; bh=Zfjo3uQtTaPNNjHjcHVjsQYA0A7B9LCx6qG2CyxRV1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pnvcTeRi1mEWhb7HfDMn0Pur85g1RR+aOvnYv/eE6nBlkH7bLpbHI35TrpKzkZRFK
	 V60+8/XmWPCvq90+DgQ1/Sh2hB0tQqRn1XMWCva0gbCFbQCuI3i1k2NT7kWawqV+l2
	 1D5q5buOqeorJ8BCO1geRuszrevxj/x9FfunmakQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id ACB90472; Wed, 24 Jan 2024 09:43:11 +0800
X-QQ-mid: xmsmtpt1706060591tyci74cxy
Message-ID: <tencent_1E7AB26ECC2DC56C589658EB6AED3ACE000A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70Or1JZvPbk/egK9ZD7lOTX0d1J3IH4JaXMzbBPNJwcDgOVHsgFq
	 yX0FEWC0oARvM8Npb/P/f4wrA7QEYjdC+GTW03TRMyghe34wCdfdevQDN0fd41m4KE74B/S9poJq
	 nEzw4lHo6bcPqybdEh16U5nR1Pj1QnIjsZf+ZdWaH26EENzSVtVJObUuIkT0C8QPRlM3hycBFGKF
	 UYmAkx6mHTES7iyjLomXB7e5X1w89dxrofEUwghGFFF1SJ2WJZn5xe5jUoiJcaHGpDwAz/E/DDAq
	 DRu0WcWtfKo5wnZfuS4nZsOQZZ5fmS77lTvNwTJZZheeovExLWZx0DYV91SWoIQJzO9wfspM2cCZ
	 m9PCLhOrVhlVRB90VLj/JPTDrphDDDxT0OhMpej7E5DrI0xq0phYtx7ClsDeW7mEWM9dTFAvQ/yq
	 9g4zFk/YhprHAvLH5WZST3rNabUxTlkAE3po/HxdZr9TwNce6wznmnYuvEPLbWi16Mfa84izbclT
	 fmpcyTYYYbSH/8qtB5To6EgpeRsNwD3a8YQsBRU8F7zcrb6gxJwSdbCri1ocEEgt0dlUWG5csHMc
	 XD9eDTW1Jv9IJtJe9HfcwwREz1fJNOe73U9z97WP+ciAd5KO9TOARRWbYXnxVS2TnmK6tFqP2IOx
	 ZA487kd38sY9YIYxgp0SNPM9k2GtlotFw0MJHlMkQ6hd++DGxczuMFq0LTQz54zXfSmHiAzUQCk6
	 ovghIoA6j04vv1wRQKyZwBOcUbGplsMWucQU2rPO2V9GIcf+fVvBwHAC2jHzEB2tuwjfzpxrpVtU
	 mUZ47Zuymr8SXqO0TrWCi69KocYJp1HWCfSO0YthWMb4lkT0jDpCQsdzOPT5QnXL96NjfVexLdIZ
	 tXyFUANIlhdmmMj8kCfr8AFpqsKGIDbGwY4by5KCtr1ZRgvw7b3aJRdFLtYtINcz4owEDXtVnDN3
	 zAze0a+YXEDZHH4sfi4ENtV/RfJ6U6MIg+8arSUybtLBsdAkodEg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] WARNING in dbAdjTree
Date: Wed, 24 Jan 2024 09:43:12 +0800
X-OQ-MSGID: <20240124014311.4182088-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ad0392060f337207@google.com>
References: <000000000000ad0392060f337207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test WARNING in dbAdjTree

#syz test upstream master

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 8eec84c651bf..bed14d5169f8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2294,6 +2294,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 	 */
 	dbitno = blkno & (BPERDMAP - 1);
 	word = dbitno >> L2DBWORD;
+	printk("dbitno: %d, blkno: %ld, word: %d, %s\n", dbitno, blkno, word, __func__);
 
 	/* block range better be within the dmap.
 	 */
@@ -2875,8 +2876,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 	/* pick up the index of the leaf for this leafno.
 	 */
 	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
+	printk("lp: %d, leafno: %d, tp: %p, %s\n", lp, leafno, tp,  __func__);
 
-	if (WARN_ON_ONCE(lp >= size || lp < 0))
+	if (lp >= size || lp < 0)
 		return;
 
 	/* is the current value the same as the old value ?  if so,



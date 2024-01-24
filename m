Return-Path: <linux-kernel+bounces-36287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F8839E67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB301C26B92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E891C15D2;
	Wed, 24 Jan 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FpB9LoIe"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240C15BB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061017; cv=none; b=MDJfLrVkCdxEhe9H3vfNvJxDIHdO7Gqo1AnjqLuNVRictmuZWQNyWBmNeSHc2nED8+/Nx8TgDpu1/jQM7iSzYaxAqROtEdXRIVdXAEQNEqrB4Qxi93VxABaxrP+v50tAOmyny8kuY8JMebsRhdjuNol5JnxpXBX0hMlbxaWJbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061017; c=relaxed/simple;
	bh=l9E1JQFz1baO/04TA2XGeR+Y0ZuDOFDuO9EI5AWvjQw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HsPTVKa615/X1DlBa/GNqF4sEWhcRrDkpKJM13FLj7OMas2lCBk33+a5urwPy1yyALrMvVMO1QGxM1a+mKNEQphau/AvlmpF0m+Z+rAuS+954eqpmdZPSdYrHLGYL3vFWC+6N+5wndWVwOxH9+P1F9sxHjFzZP97noj0lvI9UzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FpB9LoIe; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706060705; bh=U2weu1yWJfpc5ss8U0c8YLdbhDWFzKGSGPcTt9qG428=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FpB9LoIeE+05GVtxHF92H2Sf55Tnh94qCyXmyx4qf6Xe/c3iKBbfoe54NpsewngET
	 eJhsDK9dFmzCAc08+esfeYg6jo39vlWSD0bSI04sd6J8cVL9KfIUZJnJTjxawopSqs
	 h1dBx21XPWQtUrYJu7egQG9DazEysSErefyyS09Q=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id B43B4A67; Wed, 24 Jan 2024 09:45:03 +0800
X-QQ-mid: xmsmtpt1706060703tbk1yspru
Message-ID: <tencent_85364A4A447431779D67703D19366A97C009@qq.com>
X-QQ-XMAILINFO: N2/jAoEINgTT6wupcecJiu2uV1fJiqccKsqY3vxg3IHhK7ixV4v4RXEznaJID0
	 Hl19M1a+fCCEGOzc23NVZDbH2UpNAPnBGh07o2Pqra840nj4J2KkfPCRHst9/UOTH+Kd/7CsWAMm
	 zJlwP8QyHkwCGwTTYooCb5XS0SBok1ZJYZUB7udEm/0JeFgneeT9gYnXqOq+TfZBNOjCdej0KiNr
	 ZGbI3UrWvSjQbAvB38qh0Kje9fy/7gLOQPC49jy/Ot1ClCD9dkLIB3vNlk4JWwVJ0Hj3llQb9QkL
	 2PySQWdj7dm5rn2YUdVQbRiou+YeTqmqdDgtCuhrRCK8jWiN6rkEfE82mToymMVKqQNrTZokwfvb
	 m4ijNge9hM5Ovk1Zcz6zzGD4+PDGSHROwDfFo3EDEaISlI7SDmqdwHWbDyGP0PG4r7nCfoJ8HUj/
	 GZC0qNzUk3nZEwkq9md+0/Ny8zm2FeRHdnS2UqTx1SvPqhVTpmjct3Ctt8gOjvn55xz9t95p3whn
	 b6jBMF9xXXBx0gTKcg2MJeZ3oK1+qSnw6AakkksXuuxDkr7le/eThaFVt9DNDwW7C5vfSj+Ed5NW
	 Rh9zglohOienylXPWrkVDe45gpVz50ddfkQ5idObv2bBWm21DacmqTrcmNNeCV8eiLJwo40ZXlRC
	 n2iGsrLZ8baA2JG2hMoyycxZ2nzBSS3L5sauLJ8QxF51wDnYISkAgLIf4HM6zzzxfiU5aCgPWuT5
	 W4wcxk/WnBQLqFTr5UMSnX5WHcFA9nbo9SLvirdwD3PZeJRMfn5tPUuH9MxqY8z+Efnqjc4GGRP7
	 yn8BrsZWeYidbMKCorYv9oZMH/cx5NGkquhoxWUhSVsvE6w0MlJZN5gvak0w6aFau3NKLoaqWTXP
	 Tv7EtPWCANQ3wCnkkv3o/4xA9lfNbwPpcE01wlV5JBglsFEV2hAc32cwDg5+/L+mruV/FoYgcjxW
	 uvoYiZ+ge27CKb20UiI/tyTEimg/Ep
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] WARNING in dbAdjTree
Date: Wed, 24 Jan 2024 09:45:04 +0800
X-OQ-MSGID: <20240124014503.4183791-2-eadavis@qq.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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



Return-Path: <linux-kernel+bounces-36279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4E4839E56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B261F2ABE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3E15BB;
	Wed, 24 Jan 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="m9mp9ovO"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E2137B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060323; cv=none; b=XbhXinAcDz4cICaEOE7vc0Qk0bmr0WC7hkMvxu3QIbujViXXc8Jetcym9B5cuYvuG4IFPTFd/nGwI3qV7algUct9pgV0mE7jBZnUIdO5QRDNjviIhUJTYuT3eS6kUADWCtNPDGjYF3mq4RDHA8jFzt8bojIea+hPlKbR1/WuoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060323; c=relaxed/simple;
	bh=Dvjzq7uuQTx7KGhFVJ4ke7WrUbOUpMuqCMmk9Er/9+s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=UVPkL11u+wAq3HyLnn2+QaobuhWNsXvpDo910wCJNVWRzD6rybyq0HacDnWW+CJuKIOahJwQ1KeeR0l4V3PJ+jyZbN6vjcBRVzmcp+ItT7o2dQb8zZPjhvtQY80Xi9Iahg1snTSRshWZ/aH9VZAwYaQAITiVz42N0FQxMO1RZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=m9mp9ovO; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706060316; bh=NeQS+yVQ4S4n49pCnW+p+jqFLeQTjwNbBIpW7oFASwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9mp9ovOfVKJLmajL/utvprChdwms+NWP7h/0+Aceouhf+uJPNgXkdoe+2U9z7tqv
	 eTLsrzAf9AbjSWQNQaNtBUWkAJWLgBJCDyHcKirkzgqsOgCbLX0w+VuhSxvL2zYyW9
	 0vjOGyZ+7v7BdffSrWBTOBKSYOqqlGUPQW9rsFjk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 9A29EA14; Wed, 24 Jan 2024 09:38:34 +0800
X-QQ-mid: xmsmtpt1706060314t986v3bg9
Message-ID: <tencent_E352FDC65FC9B06EFB6ED30C9CA7EF46DC06@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1Xn0bG6a/PZp+5wCFA0unRgyhzGIOfuixHFtLN0fNbDXQwkz2H97q
	 /YEZDDyXy5+F6iSGQ2mrrCRBFzmvhem+56iMUGQgIc3iysZltZgdJxlbRA2Cj4sVmxAMO7760piR
	 omuXCbLqVDWs4KkB4CFDsTxze+Y2ROIynbtR6DWt085jhUExOuX/bTRj2N+jbaH0VE2RnLgUe8lg
	 efAiitV1xAbEvIVE+4+h7CLkGWq3PRt1C6m5BB3rOG3hpjPDAL9nLtTgdDnAH8914nmP9GpEapjh
	 j33I6gXwMLgYDeQwEdS7Yr77VQpWdCUyn7USUdxbibvlpKzze9jvCME4UAPpZKgSzNv5YInNyvEV
	 AiOLarf7jm88ordHmIH4ZWRVYOoI5h8tuwY9rRV0YUMXyG07zpue23KJpqJ4WWk+v45rB9tLCrMs
	 dfEK+2Ei40ni5CCm89bVF0WkVU8PfgG8dJGkRvjLV7MqpbDEC7DeLDMNScJT1hl/gsFSomXElPxV
	 DFuo5ePqVfPJLvubyywf2ESta4hUKLf3y7pSxLdfmrtmcIe3jX2DAK00Qt9Ti8qLoo3Nnw4ZnhOk
	 zOwGuf+uHKR9AvlECTQnbMGSAI1GYVLR6plMgu5ZCZo94X0ph9K2AbLIGfnx4KLzNCNNR+WxWQfH
	 82kZp9Ww6cVaEP19LEhpNy4OvHQa4HEbnWYTwLYEk7AsuTITxJVDNFxXxQy7Zq0GzQc4vQM8vKko
	 Vks6qcLj1pnzdfq4qXlB3shMwihZOBMfsM7KFsIfeEENcwQIQyM+7A8orm2GpUNatBJn6965RQ3L
	 vGY62z/hPs6P52md1JGvgjtOh3EDDtxGfsAqPy7RIvGLSBEsw5vfjuiUUOeobgQ9HFbrpUNqAkqE
	 UQsxnl2SLzkh7j0DtnQMvUcDsFDgqv8yTRKwcJL7WjO8YvIZ7neWz55XNt9mcStA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] WARNING in dbAdjTree
Date: Wed, 24 Jan 2024 09:38:35 +0800
X-OQ-MSGID: <20240124013834.4179575-2-eadavis@qq.com>
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

#syz test upstream

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



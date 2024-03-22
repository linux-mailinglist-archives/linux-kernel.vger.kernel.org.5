Return-Path: <linux-kernel+bounces-110819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C1886452
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D27E1F21678
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA515D1;
	Fri, 22 Mar 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zZo4aFcr"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02912A41
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066964; cv=none; b=qquHKsqQmU5TDnyOSgzdVwweax+bXHGAud2Yf6haLioD4HBsKAJ3YrjkPjW1eIGXCGJvHbvodoT+n7J8ekKrGliMyoAW1WEn5qht0ZT440Acr733ot1izJnx7cG0I42ntESFP9sezBQEUIzfod6FOU54ZjgtGiV9t423sTSo5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066964; c=relaxed/simple;
	bh=3t1Puwvdd9YGQyAKxNhbTo32TdrvZP4POduKNuPMD3w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TwR9uU2DRmFDLkDTD3/1RSgVvmo0CNaleQyHTU0xTQA0bpmP5Ztb2aZWH5BZX0Ex5Ae+TsE1Ig83UEV+BBAY76nRMnjxjPG0Bxx6OPcW+9fZQrpAt24ULUgXbq9HbppFpdE7s30SJe0Q0FZCWtXsp9J7OQXu1or4Ou1QsdecB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zZo4aFcr; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711066657; bh=9jiZwYw7NgFqbN0NLudxqqOACEB3djyd6F0TISISt04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zZo4aFcri/lYlTS58X7JPjjGMb7za3GcV54U+SAEbVYdtk7QX8wKb/eQ1hW/VPzbM
	 nWz/lBVWUsyLiSzF2U7X0fBvuhXzeP2Vdy3q8n08bvfbCmLnoXli9xpLeIOR1n05hK
	 9EY9x69jqG8eC00SOHt0Ump+yczqF9bA5LksU8h8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 46386CAC; Fri, 22 Mar 2024 08:17:35 +0800
X-QQ-mid: xmsmtpt1711066655tbrgs4jy7
Message-ID: <tencent_C325838D999249DDEFDDAA191E4FF08DC007@qq.com>
X-QQ-XMAILINFO: NUygYfydBsqcWi/AEA1lzJGKks5oLrgyV8gMpyS5RBcdhAm9aUnkmBYletz0qD
	 050CufAGfB1olpNswhBeLPEcQJJbHi7lZGf5EQh4qSOtzVM7mERLcoAcfc+LRURtXOcglbEcQ2OY
	 oHLAko3v7vA+ijnLHFr9zKJpBWRjp+6DjR4aW59ew6jMD00gyDD1+59VjybjpT/airWj9uc1+UKd
	 Y8w5YNKvYl+yhmumiF+0BV6tl7TYylFIsgHX2UJuAej5n+wWSxN/XOqJpYvpwnFOq911rV6lkyJk
	 YXdaUaRL29jpynBaCT3GR1mPll3nyyO4Qt+tMx9Mjmfmi6yurvtO4SniXX8sfo1gYwxgfWBzgZ6u
	 7LVLvuj/WRFpMiELMlUdxrl/81SegoEGF5BRxt1gcX0H6VPbu8llkYDLEbWEp6CYIHbKQ52Ya7iE
	 0vqJstS4La05PWIzkpWkLpAx7sYIbF76aiclHY0k/n77gR+/j07pNxajtmLPXUOLZlM5RiPS0kkg
	 9hT+V43CjH5UiI0kqPnazxHUn+fUAq/j2oPhlZCpPItqrvVixsRclhAZDJtlXtS8P/Rj9CzrAA/W
	 m9kxB0+f4iVnzZ+0tpXa1T64TDa0YdZfDlyhVk82ZB75819sK9X4IyYEblQwSb5cN2iPmfo3Vsb1
	 D+VQpreh+eFPppUNx/1cxnZZg447WVOcan411gYQaskdsFg8903/brxRwV2GjJfazjDY8MGhxRlI
	 zolaBAjG7KuD9iYx+8uDEt1EvkOTFx1ZkwG3oiI+T2DjPUVp++PkfvRHReJ4J6Ivtnk88WGnYzJ4
	 dydMSEDuFemXvLntFZcha+UWgSJKqWgSG11bSjgebrksyyY1jfPwSbbg/0ScODZ9pX4f0mU9TWyG
	 xP3CHs+hfJBPEfpf37ZQQO1tRGC/RQNi6t9a6TTSlhcM7fLjf+705bDfLQi/rz/YVPQstrBSTrJ4
	 iX/tzM6BRxSF/k4vO8X6zKegzI20Cm8G42ZaqK6XE=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in rcu_report_exp_cpu_mult
Date: Fri, 22 Mar 2024 08:17:30 +0800
X-OQ-MSGID: <20240322001729.2656323-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000dc9aca0613ec855c@google.com>
References: <000000000000dc9aca0613ec855c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in rcu_report_exp_cpu_mult

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master


diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..ae8f81b26e16 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
@@ -1136,6 +1137,7 @@ static void sock_hash_free(struct bpf_map *map)
 	struct bpf_shtab_elem *elem;
 	struct hlist_node *node;
 	int i;
+	unsigned long flags;
 
 	/* After the sync no updates or deletes will be in-flight so it
 	 * is safe to walk map and remove entries without risking a race
@@ -1151,11 +1153,11 @@ static void sock_hash_free(struct bpf_map *map)
 		 * exists, psock exists and holds a ref to socket. That
 		 * lets us to grab a socket ref too.
 		 */
-		spin_lock_bh(&bucket->lock);
+		spin_lock_irqsave(&bucket->lock, flags);
 		hlist_for_each_entry(elem, &bucket->head, node)
 			sock_hold(elem->sk);
 		hlist_move_list(&bucket->head, &unlink_list);
-		spin_unlock_bh(&bucket->lock);
+		spin_unlock_irqrestore(&bucket->lock, flags);
 
 		/* Process removed entries out of atomic context to
 		 * block for socket lock before deleting the psock's



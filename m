Return-Path: <linux-kernel+bounces-125452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52FD892656
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610752836B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91913BC3E;
	Fri, 29 Mar 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KhCivNQ3"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A001E897
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748930; cv=none; b=sZ6d/1wdn1CNbitAJNBMn7fsC9tbsWdPigLV88XTAp7AQ3DIJ3LXWH9hiQ0T9bXbRGWNueHDtxKZ5QXXakookV0To6HBTzPJJU3bHmAOpO/Fc1BxJ3UqeVjCRsHKMi+x+sUKl/9PMEyemPS2KSNMXwi9iZOd0oNOSfosswHTA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748930; c=relaxed/simple;
	bh=BUffWdP8GQDH3Y4el9iZGb0ZPbexiibWEVvVLXO/DAU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TcKJ49O29rJe6JqI8YKKJJIfqiK7tD9h4xKamETjhw0+cODNQ+qCf9OKkV19ksQwJ5EE8zndt6XOUNrUcjFp4aU0V4d8+22GUM+OPc6Ci38CaLbHSQ74AUtGNiD7UH/0ioZxu6Huegj9sYDznz235fBS8NEWMaknDQSWsn43oEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KhCivNQ3; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711748616; bh=lILsADCNdk/Cqao041ZOb9WEswS7DhlSq7yDDytvsaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KhCivNQ3M4L77QFSa/NxtCHilRuDEXCfPcIYnf2dWiToVW4g9eicmJJchyoakl6ER
	 wbOl+3zghT/l13xYj8eAr76pXjVhBL0a4b+N8NoZ9qWSWoqZ/apI1dHK56zzCMS24z
	 lq3LhZYwDXT4Xio8XoM2rgrkKONpCs9cY85CxjXA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id AE3360E8; Sat, 30 Mar 2024 05:43:35 +0800
X-QQ-mid: xmsmtpt1711748615thj57ysf5
Message-ID: <tencent_F85DE45D93995ACF9C8DD7A5FD0DC0921A07@qq.com>
X-QQ-XMAILINFO: MFWpArBVhhGTGTXc2JWhf4QcXUSb63YXMuI8I9N5/x06LWxcYpgoTdIV2zpXfE
	 xPl5fn6dyADxKWBTmLzUR76rFYoZ/mHixqdKoh8t6DUlYh3oMgCIr/QtsRx00XZLeskTCe1AB7UC
	 wF/6nh3xS/VRda+efupXS/ux4I4weQlZFCxbwyfxsfauGmDYnwiw9nRuInlcUM3Riry+AEclim0v
	 Kq8mIYV1Q8LZrAYX9laGdeZvQxcNiwBu6qLhYKkNYricJk0N0nzu/RjTXwisQQXy/J/f2UTbmohx
	 bE0uhXFOvqh5RwrJURm+SCM4SwwgyU8CNvGtPCjZZNk75Akfpy/B2JV0uigdIzlrtLgesjVdCPjD
	 Pr7HkWr4AAJLq9iFfyGhTOhk3r/pCBYxNx3yTziCYKlk2Kahb+n4CZJkUnrkWfL3+8QYt8lb6e5k
	 w7TIXKTX5lKjfYDcF2IUPiVizTmFnjGIW0uXGAmqA+uH5ugXyDtEhuY6tRc9QdX2DM+fvqrABO4Q
	 lmpliKjCguIz6eb5Nwpt3p2xK3a2TCiBT8EPhgJr3HuncHisTaAXeZeJnloapFrvCdBCNrgYuc/U
	 FkBcUtmQeSFqs4LtUDvpBH+1GQPvYj2cPmjJGdGN1BRDS4yNsRmjKdSBJhS2qgEqXo8+oFv9KUOX
	 JRCWd0bKXoyTukZocTV6JydPvo31TDJdORLGHf20vA1Nbsk7vTBdxGZEAZMNvSoW+c07GmxZBCt2
	 e/nxbxP8YxwMHppGXXusyhlofSPejynVoVO86ulTZOMWkFOaOICPhpBavGUit+lOCOSFz0lNuQgn
	 px4mzGz5IaVU3raKfhlUx8n9xX4LVGtESQCodUt31wHjknXQAa0AFp9yjCEVVP4VxEGXGNEkJaln
	 XPYg/zd9PYSLwiEgHDaYGSj6a9C5kO+fk4cekZG44wXotI61AuAHd6/AV30WLVCw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in tick_setup_sched_timer
Date: Sat, 30 Mar 2024 05:43:34 +0800
X-OQ-MSGID: <20240329214333.3537719-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004fbc7a0614cc4eb9@google.com>
References: <0000000000004fbc7a0614cc4eb9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in tick_setup_sched_timer

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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



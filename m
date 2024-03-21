Return-Path: <linux-kernel+bounces-109517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D2881A71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4749E1C20ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C6811;
	Thu, 21 Mar 2024 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v7kS8/id"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F163C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710980621; cv=none; b=VRIJreig3+WqrE0fvgwKXrh1KpP/Kr5EnsrpH9shT8U8XNqi52JIaxK6h5Y55NLRuL5lmeC7etyztrC8pfv/2NEQalEKSR+E7+iC2z/LjTp3xl0GntWBA1KpqskKyD5bGnMPeq8r/SszkW0Sjlu9iJKqw9WPzP8bJ/Kqc3Q3m7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710980621; c=relaxed/simple;
	bh=NN6CENyCwMZhMtYWPZKxQuzY0hbwg5kkB8EyP0ggEDU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LG4XVHX7ii8P6fkJairqPcKrDhZV9Acl9T0TGosxqSb2OTehx7uiIoyc34Vb5qVW6z6HhchbMIGs5ZoLLOUG2xMlNKc4cPXFT3z2EA6oUQVQfhjBh9ZbI+LSii9EYiHltqrXc2QVOUISeYCME5UaxW5NsSPndIgR/AAh08+5WLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v7kS8/id; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710980307; bh=t3IJ5ULVu+wYG9cQUgBfpwr24/8sQgXcWmEIigrWYZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v7kS8/iduufckSkge2g9jY3t6Wsque5oTxGpu4PvcNOd2OaKjJI46g0UdMlqwzeDX
	 n5Gk+IhgrWowRxj367ncmOVjrDNMs7aIkYMwDkfUnAD8hQUfJIyOrbMFJTayqsUF9I
	 yrazoEbq3RolcfEX4ocKXmKLayDCn0vPtYs+XM+s=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 49A34031; Thu, 21 Mar 2024 08:18:26 +0800
X-QQ-mid: xmsmtpt1710980306tsils527l
Message-ID: <tencent_897431776767BA3D0B361296C236024BFC09@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVV8yG3LJVEpMy3FkO3EFH3MLFroFggCRblnVhk8xbXcDDtDlVr6
	 x37WBrET/Z0gOfk+7ye7hTkF/B3+8u/ypykLXAI1XbHdOGgJA+BhFuoZN2eK1gKXFSIriSDvrv+4
	 EtOyU8nFKhdgCjHxkV7+gdk+FDGl+gY6MJ6oxPvFRMkc42mXxGXXoN67pP0DJSq7SYvFzLn4T349
	 fwBWZdDzk7ofOke8GmP6S5/Jw9ngXQ7CtOKxftElZUPqAIPK5vN650AuO3YBR9r+PDb4onPSz/uT
	 ve8qr2FqwT5Ix01UumlQ1kLVQGByVYh8VHSs6G9NNjqOQnpqf/If2KItzSp6zeBV2k7hDSavY6u8
	 PItOUHGEMes0mfeAC11XdspuhIlgtjv8Lxp+eZfwdcKZ7Hf9AGfBdDm9P8qS/oQ6b63pc+31bkbg
	 zRMTngZ3KjZYLNMGrj5rdd0zf2qGI6PlzAJYWV1w0bsXAcCeep+tJL0cEqG2AcRxuGOSQU6XDaNU
	 kxZi+99tRFp9NjCsxjynLO0pAouLnlXE+rdf5DEDqJmx8C6C75VO3cdqZs/M9Q1V3uq6F8+4sVSW
	 yB0aX7GubKHWTNYOU65+/BKx1+ljP/7fhpjb+iDPPvbYN/mhhfdNRBbs+8pJnoxRRNhtMlvn/ttz
	 wW/kMFNtkYZrN812RAi6bR4By8XbPxNwTRCEKrW3snsQZsl369rejh9ploNlEa98nclS3pINDKCa
	 CAzfLOZXiYiMrncJ02M87fqJi+MsEb/vY1xNYOlbp/JbI+aF4SsCUQS/xyb3D3DrqxSEC9dHDx1j
	 e+84oWiVskpIawFxfInRYI8KwvqkBSBh16oa9Ngs2wcs1qY/R2+5wQ/StZ8xs7Tqej4M7VSXlN/F
	 +y9es7lwmexw6t5bajFef//zzeB32t9XEz9Pi2+tApElgi7yUucqRVfnoIW1npUU4K0PMksLspCc
	 qclURwBRU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+628f63ef3b071e16463e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in scheduler_tick (3)
Date: Thu, 21 Mar 2024 08:18:26 +0800
X-OQ-MSGID: <20240321001826.1709658-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000064f78806141c027e@google.com>
References: <00000000000064f78806141c027e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in scheduler_tick

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..8a21a59eb599 100644
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
 



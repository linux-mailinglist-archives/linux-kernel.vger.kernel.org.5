Return-Path: <linux-kernel+bounces-101478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEFB87A7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13231F21647
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55612184E;
	Wed, 13 Mar 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iPvednof"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EA6382
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333404; cv=none; b=ehc9vJZBElHAPSJCBFLz1JY+LVj8O3TOpkFILESIYPkX8/MTqrRZdEpIw8EVDkrEFSCjiSI5ngdiQZzQUmyrz+ZfnWAkRnHojY3TByPnGjCmu8hrC+kN33PgdQVjY/RK4K0IRzaIn0K6bS17U4v2X1Ncsb3Rq/+Y8OZHucNQCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333404; c=relaxed/simple;
	bh=aWra4bqvSXBMRGOR8oadwv4k5mdso03p4uV+mtuLElM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DtXq3pex+cIMi7oa+mqZLYnbU5bL7dBU0A+uJsVpUH4MwjNZgEi/0D6I/ZC3BlLH+P8RwBdwr6WcfbjQQ/JCkWICCxD61o8BPmFk4x1B1h3VX1J6ZuTS0lBbBNFOe9yaQTVCoBpAWdJaPirnfiGYHFCnE7AX2xd2rBoAucoBU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iPvednof; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710333394; bh=OgLhFLSnFF+KnR1j2cWCOJcqzUso8J0AlVNtXoJf7gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iPvednofxmJcs/HMLEW/hK6bwwZrI4Y+WrLt/OH5R3mn579RZ9bCnAm7EyW7bYeUf
	 dcjLAEogPWbteCoQRdRJ1STePyBQv/p2ek6qXvF7sGv0HmPPJ55HRkX3+PbwyKm+TQ
	 lR6iQu9ho1+S/8JnwsinHDBH6BW5SXlFSakiIOJo=
Received: from pek-lxu-l1.wrs.com ([2408:8409:ce0:12a0:a032:4bf1:303d:acae])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 79E170F9; Wed, 13 Mar 2024 20:30:30 +0800
X-QQ-mid: xmsmtpt1710333030tsqalmuzl
Message-ID: <tencent_0CC819694F840D98A5AA8DF9923F5DA6DD07@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwpJIo8Yb2elj2JqKwt2SYfbhyEfhwL/PrdCPiO1AMQEjXhSNFlC
	 MZmdWr6QM2fVieTDKjL/nPuD8G3kiB8Otje4sBgea5/hOCClJUuX+PD0brsYR+K3SgQt5ucgVH17
	 zfgVKR6KTa3858V5CBb7A3Oz6iTq2gfcZVT+4shmIGMlGZ3DtE+JcGiMXte/eSW082jp8w2xUFcj
	 xA3ARcuDdDM8J0rWS47iAhTy7UYg8Niz+GrVHRvz7L7BMcGuiQTh686o8EhHFS2hNNiduZgc1WVZ
	 g7DEq0ShAiQpKqivSs/OnSsYvchzpx2mosFi0NC9GRvjJDiodN76makHK3Ht31XPGJnMpkmOOWIM
	 CFf7vQ1Wwxf+EfERMyTu6+SwUeH8waTxR71hDgHPIps+92pdT/lIXDk/F/COa7WohRcXP6WUbdRB
	 YskwFfEob/59IVxgxZQRrLJDADKKeLmiRjscZt1fuvkhs2YWvz1P0nQXA325wBZs4m9FI0NVnJxN
	 Kn+RnBXmHYC1AWkOgbslCdxVL0Qp6/oRU6PEvaczjfkEZDSG7eaMluGnglwYYmekf+g4vmR3vla3
	 gmd/F5UD5wsbE8QmTiQuTY64SqxzwNMEM3av3Pggs5ipTmvI8ZBEeUh4uSHfJ8eG+aSVHmVqb14u
	 g5YuBw7HuQ55tVySiYmN5BZ6uH8qzkXz+yJWKHpEUrcwFUkOZg0A7dps8yo+7eIR2yzwcHRpISDN
	 9HmqqpzvtLSwX2fl/4wJFLOUp/Qn0yTQOzd7yA/tNID1QD6wEKi4/GHsYxwY2xQZWAorEdkUKRWj
	 416GIdkzsKmXpqmPKvGDZCJPE7MauFBjjyPc4psFgpkQDLsA8nHmubYonq615TmcCdqCLjmKUxvd
	 hvGoJ5ufTwCNHbeYXccPULQN0OFCHvI+iLGIbkW0XlY0vYf8w7+Wv/ME9N56k6GdWIC4MQ+gdn
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
Date: Wed, 13 Mar 2024 20:30:30 +0800
X-OQ-MSGID: <20240313123029.355852-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003ea6ba0613882a96@google.com>
References: <0000000000003ea6ba0613882a96@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test w in stashed_dentry_prune

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/libfs.c b/fs/libfs.c
index 0d14ae808fcf..67dc503272eb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2013,6 +2013,8 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 	if (!dentry)
 		return ERR_PTR(-ENOMEM);
 
+	/* Store address of location where dentry's supposed to be stashed. */
+	dentry->d_fsdata = stashed;
 	inode = new_inode_pseudo(sb);
 	if (!inode) {
 		dput(dentry);
@@ -2029,9 +2031,6 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 	WARN_ON_ONCE(!S_ISREG(inode->i_mode));
 	WARN_ON_ONCE(!IS_IMMUTABLE(inode));
 
-	/* Store address of location where dentry's supposed to be stashed. */
-	dentry->d_fsdata = stashed;
-
 	/* @data is now owned by the fs */
 	d_instantiate(dentry, inode);
 	return dentry;



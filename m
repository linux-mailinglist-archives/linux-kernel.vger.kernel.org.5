Return-Path: <linux-kernel+bounces-125909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F63892E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00505B21066
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 23:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82ED4AED7;
	Sat, 30 Mar 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sK5e1B2E"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C21119F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711842984; cv=none; b=lAqVoBt5NZAvbHwlC+03QGgnqTUq58KNMburgZBmOkkTpp9ilgaBvj4/MEM44lA1k8qPJ2cra5/1bbiTB8/0zwP1ttdezKNvqmB0OQfOtnbEeOwOZkpGSpdjqR4iaj4gFx7EHyHjWFjzojsgZBR6FNtFtI4jfabnM5XlLU1jmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711842984; c=relaxed/simple;
	bh=x65TiEMRKSzJGmBAjthL9CuCrBQKCV4P+6riV8TqnpM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Gi6WGTZdlcYZRvraW20OjzHeSeDxY+qObyxkeW6inO766ERT1U4I3iRyhX4Ly6VxpXsm+JybzwKMIyXeQSUCULuxPebNO0D1xGNBSYz5c0DjgXTir2tnJtfibgaRKLNHRzUq6NfZ/OB4uKtq3RnE6Rj6ZUGm5YsPr1cLId6jnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sK5e1B2E; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711842970; bh=J0kWCLJ4eKpWHBiKSaVoSxqt9mAWFp/YDcHne4JQ/yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sK5e1B2EEKDnM7M8L9jD7YM8XVTrmDUbnMPmGCkOVGvM+1GsNjq45hhxOIwA32d9w
	 Qrrlpz5R6JDIBgkCFtXr26NBanBhMDOjw6/whQ87INEePVdtbit1BzxY5edCpT16fr
	 b44F3q+TKf4srJSjgIzJbZxe4jMV7c5rlpsy9mCc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id C8014CA5; Sun, 31 Mar 2024 07:50:00 +0800
X-QQ-mid: xmsmtpt1711842600tc0wiwbpc
Message-ID: <tencent_A50DF61259DD955DDD190C4FE50D88A5C207@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2I1TWzPLBAfz//1XznTKBObbY+5LivoG7cAYOVoYM
	 0inrSzR0XCUgqM4ZzLAWv2fNiWM3fZGIseGKdZwIYDe0UZaiisOt5wDUCiVr2cVrkb/5kXRz2AdN
	 JBPMnVue1tsWsAqtnkm7PkBxPcQc7yNisRR1+mrdwr198le61L+zjR0s+NqT0OS73YIIHD9/K29O
	 3rRUcuBzSmvvC7u+7kvDUf9DGL+OEPr+4GDM88V+x4lMLc08xFzk85hbWH7aJ071QpeLIHXOqkVm
	 lOJm7+qc6CrkaMFy97NzDk/d0vFiqpU6VPkhGnWMskuucPU3MRzsZuU6jZcQOFziYru+0K//oXYC
	 mX7DrxUO6Cy+4jm1S8gyZCYz/NdGswuHZpHk9O1GYKWV+bkBBulQhp5WWVn6dMhbMizQzl3VlXLB
	 mp+IgYCaSyMGZjxbIPmElxjzqsYbe1tPJ6wdMqqnoMBlwYJkEpT5IfCY7g1EkzBor+FsQUURHX2t
	 9ggx7pL1H10U/XtWkG4ygVwysbzP/92FeyPrG38CayEatwhIAgifhNwAIpqKTcNACf5h/XdJWsHV
	 0ELwGPGuIc4OjmPR6YdD25pl2APwJAwsCBpEBnzUGaq26iCzK7HGMJogwJDwuVnFwMZ6PhsvUWaw
	 OIVwEsMHdjHgM2hRVDEx9c9f8kTOCsrBhx0N04HPV5iQdnX9Efl8b9BzAZC88/vcN2HR0tQpEkYd
	 pqGYc6ylIk3pBubU3ZVk7XP6mZdy+3VgkQuHaj5h/L1ZD80vEjXWzK24rQDNx7tLPa7T15uRbwEj
	 AgvJGdnFpkdqrf7FRdlwAuNv1BPSBoV3varFONgaZUMIEsIfunDtAAfpFZZ5WWZmUQV3SuHQUV7q
	 DgUnT+PakMB8VGobOnAST1N+vtoRdHj4z74DeCtK6rG7431vXoFtNg7sekgIH5og==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
Date: Sun, 31 Mar 2024 07:49:59 +0800
X-OQ-MSGID: <20240330234958.614313-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a77e580614ded85a@google.com>
References: <000000000000a77e580614ded85a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uv p9_client_rpc

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..30e183b880d5 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -292,6 +292,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 	if (!req)
 		return ERR_PTR(-ENOMEM);
 
+	memset(req, 0, sizeof(req));
 	if (p9_fcall_init(c, &req->tc, alloc_tsize))
 		goto free_req;
 	if (p9_fcall_init(c, &req->rc, alloc_rsize))



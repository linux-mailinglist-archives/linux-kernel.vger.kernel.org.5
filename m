Return-Path: <linux-kernel+bounces-12682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D033E81F8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655731F242C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF6847B;
	Thu, 28 Dec 2023 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vpWvnQ+d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098F8470
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703770160; bh=qpDeNZlSNBNw0kYgLVhEIbH+jxBdEEkgHnOnDAufrI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vpWvnQ+deNbvH2LJLWokUZtv9WTPux7bus7e8u9auxdnSqlzj6mNfCGqrEEYkZbNr
	 qBSpjBnIGli6goB33ubeAswMJYShu1PXwH7+jIWUUaqZggoMTlxZvO6Liv+2IyPtt1
	 6SvmUk01rioi476se7i+MjI/IRd0HlcD3L288iH0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 54113495; Thu, 28 Dec 2023 21:21:01 +0800
X-QQ-mid: xmsmtpt1703769661t2ruuvpk9
Message-ID: <tencent_73B236904A1C74EF77D367E43C4D36669709@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJO9fwN0NmcXHaWDhqqaAgULV5AL1QebzvFBAzIUm/EJEVqcwbxI
	 weMzkg6J0kWsgjX6FKR6J4xTF7OObWZImnVOCtANjyfdCVO6tmMWVoOg+ZQSAdUm+fhSWYSvQ4nM
	 xhkPgiLSCJJmoWrcx4Mg5vM3nMHl0bYIsTVeku2196M0dSeanTOBm2OtRAc988lxmcQCoEB+elKt
	 OiN4YR8L9OQBwwiQ+jkOLCmutuke3VtV/Aa1t6c33sQjcnJtP9daTROEdd53C0h1F0Iu9OoIrcRZ
	 Mo6xrx7tfhm6QJCXDadessSlaUHQ47ORyPJ9woaZpCqZD+5228Lj1m1HGkS5ZULuteCf6SrtRiPS
	 OLStCdBHG84guuGBNt/Epz7sv+GxRj/1QtCT2jyalQk/0T9+JOLB+CexSWIOY72EUbBty9UyvYtB
	 Qh+J2YykZJrxTMlWvuah0HTDMxlJRSqiBk41zev0FTqFdQDsYDv7pIEr1UYJLMXpQVj/yiM6gYoJ
	 t/+qt4XujkaYM88+ubDLLfoxC4WeJxq+q72+RJ9xljtj30eebnjv58ZMjp2g+kVMAL7Qa7FaYNvl
	 ekM0mtyIsyCGLhO0yIxMmua2NgLRKL4aRItJ2FUgc7jdDCLE2FUgExg2VKGFaCqZIfEydR6c5zNn
	 c0SuKRczAXdY2mtRwcEwVmucpnf+IJoeqcxlRlAZCk7H2cohUUOC1S6CbV4MMQOK8cOZWsfyi7mF
	 q4InoJt6K//mfqatr9CjGJ6HmaX+K2nAdQ0KLHRBVpaVLj9hyoZDSlBKB+W1PwC81H6fM4t9XoTM
	 1trW2v8ZwCZEtr6wCJdrtvW1vja9JV1NH/YvT1mBbXJMIXQiDUnBvUW9aOq9c2GwkhYBKbg5QM5I
	 gM5M2ZbALuxdLsqD/bsU5RK/8/uvKkQ5lvV9RbYJzhCv0Zb4fmyayi3biON7J2oA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfsplus_ext_cache_extent
Date: Thu, 28 Dec 2023 21:21:01 +0800
X-OQ-MSGID: <20231228132100.29990-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002cf943060d8f4e3c@google.com>
References: <0000000000002cf943060d8f4e3c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in __hfsplus_ext_cache_extent

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..9d4ffff6d42e 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -23,6 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		return -ENOMEM;
 	fd->search_key = ptr;
 	fd->key = ptr + tree->max_key_len + 2;
+	fd->key->ext.fork_type = 0;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {



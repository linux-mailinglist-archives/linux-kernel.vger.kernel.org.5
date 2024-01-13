Return-Path: <linux-kernel+bounces-25270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B782CC71
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD86E284227
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330A120DE9;
	Sat, 13 Jan 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GGFKv4Vs"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4A20DC6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705143804; bh=IalPj4dWcc3Tst3zLyeeQAncbEoxVIiQCJ3k5GdQ4SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GGFKv4VsdFkcgFKVDaBOcD5d1hOjIkiSModDMs+KiqSu6wBj7XqFBo7Ij7OtpTM23
	 uh1WHCY+BrKJoIOeliDLpncecfQiFPT6wo6RDU2zApx9Zt75aVxqES7TzimTJT9Fo3
	 VIrHDPXzvcRynRlybdyEv6Yam86pixfe2BbOvbsI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id DC9028D0; Sat, 13 Jan 2024 18:55:09 +0800
X-QQ-mid: xmsmtpt1705143309ts2d34r7z
Message-ID: <tencent_53EC36AE4A8A751776E7672A3C8737D69709@qq.com>
X-QQ-XMAILINFO: MWdgP8+gtiFRSS+ndu4x9KH00rQSYVWyvkIjAwUeb0KnyEmKKERwLzYYk7ZUt8
	 k4rZckQ60KqU4aZLo069ncLX5vw4qIS0RXPCtfRMO3Kh4CKVVG32zIhPoloBHT3uzIqNxh49wuNE
	 BJE/KjSIdzq94pL4o16ev9m/jjV8+m2o4mh3MQo/pRAEB0nwNK7D34M3kpQHeRAv+tHTTomGcyKg
	 WyMTazc6WDmeEfKC5C5QAT47N6QCVElOjIIqn1aDVzy2fwjnkWhDaCjhUblt3bvn646yN0En/bvg
	 bXkLS2JNGLuN0D7sUymvomVy3gPgstgZkJZIETHbfa1ZUzvP+D9QanfClqGduxygcCpabpib02CW
	 L7j2aS+Y46nsTdISx/eThCEcML3BC+QjNQs2xvSO6u6ZxpBOFqMuUmkyRUxIuOXrls+90YEkl/iu
	 1UTIfR8k019bcnil/8u2eyJNQCdv7fhC3KW3d74ye4ZO5EQFsCAPd+RwCUd0TrALhj6LO9zS/719
	 A+KCis5ncEN2R0JDkC2hsHc8g4uFdOK05MKRK9YlskI0HEKy67b2AP9A49kOfKEpM4I2zDUx/foK
	 XP5ntC46Mvz1VkV3CxDQaGGXsnpsRz86BCx0iH2zg3n5717J+cR3rMZlDmpmBVJluZvEBkCYG9gB
	 NKEGpRRTeZgUK6DPdgwz8ZkmxlXqYIpejRtVi4Qr3QpmWrevIRRyE3rYUGz8fHb4xLEhkAcFH7Jx
	 YBOkm+cDDZCYyV30UHEFdVd3jX1p76zM5sIBco+Qft9vxi6c8LXWbZi/DDDlh29goxHS5rXgLlou
	 QDCXQkwWwVauMrEepJhr1i5LQJt//5L/BRuiONhKjuB2t/nnzNyO3esNj4fpeY6ehHRx38douHqW
	 xgs/gxvjqOhg+Ql8xKTBhneieOUjiA5olj2lEWG9Z8TRz767iVCXZQOs1m9e8Pfg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in destroy_device_list
Date: Sat, 13 Jan 2024 18:55:09 +0800
X-OQ-MSGID: <20240113105509.1700896-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000aac725060ed0b15c@google.com>
References: <000000000000aac725060ed0b15c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-use-after-free Read in destroy_device_list

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 23a80d462c67

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d00d21a8b53a..9939e2445b1e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4879,6 +4879,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 
 	/* give only one another chance */



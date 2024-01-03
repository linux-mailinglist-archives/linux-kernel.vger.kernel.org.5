Return-Path: <linux-kernel+bounces-15500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A34822CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719C52858E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A9918ECC;
	Wed,  3 Jan 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tKg2/8QS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7A18EB5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704283997; bh=kXZ7H5ciV8izRUYlk7CkzEBsb3PXS4+N0LB5qQgk7Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tKg2/8QSOQQRL8Wr3FdQpzA/PMJlf9ysF9rZj0zgFmvqD3HF9uLhxbVIXaYCBrbQ9
	 BQkV4v4LIX79fRbqZo10r+VMy07jdNdTQlSIDhoZbCRTQp4kAGsCkIoXHl9hFQIdPb
	 9gOl8APJ6GXe/aTOWFlDlk+tjSoArUkfdrz9ODDw=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 34FAC091; Wed, 03 Jan 2024 20:13:15 +0800
X-QQ-mid: xmsmtpt1704283995t4ad9vegk
Message-ID: <tencent_5292EF864E49B52EDC6EF0CC99A7E4C6C306@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2L0azpIUZsry5Y/HUPF5hFdUj4LCsVXMen8nLulvz
	 gltrAhfJ/ubQm8Cf5k8FI4q3Dk3kN8Zpjh7u4GRC19fBk0V7imHh3Ug+vyKj2tISZohXId3Jh5ms
	 q2rxIvuAHuCP65hDVP52sfZH4n3CKFc0Qp+vVb0TlddA2/5VzVP+bBqsat4fC2d7WaDGqwRVp7Vs
	 47DSTGiUYRrndtyZ1bOfLrRadGn4E4iq9qcMiP7/V1W+yXoUouxdTcpFrcoEZnHcfl7Rkcbs/VqN
	 ZkIpT0tcBM28nFlJ928Na6MBAG4+BiIqwigE0v4ywGdPbATH2S4wIawSnIq6aJhTfZYS7jyGmQUL
	 XvfTFIoHERFXzp1Gl1/ptayPFt7bOKRFeM0c9PeB48FLEG+w63yg6W+IyDYqhjcIyDwG4rp4xhfi
	 OPmXkUnhLMZhiSSkS2YOWIy+VTBzTPcuXdU1co84BoWqRHBTn4NXoyGn7dmlZPtAXwhXHwDV5VK9
	 FWNckPzhRIk4upclCH8WiPQ/FW6UinyuJ7K7a7ssoj4vNzuVVVi9vF5gXEvZ/767Ai391FiCXR50
	 uId2zshqwgQpxfbMxU+iXd1qfgWsvu9uiorqotQ1f6sQTmO4Cn/R+9kLSw26k5Znyax9UP0XqU/p
	 GZlTvg415XQgVe32BEv3rFUW4oDiV+L45+us7Kx0nxqZmHZ2E0gGlicg/8bZ3U1tG9WdZSHWbCfq
	 S48/Q0gqnAKIDhu1AY0z2U2UZ98b9JARH7g8hmiHI84aFPheiKp+CFGhlp8PuaihNazNGnecFusW
	 NpaLtRozWB39lS4CcdT30twj4cn2QXaY2gARiELauCmCYdNUXpoZjsKPRjgSm2TrOWQXfYiNJXzT
	 sA6kuVOlkKGUThFH67LqXpPa9Puuz4oW4fOqqSigPQZJP+Rvoi1N9Y3X67GaI7lpYOHvycOjhU9a
	 en5l5GOEA=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] general protection fault in reiserfs_xattr_set
Date: Wed,  3 Jan 2024 20:13:16 +0800
X-OQ-MSGID: <20240103121315.2733802-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000009d4b80060df41cf8@google.com>
References: <0000000000009d4b80060df41cf8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in reiserfs_xattr_set

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 453f5db0619e

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 998035a6388e..00fd8f747394 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -618,6 +618,9 @@ int reiserfs_xattr_set(struct inode *inode, const char *name,
 	int error, error2;
 	size_t jbegin_count = reiserfs_xattr_nblocks(inode, buffer_size);
 
+	if (!reiserfs_xattrs_initialized(inode->i_sb))
+		return -EOPNOTSUPP;
+
 	/* Check before we start a transaction and then do nothing. */
 	if (!d_really_is_positive(REISERFS_SB(inode->i_sb)->priv_root))
 		return -EOPNOTSUPP;



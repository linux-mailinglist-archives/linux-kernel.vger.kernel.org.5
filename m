Return-Path: <linux-kernel+bounces-13614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FD820937
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 01:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DDBB21C02
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E20FBF2;
	Sun, 31 Dec 2023 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wm9UnN0v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D99FBE1
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703982767; bh=3rh044RPtRnB5qOZlrTQZ3Wq1aiTMZDQakFyYtFhlrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wm9UnN0vE+aTAwk4iDtKV7Xld9m7Uvrj2Y4S5sc3wL1uB9KPgLOA+PkKel4kMgJZy
	 4DrF6ZsqLzKaV5w0M7DZ41EbxL6JzUAhFeb7ZmXGhjr2EiNS37kc2fYE6zjd5hYTyL
	 hUYuHP6XdMQ4JWF5K7ogIq7VkaQhx10weLrcTlS8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 62402630; Sun, 31 Dec 2023 08:24:36 +0800
X-QQ-mid: xmsmtpt1703982276t8iav807o
Message-ID: <tencent_A1836F2960A3B98451B765576926CA937305@qq.com>
X-QQ-XMAILINFO: OUrMHMu9XZHvWDiNOLc4isXh0ELZPUmr0gmXh3prjQ7wuQ/3ZpQKbSYEZzqcvd
	 3xbog8WSkjYWDTqgxvs8aUJKpGSAceBUeJHeibWKbIg7ajK/HO+yZHy9A/Y+gbxpHi3muiTR6Txm
	 MhT2q5S6Yv+muo7/c76h+VW+awfE8PClUli2L5ZzK9uJdPrfhi7prKvEwVjPRy0Jf5NvIfIoDSMV
	 AkPaOpg0NmzQDysNg5Q5A4tlpu2LHkI6a9kCDsmg8WysDKNrcsRTiefl/coKNYPhulpHNngS099o
	 nK9mFcnynbKnPwO8kEL0/SJcO+ZwOQZEIMUNSHpJ75y0XzMrewy5YpvWPJ+epc3ZETSkbip1sCq9
	 IyQcrXgOfdKpHqGPSoCzDLS5jDeeYSpediupwLNjy6YDUt7bDWej/oYkQnvd6Gy2MgjB/U29SbmA
	 TSVAsWEMWESe7mpafnKMzF/zyOibjSVbqW6NkpAl4jnDG8KQzsbXT+YxR3NPrMRd0/lhzg+YL/b/
	 NuVcusM/DODEyam6zcLze1SN2R9z/H9U552lBCW72gY2/EL69uJmKZauBfHmg3AsMj9yUIQjyizk
	 cV91UsECvALLNO2D3pGvdxwX84Eh2Or+hPCup5vmStWDHauvRbxVfAw3IAQ09fe0jv5Rv6wcwp+i
	 DkTfYmfJ8BuBLlOGQxFp4bwP7Kvf1PfrkVnsgFvbB4PezH4uHWPqJojB93OcR5f9UYbadDdb8tyd
	 H85uyZ24smLqfRxouxvkVEm3Z5w5usxQEqpfpVc0iMg/iut80GmGdcddRsgHrIpRlHRITRJaFQaA
	 w2gKGtZqsBWBinS/v+Ixgwv0aHEWejtvna/CYE3DRGPE7KjQTrGoyMAbAv8QkUokpxdL005d/ud0
	 /65vzpvEi9/GfMQDX+S0fcjrWu+yOavkW0Tx6J+0VJ3OdlZr5gQQXXtd1BrsFVCg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] KMSAN: uninit-value in reiserfs_new_inode (2)
Date: Sun, 31 Dec 2023 08:24:36 +0800
X-OQ-MSGID: <20231231002435.3023407-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000da757a060d58ebbe@google.com>
References: <000000000000da757a060d58ebbe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in reiserfs_new_inode

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 861deac3b092

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 994d6e6995ab..3a824fb170d5 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -638,6 +638,10 @@ static int reiserfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	if (retval)
 		return retval;
 
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+	REISERFS_I(dir)->new_packing_locality = 0;
+#endif
+
 	if (!(inode = new_inode(dir->i_sb))) {
 		return -ENOMEM;
 	}



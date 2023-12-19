Return-Path: <linux-kernel+bounces-4664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D7818064
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E301A1F24C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C0883B;
	Tue, 19 Dec 2023 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YyuEVrGr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22990881E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702959098; bh=17oINVoUUTzdjrEByk1+pwtdRve7fqYC9tf0eEfH7y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YyuEVrGrIdLkG7HCjAj/BnY/mk/JInh8+Meal4rAqcIYANDfbjH1AA60adTnfBJCN
	 GtkUOFQTalX9+BC7LOnS9iIhay2xb9zMHvxlM/6RyOpw5QcvVZm+wqiCCXamCPpgFx
	 Ex5PQEFLmqNgJh1ns6vFOGF9BWfvRdpfiHyKJiqM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 15891662; Tue, 19 Dec 2023 12:05:24 +0800
X-QQ-mid: xmsmtpt1702958724th7prfzml
Message-ID: <tencent_E536EA4ACA75D3778366B23C3D37A696CE09@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj9WoC9EoF/oo7ZpvT58T0cUg3uPJl+mP2NfWSOuBpaNI/m0eJHQ
	 wXzhzIrczD6nbvsx3Qglb4DQceC7AcHwL+2id+7ysIYArc1VMXcDQQlhSysLDf3aP2x7AnonpMvi
	 atvgKlRHngS0LMLb1Ca243FP+pGtQHxbRafp/GE/6/TdCESjHjMM/mMa7Z2Rq+tJ98aP1T3Ba6ms
	 qUMEP89OOhmhbLa8CMqCp/9Ia3S0BJmsssWbCme6zmlkIzlzyT5GKxIWZ/Dc9e5EkH7GrcN0J2m+
	 mLRg+gDCgvTJmCauT5GyEJOQNjHfjw8KH+xucpmQHkP66ZEacuiSPb6xZm2JZxCEL6bs+PTRjCIo
	 wEZL7PYNbQME/vmirS8/l1/z43fy4D/6rtboH+9E/vpT8ovg0ZXA7UiHN1A/mgf3esAH/TfwDtXL
	 t+s0jaO0tHpq7SBTYn0hSJP552RLEqYA1CRKoV/+9gqQa/RSbHXfBLOkyj0QNAp+vSxFy2rrKwv8
	 DQxyUrfiEUDRK2O/FZ0UwOLjz6uR4csHkZr1capzqgzd40k6/8BDvVOkI8cMYLgxVxNMEOrLBy0u
	 BMp9LVtAbQHHpeZ/Ut13vJAczoRGQbzrn6FoLehrznLaSpXbfDb40JW1+doksSc5TgdOE9+QOhcY
	 kcSVs0H8EdHmowLmfAaZEVhtWwq60Vl5UHDyZjKHUeiSW5pmcM7eLYLbD1MeKUoaCEpUrcLhW7hh
	 JkcbAL7bvu/83KdLuApNXOvAJDILpeXrwn4UtrkQkUCpCSUryLQ1qo/EgEqvuA9szgZ+t7mej8fd
	 QBV4pTJ2yjWAxZzQtG7AXv1RekM1leXtJkvIHO8i76wF2mebZXFbxkQnhkNCcPx9KO0nUHS14Yj+
	 cDbI+pBJA+SJS/eMpXoN9KnjU1ksqGeYGRmxoyG9mdZXcjxpd6p72mtZTHYgeWPpCT/HaJQ/ojpd
	 5haeqSZIuDe1xfmDQDJTWCe9zGcVh+NkHmb3C4YIE=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 12:05:25 +0800
X-OQ-MSGID: <20231219040524.1687447-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000d1a1d1060cc9c5e7@google.com>
References: <000000000000d1a1d1060cc9c5e7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-out-of-bounds Read in getname_kernel

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3bd7d7488169

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f9544fda38e9..b7e8392d34dc 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -741,7 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	}
 
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
+	    args->start.tgtdev_name[0] == '\0' ||
+	    !args->start.tgtdev_name[0])
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
diff --git a/mm/util.c b/mm/util.c
index 744b4d7e3fae..2581d687df87 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -194,7 +194,7 @@ void *memdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
+	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN | __GFP_ZERO);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 



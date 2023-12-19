Return-Path: <linux-kernel+bounces-4716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C9818102
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4CE1C21903
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E868493;
	Tue, 19 Dec 2023 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zg4T8xC7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FA6FCE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702963801; bh=I2awE1lJaTlqqkdyjpo87BzMEp2fNSxxS6Cb/6JrL0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zg4T8xC7DD9A8qUJHOnGPejgk01oNzmliWgUrKHcq0eb+BNK6QBRSbM/ySZeXTpIZ
	 uZybpH9m4GopuyH3XmjJh7pffEtDUSpAxiFQPkNUkbmvWSyA3M5l7MXiwuWIEL1hsF
	 qBb1AdKE7aKuoYQ5PvclsgIXfc1S2cGqrGvwvyKk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 5F9AD815; Tue, 19 Dec 2023 13:23:57 +0800
X-QQ-mid: xmsmtpt1702963437tbwlodod7
Message-ID: <tencent_D55B49852EFAAEE78C9D67DB46EB52F44606@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieHB9v/AIEcRCwh4pChVC/FFsoHNMCEnQZCNkfQSf1to6BetoCxh
	 UnFqnS1bg0RhU27i64xkHDqQw8jVTR+zHKXSh7eL8JT4ozxtHPMbHQR8zR/AYqSr3IMS05H6Wmj4
	 IqT5JReu/eZi/rsYcQaUFDOScvBGkqsQ4ruWU3iXWqzivijcPLOcP0nqHeMbLCChzRTHM+1c7LXb
	 NgqJatBifvExUCaeehilW8/ceIGl7dXkwFjuWJU1dpUcSOWBYDXWRskgMMVXvbVC6eSTN/FsYwoG
	 MqBByopnBhr8NqX8LclyCrK9Tr6xIVUYUKyvwRBQ/qJcJ7FRC/XKd0qUx65+b0KqzR2qgRWsNh7d
	 3oGvDUm0wVYFzXl6x+4UoVAWYwnQ1Orw3A1nXQqQ2xwl2rJpZw6xiJDYXXRgV2TfHvmJGRqaShWo
	 i4LuLyJpGy2ZyW7oEj9XE7ncmTrvtBwLz51kPUc5ctMQXHmpVBuH9tLvxarsoYUMF8nWc6/9QtdS
	 njM+lphGEdgtRixhqa2j80sZvkV46UdZQaM7g8rYa1Vr6PSmKnUmK9wsZHKKwsgIbIdW/Fr3iGKf
	 XE3QRutXaVy44bYnblZ6ZU1127VZEFnzOz3aahQ+yIDnpVdH/lmJKM73sKHe1mA9gWhkdAJWnRM3
	 YnDoBTaYCkF3lZLGCeerVcclut+G3trielD8OhDNvmfbLJcrd5+wRtABDkX8mQUMojBlmlnIRGAF
	 vbRmQkowqnW0eFv1qjhM/4cXkI0DWdkSdFqOJJ3xYeNzMlyqAmNsMNvWd1UD8iOI1ykgDUk6mK2G
	 P2tOxWYZX0D8WDRkpM9FSkvIXi0rURf6Et7AQm0IBGiOR7bZYzl5LnToB7YESs3Dn7MGDN39zx5z
	 Jnw+OLo25PpxbQB4McCgxO+tQCQ+dRmDZsVtCPTQZVMhx479aUawJwnrl53rXiSuXg8xTaVaSemi
	 d6tAM6jAtN+pj/TvwqFg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+20e9a5e0dd424a875f55@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] INFO: task hung in blkdev_flush_mapping
Date: Tue, 19 Dec 2023 13:23:58 +0800
X-OQ-MSGID: <20231219052357.1770891-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000008e6074060cc640bc@google.com>
References: <0000000000008e6074060cc640bc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in blkdev_flush_mapping

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5bd7ef53ffe5
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b6414e1e645b..31656364d8a3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1394,6 +1394,9 @@ static int nbd_start_device(struct nbd_device *nbd)
 	}
 	set_bit(NBD_RT_HAS_PID_FILE, &config->runtime_flags);
 
+	if (num_connections == 1 && !nbd->tag_set.timeout)
+		nbd->tag_set.timeout = HZ * 1024;
+
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
 		struct recv_thread_args *args;



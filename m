Return-Path: <linux-kernel+bounces-2509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AC815E3E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C131F221DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289091FDB;
	Sun, 17 Dec 2023 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c8u6Ajyy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC01C17;
	Sun, 17 Dec 2023 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702802246; bh=Cu0nA0cgoDEd9tG8+d+j50FSTxVeILTQkKFvK9DqtUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c8u6AjyyLwuw/cwAd//5d6Ts+Rokd2xosKplpbJeXFMed2SZYBabFSnHloObEStjM
	 n+hc4Ob6rlcGpMzIbPEGOKJgwVcVEJ9pdsuBSHY+DSO/h76nyAsWPa2htoQsFvHckc
	 ju7kEIjZw2eibsdLeWCN0JA8/ywc3PYyaFcDDZe0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 881A00AA; Sun, 17 Dec 2023 16:34:01 +0800
X-QQ-mid: xmsmtpt1702802041tao8s72lf
Message-ID: <tencent_AB577926C13364C3696965A3A2244B776605@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIe+6yMR1GxFSCIgL66rhyDgy4IYmyvPR/d+QQ8fRyhjEbRyYCdlN
	 TLsxTG1YWgseAAebyOzN4p2aVvm+Qv9dUyHdR0JCMpVpRIHlFA1xovgq5IluZnIAQNc0E6XEiFaK
	 l8j6+krtL9tqBLC1uvaySDUBML6aECEzLVx7YfiVCFTwdyVaQ+ufunlI4AJCECVpQ8deqdP4hm2X
	 J3n3eJdNZLPlv6v8qyRqXBET4L7kiiCQtIGns6SLeUdeaZ/we84Iz3pl6gRggDxnJVDWLBrJNDbL
	 SlVRLtXzVc146/CbTW//UljvPWqkffbQkq0/L7tq/zI/vQPXEFnJsL8e5TmhuYdpucT4xAj2ADSv
	 K2l68VecFyGFGuX7KpRosQkPCKsnoNLa9ihuxtf1QjCgpnWbQyTFFWWXzdKiJZYnqiH7oyjZ+BTs
	 Kre2VQBcpP3SGdOQK9jPSkUDiT8H5TGxXNDysokQdQoeS8VUwLv+rAw5rdyRlCZlzyWVr/kJuG2W
	 SbHnPFFDnJKFMezBMwuEYsHLt+eNZ0mJBLot/+0vgETNP/7JfKGENVrnHGrfcudv5UfsljL7nY7g
	 6mlrSi4otzU0xQadPwJFhqPP7VZ7LRe5COjxjt+UNyEgRhoUdFkmcvCgzrKEiMB6pvQ1C3SjWBQp
	 IUhyRNb+GyJk1DsQqNHFnhB5Ykw2A0cOeHoOvq8vNIryL4d/3d+Hj88OScYcjUwZjaSPQzJf+ET6
	 9+xjhPYRWMZfxBHO90ubXQlsjKzZIzJYvoUcTUdvtBuvoG4wfs5xPjm9dkWpsP4VTXLWNP/PD4MN
	 t5VIJDmFGWktb8NXozZs1BBlR/4LNj+vWLI5q0c/XavmE2bu7m0xybUUxXxAf1G7SxiM0l5hNG0B
	 Vq2koLZWtFwtFzsOkWa8JaLEUETK0LIQ4+RyPhbpf8PNXrWyFja5nwdCQpFjkEO0KnVY7skWdnsC
	 RHbRJl5Mk=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] nbd: fix task hung in bdev_release
Date: Sun, 17 Dec 2023 16:34:02 +0800
X-OQ-MSGID: <20231217083401.4160650-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000098af2060b5ff161@google.com>
References: <000000000000098af2060b5ff161@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the nbd timeout value is not set before calling nbd_start_device_ioctl(),
so the socket will be disabled disconnection, which will cause the timer to 
only be reset and cause this 143 second timeout issue.

The solution I have provided here is to set the default timeout value for nbd in
nbd_start_device() to avoid problems from occurring.

Reported-and-tested-by: syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.43.0



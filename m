Return-Path: <linux-kernel+bounces-27237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447882EC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338B728348E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987EA134C6;
	Tue, 16 Jan 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ca5Ctil1"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE75134B6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705399728; bh=RbrFNBhAbWaNXKDU9bLaHQrIHTGxxv64748eV9Y5qT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ca5Ctil1RnJp+xoQzYbswI7hDWipcqh5s05tUFVIc4V20oYEhxcam3YKb95PK1goE
	 8idJ1nMqqfHTdgYMcS873z5znrEbsSfgdmOO2xdG1DQYY05abZ/BcoTMJmZBbs95Up
	 6CLm1r7YJNNt5CuG+OI9xO2VjX5ICtgywKKWzLfA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id ACBD886; Tue, 16 Jan 2024 18:02:44 +0800
X-QQ-mid: xmsmtpt1705399364tlk4xvu33
Message-ID: <tencent_60371697EC37444A2C756B77D567103CA109@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69+OV4WSENK3vQvStHKhjPC1Myk+QT/ObxMhcmvcUvAVC8j8Frdq
	 mW+OAtgjzBHhITe+bXbDeaHzdbXeaaw86B3IgwPb1qGfTMTpADitnxB5GRycS0Nm2YSTKlih05yP
	 PAAbpoYzM41wZbUYEelVtD350V3wf/m77kYNc+I7YMVkT+8pKsdx1s4m0s4eBzEJxX3N5Kx+/IXI
	 a2564BpRsuQt+Y53k5Q0JMX91E120V648bBZNbWWe4YPJLRsAweBUuL/thdzuDhDWcF0JofW1czS
	 9IpML9GqUmF+f5QkYOjAQAkQiK1ozEWI38u6Jv7WS86oZAnAgJAZAhr1DGbhP3NYmFcsTFXHJfTl
	 3WG+ILViQTojjrN7dUQmzT+GjSYgRfk25HaJlTWqxjDZKCViD6N/0eczzWsTzRfEcATwwB1M17vj
	 ItzjEgMriHWE9S1gET7p++U0Md5SuZs9CdIweVI9fEfJbeOZWUVkAhm0hg285GyuUbp8ipKXpaSh
	 S1ISL48pqCOdG6WBtMDbCEXD8TPRJr8mvxsyR1I9cr1Hq/4eRvjdGw2mypuz8AdqlcHjQvvwJjKH
	 CknL+By81Qv5fCLH8MNsm0HtJTzX5V9Kp939/lTzxTa+5JV7fEhzqIa6tmiheD5MxVWmiqOWlxLz
	 cI0cGDOobO3o2Xgu1vP+6L2MlZsyWj8a/17WI9vm32sNQRu08ES5v8qygxakh3209MW3FtrBESSQ
	 HRrQhnxZr1Yb+498B0ydZeJ5O+trtro/YZ4To8vv6QlOEfa8byD/o/vQ8Ak3KzPhCtO1HmC5v00/
	 Yw3WQ8iOpCQVb7DlWYuSgp3GU12p+YcLZMl14Y187XBcTJvfRHDT1uJdtPne5+kIz9n7UxH1R/40
	 SvT+zveCp4kjXDLUJE1gO/zKypKaB7AKauvPxp94FjPmn8IM8+ckqCSHeP7eSj63juuwP4fDdS1F
	 p8VRKepwuIHpYcGWhLerMtrDAxATLV
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
Date: Tue, 16 Jan 2024 18:02:45 +0800
X-OQ-MSGID: <20240116100244.645287-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000002faa2060f02e766@google.com>
References: <00000000000002faa2060f02e766@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-out-of-bounds Read in dsa_user_prechangeupper

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3e7aeb78ab01

diff --git a/net/dsa/user.c b/net/dsa/user.c
index b738a466e2dc..2034587b3a68 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2865,14 +2865,16 @@ static int dsa_user_changeupper(struct net_device *dev,
 static int dsa_user_prechangeupper(struct net_device *dev,
 				   struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
+	const struct rtnl_link_ops *ops = dev->rtnl_link_ops;
+	struct dsa_port *dp = ops->priv_size >= sizeof(*dp) ? 
+		dsa_user_to_port(dev) : NULL;
 
 	if (!dsa_user_dev_check(dev))
 		return NOTIFY_DONE;
 
-	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
+	if (netif_is_bridge_master(info->upper_dev) && !info->linking && dp)
 		dsa_port_pre_bridge_leave(dp, info->upper_dev);
-	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
+	else if (netif_is_lag_master(info->upper_dev) && !info->linking && dp)
 		dsa_port_pre_lag_leave(dp, info->upper_dev);
 	/* dsa_port_pre_hsr_leave is not yet necessary since hsr devices cannot
 	 * meaningfully placed under a bridge yet
-- 
2.43.0



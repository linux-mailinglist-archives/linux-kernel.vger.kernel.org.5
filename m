Return-Path: <linux-kernel+bounces-27166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B745682EB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4431C22E44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22512B72;
	Tue, 16 Jan 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GDvzY5ew"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19897125B2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705396619; bh=lIy9wHh+g96JsNjrDnYthtgcgqnhJ+ghbboFhC4b3To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GDvzY5ewoL1j17KitP4H3tK8g2EywKVAr2IQkjbgVQGZUE6X9nZesquh2vLubtaXd
	 lHAx33DgORPvanZ0fW57m41RyIy/Lh8jFU96z90dj6SrqrGbkK3dQeKYRqXcRPAfDc
	 oLffTSYwNrkC/tthZ7+HTm6fM14Dd54AVwxZBmGg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 35E86CCF; Tue, 16 Jan 2024 17:13:30 +0800
X-QQ-mid: xmsmtpt1705396410tsyui8bbs
Message-ID: <tencent_674ACC74C977BF672C3C2F37AC97E236F409@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTqLDJ+oJttz4uiJ218HS117yUUOijsOcEdfAtEXrfmON6pnQFf2
	 hgqXiout9Fq0RRqgkq1zRMqtDmwEChyznopyzyMhizf0sxWr4WIyNeS6fABqIjZh3wqHODFlqkKn
	 dlbv3gZyffNSEI75IJlYEiu3zJ2eNeX990/YlNEMcf+EF+eImZTKCHeox/anL7KI9pSZ0WYuoRoX
	 zO+IkvIBkH+/NmtHsmMrHitu+gzWslPMWpSYLwXwpHpQjlGTWoIF1gjZS6k0uhFdsaXojL5cyhM0
	 nbE+/nH9fMN5isOZskjPoyoa8cpgQ76vu/pkm0+Io1BqK5PSRr4Yqj/OF6Yaf64ZFcMrZB4zCcUR
	 hY1Igpq1vF4d9YnhLhfZyAoxQSEyEbxOPSkbo/fDZmYV52aodqyk8D0c6JAqdyH0FxWFw8pppccI
	 6x5U3ToOU4YxO33jrT2MJZh4eqcsllKI5OPkqgarXPSqvLnif8qvURkJUaB1TAEk1sMZFlCdYe/C
	 QSYAeechqvDZsFHD04nkLf0BbhZdoyCmRdFdlFg4U/ZAmddtU8B8xw0er3DaLm0p2XWbFL9BA73z
	 9jxRXgKMFbtJdBodbBxSiJBl7DjKris0gMNNTfz3ps9sf4V8S0uY5jTdVuFDexapgRf9G6svdiSJ
	 WkryBXrtMIPxhNH0ipq3yXLKUFcTuRc1joY0f+5gu94LzCd87f5FPo/A9mMy6epAr9JyucMRAsTy
	 MtAlBq6ZJb1hYkkewqaEtjp4Ru96+xf8WRLcYM/ysr8f73lGql8lrYCD7OibWNdIS9FzoaveTK1q
	 ZESCWPl5pBHy6iv5LwEoewNkQMrXP2OkHhWSkfblx9HXrzRf3mgSP9usfIGipjs+S9ccUzj9UdM/
	 PhtADsig80062YgrKSn1s1g7TQiGHVDE3UtKdZX0yiXctFIT86rkReIoCuoTGZXiDSFo0OsffFip
	 crc3PiLPU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
Date: Tue, 16 Jan 2024 17:13:31 +0800
X-OQ-MSGID: <20240116091330.572860-2-eadavis@qq.com>
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
index b738a466e2dc..e6bb2c527067 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2865,7 +2865,8 @@ static int dsa_user_changeupper(struct net_device *dev,
 static int dsa_user_prechangeupper(struct net_device *dev,
 				   struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
+	const struct rtnl_link_ops *ops = dev->rtnl_link_ops;
+	struct dsa_port *dp = ops->priv_size ? dsa_user_to_port(dev) : NULL;
 
 	if (!dsa_user_dev_check(dev))
 		return NOTIFY_DONE;



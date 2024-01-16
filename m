Return-Path: <linux-kernel+bounces-27460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7B82F072
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B701C234FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54D1BF22;
	Tue, 16 Jan 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J+OWdh6A"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20791BDFC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705414759; bh=hVZ/HiO5uU1gBjNNiO+94yCP41EBlFJE2bjhqvDtdTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J+OWdh6ALpv4xKOgMt6i4rHoufsXoJVMHKAIvEcpPoinvgCfCTmD2n+KnpS8yC0X6
	 tCzjCFJSuaYD+GLiGsyOUGV4tjQIg+Mb9tf9hjSPGFT7qQ8G6hj4OggBGxuDh7q8Ar
	 DEyfMPC0cCoxVtzdsdmSrf4crEOPxoFcAYjoz+lA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 350128D8; Tue, 16 Jan 2024 22:13:16 +0800
X-QQ-mid: xmsmtpt1705414396tj04rh3xf
Message-ID: <tencent_CBECC6CDB07A5A6C182C156DAC9490EB160A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9RG4S4i57iS1wgbWQUvqmhnnm/R3d6e/JeU7u3F4LCVpTlsFzJ0
	 +Zjj1ZXCsoQ4YHeloGST7SZAggtPT7SE6oaZ+6LaHrH5ikZmvGhddf6fxqVgEn8SN8unjXf2OYBo
	 /KnUOnt0COGwJD/WGcnAUzWBh61TN078P+E5rb+GhbuqwEy5t1DTX8VoC6JnaBEDRgjjmc7pIAJR
	 CCLsvCAvg+Ms+3jpc8wSjBqbjKeKjfmyBYgt4alobetp5pSL6dp1nOKAVNE5IfXgDUqn4Tz1XD3t
	 CmJbk9ZhpitX3tHpox5MoR1BKR5tpDNZOMnL6bF9mjfkrVOdUCl5bwAnoG25u1NGco77uHkBqs53
	 0nBgWefLDUs5yGyXxZqojFz4wx81Xc4DPjkS5pp2a4DKw3ygsb31f1Zko+Kl7xW6vpsSL0/UBKhE
	 VLUd5hGibwXrtmnPv+9YOjPyWLR4YGUPbBM8xhEP7UpAdtQhdZRS9xGUi+dRsB/TxXu5YWn27/Ex
	 Vm9cypB6r8g8GtwGfE2XjQkfj+yfaAPOVss7xv0+Wy25FO96P7CO648ooGa8Oan6P6LlatYQHwfR
	 W1cGaskGeM6dUZIcdH3TuE9Oj5rpg/4R7RY4imkbgARpIToOwVrEChfEhlApCfMXYiGFB3zh0qVw
	 wUmn8VfpGBjLSK0EiqLe6QW4v1KoD5ozgs/mFR8LATYYBTLPfTt/cWWVj0AD+yM4NncQFTU1C5B1
	 wkdlYXrVvIZ1Fh2o/cUASlMROsTOpPCj8hfqQq6VVrLaPkVgn+lTX+ndp5DnKgjfk70q3B+gRtUy
	 rUiRvIaTdjKd7Jlz0k1hTTxzMbt3PREggJMFdvy7hVt/8yTMDLv0/FasShioDXk3LgUWNqtrpkfL
	 VTXyMsM3Cn4AdqMeagmiIeSJSRwYQojZJVpd0+mG4YBsjgp28Kz2nwqGawHTaVsXq6NDWpsBfTvE
	 R3ef0nVsHYSgGj/gkXhA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
Date: Tue, 16 Jan 2024 22:13:16 +0800
X-OQ-MSGID: <20240116141315.955157-2-eadavis@qq.com>
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

diff --git a/net/dsa/user.h b/net/dsa/user.h
index 996069130bea..9a40918ee7fc 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -53,7 +53,11 @@ int dsa_user_manage_vlan_filtering(struct net_device *dev,
 
 static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
 {
-	struct dsa_user_priv *p = netdev_priv(dev);
+	const struct rtnl_link_ops *ops = dev->rtnl_link_ops;
+	struct dsa_user_priv *p = ops->priv_size >= sizeof(*p) ? 
+		netdev_priv(dev) : NULL;
+	if (!p)
+		return NULL;
 
 	return p->dp;
 }



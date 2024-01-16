Return-Path: <linux-kernel+bounces-27501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7B82F112
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2C31C235AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61C1BF52;
	Tue, 16 Jan 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XXiCmNju"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B11BF40
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705417795; bh=qjcLg5ms9S47F00EB6wAMEe0GkzvYo0BfBYr/994CQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXiCmNjuospjuz4EQ3N8DN1c+80X1HHJ9G8jzzIzJKDrF/5sZo9CoH7VZHIXQnfyQ
	 up1Z3vndEET1NwhH7jpHz2XFGyIlsH/Z0q6OZ95A55748Ee01R92BwkmBL6jD9QlbB
	 D6JV8MBAGny3dMwX+xVorVjm34LaAfuFcSqz5fco=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id E1992011; Tue, 16 Jan 2024 22:56:25 +0800
X-QQ-mid: xmsmtpt1705416985taran815z
Message-ID: <tencent_293767377D86CBF3726365497A43BD445205@qq.com>
X-QQ-XMAILINFO: Nu+mFq/+qLTW6J1GszGKKMTR/InK/Fvy2NNiFYYAucHx9hFcoWmMvR7JHZMQMf
	 c8/RnwufjcfaXFEVBxwPWX8kFott6/6re8FQggruEDjTySyrITPffpe2xAqzthCp/eZm4Jcd4Qjd
	 8FeFe/rLoUx42wxdfd5WiO0mc+MvC9u1iYoczuUfLcqk+hPxNNRGaBEkgYIxBAIJma+I0ax4VG+x
	 zKUjChCiJiCq9wbuBNj8xK6U12zYfS/IerODRuCPx4VagwfjxBDOYiNdnPD2G6jdC5UtuwM/4mZg
	 qseaBdLpoLeJcnRPZTmLIzWnp6J77BvUom6IdX3bTsfDaifJFzOfTUKhG/SF0sTDqvpvM6k2DF6l
	 k1KcLdiTQkzruW+1TbEP4jfq4k36MQvRL+DVnsEjPRHnurxD/+WZG7xArF20dY72JxkIRT82UYZd
	 AYbpLaxyKEwCiAeoXB6X0jyT0hhlo1FtJ0MwgMw9x6csCZYnmlJQxooQ15a3tncLSXxYRoAWZ/S/
	 jTaOuIz6fS9ieuw55ITMRJf0W4O7dNbBfAwOrv3PYR4GJF7wizwFXsQkurXzhVM5PL0HZWuSp+Nh
	 5rVAeFpNNDhqpF2tmUZ4WvUoaDKZDuVZ/PU0U0+8vhld/0Y+L2+dMdQWo6CaKq3Ezb3VIVc1quPq
	 bTX17yitdp8aSvbZnhhMpd6rAxCteFlJU3hV0XecdaN00fLktIA2SYAOO/jidjKIDRtq7sJehFGv
	 BCb7Zcnzqw0+NNllbRxUw1hftKXmTNpe6pa23UXfrcQNhQt98o4l49k+TpTpKxrPZzt9F3oXVM81
	 Q77SSpUgeML2AQDFeqhQVJFU7UDvPp+RuUiWUo7e5ySfvws71GvTooxDKWw5rD7BB0aL+CymgUJa
	 Y+ZVlET6B0IZ9Cl5RsHE2zfW0sXsJJkAw7w6nDy5h+/EGGvu/P2LI4jJz6kfV9dE8cEaC4Wh1zIz
	 phRf5Hwq8=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com
Cc: andrew@lunn.ch,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	syzkaller-bugs@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH] net/dsa: fix oob in dsa_user_prechangeupper
Date: Tue, 16 Jan 2024 22:56:26 +0800
X-OQ-MSGID: <20240116145625.996134-2-eadavis@qq.com>
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

If the private data is not allocated memory when generating an instance of 
struct net_device, i.e. priv_size is too small, then its corresponding private
data should not be accessed.

Reported-and-tested-by: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/dsa/user.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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
-- 
2.43.0



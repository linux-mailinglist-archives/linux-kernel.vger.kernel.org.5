Return-Path: <linux-kernel+bounces-164310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBF8B7C27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC812B23360
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A717556A;
	Tue, 30 Apr 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FdZGkFtE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D165173344;
	Tue, 30 Apr 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492240; cv=none; b=BVjSkeeIZLNuZWQ5of0QEoMUjB7dDmoPCmr6Xd6jx4g5THYs2ICNYcoauYeBSebXdJ6jrH7Sr5pbJhJH5egoIdtctBSXSO0s8ktrpRBQyBLF790gvZdz5/X2+5dXaJU4l0cpFOKyCNg9pvuSewWVUhx0reXWJhCIwW1+B3YIiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492240; c=relaxed/simple;
	bh=VJPc8WmZzvyxcn/7sfR5efAUSqUidJZJJKnkz13s46Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAdpuGINWfyrKldcu5DYa1wTRpFPvQ/E6rOZiWHBWLq7/V4dTLsyXrm+FUeu2VD8PVAWhBvYLCToKwh0b8V3Q8QPIG51EebMb2n/3+ahQbyIxq5VqNlM26afmQLZDjN3h39Nbyq6/tm3rpdfm53ZtOkVrB/ias7++vtKu1IIb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FdZGkFtE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 398862000D;
	Tue, 30 Apr 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlHPCLywel0MzV0mBSERbfTFdW1JmAebwc9eEjS78G8=;
	b=FdZGkFtEUdr52Zgx2MzpI+qW0DGIn8tApu1jXNTpdnU2QrVU3ygB4Kt1IGJ5JZWTYiQmS6
	7zNrBK5PiWdfOHrAvJpHXqcZZCOoRR5Ex0dO2Vkud8r/GCY7DheA58m1GLOKgVVTSQ6hNs
	1xMyRUpRDfbbPKt9coTz3HLeqh/2zc4TT2+X8TIR3IdmmqhZRloooYNjMX9CyZz7FpCL4y
	tOJ3GPYPx6VnZtug76/s3ZJkeHQBPhev1sXCVNMyJwk+ZQ9E1753ei9lfoC5B7lQya37c0
	GHWJIMGPDRPIDpMLvwNf8LhJj/dFFnLF+rjgcZkwooflmKNVCsWG84TmGYxQzA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Apr 2024 17:49:45 +0200
Subject: [PATCH net-next v12 02/13] net: Move dev_set_hwtstamp_phylib to
 net/core/dev.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-feature_ptp_netnext-v12-2-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
In-Reply-To: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

This declaration was added to the header to be called from ethtool.
ethtool is separated from core for code organization but it is not really
a separate entity, it controls very core things.
As ethtool is an internal stuff it is not wise to have it in netdevice.h.
Move the declaration to net/core/dev.h instead.

Remove the EXPORT_SYMBOL_GPL call as ethtool can not be built as a module.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v10:
- New patch.
---
 include/linux/netdevice.h | 3 ---
 net/core/dev.h            | 4 ++++
 net/core/dev_ioctl.c      | 1 -
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f849e7d110ed..f0e4572cdad5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3901,9 +3901,6 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg,
 			       struct netlink_ext_ack *extack);
-int dev_set_hwtstamp_phylib(struct net_device *dev,
-			    struct kernel_hwtstamp_config *cfg,
-			    struct netlink_ext_ack *extack);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/net/core/dev.h b/net/core/dev.h
index 8572d2c8dc4a..39819fffece7 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -167,4 +167,8 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
 
+int dev_set_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack);
+
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 9a66cf5015f2..b9719ed3c3fd 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -363,7 +363,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_set_hwtstamp_phylib);
 
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {

-- 
2.34.1



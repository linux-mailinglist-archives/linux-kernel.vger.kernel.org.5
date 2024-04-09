Return-Path: <linux-kernel+bounces-136462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A789D445
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ABB281344
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6C584A2B;
	Tue,  9 Apr 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KzBc/gDM"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCA7E777;
	Tue,  9 Apr 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651234; cv=none; b=nmh5l8kUTJQ3d98tt6hOwENuLmyqtWEqurVLne2MiRPxYSpZFcM1EUouAXlM7fMmJOH5Cy0XUFDWecuHrrpt7su0F+7wg6ajXHIitRHs9ra8iYTPGABIrnialHXpbQJCiW32/koxC12Tbeof2OfQS4uVcwFkrvfAeP5tcOwJVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651234; c=relaxed/simple;
	bh=klWcumVJrcH/pn5YJZSUFgoUrcCqVXbHft97/Lk3DXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPpI8OM7GM7S2KoCkkl2ZBhfevDtwLXVqUKtCrv+8X8cstF2vjhAt1OgbSZj3LUcC9M4Feh0y2yYjqfrJ9jXwFe8xCXYsr+7TGpHYKRwz4jAr73qUlLPEsSCB+7EqJQGOkC6VweOgunGLGu1phBZH6sYLZHNC8wVw321oZ+gelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KzBc/gDM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DEB5FF803;
	Tue,  9 Apr 2024 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712651225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQ2TKG/z7CPeraioenp8VFZhbdSJzDNu3y7fKUkGkTQ=;
	b=KzBc/gDMBMKA8c1EK4vP64dbqSjwveLf0au24FxsRmG4eK+5VWUsQQRr1T+5aMWtLgEadX
	vP3wb3PlZLA4TntsUZ7V1M9R2dA6Xm6kvyONCW4AEWAruoZUnyAP1gU3Q0syMaEvah3Mup
	Q3LakYFKwgHnbTLLGcUIDmK0CIYKgHtoREEKM5T3ykPV0fns/1gbumZu6reh7ZQE5mFltH
	OmIqhGx54xI4+l9iIODsBmaAqOLLqEMO5kYmwYOM0V36h1uc7UszbUK8GQsIq5lJE2Ul/S
	KLmQsmcTDBLWy6sxRgfIyu75jAujB5MP+Uxcwt+w6XfCdKnNQUqtT7aAyPRTGQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 10:26:24 +0200
Subject: [PATCH net-next v10 02/13] net: Move dev_set_hwtstamp_phylib to
 net/core/dev.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_ptp_netnext-v10-2-0fa2ea5c89a9@bootlin.com>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
In-Reply-To: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

This declaration was added to the header to be called from ethtool.
ethtool is separated from core for code organization but it is not really
a separate entity, it controls very core things.
As ethtool is an internal stuff it is not wise to have it in netdevice.h.
Move the declaration to net/core/dev.h instead.

Remove the EXPORT_SYMBOL_GPL call as ethtool can not be built as a module.

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
index d45f330d083d..9a4b92b49fac 100644
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



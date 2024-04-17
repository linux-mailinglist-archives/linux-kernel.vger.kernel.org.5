Return-Path: <linux-kernel+bounces-148242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884F8A7FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353B22836AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4F13C3E8;
	Wed, 17 Apr 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oOeyh6gm"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96A133435;
	Wed, 17 Apr 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346465; cv=none; b=e2vx3GI4mGRR2sQISfrHpmAoW1waWxrBShh9pc+im6Es0XB0VB1oL8dMkf+oy9jSkUKdwLBk0K22oAJzsOLkM/ne4cxrEtnGDV+F3yC3jOyJDPAxD4ywABXv4U/IcLKans2UmrHzgldF6/QIoQpaMvP4aNR3EgDhOEBlhKMflhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346465; c=relaxed/simple;
	bh=TkDdyyxMxMzG8CP5s82byzQpJzc0TZdDk6Z4aLsoXno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2ywWYk+JL5OJ3iPuU/oaHisbA4HqFmLmuij6z44fcr5q0JVHGCQuV3cLA29I6AhTDrNwVokQkLYsK/jNborNEjQGkVbu2z5cgzLpNBZ+E4odmWdFK9L9IzuA0XfV4zs9kVku1zvZ62oRBQsNlvwnytmuHcTFlglrQ+ZtlzTQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oOeyh6gm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 677CBFF80E;
	Wed, 17 Apr 2024 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSQulcNZ7xVN29GXFAi9C0JHJLd/h7peOYiZQ1EcFoc=;
	b=oOeyh6gm8PC4Mdw5pg5UzxK/HB8J3Wqdr3vDKyNY3hkZgK2fEAfydVCAyils33EF6c7Mef
	eTjHvzdFqK8YbdYIDvbNFvGmoP5Q0JN+3KgsYn9kOCqEaHnKMTml7//t+Y/UpqG8m53Mim
	RmH+xRVHCMq+ioXu9eFuR9kH7oSLS7qQdReNpjUUYuAS+lg/qGU2sgDKv+x7v7Vc66vdrq
	QbpudOOzRZhBCZBhkuHACb8zOTBdl71NjGCot1UzVWlhwgJBiH/BFnEh1k7jbv0cRgZ9wn
	LhpPb47KxUpoq9+2PkRTZUCFOg+siR6846ux1kT5ryR9L2NqPC5vriYtYf5vmg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 17 Apr 2024 11:34:10 +0200
Subject: [PATCH 3/6] wifi: wilc1000: set wilc_set_mac_address parameter as
 const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-mac_addr_at_probe-v1-3-67d6c9b3bc2b@bootlin.com>
References: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
In-Reply-To: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Any attempt to provide a const mac address to wilc_set_mac_address results
in the following warning:

warning: passing argument 2 of 'wilc_set_mac_address' discards 'const'
qualifier from pointer target type [-Wdiscarded-qualifiers]
[...]
drivers/net/wireless/microchip/wilc1000/hif.h:170:52: note: expected 'u8 *'
{aka 'unsigned char *'} but argument is of type 'const unsigned char *'a
int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr);

Instead of using an explicit cast each time we need provide a MAC address,
set the function parameter as const

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c    | 4 ++--
 drivers/net/wireless/microchip/wilc1000/hif.h    | 2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 919de6ffb821..c6892b7e190f 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1293,7 +1293,7 @@ int wilc_get_mac_address(struct wilc_vif *vif, u8 *mac_addr)
 	return result;
 }
 
-int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr)
+int wilc_set_mac_address(struct wilc_vif *vif, const u8 *mac_addr)
 {
 	struct wid wid;
 	int result;
@@ -1301,7 +1301,7 @@ int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr)
 	wid.id = WID_MAC_ADDR;
 	wid.type = WID_STR;
 	wid.size = ETH_ALEN;
-	wid.val = mac_addr;
+	wid.val = (u8 *)mac_addr;
 
 	result = wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
 	if (result)
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wireless/microchip/wilc1000/hif.h
index 0d380586b1d9..96eeaf31d237 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -167,7 +167,7 @@ int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len,
 		    u8 cipher_mode);
 int wilc_set_pmkid_info(struct wilc_vif *vif, struct wilc_pmkid_attr *pmkid);
 int wilc_get_mac_address(struct wilc_vif *vif, u8 *mac_addr);
-int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr);
+int wilc_set_mac_address(struct wilc_vif *vif, const u8 *mac_addr);
 int wilc_set_join_req(struct wilc_vif *vif, u8 *bssid, const u8 *ies,
 		      size_t ies_len);
 int wilc_disconnect(struct wilc_vif *vif);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index acc9b9a64552..5ab448d0b643 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -678,7 +678,7 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 	}
 	rcu_read_unlock();
 
-	result = wilc_set_mac_address(vif, (u8 *)addr->sa_data);
+	result = wilc_set_mac_address(vif, addr->sa_data);
 	if (result)
 		return result;
 

-- 
2.44.0



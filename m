Return-Path: <linux-kernel+bounces-67207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AB856804
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A69B283E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAB134CD3;
	Thu, 15 Feb 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RQdOi/+x"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3F133432;
	Thu, 15 Feb 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011409; cv=none; b=JWYzKZNhntrfo7OMFp1gmmvsqZ5oxj3dtWO4iZB/4yuqkckN0eB9qar1+ms2ePRO3+MP6WBt/MOgFpjZoGbrG0dPsAM0ueMYTZXIrUu60RO7qwNrANBKpOIa1TaBifcN5iU6+Az4CjoIZIv/d9rMOLp7uspp65vNaULvHl0Wfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011409; c=relaxed/simple;
	bh=FjdprrnC/XsA9GWxGqo/QmO/W07N1XedtxUX8gEVkh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AR/QDfnFBCWP2lSh4W9fpftZLL/jqsi2d4SqnE1a01EcoGDggQ4JBTuPaUQKTRTLgonkGpzwLpNIjeQbkI5XzPkzBeYCiBrm+BlHLRjW7UZVftJB7CDdgfwHNENIPVWw3D/+uVvUtJTjjKbFIEWxDgQwvgnc3Cosa8dZIHDaig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RQdOi/+x; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B757FC876C;
	Thu, 15 Feb 2024 15:36:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B78B4FF807;
	Thu, 15 Feb 2024 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708011392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVIMZPbdYf3ZH4bucFJyX+oUYzajS9yHWDPkyGO2CoA=;
	b=RQdOi/+xBIS2kluyOnNaH9ORWUF5pi0TEliRBZFwz7PAVW7PSOlvE/kYx3RaC6N9rOIMX+
	0oit69wYMUXzjmfjvETTh+iadx6jC0tfiJgVW7WoIzzLz+YjyECs6/sWqMDERhuF4mkFsa
	9Pu/ZASDXLgAI94bnHzeFtmXcm/1S6KMguQNkjdeF/ixSjR1uvUASU41olKyDVuECPDOhz
	Fo3mzAlxxushnul31gJEKdW1ZdnxOuXnQw641Np/zGjXV6BNv8o8JEL5JCi8e0tVCUKCpL
	xxsYIZGWEtbzLGHYt1D+e8D+UhSIZHGcjrVVlgczoIZ2asqkazmQnR2a2lyIxw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 15 Feb 2024 16:36:20 +0100
Subject: [PATCH 3/4] wifi: wilc1000: fix declarations ordering
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-wilc_fix_rcu_usage-v1-3-f610e46c6f82@bootlin.com>
References: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
In-Reply-To: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

Fix reverse-christmas tree order in some functions before adding more
variables

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c    | 16 ++++++++--------
 drivers/net/wireless/microchip/wilc1000/netdev.c |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index f3800aa9e9f8..c42859a727c3 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1567,11 +1567,11 @@ int wilc_deinit(struct wilc_vif *vif)
 
 void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 {
-	int result;
-	struct host_if_msg *msg;
-	int id;
 	struct host_if_drv *hif_drv;
+	struct host_if_msg *msg;
 	struct wilc_vif *vif;
+	int result;
+	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
 	vif = wilc_get_vif_from_idx(wilc, id);
@@ -1608,11 +1608,11 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 {
-	int result;
-	struct host_if_msg *msg;
-	int id;
 	struct host_if_drv *hif_drv;
+	struct host_if_msg *msg;
 	struct wilc_vif *vif;
+	int result;
+	int id;
 
 	mutex_lock(&wilc->deinit_lock);
 
@@ -1654,10 +1654,10 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 
 void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 {
-	int result;
-	int id;
 	struct host_if_drv *hif_drv;
 	struct wilc_vif *vif;
+	int result;
+	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
 	vif = wilc_get_vif_from_idx(wilc, id);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 96f239adc078..092801d33915 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -814,12 +814,12 @@ static int wilc_mac_close(struct net_device *ndev)
 void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 		       u32 pkt_offset)
 {
-	unsigned int frame_len = 0;
-	int stats;
 	unsigned char *buff_to_send = NULL;
-	struct sk_buff *skb;
 	struct net_device *wilc_netdev;
+	unsigned int frame_len = 0;
 	struct wilc_vif *vif;
+	struct sk_buff *skb;
+	int stats;
 
 	if (!wilc)
 		return;

-- 
2.43.0



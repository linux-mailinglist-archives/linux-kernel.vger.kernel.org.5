Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4E1751662
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjGMCiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjGMCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:37:58 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B200211F;
        Wed, 12 Jul 2023 19:37:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1ebb79579so220176b6e.3;
        Wed, 12 Jul 2023 19:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215864; x=1691807864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vduQ3kkF6+9LmbpyzrWUTpYlu5cuK+oeQp8QiLQyx9c=;
        b=NNs1KVqjl2RZ7Rh0yiNv62nzhr/EH0ThqGellMU9EUvBSasusY+TdzYq2rqxkI5L9Z
         pfc5oHrSbMDGugxXVCFTGGbyK1JFIQADvs2hl5I5OwFffHTCY8eVm+jYGomjjnfP0EZP
         SPVGY1Jz1lnrsprPEZTJZzByj96xA6fFP//LCq5IoKv3fXhE7QdDSyeKc9p6Y77f6O8n
         Xeea9DtU+JKh6zlu72wSqn+ZNtnXnouhhZKAotLPY3pDvEQ4eCLj7m9AJ163PTuL/z0u
         aOfFCDiO1P6Dm7wUf8nJZQNND56ScZlxY0TnPHNLzG8t1vCsscqZP9VP+l+4aApCR2Mu
         DTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215864; x=1691807864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vduQ3kkF6+9LmbpyzrWUTpYlu5cuK+oeQp8QiLQyx9c=;
        b=E2ULzJ/MkYwBRC6S/mUxdbprBVyW0zJxdxDOx0D+05ivjc3v2O+TcW3JSk9/GFrVyN
         SKdXfdY1JRGUlCxZLBuoQoUq74tPuHnYGzSQadWfOQbgCaJF+ZoJEdi/6sppYtTDQXSz
         S1ALWfzyKERROAZaTsqfhLOEzsi8QXZ1Wb+t9rLO8X8qLXRCWesQ2qc+kVO18Iiz4D4J
         UJAtrqJ25WTBfG5PpMRC0o7lql9SDD4f5KyyD9Jfnp2OKYo08n5JtNIadWivcI3wd+IA
         MiGg9EajC2dguJy6E35TlRCr37iplq02U7EpbsstLoszQLZ9PTJUDdKxHvnyw48OXhUD
         i3NQ==
X-Gm-Message-State: ABy/qLa6AtaBrT31ETzZs4V9icit4mX+0gENADqFD4tF3xATWfCxfk7Q
        2KxlWdk8ZL3ZNgnBGaWo1F1jK9Wb4lNFjtnQ
X-Google-Smtp-Source: APBJJlFx8O9/XOGVBIPOcHRYVQ/yBszXHyLoyCBGcG8ZkvainhaeT7unU2YD37GoBnd7F3N9vgAWjQ==
X-Received: by 2002:a05:6808:1490:b0:3a3:7adc:dec7 with SMTP id e16-20020a056808149000b003a37adcdec7mr419369oiw.38.1689215864298;
        Wed, 12 Jul 2023 19:37:44 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id 6-20020aa79106000000b00662c4ca18ebsm4228783pfh.128.2023.07.12.19.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:37:43 -0700 (PDT)
From:   pinkperfect <pinkperfect2021@gmail.com>
To:     kuba@kernel.org, amitkarwar@gmail.com, kvalo@kernel.org,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pinkperfect <pinkperfect2021@gmail.com>
Subject: [PATCH v3] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Thu, 13 Jul 2023 02:37:31 +0000
Message-Id: <20230713023731.2518507-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure mwifiex_process_mgmt_packet and its callers
mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet
not out-of-bounds access the skb->data buffer.

Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80211")

Signed-off-by: pinkperfect <pinkperfect2021@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c   |  3 ++-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 10 +++-------
 drivers/net/wireless/marvell/mwifiex/util.c     |  5 +++++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 13659b02ba88..88aaec645291 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -194,7 +194,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_private *priv,
 
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
 
-	if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
+	if ((rx_pkt_offset + rx_pkt_length) > (u16)skb->len ||
+	    skb->len - rx_pkt_offset < sizeof(*rx_pkt_hdr)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
 			    skb->len, rx_pkt_offset, rx_pkt_length);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index e495f7eaea03..f84ed22518c6 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -367,20 +367,15 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
 	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
 
-	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
-
 	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
-	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16) skb->len) {
+	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16)skb->len ||
+	     skb->len - le16_to_cpu(uap_rx_pd->rx_pkt_offset) < sizeof(*rx_pkt_hdr)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, offset=%d, length=%d\n",
 			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset),
 			    le16_to_cpu(uap_rx_pd->rx_pkt_length));
 		priv->stats.rx_dropped++;
 
-		node = mwifiex_get_sta_entry(priv, ta);
-		if (node)
-			node->stats.tx_failed++;
-
 		dev_kfree_skb_any(skb);
 		return 0;
 	}
@@ -393,6 +388,7 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 		return ret;
 	}
 
+	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
 
 	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
 		spin_lock_bh(&priv->sta_list_spinlock);
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 94c2d219835d..31e1a82883e4 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 
 	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
 
+	if (pkt_len < sizeof(struct ieee80211_hdr) || skb->len < pkt_len) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
+		return -1;
+	}
+
 	ieee_hdr = (void *)skb->data;
 	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
 		if (mwifiex_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
-- 
2.25.1


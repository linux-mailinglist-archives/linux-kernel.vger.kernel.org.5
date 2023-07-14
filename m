Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E16754521
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGNWsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGNWsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:48:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B282113;
        Fri, 14 Jul 2023 15:48:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b895a06484so15313405ad.1;
        Fri, 14 Jul 2023 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689374901; x=1691966901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KPDXw6d9QZoIdRyusRX5j718BfWZgOZEixbpaIJv+E=;
        b=CT3GBfawVE1QNsKfAqGgoFAV5+9AozosB89w0/RPQcLvMiyt1nscbONtsTPyOqTf8y
         ObnOutT/we3CUiebSmY+6b+DKsyyI8rVQXYmawwYIVPrfz4jxO2th8IKyJ3Lz+MiEyf+
         W+BomqV7BoZoMV3fZseTlKXjvJYJ9LqCPzqnk4JXFjxQdsOTDuVmyCRSlBeiFJ6grlld
         jpxDeannYcDPCS09Wext4Hay9562AUSrc08lGVKEjd15TA+wt0frX3h6/+hewRB7iyKm
         GAplpYWmB4RBUb1PW8gepE79Yp5hDzdoAy+2KoGFGfvIZnKHzuI5NdRtd57XQkftM1g+
         kp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374901; x=1691966901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KPDXw6d9QZoIdRyusRX5j718BfWZgOZEixbpaIJv+E=;
        b=dSAei/v4n1tX/GUD5dZj3jOr509eM1sZC73TdXCzFeljXW4jv7mJgJXfhrXv9iWNrv
         nclhbxSNxNKbKKab2XRdNmoVAFPLhhI450NX24KvFB2B8jXRmOEJauDGlcmkR0zhR2Lh
         xG3TBQEAtKAa9CoRRRIvhwCH9QpwWLZY1JH70d5UImSYnhAkBW42XZRX4s703YOH7/YW
         be7YjL3zvUoPpueB2J9jCJ3cd+SzkcKRKfCWIbtOouaKg9t+Yk2DkWEyhbiF96hiPU+f
         hv2XfDHSue2XFTtAgE0W6t6Tx5G9FgSPgoJgSvA+VZbCkGNL9OnVMIec12YXygXMVKuf
         tBkA==
X-Gm-Message-State: ABy/qLYoeDgykoZuq9gm5Dxmz+YqAlwvJfPQDy7EFqb4Gl9Cc4fATt42
        p9VEE7uNzAU02lz60kYZgAQCXjocohXIc+ViCiU=
X-Google-Smtp-Source: APBJJlHYQrcEFpBZFB5cptzfdbqr9WU1KqJqnCs5O9HDa+wA+G7yJUhsSDWj8HCnaHgx8UaubdXMxw==
X-Received: by 2002:a17:903:2343:b0:1b8:77b3:6bf6 with SMTP id c3-20020a170903234300b001b877b36bf6mr5726230plh.33.1689374900748;
        Fri, 14 Jul 2023 15:48:20 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id ja22-20020a170902efd600b001b8c6662094sm8260845plb.188.2023.07.14.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:48:20 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     kuba@kernel.org, matthewmwang@chromium.org, kuabhs@chromium.org,
        amitkarwar@gmail.com, kvalo@kernel.org, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Polaris Pi <pinkperfect2021@gmail.com>
Subject: [PATCH v6] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Fri, 14 Jul 2023 22:48:09 +0000
Message-Id: <20230714224809.3929539-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
---
V5: Follow chromeos comments: preserve the original flow of mwifiex_process_uap_rx_packet
V6: Simplify check in mwifiex_process_uap_rx_packet
---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c   |  3 ++-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 10 ++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c     |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index e495f7eaea03..f0711b73ba3e 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -367,6 +367,16 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
 	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
 
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) + sizeof(*rx_pkt_hdr) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet offset: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
 	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
 
 	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
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


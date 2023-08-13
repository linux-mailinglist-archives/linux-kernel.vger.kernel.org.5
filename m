Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57C277A45F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 02:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHMAwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 20:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:52:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C710FD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:52:02 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40fd6da0325so20187321cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691887921; x=1692492721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7feWcNuqlvaMjAjbTkKsTbz2ttRhhnPSLZsSIUE8mho=;
        b=V5+CEj7GT+FOTcw/fdoIEvaydRZ+vhgjsiRLhg3tbEDSPQr+3zFl12CmbHQ64WXKNT
         K8gdu37Jr12iDYbbh/bRjTBS7J/5ipavA3U4DWqMxJvNme/kfuMBxf8OAz7sdrJ5xKQG
         tHAVLI3wUX4pJobDeFKUvpqmKdDpWy/7gbi3FVRmT5PZ0s8a3D9DfIiVSLTVGFzsdzHs
         HBSFA8HTP2CoB8YlATivw1UL35UrutndellOG7Yndb/iL5yEMbaI4kEsAiP8hy6DIvCs
         1cJmxrG0dh+j4b9sNdfvT1Uf6Q5X/EV6GLNGF9eAfBTKYEjYyrTQEfpRZ+SDEUx0XJVr
         WKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691887921; x=1692492721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7feWcNuqlvaMjAjbTkKsTbz2ttRhhnPSLZsSIUE8mho=;
        b=D6tXsN5jXt3lJw7ofrln7qBCVYlunwwJLHJaQ7x9Yb/BH8LrqVIotSWtJ4YsPhNnHH
         qmzQ+gYsV/QWH1yCrocnQy61LZhGJRmwOAwM4PNQy6D2XmWss2JpMQ/5MOYazWxcQa1+
         KdwKwPQ1hfyNqVyEzsLEF33F4k0keRFsZTmCmPNJsLjHEkNn+SDkIkIonvt7JAmGnetG
         cUJeH88Kb1e+fzJSD5QflN1MRzl8BfXviOUNrSTewkLQ+CcATIruQsWKb8R1cJdOFquZ
         tJwahWCX9GTFHULIBYrCtWtHdytI/ugwd6rb2UoA9m290rQmO/whJWjHNOT+8sxDEMZL
         36wg==
X-Gm-Message-State: AOJu0YxW4/LiWJmqOPg+g7PgJEqo5ty4eSmF3g7CRooAqlOPDxLJ6j0z
        l9/jS4nWEbomUiv+y6QJU4Y=
X-Google-Smtp-Source: AGHT+IEBSOhpavhH2aTfUovlvQ39ovMTQvLiSofwyGGuylN74uOv9dFUjFEfwix95honyJ+QInkt1g==
X-Received: by 2002:ac8:5ccb:0:b0:403:ab73:9d55 with SMTP id s11-20020ac85ccb000000b00403ab739d55mr8815753qta.6.1691887921489;
        Sat, 12 Aug 2023 17:52:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-236-155-147.hsd1.md.comcast.net. [73.236.155.147])
        by smtp.gmail.com with ESMTPSA id f19-20020ac84993000000b004053bcffe49sm2130360qtq.9.2023.08.12.17.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 17:52:01 -0700 (PDT)
From:   Cyrus Ramavarapu <cyrus.ramavarapu@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Cyrus Ramavarapu <cyrus.ramavarapu@gmail.com>
Subject: [PATCH] staging: octeon: Remove unnecessary parentheses
Date:   Sat, 12 Aug 2023 20:53:26 -0400
Message-ID: <20230813005326.98905-1-cyrus.ramavarapu@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses found by checkpatch.

Signed-off-by: Cyrus Ramavarapu <cyrus.ramavarapu@gmail.com>
---
 drivers/staging/octeon/ethernet-rgmii.c | 2 +-
 drivers/staging/octeon/ethernet-rx.c    | 5 ++---
 drivers/staging/octeon/ethernet-tx.c    | 8 ++++----
 drivers/staging/octeon/ethernet.c       | 6 +++---
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index 0c4fac31540a..15d2c84925ba 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -148,7 +148,7 @@ int cvm_oct_rgmii_open(struct net_device *dev)
 		 */
 		if ((priv->imode == CVMX_HELPER_INTERFACE_MODE_GMII &&
 		     priv->port  == 0) ||
-		    (priv->imode == CVMX_HELPER_INTERFACE_MODE_RGMII)) {
+		    priv->imode == CVMX_HELPER_INTERFACE_MODE_RGMII) {
 			priv->poll = cvm_oct_check_preamble_errors;
 			cvm_oct_check_preamble_errors(dev);
 		}
diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 965330eec80a..db359a1e0b08 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -69,7 +69,7 @@ static inline int cvm_oct_check_rcv_error(struct cvmx_wqe *work)
 	else
 		port = work->word1.cn38xx.ipprt;
 
-	if ((work->word2.snoip.err_code == 10) && (work->word1.len <= 64))
+	if (work->word2.snoip.err_code == 10 && work->word1.len <= 64)
 		/*
 		 * Ignore length errors on min size packets. Some
 		 * equipment incorrectly pads packets to 64+4FCS
@@ -324,8 +324,7 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 			}
 			packet_not_copied = 0;
 		}
-		if (likely((port < TOTAL_NUMBER_OF_PORTS) &&
-			   cvm_oct_device[port])) {
+		if (likely(port < TOTAL_NUMBER_OF_PORTS && cvm_oct_device[port])) {
 			struct net_device *dev = cvm_oct_device[port];
 
 			/*
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index bbf33b88bb7c..0954509ea42c 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -153,8 +153,8 @@ netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * completely remove "qos" in the event neither interface
 	 * supports multiple queues per port.
 	 */
-	if ((CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 > 1) ||
-	    (CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 > 1)) {
+	if (CVMX_PKO_QUEUES_PER_PORT_INTERFACE0 > 1 ||
+	    CVMX_PKO_QUEUES_PER_PORT_INTERFACE1 > 1) {
 		qos = GET_SKBUFF_QOS(skb);
 		if (qos <= 0)
 			qos = 0;
@@ -224,7 +224,7 @@ netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * no room to add the padding.  The kernel should always give
 	 * us at least a cache line
 	 */
-	if ((skb->len < 64) && OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+	if (skb->len < 64 && OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
 		union cvmx_gmxx_prtx_cfg gmx_prt_cfg;
 		int interface = INTERFACE(priv->port);
 		int index = INDEX(priv->port);
@@ -360,7 +360,7 @@ netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 dont_put_skbuff_in_hw:
 
 	/* Check if we can use the hardware checksumming */
-	if ((skb->protocol == htons(ETH_P_IP)) &&
+	if (skb->protocol == htons(ETH_P_IP) &&
 	    (ip_hdr(skb)->version == 4) &&
 	    (ip_hdr(skb)->ihl == 5) &&
 	    ((ip_hdr(skb)->frag_off == 0) ||
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..d025ce51e755 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -248,7 +248,7 @@ static int cvm_oct_common_change_mtu(struct net_device *dev, int new_mtu)
 
 	dev->mtu = new_mtu;
 
-	if ((interface < 2) &&
+	if (interface < 2 &&
 	    (cvmx_helper_interface_get_mode(interface) !=
 		CVMX_HELPER_INTERFACE_MODE_SPI)) {
 		int index = INDEX(priv->port);
@@ -294,7 +294,7 @@ static void cvm_oct_common_set_multicast_list(struct net_device *dev)
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	int interface = INTERFACE(priv->port);
 
-	if ((interface < 2) &&
+	if (interface < 2 &&
 	    (cvmx_helper_interface_get_mode(interface) !=
 		CVMX_HELPER_INTERFACE_MODE_SPI)) {
 		union cvmx_gmxx_rxx_adr_ctl control;
@@ -346,7 +346,7 @@ static int cvm_oct_set_mac_filter(struct net_device *dev)
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	int interface = INTERFACE(priv->port);
 
-	if ((interface < 2) &&
+	if (interface < 2 &&
 	    (cvmx_helper_interface_get_mode(interface) !=
 		CVMX_HELPER_INTERFACE_MODE_SPI)) {
 		int i;
-- 
2.41.0


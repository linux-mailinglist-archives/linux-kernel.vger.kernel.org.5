Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1647FFAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376310AbjK3TOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376312AbjK3TOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:14:01 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF210F1;
        Thu, 30 Nov 2023 11:14:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75D1420002;
        Thu, 30 Nov 2023 19:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701371645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PV0l1NIZNMh69B6nDjZj0YkTHvJCTXzHrPnQeeMYxTI=;
        b=nKtL2f+I4jSys+yl/ptWrpQaSC+/CEoTXI9xtpH71qWWquuuubZUw96Jd1uyW6Wi0qk45m
        1aM6E5lPLv8ThCwZKABHjDT+c7ltdl+2HWs6o2BgSSZl4wjxVWsI6wGVZDZ5wTh3m8JYLY
        o3gyJlcI2sTwXi9JwbX1hdOXQPO45kW87kg2Kxx75FHpSU+kzpc3vppivUhK3WGWHdr7m4
        LkH2Dlm/whTu9l5hFTUjj6c//NJo7PNLBh6WiwS7M0ckt8L+tNPDmQW/CC/wf5onYBZyh7
        YlqfVBezVsLZ+SQM7eE14ZlxX+1Wpkskzconk2xBzLbGKDoI/m4XY4G1wjEjoA==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-doc@vger.kernel.org
Subject: [PATCH net-next] Documentation: networking: add missing PLCA messages from the message list
Date:   Thu, 30 Nov 2023 20:13:59 +0100
Message-ID: <20231130191400.817948-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Physical Layer Collision Avoidance messages are correctly documented but
were left-out of the global list of ethnl messages, add them to the
list.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/ethtool-netlink.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2540c70952ff..6a49624a9cbf 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -223,6 +223,9 @@ Userspace to kernel:
   ``ETHTOOL_MSG_PSE_SET``               set PSE parameters
   ``ETHTOOL_MSG_PSE_GET``               get PSE parameters
   ``ETHTOOL_MSG_RSS_GET``               get RSS settings
+  ``ETHTOOL_MSG_PLCA_GET_CFG``          get PLCA RS parameters
+  ``ETHTOOL_MSG_PLCA_SET_CFG``          set PLCA RS parameters
+  ``ETHTOOL_MSG_PLCA_GET_STATUS``       get PLCA RS status
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
   ===================================== =================================
@@ -267,6 +270,9 @@ Kernel to userspace:
   ``ETHTOOL_MSG_MODULE_GET_REPLY``         transceiver module parameters
   ``ETHTOOL_MSG_PSE_GET_REPLY``            PSE parameters
   ``ETHTOOL_MSG_RSS_GET_REPLY``            RSS settings
+  ``ETHTOOL_MSG_PLCA_GET_CFG_REPLY``       PLCA RS parameters
+  ``ETHTOOL_MSG_PLCA_GET_STATUS_REPLY``    PLCA RS status
+  ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
   ======================================== =================================
 
-- 
2.42.0


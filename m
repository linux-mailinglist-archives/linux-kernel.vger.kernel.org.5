Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5677963D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjHKRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHKRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:37:13 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 10:37:11 PDT
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA70A8;
        Fri, 11 Aug 2023 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=676; s=dkim-tub; t=1691775431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w4aamHWJldp6h5Ct58c7qthgK+NVnM3KT47swLL3BsI=;
  b=XNy1ygimnvgONomBYutkwe2yzruPCxXCvnvZX2AAhY6Qr7Bn3fFov2y7
   HmbkMPeCk/E3I4z+P+h7rc4r4StVHFpLrCumopt40eiHwWFH/FG3TVS96
   RQ0vf8GmHeA2OR4iNeWukqPnTGP+ONGK3KbvykAnV1g+nBcCGAosc3s/U
   M=;
X-IronPort-AV: E=Sophos;i="6.01,166,1684792800"; 
   d="scan'208";a="3190198"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 11 Aug 2023 19:36:06 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: Remove leftover include from nftables.h
Date:   Fri, 11 Aug 2023 19:33:57 +0200
Message-ID: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit db3685b4046f ("net: remove obsolete members from struct net")
removed the uses of struct list_head from this header, without removing
the corresponding included header.

Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 include/net/netns/nftables.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index 8c77832d0240..cc8060c017d5 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -2,8 +2,6 @@
 #ifndef _NETNS_NFTABLES_H_
 #define _NETNS_NFTABLES_H_
 
-#include <linux/list.h>
-
 struct netns_nftables {
 	u8			gencursor;
 };
-- 
2.39.2


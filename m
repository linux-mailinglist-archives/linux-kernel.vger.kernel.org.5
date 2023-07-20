Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C11675B213
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjGTPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGTPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:11:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7352BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:11:16 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qMVJC-00059N-44
        for linux-kernel@vger.kernel.org; Thu, 20 Jul 2023 17:11:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7AB811F6521
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:11:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5A8D11F651C;
        Thu, 20 Jul 2023 15:11:12 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 58815a76;
        Thu, 20 Jul 2023 15:11:11 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next] MAINTAINERS: net: fix sort order
Date:   Thu, 20 Jul 2023 17:11:07 +0200
Message-Id: <20230720151107.679668-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus seems to like the MAINTAINERS file sorted, see
c192ac735768 ("MAINTAINERS 2: Electric Boogaloo").

Since this is currently not the case, restore the sort order.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Justin Chen <justin.chen@broadcom.com>
Fixes: 3abf3d15ffff ("MAINTAINERS: ASP 2.0 Ethernet driver maintainers")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b123afcfc9e..66a06ac9729e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3838,6 +3838,15 @@ S:	Maintained
 F:	kernel/bpf/stackmap.c
 F:	kernel/trace/bpf_trace.c
 
+BROADCOM ASP 2.0 ETHERNET DRIVER
+M:	Justin Chen <justin.chen@broadcom.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
+F:	drivers/net/ethernet/broadcom/asp2/
+
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
 L:	netdev@vger.kernel.org
@@ -4148,15 +4157,6 @@ F:	drivers/net/mdio/mdio-bcm-unimac.c
 F:	include/linux/platform_data/bcmgenet.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 
-BROADCOM ASP 2.0 ETHERNET DRIVER
-M:	Justin Chen <justin.chen@broadcom.com>
-M:	Florian Fainelli <florian.fainelli@broadcom.com>
-L:	bcm-kernel-feedback-list@broadcom.com
-L:	netdev@vger.kernel.org
-S:	Supported
-F:	Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
-F:	drivers/net/ethernet/broadcom/asp2/
-
 BROADCOM IPROC ARM ARCHITECTURE
 M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
-- 
2.40.1



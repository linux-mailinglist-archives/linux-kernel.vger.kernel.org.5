Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7381176A8E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjHAGXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHAGWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20E1BF1;
        Mon, 31 Jul 2023 23:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354626147D;
        Tue,  1 Aug 2023 06:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D5CC433C9;
        Tue,  1 Aug 2023 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690870966;
        bh=b2RgmgrZgvx8gY0C2fKs3oh+azWjdXtoP4cL2Idz4YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7RwOb7oUztbzNAhEda9ikSF6FSSik48MGrDJVno2hY8EGt94fNSgeklPels0sqy/
         ekGIXqs1rIX+lqgmqiCbMJ4RRQqhD0I5PFZ5U61ItHDTgxTDSnrbo/i5NWHKr672TQ
         u16Gr0Sz9UP84+M11kkSOn6ZOabbRqBP5eWlBuNewTTrVrc2Kznm1/ABduiVtBx1+U
         QGPlRY38tDc7yiDbuYiJUFTXVT3J+jbcRG+qRv/iqzg83wIYgsmwXaIvf5Sm9BLS7I
         QMWbmKg77O4YVa+uWl2K918TxGce9WZNxM7BlhuiKbP8sOnQwTGTZqeVh/WozHA3hI
         cFS4s7uOkcCyQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/2] can: can327: remove casts from tty->disc_data
Date:   Tue,  1 Aug 2023 08:22:36 +0200
Message-ID: <20230801062237.2687-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801062237.2687-1-jirislaby@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty->disc_data is 'void *', so there is no need to cast from that.
Therefore remove the casts and assign the pointer directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Max Staudt <max@enpas.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/can/can327.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index dc7192ecb001..ee8a977acc8d 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -888,7 +888,7 @@ static bool can327_is_valid_rx_char(u8 c)
 static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 			    const char *fp, int count)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 	size_t first_new_char_idx;
 
 	if (elm->uart_side_failure)
@@ -990,7 +990,7 @@ static void can327_ldisc_tx_worker(struct work_struct *work)
 /* Called by the driver when there's room for more data. */
 static void can327_ldisc_tx_wakeup(struct tty_struct *tty)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 
 	schedule_work(&elm->tx_work);
 }
@@ -1067,7 +1067,7 @@ static int can327_ldisc_open(struct tty_struct *tty)
  */
 static void can327_ldisc_close(struct tty_struct *tty)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 
 	/* unregister_netdev() calls .ndo_stop() so we don't have to. */
 	unregister_candev(elm->dev);
@@ -1092,7 +1092,7 @@ static void can327_ldisc_close(struct tty_struct *tty)
 static int can327_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
 			      unsigned long arg)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 	unsigned int tmp;
 
 	switch (cmd) {
-- 
2.41.0


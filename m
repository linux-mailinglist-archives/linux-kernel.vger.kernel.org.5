Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF90768F94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGaIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGaIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E213426A3;
        Mon, 31 Jul 2023 01:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B31260F5E;
        Mon, 31 Jul 2023 08:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEAAC43395;
        Mon, 31 Jul 2023 08:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790577;
        bh=t10N72oEfrdWvctrgvxTa70mihQMypTsXP5is3fxQas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFMtHrIhFzDSxjMCDs1WdZHEIKSx1+VX1YOY/dFgDZvmbzMGfH3RP0d+HhZhoU19t
         hZlT/E0OjVoFFCdn2M8gZRsVrZNFE2xg83Ly7od1GPm5C1479rkTdgj2CLZwfW4StB
         Twg4NRjSSaCFE4FsvZnKpqxXBAEeeD+q1lGqu2NjPqo2pBNKFOQ5tJgchlY82DRpY/
         y7G0cT1PMK0AtF+xJ/BnB89INOyuzs3Ym2JPcAl0VlkWU7chVbYhaAI4cIrdI563VT
         p2H/YQNsB5sSXBMzPudyFIfUmPr6nK0XXZhNJbJcf8VxCiGpnxOSlqz7nQVXFZT6aP
         dJpIUIMMVM3Cw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 05/10] can: slcan: remove casts from tty->disc_data
Date:   Mon, 31 Jul 2023 10:02:39 +0200
Message-ID: <20230731080244.2698-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
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
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/can/slcan/slcan-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index f4db77007c13..371af9d17b14 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -583,7 +583,7 @@ static void slcan_transmit(struct work_struct *work)
  */
 static void slcan_write_wakeup(struct tty_struct *tty)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 
 	schedule_work(&sl->tx_work);
 }
@@ -778,7 +778,7 @@ static void slcan_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, const char *fp,
 			      int count)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 
 	if (!netif_running(sl->dev))
 		return;
@@ -862,7 +862,7 @@ static int slcan_open(struct tty_struct *tty)
  */
 static void slcan_close(struct tty_struct *tty)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 
 	unregister_candev(sl->dev);
 
@@ -886,7 +886,7 @@ static void slcan_close(struct tty_struct *tty)
 static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
 		       unsigned long arg)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 	unsigned int tmp;
 
 	switch (cmd) {
-- 
2.41.0


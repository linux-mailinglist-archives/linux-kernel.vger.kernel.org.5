Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5C7DC1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjJ3VW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjJ3VW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:22:57 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992D511B;
        Mon, 30 Oct 2023 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=OZB13UmFkPitLseb0iuRjPOZ75p/5s1IyVR8C319A1g=; b=jaXEIT90jztxDfvjed9tBlay0d
        9b2c7qp9BihSRd5X/6+CnGnPEr/O8BQJnn+JsOqo0zBX1/Oll76bvPih2lYi3EuiNNTwplwFlIAJj
        xfYls16fXv/oaEqe4RB+a63okFNYp+VlmhfEWjjhmAYcgiwOJAp3RGynbMWOJfgkZHhk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51974 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qxZib-0005os-Uc; Mon, 30 Oct 2023 17:22:42 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Mon, 30 Oct 2023 17:22:40 -0400
Message-Id: <20231030212240.975885-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] serial: sunsab: remove trailing whitespaces
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix coding style. No functional changes.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sunsab.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 6aa51a6f8063..1ef2057a7366 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -443,7 +443,7 @@ static void sunsab_start_tx(struct uart_port *port)
 
 	up->interrupt_mask1 &= ~(SAB82532_IMR1_ALLS|SAB82532_IMR1_XPR);
 	writeb(up->interrupt_mask1, &up->regs->w.imr1);
-	
+
 	if (!test_bit(SAB82532_XPR, &up->irqflags))
 		return;
 
@@ -549,7 +549,7 @@ static int sunsab_startup(struct uart_port *port)
 	(void) readb(&up->regs->r.isr1);
 
 	/*
-	 * Now, initialize the UART 
+	 * Now, initialize the UART
 	 */
 	writeb(0, &up->regs->w.ccr0);				/* power-down */
 	writeb(SAB82532_CCR0_MCE | SAB82532_CCR0_SC_NRZ |
@@ -563,7 +563,7 @@ static int sunsab_startup(struct uart_port *port)
 			   SAB82532_MODE_RAC);
 	writeb(up->cached_mode, &up->regs->w.mode);
 	writeb(SAB82532_RFC_DPS|SAB82532_RFC_RFTH_32, &up->regs->w.rfc);
-	
+
 	tmp = readb(&up->regs->rw.ccr0);
 	tmp |= SAB82532_CCR0_PU;	/* power-up */
 	writeb(tmp, &up->regs->rw.ccr0);
@@ -607,7 +607,7 @@ static void sunsab_shutdown(struct uart_port *port)
 	up->cached_dafo &= ~SAB82532_DAFO_XBRK;
 	writeb(up->cached_dafo, &up->regs->rw.dafo);
 
-	/* Disable Receiver */	
+	/* Disable Receiver */
 	up->cached_mode &= ~SAB82532_MODE_RAC;
 	writeb(up->cached_mode, &up->regs->rw.mode);
 
@@ -622,7 +622,7 @@ static void sunsab_shutdown(struct uart_port *port)
 	 * speed the chip was configured for when the port was open).
 	 */
 #if 0
-	/* Power Down */	
+	/* Power Down */
 	tmp = readb(&up->regs->rw.ccr0);
 	tmp &= ~SAB82532_CCR0_PU;
 	writeb(tmp, &up->regs->rw.ccr0);
@@ -649,7 +649,7 @@ static void calc_ebrg(int baud, int *n_ret, int *m_ret)
 		*m_ret = 0;
 		return;
 	}
-     
+
 	/*
 	 * We scale numbers by 10 so that we get better accuracy
 	 * without having to use floating point.  Here we increment m
@@ -788,7 +788,7 @@ static const char *sunsab_type(struct uart_port *port)
 {
 	struct uart_sunsab_port *up = (void *)port;
 	static char buf[36];
-	
+
 	sprintf(buf, "SAB82532 %s", sab82532_version[up->type]);
 	return buf;
 }
@@ -933,7 +933,7 @@ static int sunsab_console_setup(struct console *con, char *options)
 	sunsab_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
 
 	uart_port_unlock_irqrestore(&up->port, flags);
-	
+
 	return 0;
 }
 

base-commit: 64ebf8797249e792af2143eb9e4bd404d10a022e
-- 
2.39.2


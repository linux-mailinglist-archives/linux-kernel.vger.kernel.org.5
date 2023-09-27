Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C487AF9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjI0FMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjI0FLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:11:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35237A81;
        Tue, 26 Sep 2023 21:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o2C3IMNn5E8olqASjx2/ZYFEnSXvq023rbPKyXfiuOE=; b=KaXxIKBMPN4ABhM72wnGNNhU52
        hI70FbrVB2UTn/yOyXmB2Ots396y8XUoYtwzsJe0vCEXLhxQSjFgoJyBZp9SNt5/puDpOqx7Nrf51
        x6aiBs9CcLp4vCXb/7XgrIDBbb1H+RwFaNTPuR7MyGylNEKb+TbBb2f/RsV5RpHrTe2omMIB7Reeu
        f8F4XOQdFU2Ts//kdC3YA9gtigbnfrGC70thb0uG43eofwMkJXCJ3t0XMF509BS+3Luo8xEdYobLb
        z6Lvfc+Gb7zafT4EqmYailKBzbDX8CMj14Vtnp7q5TKLwuSWGxE266ZZl7Zte0eBt4e3l6y0NgjSm
        esiSnEwg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlMMa-00HXig-2t;
        Wed, 27 Sep 2023 04:41:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH -next] serial: core: fix kernel-doc for uart_port_unlock_irqrestore()
Date:   Tue, 26 Sep 2023 21:41:28 -0700
Message-ID: <20230927044128.4748-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the function name to avoid a kernel-doc warning:

include/linux/serial_core.h:666: warning: expecting prototype for uart_port_lock_irqrestore(). Prototype was for uart_port_unlock_irqrestore() instead

Fixes: b0af4bcb4946 ("serial: core: Provide port lock wrappers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
---
 include/linux/serial_core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -658,7 +658,7 @@ static inline void uart_port_unlock_irq(
 }
 
 /**
- * uart_port_lock_irqrestore - Unlock the UART port, restore interrupts
+ * uart_port_unlock_irqrestore - Unlock the UART port, restore interrupts
  * @up:		Pointer to UART port structure
  * @flags:	The saved interrupt flags for restore
  */

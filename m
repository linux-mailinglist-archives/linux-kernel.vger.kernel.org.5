Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECBF75EB89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGXGdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGXGdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:33:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439ED2;
        Sun, 23 Jul 2023 23:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xi02gFW93Id0bT7Sh+4wBXdpqlJzFPayUdH3m+EHzPM=; b=BSdcx4WoALDgeHupsuSnOLc1rn
        gERe7ONSyqR4QdO2pdzHlgtJabW3mHKBgo9gz+fGGpRUX+vnDhZJ5AOedAXhwikUVAL0+SmhjwbxN
        /N0VWSoe1u1O8qFlW0Q/15iF3i1+4nL3KQEXy6vAxvUZONFG/WTS+I9t67a82XbLG7OfvoNZTxlTI
        kjMZrhFr7XVvcCGYfNtO/vTmnvsfUi39W5AF55O0z+mC8Pv0FcqpRQ7u2UZsTkfqp6YEEL95yW2ps
        /w1IpB+gf6iGr6PMeyaMEROi7+ys87t30fRl2tQhbDcxqjeRIsrAXvlidl94WCiUtoYWe74OlVV2m
        HuQe1YPw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNp8c-002ySv-17;
        Mon, 24 Jul 2023 06:33:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Timur Tabi <timur@kernel.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: devices.txt: reconcile serial/ucc_uart minor numers
Date:   Sun, 23 Jul 2023 23:33:41 -0700
Message-ID: <20230724063341.28198-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reconcile devices.txt with serial/ucc_uart.c regarding device number
assignments. ucc_uart.c supports 4 ports and uses minor devnums
46-49, so update devices.txt with that info.
Then update ucc_uart.c's reference to the location of the devices.txt
list in the kernel source tree.

Fixes: d7584ed2b994 ("[POWERPC] qe-uart: add support for Freescale QUICCEngine UART")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Timur Tabi <timur@kernel.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/devices.txt |    2 +-
 drivers/tty/serial/ucc_uart.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -59,7 +59,7 @@ static int firmware_loaded;
 /* #define LOOPBACK */
 
 /* The major and minor device numbers are defined in
- * http://www.lanana.org/docs/device-list/devices-2.6+.txt.  For the QE
+ * Documentation/admin-guide/devices.txt.  For the QE
  * UART, we have major number 204 and minor numbers 46 - 49, which are the
  * same as for the CPM2.  This decision was made because no Freescale part
  * has both a CPM and a QE.
diff -- a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2691,7 +2691,7 @@
 		 45 = /dev/ttyMM1		Marvell MPSC - port 1 (obsolete unused)
 		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
 		    ...
-		 47 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
+		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
 		 50 = /dev/ttyIOC0		Altix serial card
 		    ...
 		 81 = /dev/ttyIOC31		Altix serial card

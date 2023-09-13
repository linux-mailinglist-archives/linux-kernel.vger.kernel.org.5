Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4258A79EAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbjIMOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbjIMOKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:10:02 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF122119
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:53 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by michel.telenet-ops.be with bizsmtp
        id lS8p2A00U3fvA4V06S8qJa; Wed, 13 Sep 2023 16:08:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003cs5-Lm;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV4n-0w;
        Wed, 13 Sep 2023 16:08:47 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 18/52] m68k: atari: Document data parameter of stdma_try_lock()
Date:   Wed, 13 Sep 2023 16:08:08 +0200
Message-Id: <a69dd3ab0a224e40ce5ce7b30981e2d7a0285a83.1694613528.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694613528.git.geert@linux-m68k.org>
References: <cover.1694613528.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/atari/stdma.c:69: warning: Function parameter or member 'data' not described in 'stdma_try_lock'

Fix this by documenting the data parameter.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/atari/stdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/atari/stdma.c b/arch/m68k/atari/stdma.c
index ce6818eff75efcdf..155fefff19b0e19d 100644
--- a/arch/m68k/atari/stdma.c
+++ b/arch/m68k/atari/stdma.c
@@ -61,6 +61,7 @@ static irqreturn_t stdma_int (int irq, void *dummy);
 /**
  * stdma_try_lock - attempt to acquire ST DMA interrupt "lock"
  * @handler: interrupt handler to use after acquisition
+ * @data: cookie passed to the interrupt handler function
  *
  * Returns !0 if lock was acquired; otherwise 0.
  */
-- 
2.34.1


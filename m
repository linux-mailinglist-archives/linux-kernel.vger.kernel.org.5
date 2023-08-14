Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF7477B1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjHNHBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjHNHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:00:45 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D050E73;
        Mon, 14 Aug 2023 00:00:43 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RPQJr0LpDz9ssp;
        Mon, 14 Aug 2023 09:00:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zuZCU_fctyZk; Mon, 14 Aug 2023 09:00:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RPQJp25t7z9srs;
        Mon, 14 Aug 2023 09:00:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4326E8B76C;
        Mon, 14 Aug 2023 09:00:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YEqhxg472S6o; Mon, 14 Aug 2023 09:00:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.203])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CA0A8B763;
        Mon, 14 Aug 2023 09:00:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37E62ESs271141
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:02:14 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37E62EhM271140;
        Mon, 14 Aug 2023 08:02:14 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] Documentation: devices.txt: Remove ttyIOC*
Date:   Mon, 14 Aug 2023 08:02:09 +0200
Message-ID: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691992928; l=1483; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=3DFU8bIJ7mw3pPTSc8blm/K1aP1rPFtUO/2S5FYALX8=; b=AHGJaqyXwaaBz8IkcAjvTt69oWesHlRokalggr5+nMG6/75fOPOriJ+W2f5hwFPy/QTEjJ+Nw QP9pmDr9ojHA+r515xukDymg/GggejEhFrU1iwmhHvVWuTmdzVVVU2z
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOC4 serial driver was removed, remove associated devices
from documentation.

Fixes: a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/admin-guide/devices.txt | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index b1b57f638b94..75a408f72402 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2692,14 +2692,8 @@
 		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
 		    ...
 		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
-		 50 = /dev/ttyIOC0		Altix serial card
-		    ...
-		 81 = /dev/ttyIOC31		Altix serial card
 		 82 = /dev/ttyVR0		NEC VR4100 series SIU
 		 83 = /dev/ttyVR1		NEC VR4100 series DSIU
-		 84 = /dev/ttyIOC84		Altix ioc4 serial card
-		    ...
-		 115 = /dev/ttyIOC115		Altix ioc4 serial card
 		 116 = /dev/ttySIOC0		Altix ioc3 serial card
 		    ...
 		 147 = /dev/ttySIOC31		Altix ioc3 serial card
@@ -2762,9 +2756,6 @@
 		 46 = /dev/cucpm0		Callout device for ttyCPM0
 		    ...
 		 49 = /dev/cucpm5		Callout device for ttyCPM5
-		 50 = /dev/cuioc40		Callout device for ttyIOC40
-		    ...
-		 81 = /dev/cuioc431		Callout device for ttyIOC431
 		 82 = /dev/cuvr0		Callout device for ttyVR0
 		 83 = /dev/cuvr1		Callout device for ttyVR1
 
-- 
2.41.0


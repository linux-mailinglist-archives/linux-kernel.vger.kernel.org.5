Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045D677B200
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjHNHBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjHNHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:00:42 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9EE65;
        Mon, 14 Aug 2023 00:00:37 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RPQJp0kcGz9ssX;
        Mon, 14 Aug 2023 09:00:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hu0sP8X6HQlH; Mon, 14 Aug 2023 09:00:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RPQJp04wFz9srs;
        Mon, 14 Aug 2023 09:00:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F36798B76C;
        Mon, 14 Aug 2023 09:00:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xWxrY8iqC-rg; Mon, 14 Aug 2023 09:00:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.203])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCCE28B763;
        Mon, 14 Aug 2023 09:00:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37E62F9n271148
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:02:15 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37E62FOL271147;
        Mon, 14 Aug 2023 08:02:15 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] Documentation: devices.txt: Remove ttySIOC*
Date:   Mon, 14 Aug 2023 08:02:10 +0200
Message-ID: <f13b5c64f8cb6d8f2357d7be14397676b27ac2a2.1691992627.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
References: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691992928; l=947; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=2nRA6l7I51a8hjG1ME4LWtdcgbM7LNm884RX1X7uab8=; b=i/A8caVQRktVdDHJ2ia90ZuOnaOkasvevHWeb9AMzpfuCW/SrgJ9uJMCpqWSPlVH27Y3IF85Q gPGppJp0PMUCKzCJ+8qdGeUtm51K3Ae9fN9G25U6//GtAOm8EjN9asg
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOC3 serial driver was removed, remove associated devices
from documentation.

Fixes: 9c860e4cf708 ("tty/serial: remove the ioc3_serial driver")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/admin-guide/devices.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 75a408f72402..1ba5b7c4973c 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2694,9 +2694,6 @@
 		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
 		 82 = /dev/ttyVR0		NEC VR4100 series SIU
 		 83 = /dev/ttyVR1		NEC VR4100 series DSIU
-		 116 = /dev/ttySIOC0		Altix ioc3 serial card
-		    ...
-		 147 = /dev/ttySIOC31		Altix ioc3 serial card
 		 148 = /dev/ttyPSC0		PPC PSC - port 0
 		    ...
 		 153 = /dev/ttyPSC5		PPC PSC - port 5
-- 
2.41.0


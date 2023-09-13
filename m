Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF28579EA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbjIMOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbjIMOI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:57 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552F1BCA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:51 -0700 (PDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4Rm2PF4wWYz4x7bB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:08:49 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id lS8o2A00F1C8whw01S8oWv; Wed, 13 Sep 2023 16:08:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXe-003cuC-N6;
        Wed, 13 Sep 2023 16:08:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXw-00FV7S-2V;
        Wed, 13 Sep 2023 16:08:48 +0200
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
Subject: [PATCH v2 51/52] m68k: sun3x: Make dvma_print() static
Date:   Wed, 13 Sep 2023 16:08:41 +0200
Message-Id: <0a038ac68ee553b1928a975dc0ae1c16803a0ac0.1694613528.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694613528.git.geert@linux-m68k.org>
References: <cover.1694613528.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was never a user of dvma_print() outside arch/m68k/sun3x/dvma.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/sun3x/dvma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/sun3x/dvma.c b/arch/m68k/sun3x/dvma.c
index d1847bfa136791e2..5185b4818d408e71 100644
--- a/arch/m68k/sun3x/dvma.c
+++ b/arch/m68k/sun3x/dvma.c
@@ -60,7 +60,7 @@ static volatile unsigned long *iommu_pte = (unsigned long *)SUN3X_IOMMU;
 
 #ifdef DEBUG
 /* code to print out a dvma mapping for debugging purposes */
-void dvma_print (unsigned long dvma_addr)
+static void dvma_print (unsigned long dvma_addr)
 {
 
 	unsigned long index;
-- 
2.34.1


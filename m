Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404BB7BC74D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjJGMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbjJGMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11804B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:44 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92c+9Dj9ViNtp+drs9p1jAq3q66nghzjNiv8cuBrUqo=;
        b=gLqoJ4AkNPP+SldOMwGDdyUm5n3d4kemlqE0vg6at1OsrFfUvwQGGTy9BpAH0gsqataz+X
        vOyiTnZ904rGI5hFfdIfU5F2vwzPrP+7PuSPX3PO7mAbzmNOXEAN4fCQFP2lzWJGt/7WTj
        G+GjgDk+4nRcI/Ndn153PitAlvLaTi3U4UbZTnDw6bjfOcZmn3LxUDqdntuNkYTbQywxuW
        N7ZjxOORRbxf8ernBeKgPfDMktYGC2AMy+/LK8mO2Kd73IZeqz9iHh3E8s1lyhCPa4UMYO
        K5L9h46cNaraSo1jXQpKMoknxTANBZeiyZU6TbJuTRG2u1fci9w3H9ZCiqa0cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92c+9Dj9ViNtp+drs9p1jAq3q66nghzjNiv8cuBrUqo=;
        b=Yv90/EUFxTHjbzqjTw+ZdqlY+e3z4vFQAd9Fbd2M4+KJ0nV/viaBDTxJeekYRGtCAaBaxS
        h7JIbEQN00+nH4DQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] MAINTAINERS: Remove myself from the
 general IRQ subsystem maintenance
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20231002141302.3409485-3-maz@kernel.org>
References: <20231002141302.3409485-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <169668004066.3135.8137606557277083333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     b673fe1a6229a49be5394f4e539055d9ce685615
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b673fe1a6229a49be5394f4e539055d9ce685615
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 02 Oct 2023 15:13:02 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:13 +01:00

MAINTAINERS: Remove myself from the general IRQ subsystem maintenance

It is pretty obvious that I haven't done much on the IRQ side
for a while, and it is unlikely that I'll have more bandwidth
for it any time soon. People keep sending me patches that
I end-up reviewing in a cursory manner, which isn't great for
anyone.

So in everyone's interest, I'm removing myself from the list
of maintainers and leave the irqchip and irqdomain subsystems
in Thomas' capable hands.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231002141302.3409485-3-maz@kernel.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8599e2..f2bc21a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11075,7 +11075,7 @@ F:	Documentation/devicetree/bindings/sound/irondevice,*
 F:	sound/soc/codecs/sma*
 
 IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
-M:	Marc Zyngier <maz@kernel.org>
+M:	Thomas Gleixner <tglx@linutronix.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/core-api/irq/irq-domain.rst
@@ -11094,7 +11094,6 @@ F:	lib/group_cpus.c
 
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
-M:	Marc Zyngier <maz@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

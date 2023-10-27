Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC8E7DA0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346440AbjJ0SqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjJ0SqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:46:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4941D62;
        Fri, 27 Oct 2023 11:23:50 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SZc2h5spUaSzuUIS3s9W0OgoU45rIU179H+nuFSIYQ=;
        b=k8ln5JgrDABOP2HMs5ntDx2a4as6ZJJZR79Grl8TGHyrHG6fnA4djSVr2Blf5DWm4C5VGs
        tzcLftX69XOrrKV6+0Iz1OiUgW2eeZqxt7vZmclw3RxOYdSShxapi23/qGwIefsFKOrb3i
        hSb8BLwnyNjZVBircyK4ttALVMHmkrrDbTLG0ZHF64nJeULBbEXhs/l/cRx0U5MwEu64zT
        lTIfGHaTjl7fGzykNtVj0Xss5au5jNDyjr7JzvJU5Yk63IDJYeXO84GALWoNqf9PTqcVgs
        L8BfRO3KpgzCbySMTPQ0/MCb6GPAaqCUEkrt7u6O/CyiwdCZKAbsLhMYT6ZmBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SZc2h5spUaSzuUIS3s9W0OgoU45rIU179H+nuFSIYQ=;
        b=DzDSw+qvheB4zZhJBXgz4xA48w9u6iD+riW0iUeCvlUHbh4pfCYJHahofQQMPPzyPQU7np
        LXNe+klDEJo4TQAQ==
From:   "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Cc:     stable@kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727081848.100834-2-biju.das.jz@bp.renesas.com>
References: <20230727081848.100834-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <169843099454.3135.14190168056733834940.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b7a8f1f7a8a25e09aaefebb6251a77f44cda638b
Gitweb:        https://git.kernel.org/tip/b7a8f1f7a8a25e09aaefebb6251a77f44cda638b
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Thu, 27 Jul 2023 09:18:44 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 11 Oct 2023 09:03:54 +02:00

dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt names

As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
interrupt names starts with 'tci' instead of 'tgi'.

Fix this documentation issue by replacing below overflow/underflow
interrupt names:
 - tgiv0->tciv0
 - tgiv1->tciv1
 - tgiu1->tciu1
 - tgiv2->tciv2
 - tgiu2->tciu2
 - tgiv3->tciv3
 - tgiv4->tciv4
 - tgiv6->tciv6
 - tgiv7->tciv7
 - tgiv8->tciv8
 - tgiu8->tciu8

Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a bindings")
Cc: stable@kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230727081848.100834-2-biju.das.jz@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml | 38 +++----
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index bffdab0..fbac40b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -169,27 +169,27 @@ properties:
       - const: tgib0
       - const: tgic0
       - const: tgid0
-      - const: tgiv0
+      - const: tciv0
       - const: tgie0
       - const: tgif0
       - const: tgia1
       - const: tgib1
-      - const: tgiv1
-      - const: tgiu1
+      - const: tciv1
+      - const: tciu1
       - const: tgia2
       - const: tgib2
-      - const: tgiv2
-      - const: tgiu2
+      - const: tciv2
+      - const: tciu2
       - const: tgia3
       - const: tgib3
       - const: tgic3
       - const: tgid3
-      - const: tgiv3
+      - const: tciv3
       - const: tgia4
       - const: tgib4
       - const: tgic4
       - const: tgid4
-      - const: tgiv4
+      - const: tciv4
       - const: tgiu5
       - const: tgiv5
       - const: tgiw5
@@ -197,18 +197,18 @@ properties:
       - const: tgib6
       - const: tgic6
       - const: tgid6
-      - const: tgiv6
+      - const: tciv6
       - const: tgia7
       - const: tgib7
       - const: tgic7
       - const: tgid7
-      - const: tgiv7
+      - const: tciv7
       - const: tgia8
       - const: tgib8
       - const: tgic8
       - const: tgid8
-      - const: tgiv8
-      - const: tgiu8
+      - const: tciv8
+      - const: tciu8
 
   clocks:
     maxItems: 1
@@ -285,16 +285,16 @@ examples:
                    <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
-      interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0", "tgiv0", "tgie0",
+      interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0", "tciv0", "tgie0",
                         "tgif0",
-                        "tgia1", "tgib1", "tgiv1", "tgiu1",
-                        "tgia2", "tgib2", "tgiv2", "tgiu2",
-                        "tgia3", "tgib3", "tgic3", "tgid3", "tgiv3",
-                        "tgia4", "tgib4", "tgic4", "tgid4", "tgiv4",
+                        "tgia1", "tgib1", "tciv1", "tciu1",
+                        "tgia2", "tgib2", "tciv2", "tciu2",
+                        "tgia3", "tgib3", "tgic3", "tgid3", "tciv3",
+                        "tgia4", "tgib4", "tgic4", "tgid4", "tciv4",
                         "tgiu5", "tgiv5", "tgiw5",
-                        "tgia6", "tgib6", "tgic6", "tgid6", "tgiv6",
-                        "tgia7", "tgib7", "tgic7", "tgid7", "tgiv7",
-                        "tgia8", "tgib8", "tgic8", "tgid8", "tgiv8", "tgiu8";
+                        "tgia6", "tgib6", "tgic6", "tgid6", "tciv6",
+                        "tgia7", "tgib7", "tgic7", "tgid7", "tciv7",
+                        "tgia8", "tgib8", "tgic8", "tgid8", "tciv8", "tciu8";
       clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
       power-domains = <&cpg>;
       resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;

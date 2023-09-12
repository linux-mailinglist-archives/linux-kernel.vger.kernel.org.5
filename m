Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0344479D15E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjILMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjILMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:49:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A596910D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:49:54 -0700 (PDT)
Date:   Tue, 12 Sep 2023 12:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694522992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55pkRgTuCni+LyjkZ2Eo/eG7LqE/F0QPoiU9DUC6Vfs=;
        b=ZuXz9oqRk3U2xsknUf8uY3w8sYZlc4l3YDaVHHJXmVIUbewy+l7ZgKZMraoKFPTZjpqpac
        /Ggkt/TgM2kK7Fqy8Gr10VtOGWl6IH8isbIonFtEl4cCOH/LwKutScb1e6yZa3qJTSM4Us
        BXtYHsvIVkbez5/axy8FeqLWpct3KE/u4hN0htPhWozhwh1L5xu+PH1t/f9b8uwkCkHlPz
        Fj+LahNpo0sgDWchKtfW2+MB4BIchbHDakIZ2TDsoPCMK+nbouMjs/7e9nZri/U9LWcBp3
        OLLbugmoC8isM/HPouZzVyISIXAeQUheM3BuS0XtHg+9VwCOG9J3/JSKWv2ifg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694522992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55pkRgTuCni+LyjkZ2Eo/eG7LqE/F0QPoiU9DUC6Vfs=;
        b=5kZgPp/2YgoA2wjFyd1gn79ErfBTqZ75pdqJH2cQxrfwKi3huR/cD1dF2koYSWpZk7GAB2
        b2Cr8+NobNf2tEAQ==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update description for '#interrupt-cells' property
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220722151155.21100-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220722151155.21100-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <169452299136.27769.11553803344852977904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     cfa1f9db6d6088118ef311c0927c66072665b47e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/cfa1f9db6d6088118ef311c0927c66072665b47e
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Fri, 22 Jul 2022 16:11:54 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 12 Sep 2023 13:40:52 +01:00

dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property

Update description for '#interrupt-cells' property to utilize the
RZG2L_{NMI,IRQX} for the first cell defined in the
include/dt-bindings/interrupt-controller/irqc-rzg2l.h file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 96fed779d3d4cb3c ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220722151155.21100-3-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 33b90e9..ea7db36 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -31,8 +31,9 @@ properties:
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
-    description: The first cell should contain external interrupt number (IRQ0-7) and the
-                 second cell is used to specify the flag.
+    description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
+                 include/dt-bindings/interrupt-controller/irqc-rzg2l.h and the second
+                 cell is used to specify the flag.
     const: 2
 
   '#address-cells':

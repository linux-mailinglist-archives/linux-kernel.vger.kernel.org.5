Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF407BC754
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbjJGMBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbjJGMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6DC2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:49 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6aHtshmGLSHdXmFugIBotlcQ4z4y6NVdza4dzL8x34=;
        b=uVwgtlOFp6YeHgSxMO6bZRnCh60XtVW3pa55MDBc4CSDMJtl4IhQMBzvddhFsbIpPToaNQ
        ceDDTCB5kIUPHImls3UXYtrxwxevNYF039dD8dVwlb/E763nGkJ0TkRg7ikGzMxxkkqgHc
        lwXeV/uyB5IVgmfmX95Rcpo/+BBh7sU3cr3PS3Q9wbUDyV/BJT7B4veYF1jJ7+6U80+X/k
        0e/ZuiWQ96uBsQ/BcYzJ1DNsMYPwSswPDJ9jtN4D4LFMfYagrfJ18FPetdzZ5CuSsVRmtE
        ERqRyD6Qjzp3nzJ5cjRlHjw9LWpmRlaleO9M5WpWbzfJEfxn4T1pdFI1iauf0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6aHtshmGLSHdXmFugIBotlcQ4z4y6NVdza4dzL8x34=;
        b=wg1PTZnrt2jk8P7QviLtym5di2yESZ/k3RzHSiecXJdKi+HJRHZ+zAF8FxwR3WtJKtpNQM
        f2uJhLqfESXC7HAg==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: interrupt-controller:
 renesas,irqc: Add r8a779f0 support
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C9467a1c67d5d240211f88336973fa968d39cc860=2E16904?=
 =?utf-8?q?46928=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C9467a1c67d5d240211f88336973fa968d39cc860=2E169044?=
 =?utf-8?q?6928=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <169668004682.3135.8488083771046609132.tip-bot2@tip-bot2>
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

Commit-ID:     977f7c2b275667777cd42ab0e61461617b652b05
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/977f7c2b275667777cd42ab0e61461617b652b05
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Thu, 27 Jul 2023 10:36:23 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:05 +01:00

dt-bindings: interrupt-controller: renesas,irqc: Add r8a779f0 support

Document support for the Interrupt Controller for External Devices
(INT-EX) in the Renesas R-Car S4-8 (R8A779F0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/9467a1c67d5d240211f88336973fa968d39cc860.1690446928.git.geert+renesas@glider.be
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index 95033cb..b417341 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -37,6 +37,7 @@ properties:
           - renesas,intc-ex-r8a77990    # R-Car E3
           - renesas,intc-ex-r8a77995    # R-Car D3
           - renesas,intc-ex-r8a779a0    # R-Car V3U
+          - renesas,intc-ex-r8a779f0    # R-Car S4-8
           - renesas,intc-ex-r8a779g0    # R-Car V4H
       - const: renesas,irqc
 

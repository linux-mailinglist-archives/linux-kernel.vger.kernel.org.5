Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B767BC74E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbjJGMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjJGMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F59BC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:44 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/VuryWsOY5L1lvasV2Y5bxl2TCkoNrxw4HiUx50Fso=;
        b=Yy/4nHnyzHf5G+VlsjLu/sArRmzHy8t+jYdm7b+RwFDsnZMt8sI2xNSAi/naxDm9ONY/7T
        lK3NSG3t3C94vKqrabIH8Kpt5jxqkCZfFfnslAhMoE561HFSIk4KzJmgTh00XHO+LeoD2H
        tAgPFugLl+WmAaIFATSbf4x70EWBD0LHnNLkr4/l+l9OlPVDncp6hvAb38WXOGsjVpUc+0
        5n8Fp2ICC/G2a6vMV86kOM7xzoN3CFZzJa8STHPV8JjS4N/tMkEyo33ckqQ7gFzIFAbuNk
        h8BXNKJ7YTEme5bzz7dVc1DOk3u0CCSACXDOI/YzA8lvW1g/tpupsY0zvBmq2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/VuryWsOY5L1lvasV2Y5bxl2TCkoNrxw4HiUx50Fso=;
        b=vXof+STJEz3aUm7XN1N+itzWxChb//mDYi4nNi5gyTXEZmYfv1r+VBF+tJkZ0SCJitD4Kf
        I/3SBzI/1/cUcDCg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] MAINTAINERS: Add myself as the ARM GIC
 maintainer
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <zenghui.yu@linux.dev>,
        tglx@linutronix.de
In-Reply-To: <20231002141302.3409485-2-maz@kernel.org>
References: <20231002141302.3409485-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <169668004147.3135.9982739949197050672.tip-bot2@tip-bot2>
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

Commit-ID:     c1097091b72255b2f9373260579133c5ce134dd1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c1097091b72255b2f9373260579133c5ce134dd1
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 02 Oct 2023 15:13:01 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:13 +01:00

MAINTAINERS: Add myself as the ARM GIC maintainer

The ARM GIC maintenance is currently covered by the blanket
IRQCHIP DRIVERS entry, which I'm about to remove myself from.

It is unlikely that anyone is mad enough to pick this up,
so I'll keep doing that for the foreseable future.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Link: https://lore.kernel.org/r/20231002141302.3409485-2-maz@kernel.org
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f1328..a8599e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1585,6 +1585,17 @@ F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
 
+ARM GENERIC INTERRUPT CONTROLLER DRIVERS
+M:	Marc Zyngier <maz@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,gic*
+F:	arch/arm/include/asm/arch_gicv3.h
+F:	arch/arm64/include/asm/arch_gicv3.h
+F:	drivers/irqchip/irq-gic*.[ch]
+F:	include/linux/irqchip/arm-gic*.h
+F:	include/linux/irqchip/arm-vgic-info.h
+
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported

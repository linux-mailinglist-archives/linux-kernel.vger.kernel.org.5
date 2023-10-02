Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE87B5510
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjJBONe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjJBONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:13:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B20AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C1C433C7;
        Mon,  2 Oct 2023 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696256009;
        bh=WPPWNMT1FiFMDjv1uri72nHhTSI3cPkpTP7tQta4Kpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOSJiZtjpjEeAC0IXYCiOsnjTt7neLOofcuKlPEx6D7CErnEB5emCMJVMIDg3/294
         k3g0054NhpUzBWZaXWfIfXDeFcug42bR7W6b9D4CNFKhkqKOw57jcnGeaPmN0cZWyV
         Uh+bEgAfgAVAtpgdHzXOPrdzEmU4Sq7verhvf1aP/hsa//twtJE/KoYFUxaKZwOgDY
         GBFJIQ+Ft/aiPxvqLKoY7nT1dM05evOBsptt8ijX1HEajUQKQMaLL4ubSeuaL/1hLL
         zvnxG5Z843vYOeyel2uDO22Nh6GBGeMXpJQKjiMtVkkw7InEmQdVQCNrVuoy4VgNfl
         AhmiC5oi0f5PA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qnJfr-000Nzy-87;
        Mon, 02 Oct 2023 15:13:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] MAINTAINERS: Add myself as the ARM GIC maintainer
Date:   Mon,  2 Oct 2023 15:13:01 +0100
Message-Id: <20231002141302.3409485-2-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002141302.3409485-1-maz@kernel.org>
References: <20231002141302.3409485-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM GIC maintenance is currently covered by the blanket
IRQCHIP DRIVERS entry, which I'm about to remove myself from.

It is unlikely that anyone is mad enough to pick this up,
so I'll keep doing that for the foreseable future.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..f37f4ee96b20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1585,6 +1585,14 @@ F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
 
+ARM GENERIC INTERRUPT CONTROLLER DRIVERS
+M:	Marc Zyngier <maz@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/include/asm/arch_gicv3.h
+F:	arch/arm64/include/asm/arch_gicv3.h
+F:	drivers/irqchip/irq-gic*.[ch]
+
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
-- 
2.34.1


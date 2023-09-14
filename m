Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC647A01CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjINKh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbjINKhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:37:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0721BEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:37:19 -0700 (PDT)
X-QQ-mid: bizesmtp89t1694687810trhko363
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 18:36:48 +0800 (CST)
X-QQ-SSF: 00200000000000907000000A0000000
X-QQ-FEAT: I8hG9CuxGDK9htxS4giykKhdSKm0WfZ2rkQbe2+M7ckZgA0VYqnbJCboHIX7t
        /EV3DmDQ28zupomg5/x5+bl55fWx9dbWnbUD3+Xpgz/Gd0roHog9nljRxYM1VvOn6iOPdJy
        7TuNplcJFa9FvBXjTOYqm+jrXaCD5bom5i0nLCfuC1Ao1sK0oJyKcO6Oi7q60TNZ8bqe75Q
        dllQatPD0IdZietuBdXUp0lpngTVckYb/mUAECdARNfIJt9T5qSyb1ahqpv1r8ZMfonMA6b
        UUDnBcrSzvNnQxiS1m57SbZN8gKLZTecoxDTVlOmt0g/Qmgchsf3CN2n4RV9Sw66eg1PcU6
        wf+8GAqr6aqFSgiq0h7g2Z+8VORzkiN/p0wqMqCD4bHPXZHfnhxp/uGS88f/g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2437291328918488194
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, falcon@tinylab.org,
        w@1wt.eu, linux@weissschuh.net, tanyuan@tinylab.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 3/3] x86/config: Simplify i386_defconfig and x86_64_defconfig
Date:   Thu, 14 Sep 2023 18:36:47 +0800
Message-Id: <d992371d07c4e423b70d56abef7806f506696814.1694687048.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694687048.git.tanyuan@tinylab.org>
References: <cover.1694687048.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify i386_defconfig and x86_64_defconfig with POWER_RESET dependences.

Regenerate i386_defconfig and x86_64_defconfig with 'make savedefconfig'.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/x86/configs/i386_defconfig   | 2 +-
 arch/x86/configs/x86_64_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index babd91c8091a..470ce962eb58 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -121,7 +121,6 @@ CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
-CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_PCCARD=y
@@ -186,6 +185,7 @@ CONFIG_NVRAM=y
 CONFIG_HPET=y
 # CONFIG_HPET_MMAP is not set
 CONFIG_I2C_I801=y
+CONFIG_POWER_RESET=y
 CONFIG_WATCHDOG=y
 CONFIG_AGP=y
 CONFIG_AGP_AMD64=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index babd91c8091a..470ce962eb58 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -121,7 +121,6 @@ CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
-CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_PCCARD=y
@@ -186,6 +185,7 @@ CONFIG_NVRAM=y
 CONFIG_HPET=y
 # CONFIG_HPET_MMAP is not set
 CONFIG_I2C_I801=y
+CONFIG_POWER_RESET=y
 CONFIG_WATCHDOG=y
 CONFIG_AGP=y
 CONFIG_AGP_AMD64=y
-- 
2.34.1


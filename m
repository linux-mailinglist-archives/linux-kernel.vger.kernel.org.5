Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B55979D268
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjILNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjILNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:32:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2D72123
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:15 -0700 (PDT)
X-QQ-mid: bizesmtpipv602t1694525493t476
Received: from localhost.localdomain ( [255.55.58.5])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 12 Sep 2023 21:31:31 +0800 (CST)
X-QQ-SSF: 01200000000000302000000A0000000
X-QQ-FEAT: n5ZZfu71JLxz6MwOEsrJsuqDcH7rEDQR0btq3jRrn7DHcQvGJ9LVMjdKmIjvh
        JCDktGeOKpmJZBOTGF5AyusOz1RPbqXIaM+xW3oBUwYNF+XjMgdTm37xKaYK/xl6O7j+2Zh
        sVfvh/bHB73yBUjDSy7VomzjLsl0c1zKxDjPinRcCrvHTpAaXpiXxcrYzpsOl0Pv9l+LXjQ
        dnMjpdkxDoZHR6uALLyruupAvTm0C9fNHKcF7K67PdiYIOQ+3asQkwGJY83M06PEQKpxBAV
        xh+zM1X97JhIoX+EORYPwL+Wwu2CVA1vL4mJQTZcqUuSkzl2+TTLc1fGerQl9FHuMKgrY0r
        fvZxKscTVAdHMhOW3g=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3363788168851752325
From:   Jinyu Tang <tangjinyu@tinylab.org>
To:     william.qiu@starfivetech.com, hal.feng@starfivetech.com,
        conor.dooley@microchip.com, palmer@dabbelt.com,
        apatel@ventanamicro.com
Cc:     ttjjyystupid@163.com, falcon@tinylab.org, wangjiexun@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jinyu Tang <tangjinyu@tinylab.org>
Subject: [PATCH v2] riscv: defconfig : add CONFIG_MMC_DW for starfive
Date:   Tue, 12 Sep 2023 21:31:28 +0800
Message-Id: <20230912133128.5247-1-tangjinyu@tinylab.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If these config not set, mmc can't run for jh7110, rootfs can't
be found when using SD card. So set CONFIG_MMC_DW=y like arm64
defconfig, and set CONFIG_MMC_DW_STARFIVE=y for starfive. Then
starfive vf2 board can start SD card rootfs with mainline defconfig
and dtb.

Signed-off-by: Jinyu Tang <tangjinyu@tinylab.org>
---
v1 -> v2:
Change the order of these by using savedefconfig, thanks to
Conor Dooley.

 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9..76c43a532 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -169,6 +169,8 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_STARFIVE=y
 CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
-- 
2.39.2


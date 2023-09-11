Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9779B2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjIKVrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbjIKNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:00:33 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7CCD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:00:22 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1694437199trjm
Received: from localhost.localdomain ( [255.178.53.11])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Sep 2023 20:59:57 +0800 (CST)
X-QQ-SSF: 01200000000000302000000A0000000
X-QQ-FEAT: 6WLXEB60CfU6gl+0T7VQ7y7v63PY40ezi7u04+YNzdCnXIqjzLgP2nL5gtTl8
        NPAPmj8NOF76BDhGN96OXFLTK93HpLe82OevqdWaQM/aFQLohIeaB+GVxMrSXq/sPiuyph/
        6yN/V3NOTNwZn3yJdx1HPOHsGtirccrxhRojqjaJ/dhnVE0YmZtxmu/YXrcSf0rbt6VZHl/
        0yCkaKNowUFu6FEZ1GxMVY1sOtnv320Z+GrPsar4CldzfQuCcLiLqaJTIJLZwYH9hEc6Wvq
        esli6Gh0wURUleDhcUW7kmri3XyI58p9sO+ghTO4MUJKQspXt1LrH8IM66SBoUhUUuMDTty
        BJ6cqMffRYQKgSpjafsHjCPiEsv2vSGK/0e/Xc+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11791659690987653282
From:   Jinyu Tang <tangjinyu@tinylab.org>
To:     william.qiu@starfivetech.com, hal.feng@starfivetech.com,
        conor.dooley@microchip.com, palmer@dabbelt.com,
        apatel@ventanamicro.com
Cc:     ttjjyystupid@163.com, falcon@tinylab.org, wangjiexun@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jinyu Tang <tangjinyu@tinylab.org>
Subject: [PATCH] riscv: defconfig : add CONFIG_MMC_DW for starfive
Date:   Mon, 11 Sep 2023 20:59:55 +0800
Message-Id: <20230911125955.8937-1-tangjinyu@tinylab.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If these config not set, mmc can't run for jh7110, rootfs can't
be found when using SD card. So set CONFIG_MMC_DW=y like arm64
defconfig, and set CONFIG_MMC_DW_STARFIVE=y for starfive. Then
starfive vf2 can start SD card rootfs with mainline defconfig and
dtb.

Signed-off-by: Jinyu Tang <tangjinyu@tinylab.org>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9..0664b92d1 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -170,6 +170,8 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_STARFIVE=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
-- 
2.39.2


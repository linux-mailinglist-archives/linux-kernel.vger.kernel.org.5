Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7779FEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjINIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjINIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:44:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794A1FE5;
        Thu, 14 Sep 2023 01:44:27 -0700 (PDT)
X-QQ-mid: bizesmtp72t1694681055tww0inna
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 16:44:12 +0800 (CST)
X-QQ-SSF: 00200000000000907000000A0000000
X-QQ-FEAT: rZJGTgY0+YOhl84ujRW11R9dJ6KjDmRaz4/+ZHl3eAlGCiSccYVFUNm2l3sCc
        KdlGQ4Z2arqnihIwzx4t5YxWKQXYvUsN+XAUqMFeV724FprDrk8BxS7WUdJTCutVqyUQM07
        blEuMqJo4guiFrmpYEteUaDbOhmlSz6P40wRVj9nDb8wgBmi7IqMZD+ehHo7jHpfvN+czt6
        jCESP36NbQw1Wm/hlR2mWEs3LZfWyuXZQlUrdK5z2c+hOuvD1c/iQ1y1h3O0FXFVhcVeMn/
        bwOWV2vgNnnloCLUeUZpDRX3lPGn+XWH7rugbaWiB+GRPg7eJDJfVgmhde6d2jxuyyYQVJs
        Tx2CLYyTDf4LlQhgS35WybLkg9fMq7cyRty2pqqGpC4sdPcWiE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17564644659303602312
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tsbogend@alpha.franken.de, 42.hyeyoo@gmail.com, philmd@linaro.org
Cc:     linux-mips@vger.kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org, w@1wt.eu,
        linux@weissschuh.net, tanyuan@tinylab.org
Subject: [PATCH v3 3/3] MIPS: Simplify malta_defconfig
Date:   Thu, 14 Sep 2023 16:44:11 +0800
Message-Id: <4d946232ffdd8891a32d4a9f17dbca10a4aa465d.1694680448.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694680448.git.tanyuan@tinylab.org>
References: <cover.1694680448.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify malta_defconfig with POWER_RESET dependences.

Regenerate malta_defconfig with 'make savedefconfig'.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/mips/configs/malta_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 7ae07d57b79a..99049e993192 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -192,7 +192,6 @@ CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
-CONFIG_PCI=y
 CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
@@ -284,7 +283,6 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-- 
2.34.1


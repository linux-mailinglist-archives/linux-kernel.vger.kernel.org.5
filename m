Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3346792B02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbjIEQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354552AbjIEMgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:36:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3895C1AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:36:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxnuveIPdkg5MfAA--.61229S3;
        Tue, 05 Sep 2023 20:36:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3c7PIPdkKeZsAA--.894S2;
        Tue, 05 Sep 2023 20:36:45 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn,
        Yinbo Zhu <zhuyinbo@loongson.cn>, Liu Yun <liuyun@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: loongson2_pm: add dependency on INPUT
Date:   Tue,  5 Sep 2023 20:36:29 +0800
Message-Id: <20230905123629.4510-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c7PIPdkKeZsAA--.894S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some undefined references to `input_set_capability' and
`input_register_device` issue when INPUT is not enabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202309030751.pDnTZX4E-lkp@intel.com/
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/soc/loongson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
index 314e13bb3e01c..1b57af1e55298 100644
--- a/drivers/soc/loongson/Kconfig
+++ b/drivers/soc/loongson/Kconfig
@@ -20,6 +20,7 @@ config LOONGSON2_GUTS
 config LOONGSON2_PM
 	bool "Loongson-2 SoC Power Management Controller Driver"
 	depends on LOONGARCH && OF
+	depends on INPUT
 	help
 	  The Loongson-2's power management controller was ACPI, supports ACPI
 	  S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
-- 
2.31.1


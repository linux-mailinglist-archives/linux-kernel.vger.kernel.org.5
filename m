Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE487EFF0D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjKRKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjKRKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:44 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E64410DC;
        Sat, 18 Nov 2023 02:41:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgf2pxcz4f3lff;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 82BEF1A016E;
        Sat, 18 Nov 2023 18:41:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S17;
        Sat, 18 Nov 2023 18:41:38 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 13/14] kddv/tests/mtd: Add test cases for mchp23k256 driver
Date:   Sat, 18 Nov 2023 18:40:39 +0800
Message-Id: <20231118104040.386381-14-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S17
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxJF1rJr1fZw4DXFWDArb_yoWrWw4xpF
        WrCayYqr1UZFn293sa9F43Jr15uw4kXry5GrWvgw1a9w4aqw1DKr48KFyUta43W3ykXrWr
        uayjvrW8Grs5WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
        nIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

This add test case for mchp23k256 mtd driver, test for
create mchp23k256 device, default size of the device and
read/write data from device.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu@huawei.com>
---
 .../kddv/kddv/data/bpf/mtd/mtd-mchp23k256.c   | 72 +++++++++++++++++++
 .../kddv/kddv/tests/mtd/test_mchp23k256.py    | 41 +++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/testing/kddv/kddv/data/bpf/mtd/mtd-mchp23k256.c
 create mode 100755 tools/testing/kddv/kddv/tests/mtd/test_mchp23k256.py

diff --git a/tools/testing/kddv/kddv/data/bpf/mtd/mtd-mchp23k256.c b/tools/testing/kddv/kddv/data/bpf/mtd/mtd-mchp23k256.c
new file mode 100644
index 000000000000..b1aa8a25edc0
--- /dev/null
+++ b/tools/testing/kddv/kddv/data/bpf/mtd/mtd-mchp23k256.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022-2023 Huawei Technologies Co., Ltd */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+#include "spi-xfer-base.h"
+
+#define MCHP23K256_CMD_WRITE_STATUS	0x01
+#define MCHP23K256_CMD_WRITE		0x02
+#define MCHP23K256_CMD_READ		0x03
+
+#define CHIP_REGS_SIZE			0x20000
+
+#define MAX_CMD_SIZE			4
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u8);
+} regs_mtd_mchp23k256 SEC(".maps");
+
+static unsigned int chip_reg;
+
+static int spi_transfer_read(struct spi_msg_ctx *msg, unsigned int len)
+{
+	return spi_xfer_read_u8(msg, len, &regs_mtd_mchp23k256, chip_reg, 0);
+}
+
+static int spi_transfer_write(struct spi_msg_ctx *msg, unsigned int len)
+{
+	u8 opcode = msg->data[0];
+	int i;
+
+	switch (opcode) {
+	case MCHP23K256_CMD_READ:
+	case MCHP23K256_CMD_WRITE:
+		if (len < 2)
+			return -EINVAL;
+
+		chip_reg = 0;
+		for (i = 0; i < MAX_CMD_SIZE && i < len - 1; i++)
+			chip_reg = (chip_reg << 8) + msg->data[1 + i];
+
+		return 0;
+	case MCHP23K256_CMD_WRITE_STATUS:
+		// ignore write status
+		return 0;
+	default:
+		break;
+	}
+
+	return spi_xfer_write_u8(msg, len, &regs_mtd_mchp23k256, chip_reg, 0);
+}
+
+SEC("raw_tp.w/spi_transfer_writeable")
+int BPF_PROG(mtd_mchp23k256, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+{
+	int ret = 0;
+
+	if (msg->tx_nbits)
+		ret = spi_transfer_write(msg, len);
+	else if (msg->rx_nbits)
+		ret = spi_transfer_read(msg, len);
+
+	return ret;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/kddv/kddv/tests/mtd/test_mchp23k256.py b/tools/testing/kddv/kddv/tests/mtd/test_mchp23k256.py
new file mode 100755
index 000000000000..eefad9d70483
--- /dev/null
+++ b/tools/testing/kddv/kddv/tests/mtd/test_mchp23k256.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+from kddv.core import SPIDriverTest
+from . import MTDDriver
+
+MCHP23K256_TEST_DATA = [0x78] * 16
+
+class TestMCHP23K256(SPIDriverTest, MTDDriver):
+    name = "mchp23k256"
+
+    @property
+    def bpf(self):
+        return f"mtd-{self.name}"
+
+    def test_device_probe(self):
+        with self.assertRaisesFault():
+            with self.device() as _:
+                pass
+
+    def test_device_size(self):
+        with self.device() as dev:
+            size = self.mtd_read_attr(dev, 'size')
+            self.assertEqual(size, '32768')
+
+    def test_read_data(self):
+        with self.device() as dev:
+            self.write_regs(0x00, MCHP23K256_TEST_DATA)
+            data = self.mtd_read_bytes(dev, 16)
+            self.assertEqual(data, bytes(MCHP23K256_TEST_DATA))
+
+    def test_write_data(self):
+        with self.device() as dev:
+            self.write_regs(0x00, [0] * 16)
+            self.mtd_write_bytes(dev, bytes(MCHP23K256_TEST_DATA))
+            self.assertRegsEqual(0x00, MCHP23K256_TEST_DATA)
-- 
2.34.1


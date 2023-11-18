Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFBB7EFF1D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjKRKpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjKRKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:45:35 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10610DA;
        Sat, 18 Nov 2023 02:45:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SXVm73l0yz4f3kFr;
        Sat, 18 Nov 2023 18:45:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 0C4761A016E;
        Sat, 18 Nov 2023 18:45:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhDClVhlAjMGBQ--.58652S8;
        Sat, 18 Nov 2023 18:45:28 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huawecloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 -next 4/4] spi: mockup: Add documentation
Date:   Sat, 18 Nov 2023 18:44:42 +0800
Message-Id: <20231118104442.861759-5-zhangxiaoxu@huawecloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104442.861759-1-zhangxiaoxu@huawecloud.com>
References: <20231118104442.861759-1-zhangxiaoxu@huawecloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhDClVhlAjMGBQ--.58652S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry5Jr4xWFW7Jry5WFWkCrg_yoW7trWDpF
        WUJFy3K3y8XF9xWF1Sq3s5G343Aas7ZFZrGFZ5tF10yr1q9r95AF1xtryYqan8WF4DCFy0
        vFW5AFW8Kry7Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwV
        Aq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUruWlDUUUU
Sender: zhangxiaoxu@huaweicloud.com
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

Add documentation for the SPI mockup controller driver.
This include the tutorial for how to mockup a spi device.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 Documentation/spi/index.rst      |   1 +
 Documentation/spi/spi-mockup.rst | 198 +++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 Documentation/spi/spi-mockup.rst

diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
index 06c34ea11bcf..a8f4f5cd0f09 100644
--- a/Documentation/spi/index.rst
+++ b/Documentation/spi/index.rst
@@ -13,6 +13,7 @@ Serial Peripheral Interface (SPI)
    pxa2xx
    spi-lm70llp
    spi-sc18is602
+   spi-mockup
 
 .. only::  subproject and html
 
diff --git a/Documentation/spi/spi-mockup.rst b/Documentation/spi/spi-mockup.rst
new file mode 100644
index 000000000000..a5b69ce83ad9
--- /dev/null
+++ b/Documentation/spi/spi-mockup.rst
@@ -0,0 +1,198 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+spi-mockup
+==========
+
+Description
+===========
+
+This module is a very simple fake SPI controller driver. It implements
+a BPF based interface to mockup SPI device.
+
+No hardware is needed nor associated with this module. It will respond
+spi message by BPF program attached to spi_transfer_writeable tracepoint
+by reading from or writing BPF maps.
+
+The typical use-case is like this:
+        1. create the spi mockup controller;
+        2. load EBPF program as device's backend;
+        3. create target chip device to the spi mockup controller.
+
+Example
+=======
+
+This example show how to mock a MTD device by using spi-mockup driver.
+
+Compile your copy of the kernel source. Make sure to configure the spi-mockup
+and the target chip driver as a module.
+
+Register the spi mockup controller.
+
+::
+
+  $ mkdir /sys/kernel/config/spi-mockup/spi0
+
+  # configure the spi mockup controller attribute
+  $ echo 40000 > /sys/kernel/config/spi-mockup/spi0/min_speed
+  $ echo 25000000 > /sys/kernel/config/spi-mockup/spi0/max_speed
+  $ echo 0 > /sys/kernel/config/spi-mockup/spi0/flags
+  $ echo 8 > /sys/kernel/config/spi-mockup/spi0/num_cs
+
+  # enable the spi mockup controller
+  $ echo 1 > /sys/kernel/config/spi-mockup/spi0/live
+
+Write a BPF program as device's backup.
+
+::
+
+  #define MCHP23K256_CMD_WRITE_STATUS   0x01
+  #define MCHP23K256_CMD_WRITE          0x02
+  #define MCHP23K256_CMD_READ           0x03
+
+  #define CHIP_REGS_SIZE		0x20000
+
+  #define MAX_CMD_SIZE		        4
+
+  struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u8);
+  } regs_mchp23k256 SEC(".maps");
+
+  static unsigned int chip_reg = 0;
+
+  static int spi_transfer_read(struct spi_msg_ctx *msg, unsigned int len)
+  {
+	int i, key;
+	u8 *reg;
+
+	for (i = 0; i < len && i < sizeof(msg->data); i++) {
+		key = i + chip_reg;
+
+		reg = bpf_map_lookup_elem(&regs_mchp23k256, &key);
+		if (!reg) {
+			bpf_printk("key %d not exists", key);
+			return -EINVAL;
+		}
+
+		msg->data[i] = *reg;
+	}
+
+	return 0;
+  }
+
+  static int spi_transfer_write(struct spi_msg_ctx *msg, unsigned int len)
+  {
+	u8 opcode = msg->data[0], value;
+	int i, key;
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
+	for (i = 0; i < len && i < sizeof(msg->data); i++) {
+		value = msg->data[i];
+		key = chip_reg + i;
+
+		if (bpf_map_update_elem(&regs_mchp23k256, &key, &value,
+					BPF_EXIST)) {
+			bpf_printk("key %d not exists", key);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+  }
+
+  SEC("raw_tp.w/spi_transfer_writeable")
+  int BPF_PROG(mtd_mchp23k256, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+  {
+	int ret = 0;
+
+	if (msg->tx_nbits)
+		ret = spi_transfer_write(msg, len);
+	else if (msg->rx_nbits)
+		ret = spi_transfer_read(msg, len);
+
+	return ret;
+  }
+
+  char LICENSE[] SEC("license") = "GPL";
+
+Use bpftool to load the BPF program.
+
+::
+
+  $ bpftool prog load mtd-mchp23k256.o /sys/fs/bpf/mtd_mchp23k256 autoattach
+
+Create the mchp23k256 device, this is accomplished by executing the
+following command:
+
+::
+
+  $ mkdir /sys/kernel/config/spi-mockup/spi0/targets/mchp23k256
+  $ echo -n mchp23k256 > /sys/kernel/config/spi-mockup/spi0/targets/mchp23k256/device_id
+  $ echo 1 > /sys/kernel/config/spi-mockup/spi0/targets/mchp23k256/live
+
+
+Now, the mchp23k256 MTD device named /dev/mtd0 has been created successfully.
+
+::
+
+  $ ls /sys/bus/spi/devices/spi0.0/mtd/
+  mtd0  mtd0ro
+
+  $ cat /sys/class/mtd/mtd0/name
+  spi0.0
+
+  $ hexdump /dev/mtd0
+  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  0008000
+
+  $ echo aaaa > /dev/mtd0
+
+  $ hexdump /dev/mtd0
+  00000000  61 61 61 61 0a 00 00 00  00 00 00 00 00 00 00 00  |aaaa............|
+  00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+  *
+  00008000
+
+  $ bpftool map update name regs_mchp23k256 key 0 0 0 0 value 0
+
+  $ hexdump /dev/mtd0
+  00000000  00 61 61 61 0a 00 00 00  00 00 00 00 00 00 00 00  |.aaa............|
+  00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+  *
+  00008000
+
+
+Remove the mchp23k256 device by executing the following command:
+
+::
+
+  $ echo 0 > /sys/kernel/config/spi-mockup/spi0/targets/mchp23k256/live
+  $ rmdir /sys/kernel/config/spi-mockup/spi0/targets/mchp23k256
+
+Remove the spi mockup controller by executing the following command:
+
+::
+
+  $ echo 0 > /sys/kernel/config/spi-mockup/spi0/live
+  $ rmdir /sys/kernel/config/spi-mockup/spi0
-- 
2.34.1


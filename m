Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED17E0E20
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjKDGrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjKDGr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:47:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82309D52;
        Fri,  3 Nov 2023 23:47:24 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SMp7q2HGdz4f3kJs;
        Sat,  4 Nov 2023 14:47:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 820631A0171;
        Sat,  4 Nov 2023 14:47:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd3z6EVlglQtEw--.50758S9;
        Sat, 04 Nov 2023 14:47:21 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 -next 5/5] spi: mockup: Add documentation
Date:   Sat,  4 Nov 2023 14:46:50 +0800
Message-Id: <20231104064650.972687-6-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd3z6EVlglQtEw--.50758S9
X-Coremail-Antispam: 1UD129KBjvJXoW3JryxuF18tF43Ar1kArWrZrb_yoW7Aw4fpF
        WUtry3K3y8Xr9rWF1fXa4kJFy3A3s7Zay7GFWvgF1Yyr1qvr95JF1xKryYq3Z8WF4kAFy0
        vFW5AFW8Kr17ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7IU1FfO7UUUUU==
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

Add documentation for the SPI mockup controller driver.
This include the tutorial for how to mockup a spi device.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 Documentation/spi/index.rst      |   1 +
 Documentation/spi/spi-mockup.rst | 196 +++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
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
index 000000000000..dd9feb81535e
--- /dev/null
+++ b/Documentation/spi/spi-mockup.rst
@@ -0,0 +1,196 @@
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
+        1. load EBPF program as device's backend
+        2. create target chip device
+
+Example
+=======
+
+This example show how to mock a MTD device by using spi-mockup driver.
+
+Compile your copy of the kernel source. Make sure to configure the spi-mockup
+and the target chip driver as a module.
+
+Register the spi mockup device.
+
+::
+
+  $ mkdir /sys/kernel/config/spi-mockup/spi0
+
+  # configure the spi mockup attribute
+  $ echo 40000 > /sys/kernel/config/spi-mockup/spi0/min_speed
+  $ echo 25000000 > /sys/kernel/config/spi-mockup/spi0/max_speed
+  $ echo 0 > /sys/kernel/config/spi-mockup/spi0/flags
+  $ echo 8 > /sys/kernel/config/spi-mockup/spi0/num_cs
+
+  # enable the spi mockup device
+  $ echo 1 > /sys/kernel/config/spi-mockup/spi0/enable
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
+
+This is accomplished by executing the following command:
+
+::
+
+  $ echo mchp23k256 0 > /sys/class/spi_master/spi0/new_device
+
+
+The name of the target driver and its chip select were used to instantiate
+the device.
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
+  $echo aaaa > /dev/mtd0
+
+  $ hexdump /dev/mtd0
+  0000000 6161 6161 000a 0000 0000 0000 0000 0000
+  0000010 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  0008000
+
+  $ bpftool map update name regs_mchp23k256 key 0 0 0 0 value 0
+
+  $ hexdump /dev/mtd0
+  0000000 6100 6161 000a 0000 0000 0000 0000 0000
+  0000010 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  0008000
+
+Remove the mockup device by executing the following command:
+
+::
+
+  $ echo 0 > /sys/class/spi_master/spi0/delete_device
+
+Remove the spi mockup device by executing the following command:
+
+::
+
+  $ echo 0 > /sys/kernel/config/spi-mockup/spi0/disable
+  $ rmdir /sys/kernel/config/spi-mockup/spi0
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8493D7EFF12
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjKRKmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjKRKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:45 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FD4D72;
        Sat, 18 Nov 2023 02:41:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgf5LYLz4f3lWF;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id D9E201A0169;
        Sat, 18 Nov 2023 18:41:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S18;
        Sat, 18 Nov 2023 18:41:38 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 14/14] kddv: Add document for kddv
Date:   Sat, 18 Nov 2023 18:40:40 +0800
Message-Id: <20231118104040.386381-15-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S18
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487M2AExVAIFx
        02aVAFz4v204v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4kE6I8I3I0E14AKx2xKxVC2ax8xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr0_Jr4lx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
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

This add documentation for the kddv, include the design principles,
how to run the testcases, and how to contribute new testcases

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu@huawei.com>
---
 Documentation/dev-tools/index.rst |   1 +
 Documentation/dev-tools/kddv.rst  | 183 ++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100755 Documentation/dev-tools/kddv.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 6b0663075dc0..ef8203db8fd7 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -34,6 +34,7 @@ Documentation/dev-tools/testing-overview.rst
    kselftest
    kunit/index
    ktap
+   kddv
 
 
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/kddv.rst b/Documentation/dev-tools/kddv.rst
new file mode 100755
index 000000000000..9a031448312a
--- /dev/null
+++ b/Documentation/dev-tools/kddv.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright(c) 2022 Huawei Technologies Co., Ltd.
+
+Kernel Device Driver Verification (KDDV)
+========================================
+
+The kernel code contains a large amount of driver code which
+depends on specific hardware. As a result, the test of this part
+of code is difficult. Due to resource limitations, common detection
+methods such as KASAN are difficult to deploy. Therefore, a test
+method independent of physical hardware is required.
+
+Generally, the driver reads related information from the physical
+hardware by calling a specific function. Then the driver code can
+be tested by mocking the specific function to simulate physical
+hardware behavior by returning virtual values.
+
+With the development of eBPF, it is possible to mock a specific
+function based on the eBPF TracePoint mechanism, and then use
+eBPF to simulate physical hardware.
+
+Based on the python unittests framework, KDDV mounts devices to
+virtual buses and simulates hardware behaviors through the ebpf
+program to test specific driver functions. In addition, KDDV supports
+fault injection to simulate exceptions, verify that the driver
+behaves properly.
+
+
+Design principles
+-----------------
+
+The driver can register these device to the mock bus, it can be interacts
+with bpf program, then the physical hardware can be mocked by bpf.
+
+::
+
+    __________________________________       _______________________________
+    |User Program                    |       | Linux kernel                |
+    |                                |       |                             |
+    |                                |       |                             |
+    |            _________________   | load  |    _____________      _____ |
+    |llvm -----> | eBPF bytecode |  -|-------|--> | Verifier  |      | M | |
+    |            ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   |       |    ¯¯¯¯¯¯¯¯¯¯¯¯¯      | O | |
+    |                                |       |                       | C | |
+    |                                |       |    _____________      | K | |
+    |                                |       |    |   eBPF    | <--> |   | |
+    |                                |       |    ¯¯¯¯¯¯¯¯¯¯¯¯¯      | B | |
+    |            _______________     | read  |    _____________      | U | |
+    |bpftool --> | Access Regs | ----|-------|--> | eBPF Maps |      | S | |
+    |            ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯     | write |    ¯¯¯¯¯¯¯¯¯¯¯¯¯      ¯¯¯¯¯ |
+    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯       ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
+
+
+
+Running the KDDV
+----------------
+
+The kddv depends on the mock bus, should configure kernel as below::
+
+    CONFIG_SPI_MOCK=y
+    ...
+
+To build the tests::
+
+  $ make -C tools/testing/kddv/
+
+To install kddv in a user specified location::
+
+   $ make -C tools/testing/selftests install INSTALL_PATH=/some/other/path
+
+To run the tests::
+
+  $ cd /some/other/path
+  $ python3 -m kddv.cmds.test
+
+More useful info can be got from the help::
+
+  $ python3 -m kddv.cmds.test --help
+
+
+Contributing new tests
+----------------------
+
+Test file placement
+~~~~~~~~~~~~~~~~~~~
+
+The directory structure is as below::
+
+        tools/testing/kddv/kddv
+        ├── cmds  # Python unittests command line
+        ├── core  # General data structure of the kddv
+        ├── data  # Extra data, eg: bpf program
+        │   ├── bpf
+        │   │   ├── include
+        │   │   │   └── bpf-xfer-conf.h
+        │   │   ├── Makefile
+        │   │   ├── mtd
+        │   │   │   └── mtd-mchp23k256.c
+        │   │   └── spi
+        │   └── Makefile
+        ├── tests  # KDDV testcases
+        │   ├── __init__.py
+        │   ├── hwmon
+        │   │   ├── __init__.py
+        │   │   └── test_max31722.py
+        │   └── mtd
+        │       ├── __init__.py
+        │       └── test_mchp23k256.py
+        ├── __init__.py
+        └── Makefile
+
+If you want to add a new testcase to kddv, you should:
+  1. add the python unittests to the **tests** directory.
+  2. add the bpf program to the **data/bpf** directory.
+
+Basic example
+~~~~~~~~~~~~~
+
+The kddv based on python unittests, it provides a set of tools for write
+the testcase, here is a basic example for test some feature of mchp23k256
+mtd device::
+
+  from kddv.core import SPIDriverTest
+  from . import MTDDriver
+
+  MCHP23K256_TEST_DATA = [0x78] * 16
+
+  class TestMCHP23K256(SPIDriverTest, MTDDriver):
+      name = "mchp23k256"
+
+      @property
+      def bpf(self):
+          return f"mtd-{self.name}"
+
+      def test_device_probe(self):
+          with self.assertRaisesFault():
+              with self.device() as _:
+                  pass
+
+      def test_device_size(self):
+          with self.device() as dev:
+              size = self.mtd_read_attr(dev, 'size')
+              self.assertEqual(size, '32768')
+
+      def test_read_data(self):
+          with self.device() as dev:
+              self.write_regs(0x00, MCHP23K256_TEST_DATA)
+              data = self.mtd_read_bytes(dev, 16)
+              self.assertEqual(data, bytes(MCHP23K256_TEST_DATA))
+
+      def test_write_data(self):
+          with self.device() as dev:
+              self.write_regs(0x00, [0] * 16)
+              self.mtd_write_bytes(dev, bytes(MCHP23K256_TEST_DATA))
+              self.assertRegsEqual(0x00, MCHP23K256_TEST_DATA)
+
+**SPIDriverTest** provides the basic functions for SPI driver, such as
+loading the driver, read/write SPI registers.
+
+**MTDDriver** provides some basic function for MTD driver, such as get the
+mtd device info, read/write data from mtd device.
+
+Since the mchp23k256 is a mtd driver based on SPI bus, so **TestMCHP23K256**
+inherited from **SPIDriverTest** and **MTDDriver**.
+
+There are 4 testcases for mchp23k256 basic function:
+  1. driver and device can be loading successfully;
+  2. the device size should be 32k as the default;
+  3. read data from device, the data should be equal with the regs;
+  4. write data to device, the regs should be equal with the data;
+
+The above script produces an output that looks like this::
+
+  $ python3 -m kddv.cmds.test kddv.tests.mtd.test_mchp23k256
+  test_device_probe (kddv.tests.mtd.test_mchp23k256.TestMCHP23K256) ... ok
+  test_device_size (kddv.tests.mtd.test_mchp23k256.TestMCHP23K256) ... ok
+  test_read_data (kddv.tests.mtd.test_mchp23k256.TestMCHP23K256) ... ok
+  test_write_data (kddv.tests.mtd.test_mchp23k256.TestMCHP23K256) ... ok
+
+  ----------------------------------------------------------------------
+  Ran 4 tests in 36.100s
+
+  OK
-- 
2.34.1


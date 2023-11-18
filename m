Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4967EFF0C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjKRKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjKRKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:42 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937B10DC;
        Sat, 18 Nov 2023 02:41:38 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SXVgf5xsGz4f3kFf;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 55D731A01A1;
        Sat, 18 Nov 2023 18:41:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S11;
        Sat, 18 Nov 2023 18:41:36 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 07/14] kddv/cmd: Add command to create/remove mockup device
Date:   Sat, 18 Nov 2023 18:40:33 +0800
Message-Id: <20231118104040.386381-8-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S11
X-Coremail-Antispam: 1UD129KBjvJXoWxtF47Xr1xKr47Zw45tw18Krg_yoW7uF18pa
        1rGa1Uur48ur15Krn5ZryjqrWrXr4kCFWFgr1xZr12grnxCr95GrWxta4Yq343W3WrJFWS
        vFykuw10kr1UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
        VFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
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

Add command kddv.cmds.mock to create/remove mockup device which support
by the test framework. Usage:

Create device:
  $ python3 -m kddv.cmds.mock --bus spi --devid mchp23k256
  create spi device mchp23k256 success!

Then the mockup device can be accessed by exists user space tools.
  $ ls /dev/mtd0
  mtd0    mtd0ro
  $ hexdump /dev/mtd0
  0000000 0000 0000 0000 0000 0000 0000 0000 0000
  *
  0008000

Remove the mockup device:
 $ python3 -m kddv.cmds.mock --bus spi --devid mchp23k256 -r
 [  198.718172] Deleting MTD partitions on "spi0.0":
 remove spi device mchp23k256 success!

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/kddv/Makefile         |   1 +
 tools/testing/kddv/kddv/cmds/__init__.py |   0
 tools/testing/kddv/kddv/cmds/mock.py     | 105 +++++++++++++++++++++++
 tools/testing/kddv/kddv/cmds/utils.py    |  28 ++++++
 4 files changed, 134 insertions(+)
 create mode 100755 tools/testing/kddv/kddv/cmds/__init__.py
 create mode 100755 tools/testing/kddv/kddv/cmds/mock.py
 create mode 100755 tools/testing/kddv/kddv/cmds/utils.py

diff --git a/tools/testing/kddv/kddv/Makefile b/tools/testing/kddv/kddv/Makefile
index a68112154669..a5c91fcb0e9a 100644
--- a/tools/testing/kddv/kddv/Makefile
+++ b/tools/testing/kddv/kddv/Makefile
@@ -12,6 +12,7 @@ install:
 	$(INSTALL) -m 0755 -d $(INSTALL_PATH)
 	$(INSTALL) __init__.py $(INSTALL_PATH)
 	cp -rf core/ $(INSTALL_PATH)
+	cp -rf cmds/ $(INSTALL_PATH)
 	cp -rf tests/ $(INSTALL_PATH)
 
 clean:
diff --git a/tools/testing/kddv/kddv/cmds/__init__.py b/tools/testing/kddv/kddv/cmds/__init__.py
new file mode 100755
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/kddv/kddv/cmds/mock.py b/tools/testing/kddv/kddv/cmds/mock.py
new file mode 100755
index 000000000000..2ec5e45219a0
--- /dev/null
+++ b/tools/testing/kddv/kddv/cmds/mock.py
@@ -0,0 +1,105 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import os
+import sys
+import logging
+import argparse
+import unittest
+import subprocess
+
+from kddv.core.mockup import Mockup
+from kddv.core.ddunit import DriverTest
+from kddv.core.buses import *
+from . import utils
+
+ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
+
+logger = logging.getLogger()
+
+def search(suite, bus: str, devid: str):
+    mdrv = None
+    for t in suite:
+        if isinstance(t, unittest.TestSuite):
+            driver = search(t, bus, devid)
+            if driver:
+                if driver.device_id == devid:
+                    return driver
+                mdrv = driver
+        elif isinstance(t, DriverTest):
+            if not hasattr(t, 'bus') or not hasattr(t, 'device_id'):
+                logger.debug(f"not a driver test case: {t}")
+                continue
+            if t.bus != bus:
+                continue
+            if t.device_id == devid:
+                return t
+            if  t.driver_name == devid:
+                mdrv = t
+        else:
+            return mdrv
+
+def do_mockup_device(t):
+    mock = Mockup.create(t.bus, t)
+    try:
+        subprocess.check_output(
+            ["/sbin/modprobe", t.module_name], stderr=subprocess.STDOUT
+        )
+    except:
+        logger.warning(f"Module {t.module_name} not found")
+        sys.exit(1)
+
+    mock.load()
+    logger.warning(f"create {t.bus} device {t.device_id} success!")
+
+def do_remove_device(t):
+    mock = Mockup.create(t.bus, t)
+    try:
+        mock.unload()
+        logger.warning(f"remove {t.bus} device {t.device_id} success!")
+    except:
+        logger.warning(f"{t.bus} device {t.device_id} not found")
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument(
+        "--bus", "-b", type=str, required=True,
+        choices=["i2c", "spi", "pci", "platform"], help="Bus Types"
+    )
+    parser.add_argument(
+        "--devid", "-d", type=str, required=True, help="Device ID"
+    )
+    parser.add_argument(
+        "--log-level", "-l", type=str, default=None,
+        choices=utils.LOG_LEVELS, help="Log level"
+    )
+    parser.add_argument(
+        "--remove", "-r", action='store_true', default=False,
+        help="Remove device",
+    )
+    args = parser.parse_args()
+
+    if args.log_level:
+        utils.setup_logger(args.log_level)
+
+    loader = unittest.defaultTestLoader
+    suites = loader.discover(os.path.join(ROOT_DIR, 'tests'))
+    driver = search(suites, args.bus, args.devid)
+    if driver is None:
+        logger.error(f"{args.bus} device {args.devid} not support")
+        sys.exit(1)
+
+    if not args.remove:
+        do_mockup_device(driver)
+    else:
+        do_remove_device(driver)
+
+    sys.exit(0)
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/kddv/kddv/cmds/utils.py b/tools/testing/kddv/kddv/cmds/utils.py
new file mode 100755
index 000000000000..8130d7a57a36
--- /dev/null
+++ b/tools/testing/kddv/kddv/cmds/utils.py
@@ -0,0 +1,28 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel device driver verification
+#
+# Copyright (C) 2022-2023 Huawei Technologies Co., Ltd
+# Author: Wei Yongjun <weiyongjun1@huawei.com>
+
+import sys
+import logging
+
+logger = logging.getLogger()
+
+LOG_FORMAT = "%(asctime)-15s [%(levelname)-7s] %(message)s"
+LOG_LEVELS = {
+    'ERROR': logging.ERROR,
+    'WARN': logging.WARN,
+    'INFO': logging.INFO,
+    'DEBUG': logging.DEBUG
+}
+
+def setup_logger(level):
+    logger.setLevel(LOG_LEVELS.get(level))
+    handler = logging.StreamHandler(sys.stdout)
+    handler.setFormatter(logging.Formatter(
+        fmt=LOG_FORMAT, datefmt="%Y-%m-%d %H:%M:%S"
+    ))
+    logger.addHandler(handler)
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28D7EFEFC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjKRKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjKRKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:41 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031BED75;
        Sat, 18 Nov 2023 02:41:36 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SXVgc2NmHz4f3jMP;
        Sat, 18 Nov 2023 18:41:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id CF75C1A0175;
        Sat, 18 Nov 2023 18:41:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S4;
        Sat, 18 Nov 2023 18:41:33 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 00/14] Implement a ligth weight device driver test framework
Date:   Sat, 18 Nov 2023 18:40:26 +0800
Message-Id: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKry3tw4DWr17WFW3Zr18Zrb_yoWxKF43pF
        WrJ347Wa1UCF1ftrs5tF4jqFWrXw4kWF4Fkr1IqryxWr93Kr1rCrW2k3WYqF9xua1FqrZ5
        Aw109ryUCw1UXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu@huawei.com>

Implement a ligth weight device driver test framework, KDDV(Kernel
Device Driver Verification). Which using eBPF based bus controllers
to mockup device chipsets.

The kddv already discover the following issues:
  fc92d9e3de0b iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw
  58143c1ed588 iio: health: afe4403: Fix oob read in afe4403_read_raw
  3f4033a811bc iio: filter: admv8818: close potential out-of-bounds read in __admv8818_read_[h|l]pf_freq()
  8c9a59939deb Input: raydium_ts_i2c - fix memory leak in raydium_i2c_send()
  7485edb2b6ca media: i2c: ov772x: Fix memleak in ov772x_probe()
  bab76514aca3 regulator: da9121: Fix uninit-value in da9121_assign_chip_model()
  9d47e01b9d80 power: supply: adp5061: fix out-of-bounds read in adp5061_get_chg_type()
  ...

Zhang Xiaoxu (14):
  kddv/core: Implement a ligth weight device driver test framework
  kddv/core: Allow test case config bpf program
  kddv/core: Add io fault support to bpf program
  kddv/core: Check kmsg before return from test case
  kddv/core: Support kernel memory leak detector
  kddv/core: Add page and slab fault inject support
  kddv/cmd: Add command to create/remove mockup device
  kddv/cmd: Add command to run testcases
  kddv/core: Add test support for SPI driver
  kddv/tests: Add support for testing hwmon driver
  kddv/tests/hwmon: Add test cases for max31722 driver
  kddv/tests: Add support for testing mtd driver
  kddv/tests/mtd: Add test cases for mchp23k256 driver
  kddv: Add document for kddv

 Documentation/dev-tools/index.rst             |   1 +
 Documentation/dev-tools/kddv.rst              | 183 ++++++++
 tools/testing/kddv/.gitignore                 |   3 +
 tools/testing/kddv/Makefile                   |  25 ++
 tools/testing/kddv/kddv/Makefile              |  28 ++
 tools/testing/kddv/kddv/__init__.py           |   0
 tools/testing/kddv/kddv/cmds/__init__.py      |   0
 tools/testing/kddv/kddv/cmds/mock.py          | 105 +++++
 tools/testing/kddv/kddv/cmds/test.py          |  75 ++++
 tools/testing/kddv/kddv/cmds/utils.py         |  28 ++
 tools/testing/kddv/kddv/core/__init__.py      |  13 +
 .../testing/kddv/kddv/core/buses/__init__.py  |  13 +
 tools/testing/kddv/kddv/core/buses/spi.py     |  74 +++
 tools/testing/kddv/kddv/core/consts.py        |  13 +
 tools/testing/kddv/kddv/core/ddunit.py        |  83 ++++
 tools/testing/kddv/kddv/core/device.py        |  78 ++++
 tools/testing/kddv/kddv/core/dmesg.py         |  41 ++
 tools/testing/kddv/kddv/core/driver.py        |  82 ++++
 tools/testing/kddv/kddv/core/environ.py       |  65 +++
 tools/testing/kddv/kddv/core/failnth.py       |  57 +++
 tools/testing/kddv/kddv/core/faulter.py       |  48 ++
 .../testing/kddv/kddv/core/faults/__init__.py |  13 +
 tools/testing/kddv/kddv/core/faults/fail.py   |  86 ++++
 tools/testing/kddv/kddv/core/faults/page.py   |  40 ++
 tools/testing/kddv/kddv/core/faults/slab.py   |  36 ++
 tools/testing/kddv/kddv/core/memleak.py       |  39 ++
 tools/testing/kddv/kddv/core/mockup.py        | 193 ++++++++
 tools/testing/kddv/kddv/core/model.py         |  95 ++++
 tools/testing/kddv/kddv/data/Makefile         |  21 +
 tools/testing/kddv/kddv/data/bpf/Makefile     |  22 +
 .../kddv/data/bpf/include/bpf-xfer-conf.h     | 124 +++++
 .../kddv/kddv/data/bpf/mtd/mtd-mchp23k256.c   |  72 +++
 .../kddv/kddv/data/bpf/spi/spi-xfer-base.h    |  99 ++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r1v1.c    |  51 +++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r1v2.c    |  51 +++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r1v3.c    |  86 ++++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r2v1.c    |  51 +++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r2v2.c    |  51 +++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r3v1.c    |  52 +++
 .../kddv/kddv/data/bpf/spi/spi-xfer-r4v4.c    |  89 ++++
 tools/testing/kddv/kddv/tests/__init__.py     |   0
 .../testing/kddv/kddv/tests/hwmon/__init__.py | 425 ++++++++++++++++++
 .../kddv/kddv/tests/hwmon/test_max31722.py    |  40 ++
 tools/testing/kddv/kddv/tests/mtd/__init__.py |  63 +++
 .../kddv/kddv/tests/mtd/test_mchp23k256.py    |  41 ++
 45 files changed, 2855 insertions(+)
 create mode 100755 Documentation/dev-tools/kddv.rst
 create mode 100644 tools/testing/kddv/.gitignore
 create mode 100644 tools/testing/kddv/Makefile
 create mode 100644 tools/testing/kddv/kddv/Makefile
 create mode 100755 tools/testing/kddv/kddv/__init__.py
 create mode 100755 tools/testing/kddv/kddv/cmds/__init__.py
 create mode 100755 tools/testing/kddv/kddv/cmds/mock.py
 create mode 100755 tools/testing/kddv/kddv/cmds/test.py
 create mode 100755 tools/testing/kddv/kddv/cmds/utils.py
 create mode 100755 tools/testing/kddv/kddv/core/__init__.py
 create mode 100755 tools/testing/kddv/kddv/core/buses/__init__.py
 create mode 100755 tools/testing/kddv/kddv/core/buses/spi.py
 create mode 100755 tools/testing/kddv/kddv/core/consts.py
 create mode 100755 tools/testing/kddv/kddv/core/ddunit.py
 create mode 100755 tools/testing/kddv/kddv/core/device.py
 create mode 100755 tools/testing/kddv/kddv/core/dmesg.py
 create mode 100755 tools/testing/kddv/kddv/core/driver.py
 create mode 100755 tools/testing/kddv/kddv/core/environ.py
 create mode 100755 tools/testing/kddv/kddv/core/failnth.py
 create mode 100755 tools/testing/kddv/kddv/core/faulter.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/__init__.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/fail.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/page.py
 create mode 100755 tools/testing/kddv/kddv/core/faults/slab.py
 create mode 100755 tools/testing/kddv/kddv/core/memleak.py
 create mode 100755 tools/testing/kddv/kddv/core/mockup.py
 create mode 100755 tools/testing/kddv/kddv/core/model.py
 create mode 100644 tools/testing/kddv/kddv/data/Makefile
 create mode 100644 tools/testing/kddv/kddv/data/bpf/Makefile
 create mode 100644 tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h
 create mode 100644 tools/testing/kddv/kddv/data/bpf/mtd/mtd-mchp23k256.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-base.h
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v1.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v2.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r1v3.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v1.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r2v2.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r3v1.c
 create mode 100644 tools/testing/kddv/kddv/data/bpf/spi/spi-xfer-r4v4.c
 create mode 100755 tools/testing/kddv/kddv/tests/__init__.py
 create mode 100755 tools/testing/kddv/kddv/tests/hwmon/__init__.py
 create mode 100755 tools/testing/kddv/kddv/tests/hwmon/test_max31722.py
 create mode 100644 tools/testing/kddv/kddv/tests/mtd/__init__.py
 create mode 100755 tools/testing/kddv/kddv/tests/mtd/test_mchp23k256.py

-- 
2.34.1


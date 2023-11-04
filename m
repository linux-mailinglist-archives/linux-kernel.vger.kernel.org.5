Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC707E0E1C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjKDGra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKDGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:47:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453FD45;
        Fri,  3 Nov 2023 23:47:23 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SMp7n46ZMz4f3k6V;
        Sat,  4 Nov 2023 14:47:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id C41151A0170;
        Sat,  4 Nov 2023 14:47:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd3z6EVlglQtEw--.50758S4;
        Sat, 04 Nov 2023 14:47:19 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/5] spi: Introduce BPF based SPI mockup controller
Date:   Sat,  4 Nov 2023 14:46:45 +0800
Message-Id: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd3z6EVlglQtEw--.50758S4
X-Coremail-Antispam: 1UD129KBjvdXoWrurykXr4fZFWUArWkZw1fZwb_yoWkKwbEyr
        47Aryvgr4UJa4fCFW2vr18ZFy2vF4fWr1vvFn8trZrXa9rZw47Kw1kJryqyF4UCa1DZr13
        XFn7XrWkAr13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
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

v2->v3:
  Add configfs to configure and register the device;
  Fix some misspelling.

v1->v2:
  Use the new _controller() API
  P1. Move the license identifier to the entrie comment
  P2. Inherit tx_nbits/rx_nbits/cs_off/cs_change from the
      spi_transfer to the tracepoint
  P3. Removed.
  P4. Update the Document.

Zhang Xiaoxu (5):
  spi: mockup: Add SPI controller testing driver
  spi: mockup: Add writeable tracepoint for spi transfer
  spi: mockup: Add support register the device through configfs
  spi: mockup: Add speed and flags attribute support
  spi: mockup: Add documentation

 Documentation/spi/index.rst       |   1 +
 Documentation/spi/spi-mockup.rst  | 196 ++++++++++++
 drivers/spi/Kconfig               |  13 +
 drivers/spi/Makefile              |   1 +
 drivers/spi/spi-mockup.c          | 474 ++++++++++++++++++++++++++++++
 include/linux/spi/spi-mockup.h    |  17 ++
 include/trace/events/spi_mockup.h |  31 ++
 7 files changed, 733 insertions(+)
 create mode 100644 Documentation/spi/spi-mockup.rst
 create mode 100644 drivers/spi/spi-mockup.c
 create mode 100644 include/linux/spi/spi-mockup.h
 create mode 100644 include/trace/events/spi_mockup.h

-- 
2.34.1


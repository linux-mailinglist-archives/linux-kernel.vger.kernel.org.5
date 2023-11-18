Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4C7EFF17
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjKRKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:45:33 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396DD10DA;
        Sat, 18 Nov 2023 02:45:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SXVm60rZSz4f3kFd;
        Sat, 18 Nov 2023 18:45:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 9B9D71A0175;
        Sat, 18 Nov 2023 18:45:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhDClVhlAjMGBQ--.58652S4;
        Sat, 18 Nov 2023 18:45:27 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huawecloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 -next 0/4] spi: Introduce BPF based SPI mockup controller
Date:   Sat, 18 Nov 2023 18:44:38 +0800
Message-Id: <20231118104442.861759-1-zhangxiaoxu@huawecloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhDClVhlAjMGBQ--.58652S4
X-Coremail-Antispam: 1UD129KBjvJXoWrur45KFW5CryDZF15uryDKFg_yoW8JryUpF
        1kJF13t3ykJrZI9F1fCa4UGFy3Aa4xurWUKa42qw1Fyr9akFyrAw4DKr1Yy3WfJFs7tFyU
        Zry2kr95KF1UZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0E
        Y4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMI
        IF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
        z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UG2NtUUUUU=
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

From: Zhang Xiaoxu <zhangxiaoxu@huawe.com>

v3->v4:
  Use configfs to register the controller and target
  Modify with the comments from Mark Brown

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

Zhang Xiaoxu (4):
  spi: mockup: Add SPI controller testing driver
  spi: mockup: Add register spi device support
  spi: mockup: Add writeable tracepoint for spi transfer
  spi: mockup: Add documentation

 Documentation/spi/index.rst       |   1 +
 Documentation/spi/spi-mockup.rst  | 198 +++++++++++
 drivers/spi/Kconfig               |  12 +
 drivers/spi/Makefile              |   1 +
 drivers/spi/spi-mockup.c          | 562 ++++++++++++++++++++++++++++++
 include/linux/spi/spi-mockup.h    |  17 +
 include/trace/events/spi_mockup.h |  31 ++
 7 files changed, 822 insertions(+)
 create mode 100644 Documentation/spi/spi-mockup.rst
 create mode 100644 drivers/spi/spi-mockup.c
 create mode 100644 include/linux/spi/spi-mockup.h
 create mode 100644 include/trace/events/spi_mockup.h

-- 
2.34.1


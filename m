Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C695B762CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjGZHOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGZHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:14:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B52722;
        Wed, 26 Jul 2023 00:10:32 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9lQ72P5WzrSBn;
        Wed, 26 Jul 2023 15:09:35 +0800 (CST)
Received: from china (10.175.101.107) by dggpeml100024.china.huawei.com
 (7.185.36.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 15:10:28 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <broonie@kernel.org>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <frowand.list@gmail.com>
CC:     <zhangxiaoxu5@huawei.com>, <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v2 -next 0/3] spi: Introduce BPF based SPI mockup controller
Date:   Wed, 26 Jul 2023 15:08:46 +0000
Message-ID: <20230726150849.28407-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.107]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series Introduce a BPF based SPI mockup controller, which can be
used for testing SPI drivers without real device.

The testsuite for SPI drivers will be post in other series, with also
support for I2C and PCI bus device drivers.

patch 1-2 introduce BPF based SPI mockup controller
patch 3 add the document

v1->v2:
  Use the new _controller() API
  P1. Move the license identifier to the entrie comment
  P2. Inherit tx_nbits/rx_nbits/cs_off/cs_change from the
      spi_transfer to the tracepoint
  P3. Removed.
  P4. Update the Document.

Wei Yongjun (3):
  spi: mockup: Add SPI controller testing driver
  spi: mockup: Add writeable tracepoint for spi transfer
  spi: mockup: Add documentation

 Documentation/spi/index.rst       |   1 +
 Documentation/spi/spi-mockup.rst  | 174 ++++++++++++++++++++
 drivers/spi/Kconfig               |  13 ++
 drivers/spi/Makefile              |   1 +
 drivers/spi/spi-mockup.c          | 260 ++++++++++++++++++++++++++++++
 include/linux/spi/spi-mockup.h    |  17 ++
 include/trace/events/spi_mockup.h |  31 ++++
 7 files changed, 497 insertions(+)
 create mode 100644 Documentation/spi/spi-mockup.rst
 create mode 100644 drivers/spi/spi-mockup.c
 create mode 100644 include/linux/spi/spi-mockup.h
 create mode 100644 include/trace/events/spi_mockup.h

-- 
2.34.1


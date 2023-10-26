Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1FE7D83AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjJZNfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZNfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:35:16 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 06:35:13 PDT
Received: from esa1.ltts.com (unknown [118.185.121.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76B718A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:35:13 -0700 (PDT)
IronPort-SDR: NPED9Wkhkyx+mUnpK3aL6xbX7ibR5C9UuIuPhve0uuuiwyYUEikwGhgOk+I1o8c3S4pipZq4rc
 W9/nbv9pYegQ==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa1.ltts.com with ESMTP; 26 Oct 2023 19:04:03 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     linux-kernel@vger.kernel.org
Cc:     lee@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
Subject: [PATCH v1 0/3] TPS65224 PMIC driver
Date:   Thu, 26 Oct 2023 19:02:23 +0530
Message-Id: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_05,RCVD_IN_DNSWL_BLOCKED,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for TPS65224 PMIC in linux.
This patch set includes driver for core, i2c and pfsm.
The driver was tested on TI's custom AM62A EVM.

Gairuboina Sirisha (3):
  drivers: mfd: Add support for TPS65224
  drivers: mfd: Add support for TPS65224 i2c driver
  drivers: misc: Add support for TPS65224 pfsm driver

 drivers/mfd/Kconfig                |  19 +
 drivers/mfd/Makefile               |   2 +
 drivers/mfd/tps65224-core.c        | 291 ++++++++++++
 drivers/mfd/tps65224-i2c.c         | 245 ++++++++++
 drivers/misc/Kconfig               |  12 +
 drivers/misc/Makefile              |   1 +
 drivers/misc/tps65224-pfsm.c       | 290 ++++++++++++
 include/linux/mfd/tps65224.h       | 735 +++++++++++++++++++++++++++++
 include/uapi/linux/tps65224_pfsm.h |  36 ++
 9 files changed, 1631 insertions(+)
 create mode 100644 drivers/mfd/tps65224-core.c
 create mode 100644 drivers/mfd/tps65224-i2c.c
 create mode 100644 drivers/misc/tps65224-pfsm.c
 create mode 100644 include/linux/mfd/tps65224.h
 create mode 100644 include/uapi/linux/tps65224_pfsm.h

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6B7EF5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbjKQQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjKQQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:10:48 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03AA5;
        Fri, 17 Nov 2023 08:10:45 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGAAI7045761;
        Fri, 17 Nov 2023 10:10:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700237410;
        bh=oLLhtJhxQAFqHbCZM5lizNcfnfeWwgpcMTLdW/jSkO4=;
        h=From:To:CC:Subject:Date;
        b=VgVz23NORrnoA3crYVeSJ8pydzkjmqbPRIC+7R7VBVkWqFxo7T9nzH33NKUndYnsM
         /ob15zqTHsi9lQjCIFpQzX45MxACR08dc6d1gLK8rXaWQJxLpDt+IcBk+d/1karjVD
         BUdalXEgiMNp+h+2XV3izJlX5LbIwlSDvunhybuU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHGA9bT022438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 10:10:10 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 10:10:09 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 10:10:09 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGA8GJ004950;
        Fri, 17 Nov 2023 10:10:08 -0600
From:   Andrew Davis <afd@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 0/5] Deprecate register_restart_handler()
Date:   Fri, 17 Nov 2023 10:10:01 -0600
Message-ID: <20231117161006.87734-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Explanation is in patch #1.

The rest of this series is a set of representative examples of converting
away from the old API. They should be valid and can be taken by their
respective maintainers even if patch #1 doesn't find acceptance.

Thanks,
Andrew

Andrew Davis (5):
  kernel/reboot: Deprecate register_restart_handler()
  drivers/soc/litex: Use devm_register_restart_handler()
  power: reset: gpio-restart: Use devm_register_sys_off_handler()
  spi: sprd: adi: Use devm_register_restart_handler()
  firmware: psci: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)

 drivers/firmware/psci/psci.c       | 10 ++-------
 drivers/power/reset/gpio-restart.c | 34 ++++++++----------------------
 drivers/soc/litex/litex_soc_ctrl.c | 23 +++++---------------
 drivers/spi/spi-sprd-adi.c         | 30 +++++++-------------------
 include/linux/reboot.h             |  8 +++++--
 kernel/reboot.c                    |  3 +++
 6 files changed, 33 insertions(+), 75 deletions(-)

-- 
2.39.2


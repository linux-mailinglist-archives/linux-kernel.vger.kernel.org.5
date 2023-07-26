Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A2D762FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGZI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjGZI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:27:48 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E625FE1;
        Wed, 26 Jul 2023 01:17:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5498996|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.152403-0.00208636-0.845511;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.U0dHKiu_1690359429;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.U0dHKiu_1690359429)
          by smtp.aliyun-inc.com;
          Wed, 26 Jul 2023 16:17:18 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH V1 0/2] regulator: aw37503: add regulator driver for AWINIC AW37503
Date:   Wed, 26 Jul 2023 08:16:10 +0000
Message-ID: <20230726081612.586295-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alec Li <like@awinic.com>

Add regulator driver for the device AWINIC AW37503 which is single
inductor - dual output power supply device. AW37503 device is
designed to support general positive/negative driven applications
like TFT display panels.

Alec Li (2):
  regulator: aw37503: add regulator driver for AWINIC AW37503
  regulator: aw37503: add device-tree binding

 .../bindings/regulator/awinic,aw37503.yaml    |  73 ++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/aw37503-regulator.c         | 246 ++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
 create mode 100644 drivers/regulator/aw37503-regulator.c


base-commit: 18b44bc5a67275641fb26f2c54ba7eef80ac5950
-- 
2.41.0


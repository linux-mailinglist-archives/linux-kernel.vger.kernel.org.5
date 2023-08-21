Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EEB782206
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjHUDyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHUDyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:54:15 -0400
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686D8E;
        Sun, 20 Aug 2023 20:54:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.410237|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00758011-0.000204805-0.992215;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.ULtK3sr_1692590038;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.ULtK3sr_1692590038)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 11:54:05 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH v5 0/2] regulator: aw37503: add regulator driver for Awinic AW37503
Date:   Mon, 21 Aug 2023 03:53:53 +0000
Message-ID: <20230821035355.1269976-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alec Li <like@awinic.com>

Add regulator driver for the device Awinic AW37503 which is
single inductor - dual output power supply device. AW37503
device is designed to support general positive/negative
driven applications like TFT display panels.

v4->v5: Delete the unnecessary '|' in the awinic,aw37503.yaml.
v3->v4: Correct yamllint warnings/errors.
v2->v3: Switch to use the dev_err_probe().
        Keep the Kconfig and Makefile sorted.
        Correct yamllint warnings/errors.
v1->v2: Remove unneeded fields and correct yamllint warnings/errors.

Alec Li (2):
  regulator: aw37503: add regulator driver for Awinic AW37503
  regulator: dt-bindings: Add Awinic AW37503

 .../bindings/regulator/awinic,aw37503.yaml    |  78 ++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/aw37503-regulator.c         | 240 ++++++++++++++++++
 4 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
 create mode 100644 drivers/regulator/aw37503-regulator.c


base-commit: 706a741595047797872e669b3101429ab8d378ef
-- 
2.41.0


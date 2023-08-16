Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C677DBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbjHPISH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbjHPIRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:17:51 -0400
Received: from out28-117.mail.aliyun.com (out28-117.mail.aliyun.com [115.124.28.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F3C109;
        Wed, 16 Aug 2023 01:17:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6799061|-1;BR=01201311R981b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.052827-0.000469179-0.946704;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.UI3zGnY_1692173853;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.UI3zGnY_1692173853)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 16:17:41 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH v4 0/2] regulator: aw37503: add regulator driver for Awinic AW37503
Date:   Wed, 16 Aug 2023 08:17:26 +0000
Message-ID: <20230816081728.2812458-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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

v3->v4: Correct yamllint warnings/errors

Alec Li (2):
  regulator: aw37503: add regulator driver for Awinic AW37503
  regulator: dt-bindings: Add Awinic AW37503

 .../bindings/regulator/awinic,aw37503.yaml    |  80 ++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/aw37503-regulator.c         | 240 ++++++++++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
 create mode 100644 drivers/regulator/aw37503-regulator.c


base-commit: 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
-- 
2.41.0


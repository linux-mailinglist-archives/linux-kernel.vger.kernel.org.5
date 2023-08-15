Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D4E77C58C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjHOCBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjHOCBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:01:06 -0400
Received: from out28-134.mail.aliyun.com (out28-134.mail.aliyun.com [115.124.28.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44467B0;
        Mon, 14 Aug 2023 19:01:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6103465|-1;BR=01201311R221b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.0111616-0.000405834-0.988433;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.UGpC1Bd_1692064847;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.UGpC1Bd_1692064847)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 10:00:55 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH v3 0/2] regulator: aw37503: add regulator driver for Awinic AW37503
Date:   Tue, 15 Aug 2023 02:00:42 +0000
Message-ID: <20230815020044.2159900-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
	
v2->v3:Switch to use the dev_err_probe()
       Keep the Kconfig and Makefile sorted
       Correct yamllint warnings/errors

Alec Li (2):
  regulator: aw37503: add regulator driver for Awinic AW37503
  regulator: dt-bindings: Add Awinic AW37503

 .../bindings/regulator/awinic,aw37503.yaml    |  66 +++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/aw37503-regulator.c         | 240 ++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
 create mode 100644 drivers/regulator/aw37503-regulator.c


base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDB76FE70
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHDK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHDK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:27:32 -0400
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08A46B1;
        Fri,  4 Aug 2023 03:27:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2278946|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0050164-0.000137319-0.994846;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.U8So1Aj_1691144835;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.U8So1Aj_1691144835)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 18:27:23 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH v2 0/2] regulator: aw37503: add regulator driver for AWINIC AW37503
Date:   Fri,  4 Aug 2023 10:27:01 +0000
Message-ID: <20230804102703.931418-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alec Li <like@awinic.com>

v1->v2: Remove unneeded fields and correct yamllint warnings/errors.

Alec Li (2):
  regulator: aw37503: Remove unneeded fields and switch to using
    dev_err_probe()
  regulator: dt-bindings: Correct yamllint warnings/errors

 .../bindings/regulator/awinic,aw37503.yaml    |  65 +++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/aw37503-regulator.c         | 240 ++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
 create mode 100644 drivers/regulator/aw37503-regulator.c


base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
-- 
2.41.0


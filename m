Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D207C8364
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjJMKmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjJMKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:42:35 -0400
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D5BB;
        Fri, 13 Oct 2023 03:42:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.251197|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00428145-6.11179e-05-0.995657;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.V-L310G_1697193742;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V-L310G_1697193742)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 18:42:29 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, fido_max@inbox.ru,
        sebastian.reichel@collabora.com, colin.i.king@gmail.com,
        liweilei@awinic.com, trix@redhat.com, dan.carpenter@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V1 0/3] ASoC: codecs: Add aw88399 amplifier driver
Date:   Fri, 13 Oct 2023 18:42:17 +0800
Message-ID: <20231013104220.279953-1-wangweidong.a@awinic.com>
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

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88399 property to the awinic,aw88395.yaml file.

Add i2c and amplifier registration for
aw88399 and their associated operation functions.

Weidong Wang (3):
  ASoC: dt-bindings: Add schema for "awinic,aw88399"
  ASoC: codecs: Add code for bin parsing compatible with aw88399
  ASoC: codecs: Add aw88399 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    1 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88395/aw88395_lib.c        |    3 +
 sound/soc/codecs/aw88395/aw88395_reg.h        |    1 +
 sound/soc/codecs/aw88399.c                    | 1964 +++++++++++++++++
 sound/soc/codecs/aw88399.h                    |  615 ++++++
 7 files changed, 2600 insertions(+)
 create mode 100644 sound/soc/codecs/aw88399.c
 create mode 100644 sound/soc/codecs/aw88399.h


base-commit: ce583d5fb9d3f4e20473b9d5619d51ea3cc92283
-- 
2.41.0


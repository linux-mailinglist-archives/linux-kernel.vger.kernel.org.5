Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C837A605F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjISK6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjISK6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:58:20 -0400
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75241A8;
        Tue, 19 Sep 2023 03:57:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1125892|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0376402-0.000188823-0.962171;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Uj4ERce_1695121045;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Uj4ERce_1695121045)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 18:57:33 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com,
        shumingf@realtek.com, ryans.lee@analog.com, 13916275206@139.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        povik+lin@cutebit.org, harshit.m.mogalapalli@oracle.com,
        arnd@arndb.de, yijiangtao@awinic.com, yang.lee@linux.alibaba.com,
        liweilei@awinic.com, u.kleine-koenig@pengutronix.de,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/7] ASoC: codecs: Add aw87390 amplifier driver
Date:   Tue, 19 Sep 2023 18:57:17 +0800
Message-ID: <20230919105724.105624-1-wangweidong.a@awinic.com>
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

The awinic aw87390 is a new high efficiency, low noise,
constant large volume, 6th Smart K audio amplifier.

Add a DT schema for describing awinic aw87390 audio amplifiers.
They are controlled using I2C.

v3 -> v4: Divide the changes of aw88395 into multiple patches

Weidong Wang (7):
  ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA
    support
  ASoC: dt-bindings: Add schema for "awinic,aw87390"
  ASoC: codecs: Modify the transmission method of parameters and
    property node
  ASoC: codecs: Add code for bin parsing compatible with aw87390
  ASoC: codecs: Modify i2c name and parameter transmission methodls
  ASoC: codecs: Change the aw88261 variable name and i2c driver name
  ASoC: codecs: Add aw87390 amplifier driver

 .../bindings/sound/awinic,aw87390.yaml        |  58 +++
 .../bindings/sound/awinic,aw88395.yaml        |  16 +
 sound/soc/codecs/Kconfig                      |  15 +-
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/aw87390.c                    | 462 ++++++++++++++++++
 sound/soc/codecs/aw87390.h                    |  85 ++++
 sound/soc/codecs/aw88261.c                    |  27 +-
 sound/soc/codecs/aw88261.h                    |   4 +-
 sound/soc/codecs/aw88395/aw88395.c            |   9 +-
 sound/soc/codecs/aw88395/aw88395.h            |   2 +-
 sound/soc/codecs/aw88395/aw88395_device.c     |  47 +-
 sound/soc/codecs/aw88395/aw88395_device.h     |   6 +-
 sound/soc/codecs/aw88395/aw88395_lib.c        |  25 +-
 sound/soc/codecs/aw88395/aw88395_reg.h        |   1 +
 14 files changed, 686 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw87390.yaml
 create mode 100644 sound/soc/codecs/aw87390.c
 create mode 100644 sound/soc/codecs/aw87390.h


base-commit: 2cf0f715623872823a72e451243bbf555d10d032
-- 
2.41.0


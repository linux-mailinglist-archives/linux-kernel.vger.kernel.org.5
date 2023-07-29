Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3094767D88
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjG2JOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjG2JOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:14:05 -0400
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D54EE3;
        Sat, 29 Jul 2023 02:13:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1943245|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0227548-0.000323795-0.976921;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U3WkWdS_1690621946;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U3WkWdS_1690621946)
          by smtp.aliyun-inc.com;
          Sat, 29 Jul 2023 17:12:29 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru, povik+lin@cutebit.org,
        liweilei@awinic.com, yijiangtao@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
Subject: [PATCH V3 0/5] ASoC: codecs: Add awinic AW88261 audio amplifier driver
Date:   Sat, 29 Jul 2023 17:12:18 +0800
Message-ID: <20230729091223.193466-1-wangweidong.a@awinic.com>
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

From: Weidong Wang <wangweidong.a@awinic.com>

The awinic AW88261 is an I2S/TDM input, high efficiency
digital Smart K audio amplifier

v1 -> v2: Submit the yaml file as a separate patch file
          Modify word capitalization in the Kconfig file
          Delete unused macro definitions 

Weidong Wang (5):
  ASoC: dt-bindings: Add schema for "awinic,aw88261"
  ASoC: codecs: Add code for bin parsing compatible with aw88261
  ASoC: codecs: Add aw88261 amplifier driver
  ASoC: codecs: aw88261 device related operation functions
  ASoC: codecs: aw88261 chip register file, Kconfig and Makefile

 .../bindings/sound/awinic,aw88395.yaml        |   4 +-
 sound/soc/codecs/Kconfig                      |  15 +
 sound/soc/codecs/Makefile                     |   3 +
 sound/soc/codecs/aw88261/aw88261.c            | 517 +++++++++++
 sound/soc/codecs/aw88261/aw88261.h            |  52 ++
 sound/soc/codecs/aw88261/aw88261_device.c     | 877 ++++++++++++++++++
 sound/soc/codecs/aw88261/aw88261_device.h     |  79 ++
 sound/soc/codecs/aw88261/aw88261_reg.h        | 374 ++++++++
 sound/soc/codecs/aw88395/aw88395_lib.c        | 193 +++-
 sound/soc/codecs/aw88395/aw88395_reg.h        |   1 +
 10 files changed, 2097 insertions(+), 18 deletions(-)
 create mode 100644 sound/soc/codecs/aw88261/aw88261.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_reg.h


base-commit: ffabf7c731765da3dbfaffa4ed58b51ae9c2e650
-- 
2.41.0


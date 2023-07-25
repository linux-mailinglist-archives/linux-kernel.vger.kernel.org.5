Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D67617C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjGYL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGYL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:57:03 -0400
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB1710CB;
        Tue, 25 Jul 2023 04:57:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2463095|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0329975-0.000205957-0.966797;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U.y2wd._1690286211;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U.y2wd._1690286211)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 19:56:54 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        shumingf@realtek.com, wangweidong.a@awinic.com,
        povik+lin@cutebit.org, 13916275206@139.com,
        herve.codina@bootlin.com, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com,
        ajye_huang@compal.corp-partner.google.com,
        sebastian.reichel@collabora.com, yijiangtao@awinic.com,
        trix@redhat.com, colin.i.king@gmail.com, liweilei@awinic.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
Subject: [PATCH V2 0/4] ASoC: codecs: Add Awinic AW88261 audio amplifier driver
Date:   Tue, 25 Jul 2023 19:56:45 +0800
Message-ID: <20230725115649.67560-1-wangweidong.a@awinic.com>
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

v1 -> v2: Use dev_err_prober instead of dev_err
          Delete unwanted dev_dbg
          Delect print messages on allocation errors.
          The commit information has been changed
          Delete EXPORT_SYMBOL_GPL
          Modify {} usage errors
          The aw88395_lib file is compatible with the bin parsing part of aw88261

Weidong Wang (4):
  ASoC: codecs: Add code for bin parsing compatible with aw88261
  ASoC: codecs: Add aw88261 audio amplifier driver
  ASoC: codecs: aw88261 device related operation functions
  ASoC: codecs: aw88261 chip register file, Kconfig and Makefile

 .../bindings/sound/awinic,aw88395.yaml        |   4 +-
 sound/soc/codecs/Kconfig                      |  13 +
 sound/soc/codecs/Makefile                     |   3 +
 sound/soc/codecs/aw88261/aw88261.c            | 517 +++++++++++
 sound/soc/codecs/aw88261/aw88261.h            |  52 ++
 sound/soc/codecs/aw88261/aw88261_device.c     | 876 ++++++++++++++++++
 sound/soc/codecs/aw88261/aw88261_device.h     |  79 ++
 sound/soc/codecs/aw88261/aw88261_reg.h        | 377 ++++++++
 sound/soc/codecs/aw88395/aw88395_lib.c        | 194 +++-
 sound/soc/codecs/aw88395/aw88395_reg.h        |   1 +
 10 files changed, 2098 insertions(+), 18 deletions(-)
 create mode 100644 sound/soc/codecs/aw88261/aw88261.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_reg.h


base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
-- 
2.41.0


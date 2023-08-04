Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5A76FFA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHDLsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHDLsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:48:07 -0400
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D571B9;
        Fri,  4 Aug 2023 04:48:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1588763|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00334653-3.04391e-05-0.996623;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U8VaX1a_1691149673;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U8VaX1a_1691149673)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 19:47:55 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, 13916275206@139.com,
        ryans.lee@analog.com, ckeepax@opensource.cirrus.com,
        sebastian.reichel@collabora.com,
        ajye_huang@compal.corp-partner.google.com, povik+lin@cutebit.org,
        yijiangtao@awinic.com, trix@redhat.com, colin.i.king@gmail.com,
        liweilei@awinic.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
Subject: [PATCH V4 0/3] ASoC: codecs: Add awinic AW88261 audio amplifier driver
Date:   Fri,  4 Aug 2023 19:47:46 +0800
Message-ID: <20230804114749.215460-1-wangweidong.a@awinic.com>
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

From: Weidong Wang <wangweidong.a@awinic.com>

The awinic AW88261 is an I2S/TDM input, high efficiency
digital Smart K audio amplifier

v3 -> v4: Modify the dev_err_probe usage
          Changed the use of sizeof in kzalloc
          Changed the function name
          Merge aw88261_device.c into aw88261.c

Weidong Wang (3):
  ASoC: dt-bindings: Add schema for "awinic,aw88261"
  ASoC: codecs: Add code for bin parsing compatible with aw88261
  ASoC: codecs: Add aw88261 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    4 +-
 sound/soc/codecs/Kconfig                      |   15 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88261.c                    | 1298 +++++++++++++++++
 sound/soc/codecs/aw88261.h                    |  459 ++++++
 sound/soc/codecs/aw88395/aw88395_lib.c        |  193 ++-
 sound/soc/codecs/aw88395/aw88395_reg.h        |    1 +
 7 files changed, 1954 insertions(+), 18 deletions(-)
 create mode 100644 sound/soc/codecs/aw88261.c
 create mode 100644 sound/soc/codecs/aw88261.h


base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
-- 
2.41.0


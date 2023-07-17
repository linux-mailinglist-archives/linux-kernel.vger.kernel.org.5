Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045D756228
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGQL7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:58:59 -0400
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE65E6;
        Mon, 17 Jul 2023 04:58:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1215566|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0282188-0.000419799-0.971361;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.TvogKtF_1689595126;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.TvogKtF_1689595126)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 19:58:48 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.co,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
Subject: [PATCH V1 0/5]  ASoC: codecs: Add Awinic AW88261 audio amplifier driver
Date:   Mon, 17 Jul 2023 19:58:40 +0800
Message-ID: <20230717115845.297991-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

The AW88261 is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Add a DT schema for describing Awinic aw88261 audio amplifiers. They are
controlled using I2C.

Weidong Wang (5):
  ASoC: codecs: Add i2c and codec registration for aw88261 and their
    associated operation functions
  ASoC: codecs: aw88261 function for ALSA Audio Driver
  ASoC: codecs: ACF bin parsing and check library file for aw88261
  ASoC: codecs: aw88261 chip register file, data type file and Kconfig
    Makefile
  ASoC: dt-bindings: Add schema for "awinic,aw88261"

 .../bindings/sound/awinic,aw88261.yaml        |  53 +
 sound/soc/codecs/Kconfig                      |  17 +
 sound/soc/codecs/Makefile                     |   5 +
 sound/soc/codecs/aw88261/aw88261.c            | 539 ++++++++++
 sound/soc/codecs/aw88261/aw88261.h            |  52 +
 sound/soc/codecs/aw88261/aw88261_data_type.h  | 144 +++
 sound/soc/codecs/aw88261/aw88261_device.c     | 959 +++++++++++++++++
 sound/soc/codecs/aw88261/aw88261_device.h     | 114 ++
 sound/soc/codecs/aw88261/aw88261_lib.c        | 997 ++++++++++++++++++
 sound/soc/codecs/aw88261/aw88261_lib.h        |  91 ++
 sound/soc/codecs/aw88261/aw88261_reg.h        | 377 +++++++
 11 files changed, 3348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw88261.yaml
 create mode 100644 sound/soc/codecs/aw88261/aw88261.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_data_type.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_reg.h


base-commit: 8d7868c41df58edabc4e408d119a1aef58a54d9d
-- 
2.41.0


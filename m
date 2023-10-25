Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2537D6A07
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJYL0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjJYL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:26:47 -0400
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94410A;
        Wed, 25 Oct 2023 04:26:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2526966|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00494645-5.18588e-05-0.995002;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.V7r.p-W_1698233187;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V7r.p-W_1698233187)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 19:26:34 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com,
        ajye_huang@compal.corp-partner.google.com, fido_max@inbox.ru,
        liweilei@awinic.com, yijiangtao@awinic.com, trix@redhat.com,
        colin.i.king@gmail.com, dan.carpenter@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3] ASoC: codecs: Add aw88399 amplifier driver
Date:   Wed, 25 Oct 2023 19:26:22 +0800
Message-ID: <20231025112625.959587-1-wangweidong.a@awinic.com>
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

v2 -> v3: Generate patch based against for-6.7 of sound tree

Weidong Wang (3):
  ASoC: dt-bindings: Add schema for "awinic,aw88399"
  ASoC: codecs: Add code for bin parsing compatible with aw88399
  ASoC: codecs: Add aw88399 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    1 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88395/aw88395_lib.c        |    3 +
 sound/soc/codecs/aw88395/aw88395_reg.h        |    1 +
 sound/soc/codecs/aw88399.c                    | 1911 +++++++++++++++++
 sound/soc/codecs/aw88399.h                    |  599 ++++++
 7 files changed, 2531 insertions(+)
 create mode 100644 sound/soc/codecs/aw88399.c
 create mode 100644 sound/soc/codecs/aw88399.h


base-commit: 3edc85e3bfcb411da6e48a38e8de578f9fd71340
-- 
2.41.0


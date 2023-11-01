Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333FC7DDDF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjKAJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjKAJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:02:26 -0400
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7379F1;
        Wed,  1 Nov 2023 02:02:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.162632|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00934526-0.000121555-0.990533;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.VCeeghj_1698829334;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.VCeeghj_1698829334)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 17:02:18 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, liweilei@awinic.com,
        u.kleine-koenig@pengutronix.de, yang.lee@linux.alibaba.com,
        nathan@kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] ASoC: codecs: Modify some error codes
Date:   Wed,  1 Nov 2023 17:02:07 +0800
Message-ID: <20231101090211.177125-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

The maximum value that calib can set should be
consistent with the maximum value of re.

An error code should be return when the re is greater
than the maximum value or less than the minimum value

The value of vsense_select should be either 32
or 0 in both cases, so modify the
AW88399_DEV_VDSEL_VSENSE macro to 32.

v1 -> v2: Added changes to the calib range

Weidong Wang (3):
  ASoC: codecs: Modify the maximum value of calib
  ASoC: codecs: Modify the wrong judgment of re value
  ASoC: codecs: Modify macro value error

 sound/soc/codecs/aw88395/aw88395.c | 2 +-
 sound/soc/codecs/aw88399.c         | 6 +++---
 sound/soc/codecs/aw88399.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: fa7d0c17278644aa691f96d08bef8001b762f9cd
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471CA7DDCEE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjKAHEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKAHEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:04:46 -0400
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D9E8;
        Wed,  1 Nov 2023 00:04:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.151909|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00863109-0.000239784-0.991129;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.VCY3.KT_1698822256;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.VCY3.KT_1698822256)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 15:04:34 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, nathan@kernel.org,
        inux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: codecs: Modify some error codes
Date:   Wed,  1 Nov 2023 15:04:11 +0800
Message-ID: <20231101070413.162708-1-wangweidong.a@awinic.com>
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

An error code should be return when the re is greater
than the maximum value or less than the minimum value

The value of vsense_select should be either 32
or 0 in both cases, so modify the
AW88399_DEV_VDSEL_VSENSE macro to 32.

Weidong Wang (2):
  ASoC: codecs: Modify the wrong judgment of re value
  ASoC: codecs: Modify macro value error

 sound/soc/codecs/aw88399.c | 4 ++--
 sound/soc/codecs/aw88399.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: fa7d0c17278644aa691f96d08bef8001b762f9cd
-- 
2.41.0


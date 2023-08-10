Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57912776D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHJA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHJA4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:56:02 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A61BFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:56:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VpROvVB_1691628956;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VpROvVB_1691628956)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 08:55:57 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ASoC: SOF: Intel: Remove duplicated include in lnl.c
Date:   Thu, 10 Aug 2023 08:55:55 +0800
Message-Id: <20230810005555.4610-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./sound/soc/sof/intel/lnl.c: hda.h is included more than once.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/sof/intel/lnl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 3d919b0b6891..db94b45e53af 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -16,7 +16,6 @@
 #include "hda-ipc.h"
 #include "../sof-audio.h"
 #include "mtl.h"
-#include "hda.h"
 #include <sound/hda-mlink.h>
 
 /* LunarLake ops */
-- 
2.20.1.7.g153144c


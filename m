Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5197CD191
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjJRBCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRBCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:02:10 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9692
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:02:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuOwdgd_1697590924;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VuOwdgd_1697590924)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 09:02:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com, harry.wentland@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: Remove duplicated include in dce110_hwseq.c
Date:   Wed, 18 Oct 2023 09:02:03 +0800
Message-Id: <20231018010203.110189-1-yang.lee@linux.alibaba.com>
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

./drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c: dce110_hwseq.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6897
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 74602a5fd6dd..51e42cbb3cdb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -65,8 +65,6 @@
 
 #include "dcn10/dcn10_hwseq.h"
 
-#include "dce110_hwseq.h"
-
 #define GAMMA_HW_POINTS_NUM 256
 
 /*
-- 
2.20.1.7.g153144c


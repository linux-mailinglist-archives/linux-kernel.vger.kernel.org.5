Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F07F227C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjKUAtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjKUAtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:49:47 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E738BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:49:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VwqRWD4_1700527781;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VwqRWD4_1700527781)
          by smtp.aliyun-inc.com;
          Tue, 21 Nov 2023 08:49:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com, harry.wentland@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: Remove duplicated include in dcn201_resource.c
Date:   Tue, 21 Nov 2023 08:49:39 +0800
Message-Id: <20231121004939.55904-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c: dcn201/dcn201_hubbub.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7583
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 914b234d7f6b..3cfb7e913c4c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -55,7 +55,6 @@
 #include "dce110/dce110_resource.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
-#include "dcn201/dcn201_hubbub.h"
 #include "dcn10/dcn10_resource.h"
 
 #include "cyan_skillfish_ip_offset.h"
-- 
2.20.1.7.g153144c


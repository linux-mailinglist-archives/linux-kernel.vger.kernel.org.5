Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7871576C25B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjHBBjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHBBjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:39:52 -0400
Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com [115.124.28.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25E30C6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:39:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4792903|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.0767665-0.000288784-0.922945;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Jqo9R_1690940299;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Jqo9R_1690940299)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:38:21 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in pp_thermal.h
Date:   Wed,  2 Aug 2023 01:38:18 +0000
Message-Id: <20230802013818.8766-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
index f7c41185097e..2003acc70ca0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
@@ -25,14 +25,12 @@
 
 #include "power_state.h"
 
-static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDelayPolicy[] =
-{
+static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDelayPolicy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
 
-static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy[] =
-{
+static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
-- 
2.17.1


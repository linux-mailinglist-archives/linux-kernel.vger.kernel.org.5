Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3C7FEE57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjK3L5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjK3L5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:57:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6530E10F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:57:17 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AU5Ad2E001244;
        Thu, 30 Nov 2023 05:57:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=S1lHDJ3aPcKmpoyJXC6HZYjYNzWGgeJbNEH+lWhfxAo=; b=
        nRL+4u4iix91kJP4wnfUFG59nKHmdydUzXnT4coAE7gECq2db7MzIzjAh1WYMBYp
        0fH+kf5w9TNvMibQXe4a92aB9flCFCFz9E4k/fbqItwgJQVZ+cAjeCTWvdrkh+p2
        hUFQNnloX86tf2O3qhRj1pl2fCxliU5ExliIZ7pNSNGZtkHWmwGuUF3MHoDoKpUu
        b4K/4iDD8wnZcci6ZoGVYys5W4bN5RpRaOTZEwzOHPVHGFJtm4luMoeqTF199fRU
        QCFORMrkVsr/Il4HqVirEAwb7B3KQ1UpdBBHFml5kVgrQk6vYfWKyq94jfa4fNCY
        RL1WdZvdfO8/rXF55v0Dng==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3unvprt1h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 05:57:13 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 30 Nov
 2023 11:57:12 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Thu, 30 Nov 2023 11:57:12 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6481A11D4;
        Thu, 30 Nov 2023 11:57:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mfd: cs42l43: Correct order of include files to be alphabetical
Date:   Thu, 30 Nov 2023 11:57:12 +0000
Message-ID: <20231130115712.669180-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130115712.669180-1-ckeepax@opensource.cirrus.com>
References: <20231130115712.669180-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: A2ll6Ax3liEuK9KEUDk53zevdb-l2Iwp
X-Proofpoint-GUID: A2ll6Ax3liEuK9KEUDk53zevdb-l2Iwp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
index 4be4df9dd8cf1..1d85bbf8cdd5d 100644
--- a/drivers/mfd/cs42l43-sdw.c
+++ b/drivers/mfd/cs42l43-sdw.c
@@ -6,11 +6,11 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/mfd/cs42l43-regs.h>
 #include <linux/module.h>
-#include <linux/device.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw_type.h>
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165E278400E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjHVLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjHVLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:50:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05462E53
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:50:16 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37MAaZCi005826;
        Tue, 22 Aug 2023 06:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=Q
        q157WXYbw6aMhWL2RrlH5jE8wcD/puLfZnESyZj1C0=; b=p0F/29tkW9j4tBfq0
        e6iTEC1ryVPTlqJJxOYsN3RA2mb6XE0EL5g3Pz0d0XoEUW30CeqtvY9QUxpVDwIr
        /z00Ce4LNIMYDBkaiQbIO+QnmYSHPkmiCDs2UxbUECdgx1Nn7I65I9a7llWqWiXj
        wqux3Sw3/HO3c0N7RXwPSUHyS7BOofPlCN/2Ow/KnWNCYdpxW6huaGIkQhFDLXsm
        c1TF285PZMB9b6v0Y02XOkhVvri9JRcKZRfzewbvSEx4/SAP2852DR5fsnAmhMeG
        GVCdZ6NmFjqs5LGz9JxD3KRMZdgqykehf2bIwKMrib29pWUsL7f0cX4QRAEpeGEb
        BjdJA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sktt5skh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:49:16 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 22 Aug
 2023 12:49:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 22 Aug 2023 12:49:14 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AA12D3563;
        Tue, 22 Aug 2023 11:49:14 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: cs42l43: Use correct macro for new-style PM runtime ops
Date:   Tue, 22 Aug 2023 12:49:14 +0100
Message-ID: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZBSf8v4irPi57QED9A6o0x9uA__7oLrH
X-Proofpoint-ORIG-GUID: ZBSf8v4irPi57QED9A6o0x9uA__7oLrH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was accidentally mixing new and old style macros, update the
macros used to remove an unused function warning whilst building with
no PM enabled in the config.

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 37b23e9bae823..7b6d07cbe6fc6 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
-	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
+	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
 };
 
 MODULE_DESCRIPTION("CS42L43 Core Driver");
-- 
2.30.2


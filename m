Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC376EF4F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjHCQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjHCQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:23:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D5230DB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:23:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37367YIr018231;
        Thu, 3 Aug 2023 11:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=z
        sBLhUvAZHDtEeJFuObfMcXDnu2U4ZsRAv3wWenIgnM=; b=B4Dw/dRrJ+U7JPUPN
        VaRl8JWuF0sbBjg9+9SC4xiKx007pf2fQ+pT0JCKRqjwr4yRU37Klrp13d0k6Zek
        uskld2NZ+aWuBfokVhFoptLVWONlV6LfNVFPRMT8XJo+WwBUm1ZeV3Sch8QAqYFb
        j7m49sUiRB9KBuxI38pxDv/rkzkSp7gAO/SKe+Lg+sZlVKWizRWXVrz9QWXsvqRt
        KcXwuzN5/3p2qAIzApj9ov3D6xzInVcf1e2eEr0RySZuCnvacfODY7Msfuee/+Yj
        jKWAAX78VC5oUzJxhvdjEAtDScIx+xNLM16xF9fVw3aEsj5X3jrs51O8n4wt2pSJ
        xdfaw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1x6xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 11:23:14 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 3 Aug
 2023 17:23:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 3 Aug 2023 17:23:12 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2BEDD3563;
        Thu,  3 Aug 2023 16:23:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: soc-acpi: Add missing kernel doc
Date:   Thu, 3 Aug 2023 17:23:12 +0100
Message-ID: <20230803162312.117771-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: E5ZRspWyMbP0Hdb1q7WxMkEWoQYHyjS0
X-Proofpoint-ORIG-GUID: E5ZRspWyMbP0Hdb1q7WxMkEWoQYHyjS0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UID field in snd_soc_acpi_link_adr is not documented, add kernel doc
for it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc-acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 630bf7367fe69..6d31d535e8f6d 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -151,6 +151,7 @@ struct snd_soc_acpi_link_adr {
  * all firmware/topology related fields.
  *
  * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
+ * @uid: ACPI Unique ID, can be used to disambiguate matches.
  * @comp_ids: list of compatible audio codecs using the same machine driver,
  * firmware and topology
  * @link_mask: describes required board layout, e.g. for SoundWire.
-- 
2.30.2


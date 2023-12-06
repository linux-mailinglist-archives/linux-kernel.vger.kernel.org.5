Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA568077FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442788AbjLFSr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379382AbjLFSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:47:35 -0500
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598F10FF;
        Wed,  6 Dec 2023 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1056; q=dns/txt; s=iport;
  t=1701888435; x=1703098035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DvpvexVDMU5638wqFKGLX6VF8dgg0xDpZ3MUoNlfWeY=;
  b=Rh7pbLO8lRb+VAfCFVi9uxswufie0P0oQICcwGUSjpS9vbm3FS86YwiC
   72/LAaW41Wso5O0weUDmLHb3Hq1D4G41dbU01C3SYn+YqvHQkclVCkbnE
   mhFTDt9RHm52ZV7IFAJUVdxz+CnpzcQKLDBRfpBBJTqeyfFAxwyOCld5K
   s=;
X-CSE-ConnectionGUID: 0VqnhO/SSNu5vJN/vZvf+Q==
X-CSE-MsgGUID: /Vur/SGrSamPKHoNazhmpw==
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="154982619"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:47:14 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3B6IkHD9010013
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Dec 2023 18:47:13 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v5 13/13] scsi: fnic: Increment driver version
Date:   Wed,  6 Dec 2023 10:46:15 -0800
Message-Id: <20231206184615.878755-14-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231206184615.878755-1-kartilak@cisco.com>
References: <20231206184615.878755-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: alln-core-4.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increment driver version for multiqueue(MQ)

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v4 and v5:
    Incorporate review comments from Martin:
	Modify patch commits to include a "---" separator.

Changes between v2 and v3:
    Incorporate the following review comments from Hannes:
	Create a separate patch to increment driver version.
	Increment driver version number to 1.7.0.0.
---
 drivers/scsi/fnic/fnic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index c4edbd7dfc25..7241aebf79d6 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -27,7 +27,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.56"
+#define DRV_VERSION		"1.7.0.0"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
-- 
2.31.1


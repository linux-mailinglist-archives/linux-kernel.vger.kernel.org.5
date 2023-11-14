Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F7E7EB989
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjKNWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjKNWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:41:12 -0500
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C90C1;
        Tue, 14 Nov 2023 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=877; q=dns/txt; s=iport;
  t=1700001670; x=1701211270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XEQ4NSFM5Uqzyo57IeSl2o8heX6pLC+We2PwToQ+IVw=;
  b=EtshSuHz/aP2YYjwQ/+YGFnipdBw5IvSx1d5Rj0MEDWi5bfvITZReZka
   sICx8XX6JvchOAsVsQsXF3xo6Ql7u40gPkmXnGQ4WhSAN+GsPzS80wdXG
   UceGm0LdPJ22URWaKNFDn/Jj4ajP+ZfmSt5VK014R4VkRkEFl6eJXCIGs
   w=;
X-CSE-ConnectionGUID: V26Ykc5QQm64vchQGHderA==
X-CSE-MsgGUID: s0ZtDmJ/Q7alYmPeIPY7YQ==
X-IronPort-AV: E=Sophos;i="6.03,303,1694736000"; 
   d="scan'208";a="139043012"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 22:41:09 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AEMf213027712
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Nov 2023 22:41:08 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v3 13/13] scsi: fnic: Increment driver version
Date:   Tue, 14 Nov 2023 14:41:00 -0800
Message-Id: <20231114224100.634381-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-2.cisco.com
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

Changes between v2 and v3:
    Incorporate the following review comments from Hannes:
	Create a separate patch to increment driver version.
	Increment driver version number to 1.7.0.0.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
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


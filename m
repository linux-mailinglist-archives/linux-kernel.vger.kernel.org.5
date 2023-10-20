Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF07D161B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjJTTHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjJTTHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:07:05 -0400
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACD5D76;
        Fri, 20 Oct 2023 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1929; q=dns/txt; s=iport;
  t=1697828823; x=1699038423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfN4RnDRd/wQBtbHZU4sV3kl2Zo449NxAVA6sUVHsHA=;
  b=bwCAHWwNWpcVNSUrMoD9HnhWyI8K95HVlhJWvZiEhZZ0p6UT1Z+uW7x0
   DYZg0mnUgSRq1adBbEA+OnoZ0Ml2ai5/4rui+IsttHlgQCv0x+L34LjRc
   dzWzANLs4btKaaUctrTljxtYti8KyVWuY+/qsxGoVRmcxoQGm8c8k0UuL
   A=;
X-CSE-ConnectionGUID: wEAiJYrnQfKpoxYuknY4Kg==
X-CSE-MsgGUID: 9QoOHDiIROqS/IxMzlWusg==
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="126839759"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 19:07:02 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39KJ6XPD026372
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Oct 2023 19:07:01 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH 01/13] scsi: fnic: Modify definitions to sync with VIC firmware
Date:   Fri, 20 Oct 2023 12:06:17 -0700
Message-Id: <20231020190629.338623-2-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231020190629.338623-1-kartilak@cisco.com>
References: <20231020190629.338623-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIC firmware has updated definitions.
Modify structure and definitions to sync with the latest VIC firmware.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/vnic_scsi.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/vnic_scsi.h b/drivers/scsi/fnic/vnic_scsi.h
index 4e12f7b32d9d..f715f7942bfe 100644
--- a/drivers/scsi/fnic/vnic_scsi.h
+++ b/drivers/scsi/fnic/vnic_scsi.h
@@ -26,7 +26,7 @@
 #define VNIC_FNIC_RATOV_MAX                 255000
 
 #define VNIC_FNIC_MAXDATAFIELDSIZE_MIN      256
-#define VNIC_FNIC_MAXDATAFIELDSIZE_MAX      2112
+#define VNIC_FNIC_MAXDATAFIELDSIZE_MAX      2048
 
 #define VNIC_FNIC_FLOGI_RETRIES_MIN         0
 #define VNIC_FNIC_FLOGI_RETRIES_MAX         0xffffffff
@@ -55,7 +55,7 @@
 #define VNIC_FNIC_PORT_DOWN_IO_RETRIES_MAX  255
 
 #define VNIC_FNIC_LUNS_PER_TARGET_MIN       1
-#define VNIC_FNIC_LUNS_PER_TARGET_MAX       1024
+#define VNIC_FNIC_LUNS_PER_TARGET_MAX       4096
 
 /* Device-specific region: scsi configuration */
 struct vnic_fc_config {
@@ -79,10 +79,19 @@ struct vnic_fc_config {
 	u16 ra_tov;
 	u16 intr_timer;
 	u8 intr_timer_type;
+	u8 intr_mode;
+	u8 lun_queue_depth;
+	u8 io_timeout_retry;
+	u16 wq_copy_count;
 };
 
 #define VFCF_FCP_SEQ_LVL_ERR	0x1	/* Enable FCP-2 Error Recovery */
 #define VFCF_PERBI		0x2	/* persistent binding info available */
 #define VFCF_FIP_CAPABLE	0x4	/* firmware can handle FIP */
 
+#define VFCF_FC_INITIATOR         0x20    /* FC Initiator Mode */
+#define VFCF_FC_TARGET            0x40    /* FC Target Mode */
+#define VFCF_FC_NVME_INITIATOR    0x80    /* FC-NVMe Initiator Mode */
+#define VFCF_FC_NVME_TARGET       0x100   /* FC-NVMe Target Mode */
+
 #endif /* _VNIC_SCSI_H_ */
-- 
2.31.1


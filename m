Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE37AAF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjIVKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjIVKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:07:15 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E791;
        Fri, 22 Sep 2023 03:07:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vsd7U46_1695377219;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vsd7U46_1695377219)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 18:07:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     satishkh@cisco.com
Cc:     sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] scsi: fnic: clean up some inconsistent indenting
Date:   Fri, 22 Sep 2023 18:06:57 +0800
Message-Id: <20230922100657.14566-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/scsi/fnic/fnic_fcs.c:152 fnic_handle_link() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6678
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/fnic/fnic_fcs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 79ddfaaf71a4..55632c67a8f2 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -145,16 +145,17 @@ void fnic_handle_link(struct work_struct *work)
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		if (fnic->config.flags & VFCF_FIP_CAPABLE) {
 			/* start FCoE VLAN discovery */
-				fnic_fc_trace_set_data(
-				fnic->lport->host->host_no,
-				FNIC_FC_LE, "Link Status: DOWN_UP_VLAN",
-				strlen("Link Status: DOWN_UP_VLAN"));
+			fnic_fc_trace_set_data(fnic->lport->host->host_no,
+					       FNIC_FC_LE, "Link Status: DOWN_UP_VLAN",
+					       strlen("Link Status: DOWN_UP_VLAN"));
 			fnic_fcoe_send_vlan_req(fnic);
+
 			return;
 		}
+
 		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, "link up\n");
 		fnic_fc_trace_set_data(fnic->lport->host->host_no, FNIC_FC_LE,
-			"Link Status: DOWN_UP", strlen("Link Status: DOWN_UP"));
+				       "Link Status: DOWN_UP", strlen("Link Status: DOWN_UP"));
 		fcoe_ctlr_link_up(&fnic->ctlr);
 	} else {
 		/* UP -> DOWN */
-- 
2.20.1.7.g153144c


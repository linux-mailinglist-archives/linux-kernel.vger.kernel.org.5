Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44997CF299
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjJSIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJSIaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:30:55 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BC39911F;
        Thu, 19 Oct 2023 01:30:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id CA64C6071E208;
        Thu, 19 Oct 2023 16:30:32 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     Su Hui <suhui@nfschina.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: snici: Remove dead code in snic_dr_clean_pending_req
Date:   Thu, 19 Oct 2023 16:30:27 +0800
Message-Id: <20231019083026.1525366-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value stored to 'ret' is never read, remove it to save space.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/scsi/snic/snic_scsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index c50ede326cc4..badd0d5640bc 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -1867,11 +1867,8 @@ snic_dr_clean_pending_req(struct snic *snic, struct scsi_cmnd *lr_sc)
 	schedule_timeout(msecs_to_jiffies(100));
 
 	/* Walk through all the cmds and check abts status. */
-	if (snic_is_abts_pending(snic, lr_sc)) {
-		ret = FAILED;
-
+	if (snic_is_abts_pending(snic, lr_sc))
 		goto clean_err;
-	}
 
 	ret = 0;
 	SNIC_SCSI_DBG(snic->shost, "clean_pending_req: Success.\n");
-- 
2.30.2


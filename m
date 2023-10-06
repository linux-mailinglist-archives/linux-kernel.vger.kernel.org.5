Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC407BC0A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjJFUrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJFUrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:47:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26099FC;
        Fri,  6 Oct 2023 13:47:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so3262727e87.2;
        Fri, 06 Oct 2023 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696625225; x=1697230025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv0KOPQGwSmTbUciXfuMBWmAszihY5ijU/JoeW74y8Q=;
        b=C7WBgV8JA2adtfw9MS3aXFG1skjoRzQKyIU3VWnld9w4b+ObYauJ6RIU0w8DCL2mtp
         ApIVfYGg7reAM+kCu5BdGTPzHx5b0lkLO+BODZRnz0jFUYNLKJc40Kpn+SwyUqeufIz0
         WCYLgaTysg4aN6wRY5RZ9mNiOZBkoPlBn38/LmP907zGuXsiu+K0FYNmAtgXRctxjzhI
         DFjEozmRs0Cj9eDqxQxoCHiOjUpJMEx9wOHrv30yZLTd+tmNqplIutjh8kUS5Gstoaai
         5iIaSyOyxD5MECLhJ5BHzY9cGtIR8EHhZtYpCmXUAPBzbyIJAOWX+60iSx0LTLwulANn
         3wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696625225; x=1697230025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv0KOPQGwSmTbUciXfuMBWmAszihY5ijU/JoeW74y8Q=;
        b=HZ9Qq47s0AwsGZFiUdWVPoJYrZ9OO3AEn9tnG255oEQ22JyKYiREYuwiHriEfFJg78
         nAeFf0tBSwZw2k4wmodQ2ip2DDTbv3w3jB2B+dUi64WPBJKZMC6kQxYo7R7DFA/Y1fnT
         cWfKpz+FUM29VfiMPUHftT0bqeIwXemSEfh7k4XKCcDw2MgB4irF9vGwXTeA6yG9Apx4
         gAN8gzB2ywkCcKc1fwKWFrBzci32v2+xkMHLOPSjcwouiXI9DR8CzuyD3WZXY97ttP0M
         Wb4Px7Rl2HRPHWwKu9shuW6k2LbFauzhzbTCCloEp76LoteNQ40CwnuDjrdO9lyqIVkd
         RRkQ==
X-Gm-Message-State: AOJu0YzhhbdHvb1HeEq1YmpOqFm67eEub9DBzTCh3eB0XM02sZsCUFqQ
        D+TZYBr6jdtXRi/NZ4mPMQ0=
X-Google-Smtp-Source: AGHT+IE9/Q7u6Nkl1Qm/2ugsnv1msAs7hE20IrWBmQIeyc1HqjeM9EQMgIwVvVbDxeD1Qhke/UJ7fw==
X-Received: by 2002:a05:6512:3706:b0:503:367c:49c7 with SMTP id z6-20020a056512370600b00503367c49c7mr7092261lfr.53.1696625224960;
        Fri, 06 Oct 2023 13:47:04 -0700 (PDT)
Received: from localhost.localdomain ([31.40.96.55])
        by smtp.gmail.com with ESMTPSA id s8-20020ac25fa8000000b0050482b29ac9sm431273lfe.212.2023.10.06.13.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:47:04 -0700 (PDT)
From:   Vadim Marchenko <jakosvadim@gmail.com>
To:     HighPoint Linux Team <linux@highpoint-tech.com>
Cc:     Vadim Marchenko <jakosvadim@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] scsi: hptiop: Fix buffer overflow of hba->reqs[]
Date:   Fri,  6 Oct 2023 23:46:53 +0300
Message-Id: <20231006204653.4677-1-jakosvadim@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer overflow when accessing an hba->reqs[tag]. Since the tag value is read
from the device with readl(), it can be greater than HPTIOP_MAX_REQUESTS,
which is the maximum size of reqs[].
struct hptiop_hba { ... struct hptiop_request reqs[HPTIOP_MAX_REQUESTS]; ... }

For example, if tag is 0x80000101, then in hptiop.c:79 we will pass tag equal
to (tag & ~IOPMU_QUEUE_ADDR_HOST_BIT) = (0x80000101 & 0x7fffffff) = 0x101 = 257
and get a buffer overflow in hptiop_host_request_callback_itl().

To fix it, we need to get the last 8 bits of the tag before accessing the
hba->reqs[tag]. We can do this by calculating bitwise and of tag with macros
IOPMU_QUEUE_REQUEST_INDEX_BITS which is equal to 0xff.
By the way, array access that prevents overflow was in commit 286aa031664b
("[SCSI] hptiop: Support HighPoint RR4520/RR4522 HBA") in function
hptiop_request_callback_mvfrey(), and this fix extends it to all other cases.

Found by Linux Verification Center (linuxtesting.org) with KLEVER.

Signed-off-by: Vadim Marchenko <jakosvadim@gmail.com>
---
 drivers/scsi/hptiop.c | 22 +++++++++++++++-------
 drivers/scsi/hptiop.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f5334ccbf2ca..174a350c4f58 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -176,6 +176,7 @@ static void hptiop_request_callback_mv(struct hptiop_hba *hba, u64 tag)
 {
 	u32 req_type = (tag >> 5) & 0x7;
 	struct hpt_iop_request_scsi_command *req;
+	u32 req_idx;
 
 	dprintk("hptiop_request_callback_mv: tag=%llx\n", tag);
 
@@ -188,7 +189,8 @@ static void hptiop_request_callback_mv(struct hptiop_hba *hba, u64 tag)
 		break;
 
 	case IOP_REQUEST_TYPE_SCSI_COMMAND:
-		req = hba->reqs[tag >> 8].req_virt;
+		req_idx = (tag >> 8) & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 		if (likely(tag & MVIOP_MU_QUEUE_REQUEST_RESULT_BIT))
 			req->header.result = cpu_to_le32(IOP_RESULT_SUCCESS);
 
@@ -231,6 +233,7 @@ static void hptiop_request_callback_mvfrey(struct hptiop_hba *hba, u32 _tag)
 {
 	u32 req_type = _tag & 0xf;
 	struct hpt_iop_request_scsi_command *req;
+	u32 req_idx;
 
 	switch (req_type) {
 	case IOP_REQUEST_TYPE_GET_CONFIG:
@@ -239,10 +242,11 @@ static void hptiop_request_callback_mvfrey(struct hptiop_hba *hba, u32 _tag)
 		break;
 
 	case IOP_REQUEST_TYPE_SCSI_COMMAND:
-		req = hba->reqs[(_tag >> 4) & 0xff].req_virt;
+		req_idx = (_tag >> 4) & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 		if (likely(_tag & IOPMU_QUEUE_REQUEST_RESULT_BIT))
 			req->header.result = IOP_RESULT_SUCCESS;
-		hptiop_finish_scsi_req(hba, (_tag >> 4) & 0xff, req);
+		hptiop_finish_scsi_req(hba, req_idx, req);
 		break;
 
 	default:
@@ -717,6 +721,7 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 				struct hpt_iop_request_scsi_command *req)
 {
 	struct scsi_cmnd *scp;
+	u32 req_idx = tag & IOPMU_QUEUE_REQUEST_INDEX_BITS;
 
 	dprintk("hptiop_finish_scsi_req: req=%p, type=%d, "
 			"result=%d, context=0x%x tag=%d\n",
@@ -726,7 +731,7 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 	BUG_ON(!req->header.result);
 	BUG_ON(req->header.type != cpu_to_le32(IOP_REQUEST_TYPE_SCSI_COMMAND));
 
-	scp = hba->reqs[tag].scp;
+	scp = hba->reqs[req_idx].scp;
 
 	if (HPT_SCP(scp)->mapped)
 		scsi_dma_unmap(scp);
@@ -770,22 +775,25 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 skip_resid:
 	dprintk("scsi_done(%p)\n", scp);
 	scsi_done(scp);
-	free_req(hba, &hba->reqs[tag]);
+	free_req(hba, &hba->reqs[req_idx]);
 }
 
 static void hptiop_host_request_callback_itl(struct hptiop_hba *hba, u32 _tag)
 {
 	struct hpt_iop_request_scsi_command *req;
 	u32 tag;
+	u32 req_idx;
 
 	if (hba->iopintf_v2) {
 		tag = _tag & ~IOPMU_QUEUE_REQUEST_RESULT_BIT;
-		req = hba->reqs[tag].req_virt;
+		req_idx = tag & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 		if (likely(_tag & IOPMU_QUEUE_REQUEST_RESULT_BIT))
 			req->header.result = cpu_to_le32(IOP_RESULT_SUCCESS);
 	} else {
 		tag = _tag;
-		req = hba->reqs[tag].req_virt;
+		req_idx = tag & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 	}
 
 	hptiop_finish_scsi_req(hba, tag, req);
diff --git a/drivers/scsi/hptiop.h b/drivers/scsi/hptiop.h
index 394ef6aa469e..742ce87ab56d 100644
--- a/drivers/scsi/hptiop.h
+++ b/drivers/scsi/hptiop.h
@@ -32,6 +32,7 @@ struct hpt_iopmu_itl {
 #define IOPMU_QUEUE_ADDR_HOST_BIT    0x80000000
 #define IOPMU_QUEUE_REQUEST_SIZE_BIT    0x40000000
 #define IOPMU_QUEUE_REQUEST_RESULT_BIT   0x40000000
+#define IOPMU_QUEUE_REQUEST_INDEX_BITS   0xff
 
 #define IOPMU_OUTBOUND_INT_MSG0      1
 #define IOPMU_OUTBOUND_INT_MSG1      2
-- 
2.39.2


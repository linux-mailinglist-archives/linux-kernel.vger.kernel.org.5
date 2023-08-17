Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F113A77F461
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbjHQKiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349920AbjHQKiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:38:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DE2D5A;
        Thu, 17 Aug 2023 03:37:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb84194bf3so48761105ad.3;
        Thu, 17 Aug 2023 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692268678; x=1692873478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8u6STTTo0IQbi3lQd+vgtiTbyFEHsVCA7HA0UeiZdw=;
        b=OMZXTeKwtW1HkrTRzX9/ceRnBHtM5YJ6w2M3N4KNUttvLDqZJeNUGjKnRFHkkkjJ7a
         4mWnKqvrd+W8U3GtAzJWdvpVjc/jxwVLPvnM2UjiYMXRfWk9T8va3JaUAvl1Cu/VJ6QH
         Qfgvuvrp7iWpEcCodll03rjut+S44okzhw/avRSBxNp2naDF46FNu6cXCLbD/XiJgFpl
         B+j4q4HhduNEz8/DyvzfsFD6xe8rM8WPhAH5j5djuIRt9J5E2dkDp8K9dK86MLjBmiN+
         E5/e2s0eeHTRVn4RrM5TKSp0YwTLkdYtZS7lJS0RDHSuJo52Gfp2IhpqjilIfrdpQfUK
         KVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692268678; x=1692873478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8u6STTTo0IQbi3lQd+vgtiTbyFEHsVCA7HA0UeiZdw=;
        b=P4v5gRWdX61ihvTrMHqNcbIWGoWmUaQc9EQu28zXfu2GX353l55EH0zqqQE7Dp7fBn
         O7BEGD2SQo3+4gWlasl7X6UssiWiWv8Q/qvnxu5dYnVkrIdxy/yNwtJI1FhTq6vYhG18
         9wmhKagx2SmebapCi8SHFH845AkNhqkoPAoTpNAX7KX9FLfI35/p70bMh2uiKJsjpDIS
         q5+bq8xz3Gjcm0EXP5p7qOPdB4Emmhhc+VGj9JRiJL41S7UXFBW5KOXidQt/5qlkU/zR
         QMXZQgvewIHx7aF1TOQqDof9i0TBD4f0fo56VVcFd+OTx7VFUaQFzbCDbWoPKVFbH1D6
         ptfA==
X-Gm-Message-State: AOJu0Yz1fdDQdSsjdc1AH33bPGhmZDy85+XmXTVwlK8oevTX5t6NkUCp
        U3qra+4BzQx/jrEhE8nHs/I=
X-Google-Smtp-Source: AGHT+IFpAGL5N3vaudEA7MH3XwrMMJeUBz6yL0NjKOczZnqyaaL5xXtsNl/eXPB/emWKCmX2nsxYvQ==
X-Received: by 2002:a17:902:cec5:b0:1bc:81f2:ddf0 with SMTP id d5-20020a170902cec500b001bc81f2ddf0mr5157403plg.67.1692268678398;
        Thu, 17 Aug 2023 03:37:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1016:aeca:454:68e4:51c8:d1cf])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001b87d3e845bsm14963467plw.149.2023.08.17.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 03:37:58 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        rdunlap@infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] scsi: sli4: Remove the buggy code
Date:   Thu, 17 Aug 2023 16:07:51 +0530
Message-Id: <20230817103751.16350-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

In the function sli_xmit_bls_rsp64_wqe, the 'if' and 'else' conditions
evaluates the same expression and gives same output. Also the variable
bls->local_n_port_id_dword is not used anywhere. Therefore removing the 
redundant code.

This fixes coccinelle warning such as:
drivers/scsi/elx/libefc_sli/sli4.c:2320:2-4: WARNING: possible
condition with no effect (if == else)

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
v1->v2
Modified patch and verified with checkpatch.pl.

---
 drivers/scsi/elx/libefc_sli/sli4.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 8f96049f62dd..af661b769464 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -2317,13 +2317,6 @@ sli_xmit_bls_rsp64_wqe(struct sli4 *sli, void *buf,
 		SLI4_GENERIC_CONTEXT_VPI << SLI4_BLS_RSP_WQE_CT_SHFT;
 		bls->context_tag = cpu_to_le16(params->vpi);
 
-		if (params->s_id != U32_MAX)
-			bls->local_n_port_id_dword |=
-				cpu_to_le32(params->s_id & 0x00ffffff);
-		else
-			bls->local_n_port_id_dword |=
-				cpu_to_le32(params->s_id & 0x00ffffff);
-
 		dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
 			       (params->d_id & SLI4_BLS_RSP_RID);
 
-- 
2.25.1


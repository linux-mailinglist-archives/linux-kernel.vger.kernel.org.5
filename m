Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2677F57E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350422AbjHQLnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350410AbjHQLnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:43:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0C2198C;
        Thu, 17 Aug 2023 04:43:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb84194bf3so49161895ad.3;
        Thu, 17 Aug 2023 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692272588; x=1692877388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45rLKFe/XGdWEKHKL/OvhqCh4xyXYRWTSCuP5teWtaA=;
        b=PsO2n5E3s0Nq8bo5r7Wbpoo97Bw4xVKOmW9g+n/5j1f96rtp8ah+m0dGMPO0tzt3d8
         WlyrW7jIxqqObwuKgO3Dy4mkQD+I4n091NzGIMmRqvRzewT1XDngW+7abAvyjbI0yKdu
         amyTa9kr/u50Vi8Zsiw6FnqmHZ1Uc6AEAzAZvsjqE/Qr9FU/7HMbWQS1Jj6TOck4/VD/
         BgZBIN4KI0VYY0m38b6WnMi6mbODbZ5tmdcV+3DfUswxbDIo2kDiTWrBK14IPCI9HmEO
         Am+L6pX/vxkCL0Gri+6eB2jFJYAUlhJQz9hQhqkmY+0qqJnZ4TRUVErPuQ4n21cahIZx
         aniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272588; x=1692877388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45rLKFe/XGdWEKHKL/OvhqCh4xyXYRWTSCuP5teWtaA=;
        b=WouLOEQ55XMkTbT+V6XfB1LIcA6flFO5E1YqqvijEuton3bgqNVzfVETe5dhIT8E7O
         wLUb5gEWKxiajCK5Bum6sdtjP4DCHt3TCRAmlgGZDVELNLj7jHaPcAjmXrqGVIrlGSbl
         9TIt+YkOeU81QKjmBJHmXtkjCHPsLS3Us/3h1gwvnrWG/zg+lRwKfy2lnEIw3RSFR/WA
         KfuLbwbJ4geCEg0prcq6qj6DBOQjDH3UlJ6xWYvI11jRQzj5nv/pZPuO7nYK6VfwZdRS
         sFmSWkRfzmm1pguIVkGq9+iGUIt6BSGK+Tz2yZSdRA6pAL6nfTv1FlMmrDFNjkmT1X7I
         dyYA==
X-Gm-Message-State: AOJu0Yz37c8tWZPKeNb2LrvhfRxfyjS/Sh2alZc1ib4/KgCjmh/D+/Sn
        eVmr7XKnHl5ULVnEfTWaaF4=
X-Google-Smtp-Source: AGHT+IEW0RBHUjzorOFWrjg2otfzDibWdKDDtxIBhh0+8BxwA+o0wRWvCn53MdbaZnI7SyLeOBTsAg==
X-Received: by 2002:a17:902:db0e:b0:1bb:25bd:d091 with SMTP id m14-20020a170902db0e00b001bb25bdd091mr4862224plx.30.1692272588373;
        Thu, 17 Aug 2023 04:43:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1016:aeca:454:68e4:51c8:d1cf])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b001bb9d6b1baasm14951767plb.198.2023.08.17.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 04:43:07 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        rdunlap@infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v3] scsi: sli4: Remove code duplication
Date:   Thu, 17 Aug 2023 17:13:01 +0530
Message-Id: <20230817114301.17601-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

In the function sli_xmit_bls_rsp64_wqe, the 'if' and 'else' conditions
evaluates the same expression and gives same output. Also, params->s_id
shall not be equal to U32_MAX. Therefore removing the unused code.

This fixes coccinelle warning such as:
drivers/scsi/elx/libefc_sli/sli4.c:2320:2-4: WARNING: possible
condition with no effect (if == else)

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
v1->v2
Modified patch and the corrected the warnings using checkpatch.
v2->v3
Modified patch details keeping HW descriptor variable.

---
 drivers/scsi/elx/libefc_sli/sli4.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 8f96049f62dd..5e7fb110bc3f 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -2317,12 +2317,8 @@ sli_xmit_bls_rsp64_wqe(struct sli4 *sli, void *buf,
 		SLI4_GENERIC_CONTEXT_VPI << SLI4_BLS_RSP_WQE_CT_SHFT;
 		bls->context_tag = cpu_to_le16(params->vpi);
 
-		if (params->s_id != U32_MAX)
-			bls->local_n_port_id_dword |=
-				cpu_to_le32(params->s_id & 0x00ffffff);
-		else
-			bls->local_n_port_id_dword |=
-				cpu_to_le32(params->s_id & 0x00ffffff);
+		bls->local_n_port_id_dword |=
+			cpu_to_le32(params->s_id & 0x00ffffff);
 
 		dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
 			       (params->d_id & SLI4_BLS_RSP_RID);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05677DCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbjHPIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243071AbjHPIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:50:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E6CB9;
        Wed, 16 Aug 2023 01:50:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565ea1088fbso836036a12.2;
        Wed, 16 Aug 2023 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692175815; x=1692780615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eRsINPgpxkvQxXZIsw3b1mbCLVjAw0qj7X5Yoa2AdQ=;
        b=EXuOgcs5leGr6lrNtouluD66V/+g+wcjBC8VncFDX/z5oSxbNv8lniPRWgcIkIU517
         kvY+gOuyUDYz4FHfXQjNnB2cn/1wibvt3Ofh80i8/X8O2o4B6pH/cYaLPWV1gOHVKBSs
         mMLPvEPtnNrxskvrQxm3MyjqQ2irEf4xYQKipJfWHj8FrgiwJ3OacVkezSC2BTtLA3PG
         +dcxy9sh/sTk6FPldqdXkAWheOLRAF6WO7eVV2EoVIyYBKTCaMRx1aVGyKDzBe+5aMvX
         +5K2JkAmIeeEclgzYDSxrLEM3hPxXHvPgyHK7ebXfDRcd+br+o33G+k0TK52Ts8PWQoY
         gR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692175815; x=1692780615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eRsINPgpxkvQxXZIsw3b1mbCLVjAw0qj7X5Yoa2AdQ=;
        b=MHkkQBZUpFaJyzR2J4DJ7g9tw1yGwY8Xkhghqh4TsfmWwonbsVEgfI21izS/7YDBtT
         o6gUYWMEuDaHGtMqeQw6pB0Ysr9NQrrGg4Cz/ePsLNOOhdII4wCbUdhNCMjJ+WyaZ0gQ
         PoxfZamo28lC0aGAPrSr5nGei1AiPufuBYP2lrJ/GbM3z9VkpRkDwib5aeBYz0WP2EeL
         nzXYihpm/t+dGz+PtUcHVo0Hf3QAWv8ZCTtF/Q+qX3lLfXefviJbYjm5fbPPxRyNc6RI
         SOyMJbzXqFox08QC5dWraDkIlnN37I1jVbIyzR8u0bZTNsJL8UV6ZC6gLGrrsg+tVTFU
         YcQw==
X-Gm-Message-State: AOJu0YxOrsMy3a8jnmo9Q9r8oTNe58fF2VSMLYaMKT76GDi9JBdOWqIl
        eNP9HBGugmGNc9FNDYne/QM=
X-Google-Smtp-Source: AGHT+IEwBVEqGJfVVew3i80dbzb/4zO2dSuu0e4uG1Qf05xeb9utK3KlIXl5ZZBY604UBE7xJajVjw==
X-Received: by 2002:a05:6a20:734b:b0:137:8599:691e with SMTP id v11-20020a056a20734b00b001378599691emr1563784pzc.49.1692175814754;
        Wed, 16 Aug 2023 01:50:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100b:771e:e5ae:d854:9f75:d38f])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b00682669dc19bsm10529706pfi.201.2023.08.16.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:50:14 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        rdunlap@infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH] scsi: sli4: Remove code duplication
Date:   Wed, 16 Aug 2023 14:20:07 +0530
Message-Id: <20230816085007.10591-1-coolrrsh@gmail.com>
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
evaluates the same expression and gives same output. So removing the redundant 
code duplication to optimise the code.

This fixes warning such as:
drivers/scsi/elx/libefc_sli/sli4.c:2320:2-4: WARNING: possible condition with no effect (if == else)

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
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


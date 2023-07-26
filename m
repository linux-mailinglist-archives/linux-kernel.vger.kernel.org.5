Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6482D763E32
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGZSNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGZSNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:13:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14656E4D;
        Wed, 26 Jul 2023 11:13:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8ad356fe4so373505ad.2;
        Wed, 26 Jul 2023 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690395213; x=1691000013;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwiSFj0tl/R+2ypAV/GDIAiCwQG00lhPHhABGlY+Hic=;
        b=pvxRPcRPGAfCe4SrvnDaqzurhrKOcVas4Tnt6r7ITP3DnKTAdadQeNOZIYtvxZlyDn
         DozhwK9IGtgCBWi3ffcMC796lhCxm+gzK2j9eyKV95IPGS8xj+8f2FDv/JB5ovIsi5UD
         qt/8yTjnGNgleKv7v8WrBjBeJogMfejzAlE3SL+rMfERO6ucZIKXksiZVZQxIOZq65B5
         Te2OlQwqeJbvNcZwIOAr0gAkZbUPY1eCfToHo7n8vHhiGE46COkFmR7//Wu2tE2h1BSV
         BfhYiR8hECg45x0FqEJYUSKeCgH472DOcTHMgd2T7pCv+vwrYCYh6ITmAN924aXho4lc
         mJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690395213; x=1691000013;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwiSFj0tl/R+2ypAV/GDIAiCwQG00lhPHhABGlY+Hic=;
        b=djFQyhEwBQOVcFLMqOZcpIAlHy9IU9cptrzQRUVzV/GDtVvyDyT+khD2uq2PE6U9DT
         eGsqfl7VEaL5Ifb2PZCM9He4stSTpVjYWlsZIP7jvSSpBkHZqOyTYT9WUw35LKfL//eR
         MU8YlMYGzL6+yqMv5H85F07lxKuSYIn34D5Eo4rMrZSu4c2FOyan2qJ/vQBvv9XCvGVG
         D6uomz92sTzTDlzycf2fUb/T3JNKP40Mhzz1V/0GrXlZV9XEntaa7ndydyYGGHlrbv00
         uScE8u8iyuwmei5P3jlAf8NQI3CpOPTWrOLtLhfPbi902YRg9TZwnxdeE7Q/1zwTMt8v
         yIWA==
X-Gm-Message-State: ABy/qLZNmHs5AU/AShaKfUpKqmgmic/NVhyw4nyVzDSb89YnAmjFEWG3
        hYFJDFGzUMunjecSrG+4ovU=
X-Google-Smtp-Source: APBJJlENsKtAIdpEBIKfw+s/pPsgNv0zC1TAnGLqNZq+eoO8cyf+D7Fq22VDKCbbaFYZ8L+dGs9mQA==
X-Received: by 2002:a17:903:181:b0:1b1:ae33:30de with SMTP id z1-20020a170903018100b001b1ae3330demr2839399plg.13.1690395213483;
        Wed, 26 Jul 2023 11:13:33 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001bb8be10a84sm9100254plc.304.2023.07.26.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:13:32 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        justin.tee@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] scsi: lpfc: Fix potential deadlock on &ndlp->lock
Date:   Wed, 26 Jul 2023 18:13:22 +0000
Message-Id: <20230726181322.26754-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &ndlp->lock is acquired by timer lpfc_els_retry_delay() under softirq
context, process context code acquiring the lock &ndlp->lock should
disable irq or bh, otherwise deadlock could happen if the timer preempt
the execution while the lock is held in process context on the same CPU.

The two lock acquisition inside lpfc_cleanup_pending_mbox() does not
disable irq or softirq.

[Deadlock Scenario]
lpfc_cmpl_els_fdisc()
    -> lpfc_cleanup_pending_mbox()
    -> spin_lock(&ndlp->lock);
        <irq>
        -> lpfc_els_retry_delay()
        -> lpfc_nlp_get()
        -> spin_lock_irqsave(&ndlp->lock, flags); (deadlock here)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

The patch fix the potential deadlock by spin_lock_irq() to disable
irq.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 58d10f8f75a7..8555f6bb9742 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -21049,9 +21049,9 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 				mb->mbox_flag |= LPFC_MBX_IMED_UNREG;
 				restart_loop = 1;
 				spin_unlock_irq(&phba->hbalock);
-				spin_lock(&ndlp->lock);
+				spin_lock_irq(&ndlp->lock);
 				ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-				spin_unlock(&ndlp->lock);
+				spin_unlock_irq(&ndlp->lock);
 				spin_lock_irq(&phba->hbalock);
 				break;
 			}
@@ -21067,9 +21067,9 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 			ndlp = (struct lpfc_nodelist *)mb->ctx_ndlp;
 			mb->ctx_ndlp = NULL;
 			if (ndlp) {
-				spin_lock(&ndlp->lock);
+				spin_lock_irq(&ndlp->lock);
 				ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-				spin_unlock(&ndlp->lock);
+				spin_unlock_irq(&ndlp->lock);
 				lpfc_nlp_put(ndlp);
 			}
 		}
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A5E763D63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGZROi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGZROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:14:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C061739;
        Wed, 26 Jul 2023 10:14:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668704a5b5bso94109b3a.0;
        Wed, 26 Jul 2023 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690391676; x=1690996476;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8QZa7qTEmGwCyA0yfHV1JjhyFQSM3L1Bj9irGZtMbI=;
        b=V5ourLyDBFitbj6i3NSu7Ce7nyCxoe4wZz6T48QqcrhwAyGppGZo6/+WkRI9pTCQhc
         ZKv2sR5SfQnbXhe8eslmUHoLwz/Dk2cyZSCWcaACOGBdVZueFvu5ixTwrS09deJZEeCl
         ggNyP8W+/4g2znmswMkpzWrVAtkKCAh36eSKLciRAPRvDQhheqyFytgwdBoZG4Ecxs/y
         JTAnoH6VABAO9MSHILqEdWZ1xznhrFaW/CWQxP6nx0FD9x8BsFJjFQ27EzuMopLeSN/E
         vIUvuUTPiuI3TdlPaDwPH2zPABN0ZDf+Y6vAALJ46Eq9cz21qVSeIhwttVhqxNA3p49O
         evtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690391676; x=1690996476;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8QZa7qTEmGwCyA0yfHV1JjhyFQSM3L1Bj9irGZtMbI=;
        b=NyO5sWF/JPJqjxvsdtAGbJjzauSLTQmSI2r9QMtNtmYeXv6BTW8XeaWhqhofRZfy9P
         79Max51NegOagbu5MbVniqZyEundi9+SG7BhFZYyirk7kKOIB6YguD1bSiw/QliCVIDR
         O/yyTnvx37K45WjFmbk8C4f6brz2rhEOks3aNP/lTOgUmpslgRcUD6d/hntym3VNwWBJ
         ZV1EuHHjDQXEY4syUNftBxDFReCcXoKm+6dQdHlhit5eqetWOAvTTaSuhBnWMCyu3rWU
         JCggWf5l9+TGuKemJwwBmLVT9xeeb2exIJwfKNETFiActgfqEVLeqw7CS+hEKCgHuNtE
         ypoA==
X-Gm-Message-State: ABy/qLYQz+IZW/h1VzBkasLRD6nL7QuOwRnKiGI4dfxOrFNMcTdjG1NF
        5OC6BxacCmQ1fisIXvIPu8I=
X-Google-Smtp-Source: APBJJlF9uZ/TB0GtcuHXezMc7d0QCA7hQiP905LgZ3w0DZ1XDY4QZ9iUrKmEg++RMxvAb8QwPjMcLA==
X-Received: by 2002:a05:6a00:2d01:b0:686:b662:f303 with SMTP id fa1-20020a056a002d0100b00686b662f303mr3540492pfb.0.1690391675815;
        Wed, 26 Jul 2023 10:14:35 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id k196-20020a633dcd000000b005501b24b1c9sm12688361pga.62.2023.07.26.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 10:14:35 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        justin.tee@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: lpfc: Fix potential deadlock on &ndlp->lock
Date:   Wed, 26 Jul 2023 17:14:23 +0000
Message-Id: <20230726171423.18692-1-dg573847474@gmail.com>
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
context, process context code acquiring the lock &phba->hbalock should
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


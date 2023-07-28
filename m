Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFBC76756A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjG1S23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjG1S1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:27:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D55244BE;
        Fri, 28 Jul 2023 11:27:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55bac17b442so1711457a12.3;
        Fri, 28 Jul 2023 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690568765; x=1691173565;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAtgBupKkmJANisZxsV/A8KbRVbGfP4y5JFkhGvsuCA=;
        b=c78uotqEs162djMi3AxdLn4LbmmXt7Mtk8v+dcJtxlTYks0pXrr2wcQHXonUP+dPBH
         WuKR0R4u712pZRzHIuR3/Qt7TqPwv0vyi+PEOyVpVb+N11oqpO5qScS/F4ZdmusU2MFQ
         IYwaM5MnK8wFIrWG0UCt1hiRGvR2vxk628G1ShRLpBkVJI522RvLlRSZeVr+bJ5eqmp9
         w5MfP+WsSClb30Jqzbolk+mDHhPXeadaz6P9NaZi3I5ruLyKbTtHLfUdoLkd8qG/f9st
         EOzqTTvNpQ2mwT/tq0scFbiAEO62M11gdXoospjg5wiPjf85utZf4TJk40T51RFr+eMI
         y9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690568765; x=1691173565;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAtgBupKkmJANisZxsV/A8KbRVbGfP4y5JFkhGvsuCA=;
        b=fWQgInJEETb9YuMfyyHzGoO1cci9Vk8eydAinx/9slLS6FdPmB4oDJiPS4FKfYir8z
         XBdxo/Uy8vn/27j+ft8d84eQvXIR9abF4BcKTHeqZ/0OQEdunizXjTjJCPK7PYK016OQ
         /wimTZTy7KWSfi3dL9r8egoHO8iIiMjnbGOYdT6DZ8jFyMimaDnjkod+fGRkO4lIeRji
         JcjB5x0makZMUHJReGLHi56wtIalwDSj6vf90XPX7/22eUxpaQXSrrDE/dNBRgVV3Ou9
         sodYo1KklQAEWTNCoI1LI9yfpkWhOAeBr/hLh8WW8x61NuKPoc3QSP6EXNEjHl24O6EL
         vQ/w==
X-Gm-Message-State: ABy/qLZgrlPX7jNzfVwm+lVjTfaloErCj+EHxOGyZxoEVoDO78vkns+f
        shWnxK8WFLbCqWPHJzE3WNE=
X-Google-Smtp-Source: APBJJlEy+cEJXsT8/Tzdp2unllMozrQBH6PtV/dv7XTOBjF+e0TneXDt8Oa/NcyXsNChXyJ/19hGwg==
X-Received: by 2002:a17:90b:4d92:b0:268:14d7:bc34 with SMTP id oj18-20020a17090b4d9200b0026814d7bc34mr2413761pjb.20.1690568765503;
        Fri, 28 Jul 2023 11:26:05 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm5680504pjb.1.2023.07.28.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:26:04 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: megaraid: Fix potential deadlock on &adapter->lock
Date:   Fri, 28 Jul 2023 18:25:54 +0000
Message-Id: <20230728182554.5112-1-dg573847474@gmail.com>
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

As &adapter->lock is acquired by megaraid_isr_iomapped() under irq context,
process context code acquiring the lock should disable irq, otherwise
deadlock could happen if the irq preempt the execution while the
lock is held in process context on the same CPU.

Lock acquisition of &adapter->lock in megaraid_reset_handler() does not 
disable irq. Inside the function there is a calling sequence shows like 
the below where irq is re-enabled by spin_unlock_irqrestore() on
PENDING_LIST_LOCK(adapter).

  spin_lock_irqsave(PENDING_LIST_LOCK(adapter), flags);
  ...
  spin_unlock_irqrestore(PENDING_LIST_LOCK(adapter), flags);

  spin_lock(&adapter->lock)
  ...
  spin_unlock(&adapter->lock)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The patch fix the potential deadlock by also use spin_lock_irqsave() on
&adapter->lock.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index ef2b6380e19a..7edddefcc9a3 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -2603,7 +2603,7 @@ megaraid_reset_handler(struct scsi_cmnd *scp)
 		msleep(1000);
 	}
 
-	spin_lock(&adapter->lock);
+	spin_lock_irqsave(&adapter->lock, flags);
 
 	// If still outstanding commands, bail out
 	if (adapter->outstanding_cmds) {
@@ -2643,7 +2643,7 @@ megaraid_reset_handler(struct scsi_cmnd *scp)
 	}
 
  out:
-	spin_unlock(&adapter->lock);
+	spin_unlock_irqrestore(&adapter->lock, flags);
 	return rval;
 }
 
-- 
2.17.1


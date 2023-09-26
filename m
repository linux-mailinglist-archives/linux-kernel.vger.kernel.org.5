Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A221A7AEAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjIZLAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZLAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:00:37 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C01E5;
        Tue, 26 Sep 2023 04:00:30 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57b6c7d0cabso4112181eaf.1;
        Tue, 26 Sep 2023 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695726030; x=1696330830; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTPDkDgir8+eHfv6boD534YZzvgH26+lz36TV282DbM=;
        b=LVgc1ALtbwjzgDg03yGy2y5gqqwYBDjHSocqc0f29YKO8+fAJEjafreUS0n6tZDSqB
         nTKIZtL+lcaqArIyl5icBayCWTt7uHdCm7WzK9PBcIPtpa10pPeUhpLDYEcGl8dcsR4V
         jhE8FcehywPXu+tm5jdgEkk0bXZQl6HvGfKLzq5j+IPVJBA7Frro/tWFAS1pPvOfQAyS
         1gqk5uK8CMgfsJEzbNjeEnQvwcMF5JUBa0Cyb5gLakuX53WG1Rm2Kfvdi6xYoET8J+Ko
         hUDL3BQDifjnT53OiwIk31vWnzW5EGWkNXevO8d/HkGzZpCm2HzJVieiYlUgrqtxK1bo
         GVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695726030; x=1696330830;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTPDkDgir8+eHfv6boD534YZzvgH26+lz36TV282DbM=;
        b=LLl0mwjInuvjqJestGeqpx7c7CNEY5yUYW+Le2xGXO+OfedwzVUBtqfOGEh1hVfe6I
         zavZh2dS/5QjWUuFThPTlkK7X4mkJhH5tzXM9MWkemFBm2kchmkzcuzJeb+NIuMYg9RA
         GtX3alxnpe+m4yFUEgaLUFST3il1GL7ddW/5HThLj2O2YYw0s2JuW+ZaSEfIg2Zh5lvz
         e+eeU/wU5iHKvWLS2N2dsicuHAORlmkdx/oReRpt+rK3EW5ZJXpmQRGhK6UMeQGLcM+I
         WAWGIvS2LpiSEpAUQwwI2rFp2vxkXZwW2xBHs+XpswKaEE8MO67HsiygLe69fKwVkdf7
         OcSw==
X-Gm-Message-State: AOJu0Yzz4JLiRL6KNT+eRo/M+WxUwPm1G6NerrD6xWSFRAP2X3ifHPFz
        zj+mw9s7jcH0ClvWoHfXWoA=
X-Google-Smtp-Source: AGHT+IHnu+BWdXWBZ09+ZCb+3MXaniluv7grLsU7oTuQmYxkXqMwoKHRxw/YVOW8PHtm1snmZM1pOQ==
X-Received: by 2002:a05:6358:720c:b0:13f:e3eb:53a6 with SMTP id h12-20020a056358720c00b0013fe3eb53a6mr10456231rwa.30.1695726029822;
        Tue, 26 Sep 2023 04:00:29 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id fm18-20020a056a002f9200b00690d7da743dsm9720387pfb.161.2023.09.26.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:00:29 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] drbd: Fix potential deadlock on &session->back_lock and &session->frwd_lock
Date:   Tue, 26 Sep 2023 11:00:18 +0000
Message-Id: <20230926110018.11344-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timer interrupt could introduce inverse lock ordering between
&session->frwd_lock and &session->back_lock if qedi_tmf_resp_work()
is interrupted by timer.

<Deadlock #1>

          [CPU0]                            |          [CPU1]
qedi_tmf_resp_work()                        |
--> spin_lock(&session->back_lock)          |
                                            | iscsi_eh_cmd_timed_out()
                                            | --> spin_lock_bh(&session->frwd_lock)
                                            |
                                            | --> spin_lock(&session->back_lock)
<timer interrupt>                           |
   --> iscsi_tmf_timedout()                 |
   --> spin_lock(&session->frwd_lock)       |

<Deadlock #2>

          [CPU0]                            |          [CPU1]
qedi_tmf_resp_work()                        |
--> __iscsi_complete_pdu()                  |
--> spin_lock(&conn->session->frwd_lock)    |
                                            | qedi_process_async_mesg()
                                            | --> spin_lock_bh(&session->back_lock)
                                            |
                                            | --> __iscsi_complete_pdu()
                                            | --> spin_lock(&conn->session->frwd_lock)
<timer interrupt>                           |
   --> iscsi_check_transport_timeouts()     |
   --> iscsi_send_nopout()                  |
   --> iscsi_alloc_mgmt_task()              |
   --> iscsi_put_task()                     |
   --> spin_lock_bh(&session->back_lock)    |

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch use spin_lock_bh()
on &session->back_lock inside qedi_tmf_resp_work() to prevent the
timer interrupts.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/qedi/qedi_fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 6901738324da..60a168ca178c 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -162,9 +162,9 @@ static void qedi_tmf_resp_work(struct work_struct *work)
 	if (rval)
 		goto exit_tmf_resp;
 
-	spin_lock(&session->back_lock);
+	spin_lock_bh(&session->back_lock);
 	__iscsi_complete_pdu(conn, (struct iscsi_hdr *)resp_hdr_ptr, NULL, 0);
-	spin_unlock(&session->back_lock);
+	spin_unlock_bh(&session->back_lock);
 
 exit_tmf_resp:
 	kfree(resp_hdr_ptr);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477157D3088
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjJWK7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjJWK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:59:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8DD7B;
        Mon, 23 Oct 2023 03:59:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40842752c6eso25439335e9.1;
        Mon, 23 Oct 2023 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698058778; x=1698663578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6j/2ifCE0YHhbOaZeNpHrEB/O9NJfSeX3Pim8KYVnc=;
        b=L935+M5dhUVdxDzg3gfK3SBF9HVkwqn+BFtKDZZPXjQLMaq6xM5Ng9J7a3hCzIuXGv
         oyV6bP7czvtmNKrKnRCkvh+HOxwOkPXOVy/7wX+NBsCYF3a9QO8XZgtk6UfS0jlXMf16
         mPzznZLOQHLEvs8/i2+20V7kwRGQDI+luLbYPNXh5JdJQB+dWP3WUEo2cIrtyI48Eibo
         1Zj0dX2IC7vhRIWNrPeSFdxwhx1li/cZDhCNL4nAyxHZwaRiOT5vvgW1XTdnU8MjSr86
         MjipjAfzZ7rQCm7h8ewuR/a+wGK+4EMx0ROxexjtwuBmAbXvFF2y+M7viue42W/5gTPQ
         ejOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698058778; x=1698663578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6j/2ifCE0YHhbOaZeNpHrEB/O9NJfSeX3Pim8KYVnc=;
        b=HNXCCiIBWfirh/QL0hFZkcHZgZ9OlTlD+XY0Kx6M2lA2rHKTvQeEE1v9BVDZxUpAx6
         usXwxWnXCg9NyUzRZJZT4uJbpr0yHHsqVFI+OkzaitwQzNDlv7+Z8EyOQzmCfsDF6+bl
         LHJSfHBpy+EPggJL11r6c+aF8NwAV3sME8UxtLYNDHPK0pE88qVOr+2ZdV+yzfgm2oVc
         wEHRHFVhHFyCmICYfxi7ic2c6PQ4JEgCwEN7fXnji2nn6E8pL0dLizAPzrtY/iGYW6/2
         za6HKRD46PmS8IO/YWUPJK1oE2D//TbZp8XlaxL6Bci8X4RZd+IKVu5BCOoGNcHXHfFJ
         iypA==
X-Gm-Message-State: AOJu0YxgPG5cNGxDEHJ3tSUOxcKI0p3/1TJF9yKnRr2l2koCodKbjK1m
        ZpKA9pZH8rUlUgBtY/0wZpqN3lFoeSDnmh1x
X-Google-Smtp-Source: AGHT+IFNvqXJ0qeH+NAb1NocV3+Zb3vKkqelKbIBqGdq0v+QqLzLBUHvw47txyaSdmEd+EyiVzityQ==
X-Received: by 2002:a05:600c:310d:b0:405:3dee:3515 with SMTP id g13-20020a05600c310d00b004053dee3515mr7291068wmo.27.1698058777930;
        Mon, 23 Oct 2023 03:59:37 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c210100b004068de50c64sm9002471wml.46.2023.10.23.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:59:37 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     martin.petersen@oracle.com, bostroesser@gmail.com,
        michael.christie@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] drivers: target: Fixed multiple typos in multiple files
Date:   Mon, 23 Oct 2023 15:59:15 +0500
Message-Id: <20231023105915.29482-1-m.muzzammilashraf@gmail.com>
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

iscsi: iscsi_target.c: Fixed typo
iscsi: iscsi_target_login.c: Fixed typo
iscsi: iscsi_target_nego.c: Fixed typo
iscsi: iscsi_target_parameters.h: Fixed typo
iscsi: iscsi_target_tpg.c: Fixed typo
target_core_sbc.c: Fixed typo
target_core_transport.c: Fixed typo
target_core_user.c: Fixed typo
target_core_xcopy.h: Fixed typo
tcm_fc: tfc_conf.c: Fixed typo
tcm_fc: tfc_sess.c: Fixed typo

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 drivers/target/iscsi/iscsi_target.c            | 2 +-
 drivers/target/iscsi/iscsi_target_login.c      | 2 +-
 drivers/target/iscsi/iscsi_target_nego.c       | 4 ++--
 drivers/target/iscsi/iscsi_target_parameters.h | 2 +-
 drivers/target/iscsi/iscsi_target_tpg.c        | 2 +-
 drivers/target/target_core_sbc.c               | 2 +-
 drivers/target/target_core_transport.c         | 4 ++--
 drivers/target/target_core_user.c              | 4 ++--
 drivers/target/target_core_xcopy.h             | 2 +-
 drivers/target/tcm_fc/tfc_conf.c               | 2 +-
 drivers/target/tcm_fc/tfc_sess.c               | 4 ++--
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 1d25e64b068a..b1d61f717b3d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4591,7 +4591,7 @@ static void iscsit_logout_post_handler_closesession(
 	/*
 	 * Traditional iscsi/tcp will invoke this logic from TX thread
 	 * context during session logout, so clear tx_thread_active and
-	 * sleep if iscsit_close_connection() has not already occured.
+	 * sleep if iscsit_close_connection() has not already occurred.
 	 *
 	 * Since iser-target invokes this logic from it's own workqueue,
 	 * always sleep waiting for RX/TX thread shutdown to complete
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 90b870f234f0..761d2783c89c 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -570,7 +570,7 @@ int iscsi_login_post_auth_non_zero_tsih(
 	/*
 	 * By following item 5 in the login table,  if we have found
 	 * an existing ISID and a valid/existing TSIH and an existing
-	 * CID we do connection reinstatement.  Currently we dont not
+	 * CID we do connection reinstatement.  Currently we don't not
 	 * support it so we send back an non-zero status class to the
 	 * initiator and release the new connection.
 	 */
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index fa3fb5f4e6bc..ca24804e5386 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -557,7 +557,7 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 	 * before initial PDU processing in iscsi_target_start_negotiation()
 	 * has completed, go ahead and retry until it's cleared.
 	 *
-	 * Otherwise if the TCP connection drops while this is occuring,
+	 * Otherwise if the TCP connection drops while this is occurring,
 	 * iscsi_target_start_negotiation() will detect the failure, call
 	 * cancel_delayed_work_sync(&conn->login_work), and cleanup the
 	 * remaining iscsi connection resources from iscsi_np process context.
@@ -1050,7 +1050,7 @@ static int iscsi_target_do_login(struct iscsit_conn *conn, struct iscsi_login *l
 				/*
 				 * Check to make sure the TCP connection has not
 				 * dropped asynchronously while session reinstatement
-				 * was occuring in this kthread context, before
+				 * was occurring in this kthread context, before
 				 * transitioning to full feature phase operation.
 				 */
 				if (iscsi_target_sk_check_close(conn))
diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/target/iscsi/iscsi_target_parameters.h
index 00fbbebb8c75..c143d487afa8 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.h
+++ b/drivers/target/iscsi/iscsi_target_parameters.h
@@ -95,7 +95,7 @@ extern void iscsi_set_session_parameters(struct iscsi_sess_ops *,
 #define OFMARKINT			"OFMarkInt"
 
 /*
- * Parameter names of iSCSI Extentions for RDMA (iSER).  See RFC-5046
+ * Parameter names of iSCSI Extensions for RDMA (iSER).  See RFC-5046
  */
 #define RDMAEXTENSIONS			"RDMAExtensions"
 #define INITIATORRECVDATASEGMENTLENGTH	"InitiatorRecvDataSegmentLength"
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index f7bac98fd4fe..23478c8957df 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -313,7 +313,7 @@ int iscsit_tpg_enable_portal_group(struct iscsi_portal_group *tpg)
 	}
 	/*
 	 * Make sure that AuthMethod does not contain None as an option
-	 * unless explictly disabled.  Set the default to CHAP if authentication
+	 * unless explicitly disabled.  Set the default to CHAP if authentication
 	 * is enforced (as per default), and remove the NONE option.
 	 */
 	param = iscsi_find_param_from_key(AUTHMETHOD, tpg->param_list);
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 6a02561cc20c..35dfe5cb40ec 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -573,7 +573,7 @@ sbc_compare_and_write(struct se_cmd *cmd)
 	int rc;
 	/*
 	 * Submit the READ first for COMPARE_AND_WRITE to perform the
-	 * comparision using SGLs at cmd->t_bidi_data_sg..
+	 * comparison using SGLs at cmd->t_bidi_data_sg..
 	 */
 	rc = down_interruptible(&dev->caw_sem);
 	if (rc != 0) {
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index c81def3c96df..665eb2d9bc19 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1820,7 +1820,7 @@ EXPORT_SYMBOL_GPL(target_submit_prep);
  * This may only be called from process context, and also currently
  * assumes internal allocation of fabric payload buffer by target-core.
  *
- * It also assumes interal target core SGL memory allocation.
+ * It also assumes internal target core SGL memory allocation.
  *
  * This function must only be used by drivers that do their own
  * sync during shutdown and does not use target_stop_session. If there
@@ -3447,7 +3447,7 @@ static const struct sense_detail sense_detail_table[] = {
 		 * REGISTER AND MOVE service actionis attempted,
 		 * but there are insufficient device server resources to complete the
 		 * operation, then the command shall be terminated with CHECK CONDITION
-		 * status, with the sense key set to ILLEGAL REQUEST,and the additonal
+		 * status, with the sense key set to ILLEGAL REQUEST,and the additional
 		 * sense code set to INSUFFICIENT REGISTRATION RESOURCES.
 		 */
 		.key = ILLEGAL_REQUEST,
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 7eb94894bd68..d13e38fcee4c 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1985,7 +1985,7 @@ static int tcmu_release(struct uio_info *info, struct inode *inode)
 		tcmu_free_cmd(cmd);
 	}
 	/*
-	 * We only freed data space, not ring space. Therefore we dont call
+	 * We only freed data space, not ring space. Therefore we don't call
 	 * run_tmr_queue, but call run_qfull_queue if tmr_list is empty.
 	 */
 	if (freed && list_empty(&udev->tmr_queue))
@@ -3125,7 +3125,7 @@ static ssize_t tcmu_free_kept_buf_store(struct config_item *item, const char *pa
 	tcmu_cmd_free_data(cmd, cmd->dbi_cnt);
 	tcmu_free_cmd(cmd);
 	/*
-	 * We only freed data space, not ring space. Therefore we dont call
+	 * We only freed data space, not ring space. Therefore we don't call
 	 * run_tmr_queue, but call run_qfull_queue if tmr_list is empty.
 	 */
 	if (list_empty(&udev->tmr_queue))
diff --git a/drivers/target/target_core_xcopy.h b/drivers/target/target_core_xcopy.h
index 0aad7dc65895..5337d4f89a8d 100644
--- a/drivers/target/target_core_xcopy.h
+++ b/drivers/target/target_core_xcopy.h
@@ -42,7 +42,7 @@ struct xcopy_op {
 };
 
 /*
- * Receive Copy Results Sevice Actions
+ * Receive Copy Results Service Actions
  */
 #define RCR_SA_COPY_STATUS		0x00
 #define RCR_SA_RECEIVE_DATA		0x01
diff --git a/drivers/target/tcm_fc/tfc_conf.c b/drivers/target/tcm_fc/tfc_conf.c
index 5ee03d1cba2b..4b066e14f885 100644
--- a/drivers/target/tcm_fc/tfc_conf.c
+++ b/drivers/target/tcm_fc/tfc_conf.c
@@ -281,7 +281,7 @@ static void ft_del_tpg(struct se_portal_group *se_tpg)
 
 	destroy_workqueue(tpg->workqueue);
 
-	/* Wait for sessions to be freed thru RCU, for BUG_ON below */
+	/* Wait for sessions to be freed through RCU, for BUG_ON below */
 	synchronize_rcu();
 
 	mutex_lock(&ft_lport_lock);
diff --git a/drivers/target/tcm_fc/tfc_sess.c b/drivers/target/tcm_fc/tfc_sess.c
index 593540da9346..e2ff506ca68d 100644
--- a/drivers/target/tcm_fc/tfc_sess.c
+++ b/drivers/target/tcm_fc/tfc_sess.c
@@ -98,7 +98,7 @@ static void ft_tport_delete(struct ft_tport *tport)
 
 /*
  * Add local port.
- * Called thru fc_lport_iterate().
+ * Called through fc_lport_iterate().
  */
 void ft_lport_add(struct fc_lport *lport, void *arg)
 {
@@ -110,7 +110,7 @@ void ft_lport_add(struct fc_lport *lport, void *arg)
 
 /*
  * Delete local port.
- * Called thru fc_lport_iterate().
+ * Called through fc_lport_iterate().
  */
 void ft_lport_del(struct fc_lport *lport, void *arg)
 {
-- 
2.27.0


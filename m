Return-Path: <linux-kernel+bounces-83509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471FC869A70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E8628DEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408421474A5;
	Tue, 27 Feb 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyHN7Aeo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25E146012
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047910; cv=none; b=pzeM5AR2JKNQ1CozPHCOsB07CZ7kO3m5Tugl+3b7MP3Rpdvhen9TREd6hAO+v3KEh2c3UL5C6YVBMko00sqcaKA6qLfI7oT5sS62DcKIcrxrcyr6VTQYuChjKGAWYfItgsR30oW88Q+IhB+/Uhx66ReBSGsHCNyJnLO2TFv8jCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047910; c=relaxed/simple;
	bh=zLcF/AONIH/HjNAqQzf41Ni8Aqwi/34Hf4FgQAq9R4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHup4azZ8GAbuUf2FXTjLz+JbnTu0adaV0kxnXXxOjjScc5tEUc3Di0fqDqukzPAwD8SHF6hWddqgzpkZo+PNaIEvJASZRfaoAZCr5/x48tHjvSR5bMlTthMGXYLbhd5bKv8zY5gDL+1Mr6uQzfguBcC6Pl4O2e56lY27p4x1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RyHN7Aeo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so6069918e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709047906; x=1709652706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suU2ebEyw3xXlVKWbCLt3I5PCGWr42q4ZsNUvAvwawk=;
        b=RyHN7AeoyzlzRMhKnJRiFPKi5kXzfNA+YgGK5VN914VmRMGui8P0E+Hp84QuhWhXhV
         vHV41DQGQTd46ssaYPHHRnrSWJqNJk+SbkgZVyoozF2iziYDUTRw6y0PSk4a9Bj53a0t
         4HJ+zeoE5wICVa2sTndhKvqVvugG2EAUYQ9BnCymPbAjNxdxSXh2nhe7xEa3/9byC2LT
         adtunHjYlmgOpSLRZE+fWsesR5dVJ/13IOl1bOI1T3h2EpBIzTfao54ctX2aw+Ql61xd
         yr+QqiMwduUqLRXxb8504d/59kmk+KZycJjgoOfzftzY+OwKh32b93Q+LWRH3auEz+WU
         VLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047906; x=1709652706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suU2ebEyw3xXlVKWbCLt3I5PCGWr42q4ZsNUvAvwawk=;
        b=p18zxHOMlOjZ1CY4TF9gzat0wUYEhq4MBxlQWc/YK4xIuy4Er6neWwccyxd91KkHdm
         fQIi5rxCyaa1HxWOLr/dDH3Tj/NmGGpKyr82LfmELV9BwG5y72g2t4ilWyLjd319k5a0
         ULIO20C7TH/Vm4UmiIvF/NtL5aaVdIKCgw4SP2ORsAAvIZWnZxq3O98VVHi+yB8wxs+m
         P8OwTkHFVrjlg4q8BRJpa9POB5fz/DfeMOyB4fPmEuB3ZzBmqNev8VAZ6sT6gLh6xNbr
         B2atJWjKsu/smPu5WcPuOzXNJykmN/O6Wu+KbjPwG4uT1NZM6ZcHBQbMrCfY3lpmN6DY
         gpTQ==
X-Gm-Message-State: AOJu0YxzIy2YmJQQTGhyPfTJccauFNynys5qbnHtsjVLFkvtK6W37jct
	Yh8rkFmjxqU4+ll0n2YIyBaJt5YnK8S+hd4nBTAqcDfk68C2hPxgTyn4v+hxmDoRvWeyThbSEIP
	6
X-Google-Smtp-Source: AGHT+IG7oJ/tq1tKfZeQTA134GKJLnvxSC5CAR567um79ppjIGj04xxslIi7Qry4zEtuvw82nC04XQ==
X-Received: by 2002:a05:6512:3dac:b0:512:ed33:c16 with SMTP id k44-20020a0565123dac00b00512ed330c16mr8378083lfv.8.1709047906331;
        Tue, 27 Feb 2024 07:31:46 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h18-20020a19ca52000000b00513003b8ebesm586969lfj.135.2024.02.27.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:31:45 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 3/3] optee: probe RPMB device using RPMB subsystem
Date: Tue, 27 Feb 2024 16:31:32 +0100
Message-Id: <20240227153132.2611499-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227153132.2611499-1-jens.wiklander@linaro.org>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
use an RPMB device via the RPBM subsystem instead of passing the RPMB
frames via tee-supplicant in user space. A fallback mechanism is kept to
route RPMB frames via tee-supplicant if the RPMB subsystem isn't
available.

The OP-TEE RPC ABI is extended to support iterating over all RPMB
devices until one is found with the expected RPMB key already
programmed.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c          |  55 +++++++
 drivers/tee/optee/ffa_abi.c       |   7 +
 drivers/tee/optee/optee_private.h |  16 ++
 drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
 drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   6 +
 6 files changed, 352 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 3aed554bc8d8..6b32d3e7865b 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/rpmb.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_drv.h>
@@ -80,6 +81,57 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 	shm->pages = NULL;
 }
 
+static void optee_rpmb_scan(struct work_struct *work)
+{
+	struct optee *optee = container_of(work, struct optee, scan_rpmb_work);
+	bool scan_done = false;
+	u32 res;
+
+	do {
+		mutex_lock(&optee->rpmb_dev_mutex);
+		/* No need to rescan if we haven't started scanning yet */
+		optee->rpmb_dev_request_rescan = false;
+		mutex_unlock(&optee->rpmb_dev_mutex);
+
+		res = optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB);
+		if (res && res != TEE_ERROR_STORAGE_NOT_AVAILABLE)
+			pr_info("Scanning for RPMB device: res %#x\n", res);
+
+		mutex_lock(&optee->rpmb_dev_mutex);
+		/*
+		 * If another RPMB device came online while scanning, scan one
+		 * more time, unless we have already found an RPBM device.
+		 */
+		scan_done = (optee->rpmb_dev ||
+			     !optee->rpmb_dev_request_rescan);
+		optee->rpmb_dev_request_rescan = false;
+		optee->rpmb_dev_scan_in_progress = !scan_done;
+		mutex_unlock(&optee->rpmb_dev_mutex);
+	} while (!scan_done);
+}
+
+void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
+			      struct rpmb_dev *rdev)
+{
+	struct optee *optee = container_of(intf, struct optee, rpmb_intf);
+	bool queue_work = true;
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	if (optee->rpmb_dev || optee->rpmb_dev_scan_in_progress) {
+		queue_work = false;
+		if (optee->rpmb_dev_scan_in_progress)
+			optee->rpmb_dev_request_rescan = true;
+	}
+	if (queue_work)
+		optee->rpmb_dev_scan_in_progress = true;
+	mutex_unlock(&optee->rpmb_dev_mutex);
+
+	if (queue_work) {
+		INIT_WORK(&optee->scan_rpmb_work, optee_rpmb_scan);
+		schedule_work(&optee->scan_rpmb_work);
+	}
+}
+
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
@@ -161,6 +213,7 @@ void optee_release_supp(struct tee_context *ctx)
 
 void optee_remove_common(struct optee *optee)
 {
+	rpmb_interface_unregister(&optee->rpmb_intf);
 	/* Unregister OP-TEE specific client devices on TEE bus */
 	optee_unregister_devices();
 
@@ -177,6 +230,8 @@ void optee_remove_common(struct optee *optee)
 	tee_shm_pool_free(optee->pool);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
 }
 
 static int smc_abi_rc;
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408..befe19ecc30a 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -7,6 +7,7 @@
 
 #include <linux/arm_ffa.h>
 #include <linux/errno.h>
+#include <linux/rpmb.h>
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee_cq_init(&optee->call_queue, 0);
 	optee_supp_init(&optee->supp);
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
 	ffa_dev_set_drvdata(ffa_dev, optee);
 	ctx = teedev_open(optee->teedev);
 	if (IS_ERR(ctx)) {
@@ -955,6 +957,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (rc)
 		goto err_unregister_devices;
 
+	optee->rpmb_intf.add_rdev = optee_rpmb_intf_add_rdev;
+	rpmb_interface_register(&optee->rpmb_intf);
 	pr_info("initialized driver\n");
 	return 0;
 
@@ -968,6 +972,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	teedev_close_context(ctx);
 err_rhashtable_free:
 	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
+	rpmb_interface_unregister(&optee->rpmb_intf);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 	mutex_destroy(&optee->ffa.mutex);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 7a5243c78b55..1e4c33baef43 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -8,6 +8,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/rhashtable.h>
+#include <linux/rpmb.h>
 #include <linux/semaphore.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
@@ -20,11 +21,13 @@
 /* Some Global Platform error codes used in this driver */
 #define TEEC_SUCCESS			0x00000000
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_ITEM_NOT_FOUND	0xFFFF0008
 #define TEEC_ERROR_NOT_SUPPORTED	0xFFFF000A
 #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
 #define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
 #define TEEC_ERROR_BUSY			0xFFFF000D
 #define TEEC_ERROR_SHORT_BUFFER		0xFFFF0010
+#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
 
 #define TEEC_ORIGIN_COMMS		0x00000002
 
@@ -197,6 +200,8 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
+ * @mutex:		mutex protecting @rpmb_dev
+ * @rpmb_dev:		current RPMB device or NULL
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -215,9 +220,17 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
+	/* Protects rpmb_dev pointer and rpmb_dev_* */
+	struct mutex rpmb_dev_mutex;
+	struct rpmb_dev *rpmb_dev;
+	bool rpmb_dev_scan_in_progress;
+	bool rpmb_dev_request_rescan;
+	bool rpmb_dev_scan_done;
+	struct rpmb_interface rpmb_intf;
 	unsigned int rpc_param_count;
 	bool   scan_bus_done;
 	struct work_struct scan_bus_work;
+	struct work_struct scan_rpmb_work;
 };
 
 struct optee_session {
@@ -280,8 +293,11 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 
 #define PTA_CMD_GET_DEVICES		0x0
 #define PTA_CMD_GET_DEVICES_SUPP	0x1
+#define PTA_CMD_GET_DEVICES_RPMB	0x2
 int optee_enumerate_devices(u32 func);
 void optee_unregister_devices(void);
+void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
+			      struct rpmb_dev *rdev);
 
 int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 			       size_t size, size_t align,
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
index f3f06e0994a7..f351a8ac69fc 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -16,6 +16,14 @@
  * and sends responses.
  */
 
+/*
+ * Replay Protected Memory Block access
+ *
+ * [in]     memref[0]	    Frames to device
+ * [out]    memref[1]	    Frames from device
+ */
+#define OPTEE_RPC_CMD_RPMB		1
+
 /*
  * Get time
  *
@@ -103,4 +111,31 @@
 /* I2C master control flags */
 #define OPTEE_RPC_I2C_FLAGS_TEN_BIT	BIT(0)
 
+/*
+ * Reset RPMB probing
+ *
+ * Releases an eventually already used RPMB devices and starts over searching
+ * for RPMB devices. Returns the kind of shared memory to use in subsequent
+ * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
+ *
+ * [out]    value[0].a	    OPTEE_RPC_SHM_TYPE_*, the parameter for
+ *			    OPTEE_RPC_CMD_SHM_ALLOC
+ */
+#define OPTEE_RPC_CMD_RPMB_PROBE_RESET	22
+
+/*
+ * Probe next RPMB device
+ *
+ * [out]    value[0].a	    Type of RPMB device, OPTEE_RPC_RPMB_*
+ * [out]    value[0].b	    EXT CSD-slice 168 "RPMB Size"
+ * [out]    value[0].c	    EXT CSD-slice 222 "Reliable Write Sector Count"
+ * [out]    memref[1]       Buffer with the raw CID
+ */
+#define OPTEE_RPC_CMD_RPMB_PROBE_NEXT	23
+
+/* Type of RPMB device */
+#define OPTEE_RPC_RPMB_EMMC		0
+#define OPTEE_RPC_RPMB_UFS		1
+#define OPTEE_RPC_RPMB_NVME		2
+
 #endif /*__OPTEE_RPC_CMD_H*/
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index e69bc6380683..97f69a108f61 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/rpmb.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
@@ -255,6 +256,229 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
 	optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
 }
 
+static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
+					     struct optee *optee,
+					     struct optee_msg_arg *arg)
+{
+	struct tee_param params[1];
+
+	if (!IS_ENABLED(CONFIG_RPMB)) {
+		handle_rpc_supp_cmd(ctx, optee, arg);
+		return;
+	}
+
+	if (arg->num_params != ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	params[0].u.value.a = OPTEE_RPC_SHM_TYPE_KERNEL;
+	params[0].u.value.b = 0;
+	params[0].u.value.c = 0;
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rpmb_dev_put(optee->rpmb_dev);
+	optee->rpmb_dev = NULL;
+	mutex_unlock(&optee->rpmb_dev_mutex);
+
+	arg->ret = TEEC_SUCCESS;
+}
+
+static int rpmb_type_to_rpc_type(enum rpmb_type rtype)
+{
+	switch (rtype) {
+	case RPMB_TYPE_EMMC:
+		return OPTEE_RPC_RPMB_EMMC;
+	case RPMB_TYPE_UFS:
+		return OPTEE_RPC_RPMB_UFS;
+	case RPMB_TYPE_NVME:
+		return OPTEE_RPC_RPMB_NVME;
+	default:
+		return -1;
+	}
+}
+
+static int rpc_rpmb_match(struct rpmb_dev *rdev, const void *data)
+{
+	return rpmb_type_to_rpc_type(rdev->ops->type) >= 0;
+}
+
+static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
+					    struct optee *optee,
+					    struct optee_msg_arg *arg)
+{
+	struct rpmb_dev *rdev;
+	struct tee_param params[2];
+	void *buf;
+
+	if (!IS_ENABLED(CONFIG_RPMB)) {
+		handle_rpc_supp_cmd(ctx, optee, arg);
+		return;
+	}
+
+	if (arg->num_params != ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
+	    params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+	buf = tee_shm_get_va(params[1].u.memref.shm,
+			     params[1].u.memref.shm_offs);
+	if (!buf) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rdev = rpmb_dev_find_device(NULL, optee->rpmb_dev, rpc_rpmb_match);
+	rpmb_dev_put(optee->rpmb_dev);
+	optee->rpmb_dev = rdev;
+	mutex_unlock(&optee->rpmb_dev_mutex);
+
+	if (!rdev) {
+		arg->ret = TEEC_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	if (params[1].u.memref.size < rdev->dev_id_len) {
+		arg->ret = TEEC_ERROR_SHORT_BUFFER;
+		return;
+	}
+	memcpy(buf, rdev->dev_id, rdev->dev_id_len);
+	params[1].u.memref.size = rdev->dev_id_len;
+	params[0].u.value.a = rpmb_type_to_rpc_type(rdev->ops->type);
+	params[0].u.value.b = rdev->capacity;
+	params[0].u.value.c = rdev->reliable_wr_count;
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	arg->ret = TEEC_SUCCESS;
+}
+
+/* Request */
+struct rpmb_req {
+	u16 cmd;
+#define RPMB_CMD_DATA_REQ      0x00
+#define RPMB_CMD_GET_DEV_INFO  0x01
+	u16 dev_id;
+	u16 block_count;
+	/* Optional data frames (rpmb_data_frame) follow */
+};
+
+#define RPMB_REQ_DATA(req) ((void *)((struct rpmb_req *)(req) + 1))
+
+#define RPMB_CID_SZ 16
+
+/* Response to device info request */
+struct rpmb_dev_info {
+	u8 cid[RPMB_CID_SZ];
+	u8 rpmb_size_mult;	/* EXT CSD-slice 168: RPMB Size */
+	u8 rel_wr_sec_c;	/* EXT CSD-slice 222: Reliable Write Sector */
+				/*                    Count */
+	u8 ret_code;
+#define RPMB_CMD_GET_DEV_INFO_RET_OK     0x00
+#define RPMB_CMD_GET_DEV_INFO_RET_ERROR  0x01
+};
+
+static int get_dev_info(struct rpmb_dev *rdev, void *rsp, size_t rsp_size)
+{
+	struct rpmb_dev_info *dev_info;
+
+	if (rsp_size != sizeof(*dev_info))
+		return TEEC_ERROR_BAD_PARAMETERS;
+
+	dev_info = rsp;
+	memcpy(dev_info->cid, rdev->dev_id, sizeof(dev_info->cid));
+	dev_info->rpmb_size_mult = rdev->capacity;
+	dev_info->rel_wr_sec_c = rdev->reliable_wr_count;
+	dev_info->ret_code = RPMB_CMD_GET_DEV_INFO_RET_OK;
+
+	return TEEC_SUCCESS;
+}
+
+/*
+ * req is one struct rpmb_req followed by one or more struct rpmb_data_frame
+ * rsp is either one struct rpmb_dev_info or one or more struct rpmb_data_frame
+ */
+static u32 rpmb_process_request(struct optee *optee, struct rpmb_dev *rdev,
+				void *req, size_t req_size,
+				void *rsp, size_t rsp_size)
+{
+	struct rpmb_req *sreq = req;
+	int rc;
+
+	if (req_size < sizeof(*sreq))
+		return TEEC_ERROR_BAD_PARAMETERS;
+
+	switch (sreq->cmd) {
+	case RPMB_CMD_DATA_REQ:
+		rc = rpmb_route_frames(rdev, RPMB_REQ_DATA(req),
+				       req_size - sizeof(struct rpmb_req),
+				       rsp, rsp_size);
+		if (rc)
+			return TEEC_ERROR_BAD_PARAMETERS;
+		return TEEC_SUCCESS;
+	case RPMB_CMD_GET_DEV_INFO:
+		return get_dev_info(rdev, rsp, rsp_size);
+	default:
+		return TEEC_ERROR_BAD_PARAMETERS;
+	}
+}
+
+static void handle_rpc_func_rpmb(struct tee_context *ctx, struct optee *optee,
+				 struct optee_msg_arg *arg)
+{
+	struct tee_param params[2];
+	struct rpmb_dev *rdev;
+	void *p0, *p1;
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rdev = rpmb_dev_get(optee->rpmb_dev);
+	mutex_unlock(&optee->rpmb_dev_mutex);
+	if (!rdev) {
+		handle_rpc_supp_cmd(ctx, optee, arg);
+		return;
+	}
+
+	if (arg->num_params != ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT ||
+	    params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		goto out;
+	}
+
+	p0 = tee_shm_get_va(params[0].u.memref.shm,
+			    params[0].u.memref.shm_offs);
+	p1 = tee_shm_get_va(params[1].u.memref.shm,
+			    params[1].u.memref.shm_offs);
+	arg->ret = rpmb_process_request(optee, rdev, p0,
+					params[0].u.memref.size,
+					p1, params[1].u.memref.size);
+	if (arg->ret)
+		goto out;
+
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params))
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+out:
+	rpmb_dev_put(rdev);
+}
+
 void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 		   struct optee_msg_arg *arg)
 {
@@ -271,6 +495,15 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 	case OPTEE_RPC_CMD_I2C_TRANSFER:
 		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
 		break;
+	case OPTEE_RPC_CMD_RPMB_PROBE_RESET:
+		handle_rpc_func_rpmb_probe_reset(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_RPMB_PROBE_NEXT:
+		handle_rpc_func_rpmb_probe_next(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_RPMB:
+		handle_rpc_func_rpmb(ctx, optee, arg);
+		break;
 	default:
 		handle_rpc_supp_cmd(ctx, optee, arg);
 	}
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a37f87087e5c..8da53f41b052 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/rpmb.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -1715,6 +1716,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee->smc.memremaped_shm = memremaped_shm;
 	optee->pool = pool;
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
 
 	platform_set_drvdata(pdev, optee);
 	ctx = teedev_open(optee->teedev);
@@ -1769,6 +1771,8 @@ static int optee_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_disable_shm_cache;
 
+	optee->rpmb_intf.add_rdev = optee_rpmb_intf_add_rdev;
+	rpmb_interface_register(&optee->rpmb_intf);
 	pr_info("initialized driver\n");
 	return 0;
 
@@ -1782,6 +1786,8 @@ static int optee_probe(struct platform_device *pdev)
 err_close_ctx:
 	teedev_close_context(ctx);
 err_supp_uninit:
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
 	optee_shm_arg_cache_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
-- 
2.34.1



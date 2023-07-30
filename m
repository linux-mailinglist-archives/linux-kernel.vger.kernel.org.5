Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0665F768667
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjG3QTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjG3QTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:19:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6FC1702;
        Sun, 30 Jul 2023 09:19:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcf2de59cso589895466b.0;
        Sun, 30 Jul 2023 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690733957; x=1691338757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUYRYySpjk8ohdaW/yDF6ftOLcjXMMQdsYiTIF2jWhI=;
        b=QD12hqsMJgaXqcXToADNM5dmMy2Lkg+i8N8XpXnPAHhTvopXxcrbDynB1MogaqKdOD
         opzClWBQyn47NCGV3EHIglzRKCzS7J3fGnpT219a79y+QuYbDe9/QnLxxKHE/oQtRhZd
         zRetlMU+KXKaAuwxP1tpT3nRJ3b1IWqxBrsweXKkaEosGUSzf6LUhqZadACeKPwvd89Z
         6Eq+n9hL+ILbSKH36z7AlNbEZZP1MkVeaQ8WirohhCn3JJWMjKWiV+u0/mrEcG/+aZar
         y2YvX9GrPq9/YBMNxqh3TJahSjybxnOUVA752JjgGX1eVhDvt3qWtApzNwL9gVAseb87
         Pitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690733957; x=1691338757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUYRYySpjk8ohdaW/yDF6ftOLcjXMMQdsYiTIF2jWhI=;
        b=UqhTwDEUCWKRcaopxgd3pDlWO1HhYS9cbzu0BKiKODTCAXdQIO+fbvHjwnrxMdlLTX
         WrrhLR700xBwf8qDX0kLWeFEHVtvWg4oJOuNGUWrP28rJlFInwHcADU1PPwk7cKVbErp
         Bqi6jzL9PPrWbiYjeCfuISM5YR1nufdNcAIQaNQofZEGPGrWOX0fx5zCwS/6XaKi27+4
         ZajKH/DZud/QTP+FEp5Sb1HdpuC3RBO0VOlKrJcd7e2e0pAtQwbZ5/KZlSXXCmelM6f4
         OgYxPpeJc8FnkEJJaTXPXO41fkoN/bIbw9DaevBgl+pbLw+URFImcj1DwHHYKdUbaDr4
         we7g==
X-Gm-Message-State: ABy/qLYlQRgI3iQL1l8EsnGjhngBq1qRAHQLjUXFBtu1OMvGTW4UinjY
        7Io7p5mw8AX5c/nXC1z08U0=
X-Google-Smtp-Source: APBJJlER8y10yssmg+xKisiFZwNFyWqruHA9OqWN2LlpT1/5F5OOLocJ1UX4Vql2JIKhaptb0tfj/w==
X-Received: by 2002:a17:907:2721:b0:988:a578:4d65 with SMTP id d1-20020a170907272100b00988a5784d65mr4413059ejl.32.1690733956437;
        Sun, 30 Jul 2023 09:19:16 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id va16-20020a17090711d000b00992aea2c55dsm4858798ejb.153.2023.07.30.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 09:19:15 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface
Date:   Sun, 30 Jul 2023 18:19:03 +0200
Message-ID: <20230730161906.606163-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730161906.606163-1-luzmaximilian@gmail.com>
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SCM calls to Secure OS and the Secure Execution
Environment (SEE) residing in the TrustZone (TZ) via the QSEECOM
interface. This allows communication with Secure/TZ applications, for
example 'uefisecapp' managing access to UEFI variables.

For better separation, make qcom_scm spin up a dedicated child
(platform) device in case QSEECOM support has been detected. The
corresponding driver for this device is then responsible for managing
any QSEECOM clients. Specifically, this driver attempts to automatically
detect known and supported applications, creating a client (auxiliary)
device for each one. The respective client/auxiliary driver is then
responsible for managing and communicating with the application.

While this patch introduces only a very basic interface without the more
advanced features (such as re-entrant and blocking SCM calls and
listeners/callbacks), this is enough to talk to the aforementioned
'uefisecapp'.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v5:
 - Add a dedicated platform device and corresponding for managing the
   QSEECOM clients. Unlike before, this device is now instantiated by
   qcom_scm.c if it detects QSEECOM support.

Changes in v4:
 - Remove instantiation of dedicated QSEECOM device and load the driver
   via qcom_scm instead. In particular:
   - Add a list of tested devices to ensure that we don't run into any
     issues with the currently unimplemented re-entrant calls.
   - Use the QSEECOM version to check for general availability of the
     interface.
   - Attempt to automatically detect available QSEECOM applications
     (and instantiate respective clients) based on a fixed list.
 - Use auxiliary bus and devices for clients instead of MFD.
 - Restructure DMA allocations: Use dma_map_single() directly inside 
   qcom_scm_qseecom_app_send() instead of requiring clients to allocate
   DMA memory themselves.

Changes in v3:
 - Rebase ontop of latest qcom_scm changes (qcom_scm.h moved).
 - Move qcom_qseecom.h in accordance with qcom_scm.

Changes in v2:
 - Bind the interface to a device.
 - Establish a device link to the SCM device to ensure proper ordering.
 - Register client apps as child devices instead of requiring them to be
   specified in the device tree.
 - Rename (qctree -> qseecom) to allow differentiation between old
   (qseecom) and new (smcinvoke) interfaces to the trusted execution
   environment.

---
 MAINTAINERS                                |   6 +
 drivers/firmware/Kconfig                   |  16 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/qcom_qseecom.c            | 128 +++++++
 drivers/firmware/qcom_scm.c                | 392 +++++++++++++++++++++
 include/linux/firmware/qcom/qcom_qseecom.h |  46 +++
 include/linux/firmware/qcom/qcom_scm.h     |  21 ++
 7 files changed, 610 insertions(+)
 create mode 100644 drivers/firmware/qcom_qseecom.c
 create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ae1fd58fc64c..7a0a69a32a8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17689,6 +17689,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM QSEECOM DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/qcom_qseecom.c
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
 M:	Sean Tranchetti <quic_stranche@quicinc.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..e4cb2b8f32ac 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -226,6 +226,22 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config QCOM_QSEECOM
+	bool "Qualcomm QSEECOM interface driver"
+	depends on QCOM_SCM
+	help
+	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
+	  in the Trust Zone. This module provides an interface to that via the
+	  QSEECOM mechanism, using SCM calls.
+
+	  The QSEECOM interface allows, among other things, access to applications
+	  running in the SEE. An example of such an application is 'uefisecapp',
+	  which is required to access UEFI variables on certain systems. If
+	  selected, the interface will also attempt to detect and register client
+	  devices for supported applications.
+
+	  Select Y here to enable the QSEECOM interface driver.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 28fcddcd688f..aa48e0821b7d 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/qcom_qseecom.c b/drivers/firmware/qcom_qseecom.c
new file mode 100644
index 000000000000..e9edd500c3d9
--- /dev/null
+++ b/drivers/firmware/qcom_qseecom.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Qualcomm Secure Execution Environment (SEE) interface (QSEECOM).
+ * Responsible for setting up and managing QSEECOM client devices.
+ *
+ * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <linux/firmware/qcom/qcom_qseecom.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+
+struct qseecom_app_desc {
+	const char *app_name;
+	const char *dev_name;
+};
+
+static void qseecom_client_release(struct device *dev)
+{
+	struct qseecom_client *client = container_of(dev, struct qseecom_client, aux_dev.dev);
+
+	kfree(client);
+}
+
+static void qseecom_client_remove(void *data)
+{
+	struct qseecom_client *client = data;
+
+	auxiliary_device_delete(&client->aux_dev);
+	auxiliary_device_uninit(&client->aux_dev);
+}
+
+static int qseecom_client_register(struct platform_device *qseecom_dev,
+				   const struct qseecom_app_desc *desc)
+{
+	struct qseecom_client *client;
+	u32 app_id;
+	int ret;
+
+	/* Try to find the app ID, skip device if not found */
+	ret = qcom_scm_qseecom_app_get_id(desc->app_name, &app_id);
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
+
+	dev_info(&qseecom_dev->dev, "setting up client for %s\n", desc->app_name);
+
+	/* Allocate and set-up the client device */
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	client->aux_dev.name = desc->dev_name;
+	client->aux_dev.dev.parent = &qseecom_dev->dev;
+	client->aux_dev.dev.release = qseecom_client_release;
+	client->app_id = app_id;
+
+	ret = auxiliary_device_init(&client->aux_dev);
+	if (ret) {
+		kfree(client);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(&client->aux_dev);
+	if (ret) {
+		auxiliary_device_uninit(&client->aux_dev);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&qseecom_dev->dev, qseecom_client_remove, client);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * List of supported applications. One client device will be created per entry,
+ * assuming the app has already been loaded (usually by firmware bootloaders)
+ * and its ID can be queried successfully.
+ */
+static const struct qseecom_app_desc qcom_qseecom_apps[] = {};
+
+static int qcom_qseecom_probe(struct platform_device *qseecom_dev)
+{
+	int ret;
+	int i;
+
+	/* Set up client devices for each base application */
+	for (i = 0; i < ARRAY_SIZE(qcom_qseecom_apps); i++) {
+		ret = qseecom_client_register(qseecom_dev, &qcom_qseecom_apps[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_qseecom_remove(struct platform_device *qseecom_dev)
+{
+	return 0;	/* Nothing to do here, all is managed via devm. */
+}
+
+static struct platform_driver qcom_qseecom_driver = {
+	.driver = {
+		.name	= "qcom_qseecom",
+	},
+	.probe = qcom_qseecom_probe,
+	.remove = qcom_qseecom_remove,
+};
+
+static int __init qcom_qseecom_init(void)
+{
+	return platform_driver_register(&qcom_qseecom_driver);
+}
+subsys_initcall(qcom_qseecom_init);
+
+static void __exit qcom_qseecom_exit(void)
+{
+	platform_driver_unregister(&qcom_qseecom_driver);
+}
+module_exit(qcom_qseecom_exit);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Driver for the Qualcomm SEE (QSEECOM) interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:qcom_qseecom");
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index b6055b1c18d8..6c4a8366959c 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -55,6 +55,53 @@ struct qcom_scm_mem_map_info {
 	__le64 mem_size;
 };
 
+/**
+ * struct qcom_scm_qseecom_resp - QSEECOM SCM call response.
+ * @result:    Result or status of the SCM call. See &enum qcom_scm_qseecom_result.
+ * @resp_type: Type of the response. See &enum qcom_scm_qseecom_resp_type.
+ * @data:      Response data. The type of this data is given in @resp_type.
+ */
+struct qcom_scm_qseecom_resp {
+	u64 result;
+	u64 resp_type;
+	u64 data;
+};
+
+enum qcom_scm_qseecom_result {
+	QSEECOM_RESULT_SUCCESS			= 0,
+	QSEECOM_RESULT_INCOMPLETE		= 1,
+	QSEECOM_RESULT_BLOCKED_ON_LISTENER	= 2,
+	QSEECOM_RESULT_FAILURE			= 0xFFFFFFFF,
+};
+
+enum qcom_scm_qseecom_resp_type {
+	QSEECOM_SCM_RES_APP_ID			= 0xEE01,
+	QSEECOM_SCM_RES_QSEOS_LISTENER_ID	= 0xEE02,
+};
+
+enum qcom_scm_qseecom_tz_owner {
+	QSEECOM_TZ_OWNER_SIP			= 2,
+	QSEECOM_TZ_OWNER_TZ_APPS		= 48,
+	QSEECOM_TZ_OWNER_QSEE_OS		= 50
+};
+
+enum qcom_scm_qseecom_tz_svc {
+	QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER	= 0,
+	QSEECOM_TZ_SVC_APP_MGR			= 1,
+	QSEECOM_TZ_SVC_INFO			= 6,
+};
+
+enum qcom_scm_qseecom_tz_cmd_app {
+	QSEECOM_TZ_CMD_APP_SEND			= 1,
+	QSEECOM_TZ_CMD_APP_LOOKUP		= 3,
+};
+
+enum qcom_scm_qseecom_tz_cmd_info {
+	QSEECOM_TZ_CMD_INFO_VERSION		= 3,
+};
+
+#define QSEECOM_MAX_APP_NAME_SIZE		64
+
 /* Each bit configures cold/warm boot address for one of the 4 CPUs */
 static const u8 qcom_scm_cpu_cold_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 	0, BIT(0), BIT(3), BIT(5)
@@ -1321,6 +1368,339 @@ static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
 	return 0;
 }
 
+#ifdef CONFIG_QCOM_QSEECOM
+
+/* Lock for QSEECOM SCM call executions */
+static DEFINE_MUTEX(qcom_scm_qseecom_call_lock);
+
+static int __qcom_scm_qseecom_call(const struct qcom_scm_desc *desc,
+				   struct qcom_scm_qseecom_resp *res)
+{
+	struct qcom_scm_res scm_res = {};
+	int status;
+
+	/*
+	 * QSEECOM SCM calls should not be executed concurrently. Therefore, we
+	 * require the respective call lock to be held.
+	 */
+	lockdep_assert_held(&qcom_scm_qseecom_call_lock);
+
+	status = qcom_scm_call(__scm->dev, desc, &scm_res);
+
+	res->result = scm_res.result[0];
+	res->resp_type = scm_res.result[1];
+	res->data = scm_res.result[2];
+
+	if (status)
+		return status;
+
+	return 0;
+}
+
+/**
+ * qcom_scm_qseecom_call() - Perform a QSEECOM SCM call.
+ * @desc: SCM call descriptor.
+ * @res:  SCM call response (output).
+ *
+ * Performs the QSEECOM SCM call described by @desc, returning the response in
+ * @rsp.
+ *
+ * Return: Zero on success, nonzero on failure.
+ */
+static int qcom_scm_qseecom_call(const struct qcom_scm_desc *desc,
+				 struct qcom_scm_qseecom_resp *res)
+{
+	int status;
+
+	/*
+	 * Note: Multiple QSEECOM SCM calls should not be executed same time,
+	 * so lock things here. This needs to be extended to callback/listener
+	 * handling when support for that is implemented.
+	 */
+
+	mutex_lock(&qcom_scm_qseecom_call_lock);
+	status = __qcom_scm_qseecom_call(desc, res);
+	mutex_unlock(&qcom_scm_qseecom_call_lock);
+
+	dev_dbg(__scm->dev, "%s: owner=%x, svc=%x, cmd=%x, result=%lld, type=%llx, data=%llx\n",
+		__func__, desc->owner, desc->svc, desc->cmd, res->result,
+		res->resp_type, res->data);
+
+	if (status) {
+		dev_err(__scm->dev, "qseecom: scm call failed with error %d\n", status);
+		return status;
+	}
+
+	/*
+	 * TODO: Handle incomplete and blocked calls:
+	 *
+	 * Incomplete and blocked calls are not supported yet. Some devices
+	 * and/or commands require those, some don't. Let's warn about them
+	 * prominently in case someone attempts to try these commands with a
+	 * device/command combination that isn't supported yet.
+	 */
+	WARN_ON(res->result == QSEECOM_RESULT_INCOMPLETE);
+	WARN_ON(res->result == QSEECOM_RESULT_BLOCKED_ON_LISTENER);
+
+	return 0;
+}
+
+/**
+ * qcom_scm_qseecom_get_version() - Query the QSEECOM version.
+ * @version: Pointer where the QSEECOM version will be stored.
+ *
+ * Performs the QSEECOM SCM querying the QSEECOM version currently running in
+ * the TrustZone.
+ *
+ * Return: Zero on success, nonzero on failure.
+ */
+static int qcom_scm_qseecom_get_version(u32 *version)
+{
+	struct qcom_scm_desc desc = {};
+	struct qcom_scm_qseecom_resp res = {};
+	u32 feature = 10;
+	int ret;
+
+	desc.owner = QSEECOM_TZ_OWNER_SIP;
+	desc.svc = QSEECOM_TZ_SVC_INFO;
+	desc.cmd = QSEECOM_TZ_CMD_INFO_VERSION;
+	desc.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL);
+	desc.args[0] = feature;
+
+	ret = qcom_scm_qseecom_call(&desc, &res);
+	if (ret)
+		return ret;
+
+	*version = res.result;
+	return 0;
+}
+
+/**
+ * qcom_scm_qseecom_app_get_id() - Query the app ID for a given QSEE app name.
+ * @app_name: The name of the app.
+ * @app_id:   The returned app ID.
+ *
+ * Query and return the application ID of the SEE app identified by the given
+ * name. This returned ID is the unique identifier of the app required for
+ * subsequent communication.
+ *
+ * Return: Zero on success, nonzero on failure, -ENOENT if the app has not been
+ * loaded or could not be found.
+ */
+int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
+{
+	unsigned long name_buf_size = QSEECOM_MAX_APP_NAME_SIZE;
+	unsigned long app_name_len = strlen(app_name);
+	struct qcom_scm_desc desc = {};
+	struct qcom_scm_qseecom_resp res = {};
+	dma_addr_t name_buf_phys;
+	char *name_buf;
+	int status;
+
+	if (app_name_len >= name_buf_size)
+		return -EINVAL;
+
+	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	if (!name_buf)
+		return -ENOMEM;
+
+	memcpy(name_buf, app_name, app_name_len);
+
+	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
+	status = dma_mapping_error(__scm->dev, name_buf_phys);
+	if (status) {
+		kfree(name_buf);
+		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
+		return status;
+	}
+
+	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
+	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
+	desc.cmd = QSEECOM_TZ_CMD_APP_LOOKUP;
+	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
+	desc.args[0] = name_buf_phys;
+	desc.args[1] = app_name_len;
+
+	status = qcom_scm_qseecom_call(&desc, &res);
+	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
+	kfree(name_buf);
+
+	if (status)
+		return status;
+
+	if (res.result == QSEECOM_RESULT_FAILURE)
+		return -ENOENT;
+
+	if (res.result != QSEECOM_RESULT_SUCCESS)
+		return -EINVAL;
+
+	if (res.resp_type != QSEECOM_SCM_RES_APP_ID)
+		return -EINVAL;
+
+	*app_id = res.data;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
+
+/**
+ * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
+ * @app_id:   The ID of the target app.
+ * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req_size: Size of the request buffer.
+ * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp_size: Size of the response buffer.
+ *
+ * Sends a request to the QSEE app associated with the given ID and read back
+ * its response. The caller must provide two DMA memory regions, one for the
+ * request and one for the response, and fill out the @req region with the
+ * respective (app-specific) request data. The QSEE app reads this and returns
+ * its response in the @rsp region.
+ *
+ * Return: Zero on success, nonzero on failure.
+ */
+int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
+			      size_t rsp_size)
+{
+	struct qcom_scm_qseecom_resp res = {};
+	struct qcom_scm_desc desc = {};
+	dma_addr_t req_phys;
+	dma_addr_t rsp_phys;
+	int status;
+
+	/* Map request buffer */
+	req_phys = dma_map_single(__scm->dev, req, req_size, DMA_TO_DEVICE);
+	status = dma_mapping_error(__scm->dev, req_phys);
+	if (status) {
+		dev_err(__scm->dev, "qseecom: failed to map request buffer\n");
+		return status;
+	}
+
+	/* Map response buffer */
+	rsp_phys = dma_map_single(__scm->dev, rsp, rsp_size, DMA_FROM_DEVICE);
+	status = dma_mapping_error(__scm->dev, rsp_phys);
+	if (status) {
+		dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
+		dev_err(__scm->dev, "qseecom: failed to map response buffer\n");
+		return status;
+	}
+
+	/* Set up SCM call data */
+	desc.owner = QSEECOM_TZ_OWNER_TZ_APPS;
+	desc.svc = QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER;
+	desc.cmd = QSEECOM_TZ_CMD_APP_SEND;
+	desc.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_VAL,
+				     QCOM_SCM_RW, QCOM_SCM_VAL,
+				     QCOM_SCM_RW, QCOM_SCM_VAL);
+	desc.args[0] = app_id;
+	desc.args[1] = req_phys;
+	desc.args[2] = req_size;
+	desc.args[3] = rsp_phys;
+	desc.args[4] = rsp_size;
+
+	/* Perform call */
+	status = qcom_scm_qseecom_call(&desc, &res);
+
+	/* Unmap buffers */
+	dma_unmap_single(__scm->dev, rsp_phys, rsp_size, DMA_FROM_DEVICE);
+	dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
+
+	if (status)
+		return status;
+
+	if (res.result != QSEECOM_RESULT_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
+
+/*
+ * We do not yet support re-entrant calls via the qseecom interface. To prevent
+ + any potential issues with this, only allow validated machines for now.
+ */
+static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
+	{ .compatible = "lenovo,thinkpad-x13s", },
+	{ }
+};
+
+static bool qcom_scm_qseecom_machine_is_allowed(void)
+{
+	struct device_node *np;
+	bool match;
+
+	np = of_find_node_by_path("/");
+	if (!np)
+		return false;
+
+	match = of_match_node(qcom_scm_qseecom_allowlist, np);
+	of_node_put(np);
+
+	return match;
+}
+
+static void qcom_scm_qseecom_free(void *data)
+{
+	struct platform_device *qseecom_dev = data;
+
+	platform_device_unregister(qseecom_dev);
+}
+
+static int qcom_scm_qseecom_init(struct qcom_scm *scm)
+{
+	struct platform_device *qseecom_dev;
+	u32 version;
+	int ret;
+
+	/*
+	 * Note: We do two steps of validation here: First, we try to query the
+	 * QSEECOM version as a check to see if the interface exists on this
+	 * device. Second, we check against known good devices due to current
+	 * driver limitations (see comment in qcom_scm_qseecom_allowlist).
+	 *
+	 * Note that we deliberately do the machine check after the version
+	 * check so that we can log potentially supported devices. This should
+	 * be safe as downstream sources indicate that the version query is
+	 * neither blocking nor reentrant.
+	 */
+	ret = qcom_scm_qseecom_get_version(&version);
+	if (ret)
+		return 0;
+
+	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
+
+	if (!qcom_scm_qseecom_machine_is_allowed()) {
+		dev_info(scm->dev, "qseecom: untested device, skipping\n");
+		return 0;
+	}
+
+	/*
+	 * Set up QSEECOM interface device. All application clients will be
+	 * set up and managed by the corresponding driver for it.
+	 */
+	qseecom_dev = platform_device_alloc("qcom_qseecom", -1);
+	if (!qseecom_dev)
+		return -ENOMEM;
+
+	qseecom_dev->dev.parent = scm->dev;
+
+	ret = platform_device_add(qseecom_dev);
+	if (ret) {
+		platform_device_put(qseecom_dev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(scm->dev, qcom_scm_qseecom_free, qseecom_dev);
+}
+
+#else /* CONFIG_QCOM_QSEECOM */
+
+static int qcom_scm_qseecom_init(struct qcom_scm *scm)
+{
+	return 0;
+}
+
+#endif /* CONFIG_QCOM_QSEECOM */
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
@@ -1468,6 +1848,18 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	/*
+	 * Initialize the QSEECOM interface. Note: QSEECOM is fairly
+	 * self-contained and this only adds the interface device (the driver
+	 * of which does most of the heavy lifting). So any errors returned
+	 * here should be either -ENOMEM or -EINVAL (with the latter only in
+	 * case there's a bug in our code). This means that there is no need to
+	 * bring down the whole SCM driver. Just log the error instead and let
+	 * SCM live.
+	 */
+	ret = qcom_scm_qseecom_init(scm);
+	WARN(ret < 0, "failed to initialize qseecom: %d", ret);
+
 	return 0;
 }
 
diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
new file mode 100644
index 000000000000..b531547e1dc9
--- /dev/null
+++ b/include/linux/firmware/qcom/qcom_qseecom.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Qualcomm Secure Execution Environment (SEE) interface (QSEECOM).
+ * Responsible for setting up and managing QSEECOM client devices.
+ *
+ * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/types.h>
+
+#include <linux/firmware/qcom/qcom_scm.h>
+
+/**
+ * struct qseecom_client - QSEECOM client device.
+ * @aux_dev: Underlying auxiliary device.
+ * @app_id: ID of the loaded application.
+ */
+struct qseecom_client {
+	struct auxiliary_device aux_dev;
+	u32 app_id;
+};
+
+/**
+ * qcom_qseecom_app_send() - Send to and receive data from a given QSEE app.
+ * @client:   The QSEECOM client associated with the target app.
+ * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req_size: Size of the request buffer.
+ * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp_size: Size of the response buffer.
+ *
+ * Sends a request to the QSEE app associated with the given client and read
+ * back its response. The caller must provide two DMA memory regions, one for
+ * the request and one for the response, and fill out the @req region with the
+ * respective (app-specific) request data. The QSEE app reads this and returns
+ * its response in the @rsp region.
+ *
+ * Note: This is a convenience wrapper around qcom_scm_qseecom_app_send().
+ * Clients should prefer to use this wrapper.
+ *
+ * Return: Zero on success, nonzero on failure.
+ */
+static inline int qcom_qseecom_app_send(struct qseecom_client *client, void *req, size_t req_size,
+					void *rsp, size_t rsp_size)
+{
+	return qcom_scm_qseecom_app_send(client->app_id, req, req_size, rsp, rsp_size);
+}
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 250ea4efb7cb..dd4236cffbec 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -122,4 +122,25 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 extern int qcom_scm_lmh_profile_change(u32 profile_id);
 extern bool qcom_scm_lmh_dcvsh_available(void);
 
+#ifdef CONFIG_QCOM_QSEECOM
+
+int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
+int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
+			      size_t rsp_size);
+
+#else /* CONFIG_QCOM_QSEECOM */
+
+int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
+{
+	return -EINVAL;
+}
+
+int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
+			      size_t rsp_size)
+{
+	return -EINVAL;
+}
+
+#endif /* CONFIG_QCOM_QSEECOM */
+
 #endif
-- 
2.41.0


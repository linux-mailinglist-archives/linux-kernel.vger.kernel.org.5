Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8D796F34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbjIGDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbjIGDOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:14:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBD199F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:14:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-410af8f75d9so3900911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694056442; x=1694661242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnd0I07HeUzU7voJTdtOIpPdlBHbTA3K5Yawn0w0tak=;
        b=V+Kfj2oRDlAh19IMEtsI8lHnjqgOnEp8kFncEImVpeDXWlE7sAKCegtIiOEdoxEMvy
         KqcB49iOn6LADsG2U/FM0FYxAwajWzD5AM3HuUF8yKRbdFrfKPD+mwhYnlJjgZmQkBWU
         xiJ6bRUFG2xRyNpWDfoNb1gONUE13qkvBlrL4UIa0r/ChfDY/J//vBlIvDco+3NsqOym
         CstkvDi2+1hhlwHvflihQzCVgsh5Uno9F6B/yjUTRpG8SAMGppEWDDqn2SWdDEAsqHeX
         AlWxP8FtIvn5NQawqAjBIaSCUDkPHHYIdC/8CweDI/M8YaNOc2XifAYafTfkM3nGAP0L
         7W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694056442; x=1694661242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wnd0I07HeUzU7voJTdtOIpPdlBHbTA3K5Yawn0w0tak=;
        b=Ocih9jsxc3743PYvBhK42FP+lVJRsVYh+eri3sms9+g1+e0W8cM7l9htRpEUWiPutG
         48ZWEFolqDwMVG6pwyyt0lqT4uU5usOH5ZwqrP9qMzmzezr++aE/miX6NmKTjLW8Kiky
         iEFIkawowRunWO4ymuGt3Q7HDSWSapMaCPOLDggUDDuBVE0N9CN/wumYRYT04O8RRgFA
         /72NRtDuzwBdEECBHdSnjKAO3MBxmN645obxWZAOk9UrkIQVg46At12JJQsU9awpxfoy
         c7686qEOKLJFdGpF1JdbRgIjEANRGF7ThXhRiNiVIpMlB279AUeNMxQdRB5XRnWarMkx
         d4nQ==
X-Gm-Message-State: AOJu0Yx0lNvlyNzsBr0gcsIVYLE2pPIKP+OLKY+CzCTrW023s66CgiJV
        pCGfMAgoawJrzYlK4Z+O+uFzbuTL1mI=
X-Google-Smtp-Source: AGHT+IHE1ERuyx584zsNLMcMObFde+LaJmcvYYXzLS4XLUFyxpCorEdm+r4kUS3JbvPlIyeA+JswNw==
X-Received: by 2002:a05:620a:4012:b0:76e:ef94:127f with SMTP id h18-20020a05620a401200b0076eef94127fmr27425551qko.56.1694056442087;
        Wed, 06 Sep 2023 20:14:02 -0700 (PDT)
Received: from wenkaidev ([123.51.235.123])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78c44000000b0068be216b091sm11455269pfd.24.2023.09.06.20.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 20:14:01 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mfd: eiois200: Add Header for EIO-IS200 Core Driver
Date:   Thu,  7 Sep 2023 11:13:17 +0800
Message-Id: <20230907031320.6814-4-advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907031320.6814-1-advantech.susiteam@gmail.com>
References: <20230907031320.6814-1-advantech.susiteam@gmail.com>
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

From: Wenkai <advantech.susiteam@gmail.com>

This patch adds the header file necessary for the Advantech EIO-IS200
Core Driver. This header file provides the required definitions and
structures for communicating with the EIO-IS200 EC and its various
functionalities.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/mfd/eiois200.h | 137 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 drivers/mfd/eiois200.h

diff --git a/drivers/mfd/eiois200.h b/drivers/mfd/eiois200.h
new file mode 100644
index 000000000000..d4c3f917811c
--- /dev/null
+++ b/drivers/mfd/eiois200.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Header for the Advantech EIO-IS200 core driver and its sub-drivers
+ *
+ * Copyright (C) 2023 Advantech Co., Ltd.
+ * Author: wenkai.chung <wenkai.chung@advantech.com.tw>
+ */
+
+#ifndef _MFD_EIOIS200_H_
+#define _MFD_EIOIS200_H_
+#include <linux/io.h>
+#include <linux/regmap.h>
+
+/* Definition */
+#define EIOIS200_CHIPID1		0x20
+#define EIOIS200_CHIPID2		0x21
+#define EIOIS200_CHIPVER		0x22
+#define EIOIS200_SIOCTRL		0x23
+#define EIOIS200_SIOCTRL_SIOEN		BIT(0)
+#define EIOIS200_SIOCTRL_SWRST		BIT(1)
+#define EIOIS200_IRQCTRL		0x70
+#define EIOIS200_CHIPID			0x9610
+#define EIO201_211_CHIPID		0x9620
+#define EIOIS200_ICCODE			0x10
+#define EIO201_ICCODE			0x20
+#define EIO211_ICCODE			0x21
+
+/* LPC PNP */
+#define EIOIS200_PNP_INDEX		0x299
+#define EIOIS200_PNP_DATA		0x29A
+#define EIOIS200_SUB_PNP_INDEX		0x499
+#define EIOIS200_SUB_PNP_DATA		0x49A
+#define EIOIS200_EXT_MODE_ENTER		0x87
+#define EIOIS200_EXT_MODE_EXIT		0xAA
+
+/* LPC LDN */
+#define EIOIS200_LDN			0x07
+#define EIOIS200_LDN_PMC0		0x0C
+#define EIOIS200_LDN_PMC1		0x0D
+
+/* PMC registers */
+#define EIOIS200_PMC_PORT		0x2F0
+#define EIOIS200_PMC_PORT_SUB		0x60
+#define EIOIS200_PMC_STATUS_IBF		BIT(1)
+#define EIOIS200_PMC_STATUS_OBF		BIT(0)
+#define EIOIS200_LDAR			0x30
+#define EIOIS200_LDAR_LDACT		BIT(0)
+#define EIOIS200_IOBA0H			0x60
+#define EIOIS200_IOBA0L			0x61
+#define EIOIS200_IOBA1H			0x62
+#define EIOIS200_IOBA1L			0x63
+
+/* PMC command list */
+#define EIOIS200_PMC_CMD_ACPIRAM_READ	0x31
+#define EIOIS200_PMC_CMD_CFG_SAVE	0x56
+
+/* OLD PMC */
+#define EIOIS200_PMC_NO_INDEX		0xFF
+
+/* ACPI RAM Address Table */
+#define EIOIS200_ACPIRAM_VERSIONSECTION	(0xFA)
+#define EIOIS200_ACPIRAM_ICVENDOR	(EIOIS200_ACPIRAM_VERSIONSECTION + 0x00)
+#define EIOIS200_ACPIRAM_ICCODE		(EIOIS200_ACPIRAM_VERSIONSECTION + 0x01)
+#define EIOIS200_ACPIRAM_CODEBASE	(EIOIS200_ACPIRAM_VERSIONSECTION + 0x02)
+
+/* Firmware */
+#define EIOIS200_F_SUB_NEW_CODE_BASE	BIT(6)
+#define EIOIS200_F_SUB_CHANGED		BIT(7)
+#define EIOIS200_F_NEW_CODE_BASE	BIT(8)
+#define EIOIS200_F_CHANGED		BIT(9)
+#define EIOIS200_F_SUB_CHIP_EXIST	BIT(30)
+#define EIOIS200_F_CHIP_EXIST		BIT(31)
+
+/* Others */
+#define EC_NUM	2
+
+struct _pmc_port {
+	union {
+		u16 cmd;
+		u16 status;
+	};
+	u16 data;
+};
+
+struct _pmc_op {
+	u8  cmd;
+	u8  control;
+	u8  device_id;
+	u8  size;
+	u8  *payload;
+	u8  chip;
+	u16 timeout;
+};
+
+enum eiois200_rw_operation {
+	OPERATION_READ,
+	OPERATION_WRITE,
+};
+
+struct eiois200_dev {
+	u32 flag;
+
+	struct _pmc_port  pmc[2];
+
+	struct mutex mutex; /* Protects PMC command access */
+};
+
+/**
+ * eiois200_core_pmc_operation - Execute a new pmc command
+ * @op:		Pointer to an new pmc command.
+ */
+int eiois200_core_pmc_operation(struct _pmc_op *operation);
+
+enum eiois200_pmc_wait {
+	PMC_WAIT_INPUT,
+	PMC_WAIT_OUTPUT,
+};
+
+/**
+ * eiois200_core_pmc_wait - Wait for input / output buffer to be ready
+ * @id:		0 for main chip, 1 for sub chip.
+ * @wait:	%PMC_WAIT_INPUT or %PMC_WAIT_OUTPUT.
+ *		%PMC_WAIT_INPUT for waiting input buffer data ready.
+ *		%PMC_WAIT_OUTPUT for waiting output buffer empty.
+ * @timeout:	The timeout value.
+ */
+int eiois200_core_pmc_wait(int id, enum eiois200_pmc_wait wait, uint timeout);
+
+#define WAIT_IBF(id, timeout)	eiois200_core_pmc_wait(id, PMC_WAIT_INPUT, timeout)
+#define WAIT_OBF(id, timeout)	eiois200_core_pmc_wait(id, PMC_WAIT_OUTPUT, timeout)
+
+#ifdef pr_fmt
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#endif
+
+#endif
-- 
2.34.1


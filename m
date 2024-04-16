Return-Path: <linux-kernel+bounces-146122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B88A6100
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32AD9B22A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6542A9F;
	Tue, 16 Apr 2024 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxF/vkhv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B209374E9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234064; cv=none; b=dic+jmdN+eWv6Ar8nlY2nZE2NpCLfERo6LZtNdmAzhJd7bYBtcdo23Bt3ejBLXnjd/9wV3Uvm7UoHh+oVLTwyTrOYIFVlJDft5cqSx0nC/BNADGBu5JNa+ui7MIgTPPL7v/CimfjtZZcDgCH3/Ojhml5muifMz3QXQqR+iDZ9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234064; c=relaxed/simple;
	bh=yJeAlayWU742uIOS1+Qex7ZD6Uw85hAJ5t34KTJ2nEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUQQc0UCdbuRPfPDW9OMLj/pMdZO/M+AHRSHWcik2HqNMjHFhqG3Z88kujV9HNB/ZRIsABmSywe25dT1SBNuZtR+8VHu4VkN1J/S7Jp7GEEkIB6B0Wmsoz1TeSNvHajV249GUNUnV4GglUIoWLzXe4zvgugxnc6CYPCdjbT/ffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxF/vkhv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518a3e0d2e4so2308351e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713234059; x=1713838859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlPc7pTPuON7kRU6W7J6GqxYpvFAb8d0DJbeeg0HRuY=;
        b=cxF/vkhvb9Uy83yQNGeYYf0gf0+Qthb39fy6u+MurPGoWL/9CRKITBhPi1wKJijnvK
         a8eBbJfN8GOeWARKYhVO6Mhl444SjDFYeDLOSMPDiG0odVfL/Xj9LCWa95ghVCG5e5/U
         DqjBd/A/2G8VJO4yaOtBntK9Sf+JT4y7igkAQ6GW8PwL8VmQ5WuRveib6QZRDe1iNzKh
         BRM25y920toD1qxT841syYKpxy2KQ7nLsoenycJBa6JeIUVgHfFbJXrClUCq1pJZwhuB
         6mN96Ocj0OZGggyrVXvUqbAA6fFJuh9uZRmx1jKSRLhBty0uyo7uXoPnvZnM/5Ly5Zmn
         235w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713234059; x=1713838859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlPc7pTPuON7kRU6W7J6GqxYpvFAb8d0DJbeeg0HRuY=;
        b=KA6E+yit3K3PUIiMfAItQJIW4XMW2bw/Sltp31XuqFJPZ/NfYiIx8U8t9ULLGQrJmw
         ecCtwpUIvUTSphfT9H60V3NYXbPo0isgw2n91HSH6rxkKXgTMrseMTqaKBkt6uZqbTxl
         E38DTzL/26JMdCYVrIrcdF2yzHtXyj8uDWqtGPVi458zEW8ghFPm2FXxTZ/6XBg0YiOC
         SzxD2DC/uG9WkfL/J7gnYtIf1WkhPCp+cPdMPWAqEozAuCywb7tTNrIzGrxPK8nY5KrA
         ZaU5vGwJTz+GEy0WEOyDIvgd8o72prI62+4ssat0Mm1xjtKl0b/NkWW6k8VbwMqCc9Up
         HrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVPZJoGZ6oaPthCNvO39K5n3aWjhEcQH4kHxPuqQzmn+GaSF8JVw6vBXKjM3nNN3CFht3A7uUfrdZL9POc22DUxm913IZS3WNkvGQX
X-Gm-Message-State: AOJu0Yz012Q6Kzi6adEnw/xgbDDcLRq8XfkWUNCndz6FpdjY90g96+Lf
	5BL3ZY1sd6KXVXo4k319uaWE+jrGBixgrmexsYwV8gljRCqNfsQEXBgWjCnpjhg=
X-Google-Smtp-Source: AGHT+IG0Aujt5pjTKjVXbznsH4RV+YvZWYPpGXrdwYlIVufe4pyhYrT2mp9wYcK7ESwfTUVltzw3Og==
X-Received: by 2002:a05:6512:e89:b0:513:dcd2:1267 with SMTP id bi9-20020a0565120e8900b00513dcd21267mr514554lfb.23.1713234059396;
        Mon, 15 Apr 2024 19:20:59 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b0051925dd92dbsm27716lfb.214.2024.04.15.19.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 19:20:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 05:20:56 +0300
Subject: [PATCH 7/8] usb: typec: ucsi: glink: merge pmic_glink_altmode
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-ucsi-glink-altmode-v1-7-890db00877ac@linaro.org>
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
In-Reply-To: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=35052;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=yJeAlayWU742uIOS1+Qex7ZD6Uw85hAJ5t34KTJ2nEg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmHeCE3B4iMkJyiM/yo7kmaZCzCplGuOi0k9WM2
 qFB7JxQki2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZh3ghAAKCRCLPIo+Aiko
 1aiOCACUcftTPMFb/QxgX7eDi2FbhXEzbA1ypRl4gUtnEQ5L6A/AXxuLGQNt+bFkR5/XwTBTjQF
 dURvwhOdSdcJU5k6NdV+Tg9xuTP4AqnSwppUw5WwHCYAkuGgHaK+eYfaQyNx099tEcZKP5Yvuhj
 2yTP0HeC7ce9TJYxzJdwmLbFasPqA+Q2HCbtP/cVQ93m5En6g71Z2jw3KEaPMwErpfTSfmg9GpF
 qwt+Ramnz/Pvep4ehba8O+zpDuMix78wYsPW3BS0tfCKrV1CVnOiK7Wz/wHIUTDAXSnCzo1EmMk
 LRPgkw/PF/at3N7ezhrEMPNOcotZF18L2qq+2q02f3OJT/m9
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move handling of USB Altmode to the ucsi_glink driver. This way the
altmode is properly registered in the Type-C framework, the altmode
handlers can use generic typec calls, the UCSI driver can use
orientation information from altmode messages and vice versa, the
altmode handlers can use GPIO-based orientation inormation from UCSI
GLINK driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/Makefile             |   1 -
 drivers/soc/qcom/pmic_glink_altmode.c | 546 ----------------------------------
 drivers/usb/typec/ucsi/ucsi_glink.c   | 495 ++++++++++++++++++++++++++++--
 3 files changed, 475 insertions(+), 567 deletions(-)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ca0bece0dfff..d43d2b444634 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
-obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
 obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
 CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
deleted file mode 100644
index b3808fc24c69..000000000000
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ /dev/null
@@ -1,546 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, Linaro Ltd
- */
-#include <linux/auxiliary_bus.h>
-#include <linux/bitfield.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/mutex.h>
-#include <linux/property.h>
-#include <linux/soc/qcom/pdr.h>
-#include <drm/bridge/aux-bridge.h>
-
-#include <linux/usb/typec_altmode.h>
-#include <linux/usb/typec_dp.h>
-#include <linux/usb/typec_mux.h>
-#include <linux/usb/typec_retimer.h>
-
-#include <linux/soc/qcom/pmic_glink.h>
-
-#define PMIC_GLINK_MAX_PORTS	2
-
-#define USBC_SC8180X_NOTIFY_IND	0x13
-#define USBC_CMD_WRITE_REQ      0x15
-#define USBC_NOTIFY_IND		0x16
-
-#define ALTMODE_PAN_EN		0x10
-#define ALTMODE_PAN_ACK		0x11
-
-struct usbc_write_req {
-	struct pmic_glink_hdr   hdr;
-	__le32 cmd;
-	__le32 arg;
-	__le32 reserved;
-};
-
-#define NOTIFY_PAYLOAD_SIZE 16
-struct usbc_notify {
-	struct pmic_glink_hdr hdr;
-	char payload[NOTIFY_PAYLOAD_SIZE];
-	u32 reserved;
-};
-
-struct usbc_sc8180x_notify {
-	struct pmic_glink_hdr hdr;
-	__le32 notification;
-	__le32 reserved[2];
-};
-
-enum pmic_glink_altmode_pin_assignment {
-	DPAM_HPD_OUT,
-	DPAM_HPD_A,
-	DPAM_HPD_B,
-	DPAM_HPD_C,
-	DPAM_HPD_D,
-	DPAM_HPD_E,
-	DPAM_HPD_F,
-};
-
-struct pmic_glink_altmode;
-
-#define work_to_altmode_port(w) container_of((w), struct pmic_glink_altmode_port, work)
-
-struct pmic_glink_altmode_port {
-	struct pmic_glink_altmode *altmode;
-	unsigned int index;
-
-	struct typec_switch *typec_switch;
-	struct typec_mux *typec_mux;
-	struct typec_mux_state state;
-	struct typec_retimer *typec_retimer;
-	struct typec_retimer_state retimer_state;
-	struct typec_altmode dp_alt;
-
-	struct work_struct work;
-
-	struct auxiliary_device *bridge;
-
-	enum typec_orientation orientation;
-	u16 svid;
-	u8 dp_data;
-	u8 mode;
-	u8 hpd_state;
-	u8 hpd_irq;
-};
-
-#define work_to_altmode(w) container_of((w), struct pmic_glink_altmode, enable_work)
-
-struct pmic_glink_altmode {
-	struct device *dev;
-
-	unsigned int owner_id;
-
-	/* To synchronize WRITE_REQ acks */
-	struct mutex lock;
-
-	struct completion pan_ack;
-	struct pmic_glink_client *client;
-
-	struct work_struct enable_work;
-
-	struct pmic_glink_altmode_port ports[PMIC_GLINK_MAX_PORTS];
-};
-
-static int pmic_glink_altmode_request(struct pmic_glink_altmode *altmode, u32 cmd, u32 arg)
-{
-	struct usbc_write_req req = {};
-	unsigned long left;
-	int ret;
-
-	/*
-	 * The USBC_CMD_WRITE_REQ ack doesn't identify the request, so wait for
-	 * one ack at a time.
-	 */
-	mutex_lock(&altmode->lock);
-
-	req.hdr.owner = cpu_to_le32(altmode->owner_id);
-	req.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
-	req.hdr.opcode = cpu_to_le32(USBC_CMD_WRITE_REQ);
-	req.cmd = cpu_to_le32(cmd);
-	req.arg = cpu_to_le32(arg);
-
-	ret = pmic_glink_send(altmode->client, &req, sizeof(req));
-	if (ret) {
-		dev_err(altmode->dev, "failed to send altmode request: %#x (%d)\n", cmd, ret);
-		goto out_unlock;
-	}
-
-	left = wait_for_completion_timeout(&altmode->pan_ack, 5 * HZ);
-	if (!left) {
-		dev_err(altmode->dev, "timeout waiting for altmode request ack for: %#x\n", cmd);
-		ret = -ETIMEDOUT;
-	}
-
-out_unlock:
-	mutex_unlock(&altmode->lock);
-	return ret;
-}
-
-static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
-					 struct pmic_glink_altmode_port *port,
-					 u8 mode, bool hpd_state,
-					 bool hpd_irq)
-{
-	struct typec_displayport_data dp_data = {};
-	int ret;
-
-	dp_data.status = DP_STATUS_ENABLED;
-	if (hpd_state)
-		dp_data.status |= DP_STATUS_HPD_STATE;
-	if (hpd_irq)
-		dp_data.status |= DP_STATUS_IRQ_HPD;
-	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(mode);
-
-	port->state.alt = &port->dp_alt;
-	port->state.data = &dp_data;
-	port->state.mode = TYPEC_MODAL_STATE(mode);
-
-	ret = typec_mux_set(port->typec_mux, &port->state);
-	if (ret)
-		dev_err(altmode->dev, "failed to switch mux to DP: %d\n", ret);
-
-	port->retimer_state.alt = &port->dp_alt;
-	port->retimer_state.data = &dp_data;
-	port->retimer_state.mode = TYPEC_MODAL_STATE(mode);
-
-	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
-	if (ret)
-		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
-}
-
-static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
-					  struct pmic_glink_altmode_port *port)
-{
-	int ret;
-
-	port->state.alt = NULL;
-	port->state.data = NULL;
-	port->state.mode = TYPEC_STATE_USB;
-
-	ret = typec_mux_set(port->typec_mux, &port->state);
-	if (ret)
-		dev_err(altmode->dev, "failed to switch mux to USB: %d\n", ret);
-
-	port->retimer_state.alt = NULL;
-	port->retimer_state.data = NULL;
-	port->retimer_state.mode = TYPEC_STATE_USB;
-
-	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
-	if (ret)
-		dev_err(altmode->dev, "failed to setup retimer to USB: %d\n", ret);
-}
-
-static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
-				    struct pmic_glink_altmode_port *port)
-{
-	int ret;
-
-	port->state.alt = NULL;
-	port->state.data = NULL;
-	port->state.mode = TYPEC_STATE_SAFE;
-
-	ret = typec_mux_set(port->typec_mux, &port->state);
-	if (ret)
-		dev_err(altmode->dev, "failed to switch mux to safe mode: %d\n", ret);
-
-	port->retimer_state.alt = NULL;
-	port->retimer_state.data = NULL;
-	port->retimer_state.mode = TYPEC_STATE_SAFE;
-
-	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
-	if (ret)
-		dev_err(altmode->dev, "failed to setup retimer to USB: %d\n", ret);
-}
-
-static void pmic_glink_altmode_worker(struct work_struct *work)
-{
-	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
-	struct pmic_glink_altmode *altmode = alt_port->altmode;
-
-	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
-
-	if (alt_port->svid == USB_TYPEC_DP_SID && alt_port->mode == 0xff)
-		pmic_glink_altmode_safe(altmode, alt_port);
-	else if (alt_port->svid == USB_TYPEC_DP_SID)
-		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
-					     alt_port->hpd_state, alt_port->hpd_irq);
-	else
-		pmic_glink_altmode_enable_usb(altmode, alt_port);
-
-	drm_aux_hpd_bridge_notify(&alt_port->bridge->dev,
-				  alt_port->hpd_state ?
-				  connector_status_connected :
-				  connector_status_disconnected);
-
-	pmic_glink_altmode_request(altmode, ALTMODE_PAN_ACK, alt_port->index);
-}
-
-static enum typec_orientation pmic_glink_altmode_orientation(unsigned int orientation)
-{
-	if (orientation == 0)
-		return TYPEC_ORIENTATION_NORMAL;
-	else if (orientation == 1)
-		return TYPEC_ORIENTATION_REVERSE;
-	else
-		return TYPEC_ORIENTATION_NONE;
-}
-
-#define SC8180X_PORT_MASK		0x000000ff
-#define SC8180X_ORIENTATION_MASK	0x0000ff00
-#define SC8180X_MUX_MASK		0x00ff0000
-#define SC8180X_MODE_MASK		0x3f000000
-#define SC8180X_HPD_STATE_MASK		0x40000000
-#define SC8180X_HPD_IRQ_MASK		0x80000000
-
-static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmode,
-					       const void *data, size_t len)
-{
-	struct pmic_glink_altmode_port *alt_port;
-	const struct usbc_sc8180x_notify *msg;
-	u32 notification;
-	u8 orientation;
-	u8 hpd_state;
-	u8 hpd_irq;
-	u16 svid;
-	u8 port;
-	u8 mode;
-	u8 mux;
-
-	if (len != sizeof(*msg)) {
-		dev_warn(altmode->dev, "invalid length of USBC_NOTIFY indication: %zd\n", len);
-		return;
-	}
-
-	msg = data;
-	notification = le32_to_cpu(msg->notification);
-	port = FIELD_GET(SC8180X_PORT_MASK, notification);
-	orientation = FIELD_GET(SC8180X_ORIENTATION_MASK, notification);
-	mux = FIELD_GET(SC8180X_MUX_MASK, notification);
-	mode = FIELD_GET(SC8180X_MODE_MASK, notification);
-	hpd_state = FIELD_GET(SC8180X_HPD_STATE_MASK, notification);
-	hpd_irq = FIELD_GET(SC8180X_HPD_IRQ_MASK, notification);
-
-	svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
-
-	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
-		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
-		return;
-	}
-
-	alt_port = &altmode->ports[port];
-	alt_port->orientation = pmic_glink_altmode_orientation(orientation);
-	alt_port->svid = svid;
-	alt_port->mode = mode;
-	alt_port->hpd_state = hpd_state;
-	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
-}
-
-#define SC8280XP_DPAM_MASK	0x3f
-#define SC8280XP_HPD_STATE_MASK BIT(6)
-#define SC8280XP_HPD_IRQ_MASK	BIT(7)
-
-static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmode,
-					       u16 svid, const void *data, size_t len)
-{
-	struct pmic_glink_altmode_port *alt_port;
-	const struct usbc_notify *notify;
-	u8 orientation;
-	u8 hpd_state;
-	u8 hpd_irq;
-	u8 mode;
-	u8 port;
-
-	if (len != sizeof(*notify)) {
-		dev_warn(altmode->dev, "invalid length USBC_NOTIFY_IND: %zd\n",
-			 len);
-		return;
-	}
-
-	notify = data;
-
-	port = notify->payload[0];
-	orientation = notify->payload[1];
-	mode = FIELD_GET(SC8280XP_DPAM_MASK, notify->payload[8]) - DPAM_HPD_A;
-	hpd_state = FIELD_GET(SC8280XP_HPD_STATE_MASK, notify->payload[8]);
-	hpd_irq = FIELD_GET(SC8280XP_HPD_IRQ_MASK, notify->payload[8]);
-
-	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
-		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
-		return;
-	}
-
-	alt_port = &altmode->ports[port];
-	alt_port->orientation = pmic_glink_altmode_orientation(orientation);
-	alt_port->svid = svid;
-	alt_port->mode = mode;
-	alt_port->hpd_state = hpd_state;
-	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
-}
-
-static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)
-{
-	struct pmic_glink_altmode *altmode = priv;
-	const struct pmic_glink_hdr *hdr = data;
-	u16 opcode;
-	u16 svid;
-
-	opcode = le32_to_cpu(hdr->opcode) & 0xff;
-	svid = le32_to_cpu(hdr->opcode) >> 16;
-
-	switch (opcode) {
-	case USBC_CMD_WRITE_REQ:
-		complete(&altmode->pan_ack);
-		break;
-	case USBC_NOTIFY_IND:
-		pmic_glink_altmode_sc8280xp_notify(altmode, svid, data, len);
-		break;
-	case USBC_SC8180X_NOTIFY_IND:
-		pmic_glink_altmode_sc8180xp_notify(altmode, data, len);
-		break;
-	}
-}
-
-static void pmic_glink_altmode_put_retimer(void *data)
-{
-	typec_retimer_put(data);
-}
-
-static void pmic_glink_altmode_put_mux(void *data)
-{
-	typec_mux_put(data);
-}
-
-static void pmic_glink_altmode_put_switch(void *data)
-{
-	typec_switch_put(data);
-}
-
-static void pmic_glink_altmode_enable_worker(struct work_struct *work)
-{
-	struct pmic_glink_altmode *altmode = work_to_altmode(work);
-	int ret;
-
-	ret = pmic_glink_altmode_request(altmode, ALTMODE_PAN_EN, 0);
-	if (ret)
-		dev_err(altmode->dev, "failed to request altmode notifications: %d\n", ret);
-}
-
-static void pmic_glink_altmode_pdr_notify(void *priv, int state)
-{
-	struct pmic_glink_altmode *altmode = priv;
-
-	if (state == SERVREG_SERVICE_STATE_UP)
-		schedule_work(&altmode->enable_work);
-}
-
-static const struct of_device_id pmic_glink_altmode_of_quirks[] = {
-	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)PMIC_GLINK_OWNER_USBC },
-	{}
-};
-
-static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
-				    const struct auxiliary_device_id *id)
-{
-	struct pmic_glink_altmode_port *alt_port;
-	struct pmic_glink_altmode *altmode;
-	const struct of_device_id *match;
-	struct fwnode_handle *fwnode;
-	struct device *dev = &adev->dev;
-	u32 port;
-	int ret;
-
-	altmode = devm_kzalloc(dev, sizeof(*altmode), GFP_KERNEL);
-	if (!altmode)
-		return -ENOMEM;
-
-	altmode->dev = dev;
-
-	match = of_match_device(pmic_glink_altmode_of_quirks, dev->parent);
-	if (match)
-		altmode->owner_id = (unsigned long)match->data;
-	else
-		altmode->owner_id = PMIC_GLINK_OWNER_USBC_PAN;
-
-	INIT_WORK(&altmode->enable_work, pmic_glink_altmode_enable_worker);
-	init_completion(&altmode->pan_ack);
-	mutex_init(&altmode->lock);
-
-	device_for_each_child_node(dev, fwnode) {
-		ret = fwnode_property_read_u32(fwnode, "reg", &port);
-		if (ret < 0) {
-			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
-
-		if (port >= ARRAY_SIZE(altmode->ports)) {
-			dev_warn(dev, "invalid connector number, ignoring\n");
-			continue;
-		}
-
-		if (altmode->ports[port].altmode) {
-			dev_err(dev, "multiple connector definition for port %u\n", port);
-			fwnode_handle_put(fwnode);
-			return -EINVAL;
-		}
-
-		alt_port = &altmode->ports[port];
-		alt_port->altmode = altmode;
-		alt_port->index = port;
-		INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
-
-		alt_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
-		if (IS_ERR(alt_port->bridge)) {
-			fwnode_handle_put(fwnode);
-			return PTR_ERR(alt_port->bridge);
-		}
-
-		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
-		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
-		alt_port->dp_alt.active = 1;
-
-		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
-		if (IS_ERR(alt_port->typec_mux)) {
-			fwnode_handle_put(fwnode);
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
-					     "failed to acquire mode-switch for port: %d\n",
-					     port);
-		}
-
-		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
-					       alt_port->typec_mux);
-		if (ret) {
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
-
-		alt_port->typec_retimer = fwnode_typec_retimer_get(fwnode);
-		if (IS_ERR(alt_port->typec_retimer)) {
-			fwnode_handle_put(fwnode);
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_retimer),
-					     "failed to acquire retimer-switch for port: %d\n",
-					     port);
-		}
-
-		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_retimer,
-					       alt_port->typec_retimer);
-		if (ret) {
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
-
-		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
-		if (IS_ERR(alt_port->typec_switch)) {
-			fwnode_handle_put(fwnode);
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
-					     "failed to acquire orientation-switch for port: %d\n",
-					     port);
-		}
-
-		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
-					       alt_port->typec_switch);
-		if (ret) {
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
-	}
-
-	for (port = 0; port < ARRAY_SIZE(altmode->ports); port++) {
-		alt_port = &altmode->ports[port];
-		if (!alt_port->bridge)
-			continue;
-
-		ret = devm_drm_dp_hpd_bridge_add(dev, alt_port->bridge);
-		if (ret)
-			return ret;
-	}
-
-	altmode->client = devm_pmic_glink_register_client(dev,
-							  altmode->owner_id,
-							  pmic_glink_altmode_callback,
-							  pmic_glink_altmode_pdr_notify,
-							  altmode);
-	return PTR_ERR_OR_ZERO(altmode->client);
-}
-
-static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
-	{ .name = "pmic_glink.altmode", },
-	{},
-};
-MODULE_DEVICE_TABLE(auxiliary, pmic_glink_altmode_id_table);
-
-static struct auxiliary_driver pmic_glink_altmode_driver = {
-	.name = "pmic_glink_altmode",
-	.probe = pmic_glink_altmode_probe,
-	.id_table = pmic_glink_altmode_id_table,
-};
-
-module_auxiliary_driver(pmic_glink_altmode_driver);
-
-MODULE_DESCRIPTION("Qualcomm PMIC GLINK Altmode driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 40fcda055b05..1ef638d5fd79 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -10,9 +10,14 @@
 #include <linux/of_device.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
+#include <linux/usb/pd_vdo.h>
+#include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/gpio/consumer.h>
 #include <linux/soc/qcom/pmic_glink.h>
+
+#include <drm/bridge/aux-bridge.h>
+
 #include "ucsi.h"
 
 #define PMIC_GLINK_MAX_PORTS	2
@@ -27,6 +32,16 @@
 #define UC_UCSI_WRITE_BUF_REQ           0x12
 #define UC_UCSI_USBC_NOTIFY_IND         0x13
 
+/*
+ * On sc8180x these requests use UCSI owner,
+ * on other platforms they use USBC_PAN.
+ */
+#define USBC_CMD_WRITE_REQ		0x15
+#define USBC_PAN_NOTIFY_IND		0x16
+
+#define ALTMODE_PAN_EN		0x10
+#define ALTMODE_PAN_ACK		0x11
+
 struct ucsi_read_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
 };
@@ -55,17 +70,89 @@ struct ucsi_notify_ind_msg {
 	u32                     reserved;
 };
 
+struct usbc_write_req_msg {
+	struct pmic_glink_hdr   hdr;
+	__le32			cmd;
+	__le32			arg;
+	u32                     reserved;
+};
+
+#define USBC_NOTIFY_PAYLOAD_SIZE 16
+struct usbc_pan_notify_ind_msg {
+	struct pmic_glink_hdr	hdr;
+	char			payload[USBC_NOTIFY_PAYLOAD_SIZE];
+	u32			reserved;
+};
+
+enum pmic_glink_ucsi_orientation {
+	USBC_ORIENTATION_NORMAL,
+	USBC_ORIENTATION_REVERSE,
+	USBC_ORIENTATION_NONE,
+};
+
+enum pmic_glink_ucsi_mux {
+	USBC_MUX_NONE,
+	USBC_MUX_USB_2L,
+	USBC_MUX_DP_4L,
+	USBC_MUX_USB_DP,
+};
+
+enum pmic_glink_altmode_pin_assignment {
+	DPAM_HPD_OUT,
+	DPAM_HPD_A,
+	DPAM_HPD_B,
+	DPAM_HPD_C,
+	DPAM_HPD_D,
+	DPAM_HPD_E,
+	DPAM_HPD_F,
+};
+
+#define SC8180X_PORT_MASK		GENMASK(7, 0)
+#define SC8180X_ORIENTATION_MASK	GENMASK(15, 8)
+#define SC8180X_MUX_MASK		GENMASK(23, 16)
+#define SC8180X_MODE_MASK		GENMASK(29, 24)
+#define SC8180X_HPD_STATE_MASK		BIT(30)
+#define SC8180X_HPD_IRQ_MASK		BIT(31)
+
+#define SC8280XP_DPAM_MASK		GENMASK(5, 0)
+#define SC8280XP_HPD_STATE_MASK		BIT(6)
+#define SC8280XP_HPD_IRQ_MASK		BIT(7)
+
+struct pmic_glink_ucsi_port {
+	spinlock_t lock;
+
+	struct work_struct altmode_work;
+
+	struct pmic_glink_ucsi *ucsi;
+	struct gpio_desc *port_orientation;
+	struct auxiliary_device *bridge;
+
+	int idx;
+
+	enum typec_orientation orientation;
+
+	enum pmic_glink_ucsi_mux mux;
+	unsigned int mode;
+
+	u16 svid;
+	u8 hpd_state;
+	u8 hpd_irq;
+};
+
 struct pmic_glink_ucsi {
 	struct device *dev;
 
-	struct gpio_desc *port_orientation[PMIC_GLINK_MAX_PORTS];
+	struct pmic_glink_ucsi_port ports[PMIC_GLINK_MAX_PORTS];
 
+	unsigned int altmode_id;
+	struct pmic_glink_client *altmode_client;
 	struct pmic_glink_client *client;
 
 	struct ucsi *ucsi;
 	struct completion read_ack;
 	struct completion write_ack;
 	struct completion sync_ack;
+	struct completion pan_ack;
 	bool sync_pending;
 	struct mutex lock;	/* protects concurrent access to PMIC Glink interface */
 
@@ -193,27 +280,128 @@ static void pmic_glink_ucsi_update_connector(struct ucsi_connector *con)
 	int i;
 
 	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
-		if (ucsi->port_orientation[i])
+		if (ucsi->ports[i].port_orientation)
 			con->typec_cap.orientation_aware = true;
 	}
 }
 
+static int pmic_glink_altmode_request(struct pmic_glink_ucsi *ucsi, u32 cmd, u32 arg)
+{
+	struct usbc_write_req_msg req = {};
+	unsigned long left;
+	int ret;
+
+	/*
+	 * The USBC_CMD_WRITE_REQ ack doesn't identify the request, so wait for
+	 * one ack at a time.
+	 */
+	mutex_lock(&ucsi->lock);
+
+	req.hdr.owner = cpu_to_le32(ucsi->altmode_id);
+	req.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
+	req.hdr.opcode = cpu_to_le32(USBC_CMD_WRITE_REQ);
+	req.cmd = cpu_to_le32(cmd);
+	req.arg = cpu_to_le32(arg);
+
+	reinit_completion(&ucsi->pan_ack);
+	ret = pmic_glink_send(ucsi->altmode_client, &req, sizeof(req));
+	if (ret) {
+		dev_err(ucsi->dev, "failed to send altmode request: %#x (%d)\n", cmd, ret);
+		goto out_unlock;
+	}
+
+	left = wait_for_completion_timeout(&ucsi->pan_ack, 5 * HZ);
+	if (!left) {
+		dev_err(ucsi->dev, "timeout waiting for altmode request ack for: %#x\n", cmd);
+		ret = -ETIMEDOUT;
+	}
+
+out_unlock:
+	mutex_unlock(&ucsi->lock);
+	return ret;
+}
+
+static void pmic_glink_ucsi_set_orientation(struct ucsi_connector *con,
+					    struct pmic_glink_ucsi_port *port)
+{
+	enum typec_orientation orientation;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	orientation = port->orientation;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (port->port_orientation) {
+		int val = gpiod_get_value(port->port_orientation);
+		if (val >= 0)
+			orientation = val ?
+				TYPEC_ORIENTATION_REVERSE :
+				TYPEC_ORIENTATION_NORMAL;
+	}
+
+	typec_set_orientation(con->port, orientation);
+}
+
 static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
-	int orientation;
 
-	if (con->num >= PMIC_GLINK_MAX_PORTS ||
-	    !ucsi->port_orientation[con->num - 1])
+	if (con->num >= PMIC_GLINK_MAX_PORTS)
 		return;
 
-	orientation = gpiod_get_value(ucsi->port_orientation[con->num - 1]);
-	if (orientation >= 0) {
-		typec_set_orientation(con->port,
-				      orientation ?
-				      TYPEC_ORIENTATION_REVERSE :
-				      TYPEC_ORIENTATION_NORMAL);
-	}
+	pmic_glink_ucsi_set_orientation(con, &ucsi->ports[con->num - 1]);
+}
+
+static void pmic_glink_ucsi_register_altmode(struct ucsi_connector *con)
+{
+	static const u8 all_assignments = BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) |
+			     BIT(DP_PIN_ASSIGN_E);
+	struct typec_altmode_desc desc;
+	struct typec_altmode *alt;
+
+	mutex_lock(&con->lock);
+
+	if (con->port_altmode[0])
+		goto out;
+
+	memset(&desc, 0, sizeof(desc));
+	desc.svid = USB_TYPEC_DP_SID;
+	desc.mode = USB_TYPEC_DP_MODE;
+
+	desc.vdo = DP_CAP_CAPABILITY(DP_CAP_DFP_D);
+
+	/* We can't rely on the firmware with the capabilities. */
+	desc.vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
+
+	/* Claiming that we support all pin assignments */
+	desc.vdo |= all_assignments << 8;
+	desc.vdo |= all_assignments << 16;
+
+	alt = typec_port_register_altmode(con->port, &desc);
+	if (IS_ERR(alt))
+		goto out;
+
+        alt->desc = "DisplayPort";
+
+	con->port_altmode[0] = alt;
+
+out:
+	mutex_unlock(&con->lock);
+}
+
+static void pmic_glink_ucsi_registered(struct ucsi *ucsi)
+{
+	int i, ret;
+
+	if (!ucsi->connector)
+		return;
+
+	for (i = 0; i < ucsi->cap.num_connectors; i++)
+		pmic_glink_ucsi_register_altmode(&ucsi->connector[i]);
+
+	ret = pmic_glink_altmode_request(ucsi_get_drvdata(ucsi), ALTMODE_PAN_EN, 0);
+	if (ret)
+		dev_err(ucsi->dev, "failed to request altmode notification: %d\n", ret);
 }
 
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
@@ -222,6 +410,7 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.async_write = pmic_glink_ucsi_async_write,
 	.update_connector = pmic_glink_ucsi_update_connector,
 	.connector_status = pmic_glink_ucsi_connector_status,
+	.ucsi_registered = pmic_glink_ucsi_registered,
 };
 
 static void pmic_glink_ucsi_notify_handle(struct pmic_glink_ucsi *ucsi, u32 cci)
@@ -289,6 +478,206 @@ static void pmic_glink_ucsi_notify_ind(struct pmic_glink_ucsi *ucsi, const void
 	pmic_glink_ucsi_notify_handle(ucsi, le32_to_cpu(msg->notification));
 }
 
+static enum typec_orientation pmic_glink_altmode_orientation(unsigned int orientation)
+{
+	if (orientation == USBC_ORIENTATION_NORMAL)
+		return TYPEC_ORIENTATION_NORMAL;
+	else if (orientation == USBC_ORIENTATION_REVERSE)
+		return TYPEC_ORIENTATION_REVERSE;
+
+	WARN_ON(orientation != USBC_ORIENTATION_NONE);
+	return TYPEC_ORIENTATION_NONE;
+}
+
+static void pmic_glink_ucsi_notify_ind_sc8180x(struct pmic_glink_ucsi *ucsi, const void *data, size_t len)
+{
+	const struct ucsi_notify_ind_msg *msg;
+	struct pmic_glink_ucsi_port *port;
+	unsigned long flags;
+	u32 notification;
+	unsigned int idx;
+	unsigned int orientation;
+
+	if (len != sizeof (*msg)) {
+		dev_err_ratelimited(ucsi->dev, "Unexpected altmode notify struct size %zd\n", len);
+		return;
+	}
+
+	msg = data;
+
+	notification = le32_to_cpu(msg->notification);
+
+	idx = FIELD_GET(SC8180X_PORT_MASK, notification);
+	if (idx == 0x80) {
+		schedule_work(&ucsi->notify_work_sc8180x);
+		return;
+	}
+
+	if (idx > ARRAY_SIZE(ucsi->ports)) {
+		dev_err_ratelimited(ucsi->dev, "notification port index out of range (%d)\n", idx);
+		return;
+	}
+
+	port = &ucsi->ports[idx];
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	orientation = FIELD_GET(SC8180X_ORIENTATION_MASK, notification);
+	port->orientation = pmic_glink_altmode_orientation(orientation);
+	port->mux = FIELD_GET(SC8180X_MUX_MASK, notification);
+	port->mode = FIELD_GET(SC8180X_MODE_MASK, notification);
+	port->hpd_state = FIELD_GET(SC8180X_HPD_STATE_MASK, notification);
+	port->hpd_irq = FIELD_GET(SC8180X_HPD_IRQ_MASK, notification);
+
+	if (port->mux == USBC_MUX_DP_4L ||
+	    port->mux == USBC_MUX_USB_DP)
+		port->svid = USB_TYPEC_DP_SID;
+	else
+		port->svid = USB_SID_PD;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	schedule_work(&port->altmode_work);
+}
+
+/* used everywhere except sc8180x */
+static void pmic_glink_ucsi_altmode_notify_ind(struct pmic_glink_ucsi *ucsi, u16 svid, const void *data, size_t len)
+{
+	const struct usbc_pan_notify_ind_msg *msg;
+	struct pmic_glink_ucsi_port *port;
+	unsigned long flags;
+	unsigned int idx;
+
+	if (len != sizeof (*msg)) {
+		dev_err_ratelimited(ucsi->dev, "Unexpected altmode notify struct size %zd\n", len);
+		return;
+	}
+
+	msg = data;
+
+	idx = msg->payload[0];
+	if (idx > ARRAY_SIZE(ucsi->ports)) {
+		dev_err_ratelimited(ucsi->dev, "notification port index out of range (%d)\n", idx);
+		return;
+	}
+
+	port = &ucsi->ports[idx];
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	port->orientation = pmic_glink_altmode_orientation(msg->payload[1]);
+	port->mux = msg->payload[2];
+	port->svid = svid;
+	port->mode = FIELD_GET(SC8280XP_DPAM_MASK, msg->payload[8]);
+	port->hpd_state = FIELD_GET(SC8280XP_HPD_STATE_MASK, msg->payload[8]);
+	port->hpd_irq = FIELD_GET(SC8280XP_HPD_IRQ_MASK, msg->payload[8]);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	schedule_work(&port->altmode_work);
+}
+
+static struct typec_altmode *find_altmode(struct ucsi_connector *con,
+					  u16 svid)
+{
+	int i;
+
+	for (i = 0; con->port_altmode[i]; i++) {
+		if (con->port_altmode[i]->svid == svid)
+			return con->port_altmode[i];
+	}
+
+	return NULL;
+}
+
+static void pmic_glink_ucsi_set_state(struct ucsi_connector *con,
+				      struct pmic_glink_ucsi_port *port)
+{
+	struct typec_displayport_data dp_data = {};
+	struct typec_altmode *altmode = NULL;
+	unsigned long flags;
+	void *data = NULL;
+	int mode;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (port->svid == USB_SID_PD) {
+		mode = TYPEC_STATE_USB;
+	} else if (port->svid == USB_TYPEC_DP_SID && port->mode == DPAM_HPD_OUT) {
+		mode = TYPEC_STATE_SAFE;
+	} else if (port->svid == USB_TYPEC_DP_SID) {
+		altmode = find_altmode(con, port->svid);
+		if (!altmode) {
+			dev_err(con->ucsi->dev, "altmode woth SVID 0x%04x not found\n",
+				port->svid);
+			spin_unlock_irqrestore(&port->lock, flags);
+			return;
+		}
+
+		mode = TYPEC_MODAL_STATE(port->mode - DPAM_HPD_A);
+
+		dp_data.status = DP_STATUS_ENABLED;
+		dp_data.status |= DP_STATUS_CON_DFP_D;
+		if (port->hpd_state)
+			dp_data.status |= DP_STATUS_HPD_STATE;
+		if (port->hpd_irq)
+			dp_data.status |= DP_STATUS_IRQ_HPD;
+		dp_data.conf = DP_CONF_SET_PIN_ASSIGN(port->mode - DPAM_HPD_A);
+
+		data = &dp_data;
+	} else {
+		dev_err(con->ucsi->dev, "Unsupported SVID 0x%04x\n", port->svid);
+		spin_unlock_irqrestore(&port->lock, flags);
+		return;
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (altmode)
+		typec_altmode_set_port(altmode, mode, data);
+	else
+		typec_set_mode(con->port, mode);
+
+	if (port->bridge)
+		drm_aux_hpd_bridge_notify(&port->bridge->dev,
+					  port->hpd_state ?
+					  connector_status_connected :
+					  connector_status_disconnected);
+
+}
+
+static void pmic_glink_ucsi_handle_altmode(struct pmic_glink_ucsi_port *port)
+{
+	struct pmic_glink_ucsi *ucsi = port->ucsi;
+	struct ucsi_connector *con;
+	int idx = port->idx;
+
+	if (idx > ucsi->ucsi->cap.num_connectors) {
+		dev_warn_ratelimited(ucsi->ucsi->dev, "altmode port out of range: %d\n", idx);
+		goto out;
+	}
+
+	con = &ucsi->ucsi->connector[idx];
+
+	mutex_lock(&con->lock);
+
+	pmic_glink_ucsi_set_orientation(con, port);
+
+	pmic_glink_ucsi_set_state(con, port);
+
+	mutex_unlock(&con->lock);
+
+out:
+	pmic_glink_altmode_request(ucsi, ALTMODE_PAN_ACK, idx);
+}
+
+static void pmic_glink_ucsi_altmode_work(struct work_struct *work)
+{
+	struct pmic_glink_ucsi_port *port = container_of(work, struct pmic_glink_ucsi_port, altmode_work);
+
+	pmic_glink_ucsi_handle_altmode(port);
+}
+
 static void pmic_glink_ucsi_notify_work_sc8180x(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, notify_work_sc8180x);
@@ -324,7 +713,10 @@ static void pmic_glink_ucsi_callback_sc8180x(const void *data, size_t len, void
 		pmic_glink_ucsi_write_ack(ucsi, data, len);
 		break;
 	case UC_UCSI_USBC_NOTIFY_IND:
-		schedule_work(&ucsi->notify_work_sc8180x);
+		pmic_glink_ucsi_notify_ind_sc8180x(ucsi, data, len);
+		break;
+	case USBC_CMD_WRITE_REQ:
+		complete(&ucsi->pan_ack);
 		break;
 	};
 }
@@ -347,6 +739,26 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
 	};
 }
 
+static void pmic_glink_ucsi_altmode_callback(const void *data, size_t len, void *priv)
+{
+	struct pmic_glink_ucsi *ucsi = priv;
+	const struct pmic_glink_hdr *hdr = data;
+	u16 opcode;
+	u16 svid;
+
+	opcode = le32_to_cpu(hdr->opcode) & 0xff;
+	svid = le32_to_cpu(hdr->opcode) >> 16;
+
+	switch (opcode) {
+	case USBC_CMD_WRITE_REQ:
+		complete(&ucsi->pan_ack);
+		break;
+	case USBC_PAN_NOTIFY_IND:
+		pmic_glink_ucsi_altmode_notify_ind(ucsi, svid, data, len);
+		break;
+	};
+}
+
 static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
 {
 	struct pmic_glink_ucsi *ucsi = priv;
@@ -357,6 +769,11 @@ static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
 		ucsi_unregister(ucsi->ucsi);
 }
 
+static void pmic_glink_ucsi_altmode_pdr_notify(void *priv, int state)
+{
+	/* do nothing */
+}
+
 static void pmic_glink_ucsi_destroy(void *data)
 {
 	struct pmic_glink_ucsi *ucsi = data;
@@ -389,7 +806,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	const struct of_device_id *match;
 	struct fwnode_handle *fwnode;
 	bool sc8180x_glink;
-	int ret;
+	int i, ret;
 
 	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
 	if (!ucsi)
@@ -403,6 +820,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	init_completion(&ucsi->read_ack);
 	init_completion(&ucsi->write_ack);
 	init_completion(&ucsi->sync_ack);
+	init_completion(&ucsi->pan_ack);
 	mutex_init(&ucsi->lock);
 
 	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
@@ -436,27 +854,64 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 		}
 
 		desc = devm_gpiod_get_index_optional(&adev->dev, "orientation", port, GPIOD_IN);
-
-		/* If GPIO isn't found, continue */
-		if (!desc)
-			continue;
-
 		if (IS_ERR(desc))
 			return dev_err_probe(dev, PTR_ERR(desc),
 					     "unable to acquire orientation gpio\n");
-		ucsi->port_orientation[port] = desc;
+		ucsi->ports[port].port_orientation = desc;
+
+		ucsi->ports[port].bridge = devm_drm_dp_hpd_bridge_alloc(ucsi->dev,
+									to_of_node(fwnode));
+		if (IS_ERR(ucsi->ports[port].bridge)) {
+			fwnode_handle_put(fwnode);
+			return PTR_ERR(ucsi->ports[port].bridge);
+		}
+	}
+
+	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
+		if (!ucsi->ports[i].bridge)
+			continue;
+
+		ret = devm_drm_dp_hpd_bridge_add(dev, ucsi->ports[i].bridge);
+		if (ret)
+			return ret;
 	}
 
 	sc8180x_glink = of_device_is_compatible(dev->parent->of_node,
 						"qcom,sc8180x-pmic-glink");
 
+	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
+		ucsi->ports[i].idx = i;
+		ucsi->ports[i].ucsi = ucsi;
+		spin_lock_init(&ucsi->ports[i].lock);
+		INIT_WORK(&ucsi->ports[i].altmode_work,
+			  pmic_glink_ucsi_altmode_work);
+	}
+
 	if (sc8180x_glink) {
+		ucsi->altmode_id = PMIC_GLINK_OWNER_USBC;
+
+		/*
+		 * We don't need another instance of USBC client, both altmode
+		 * and UCSI are handled via the same client.
+		 */
 		ucsi->client = devm_pmic_glink_register_client(dev,
 							       PMIC_GLINK_OWNER_USBC,
 							       pmic_glink_ucsi_callback_sc8180x,
 							       pmic_glink_ucsi_pdr_notify,
 							       ucsi);
+		ucsi->altmode_client = ucsi->client;
 	} else {
+		ucsi->altmode_id = PMIC_GLINK_OWNER_USBC_PAN;
+
+		ucsi->altmode_client =
+			devm_pmic_glink_register_client(dev,
+							ucsi->altmode_id,
+							pmic_glink_ucsi_altmode_callback,
+							pmic_glink_ucsi_altmode_pdr_notify,
+							ucsi);
+		if (IS_ERR(ucsi->altmode_client))
+			return PTR_ERR(ucsi->altmode_client);
+
 		ucsi->client = devm_pmic_glink_register_client(dev,
 							       PMIC_GLINK_OWNER_USBC,
 							       pmic_glink_ucsi_callback,

-- 
2.39.2



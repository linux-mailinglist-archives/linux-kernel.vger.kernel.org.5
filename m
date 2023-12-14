Return-Path: <linux-kernel+bounces-235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC795813E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03661C21ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677436BB3E;
	Thu, 14 Dec 2023 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nrkr4mBN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56885375
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-db402e6f61dso46962276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595358; x=1703200158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz+cpxw87bBcltOixsK8G6eWK5Oge5gGdoz15FOhQEk=;
        b=Nrkr4mBN7v9iAXq17gPkpcZbxI0n0HhaYzdx671Ny0Mkzbv7T23E2yXacq2bhGkCg9
         /0Wa8UNRS6snKYAorTufKH13NmD5Jpleh6p0dUcZ368t1O7EwSEeA6lodgnHrXuJ2mTW
         AYc/SkoE9t3LyxlB8wEVlMuf9A+dz3fltyiB1R0RWZI8Ak8G40vdFgHqp2jOgFpWK1oW
         VsppC3bE8MdRJpK4ZsLlFfyheIH1fMlPTIub/eOx0/zB4I8W4porRmWE5vQeKs9xTGHF
         mS8JnFa2By5iz2ByIdTV8XPPIsIae4U8DhPsDH/Sk5Ezd2IXngSur7Q4dziPccGPMZuz
         W3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595358; x=1703200158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz+cpxw87bBcltOixsK8G6eWK5Oge5gGdoz15FOhQEk=;
        b=HBPFOSUAkMwfKToefVJeESBBMQW7zUQT47k/LIapONXKld3cWe8pR0lRsDW+Qn4Mhw
         4Z5CcZLI+0Uv9bi3PcncICN7nbSoN2n9aO3YQG+l4GdSri5j1K9nEZbC+EwdDsMH4isr
         a/1w+YNEz72HD7USqulee98tR5Vdql4dJLaJQykdc8FKgaG90tdkkpJuNAuOpCTkgjet
         QwiMcA2oj2hm1V7VR+TLUAgl2wox1m08VQGPu2SVwtu48sWC9oYFQaIBZYnf4lighAcW
         6dZRglC0PslBeNQsf9l2LqIC/AZR//TTbrr9Whhw+dOykuS3A7uWHx9jf66GHoAY4CY9
         hZEw==
X-Gm-Message-State: AOJu0Yx8f87rhXBudgHd4ocsgemL1vMnwGT3Cdpo7Ff+hddy9k3wBgg8
	C5KfAUq9NEr/T0H2+93DkA4eUUfOsKOjchw=
X-Google-Smtp-Source: AGHT+IGezvGLmPus/gDItq2S+afswo9Ywijqol7p+OO4spt0ZzhmRxxNJ7qcg22vE45xYVVcAL6+8oi19ut+LRs=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:7807:0:b0:dbc:cf5d:eb6a with SMTP id
 t7-20020a257807000000b00dbccf5deb6amr45577ybc.9.1702595357976; Thu, 14 Dec
 2023 15:09:17 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:55 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7080; i=rdbabiera@google.com;
 h=from:subject; bh=Qwp5SB6x+/zmM3IGFy3mOqg4GMXYHPpIkgL4lMheOY4=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3ew/gx+XCxclz5fVzbx23WvRAVuu1WYRl7Nyi5ZV/
 3AVNVrZUcrCIMbBICumyKLrn2dw40rqljmcNcYwc1iZQIYwcHEKwETcbjL8Lz/JcilWYtUiDnej
 y3HyFh+T1O4enrZM/tykVwEqfIq8qxn+abfutPsQv2HKf57LcVs3H73td2v3kuemLJ93/6k+oRL DxwUA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-25-rdbabiera@google.com>
Subject: [PATCH v2 11/12] usb: typec: tcpm: add alt mode enter/exit/vdm
 support for sop'
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add tcpm_cable_ops for enter, exit, and vdm to the tcpm, which are
registered after registering port alt modes through
typec_port_register_cable_ops. Enter Mode on SOP' now sends Exit Mode upon
failure to report to the driver.

tcpm_queue_vdm_unlocked now takes sop type as input. Proper adev_actions
in tcpm_pd_svdm are selected for SOP' messages.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 126 ++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 61433dc4c917..aa3351328e7f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1549,7 +1549,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 }
 
 static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
-				    const u32 *data, int cnt)
+				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
 {
 	mutex_lock(&port->lock);
 	tcpm_queue_vdm(port, header, data, cnt, TCPC_TX_SOP);
@@ -2137,14 +2137,28 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			}
 			break;
 		case CMD_ENTER_MODE:
-			if (adev && pdev)
-				*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
+			*response_tx_sop_type = rx_sop_type;
+			if (rx_sop_type == TCPC_TX_SOP) {
+				if (adev && pdev) {
+					typec_altmode_update_active(pdev, true);
+					*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
+				}
+			} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+				if (adev && pdev_prime) {
+					typec_altmode_update_active(pdev_prime, true);
+					*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
+				}
+			}
 			return 0;
 		case CMD_EXIT_MODE:
-			if (adev && pdev) {
-				/* Back to USB Operation */
-				*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
-				return 0;
+			*response_tx_sop_type = rx_sop_type;
+			if (rx_sop_type == TCPC_TX_SOP) {
+				if (adev && pdev) {
+					typec_altmode_update_active(pdev, false);
+					/* Back to USB Operation */
+					*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
+					return 0;
+				}
 			}
 			break;
 		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
@@ -2277,19 +2291,37 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			typec_altmode_vdm(adev, p[0], &p[1], cnt);
 			break;
 		case ADEV_QUEUE_VDM:
-			typec_altmode_vdm(adev, p[0], &p[1], cnt);
+			if (response_tx_sop_type == TCPC_TX_SOP_PRIME)
+				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
+			else
+				typec_altmode_vdm(adev, p[0], &p[1], cnt);
 			break;
 		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
-			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
-				int svdm_version = typec_get_negotiated_svdm_version(
-									port->typec_port);
-				if (svdm_version < 0)
-					break;
+			if (response_tx_sop_type == TCPC_TX_SOP_PRIME) {
+				if (typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P,
+							    p[0], &p[1], cnt)) {
+					int svdm_version = typec_get_cable_svdm_version(
+										port->typec_port);
+					if (svdm_version < 0)
+						break;
 
-				response[0] = VDO(adev->svid, 1, svdm_version,
-						  CMD_EXIT_MODE);
-				response[0] |= VDO_OPOS(adev->mode);
-				rlen = 1;
+					response[0] = VDO(adev->svid, 1, svdm_version,
+							CMD_EXIT_MODE);
+					response[0] |= VDO_OPOS(adev->mode);
+					rlen = 1;
+				}
+			} else {
+				if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
+					int svdm_version = typec_get_negotiated_svdm_version(
+										port->typec_port);
+					if (svdm_version < 0)
+						break;
+
+					response[0] = VDO(adev->svid, 1, svdm_version,
+							CMD_EXIT_MODE);
+					response[0] |= VDO_OPOS(adev->mode);
+					rlen = 1;
+				}
 			}
 			break;
 		case ADEV_ATTENTION:
@@ -2724,7 +2756,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
+	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
 	return 0;
 }
 
@@ -2741,7 +2773,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
+	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
 	return 0;
 }
 
@@ -2750,7 +2782,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
+	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
 
 	return 0;
 }
@@ -2761,6 +2793,58 @@ static const struct typec_altmode_ops tcpm_altmode_ops = {
 	.vdm = tcpm_altmode_vdm,
 };
 
+
+static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_plug_index sop,
+				    u32 *vdo)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	int svdm_version;
+	u32 header;
+
+	svdm_version = typec_get_cable_svdm_version(port->typec_port);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
+	return 0;
+}
+
+static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	int svdm_version;
+	u32 header;
+
+	svdm_version = typec_get_cable_svdm_version(port->typec_port);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
+	return 0;
+}
+
+static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
+				  u32 header, const u32 *data, int count)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+
+	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
+
+	return 0;
+}
+
+static const struct typec_cable_ops tcpm_cable_ops = {
+	.enter = tcpm_cable_altmode_enter,
+	.exit = tcpm_cable_altmode_exit,
+	.vdm = tcpm_cable_altmode_vdm,
+};
+
 /*
  * PD (data, control) command handling functions
  */
@@ -7295,6 +7379,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	typec_port_register_altmodes(port->typec_port,
 				     &tcpm_altmode_ops, port,
 				     port->port_altmode, ALTMODE_DISCOVERY_MAX);
+	typec_port_register_cable_ops(port->port_altmode, ARRAY_SIZE(port->port_altmode),
+				      &tcpm_cable_ops);
 	port->registered = true;
 
 	mutex_lock(&port->lock);
-- 
2.43.0.472.g3155946c3a-goog



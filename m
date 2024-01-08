Return-Path: <linux-kernel+bounces-20028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D623827863
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F39C281B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B595E5577A;
	Mon,  8 Jan 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9X2Vt0J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4456B73
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f69158f32eso25689377b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741409; x=1705346209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrTURjyagiHJyBtcVShn21olo2si3J8rHveL7Fpwpm8=;
        b=O9X2Vt0JDanbJO9KxEqkTNqe3nnoTUwreYqjRxkQvYJCbLzQMa/G/F4uqLA5WF2vlz
         vWyB4G5/BHSXtZQceuvSY+7LOqRDcTf0JbjuRv5wHvDXNxehsE2N5iOsvmmnYivKj1G2
         GSG2woo20boRRp/iD12mEfkb9DF7WN5pEhtZv3zWYtHFCXJKoNt1mDrUi8Y24ue+i6Yp
         9ocEz06z+js2FNBha6lVeTkLJ/kEfC3ELKvPWh7jdVVgeiFkM2U4gm7ayv+XQ8ODjFr4
         Il4RkwprMMweJboRnNISMcrwO68MSkJ2yQfCeveHRoD7bCtlffj51luLj40+OLGmloFY
         7Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741409; x=1705346209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrTURjyagiHJyBtcVShn21olo2si3J8rHveL7Fpwpm8=;
        b=mfeXfATqGymx25RM2yKwTkrzfPc2NqgBV4JXZzXwVbq1nL/uSpvxmfeMfZZUy4N+YV
         f74Wr1SSl9YST7gKu1pE1RTRqLxmX5b9OEGO1rwgYCK2DXWp08BGT+3QDNKHiVQ6ACD8
         PSeiUltUUo2D4xerLRrBBsOV4Z33PoGwv0zQyr8T7W9iFjRV2Tc9kZAaZmuMiOPRW43R
         1xic3SzqllKg5SIYJ4DKUksWCWYVYjLeC6ietoWNgCzkdcKR6GpKU0gljt87noDJ42dR
         z4zx8tQyPGxq9GtkGiOT0l8V7G4AVzJUL81aGTEnBNUUlvAUA1+jXslfFCk75OyYc4lf
         82pw==
X-Gm-Message-State: AOJu0YzQSK1X471ELz7MWZVbMxyyrsLgThpp78hS9CZNDsl6Mh7F8UOe
	kc2ZM/9Phq72+sjlfNnUFWx7I1FmGrOFGwT+kaIhVQ==
X-Google-Smtp-Source: AGHT+IFTH/hcqBkRqm9hHg05HrQJoXe8OZ4OfLoiCTQeD4qJaCHmwXtxf52nDiOKgbveQlG3D5Eel+6qz5y6kZ4=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:690c:316:b0:5e6:96cc:9f17 with SMTP
 id bg22-20020a05690c031600b005e696cc9f17mr1985952ywb.7.1704741409658; Mon, 08
 Jan 2024 11:16:49 -0800 (PST)
Date: Mon,  8 Jan 2024 19:16:24 +0000
In-Reply-To: <20240108191620.987785-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108191620.987785-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7080; i=rdbabiera@google.com;
 h=from:subject; bh=zfLOD65UxztyY2+yQMPbZDKDeJGzKZyWqg0N75vilbE=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlzvDhfR7Ewzl01J91JJaJPku1a8cctd1ZMeLG6Kn3zx
 7Uym7PfdZSyMIhxMMiKKbLo+ucZ3LiSumUOZ40xzBxWJpAhDFycAjCRo8sY/kc0Ta0KFN1y84JP
 +ZNT+v/EL9cFRInaC5kHMj5z+BU2s5ORYWbmucNanrbvDZfkuV5nSpib5PP1belBmW8Jy08dPnC 0kQMA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108191620.987785-25-rdbabiera@google.com>
Subject: [PATCH v3 11/12] usb: typec: tcpm: add alt mode enter/exit/vdm
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
index d16edf112858..86d9962961c2 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1556,7 +1556,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 }
 
 static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
-				    const u32 *data, int cnt)
+				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
 {
 	mutex_lock(&port->lock);
 	tcpm_queue_vdm(port, header, data, cnt, TCPC_TX_SOP);
@@ -2144,14 +2144,28 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
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
@@ -2284,19 +2298,37 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
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
@@ -2731,7 +2763,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
+	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
 	return 0;
 }
 
@@ -2748,7 +2780,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
+	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
 	return 0;
 }
 
@@ -2757,7 +2789,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
+	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
 
 	return 0;
 }
@@ -2768,6 +2800,58 @@ static const struct typec_altmode_ops tcpm_altmode_ops = {
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
@@ -7507,6 +7591,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	typec_port_register_altmodes(port->typec_port,
 				     &tcpm_altmode_ops, port,
 				     port->port_altmode, ALTMODE_DISCOVERY_MAX);
+	typec_port_register_cable_ops(port->port_altmode, ARRAY_SIZE(port->port_altmode),
+				      &tcpm_cable_ops);
 	port->registered = true;
 
 	mutex_lock(&port->lock);
-- 
2.43.0.472.g3155946c3a-goog



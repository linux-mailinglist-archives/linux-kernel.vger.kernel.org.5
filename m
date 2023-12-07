Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED6E80846E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjLGJH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjLGJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:07:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E54137
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:08:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d98fde753eso6626637b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701940081; x=1702544881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuwO1i75ULAaVoZs1xyVi1Y8jYwy5X8JcJl1W/tPnh8=;
        b=s3thMgXTMJT6LdOho98Ub/eTaBCw2+LhL+MA+ITPyoPLLcQLOniE7k+OZ6JsUyJC6h
         EqAtq/YQEhtpQMA4gJU1yWj2V7O7mbpx/NT9pXyeU3/3nCqJYeaGDHKtdEW/O5yIzeR5
         0UqStJp4MvaPY/VzsFNslz99RYypz8eIZRrbGf1mv5Fmfx1dGrqyD/mof5miv3IFzV3T
         K5HGz10fWaE7jEC5/3v2+5KZbEiHJeWVjeQOAFDVAj9PtJNddI2UEQa/DXjJ6DD7d5uc
         pI8r0SVjdVkGUEqXgQTK2iUGokPGYYj+K5Pt9gEwTk7Pn6vWaeYq6BCCuuyMWCeepww5
         ZvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940081; x=1702544881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuwO1i75ULAaVoZs1xyVi1Y8jYwy5X8JcJl1W/tPnh8=;
        b=rs09Vu3Lo2vNbH/ndlbK4E80tPKL7dNJCFr0f0Ckw4Dfy4G/fgSzpCcO/PDGmQoPz4
         Yzi43JQq/CVRN6pvu7rEMukWGKO9nZFcGdBUYUI2WUsOx9wZwJAdS/EFF1939dVYZToO
         F4mM2jlhb9uOXZaM4wiK9jhsjDtFAlLy1ldcrGVUHmgRioYSUa5LB+YUUHc6ppBZ6mfX
         20uiFz5Oj4Uu6Bqekvg6fo/JEao3jcJ3ATiICET4i3G4yreVMszBnwLJA/jUMX/T0Xbh
         BkKDe9+uwBBqkBha09HsN0ojSoSLK9NbMcc74AAoIZemPnsCbVWaFhpRtqYDaOVRBpLv
         zSmA==
X-Gm-Message-State: AOJu0Yw0pRdTOLQ8REWTBy0U5RRQLq7QcNbAhLuroxG0pocJ/Q8k8Y/h
        BMY0GTe7xo3b6v2kGvwBV2HyjuFJrC8eOpQ=
X-Google-Smtp-Source: AGHT+IHsWlxxa/LP64vEBaMBpQ5GH1v+h1RJAoSuyJIrlkHzy7oBcam9q6nEHFOhWQKQ4PXh5iAneho56WSnQ10=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:690c:408b:b0:5d3:d6c3:dc6 with SMTP
 id gb11-20020a05690c408b00b005d3d6c30dc6mr30642ywb.7.1701940081217; Thu, 07
 Dec 2023 01:08:01 -0800 (PST)
Date:   Thu,  7 Dec 2023 09:07:33 +0000
In-Reply-To: <20231207090738.15721-12-rdbabiera@google.com>
Mime-Version: 1.0
References: <20231207090738.15721-12-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9747; i=rdbabiera@google.com;
 h=from:subject; bh=aiPdmHgbqxhZVP1Ijw5Y52oNJyZpFyMwwjjUZtB41UU=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmF3dGvZOxvzg/3Lwg/FT6td69RcoFCTlnm5n3JK1lEX
 v2I//C8o5SFQYyDQVZMkUXXP8/gxpXULXM4a4xh5rAygQxh4OIUgIksL2JkODCjOGdds0xS68SN
 N6Wu2fB6mko17AvI2v7b/uOunLsy1YwM85IWaGskPUgWzOEUsPr2t2O+83bn8gshjlbb1S7JSJ1 lBwA=
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207090738.15721-14-rdbabiera@google.com>
Subject: [PATCH v1 02/10] usb: typec: tcpci: enable reception of SOP' messages
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, linux@roeck-us.net,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        bleung@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     badhri@google.com, tzungbi@kernel.org, utkarsh.h.patel@intel.com,
        andriy.shevchenko@linux.intel.com,
        RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cable_comm_capable to tcpci_data for tcpci drivers to indicate that
the port tcpc is capable of communicating to cables over SOP. A
corresponding tcpci callback tcpci_cable_comm_capable returns this value.
The tcpm will primarily use this in later patches to determine if the port
can transmit and receive SOP' messages.

tcpci_set_pd_rx now utilizes the cable_comm_capable flag to determine if
TCPC_RX_DETECT_SOP1 should be added to the bitfield when enabling PD
message reception.

In the tcpci, add a definition for TCPC_RX_BUF_FRAME_TYPE_SOP1 as described
in the Type C Port Controller Interface Specification Section 4.4.14.

Maxim based tcpci drivers are capable of SOP' communication, so the
cable_comm_capable flag is set to true. process_rx now takes the SOP' into
account and passes the value to tcpm_pd_receive.

tcpm_pd_receive adds the SOP type as a parameter, and passes it within the
pd_rx_event struct for tcpm_pd_rx_handler to use. For now, the handler
drops all SOP' messages.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c            | 15 +++++++++++++--
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 20 +++++++++++++++++---
 drivers/usb/typec/tcpm/tcpm.c             | 10 +++++++++-
 include/linux/usb/tcpci.h                 |  4 ++++
 include/linux/usb/tcpm.h                  |  7 ++++++-
 5 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 0ee3e6e29bb1..8ea4ed159a13 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -445,8 +445,11 @@ static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
 	unsigned int reg = 0;
 	int ret;
 
-	if (enable)
+	if (enable) {
 		reg = TCPC_RX_DETECT_SOP | TCPC_RX_DETECT_HARD_RESET;
+		if (tcpci->data->cable_comm_capable)
+			reg |= TCPC_RX_DETECT_SOP1;
+	}
 	ret = regmap_write(tcpci->regmap, TCPC_RX_DETECT, reg);
 	if (ret < 0)
 		return ret;
@@ -584,6 +587,13 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type
 	return 0;
 }
 
+static bool tcpci_cable_comm_capable(struct tcpc_dev *tcpc)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	return tcpci->data->cable_comm_capable;
+}
+
 static int tcpci_init(struct tcpc_dev *tcpc)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -712,7 +722,7 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		/* Read complete, clear RX status alert bit */
 		tcpci_write16(tcpci, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
 
-		tcpm_pd_receive(tcpci->port, &msg);
+		tcpm_pd_receive(tcpci->port, &msg, TCPC_TX_SOP);
 	}
 
 	if (tcpci->data->vbus_vsafe0v && (status & TCPC_ALERT_EXTENDED_STATUS)) {
@@ -793,6 +803,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
+	tcpci->tcpc.cable_comm_capable = tcpci_cable_comm_capable;
 
 	if (tcpci->data->check_contaminant)
 		tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 7fb966fd639b..548c583ab1a1 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -128,6 +128,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	u8 count, frame_type, rx_buf[TCPC_RECEIVE_BUFFER_LEN];
 	int ret, payload_index;
 	u8 *rx_buf_ptr;
+	enum tcpm_transmit_type rx_type;
 
 	/*
 	 * READABLE_BYTE_COUNT: Indicates the number of bytes in the RX_BUF_BYTE_x registers
@@ -142,11 +143,23 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 
 	count = rx_buf[TCPC_RECEIVE_BUFFER_COUNT_OFFSET];
 	frame_type = rx_buf[TCPC_RECEIVE_BUFFER_FRAME_TYPE_OFFSET];
+	switch (frame_type) {
+	case TCPC_RX_BUF_FRAME_TYPE_SOP1:
+		rx_type = TCPC_TX_SOP_PRIME;
+		break;
+	case TCPC_RX_BUF_FRAME_TYPE_SOP:
+		rx_type = TCPC_TX_SOP;
+		break;
+	default:
+		rx_type = TCPC_TX_SOP;
+		break;
+	}
 
-	if (count == 0 || frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP) {
+	if (count == 0 || (frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP &&
+	    frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP1)) {
 		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
 		dev_err(chip->dev, "%s\n", count ==  0 ? "error: count is 0" :
-			"error frame_type is not SOP");
+			"error frame_type is not SOP/SOP'");
 		return;
 	}
 
@@ -183,7 +196,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	if (ret < 0)
 		return;
 
-	tcpm_pd_receive(chip->port, &msg);
+	tcpm_pd_receive(chip->port, &msg, rx_type);
 }
 
 static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, bool source, bool sink)
@@ -478,6 +491,7 @@ static int max_tcpci_probe(struct i2c_client *client)
 	chip->data.vbus_vsafe0v = true;
 	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
 	chip->data.check_contaminant = max_tcpci_check_contaminant;
+	chip->data.cable_comm_capable = true;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 795e3145b0c2..5f9a4691f626 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -506,6 +506,7 @@ struct pd_rx_event {
 	struct kthread_work work;
 	struct tcpm_port *port;
 	struct pd_message msg;
+	enum tcpm_transmit_type rx_sop_type;
 };
 
 static const char * const pd_rev[] = {
@@ -2972,6 +2973,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 	const struct pd_message *msg = &event->msg;
 	unsigned int cnt = pd_header_cnt_le(msg->header);
 	struct tcpm_port *port = event->port;
+	enum tcpm_transmit_type rx_sop_type = event->rx_sop_type;
 
 	mutex_lock(&port->lock);
 
@@ -2982,6 +2984,10 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 		enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
 		unsigned int msgid = pd_header_msgid_le(msg->header);
 
+		/* Ignore SOP' for now */
+		if (rx_sop_type == TCPC_TX_SOP_PRIME)
+			goto done;
+
 		/*
 		 * USB PD standard, 6.6.1.2:
 		 * "... if MessageID value in a received Message is the
@@ -3019,7 +3025,8 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 	kfree(event);
 }
 
-void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg)
+void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg,
+		     enum tcpm_transmit_type rx_sop_type)
 {
 	struct pd_rx_event *event;
 
@@ -3029,6 +3036,7 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg)
 
 	kthread_init_work(&event->work, tcpm_pd_rx_handler);
 	event->port = port;
+	event->rx_sop_type = rx_sop_type;
 	memcpy(&event->msg, msg, sizeof(*msg));
 	kthread_queue_work(port->wq, &event->work);
 }
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 467e8045e9f8..62c518cca934 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -145,6 +145,7 @@
 #define TCPC_RX_BYTE_CNT		0x30
 #define TCPC_RX_BUF_FRAME_TYPE		0x31
 #define TCPC_RX_BUF_FRAME_TYPE_SOP	0
+#define TCPC_RX_BUF_FRAME_TYPE_SOP1	1
 #define TCPC_RX_HDR			0x32
 #define TCPC_RX_DATA			0x34 /* through 0x4f */
 
@@ -188,6 +189,8 @@ struct tcpci;
  *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
  * @vbus_vsafe0v:
  *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
+ * @cable_comm_capable
+ *		optional; Set when TCPC can communicate with cable plugs over SOP'
  * @set_partner_usb_comm_capable:
  *		Optional; The USB Communications Capable bit indicates if port
  *		partner is capable of communication over the USB data lines
@@ -204,6 +207,7 @@ struct tcpci_data {
 	unsigned char TX_BUF_BYTE_x_hidden:1;
 	unsigned char auto_discharge_disconnect:1;
 	unsigned char vbus_vsafe0v:1;
+	unsigned char cable_comm_capable:1;
 
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 65fac5e1f317..41d1ac9c8bbf 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -119,6 +119,9 @@ enum tcpm_transmit_type {
  *		at the end of the deboumce period or when the port is still
  *		toggling. Chip level drivers are expected to check for contaminant
  *		and call tcpm_clean_port when the port is clean.
+ * @cable_comm_capable
+ *		Optional; Returns whether cable communication over SOP' is supported
+ *		by the tcpc
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -154,6 +157,7 @@ struct tcpc_dev {
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
 	void (*check_contaminant)(struct tcpc_dev *dev);
+	bool (*cable_comm_capable)(struct tcpc_dev *dev);
 };
 
 struct tcpm_port;
@@ -166,7 +170,8 @@ void tcpm_cc_change(struct tcpm_port *port);
 void tcpm_sink_frs(struct tcpm_port *port);
 void tcpm_sourcing_vbus(struct tcpm_port *port);
 void tcpm_pd_receive(struct tcpm_port *port,
-		     const struct pd_message *msg);
+		     const struct pd_message *msg,
+		     enum tcpm_transmit_type rx_sop_type);
 void tcpm_pd_transmit_complete(struct tcpm_port *port,
 			       enum tcpm_transmit_status status);
 void tcpm_pd_hard_reset(struct tcpm_port *port);
-- 
2.43.0.rc2.451.g8631bc7472-goog


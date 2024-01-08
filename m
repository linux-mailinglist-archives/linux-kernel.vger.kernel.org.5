Return-Path: <linux-kernel+bounces-20021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDF827851
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5E51C24019
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38D55C06;
	Mon,  8 Jan 2024 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkvB1Ko1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5AD55C22
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d552f40a4aso1842295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741397; x=1705346197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VA6GXsaY8kxjlMQ9qtGQVmBvg/30vKloMaDh2oUyHwI=;
        b=pkvB1Ko1EQ/BiNJ5bHJoxAn0AY8XniHOnH+oqKecqEaTcuDyAu82LCkvJmoV+cTDTv
         tyLZTDZSS5dxiYI2B017M1UMNKLwFxlu2uhWzHogegBeCIAVIobGb8pHyZSUiaTJgDOK
         I7telnMY9ESpt/bvyj3SZI9PcoMqBRdw+0tseCa50Y049eKHzZ9eX2ES4SYCZkNeOee3
         +1OYHgyQMVF8p2OG5K90JAT0bjvz4owR6L5IyoLJSWEBNAQ8iGsXxnunfDjXs3h/pyzt
         wR84+v3IPult/NjOMxna7kzDhpXMjVcY9p+xcvyHlj86gbD4CICdnsd2aKMi/auwL+k1
         V7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741397; x=1705346197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA6GXsaY8kxjlMQ9qtGQVmBvg/30vKloMaDh2oUyHwI=;
        b=NreqEibTRC7SxEg6pHiIuNEJ6uYFdHqBGmktURGgNxQyHM0XZ9HzRXcnm3pIuO7BIq
         QZdIr3FsEaAOCDnibf03ekr0SGjSlhYbvmhPOINCl8OzEa4qoN/9coXJuab0Nxd3gI3r
         aHRf9l1DuQqbSttZa8LBTBd7rNqyEfwN2KSV6bctuqpVGqAU1cofAlZbTPq/N5PhZeKM
         cLPu/in1pUnDpb/kSXO4juWvY4Cv00E9IiMSQQayssP0IJHUCgnzp36pa6Ca8/Zvly8J
         RDDojUIOUe0MhcWq1ZIa1sNMak6cRWfwSIR2o00DUAQx9QnJXO170wcSpnqjMAVj2rFh
         oBEA==
X-Gm-Message-State: AOJu0YzTyfAMUYS9pFAr8t3pJSqb4Y55/LpQhoni1hfXiEkRaLmWMZas
	YLKOVmcjSOv5fuf1Y175QjVH5VzpcxF8FjGqcFHFrw==
X-Google-Smtp-Source: AGHT+IHLeB3JtE/yg5rsa2U4JlRcIRg2oHST9k2zHOUcXXd40s+glPZ9flSrGLbpc8aszExhs9/dYz0/72zaFbE=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a17:902:c946:b0:1d5:82f:4fe9 with SMTP
 id i6-20020a170902c94600b001d5082f4fe9mr23296pla.2.1704741397360; Mon, 08 Jan
 2024 11:16:37 -0800 (PST)
Date: Mon,  8 Jan 2024 19:16:17 +0000
In-Reply-To: <20240108191620.987785-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108191620.987785-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8407; i=rdbabiera@google.com;
 h=from:subject; bh=MgJ6WW9+Da7xRutzrTnX/nmyFQBobvHWlziyx0kihc4=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlzvNiWcdoc2x3dznzoxfqlIcym25aqxLEukGB9Kh05V
 fcDP8P9jlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACZy8APD/zDFqf4qM/g2fs3+
 anDn26JPH1Kcw3z9Hb48Kwo4cu/001+MDOvULiwOnbVRTeXm/2cX/fT/bdpto+dY7bfmkFVCzuw juYwA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108191620.987785-18-rdbabiera@google.com>
Subject: [PATCH v3 04/12] usb: typec: tcpci: add tcpm_transmit_type to tcpm_pd_receive
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

tcpm_pd_receive adds the SOP type as a parameter, and passes it within the
pd_rx_event struct for tcpm_pd_rx_handler to use. For now, the handler
drops all SOP' messages.

Maxim based tcpci drivers are capable of SOP' communication, so process_rx
now takes the SOP type into account and passes the value to
tcpm_pd_receive.

tcpci_set_pd_rx now utilizes the cable_comm_capable flag to determine if
TCPC_RX_DETECT_SOP1 should be added to the bitfield when enabling PD
message reception.

For all other consumers of tcpm_pd_receive, default the new field to
TCPC_TX_SOP.

Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v2:
* added reviewed-by tag
---
 drivers/usb/typec/tcpm/fusb302.c              |  2 +-
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   |  2 +-
 drivers/usb/typec/tcpm/tcpci.c                |  7 +++++--
 drivers/usb/typec/tcpm/tcpci_maxim_core.c     | 20 ++++++++++++++++---
 drivers/usb/typec/tcpm/tcpm.c                 | 10 +++++++++-
 drivers/usb/typec/tcpm/wcove.c                |  2 +-
 include/linux/usb/tcpci.h                     |  1 +
 include/linux/usb/tcpm.h                      |  3 ++-
 8 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index bc21006e979c..ef18a448b740 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1467,7 +1467,7 @@ static int fusb302_pd_read_message(struct fusb302_chip *chip,
 	if ((!len) && (pd_header_type_le(msg->header) == PD_CTRL_GOOD_CRC))
 		tcpm_pd_transmit_complete(chip->tcpm_port, TCPC_TX_SUCCESS);
 	else
-		tcpm_pd_receive(chip->tcpm_port, msg);
+		tcpm_pd_receive(chip->tcpm_port, msg, TCPC_TX_SOP);
 
 	return ret;
 }
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index 52c81378e36e..a3154085ae32 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -299,7 +299,7 @@ static void qcom_pmic_typec_pdphy_pd_receive(struct pmic_typec_pdphy *pmic_typec
 
 	if (!ret) {
 		dev_vdbg(dev, "pd_receive: handing %d bytes to tcpm\n", size);
-		tcpm_pd_receive(pmic_typec_pdphy->tcpm_port, &msg);
+		tcpm_pd_receive(pmic_typec_pdphy->tcpm_port, &msg, TCPC_TX_SOP);
 	}
 }
 
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 1ededbcecc09..8ea4ed159a13 100644
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
@@ -719,7 +722,7 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		/* Read complete, clear RX status alert bit */
 		tcpci_write16(tcpci, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
 
-		tcpm_pd_receive(tcpci->port, &msg);
+		tcpm_pd_receive(tcpci->port, &msg, TCPC_TX_SOP);
 	}
 
 	if (tcpci->data->vbus_vsafe0v && (status & TCPC_ALERT_EXTENDED_STATUS)) {
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 7b2d4e6e52a2..f9f838df43f7 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -128,6 +128,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	u8 count, frame_type, rx_buf[TCPC_RECEIVE_BUFFER_LEN];
 	int ret, payload_index;
 	u8 *rx_buf_ptr;
+	enum tcpm_transmit_type rx_type;
 
 	/*
 	 * READABLE_BYTE_COUNT: Indicates the number of bytes in the RX_BUF_BYTE_x registers
@@ -143,10 +144,23 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	count = rx_buf[TCPC_RECEIVE_BUFFER_COUNT_OFFSET];
 	frame_type = rx_buf[TCPC_RECEIVE_BUFFER_FRAME_TYPE_OFFSET];
 
-	if (count == 0 || frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP) {
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
+
+	if (count == 0 || (frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP &&
+	    frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP1)) {
 		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
 		dev_err(chip->dev, "%s\n", count ==  0 ? "error: count is 0" :
-			"error frame_type is not SOP");
+			"error frame_type is not SOP/SOP'");
 		return;
 	}
 
@@ -183,7 +197,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	if (ret < 0)
 		return;
 
-	tcpm_pd_receive(chip->port, &msg);
+	tcpm_pd_receive(chip->port, &msg, rx_type);
 }
 
 static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, bool source, bool sink)
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5945e3a2b0f7..ff0fcf560c88 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -518,6 +518,7 @@ struct pd_rx_event {
 	struct kthread_work work;
 	struct tcpm_port *port;
 	struct pd_message msg;
+	enum tcpm_transmit_type rx_sop_type;
 };
 
 static const char * const pd_rev[] = {
@@ -2981,12 +2982,17 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 	const struct pd_message *msg = &event->msg;
 	unsigned int cnt = pd_header_cnt_le(msg->header);
 	struct tcpm_port *port = event->port;
+	enum tcpm_transmit_type rx_sop_type = event->rx_sop_type;
 
 	mutex_lock(&port->lock);
 
 	tcpm_log(port, "PD RX, header: %#x [%d]", le16_to_cpu(msg->header),
 		 port->attached);
 
+	/* Ignore SOP' for now */
+	if (rx_sop_type == TCPC_TX_SOP_PRIME)
+		goto done;
+
 	if (port->attached) {
 		enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
 		unsigned int msgid = pd_header_msgid_le(msg->header);
@@ -3028,7 +3034,8 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 	kfree(event);
 }
 
-void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg)
+void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg,
+		     enum tcpm_transmit_type rx_sop_type)
 {
 	struct pd_rx_event *event;
 
@@ -3038,6 +3045,7 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg)
 
 	kthread_init_work(&event->work, tcpm_pd_rx_handler);
 	event->port = port;
+	event->rx_sop_type = rx_sop_type;
 	memcpy(&event->msg, msg, sizeof(*msg));
 	kthread_queue_work(port->wq, &event->work);
 }
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 87d4abde0ea2..cf719307b3f6 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -535,7 +535,7 @@ static irqreturn_t wcove_typec_irq(int irq, void *data)
 				goto err;
 			}
 
-			tcpm_pd_receive(wcove->tcpm, &msg);
+			tcpm_pd_receive(wcove->tcpm, &msg, TCPC_TX_SOP);
 
 			ret = regmap_read(wcove->regmap, USBC_RXSTATUS,
 					  &status);
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 1d0b849defd0..9ed6d62c9c5f 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -145,6 +145,7 @@
 #define TCPC_RX_BYTE_CNT		0x30
 #define TCPC_RX_BUF_FRAME_TYPE		0x31
 #define TCPC_RX_BUF_FRAME_TYPE_SOP	0
+#define TCPC_RX_BUF_FRAME_TYPE_SOP1	1
 #define TCPC_RX_HDR			0x32
 #define TCPC_RX_DATA			0x34 /* through 0x4f */
 
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 430fa3ec69bb..41d1ac9c8bbf 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -170,7 +170,8 @@ void tcpm_cc_change(struct tcpm_port *port);
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
2.43.0.472.g3155946c3a-goog



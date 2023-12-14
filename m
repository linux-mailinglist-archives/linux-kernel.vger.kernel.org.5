Return-Path: <linux-kernel+bounces-230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2E813E11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A7A1C2112E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A57E572;
	Thu, 14 Dec 2023 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uclVww5P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373179460
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbc8996908dso18801276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595351; x=1703200151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Btfnblv+B9zrobCpvNmL8ig5sZy4m4/Ld1MfoN3QibE=;
        b=uclVww5Pchl6q3y06l5KmlC6Mp7aIw69OnygNmFdxGrOyVktsHXxKDxLjsbe5n1OC+
         BlvCmoy0gq8ttb1+phPXAWaZor/dQjtBdJQllnPgpApqFMacNcjSY4RCQxxohHAyMHgD
         ibRcts+tg848WfbRoSFERAvywvHsziXruCLwAxGyF1hWsjYGYUhOL+6P/az4peFvhfzP
         PTchHGy2c1QmzZ7ISVmn8wPhXa0VijS/9iD4I7rlFWKxOWLhnFJGdGF4CrrJrN+29T0x
         ZdLX1pjI9nkBO35m9LYk70qPG3RafEGNk2CnrBvVarIRGXBwQeI32JBN5ST3XW9cmId5
         REzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595351; x=1703200151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Btfnblv+B9zrobCpvNmL8ig5sZy4m4/Ld1MfoN3QibE=;
        b=TSxj0Q43TGHI9RDy576Bkb46KZGjWSSM5CSqpY8E6OaKuemQ0WzdCoHhpPk0SuCE/F
         jRbC8lFuGVzQLgFf7pJNXGvxKnZNaJgGCunkJywobPEJoyoWCV47TyvJk0iXMZrrTdbx
         0UqMlqUP4KNv01w6s3TvdWCXjWiL9IwmT8YtxaFDSsO09zORSvSl/U9mKsmdPo8Jcq1s
         0joE+T7jRbG8uejO7xkACRdXfHkqkE8MNsRuk/hsyBhdcW7nWgc6voIm9jqmc0skDfAk
         H8ANu+ML4TyhWNGho6d2CzZqPwMJPMX0yL6PnCM6cqqdMDST6x7MOK2POT4ic+plJwuU
         eR4Q==
X-Gm-Message-State: AOJu0YzIk52+CGDA/tgpfwVNQKoJ6qsgma2ZjF/xUQveuyanmadwmVCb
	Uc+CKywWMjKbnfhVIfEFZ+PQC01+M+hoLpg=
X-Google-Smtp-Source: AGHT+IEZscDpeaXxwCsX3QuWYBlCCaH/vn8/CT4FBfd4fb3hB7RpFkS9s8rks/6DGRJR08/75OajI1ps3uopkVs=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6902:1812:b0:dbc:cc25:8ab with SMTP
 id cf18-20020a056902181200b00dbccc2508abmr48105ybb.4.1702595351650; Thu, 14
 Dec 2023 15:09:11 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:51 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6577; i=rdbabiera@google.com;
 h=from:subject; bh=S1M5IGXTF0VUZ1D3L0QXM+nC/Tak34QHmzO3qhJO0ik=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3azXzeVfB4b4H+FjDw5JuhNWqPPxXv2P/7IJX+oKD
 rV4eV3tKGVhEONgkBVTZNH1zzO4cSV1yxzOGmOYOaxMIEMYuDgFYCLK2gz/naQuT6/zfe5+fVdW
 zblHqVohJz4Jem50zs1KPljAlcOxm+EP7+qf6y559b+qdunY6hW+qy5My1/C0Z2PT0R9mjv3m5X 8AA==
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-21-rdbabiera@google.com>
Subject: [PATCH v2 07/12] usb: typec: tcpci: add attempt_vconn_swap_discovery callback
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add attempt_vconn_swap_discovery callback to determine whether the TCPM
should perform a Vconn swap following Discover Identity on SOP. The tcpci
will return false unless chip level drivers implement the callback.

Maxim based TCPCs will return true unless the last connection resulted in
a Vconn Over Current Fault, which may be the result of the Vconn swap. In
addition to the port resetting, the TCPCI will veto the next Vconn swap
from occurring.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c            | 11 +++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h      |  1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 17 ++++++++++++++++-
 include/linux/usb/tcpci.h                 |  9 +++++++++
 include/linux/usb/tcpm.h                  |  9 +++++++++
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 8ea4ed159a13..40c7b6224c74 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -594,6 +594,16 @@ static bool tcpci_cable_comm_capable(struct tcpc_dev *tcpc)
 	return tcpci->data->cable_comm_capable;
 }
 
+static bool tcpci_attempt_vconn_swap_discovery(struct tcpc_dev *tcpc)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	if (tcpci->data->attempt_vconn_swap_discovery)
+		return tcpci->data->attempt_vconn_swap_discovery(tcpci, tcpci->data);
+
+	return false;
+}
+
 static int tcpci_init(struct tcpc_dev *tcpc)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -804,6 +814,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
 	tcpci->tcpc.cable_comm_capable = tcpci_cable_comm_capable;
+	tcpci->tcpc.attempt_vconn_swap_discovery = tcpci_attempt_vconn_swap_discovery;
 
 	if (tcpci->data->check_contaminant)
 		tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 2c1c4d161b0d..78ff3b73ee7e 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -62,6 +62,7 @@ struct max_tcpci_chip {
 	struct i2c_client *client;
 	struct tcpm_port *port;
 	enum contamiant_state contaminant_state;
+	bool veto_vconn_swap;
 };
 
 static inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index f9f838df43f7..eec3bcec119c 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -323,8 +323,10 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 		if (ret < 0)
 			return ret;
 
-		if (reg_status & TCPC_FAULT_STATUS_VCONN_OC)
+		if (reg_status & TCPC_FAULT_STATUS_VCONN_OC) {
+			chip->veto_vconn_swap = true;
 			tcpm_port_error_recovery(chip->port);
+		}
 	}
 
 	if (status & TCPC_ALERT_EXTND) {
@@ -458,6 +460,18 @@ static void max_tcpci_check_contaminant(struct tcpci *tcpci, struct tcpci_data *
 		tcpm_port_clean(chip->port);
 }
 
+static bool max_tcpci_attempt_vconn_swap_discovery(struct tcpci *tcpci, struct tcpci_data *tdata)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
+
+	if (chip->veto_vconn_swap) {
+		chip->veto_vconn_swap = false;
+		return false;
+	}
+
+	return true;
+}
+
 static int max_tcpci_probe(struct i2c_client *client)
 {
 	int ret;
@@ -493,6 +507,7 @@ static int max_tcpci_probe(struct i2c_client *client)
 	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
 	chip->data.check_contaminant = max_tcpci_check_contaminant;
 	chip->data.cable_comm_capable = true;
+	chip->data.attempt_vconn_swap_discovery = max_tcpci_attempt_vconn_swap_discovery;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 9ed6d62c9c5f..47a86b8a4a50 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -201,6 +201,14 @@ struct tcpci;
  *		toggling state.
  * @cable_comm_capable
  *		optional; Set when TCPC can communicate with cable plugs over SOP'
+ * @attempt_vconn_swap_discovery:
+ *		Optional; The callback is called by the TCPM when the result of
+ *		a Discover Identity request indicates that the port partner is
+ *		a receptacle capable of modal operation. Chip level TCPCI drivers
+ *		can implement their own policy to determine if and when a Vconn
+ *		swap following Discover Identity on SOP' occurs.
+ *		Return true when the TCPM is allowed to request a Vconn swap
+ *		after Discovery Identity on SOP.
  */
 struct tcpci_data {
 	struct regmap *regmap;
@@ -219,6 +227,7 @@ struct tcpci_data {
 	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
 					     bool capable);
 	void (*check_contaminant)(struct tcpci *tcpci, struct tcpci_data *data);
+	bool (*attempt_vconn_swap_discovery)(struct tcpci *tcpci, struct tcpci_data *data);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 41d1ac9c8bbf..6671427f7eeb 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -122,6 +122,14 @@ enum tcpm_transmit_type {
  * @cable_comm_capable
  *		Optional; Returns whether cable communication over SOP' is supported
  *		by the tcpc
+ * @attempt_vconn_swap_discovery:
+ *		Optional; The callback is called by the TCPM when the result of
+ *		a Discover Identity request indicates that the port partner is
+ *		a receptacle capable of modal operation. Chip level TCPCI drivers
+ *		can implement their own policy to determine if and when a Vconn
+ *		swap following Discover Identity on SOP' occurs.
+ *		Return true when the TCPM is allowed to request a Vconn swap
+ *		after Discovery Identity on SOP.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -158,6 +166,7 @@ struct tcpc_dev {
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
 	void (*check_contaminant)(struct tcpc_dev *dev);
 	bool (*cable_comm_capable)(struct tcpc_dev *dev);
+	bool (*attempt_vconn_swap_discovery)(struct tcpc_dev *dev);
 };
 
 struct tcpm_port;
-- 
2.43.0.472.g3155946c3a-goog



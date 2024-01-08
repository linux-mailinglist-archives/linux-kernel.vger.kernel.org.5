Return-Path: <linux-kernel+bounces-20020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136C82784F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F9F1C23F89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318855C31;
	Mon,  8 Jan 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXjA9WZK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9955780
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cde2b113e7so481448a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741395; x=1705346195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVjThMZLotAdWb9TIioEoi19kF6hz6fkppa/3qq7zYI=;
        b=gXjA9WZKQE618v3eomvwmqVc0HmFl12Pr3USpMwXCUw2qFTAw1aG/M1PwDohAgy6dz
         RJAJgrVINOeor6NvkoIJ+eLElk+xFxcVbVeFV6K4mWcDxf0MKlm7i/OPIF1g2/1swrC1
         k55CwwCkZYl3p9nzGAksScZueBMh2yDsOmnh2WLnNU8Mq2k42CzjGjDzvOylWzsnO+V7
         jgkb/OzwQcLo6yIQykTsFV26nGQH6GUCJ8Tu48gT8ZeapQqtUIOohg758t3TMtjzJFAx
         I5o3wtuUXc7KDf8uNAkB3q+TbKqRuF5XVZjPhkxyOTLx1P6RUypKtsCuoUJ6b68wImNY
         g7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741395; x=1705346195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVjThMZLotAdWb9TIioEoi19kF6hz6fkppa/3qq7zYI=;
        b=Kb/BI97OPXrdRR7/+PBpLMQBhUwnC2iFVQm5e/IW75e9J64GEUMifhZvQJpg7t5OPT
         Ll/+PP2dY9U5sffDJKMXBIVtlol1b9SkRaBxOkOgqeUk9SwrInFU1ytzBFTam6ADdINX
         fJNDF0CWmgNnyv0nNWkfq5I9+IAOjHwjCSYP8YMY9SheZJueq/UIKty+L0dAm3d//aL3
         I1huhAY6oHmizi4o4Hpf0vO9zFFPbBDYmC0RoaNExVknaX9EY/2mlMTXPKZ96YNpOtJy
         SOWaQaVGtQUtkXCCfGZ2khI/qtDi2jOvDVdazdBtBq4/P8p6rn/cRtxzgkt1aWdTeukE
         jfhg==
X-Gm-Message-State: AOJu0YwperNZKD5eSWNMGWVaU/cC5xhmix0MpAiI+ZPyq/XRE7tuH0Da
	hyTA10eYBn3oVhCpxSzKy8tQRcNZ09NYyizKVqfJGw==
X-Google-Smtp-Source: AGHT+IGOIUXWhXCLu+tJx6ka3Fimz8laJsoLIhYNxmZmaI92SoS5S6nir2+WtKY/6bjERFB4yDlbwoqYrIqu5uk=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a63:1c54:0:b0:5ca:43c7:a67 with SMTP id
 c20-20020a631c54000000b005ca43c70a67mr23049pgm.9.1704741395247; Mon, 08 Jan
 2024 11:16:35 -0800 (PST)
Date: Mon,  8 Jan 2024 19:16:16 +0000
In-Reply-To: <20240108191620.987785-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108191620.987785-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4338; i=rdbabiera@google.com;
 h=from:subject; bh=putn0Ho6wv9tIgjQ9wNDNZ2hIDbeB2w3mtNH9bjlwx0=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlzvFjfXD6++XiP0TlvxS1e0R8fJxR032DmMN/EyiVeJ
 NE7b25RRykLgxgHg6yYIouuf57BjSupW+Zw1hjDzGFlAhnCwMUpABNJaWP4X/Be13n6O/XbTmsP
 WjzKnD0ptO/hqs4N69V6G2vuPdaUucnIcG+e5DIhF8uQD/JnHk/aleHXf6eGLeO9jnp+rdmdx65 yfAA=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108191620.987785-17-rdbabiera@google.com>
Subject: [PATCH v3 03/12] usb: typec: tcpci: add cable_comm_capable attribute
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add cable_comm_capable to tcpci_data for tcpci drivers to indicate that
the port tcpc is capable of communicating to cables over SOP. A
corresponding tcpci callback tcpci_cable_comm_capable returns this value.
The tcpm will primarily use this in later patches to determine if the port
can transmit and receive SOP' messages.

Maxim based tcpci drivers are capable of SOP' communication, so the
cable_comm_capable flag is set to true.

Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v2:
* Added reviewed-by tag
Changes since v1:
* Moved tcpm_pd_receive changes to separate patch
---
 drivers/usb/typec/tcpm/tcpci.c            | 8 ++++++++
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 1 +
 include/linux/usb/tcpci.h                 | 3 +++
 include/linux/usb/tcpm.h                  | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 0ee3e6e29bb1..1ededbcecc09 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -584,6 +584,13 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type
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
@@ -793,6 +800,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
+	tcpci->tcpc.cable_comm_capable = tcpci_cable_comm_capable;
 
 	if (tcpci->data->check_contaminant)
 		tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 7fb966fd639b..7b2d4e6e52a2 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -478,6 +478,7 @@ static int max_tcpci_probe(struct i2c_client *client)
 	chip->data.vbus_vsafe0v = true;
 	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
 	chip->data.check_contaminant = max_tcpci_check_contaminant;
+	chip->data.cable_comm_capable = true;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 467e8045e9f8..1d0b849defd0 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -198,12 +198,15 @@ struct tcpci;
  *		Chip level drivers are expected to check for contaminant and call
  *		tcpm_clean_port when the port is clean to put the port back into
  *		toggling state.
+ * @cable_comm_capable
+ *		optional; Set when TCPC can communicate with cable plugs over SOP'
  */
 struct tcpci_data {
 	struct regmap *regmap;
 	unsigned char TX_BUF_BYTE_x_hidden:1;
 	unsigned char auto_discharge_disconnect:1;
 	unsigned char vbus_vsafe0v:1;
+	unsigned char cable_comm_capable:1;
 
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 65fac5e1f317..430fa3ec69bb 100644
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
-- 
2.43.0.472.g3155946c3a-goog



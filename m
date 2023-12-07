Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE533808477
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjLGJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjLGJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:08:12 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC7019A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:08:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cf74396cbeso6745955ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701940088; x=1702544888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jk5h25qYaL8QizzGrkg3KEn1TzRDQgKBfW7d8ssHKRE=;
        b=tubaNT7LCnz71chq8LPhkyGL9GB7tPsqqNxY1isoYLwgMtRNADOGeFImptPC1LmScG
         2Cvv9qNUA/y6bv5NHx8uVdtEy6UVapts7LA1RLDkKfxSMHSq2YqIchoarZKfkpCYlfwJ
         Al3BKzKvv5oWJicsOlhNi3T49obTRAJ3axMurjTRRCF+AkwOTrFikpFDmN8oVgYHyIq3
         IomzQo7j2703OUgkpJC6mcYUmI+OD0BrrAVyco4B6NOCNxtFflv17TtdxdPG6N0R5CFo
         YVXc+uMh/dXPyT3ijWFKfJx3wKoPTz+CUYa7iYAl0KFzlbXOdgL0ageSLF7i3+yfJtjt
         24rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940088; x=1702544888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jk5h25qYaL8QizzGrkg3KEn1TzRDQgKBfW7d8ssHKRE=;
        b=ZpfEoywR+3cysxIvugym85GwSWCO1QnSE/g6kBJ9hFm5Tfh0gvq5fPXEkwrJF23ELz
         KUKML1e1E018CsKYso1nWODgbZq9+7wQnh2I/yXWRoY0H88tKjzhUi7RXwUBD3s7z/SG
         PyT9jUWOqYDKrzy7YGkw/pwIBybHIfOaL+J/MUuHI8FzYlpg6xV00mGk8HX4Zv8D2pcy
         zuh6aYcAyIwSY5QLaTzGjzWWmZIsRcwKrh7VILFKIU6WghOv/UR0jrz3IEEKdRmznM0g
         dzdsX3+Akz3OYCsGZYoPtR1GGj6V4rIW1T6RuMzXftottSCOhOQTprUbpWPWp5rC1Uvm
         oEEg==
X-Gm-Message-State: AOJu0YzuCVdNDMNLJIP6oLUOMqBUms0ugd52aKhwS3IiRWnP29mV4k2A
        WMro70COzk4yZhIr2vShHAJyqh+jhJTOZMk=
X-Google-Smtp-Source: AGHT+IG6MJfySP8fvSPNMsnjc+Dgw98hG6V4ZDf+JT1QXG5rC/xtPEPTACUCy5FlFkfxo5nndINAwF93D7r/xqY=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a17:903:3304:b0:1d0:c3e7:d4c with SMTP
 id jk4-20020a170903330400b001d0c3e70d4cmr25844plb.2.1701940087928; Thu, 07
 Dec 2023 01:08:07 -0800 (PST)
Date:   Thu,  7 Dec 2023 09:07:37 +0000
In-Reply-To: <20231207090738.15721-12-rdbabiera@google.com>
Mime-Version: 1.0
References: <20231207090738.15721-12-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=29196; i=rdbabiera@google.com;
 h=from:subject; bh=lAs4yLlDbnmwtFMl5ELcGb2z4gYasy8I9TYZjnwlCck=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmF3bFuRxTmhP6V+CCprsn7d5ZLdX7aA8kzGy98OcZp9
 vCgOdP+jlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACZSuI6R4U09q8Md1n0u+ybO
 X7wyPUk2dEXJmvA8R44PV8UVWp5NYmNkuBPFOtfp3H0VjW1z9vUuXPNT2rTex8j39/KDP+w6Fv3 fywUA
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207090738.15721-18-rdbabiera@google.com>
Subject: [PATCH v1 06/10] usb: typec: tcpm: add discover identity support for SOP'
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

Add data message handling and Discover Identity SVDM over SOP'

This patch contains the following changes:
    1. class
Add typec_cable_set_svdm_version and typec_get_cable_svdm version symbols.
Cables can operate under a lower PD revision than the port partner, and the
max SVDM version is tied to the PD revision.
    2. pd_vdo
Add VDO indices for active and passive cables, add documentation to reflect
expected number of objects.
    3. tcpm
Add typec_cable and typec_plug to tcpm_port to maintain cable and plug
information. tcpm_port also adds send_discover_prime to indicate that
Discover Identity should be sent out of the ready state.

tcpm_queue_vdm and tcpm_send_vdm now take the SOP* type when transmitting
messages. tcpm_handle_vdm_request and tcpm_pd_svdm also use the SOP* type.
tcpm_pd_svdm handles Discover Identity messages for SOP and SOP'. In the
SOP case, the port uses tcpm_attempt_vconn_swap_discovery to determine if
a Vconn swap is needed for cable communication. Otherwise, the port will
send Discover Identity on SOP' if it can, or default to Discover SVIDs.

svdm_consume_identity_sop_prime consumes the result of Discover Identity
on SOP'. It fills out cable identity and description, and it registers
the cable. The SOP' plug is registered as well.

The VDM state machine is adjusted to construct messages based on the SOP*
type. If a transmission error occurs after the max number of retries for
Discover Identity over SOP', then the port will send Discover SVIDs over
SOP.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/class.c     |  40 ++++
 drivers/usb/typec/class.h     |   1 +
 drivers/usb/typec/tcpm/tcpm.c | 388 ++++++++++++++++++++++++++++++----
 include/linux/usb/pd_vdo.h    |   8 +-
 include/linux/usb/typec.h     |   3 +
 5 files changed, 392 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 7514766df195..83b10971ec5d 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1205,6 +1205,46 @@ int typec_cable_set_identity(struct typec_cable *cable)
 }
 EXPORT_SYMBOL_GPL(typec_cable_set_identity);
 
+/**
+ * typec_get_cable_svdm_version - Get negotiated SVDM Version
+ * @port: USB Type-C Port.
+ *
+ * Get the negotiated SVDM Version. The Version is set to the port default
+ * value based on the PD Revision during cable registration, and updated after
+ * a successful Discover Identity if the negotiated value is less than the
+ * default value.
+ *
+ * Returns usb_pd_svdm_ver if the cable has been registered otherwise -ENODEV.
+ */
+int typec_get_cable_svdm_version(struct typec_port *port)
+{
+	enum usb_pd_svdm_ver svdm_version;
+	struct device *cable_dev;
+
+	cable_dev = device_find_child(&port->dev, NULL, cable_match);
+	if (!cable_dev)
+		return -ENODEV;
+
+	svdm_version = to_typec_cable(cable_dev)->svdm_version;
+	put_device(cable_dev);
+
+	return svdm_version;
+}
+EXPORT_SYMBOL_GPL(typec_get_cable_svdm_version);
+
+/**
+ * typec_cable_set_svdm_version - Set negotiated Structured VDM (SVDM) Version
+ * @cable: USB Type-C Active Cable that supports SVDM
+ * @svdm_version: Negotiated SVDM Version
+ *
+ * This routine is used to save the negotiated SVDM Version.
+ */
+void typec_cable_set_svdm_version(struct typec_cable *cable,
+				   enum usb_pd_svdm_ver svdm_version)
+{
+	cable->svdm_version = svdm_version;
+}
+
 /**
  * typec_register_cable - Register a USB Type-C Cable
  * @port: The USB Type-C Port the cable is connected to
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index c36761ba3f59..759b98355eeb 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -23,6 +23,7 @@ struct typec_cable {
 	struct usb_pd_identity		*identity;
 	unsigned int			active:1;
 	u16				pd_revision; /* 0300H = "3.0" */
+	enum usb_pd_svdm_ver		svdm_version;
 };
 
 struct typec_partner {
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d1c6157a2ea3..2b650b419421 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -319,6 +319,12 @@ struct tcpm_port {
 	struct typec_partner_desc partner_desc;
 	struct typec_partner *partner;
 
+	struct usb_pd_identity cable_ident;
+	struct typec_cable_desc cable_desc;
+	struct typec_cable *cable;
+	struct typec_plug_desc plug_prime_desc;
+	struct typec_plug *plug_prime;
+
 	enum typec_cc_status cc_req;
 	enum typec_cc_status src_rp;	/* work only if pd_supported == false */
 
@@ -496,6 +502,12 @@ struct tcpm_port {
 	bool potential_contaminant;
 
 	/* SOP* Related Fields */
+	/*
+	 * Flag to determine if SOP' Discover Identity is available. The flag
+	 * is set if Discover Identity on SOP' does not immediately follow
+	 * Discover Identity on SOP.
+	 */
+	bool send_discover_prime;
 	/*
 	 * tx_sop_type determines which SOP* a message is being sent on.
 	 * For messages that are queued and not sent immediately such as in
@@ -1501,7 +1513,7 @@ static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams)
  * VDM/VDO handling functions
  */
 static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
-			   const u32 *data, int cnt)
+			   const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
 {
 	u32 vdo_hdr = port->vdo_data[0];
 
@@ -1509,7 +1521,10 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 
 	/* If is sending discover_identity, handle received message first */
 	if (PD_VDO_SVDM(vdo_hdr) && PD_VDO_CMD(vdo_hdr) == CMD_DISCOVER_IDENT) {
-		port->send_discover = true;
+		if (tx_sop_type == TCPC_TX_SOP_PRIME)
+			port->send_discover_prime = true;
+		else
+			port->send_discover = true;
 		mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_MS);
 	} else {
 		/* Make sure we are not still processing a previous VDM packet */
@@ -1524,6 +1539,8 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 	port->vdm_state = VDM_STATE_READY;
 	port->vdm_sm_running = true;
 
+	port->tx_sop_type = tx_sop_type;
+
 	mod_vdm_delayed_work(port, 0);
 }
 
@@ -1531,7 +1548,7 @@ static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
 				    const u32 *data, int cnt)
 {
 	mutex_lock(&port->lock);
-	tcpm_queue_vdm(port, header, data, cnt);
+	tcpm_queue_vdm(port, header, data, cnt, TCPC_TX_SOP);
 	mutex_unlock(&port->lock);
 }
 
@@ -1553,6 +1570,63 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 		 PD_PRODUCT_PID(product), product & 0xffff);
 }
 
+static void svdm_consume_identity_sop_prime(struct tcpm_port *port, const u32 *p, int cnt)
+{
+	u32 idh = p[VDO_INDEX_IDH];
+	u32 product = p[VDO_INDEX_PRODUCT];
+	int svdm_version;
+
+	/*
+	 * Attempt to consume identity only if cable currently is not set
+	 */
+	if (!IS_ERR_OR_NULL(port->cable))
+		goto register_plug;
+
+	/* Reset cable identity */
+	memset(&port->cable_ident, 0, sizeof(port->cable_ident));
+
+	/* Fill out id header, cert, product, cable VDO 1 */
+	port->cable_ident.id_header = idh;
+	port->cable_ident.cert_stat = p[VDO_INDEX_CSTAT];
+	port->cable_ident.product = product;
+	port->cable_ident.vdo[0] = p[VDO_INDEX_CABLE_1];
+
+	/* Fill out cable desc, infer svdm_version from pd revision */
+	port->cable_desc.type = (enum typec_plug_type) (VDO_TYPEC_CABLE_TYPE(p[VDO_INDEX_CABLE_1]) +
+							USB_PLUG_TYPE_A);
+	port->cable_desc.active = PD_IDH_PTYPE(idh) == IDH_PTYPE_ACABLE ? 1 : 0;
+	/* Log PD Revision and additional cable VDO from negotiated revision */
+	switch (port->negotiated_rev_prime) {
+	case PD_REV30:
+		port->cable_desc.pd_revision = 0x0300;
+		if (port->cable_desc.active)
+			port->cable_ident.vdo[1] = p[VDO_INDEX_CABLE_2];
+		break;
+	case PD_REV20:
+		port->cable_desc.pd_revision = 0x0200;
+		break;
+	default:
+		port->cable_desc.pd_revision = 0x0200;
+		break;
+	}
+	port->cable_desc.identity = &port->cable_ident;
+	/* Register Cable, set identity and svdm_version */
+	port->cable = typec_register_cable(port->typec_port, &port->cable_desc);
+	if (IS_ERR_OR_NULL(port->cable))
+		return;
+	typec_cable_set_identity(port->cable);
+	/* Get SVDM version */
+	svdm_version = PD_VDO_SVDM_VER(p[VDO_INDEX_HDR]);
+	typec_cable_set_svdm_version(port->cable, svdm_version);
+
+register_plug:
+	if (IS_ERR_OR_NULL(port->plug_prime)) {
+		port->plug_prime_desc.index = TYPEC_PLUG_SOP_P;
+		port->plug_prime = typec_register_plug(port->cable,
+						       &port->plug_prime_desc);
+	}
+}
+
 static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	struct pd_mode_data *pmdata = &port->mode_data;
@@ -1647,6 +1721,7 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 }
 
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
+#define supports_host(port)	PD_IDH_HOST_SUPP((port->partner_ident.id_header))
 
 /*
  * Helper to determine whether the port is capable of SOP' communication at the
@@ -1699,9 +1774,35 @@ static bool tcpm_can_communicate_sop_prime(struct tcpm_port *port)
 	return false;
 }
 
+static bool tcpm_attempt_vconn_swap_discovery(struct tcpm_port *port)
+{
+	if (!port->tcpc->attempt_vconn_swap_discovery)
+		return false;
+
+	/* Port is already source, no need to perform swap */
+	if (port->vconn_role == TYPEC_SOURCE)
+		return false;
+
+	/*
+	 * Partner needs to support Alternate Modes with modal support. If
+	 * partner is also capable of being a USB Host, it could be a device
+	 * that supports Alternate Modes as the DFP.
+	 */
+	if (!supports_modal(port) || supports_host(port))
+		return false;
+
+	if ((port->negotiated_rev == PD_REV20 && port->data_role == TYPEC_HOST) ||
+	    port->negotiated_rev == PD_REV30)
+		return port->tcpc->attempt_vconn_swap_discovery(port->tcpc);
+
+	return false;
+}
+
 static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			const u32 *p, int cnt, u32 *response,
-			enum adev_actions *adev_action)
+			enum adev_actions *adev_action,
+			enum tcpm_transmit_type rx_sop_type,
+			enum tcpm_transmit_type *response_tx_sop_type)
 {
 	struct typec_port *typec = port->typec_port;
 	struct typec_altmode *pdev;
@@ -1711,6 +1812,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 	int cmd_type;
 	int cmd;
 	int i;
+	int ret;
 
 	cmd_type = PD_VDO_CMDT(p[0]);
 	cmd = PD_VDO_CMD(p[0]);
@@ -1723,9 +1825,28 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
 				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
 
-	svdm_version = typec_get_negotiated_svdm_version(typec);
-	if (svdm_version < 0)
-		return 0;
+	switch (rx_sop_type) {
+	case TCPC_TX_SOP_PRIME:
+		svdm_version = typec_get_cable_svdm_version(typec);
+		/*
+		 * Update SVDM version if cable was discovered before port partner.
+		 */
+		if (!IS_ERR_OR_NULL(port->cable) &&
+		    PD_VDO_SVDM_VER(p[0]) < svdm_version) {
+			typec_cable_set_svdm_version(port->cable, svdm_version);
+		}
+		break;
+	case TCPC_TX_SOP:
+		svdm_version = typec_get_negotiated_svdm_version(typec);
+		if (svdm_version < 0)
+			return 0;
+		break;
+	default:
+		svdm_version = typec_get_negotiated_svdm_version(typec);
+		if (svdm_version < 0)
+			return 0;
+		break;
+	}
 
 	switch (cmd_type) {
 	case CMDT_INIT:
@@ -1795,22 +1916,88 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			      (VDO_SVDM_VERS(typec_get_negotiated_svdm_version(typec)));
 		break;
 	case CMDT_RSP_ACK:
-		/* silently drop message if we are not connected */
-		if (IS_ERR_OR_NULL(port->partner))
+		/*
+		 * Silently drop message if we are not connected, but can process
+		 * if SOP' Discover Identity prior to explicit contract.
+		 */
+		if (IS_ERR_OR_NULL(port->partner) &&
+		    !(rx_sop_type == TCPC_TX_SOP_PRIME && cmd == CMD_DISCOVER_IDENT))
 			break;
 
 		tcpm_ams_finish(port);
 
 		switch (cmd) {
+		/*
+		 * SVDM Command Flow for SOP and SOP':
+		 * SOP		Discover Identity
+		 * SOP'		Discover Identity
+		 * SOP		Discover SVIDs
+		 *		Discover Modes
+		 *
+		 * Perform Discover SOP' if the port can communicate with cable
+		 * plug.
+		 */
 		case CMD_DISCOVER_IDENT:
-			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
-				typec_partner_set_svdm_version(port->partner,
-							       PD_VDO_SVDM_VER(p[0]));
-			/* 6.4.4.3.1 */
-			svdm_consume_identity(port, p, cnt);
-			response[0] = VDO(USB_SID_PD, 1, typec_get_negotiated_svdm_version(typec),
-					  CMD_DISCOVER_SVID);
-			rlen = 1;
+			switch (rx_sop_type) {
+			case TCPC_TX_SOP:
+				if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
+					typec_partner_set_svdm_version(port->partner,
+								       PD_VDO_SVDM_VER(p[0]));
+					if (!IS_ERR_OR_NULL(port->cable) &&
+					    (typec_get_cable_svdm_version(port->typec_port) >
+					    svdm_version))
+						typec_cable_set_svdm_version(port->cable,
+									     svdm_version);
+				}
+				/* 6.4.4.3.1 */
+				svdm_consume_identity(port, p, cnt);
+				/* Attempt Vconn swap, delay SOP' discovery if necessary */
+				if (tcpm_attempt_vconn_swap_discovery(port)) {
+					port->send_discover_prime = true;
+					port->upcoming_state = VCONN_SWAP_SEND;
+					ret = tcpm_ams_start(port, VCONN_SWAP);
+					if (!ret)
+						return 0;
+					port->upcoming_state = INVALID_STATE;
+					port->send_discover_prime = false;
+				}
+
+				/*
+				 * Attempt Discover Identity on SOP' if the
+				 * cable was not discovered previously, and use
+				 * the SVDM version of the partner to probe.
+				 */
+				if (IS_ERR_OR_NULL(port->cable) &&
+				    tcpm_can_communicate_sop_prime(port)) {
+					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+					port->send_discover_prime = true;
+					response[0] = VDO(USB_SID_PD, 1,
+							  typec_get_negotiated_svdm_version(typec),
+							  CMD_DISCOVER_IDENT);
+					rlen = 1;
+				} else {
+					*response_tx_sop_type = TCPC_TX_SOP;
+					response[0] = VDO(USB_SID_PD, 1,
+							  typec_get_negotiated_svdm_version(typec),
+							  CMD_DISCOVER_SVID);
+					rlen = 1;
+				}
+				break;
+			case TCPC_TX_SOP_PRIME:
+				/*
+				 * svdm_consume_identity_sop_prime will determine
+				 * the svdm_version for the cable moving forward.
+				 */
+				svdm_consume_identity_sop_prime(port, p, cnt);
+				*response_tx_sop_type = TCPC_TX_SOP;
+				response[0] = VDO(USB_SID_PD, 1,
+						  typec_get_negotiated_svdm_version(typec),
+						  CMD_DISCOVER_SVID);
+				rlen = 1;
+				break;
+			default:
+				return 0;
+			}
 			break;
 		case CMD_DISCOVER_SVID:
 			/* 6.4.4.3.2 */
@@ -1896,13 +2083,15 @@ static void tcpm_pd_handle_msg(struct tcpm_port *port,
 			       enum tcpm_ams ams);
 
 static void tcpm_handle_vdm_request(struct tcpm_port *port,
-				    const __le32 *payload, int cnt)
+				    const __le32 *payload, int cnt,
+				    enum tcpm_transmit_type rx_sop_type)
 {
 	enum adev_actions adev_action = ADEV_NONE;
 	struct typec_altmode *adev;
 	u32 p[PD_MAX_PAYLOAD];
 	u32 response[8] = { };
 	int i, rlen = 0;
+	enum tcpm_transmit_type response_tx_sop_type = TCPC_TX_SOP;
 
 	for (i = 0; i < cnt; i++)
 		p[i] = le32_to_cpu(payload[i]);
@@ -1937,7 +2126,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 		 *  - We will send NAK and the flag will be cleared in the state machine.
 		 */
 		port->vdm_sm_running = true;
-		rlen = tcpm_pd_svdm(port, adev, p, cnt, response, &adev_action);
+		rlen = tcpm_pd_svdm(port, adev, p, cnt, response, &adev_action,
+				    rx_sop_type, &response_tx_sop_type);
 	} else {
 		if (port->negotiated_rev >= PD_REV30)
 			tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
@@ -2005,19 +2195,38 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	mutex_lock(&port->lock);
 
 	if (rlen > 0)
-		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
+		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1, response_tx_sop_type);
 	else
 		port->vdm_sm_running = false;
 }
 
 static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
-			  const u32 *data, int count)
+			  const u32 *data, int count, enum tcpm_transmit_type tx_sop_type)
 {
-	int svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
+	int svdm_version;
 	u32 header;
 
-	if (svdm_version < 0)
-		return;
+	switch (tx_sop_type) {
+	case TCPC_TX_SOP_PRIME:
+		/*
+		 * If the port partner is discovered, then the port partner's
+		 * SVDM Version will be returned
+		 */
+		svdm_version = typec_get_cable_svdm_version(port->typec_port);
+		if (svdm_version < 0)
+			svdm_version = SVDM_VER_MAX;
+		break;
+	case TCPC_TX_SOP:
+		svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
+		if (svdm_version < 0)
+			return;
+		break;
+	default:
+		svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
+		if (svdm_version < 0)
+			return;
+		break;
+	}
 
 	if (WARN_ON(count > VDO_MAX_SIZE - 1))
 		count = VDO_MAX_SIZE - 1;
@@ -2026,7 +2235,7 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
 	header = VDO(vid, ((vid & USB_SID_PD) == USB_SID_PD) ?
 			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION),
 			svdm_version, cmd);
-	tcpm_queue_vdm(port, header, data, count);
+	tcpm_queue_vdm(port, header, data, count, tx_sop_type);
 }
 
 static unsigned int vdm_ready_timeout(u32 vdm_hdr)
@@ -2060,6 +2269,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 	struct pd_message msg;
 	int i, res = 0;
 	u32 vdo_hdr = port->vdo_data[0];
+	u32 response[8] = { };
 
 	switch (port->vdm_state) {
 	case VDM_STATE_READY:
@@ -2084,7 +2294,17 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 			case CMD_DISCOVER_IDENT:
 				res = tcpm_ams_start(port, DISCOVER_IDENTITY);
 				if (res == 0) {
-					port->send_discover = false;
+					switch (port->tx_sop_type) {
+					case TCPC_TX_SOP_PRIME:
+						port->send_discover_prime = false;
+						break;
+					case TCPC_TX_SOP:
+						port->send_discover = false;
+						break;
+					default:
+						port->send_discover = false;
+						break;
+					}
 				} else if (res == -EAGAIN) {
 					port->vdo_data[0] = 0;
 					mod_send_discover_delayed_work(port,
@@ -2153,19 +2373,50 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 				tcpm_ams_finish(port);
 		} else {
 			tcpm_ams_finish(port);
+			if (port->tx_sop_type == TCPC_TX_SOP)
+				break;
+			/* Handle SOP' Transmission Errors */
+			switch (PD_VDO_CMD(vdo_hdr)) {
+			/*
+			 * If Discover Identity fails on SOP', then resume
+			 * discovery process on SOP only.
+			 */
+			case CMD_DISCOVER_IDENT:
+				port->vdo_data[0] = 0;
+				response[0] = VDO(USB_SID_PD, 1,
+						  typec_get_negotiated_svdm_version(
+									port->typec_port),
+						  CMD_DISCOVER_SVID);
+				tcpm_queue_vdm(port, response[0], &response[1],
+					       0, TCPC_TX_SOP);
+				break;
+			default:
+				break;
+			}
 		}
 		break;
 	case VDM_STATE_SEND_MESSAGE:
 		/* Prepare and send VDM */
 		memset(&msg, 0, sizeof(msg));
-		msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
-					  port->pwr_role,
-					  port->data_role,
-					  port->negotiated_rev,
-					  port->message_id, port->vdo_count);
+		if (port->tx_sop_type == TCPC_TX_SOP_PRIME) {
+			msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
+						  0, /* Power Role for SOP' is 0 */
+						  0, /* Data Role for SOP' is 0 */
+						  port->negotiated_rev_prime,
+						  port->message_id_prime,
+						  port->vdo_count);
+		} else {
+			msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
+						  port->pwr_role,
+						  port->data_role,
+						  port->negotiated_rev,
+						  port->message_id,
+						  port->vdo_count);
+		}
+
 		for (i = 0; i < port->vdo_count; i++)
 			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
-		res = tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+		res = tcpm_pd_transmit(port, port->tx_sop_type, &msg);
 		if (res < 0) {
 			port->vdm_state = VDM_STATE_ERR_SEND;
 		} else {
@@ -2555,7 +2806,8 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 }
 
 static void tcpm_pd_data_request(struct tcpm_port *port,
-				 const struct pd_message *msg)
+				 const struct pd_message *msg,
+				 enum tcpm_transmit_type rx_sop_type)
 {
 	enum pd_data_msg_type type = pd_header_type_le(msg->header);
 	unsigned int cnt = pd_header_cnt_le(msg->header);
@@ -2596,8 +2848,11 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 			break;
 		}
 
-		if (rev < PD_MAX_REV)
+		if (rev < PD_MAX_REV) {
 			port->negotiated_rev = rev;
+			if (port->negotiated_rev_prime > port->negotiated_rev)
+				port->negotiated_rev_prime = port->negotiated_rev;
+		}
 
 		if (port->pwr_role == TYPEC_SOURCE) {
 			if (port->ams == GET_SOURCE_CAPABILITIES)
@@ -2648,8 +2903,11 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 			break;
 		}
 
-		if (rev < PD_MAX_REV)
+		if (rev < PD_MAX_REV) {
 			port->negotiated_rev = rev;
+			if (port->negotiated_rev_prime > port->negotiated_rev)
+				port->negotiated_rev_prime = port->negotiated_rev;
+		}
 
 		if (port->pwr_role != TYPEC_SOURCE || cnt != 1) {
 			tcpm_pd_handle_msg(port,
@@ -2705,7 +2963,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 					   NONE_AMS);
 		break;
 	case PD_DATA_VENDOR_DEF:
-		tcpm_handle_vdm_request(port, msg->payload, cnt);
+		tcpm_handle_vdm_request(port, msg->payload, cnt, rx_sop_type);
 		break;
 	case PD_DATA_BIST:
 		port->bist_request = le32_to_cpu(msg->payload[0]);
@@ -3154,7 +3412,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 			if (le16_to_cpu(msg->header) & PD_HEADER_EXT_HDR)
 				tcpm_pd_ext_msg_request(port, msg);
 			else if (cnt)
-				tcpm_pd_data_request(port, msg);
+				tcpm_pd_data_request(port, msg, rx_sop_type);
 			else
 				tcpm_pd_ctrl_request(port, msg, rx_sop_type);
 		}
@@ -3811,6 +4069,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	port->attached = true;
 	port->send_discover = true;
+	port->send_discover_prime = false;
 
 	return 0;
 
@@ -3827,6 +4086,15 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 static void tcpm_typec_disconnect(struct tcpm_port *port)
 {
+	/*
+	 * Unregister plug/cable outside of port->connected because cable can
+	 * be discovered before SRC_READY/SNK_READY states where port->connected
+	 * is set.
+	 */
+	typec_unregister_plug(port->plug_prime);
+	typec_unregister_cable(port->cable);
+	port->plug_prime = NULL;
+	port->cable = NULL;
 	if (port->connected) {
 		typec_partner_set_usb_power_delivery(port->partner, NULL);
 		typec_unregister_partner(port->partner);
@@ -3949,6 +4217,7 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 
 	port->attached = true;
 	port->send_discover = true;
+	port->send_discover_prime = false;
 
 	return 0;
 }
@@ -4310,14 +4579,23 @@ static void run_state_machine(struct tcpm_port *port)
 		 * 6.4.4.3.1 Discover Identity
 		 * "The Discover Identity Command Shall only be sent to SOP when there is an
 		 * Explicit Contract."
-		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
-		 * port->explicit_contract to decide whether to send the command.
+		 *
+		 * Discover Identity on SOP' should be discovered prior to the
+		 * ready state, but if done after a Vconn Swap following Discover
+		 * Identity on SOP then the discovery process can be run here
+		 * as well.
 		 */
 		if (port->explicit_contract) {
-			tcpm_set_initial_svdm_version(port);
+			if (port->send_discover_prime) {
+				port->tx_sop_type = TCPC_TX_SOP_PRIME;
+			} else {
+				port->tx_sop_type = TCPC_TX_SOP;
+				tcpm_set_initial_svdm_version(port);
+			}
 			mod_send_discover_delayed_work(port, 0);
 		} else {
 			port->send_discover = false;
+			port->send_discover_prime = false;
 		}
 
 		/*
@@ -4608,14 +4886,23 @@ static void run_state_machine(struct tcpm_port *port)
 		 * 6.4.4.3.1 Discover Identity
 		 * "The Discover Identity Command Shall only be sent to SOP when there is an
 		 * Explicit Contract."
-		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
-		 * port->explicit_contract.
+		 *
+		 * Discover Identity on SOP' should be discovered prior to the
+		 * ready state, but if done after a Vconn Swap following Discover
+		 * Identity on SOP then the discovery process can be run here
+		 * as well.
 		 */
 		if (port->explicit_contract) {
-			tcpm_set_initial_svdm_version(port);
+			if (port->send_discover_prime) {
+				port->tx_sop_type = TCPC_TX_SOP_PRIME;
+			} else {
+				port->tx_sop_type = TCPC_TX_SOP;
+				tcpm_set_initial_svdm_version(port);
+			}
 			mod_send_discover_delayed_work(port, 0);
 		} else {
 			port->send_discover = false;
+			port->send_discover_prime = false;
 		}
 
 		power_supply_changed(port->psy);
@@ -4656,6 +4943,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_unregister_altmodes(port);
 		port->nr_sink_caps = 0;
 		port->send_discover = true;
+		port->send_discover_prime = false;
 		if (port->pwr_role == TYPEC_SOURCE)
 			tcpm_set_state(port, SRC_HARD_RESET_VBUS_OFF,
 				       PD_T_PS_HARD_RESET);
@@ -4802,15 +5090,20 @@ static void run_state_machine(struct tcpm_port *port)
 	/* DR_Swap states */
 	case DR_SWAP_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_DR_SWAP, TCPC_TX_SOP);
-		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
+		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20) {
 			port->send_discover = true;
+			port->send_discover_prime = false;
+		}
 		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
 				    PD_T_SENDER_RESPONSE);
 		break;
 	case DR_SWAP_ACCEPT:
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
-		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
+		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20) {
 			port->send_discover = true;
+			port->send_discover_prime = false;
+		}
+
 		tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
 		break;
 	case DR_SWAP_SEND_TIMEOUT:
@@ -5820,11 +6113,12 @@ static void tcpm_send_discover_work(struct kthread_work *work)
 
 	mutex_lock(&port->lock);
 	/* No need to send DISCOVER_IDENTITY anymore */
-	if (!port->send_discover)
+	if (!port->send_discover && !port->send_discover_prime)
 		goto unlock;
 
 	if (port->data_role == TYPEC_DEVICE && port->negotiated_rev < PD_REV30) {
 		port->send_discover = false;
+		port->send_discover_prime = false;
 		goto unlock;
 	}
 
@@ -5834,7 +6128,7 @@ static void tcpm_send_discover_work(struct kthread_work *work)
 		goto unlock;
 	}
 
-	tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
+	tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0, port->tx_sop_type);
 
 unlock:
 	mutex_unlock(&port->lock);
diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index 3a747938cdab..136ba02aeeae 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -86,12 +86,15 @@
  *
  * Request is simply properly formatted SVDM header
  *
- * Response is 4 data objects:
+ * Response is 4 data objects for Power Delivery 2.0 and Passive Cables for
+ * Power Delivery 3.0. Active Cables in Power Delivery 3.0 have 5 data objects.
  * [0] :: SVDM header
  * [1] :: Identitiy header
  * [2] :: Cert Stat VDO
  * [3] :: (Product | Cable) VDO
+ * [4] :: Cable VDO 1
  * [4] :: AMA VDO
+ * [5] :: Cable VDO 2
  *
  */
 #define VDO_INDEX_HDR		0
@@ -100,6 +103,8 @@
 #define VDO_INDEX_CABLE		3
 #define VDO_INDEX_PRODUCT	3
 #define VDO_INDEX_AMA		4
+#define VDO_INDEX_CABLE_1	4
+#define VDO_INDEX_CABLE_2	5
 
 /*
  * SVDM Identity Header
@@ -150,6 +155,7 @@
 #define PD_IDH_MODAL_SUPP(vdo)	((vdo) & (1 << 26))
 #define PD_IDH_DFP_PTYPE(vdo)	(((vdo) >> 23) & 0x7)
 #define PD_IDH_CONN_TYPE(vdo)	(((vdo) >> 21) & 0x3)
+#define PD_IDH_HOST_SUPP(vdo)	((vdo) & (1 << 31))
 
 /*
  * Cert Stat VDO
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index a05d6f6f2536..d652060ba8fe 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -303,6 +303,9 @@ void typec_unregister_cable(struct typec_cable *cable);
 struct typec_cable *typec_cable_get(struct typec_port *port);
 void typec_cable_put(struct typec_cable *cable);
 int typec_cable_is_active(struct typec_cable *cable);
+int typec_get_cable_svdm_version(struct typec_port *port);
+void typec_cable_set_svdm_version(struct typec_cable *cable,
+				  enum usb_pd_svdm_ver svdm_version);
 
 struct typec_plug *typec_register_plug(struct typec_cable *cable,
 				       struct typec_plug_desc *desc);
-- 
2.43.0.rc2.451.g8631bc7472-goog


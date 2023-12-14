Return-Path: <linux-kernel+bounces-233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4F813E18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A9828338C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62542DB6B;
	Thu, 14 Dec 2023 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/3YRVSq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E283B0B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcd4696599so70683276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595356; x=1703200156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7teWozterxY4vh0SudKagAo1PVMtiaaFH393Nj2UKk=;
        b=D/3YRVSq4Nb59oh3ensO6p1I1rZOTMudrmd7wKYTFiuNqryBDUqrS4OrdgRw+QdUxV
         h9XPgc3uwqBBz6FvVa8UmpDCdpeazAxtZ197WZrMOiNNppN6scyFt1tw6DPCWbXatFE6
         lKaylSPUhKIqDPt5aGxC76RIYRRzjwsfqCt+Bw0O5BTnf6yFiuEhPqoVSs2cCdBzYhTA
         grw2CD1S3IGKWiVBfsmbqXc5M6/BxjbiyrsKU8VG5CbOE29+fLMetl5khV4zluHlbohK
         zlZlZI+eGlEYdPhWCypB5H3MEKyGxWExunpt50axVNURx2+U/ey49of7tpAOFoIn0lBi
         evXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595356; x=1703200156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7teWozterxY4vh0SudKagAo1PVMtiaaFH393Nj2UKk=;
        b=KVfP01c3ggNLU6zCI2hJWLqmCVlPLjEY2u87UTkJLzpCOTi3aXSEmTEJ6R6ezCJjaS
         9zgCABNjYs0OIGbdZHNHFQkQbrGM9pkQN7EpL5fF177oCZbd1IFFEg/k7XECqQFfFExo
         neBZUn97Uj5tjhL2AtmmecBNizpTbxYOaz0CCPBlSilfQXD8dSDIZSBJWprHSBU4h1x7
         xs2wLfCSehJOVHvr6g2TjQpI/7r8XM93S//mT9zPjqgQ+8YKJzrIpnedseoXyVm2KA3i
         6m1/iNOV8dJfaoFe9i2iVoK4ETJCsPwuW/wvRHAuxuGFj1z+t/49uEK2dtjD8OV4dtU5
         5Gcw==
X-Gm-Message-State: AOJu0YwgyFCBnKRJj3Xc1osLw+x0VtaLop0z7avvuyxUfybNMTrMk+Xz
	mVYcOizDZt5exXRKRArSkG8EffS9zvjcWeU=
X-Google-Smtp-Source: AGHT+IG2laeLC9jSjWg/gAkkXv/sy8mmZ99HAVVtokulYisVLWWFUMuPnabVGsZR7sQCw/ZS4CrABaV9ZCJXl/E=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6902:1364:b0:dbc:ef63:f134 with SMTP
 id bt4-20020a056902136400b00dbcef63f134mr12906ybb.2.1702595356268; Thu, 14
 Dec 2023 15:09:16 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:54 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10640; i=rdbabiera@google.com;
 h=from:subject; bh=o/NMaTlgyYfl6ifVKYzIQcgvHmY9x4Z2V9XQ8lHDpLk=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3WyLTBfLXxe99OoRl+6RlUHBxqGf2rVC1NcUzDiiW
 DlB0V+uo5SFQYyDQVZMkUXXP8/gxpXULXM4a4xh5rAygQxh4OIUgIlM9WP4Z1Qz+Qhn+64Di1cI
 Wl7pEU+dMOvUCUPLZffd/0svXvc2aSLDX+F1pw4xmdp3TTpo9Mg+YU7gwtsPFByur3xQ7u++7O7 8edwA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-24-rdbabiera@google.com>
Subject: [PATCH v2 10/12] usb: typec: tcpm: add discover svids and discover
 modes support for sop'
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Adds Discover SVIDs and Discover Modes support for SOP' and Alt Mode
SVDM support over SOP'. tcpm_port adds separate Alt Mode data for SOP'.

svdm_consume_svids and svdm_consume_modes take the received SVDM's SOP*
type to store svids/modes separately, and tcpm_register_plug_altmodes
registers the active cable's alt modes.

In tcpm_pd_svdm, the port will send Discover SVIDs to SOP' after Discover
Modes on SOP if the connected cable is an active cable. Discover Modes on
SOP' is sent following Discover SVIDs on SOP. Registering partner alt modes
is delayed when an active cable is present until Discover Modes completes
on SOP', or if the Discover SVIDs/Discover Modes request on SOP' encounters
a transmission error.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes since v1:
* Changes to tcpm_altmode_enter/exit/vdm are moved to next patch
* adev_action changes are moved to next patch
---
 drivers/usb/typec/tcpm/tcpm.c | 163 +++++++++++++++++++++++++++++-----
 1 file changed, 139 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index e21bc2eea3fc..61433dc4c917 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -465,7 +465,9 @@ struct tcpm_port {
 
 	/* Alternate mode data */
 	struct pd_mode_data mode_data;
+	struct pd_mode_data mode_data_prime;
 	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
+	struct typec_altmode *plug_prime_altmode[ALTMODE_DISCOVERY_MAX];
 	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
 
 	/* Deadline in jiffies to exit src_try_wait state */
@@ -1629,9 +1631,11 @@ static void svdm_consume_identity_sop_prime(struct tcpm_port *port, const u32 *p
 	}
 }
 
-static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
+static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt,
+			       enum tcpm_transmit_type rx_sop_type)
 {
-	struct pd_mode_data *pmdata = &port->mode_data;
+	struct pd_mode_data *pmdata = rx_sop_type == TCPC_TX_SOP_PRIME ?
+				      &port->mode_data_prime : &port->mode_data;
 	int i;
 
 	for (i = 1; i < cnt; i++) {
@@ -1677,14 +1681,29 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
 	return false;
 }
 
-static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt)
+static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt,
+			       enum tcpm_transmit_type rx_sop_type)
 {
 	struct pd_mode_data *pmdata = &port->mode_data;
 	struct typec_altmode_desc *paltmode;
 	int i;
 
-	if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
-		/* Already logged in svdm_consume_svids() */
+	switch (rx_sop_type) {
+	case TCPC_TX_SOP_PRIME:
+		pmdata = &port->mode_data_prime;
+		if (pmdata->altmodes >= ARRAY_SIZE(port->plug_prime_altmode)) {
+			/* Already logged in svdm_consume_svids() */
+			return;
+		}
+		break;
+	case TCPC_TX_SOP:
+		pmdata = &port->mode_data;
+		if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
+			/* Already logged in svdm_consume_svids() */
+			return;
+		}
+		break;
+	default:
 		return;
 	}
 
@@ -1722,7 +1741,28 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 	}
 }
 
+static void tcpm_register_plug_altmodes(struct tcpm_port *port)
+{
+	struct pd_mode_data *modep = &port->mode_data_prime;
+	struct typec_altmode *altmode;
+	int i;
+
+	typec_plug_set_num_altmodes(port->plug_prime, modep->altmodes);
+
+	for (i = 0; i < modep->altmodes; i++) {
+		altmode = typec_plug_register_altmode(port->plug_prime,
+						&modep->altmode_desc[i]);
+		if (IS_ERR(altmode)) {
+			tcpm_log(port, "Failed to register plug SVID 0x%04x",
+				 modep->altmode_desc[i].svid);
+			altmode = NULL;
+		}
+		port->plug_prime_altmode[i] = altmode;
+	}
+}
+
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
+#define supports_modal_cable(port)     PD_IDH_MODAL_SUPP((port)->cable_ident.id_header)
 #define supports_host(port)    PD_IDH_HOST_SUPP((port->partner_ident.id_header))
 
 /*
@@ -1800,6 +1840,15 @@ static bool tcpm_attempt_vconn_swap_discovery(struct tcpm_port *port)
 	return false;
 }
 
+
+static bool tcpm_cable_vdm_supported(struct tcpm_port *port)
+{
+	return !IS_ERR_OR_NULL(port->cable) &&
+	       typec_cable_is_active(port->cable) &&
+	       supports_modal_cable(port) &&
+	       tcpm_can_communicate_sop_prime(port);
+}
+
 static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			const u32 *p, int cnt, u32 *response,
 			enum adev_actions *adev_action,
@@ -1807,8 +1856,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			enum tcpm_transmit_type *response_tx_sop_type)
 {
 	struct typec_port *typec = port->typec_port;
-	struct typec_altmode *pdev;
-	struct pd_mode_data *modep;
+	struct typec_altmode *pdev, *pdev_prime;
+	struct pd_mode_data *modep, *modep_prime;
 	int svdm_version;
 	int rlen = 0;
 	int cmd_type;
@@ -1829,6 +1878,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 
 	switch (rx_sop_type) {
 	case TCPC_TX_SOP_PRIME:
+		modep_prime = &port->mode_data_prime;
+		pdev_prime = typec_match_altmode(port->plug_prime_altmode,
+						 ALTMODE_DISCOVERY_MAX,
+						 PD_VDO_VID(p[0]),
+						 PD_VDO_OPOS(p[0]));
 		if (!IS_ERR_OR_NULL(port->cable)) {
 			svdm_version = typec_get_cable_svdm_version(typec);
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
@@ -1836,11 +1890,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 		}
 		break;
 	case TCPC_TX_SOP:
+		modep = &port->mode_data;
+		pdev = typec_match_altmode(port->partner_altmode,
+					   ALTMODE_DISCOVERY_MAX,
+					   PD_VDO_VID(p[0]),
+					   PD_VDO_OPOS(p[0]));
 		svdm_version = typec_get_negotiated_svdm_version(typec);
 		if (svdm_version < 0)
 			return 0;
 		break;
 	default:
+		modep = &port->mode_data;
+		pdev = typec_match_altmode(port->partner_altmode,
+					   ALTMODE_DISCOVERY_MAX,
+					   PD_VDO_VID(p[0]),
+					   PD_VDO_OPOS(p[0]));
 		svdm_version = typec_get_negotiated_svdm_version(typec);
 		if (svdm_version < 0)
 			return 0;
@@ -1932,6 +1996,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 		 * SOP'		Discover Identity
 		 * SOP		Discover SVIDs
 		 *		Discover Modes
+		 * (Active Cables)
+		 * SOP'		Discover SVIDs
+		 *		Discover Modes
 		 *
 		 * Perform Discover SOP' if the port can communicate with cable
 		 * plug.
@@ -2011,26 +2078,62 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			}
 			break;
 		case CMD_DISCOVER_SVID:
+			*response_tx_sop_type = rx_sop_type;
 			/* 6.4.4.3.2 */
-			if (svdm_consume_svids(port, p, cnt)) {
+			if (svdm_consume_svids(port, p, cnt, rx_sop_type)) {
 				response[0] = VDO(USB_SID_PD, 1, svdm_version, CMD_DISCOVER_SVID);
 				rlen = 1;
-			} else if (modep->nsvids && supports_modal(port)) {
-				response[0] = VDO(modep->svids[0], 1, svdm_version,
-						  CMD_DISCOVER_MODES);
-				rlen = 1;
+			} else {
+				if (rx_sop_type == TCPC_TX_SOP) {
+					if (modep->nsvids && supports_modal(port)) {
+						response[0] = VDO(modep->svids[0], 1, svdm_version,
+								CMD_DISCOVER_MODES);
+						rlen = 1;
+					}
+				} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+					if (modep_prime->nsvids) {
+						response[0] = VDO(modep_prime->svids[0], 1,
+								  svdm_version, CMD_DISCOVER_MODES);
+						rlen = 1;
+					}
+				}
 			}
 			break;
 		case CMD_DISCOVER_MODES:
-			/* 6.4.4.3.3 */
-			svdm_consume_modes(port, p, cnt);
-			modep->svid_index++;
-			if (modep->svid_index < modep->nsvids) {
-				u16 svid = modep->svids[modep->svid_index];
-				response[0] = VDO(svid, 1, svdm_version, CMD_DISCOVER_MODES);
-				rlen = 1;
-			} else {
-				tcpm_register_partner_altmodes(port);
+			if (rx_sop_type == TCPC_TX_SOP) {
+				/* 6.4.4.3.3 */
+				svdm_consume_modes(port, p, cnt, rx_sop_type);
+				modep->svid_index++;
+				if (modep->svid_index < modep->nsvids) {
+					u16 svid = modep->svids[modep->svid_index];
+					*response_tx_sop_type = TCPC_TX_SOP;
+					response[0] = VDO(svid, 1, svdm_version,
+							  CMD_DISCOVER_MODES);
+					rlen = 1;
+				} else if (tcpm_cable_vdm_supported(port)) {
+					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+					response[0] = VDO(USB_SID_PD, 1,
+							  typec_get_cable_svdm_version(typec),
+							  CMD_DISCOVER_SVID);
+					rlen = 1;
+				} else {
+					tcpm_register_partner_altmodes(port);
+				}
+			} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+				/* 6.4.4.3.3 */
+				svdm_consume_modes(port, p, cnt, rx_sop_type);
+				modep_prime->svid_index++;
+				if (modep_prime->svid_index < modep_prime->nsvids) {
+					u16 svid = modep_prime->svids[modep_prime->svid_index];
+					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+					response[0] = VDO(svid, 1,
+							  typec_get_cable_svdm_version(typec),
+							  CMD_DISCOVER_MODES);
+					rlen = 1;
+				} else {
+					tcpm_register_plug_altmodes(port);
+					tcpm_register_partner_altmodes(port);
+				}
 			}
 			break;
 		case CMD_ENTER_MODE:
@@ -2411,6 +2514,16 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 				tcpm_queue_vdm(port, response[0], &response[1],
 					       0, TCPC_TX_SOP);
 				break;
+			/*
+			 * If Discover SVIDs or Discover Modes fail, then
+			 * proceed with Alt Mode discovery process on SOP.
+			 */
+			case CMD_DISCOVER_SVID:
+				tcpm_register_partner_altmodes(port);
+				break;
+			case CMD_DISCOVER_MODES:
+				tcpm_register_partner_altmodes(port);
+				break;
 			default:
 				break;
 			}
@@ -4123,14 +4236,16 @@ static void tcpm_typec_disconnect(struct tcpm_port *port)
 static void tcpm_unregister_altmodes(struct tcpm_port *port)
 {
 	struct pd_mode_data *modep = &port->mode_data;
+	struct pd_mode_data *modep_prime = &port->mode_data_prime;
 	int i;
 
-	for (i = 0; i < modep->altmodes; i++) {
-		typec_unregister_altmode(port->partner_altmode[i]);
-		port->partner_altmode[i] = NULL;
+	for (i = 0; i < modep_prime->altmodes; i++) {
+		typec_unregister_altmode(port->plug_prime_altmode[i]);
+		port->plug_prime_altmode[i] = NULL;
 	}
 
 	memset(modep, 0, sizeof(*modep));
+	memset(modep_prime, 0, sizeof(*modep_prime));
 }
 
 static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
-- 
2.43.0.472.g3155946c3a-goog



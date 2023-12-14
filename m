Return-Path: <linux-kernel+bounces-228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C0F813E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31DD1C20A33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435B6FCFE;
	Thu, 14 Dec 2023 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWv6XFbC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351866FCD3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-db084a0a2e9so48107276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595348; x=1703200148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLvCYvvyu2CfQ3tNO+G91JEiHZ8LzGrbKP4+1Xl8hgE=;
        b=xWv6XFbCOvp2SrVFtuTi+s+fyyMSjilbqL9tgVyE/uuSCOIO0rtELCQZz5IMdBnsNt
         J7doxzw5SBOKoKkMDR35sF1qM8Xq8o/LMqmyV7t+onKkwN72ohqcR7ICdtfyFphZP3M0
         HvgcM6hfItB/QwQDfY3e9BmG70SlvNtjBc6eHqAog9PSI79nWA1TZDJfS961GhfOAHTf
         5HOH4DXvJg2NtKk8TDS8z89X8NDHYoEYgTX9rLskIfbJyPA1lINXEExBcN6ss8wjvqTx
         5c8Mr6KLA1hsPPQJI5ZehWTyZQ4wzPtbYctsgEBGTcmFywt5se15sJCveENYE6xAy3sw
         YDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595348; x=1703200148;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLvCYvvyu2CfQ3tNO+G91JEiHZ8LzGrbKP4+1Xl8hgE=;
        b=sL0GftnPsQbems7DurLWCPKwv0TYHbokn5qJk9Yuarp0vxXRMLOT5qQzlN8hmstdBB
         NListLfCFMWGBOXhBeZJhGDb3jvPbE+M3kEY7yo1BEuvWphGGyPIgjzNH73kMxg8T2Yl
         r5oLcuIvUup25EvBKpKdqC+oX8GpBLT8lDPSw4B4ta3WQw7FC7/I4fiFDAPDbmwGu1us
         uCUxBHWhcKfZp4cSzcoxb0xaj7j0GXUf8ID+KglEAzjcgke+YNpqCZrfOzwfmH3sdxgc
         2gt+3QEkaNVpauMNaJLg4d6GGFZu7M7z7RSXWrL7kO+PIJri+KU+GsOJrv8w7XxEyK3l
         MmWw==
X-Gm-Message-State: AOJu0Yz8ws8ryEQ2S+5q/nJ8163lfLVaURncEkrGK9okWDS6ublvg/UD
	gCCeg1J/4CxYOhMdCLogiqSZsc+4VyZw5cM=
X-Google-Smtp-Source: AGHT+IFDlEqfWgYRFFvsPNC7Eze0hgkeBnPPkAsjjn+Fn84aFyFvnQFLQSMuRmRBmRIsNPbLMtmCgFUNyOCVx4U=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:8a09:0:b0:db5:3ce2:7977 with SMTP id
 g9-20020a258a09000000b00db53ce27977mr86734ybl.7.1702595348188; Thu, 14 Dec
 2023 15:09:08 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:49 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9980; i=rdbabiera@google.com;
 h=from:subject; bh=AActgN6y9AJQR2H1jmqVf34vMivYAm9zPmpoL3rZz/Q=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3Syfn22xP6Ufenf/X5tgBolptp3NH6Z2xCSlpXRIL
 ncJvvOro5SFQYyDQVZMkUXXP8/gxpXULXM4a4xh5rAygQxh4OIUgIlscmb4K6vK9k/o6rQV+9oU
 bB3M9yzmuLj3ZNkci6qPb5pNpdPjlzAyPCuf8z5fuGm1D3Nz8rofK63kd7yp8zzxsMLy94+oFTO XMQMA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-19-rdbabiera@google.com>
Subject: [PATCH v2 05/12] usb: typec: tcpm: process receive and transmission
 of sop' messages
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add negotiated revision and tx/rx message ids to tcpm_port specific to
SOP'. tx_sop_type is added to the tcpm_port to determine whether the
current constructed message will be sent over SOP or SOP' if not
sent immediately.

tcpm_pd_rx_handler updates the received message ids. SOP* messages are not
processed afterwards. The handler also calls tcpm_can_communicate_sop_prime
to determine if a SOP' message is directed towards the port, and drops SOP'
messages it should not respond to.

tcpm_can_communicate_sop_prime is added as a helper to determine whether
the port is capable of communicating over SOP' at a given moment. Being
the Vconn source is a requirement in Power Delivery 3.0 but only a
recommendation in Power Delviery 2.0. Because the port should ensure that
the cable is powered before communication, always enforce the port is the
Vconn source regardless of revision.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 156 +++++++++++++++++++++++++++++++---
 1 file changed, 145 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b05325dcd7ac..bc6c5f04e62f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -493,6 +493,35 @@ struct tcpm_port {
 	 * transitions.
 	 */
 	bool potential_contaminant;
+
+	/* SOP* Related Fields */
+	/*
+	 * tx_sop_type determines which SOP* a message is being sent on.
+	 * For messages that are queued and not sent immediately such as in
+	 * tcpm_queue_message or messages that send after state changes,
+	 * the tx_sop_type is set accordingly.
+	 */
+	enum tcpm_transmit_type tx_sop_type;
+	/*
+	 * Prior to discovering the port partner's Specification Revision, the
+	 * Vconn source and cable plug will use the lower of their two revisions.
+	 *
+	 * When the port partner's Specification Revision is discovered, the foll=
owing
+	 * rules are put in place.
+	 *	1. If the cable revision (1) is lower than the revision negotiated
+	 * between the port and partner (2), the port and partner will communicat=
e
+	 * on revision (2), but the port and cable will communicate on revision (=
1).
+	 *	2. If the cable revision (1) is higher than the revision negotiated
+	 * between the port and partner (2), the port and partner will communicat=
e
+	 * on revision (2), and the port and cable will communicate on revision (=
2)
+	 * as well.
+	 */
+	unsigned int negotiated_rev_prime;
+	/*
+	 * Each SOP* type must maintain their own tx and rx message IDs
+	 */
+	unsigned int message_id_prime;
+	unsigned int rx_msgid_prime;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -882,19 +911,32 @@ static void tcpm_ams_finish(struct tcpm_port *port)
 }
=20
 static int tcpm_pd_transmit(struct tcpm_port *port,
-			    enum tcpm_transmit_type type,
+			    enum tcpm_transmit_type tx_sop_type,
 			    const struct pd_message *msg)
 {
 	unsigned long timeout;
 	int ret;
+	unsigned int negotiated_rev;
+
+	switch (tx_sop_type) {
+	case TCPC_TX_SOP_PRIME:
+		negotiated_rev =3D port->negotiated_rev_prime;
+		break;
+	case TCPC_TX_SOP:
+		negotiated_rev =3D port->negotiated_rev;
+		break;
+	default:
+		negotiated_rev =3D port->negotiated_rev;
+		break;
+	}
=20
 	if (msg)
 		tcpm_log(port, "PD TX, header: %#x", le16_to_cpu(msg->header));
 	else
-		tcpm_log(port, "PD TX, type: %#x", type);
+		tcpm_log(port, "PD TX, type: %#x", tx_sop_type);
=20
 	reinit_completion(&port->tx_complete);
-	ret =3D port->tcpc->pd_transmit(port->tcpc, type, msg, port->negotiated_r=
ev);
+	ret =3D port->tcpc->pd_transmit(port->tcpc, tx_sop_type, msg, negotiated_=
rev);
 	if (ret < 0)
 		return ret;
=20
@@ -907,7 +949,20 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
=20
 	switch (port->tx_status) {
 	case TCPC_TX_SUCCESS:
-		port->message_id =3D (port->message_id + 1) & PD_HEADER_ID_MASK;
+		switch (tx_sop_type) {
+		case TCPC_TX_SOP_PRIME:
+			port->message_id_prime =3D (port->message_id_prime + 1) &
+						 PD_HEADER_ID_MASK;
+			break;
+		case TCPC_TX_SOP:
+			port->message_id =3D (port->message_id + 1) &
+					   PD_HEADER_ID_MASK;
+			break;
+		default:
+			port->message_id =3D (port->message_id + 1) &
+					   PD_HEADER_ID_MASK;
+			break;
+		}
 		/*
 		 * USB PD rev 2.0, 8.3.2.2.1:
 		 * USB PD rev 3.0, 8.3.2.1.3:
@@ -1592,6 +1647,57 @@ static void tcpm_register_partner_altmodes(struct tc=
pm_port *port)
=20
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_he=
ader)
=20
+/*
+ * Helper to determine whether the port is capable of SOP' communication a=
t the
+ * current point in time.
+ */
+static bool tcpm_can_communicate_sop_prime(struct tcpm_port *port)
+{
+	/* Check to see if tcpc supports SOP' communication */
+	if (!port->tcpc->cable_comm_capable || !port->tcpc->cable_comm_capable(po=
rt->tcpc))
+		return false;
+	/*
+	 * Power Delivery 2.0 Section 6.3.11
+	 * Before communicating with a Cable Plug a Port Should ensure that it
+	 * is the Vconn Source and that the Cable Plugs are powered by
+	 * performing a Vconn swap if necessary. Since it cannot be guaranteed
+	 * that the present Vconn Source is supplying Vconn, the only means to
+	 * ensure that the Cable Plugs are powered is for a Port wishing to
+	 * communicate with a Cable Plug is to become the Vconn Source.
+	 *
+	 * Power Delivery 3.0 Section 6.3.11
+	 * Before communicating with a Cable Plug a Port Shall ensure that it
+	 * is the Vconn source.
+	 */
+	if (port->vconn_role !=3D TYPEC_SOURCE)
+		return false;
+	/*
+	 * Power Delivery 2.0 Section 2.4.4
+	 * When no Contract or an Implicit Contract is in place the Source can
+	 * communicate with a Cable Plug using SOP' packets in order to discover
+	 * its characteristics.
+	 *
+	 * Power Delivery 3.0 Section 2.4.4
+	 * When no Contract or an Implicit Contract is in place only the Source
+	 * port that is supplying Vconn is allowed to send packets to a Cable
+	 * Plug and is allowed to respond to packets from the Cable Plug.
+	 */
+	if (!port->explicit_contract)
+		return port->pwr_role =3D=3D TYPEC_SOURCE;
+	if (port->negotiated_rev =3D=3D PD_REV30)
+		return true;
+	/*
+	 * Power Delivery 2.0 Section 2.4.4
+	 *
+	 * When an Explicit Contract is in place the DFP (either the Source or
+	 * the Sink) can communicate with the Cable Plug(s) using SOP=E2=80=99/SO=
P=E2=80=9D
+	 * Packets (see Figure 2-3).
+	 */
+	if (port->negotiated_rev =3D=3D PD_REV20)
+		return port->data_role =3D=3D TYPEC_HOST;
+	return false;
+}
+
 static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev=
,
 			const u32 *p, int cnt, u32 *response,
 			enum adev_actions *adev_action)
@@ -2977,14 +3083,18 @@ static void tcpm_pd_rx_handler(struct kthread_work =
*work)
 	tcpm_log(port, "PD RX, header: %#x [%d]", le16_to_cpu(msg->header),
 		 port->attached);
=20
-	/* Ignore SOP' for now */
-	if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME)
-		goto done;
-
 	if (port->attached) {
 		enum pd_ctrl_msg_type type =3D pd_header_type_le(msg->header);
 		unsigned int msgid =3D pd_header_msgid_le(msg->header);
=20
+		/*
+		 * Drop SOP' messages if cannot receive via
+		 * tcpm_can_communicate_sop_prime
+		 */
+		if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME &&
+		    !tcpm_can_communicate_sop_prime(port))
+			goto done;
+
 		/*
 		 * USB PD standard, 6.6.1.2:
 		 * "... if MessageID value in a received Message is the
@@ -2994,16 +3104,33 @@ static void tcpm_pd_rx_handler(struct kthread_work =
*work)
 		 * Message). Note: this shall not apply to the Soft_Reset
 		 * Message which always has a MessageID value of zero."
 		 */
-		if (msgid =3D=3D port->rx_msgid && type !=3D PD_CTRL_SOFT_RESET)
+		switch (rx_sop_type) {
+		case TCPC_TX_SOP_PRIME:
+			if (msgid =3D=3D port->rx_msgid_prime)
+				goto done;
+			port->rx_msgid_prime =3D msgid;
+			/* Ignore SOP' for now */
 			goto done;
-		port->rx_msgid =3D msgid;
+		case TCPC_TX_SOP:
+			if (msgid =3D=3D port->rx_msgid &&
+			    type !=3D PD_CTRL_SOFT_RESET)
+				goto done;
+			port->rx_msgid =3D msgid;
+			break;
+		default:
+			if (msgid =3D=3D port->rx_msgid &&
+			    type !=3D PD_CTRL_SOFT_RESET)
+				goto done;
+			port->rx_msgid =3D msgid;
+			break;
+		}
=20
 		/*
 		 * If both ends believe to be DFP/host, we have a data role
 		 * mismatch.
 		 */
 		if (!!(le16_to_cpu(msg->header) & PD_HEADER_DATA_ROLE) =3D=3D
-		    (port->data_role =3D=3D TYPEC_HOST)) {
+		    (port->data_role =3D=3D TYPEC_HOST) && rx_sop_type =3D=3D TCPC_TX_SO=
P) {
 			tcpm_log(port,
 				 "Data role mismatch, initiating error recovery");
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
@@ -3708,6 +3835,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	 * we can check tcpm_pd_rx_handler() if we had seen it before.
 	 */
 	port->rx_msgid =3D -1;
+	port->rx_msgid_prime =3D -1;
=20
 	port->tcpc->set_pd_rx(port->tcpc, false);
 	tcpm_init_vbus(port);	/* also disables charging */
@@ -4022,8 +4150,11 @@ static void run_state_machine(struct tcpm_port *port=
)
 		port->pwr_opmode =3D TYPEC_PWR_MODE_USB;
 		port->caps_count =3D 0;
 		port->negotiated_rev =3D PD_MAX_REV;
+		port->negotiated_rev_prime =3D PD_MAX_REV;
 		port->message_id =3D 0;
+		port->message_id_prime =3D 0;
 		port->rx_msgid =3D -1;
+		port->rx_msgid_prime =3D -1;
 		port->explicit_contract =3D false;
 		/* SNK -> SRC POWER/FAST_ROLE_SWAP finished */
 		if (port->ams =3D=3D POWER_ROLE_SWAP ||
@@ -4263,8 +4394,11 @@ static void run_state_machine(struct tcpm_port *port=
)
 		typec_set_pwr_opmode(port->typec_port, opmode);
 		port->pwr_opmode =3D TYPEC_PWR_MODE_USB;
 		port->negotiated_rev =3D PD_MAX_REV;
+		port->negotiated_rev_prime =3D PD_MAX_REV;
 		port->message_id =3D 0;
+		port->message_id_prime =3D 0;
 		port->rx_msgid =3D -1;
+		port->rx_msgid_prime =3D -1;
 		port->explicit_contract =3D false;
=20
 		if (port->ams =3D=3D POWER_ROLE_SWAP ||
--=20
2.43.0.472.g3155946c3a-goog



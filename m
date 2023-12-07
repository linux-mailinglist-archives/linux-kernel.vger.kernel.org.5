Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390B808458
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjLGJID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjLGJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:07:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D8D4A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:08:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db7d201be93so1026380276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701940083; x=1702544883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o14MGum+47AYWK8DkKGYzjB+QMQESr1NeJbUnOfv+2g=;
        b=pkaNSg+ub7nGua+JAwYC/Lk7cmaoGKuzEaXp6ZCAHInLwqdq2thPFzZRAAGcZgJbBE
         o62StJ8wvDYw1nusJs6gQF038iVSkoiHib1fE1II1BZJkA9Lm0fIdabmrJI80GnR8kNZ
         MELEcdX2ZYDsdxPFY+9d3/H2Q1Ejweg0IN5+NCvajQ7AbwePe2LsuiwfoV88H/0URjcx
         KP6wzl0u5XGTmOhPEk61VmpxJQ/UQMp59RpW4i9J9NE4D0/iOHi+GsGIgI96tlVemcIG
         +Org3u2jfZAwt2giVhFDXkp5jJ/lCYhTSl3y+aF1CHRdlIwmU9StctIK6PNtV/9fQ5i+
         zQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940083; x=1702544883;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o14MGum+47AYWK8DkKGYzjB+QMQESr1NeJbUnOfv+2g=;
        b=i1pJQx66PF3hfN9d8B6v0Ig61oqACNCHq0kkN31pfbSmNY2yjfbEUwEfM4q4YtuGmH
         qPLyEedFAjaSuGhNYo6NZVJhO3daRVBwsHE/2oGswYhoUKBpX283SidwmRv4xXK9uBAe
         NJcR4N7b6cw/zRRVKqm452oD2mmI1kdAER80UUw/S5jonfMHP7orW8nOfnw+TEQPRhIK
         KiRTWwcXqhsJciUAKlFzCAqGMMyk4Yk5+f/g91l9RRMsmUbMjj+EM8n0VTpnrfy7ZPml
         QE/4GetDNsRpYnbV6/rOo9frSykjFye6ap2K2D2slIgp7qXRD7zSoEBlXr7nRH7eBwA4
         29bg==
X-Gm-Message-State: AOJu0YxQv/WmjDSPqCQVdXGarUW9h4bP6qh+qRJugRWevzGbFuwZvl1T
        jKFkT1di6q6azYF3LMS4I/pheJ4DvibYqow=
X-Google-Smtp-Source: AGHT+IESqp84idXc+q5u9MDFeaSljtOtaoFQha272YyPKZC83BfNU4qv0DtqVTF2X+Ygtv8drGCkXxJ3QEblTWk=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:7489:0:b0:d9a:ec95:9687 with SMTP id
 p131-20020a257489000000b00d9aec959687mr24783ybc.11.1701940082998; Thu, 07 Dec
 2023 01:08:02 -0800 (PST)
Date:   Thu,  7 Dec 2023 09:07:34 +0000
In-Reply-To: <20231207090738.15721-12-rdbabiera@google.com>
Mime-Version: 1.0
References: <20231207090738.15721-12-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9939; i=rdbabiera@google.com;
 h=from:subject; bh=I/HoHGVc7Oaex23bh6N4rq+2IpkSlsE3QSHESQ/ktpQ=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmF3dGPVk3cq3a6ccleW9kk15ORnYuORJfcDBReUNc78
 VnotoLDHaUsDGIcDLJiiiy6/nkGN66kbpnDWWMMM4eVCWQIAxenAExk009GhtMlMfuiVouZBT9e
 viWzJKX/4pucB/fndm3UdN86g/O/dD8jw+rGdZN7lNUezMpZW6dzwawzSmfGms6JtZ/2pLtvnn9 Kgx0A
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207090738.15721-15-rdbabiera@google.com>
Subject: [PATCH v1 03/10] usb: typec: tcpm: process receive and transmission
 of sop' messages
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, linux@roeck-us.net,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        bleung@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     badhri@google.com, tzungbi@kernel.org, utkarsh.h.patel@intel.com,
        andriy.shevchenko@linux.intel.com,
        RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add negotiated revision and tx/rx message ids to tcpm_port specific to
SOP'. tx_sop_type is added to the tcpm_port to determine whether the
current constructed message will be sent over SOP or SOP' if not
sent immediately.

tcpm_pd_transmit now accounts for the transmit SOP* type, and updates
the message ids accordingly. SOP* messages are currently not sent by
the tcpm.

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
 drivers/usb/typec/tcpm/tcpm.c | 152 ++++++++++++++++++++++++++++++++--
 1 file changed, 143 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5f9a4691f626..313928f93d0c 100644
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
+	 * the tx_sop_type should be set accordingly.
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
@@ -2984,8 +3090,12 @@ static void tcpm_pd_rx_handler(struct kthread_work *=
work)
 		enum pd_ctrl_msg_type type =3D pd_header_type_le(msg->header);
 		unsigned int msgid =3D pd_header_msgid_le(msg->header);
=20
-		/* Ignore SOP' for now */
-		if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME)
+		/*
+		 * Drop SOP' messages if cannot receive via
+		 * tcpm_can_communicate_sop_prime
+		 */
+		if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME &&
+		    !tcpm_can_communicate_sop_prime(port))
 			goto done;
=20
 		/*
@@ -2997,16 +3107,33 @@ static void tcpm_pd_rx_handler(struct kthread_work =
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
+			/* For now, don't do anything with SOP' Messages */
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
@@ -3711,6 +3838,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	 * we can check tcpm_pd_rx_handler() if we had seen it before.
 	 */
 	port->rx_msgid =3D -1;
+	port->rx_msgid_prime =3D -1;
=20
 	port->tcpc->set_pd_rx(port->tcpc, false);
 	tcpm_init_vbus(port);	/* also disables charging */
@@ -4025,8 +4153,11 @@ static void run_state_machine(struct tcpm_port *port=
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
@@ -4266,8 +4397,11 @@ static void run_state_machine(struct tcpm_port *port=
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
2.43.0.rc2.451.g8631bc7472-goog


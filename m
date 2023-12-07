Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8725380845D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjLGJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjLGJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:08:00 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086DD7E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:08:05 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d08acaab7fso4912645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701940084; x=1702544884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ee9+vLb9jHxLxxtSEpDCi2PEBtLJvw/yxQpz8RWhRI=;
        b=QTolsXGwR37l69xAbt4L+irg1NTixnJz/dMqEejHRAauEBI2hLybM36OiAPGtgwxMG
         4tm8/IKjKXGGVz7EVZ9ZYzBs9/osLQ79Y+l7YanoUHGn0xUDdi1GeKZ/JvoZ22lyjNeD
         K/jal3VPSPNLmT1RH+vQVIbqQhF1JwXcfap9/WoNjTwA2ic/2utqcJ3pPKfrfQTByFWY
         v+hjO+5gMV8RJGvuazoW5I9YdbJO2ZHHsc1w8oxHntqeDVdN+3ATt81TUc2LmZgVLPJQ
         c5qh4YiHQhBDBe4y6YOVyHm8w0F0Sjy08on+VKCLIMKyu6OdeLi03ibxU2dzVshXYYv2
         tnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940084; x=1702544884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ee9+vLb9jHxLxxtSEpDCi2PEBtLJvw/yxQpz8RWhRI=;
        b=r0QpdrW3OVQSuyKgbfZuqLuR/p3VudtTEN8mThqShXpCyTJ7jBV78g97ZC/j+S8jfU
         GeyKz/h3+fR/fjtJJ+i0YySmgdSQo9/9mx0I/JwE35ou7PDYWmcYiUiCLyuD+u/m23dE
         IowUIiKv0fjPjtNRyMLhpofENxQPaWsk8Eth4/C1SjQviuHvSjWq5CEyAp72PmqeHtG3
         Y800i0JOsiu0dg7icDDUz04RI6OBdFjj1W6ckQoKwAnVQQ+L3oa9jrFAir+9bwjjPVw1
         cuYUBzqyAhUA7sX0iNvhqm/VoKEsf+e4Bfw+YD5vbKUclz1ZigTDqVJKMsuVngKWlirf
         cFYA==
X-Gm-Message-State: AOJu0YxOPelzzHCFOi8wulYIscB3l3T7RqbgxBAX1v2552gIyEivfR4E
        GhrGIHbSYtIdLm4Sih5VxI79IXwP2Fj9E5A=
X-Google-Smtp-Source: AGHT+IE144gbtvb/3pDM6DkUh1Jq1aglFiSsnUUvihpi0/LENYXSfNd9IxT6JKSeI29VryIJPTPqdtWONXT5+BI=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a17:902:dac5:b0:1d0:b595:4ea4 with SMTP
 id q5-20020a170902dac500b001d0b5954ea4mr28890plx.4.1701940084535; Thu, 07 Dec
 2023 01:08:04 -0800 (PST)
Date:   Thu,  7 Dec 2023 09:07:35 +0000
In-Reply-To: <20231207090738.15721-12-rdbabiera@google.com>
Mime-Version: 1.0
References: <20231207090738.15721-12-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=14654; i=rdbabiera@google.com;
 h=from:subject; bh=uzf9MVQzNy9YwxgF5wuGq6Gnc3qD0Q+pL2//fBHt9Rk=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmF3TGiRywSvAMPy0/96KceIsW3xv3bDK9Hfwsv/p60P
 UDzyzOhjlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACZy+zcjwzW+cgtrYa9VensW
 MZpOKOtMuV15N+irlHxfctkpcadbMxj+O23Zwtw0+7vxdv7E6z9fVac9+WUUNUMs5tYMRVv+NKf fnAA=
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207090738.15721-16-rdbabiera@google.com>
Subject: [PATCH v1 04/10] usb: typec: tcpm: add control message support for SOP'
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

Add tx_sop_type to tcpm_pd_send_control and rx_sop_type to
tcpm_pd_ctrl_request. TCPC_TX_SOP is added to all pd_send_control calls,
with the exception of TCPC_TX_SOP_PRIME being added to pd_send_control
for a SOFT_RESET message sent after a Vconn swap that makes the port
the Vconn source. After the SOFT_RESET is accepted, tcpm_pd_ctrl_request
resets the proper protocol layer depending on the rx_sop_type.

VCONN_SWAP_TURN_ON_VCONN redirects to a new state,
VCONN_SWAP_SEND_SOFT_RESET. This state sends SOFT_RESET over SOP' before
transitioning to the ready state if applicable.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 159 ++++++++++++++++++++++++----------
 include/linux/usb/pd.h        |   1 +
 2 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 313928f93d0c..d1c6157a2ea3 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -108,6 +108,7 @@
 	S(VCONN_SWAP_WAIT_FOR_VCONN),		\
 	S(VCONN_SWAP_TURN_ON_VCONN),		\
 	S(VCONN_SWAP_TURN_OFF_VCONN),		\
+	S(VCONN_SWAP_SEND_SOFT_RESET),		\
 						\
 	S(FR_SWAP_SEND),			\
 	S(FR_SWAP_SEND_TIMEOUT),		\
@@ -2391,7 +2392,8 @@ static inline enum tcpm_state ready_state(struct tcpm_port *port)
 }
 
 static int tcpm_pd_send_control(struct tcpm_port *port,
-				enum pd_ctrl_msg_type type);
+				enum pd_ctrl_msg_type type,
+				enum tcpm_transmit_type tx_sop_type);
 
 static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
 			      int cnt)
@@ -2745,10 +2747,12 @@ static void tcpm_pps_complete(struct tcpm_port *port, int result)
 }
 
 static void tcpm_pd_ctrl_request(struct tcpm_port *port,
-				 const struct pd_message *msg)
+				 const struct pd_message *msg,
+				 enum tcpm_transmit_type rx_sop_type)
 {
 	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
 	enum tcpm_state next_state;
+	unsigned int rev = pd_header_rev_le(msg->header);
 
 	/*
 	 * Stop VDM state machine if interrupted by other Messages while NOT_SUPP is allowed in
@@ -2913,6 +2917,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		case SOFT_RESET_SEND:
 			if (port->ams == SOFT_RESET_AMS)
 				tcpm_ams_finish(port);
+			/*
+			 * SOP' Soft Reset is done after Vconn Swap,
+			 * which returns to ready state
+			 */
+			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+				if (rev < port->negotiated_rev_prime)
+					port->negotiated_rev_prime = rev;
+				tcpm_set_state(port, ready_state(port), 0);
+				break;
+			}
 			if (port->pwr_role == TYPEC_SOURCE) {
 				port->upcoming_state = SRC_SEND_CAPABILITIES;
 				tcpm_ams_start(port, POWER_NEGOTIATION);
@@ -3112,8 +3126,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 			if (msgid == port->rx_msgid_prime)
 				goto done;
 			port->rx_msgid_prime = msgid;
-			/* For now, don't do anything with SOP' Messages */
-			goto done;
+			break;
 		case TCPC_TX_SOP:
 			if (msgid == port->rx_msgid &&
 			    type != PD_CTRL_SOFT_RESET)
@@ -3143,7 +3156,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 			else if (cnt)
 				tcpm_pd_data_request(port, msg);
 			else
-				tcpm_pd_ctrl_request(port, msg);
+				tcpm_pd_ctrl_request(port, msg, rx_sop_type);
 		}
 	}
 
@@ -3170,17 +3183,40 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg,
 EXPORT_SYMBOL_GPL(tcpm_pd_receive);
 
 static int tcpm_pd_send_control(struct tcpm_port *port,
-				enum pd_ctrl_msg_type type)
+				enum pd_ctrl_msg_type type,
+				enum tcpm_transmit_type tx_sop_type)
 {
 	struct pd_message msg;
 
 	memset(&msg, 0, sizeof(msg));
-	msg.header = PD_HEADER_LE(type, port->pwr_role,
-				  port->data_role,
-				  port->negotiated_rev,
-				  port->message_id, 0);
+	switch (tx_sop_type) {
+	case TCPC_TX_SOP_PRIME:
+		msg.header = PD_HEADER_LE(type,
+					  0,	/* Cable Plug Indicator for DFP/UFP */
+					  0,	/* Reserved */
+					  port->negotiated_rev,
+					  port->message_id_prime,
+					  0);
+		break;
+	case TCPC_TX_SOP:
+		msg.header = PD_HEADER_LE(type,
+					  port->pwr_role,
+					  port->data_role,
+					  port->negotiated_rev,
+					  port->message_id,
+					  0);
+		break;
+	default:
+		msg.header = PD_HEADER_LE(type,
+					  port->pwr_role,
+					  port->data_role,
+					  port->negotiated_rev,
+					  port->message_id,
+					  0);
+		break;
+	}
 
-	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+	return tcpm_pd_transmit(port, tx_sop_type, &msg);
 }
 
 /*
@@ -3199,13 +3235,13 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 
 		switch (queued_message) {
 		case PD_MSG_CTRL_WAIT:
-			tcpm_pd_send_control(port, PD_CTRL_WAIT);
+			tcpm_pd_send_control(port, PD_CTRL_WAIT, TCPC_TX_SOP);
 			break;
 		case PD_MSG_CTRL_REJECT:
-			tcpm_pd_send_control(port, PD_CTRL_REJECT);
+			tcpm_pd_send_control(port, PD_CTRL_REJECT, TCPC_TX_SOP);
 			break;
 		case PD_MSG_CTRL_NOT_SUPP:
-			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
+			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP, TCPC_TX_SOP);
 			break;
 		case PD_MSG_DATA_SINK_CAP:
 			ret = tcpm_pd_send_sink_caps(port);
@@ -4220,7 +4256,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SRC_NEGOTIATE_CAPABILITIES:
 		ret = tcpm_pd_check_request(port);
 		if (ret < 0) {
-			tcpm_pd_send_control(port, PD_CTRL_REJECT);
+			tcpm_pd_send_control(port, PD_CTRL_REJECT, TCPC_TX_SOP);
 			if (!port->explicit_contract) {
 				tcpm_set_state(port,
 					       SRC_WAIT_NEW_CAPABILITIES, 0);
@@ -4228,7 +4264,7 @@ static void run_state_machine(struct tcpm_port *port)
 				tcpm_set_state(port, SRC_READY, 0);
 			}
 		} else {
-			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+			tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 			tcpm_set_partner_usb_comm_capable(port,
 							  !!(port->sink_request & RDO_USB_COMM));
 			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
@@ -4237,7 +4273,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SRC_TRANSITION_SUPPLY:
 		/* XXX: regulator_set_voltage(vbus, ...) */
-		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
+		tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP);
 		port->explicit_contract = true;
 		typec_set_pwr_opmode(port->typec_port, TYPEC_PWR_MODE_PD);
 		port->pwr_opmode = TYPEC_PWR_MODE_PD;
@@ -4721,7 +4757,7 @@ static void run_state_machine(struct tcpm_port *port)
 		/* remove existing capabilities */
 		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
 		port->partner_source_caps = NULL;
-		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
@@ -4738,28 +4774,41 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_ams_start(port, SOFT_RESET_AMS);
 		break;
 	case SOFT_RESET_SEND:
-		port->message_id = 0;
-		port->rx_msgid = -1;
-		/* remove existing capabilities */
-		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
-		port->partner_source_caps = NULL;
-		if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET))
-			tcpm_set_state_cond(port, hard_reset_state(port), 0);
-		else
-			tcpm_set_state_cond(port, hard_reset_state(port),
-					    PD_T_SENDER_RESPONSE);
+		/*
+		 * Power Delivery 3.0 Section 6.3.13
+		 *
+		 * A Soft_Reset Message Shall be targeted at a specific entity
+		 * depending on the type of SOP* packet used.
+		 */
+		if (port->tx_sop_type == TCPC_TX_SOP_PRIME) {
+			port->message_id_prime = 0;
+			port->rx_msgid_prime = -1;
+			tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP_PRIME);
+			tcpm_set_state_cond(port, ready_state(port), PD_T_SENDER_RESPONSE);
+		} else {
+			port->message_id = 0;
+			port->rx_msgid = -1;
+			/* remove existing capabilities */
+			usb_power_delivery_unregister_capabilities(port->partner_source_caps);
+			port->partner_source_caps = NULL;
+			if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP))
+				tcpm_set_state_cond(port, hard_reset_state(port), 0);
+			else
+				tcpm_set_state_cond(port, hard_reset_state(port),
+						PD_T_SENDER_RESPONSE);
+		}
 		break;
 
 	/* DR_Swap states */
 	case DR_SWAP_SEND:
-		tcpm_pd_send_control(port, PD_CTRL_DR_SWAP);
+		tcpm_pd_send_control(port, PD_CTRL_DR_SWAP, TCPC_TX_SOP);
 		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
 			port->send_discover = true;
 		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
 				    PD_T_SENDER_RESPONSE);
 		break;
 	case DR_SWAP_ACCEPT:
-		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 		if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
 			port->send_discover = true;
 		tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
@@ -4783,7 +4832,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 
 	case FR_SWAP_SEND:
-		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP)) {
+		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP, TCPC_TX_SOP)) {
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
@@ -4803,7 +4852,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
 		tcpm_set_pwr_role(port, TYPEC_SOURCE);
-		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
+		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP)) {
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
@@ -4813,11 +4862,11 @@ static void run_state_machine(struct tcpm_port *port)
 
 	/* PR_Swap states */
 	case PR_SWAP_ACCEPT:
-		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 		tcpm_set_state(port, PR_SWAP_START, 0);
 		break;
 	case PR_SWAP_SEND:
-		tcpm_pd_send_control(port, PD_CTRL_PR_SWAP);
+		tcpm_pd_send_control(port, PD_CTRL_PR_SWAP, TCPC_TX_SOP);
 		tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
 				    PD_T_SENDER_RESPONSE);
 		break;
@@ -4859,7 +4908,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 * supply is turned off"
 		 */
 		tcpm_set_pwr_role(port, TYPEC_SINK);
-		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
+		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP)) {
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
@@ -4906,17 +4955,17 @@ static void run_state_machine(struct tcpm_port *port)
 		 * Source."
 		 */
 		tcpm_set_pwr_role(port, TYPEC_SOURCE);
-		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
+		tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP);
 		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
 		break;
 
 	case VCONN_SWAP_ACCEPT:
-		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 		tcpm_ams_finish(port);
 		tcpm_set_state(port, VCONN_SWAP_START, 0);
 		break;
 	case VCONN_SWAP_SEND:
-		tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP);
+		tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP, TCPC_TX_SOP);
 		tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
 			       PD_T_SENDER_RESPONSE);
 		break;
@@ -4935,14 +4984,34 @@ static void run_state_machine(struct tcpm_port *port)
 			       PD_T_VCONN_SOURCE_ON);
 		break;
 	case VCONN_SWAP_TURN_ON_VCONN:
-		tcpm_set_vconn(port, true);
-		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
-		tcpm_set_state(port, ready_state(port), 0);
+		ret = tcpm_set_vconn(port, true);
+		tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP);
+		/*
+		 * USB PD 3.0 Section 6.4.4.3.1
+		 *
+		 * Note that a Cable Plug or VPD will not be ready for PD
+		 * Communication until tVCONNStable after VCONN has been applied
+		 */
+		if (!ret)
+			tcpm_set_state(port, VCONN_SWAP_SEND_SOFT_RESET,
+				       PD_T_VCONN_STABLE);
+		else
+			tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case VCONN_SWAP_TURN_OFF_VCONN:
 		tcpm_set_vconn(port, false);
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
+	case VCONN_SWAP_SEND_SOFT_RESET:
+		tcpm_swap_complete(port, port->swap_status);
+		if (tcpm_can_communicate_sop_prime(port)) {
+			port->tx_sop_type = TCPC_TX_SOP_PRIME;
+			port->upcoming_state = SOFT_RESET_SEND;
+			tcpm_ams_start(port, SOFT_RESET_AMS);
+		} else {
+			tcpm_set_state(port, ready_state(port), 0);
+		}
+		break;
 
 	case DR_SWAP_CANCEL:
 	case PR_SWAP_CANCEL:
@@ -4978,7 +5047,7 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case GET_STATUS_SEND:
-		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
+		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS, TCPC_TX_SOP);
 		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
 			       PD_T_SENDER_RESPONSE);
 		break;
@@ -4986,7 +5055,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case GET_PPS_STATUS_SEND:
-		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
+		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS, TCPC_TX_SOP);
 		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
 			       PD_T_SENDER_RESPONSE);
 		break;
@@ -4994,7 +5063,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case GET_SINK_CAP:
-		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP);
+		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP, TCPC_TX_SOP);
 		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RESPONSE);
 		break;
 	case GET_SINK_CAP_TIMEOUT:
@@ -5034,7 +5103,7 @@ static void run_state_machine(struct tcpm_port *port)
 
 	/* Chunk state */
 	case CHUNK_NOT_SUPP:
-		tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
+		tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP, TCPC_TX_SOP);
 		tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
 		break;
 	default:
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index eb626af0e4e7..d50098fb16b5 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -483,6 +483,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
 #define PD_T_SINK_TX		16	/* 16 - 20 ms */
 #define PD_T_CHUNK_NOT_SUPP	42	/* 40 - 50 ms */
+#define PD_T_VCONN_STABLE	50
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
-- 
2.43.0.rc2.451.g8631bc7472-goog


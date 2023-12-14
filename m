Return-Path: <linux-kernel+bounces-229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 815DC813E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F6CB2247D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FF79474;
	Thu, 14 Dec 2023 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3WFMxg8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9F6FCD7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ce2e42ec17so42080b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595350; x=1703200150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qMULIQOgqIe7YMnzDJvKEyanw3KWMN0zaPdo/siE/M=;
        b=K3WFMxg8klWy2TlCXblniJgNtZj/l3LOx/ON3AccAstbIW00LGskQMU/cp4ion+660
         ScoEQ5gbFieddeau/gn3daV2tW4MvfydDbgPR5ihdqdLIaO1BkyvTRwbopCnpBjPks+Y
         +kZc8NU+lOu07XwGWKwQ0RuShSciILWGU/HRAVlar6BzZZwDM1k6C3A8Ka3OgXTy4sbN
         GuD/D2sH2tzH1gyPl7fRxP9jPzjMiVRtWUgTfeEahN+kcVglfuRj0BAMF6ZcRbHvAQZT
         uKHxbQO/YJYiShWNqrrK7mc61quS0wp26/3gF+VOa4qr1g/5rPpGURimuSz1RCmSLZG/
         gyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595350; x=1703200150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qMULIQOgqIe7YMnzDJvKEyanw3KWMN0zaPdo/siE/M=;
        b=OHVvnmpuygpjUJe8hRj/0KZmMGbY26Ivo8vLaTuvPHpTJ6L6hEcG5uKzoKcT9ndcn4
         gpTg4xvLIwnnozowbPmBO2i/wCX/eD4AnUNW7TwUARBu7iK59oA1zN2JXWCHxna5+V9M
         ZUoymOSkrrs74G52yMe8Y3TAwPzLnY3YZfClA6WRK1iVCJI2dfGp4+vN3tzICdzE5oJ4
         pIIkqOWWN4Ia/4kce3AGJfEc34XT+ioOZBuVwlHL5uBuUDhU4ryI4cP6H+nuDbGmspiA
         WrTfoVsNluiDTXhXkcp89iZ8bh2aWAHWsVK9bclbNOhVyJ7DI0b59XDb6IH7RbRLcmti
         BOEA==
X-Gm-Message-State: AOJu0YyusALlrH96QP8an3EAPToZvS94JAnwyxJVSVFvmB9D9Pv6ON7/
	vl4iKxVvhlipdrOyV7CEbGbwYyREV/SFbfE=
X-Google-Smtp-Source: AGHT+IG3pv/XkOk+37dZIvFdVEVcQz7AHVDMPa/trC3pJnVUwmwngUb5ADA2duKybR6KvhCTAhwcdJpEkEgOyK0=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6a00:1951:b0:6cd:f4a4:6438 with SMTP
 id s17-20020a056a00195100b006cdf4a46438mr1918589pfk.1.1702595349899; Thu, 14
 Dec 2023 15:09:09 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:50 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=14723; i=rdbabiera@google.com;
 h=from:subject; bh=Cts/QyqwRL0SscKvmL/gCe1wi0oepmxvRE5DukxwnmI=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3azmm0pfMP1eIpebEf7G/467/amlBi2zd1TwJ6d/r
 w1+Lryjo5SFQYyDQVZMkUXXP8/gxpXULXM4a4xh5rAygQxh4OIUgIk8/8zwV2ryq9neT9dOTbBY
 tOkQ20fXy4uZ7Zk/eP2JT1cJtpKMXsfIMLGu7BLXU4Pn/hvi+Y6ddmSqvnPvjnShVEVgQdvnJQe bOAE=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-20-rdbabiera@google.com>
Subject: [PATCH v2 06/12] usb: typec: tcpm: add control message support to sop'
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add tx_sop_type to tcpm_pd_send_control and rx_sop_type to
tcpm_pd_ctrl_request. TCPC_TX_SOP is added to all pd_send_control calls,
but TCPC_TX_SOP_PRIME is added to pd_send_control for a SOFT_RESET message
sent after a Vconn swap that makes the Port the Vconn source. Likewise,
tcpm_pd_ctrl_request resets the proper protocol layer depending on
rx_sop_type for SOFT_RESET.

VCONN_SWAP_TURN_ON_VCONN now moves to a new state,
VCONN_SWAP_SEND_SOFT_RESET. This state sends SOFT_RESET over SOP' before
transitioning to the ready state if applicable. It transitions after
PD_T_VCONN_STABLE, definied in pd.h as the time required for Vconn to be
on before transmitting messages.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 159 ++++++++++++++++++++++++----------
 include/linux/usb/pd.h        |   1 +
 2 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bc6c5f04e62f..c1e1fd6bd60d 100644
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
@@ -2388,7 +2389,8 @@ static inline enum tcpm_state ready_state(struct tcpm_port *port)
 }
 
 static int tcpm_pd_send_control(struct tcpm_port *port,
-				enum pd_ctrl_msg_type type);
+				enum pd_ctrl_msg_type type,
+				enum tcpm_transmit_type tx_sop_type);
 
 static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
 			      int cnt)
@@ -2742,10 +2744,12 @@ static void tcpm_pps_complete(struct tcpm_port *port, int result)
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
@@ -2910,6 +2914,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
@@ -3109,8 +3123,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 			if (msgid == port->rx_msgid_prime)
 				goto done;
 			port->rx_msgid_prime = msgid;
-			/* Ignore SOP' for now */
-			goto done;
+			break;
 		case TCPC_TX_SOP:
 			if (msgid == port->rx_msgid &&
 			    type != PD_CTRL_SOFT_RESET)
@@ -3140,7 +3153,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 			else if (cnt)
 				tcpm_pd_data_request(port, msg);
 			else
-				tcpm_pd_ctrl_request(port, msg);
+				tcpm_pd_ctrl_request(port, msg, rx_sop_type);
 		}
 	}
 
@@ -3167,17 +3180,40 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg,
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
@@ -3196,13 +3232,13 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 
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
@@ -4217,7 +4253,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SRC_NEGOTIATE_CAPABILITIES:
 		ret = tcpm_pd_check_request(port);
 		if (ret < 0) {
-			tcpm_pd_send_control(port, PD_CTRL_REJECT);
+			tcpm_pd_send_control(port, PD_CTRL_REJECT, TCPC_TX_SOP);
 			if (!port->explicit_contract) {
 				tcpm_set_state(port,
 					       SRC_WAIT_NEW_CAPABILITIES, 0);
@@ -4225,7 +4261,7 @@ static void run_state_machine(struct tcpm_port *port)
 				tcpm_set_state(port, SRC_READY, 0);
 			}
 		} else {
-			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+			tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 			tcpm_set_partner_usb_comm_capable(port,
 							  !!(port->sink_request & RDO_USB_COMM));
 			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
@@ -4234,7 +4270,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SRC_TRANSITION_SUPPLY:
 		/* XXX: regulator_set_voltage(vbus, ...) */
-		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
+		tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP);
 		port->explicit_contract = true;
 		typec_set_pwr_opmode(port->typec_port, TYPEC_PWR_MODE_PD);
 		port->pwr_opmode = TYPEC_PWR_MODE_PD;
@@ -4718,7 +4754,7 @@ static void run_state_machine(struct tcpm_port *port)
 		/* remove existing capabilities */
 		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
 		port->partner_source_caps = NULL;
-		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
@@ -4735,28 +4771,41 @@ static void run_state_machine(struct tcpm_port *port)
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
+						    PD_T_SENDER_RESPONSE);
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
@@ -4780,7 +4829,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 
 	case FR_SWAP_SEND:
-		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP)) {
+		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP, TCPC_TX_SOP)) {
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
@@ -4800,7 +4849,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
 		tcpm_set_pwr_role(port, TYPEC_SOURCE);
-		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
+		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP)) {
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
@@ -4810,11 +4859,11 @@ static void run_state_machine(struct tcpm_port *port)
 
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
@@ -4856,7 +4905,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 * supply is turned off"
 		 */
 		tcpm_set_pwr_role(port, TYPEC_SINK);
-		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
+		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY, TCPC_TX_SOP)) {
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
@@ -4903,17 +4952,17 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -4932,14 +4981,34 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -4975,7 +5044,7 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case GET_STATUS_SEND:
-		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
+		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS, TCPC_TX_SOP);
 		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
 			       PD_T_SENDER_RESPONSE);
 		break;
@@ -4983,7 +5052,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case GET_PPS_STATUS_SEND:
-		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
+		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS, TCPC_TX_SOP);
 		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
 			       PD_T_SENDER_RESPONSE);
 		break;
@@ -4991,7 +5060,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case GET_SINK_CAP:
-		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP);
+		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP, TCPC_TX_SOP);
 		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RESPONSE);
 		break;
 	case GET_SINK_CAP_TIMEOUT:
@@ -5031,7 +5100,7 @@ static void run_state_machine(struct tcpm_port *port)
 
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
2.43.0.472.g3155946c3a-goog



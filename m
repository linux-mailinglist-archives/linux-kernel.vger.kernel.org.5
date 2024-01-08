Return-Path: <linux-kernel+bounces-20025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67382785B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1791F23D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899756777;
	Mon,  8 Jan 2024 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgYUeUr+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EF5675D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbedaa77289so2445686276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741406; x=1705346206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1aAYuC2BqdlAhZMX9amHJf0C2KnJp96CrYM+8fPmRU=;
        b=lgYUeUr+jkoiQflV2zRlJme+d7boD0WhKoyX+1cUP/mNIdLPUnAUSOsVpG2i5/MWgr
         oVT5aq1NKyQ/TlOWhDAgnVJ3ifMgVJWULC9jiGXAGAf9EKjxAWJMsbi+zzYIHbHguNzY
         wDrKVJ9/SFy/ya5k9cwGaySoL3wt/cgvfJFRWQlF2nNpy87J/e0mJpNvfWFpPxkvNUDH
         VROVEbmC1S6VtC5rWXlSGi/aNd+CpySLB3coR57TPVx+ciHemAojbV3N17dDI5z0qIoJ
         FpWZdbDv3DRHdIaCzdXn3lKuSdtzVuunzmKRTNbwzTBN57RPnhlkdhnX+K8/7h8DZhlc
         NFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741406; x=1705346206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1aAYuC2BqdlAhZMX9amHJf0C2KnJp96CrYM+8fPmRU=;
        b=n9hRV1kc2BMCws4Gkv0689ZQYFkkFCQWg8opuanthkdmlVftVUvDztSC0FzkpDVw/l
         bspd4gTjrY90eD1Dnz/ivveeOvJfdvMukiA7iKEAvi6bz3WOvhbT4BnFXtMB+F9HLZxa
         UXwZLwoEyQgr9KG8uwQhC6th+YoTBL9qwyP9Y4UPn42mz5nkXtMl18lRzv7iq9fwSO4n
         TOuYB/ziXhcWxt6oR2aG3bC8h8lBE2rYuyNFq+RXhNNy2ivEdoXBCFKzi7VQHZcOs37d
         lsIQD1vRhpzjD08VuW1TDnvv7rb1eUAbz6KCsMecD2xDXUgHerikwbPtp+Qf8lUZKN67
         PiLg==
X-Gm-Message-State: AOJu0YxtxYGCrIM223WYJUeLwFQLsEUN7CKNzeqkWmwO6rcznuYLTiGF
	R9fMEcVZD9QO3DarYH245RdLcaHXDDauYKwH9lO65A==
X-Google-Smtp-Source: AGHT+IH1sORi4WDvSKneGalaBFqTuk9XLWv8umodlosZb82gjdjxP79P7uYA8f1pKM5SssOgD/7GaHFptikL9vE=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:d616:0:b0:dbd:3ccf:31e4 with SMTP id
 n22-20020a25d616000000b00dbd3ccf31e4mr73844ybg.2.1704741406073; Mon, 08 Jan
 2024 11:16:46 -0800 (PST)
Date: Mon,  8 Jan 2024 19:16:22 +0000
In-Reply-To: <20240108191620.987785-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108191620.987785-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4856; i=rdbabiera@google.com;
 h=from:subject; bh=uVQYc5B6QgFBFc2IJXXGnnh5LigcI8G8edyIRV6rpWM=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlzvDi2pX/PPjKl+uBu+TOzYowm1jbe/jXb/cnnlz/vb
 srwnsS6vqOUhUGMg0FWTJFF1z/P4MaV1C1zOGuMYeawMoEMYeDiFICJrIhhZFh0yk6HKe5W+cEZ
 04OyVBlD2W5oWc1++3mnz6TfGswR+j8Y/mdMi/K7tF3Zt+2javSvQpaoNsHy35yZLScfFpbJ/lx 4kwUA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108191620.987785-23-rdbabiera@google.com>
Subject: [PATCH v3 09/12] usb: typec: tcpm: add state machine support for SRC_VDM_IDENTITY_REQUEST
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add SRC_VDM_IDENTITY_REQUEST state which first enters after SRC_STARTUP.
The state sends Discover Identity on SOP' and transitions to
SRC_SEND_CAPABILITIES. SRC_SEND_CAPABILITIES will transition back into
SRC_VDM_IDENTITY_REQUEST instead of retrying immediately.

Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v2:
* Added reviewed-by tag
---
 drivers/usb/typec/tcpm/tcpm.c | 49 ++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a870fbc6bc35..1ce525c8f97c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -146,7 +146,9 @@
 	S(PORT_RESET_WAIT_OFF),			\
 						\
 	S(AMS_START),				\
-	S(CHUNK_NOT_SUPP)
+	S(CHUNK_NOT_SUPP),			\
+						\
+	S(SRC_VDM_IDENTITY_REQUEST)
 
 #define FOREACH_AMS(S)				\
 	S(NONE_AMS),				\
@@ -1963,6 +1965,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 					ret = tcpm_ams_start(port, VCONN_SWAP);
 					if (!ret)
 						return 0;
+					/* Cannot perform Vconn swap */
 					port->upcoming_state = INVALID_STATE;
 					port->send_discover_prime = false;
 				}
@@ -1994,6 +1997,16 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 				 * the svdm_version for the cable moving forward.
 				 */
 				svdm_consume_identity_sop_prime(port, p, cnt);
+
+				/*
+				 * If received in SRC_VDM_IDENTITY_REQUEST, continue
+				 * to SRC_SEND_CAPABILITIES
+				 */
+				if (port->state == SRC_VDM_IDENTITY_REQUEST) {
+					tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+					return 0;
+				}
+
 				*response_tx_sop_type = TCPC_TX_SOP;
 				response[0] = VDO(USB_SID_PD, 1,
 						  typec_get_negotiated_svdm_version(typec),
@@ -2288,7 +2301,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		 * if there's traffic or we're not in PDO ready state don't send
 		 * a VDM.
 		 */
-		if (port->state != SRC_READY && port->state != SNK_READY) {
+		if (port->state != SRC_READY && port->state != SNK_READY &&
+		    port->state != SRC_VDM_IDENTITY_REQUEST) {
 			port->vdm_sm_running = false;
 			break;
 		}
@@ -2364,13 +2378,22 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 			tcpm_ams_finish(port);
 		break;
 	case VDM_STATE_ERR_SEND:
+		/*
+		 * When sending Discover Identity to SOP' before establishing an
+		 * explicit contract, do not retry. Instead, weave sending
+		 * Source_Capabilities over SOP and Discover Identity over SOP'.
+		 */
+		if (port->state == SRC_VDM_IDENTITY_REQUEST) {
+			tcpm_ams_finish(port);
+			port->vdm_state = VDM_STATE_DONE;
+			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
 		/*
 		 * A partner which does not support USB PD will not reply,
 		 * so this is not a fatal error. At the same time, some
 		 * devices may not return GoodCRC under some circumstances,
 		 * so we need to retry.
 		 */
-		if (port->vdm_retries < 3) {
+		} else if (port->vdm_retries < 3) {
 			tcpm_log(port, "VDM Tx error, retry");
 			port->vdm_retries++;
 			port->vdm_state = VDM_STATE_READY;
@@ -4478,8 +4501,12 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		ret = tcpm_pd_send_source_caps(port);
 		if (ret < 0) {
-			tcpm_set_state(port, SRC_SEND_CAPABILITIES,
-				       PD_T_SEND_SOURCE_CAP);
+			if (tcpm_can_communicate_sop_prime(port) &&
+			    IS_ERR_OR_NULL(port->cable))
+				tcpm_set_state(port, SRC_VDM_IDENTITY_REQUEST, 0);
+			else
+				tcpm_set_state(port, SRC_SEND_CAPABILITIES,
+					       PD_T_SEND_SOURCE_CAP);
 		} else {
 			/*
 			 * Per standard, we should clear the reset counter here.
@@ -5395,6 +5422,15 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP, TCPC_TX_SOP);
 		tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
 		break;
+
+	/* Cable states */
+	case SRC_VDM_IDENTITY_REQUEST:
+		port->send_discover_prime = true;
+		port->tx_sop_type = TCPC_TX_SOP_PRIME;
+		mod_send_discover_delayed_work(port, 0);
+		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		break;
+
 	default:
 		WARN(1, "Unexpected port state %d\n", port->state);
 		break;
@@ -6120,7 +6156,8 @@ static void tcpm_send_discover_work(struct kthread_work *work)
 	}
 
 	/* Retry if the port is not idle */
-	if ((port->state != SRC_READY && port->state != SNK_READY) || port->vdm_sm_running) {
+	if ((port->state != SRC_READY && port->state != SNK_READY &&
+	     port->state != SRC_VDM_IDENTITY_REQUEST) || port->vdm_sm_running) {
 		mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_MS);
 		goto unlock;
 	}
-- 
2.43.0.472.g3155946c3a-goog



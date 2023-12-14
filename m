Return-Path: <linux-kernel+bounces-232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54BC813E16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BC283AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F082DB69;
	Thu, 14 Dec 2023 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3D7xUui"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0481836
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbcd721b366so48481276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595354; x=1703200154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HXrlWZscexKPeTLHRr86+b+RQKQQ4cvNdnz5vm9wxE=;
        b=u3D7xUuiFiV6hOzjLU2CBhQBOfeH1dfnOXyUeqWhfdRIqS2zAoB+mS4XJxFnHU5mPF
         RcVay/sKIEMgtSRcCUUnsizFvAziyhgUh4lJXT1ntNTIXP4wOZRfo9CUBsY1y11WElnk
         wfFRAXdAVoGJwTeCKwApt2McAqAXbJ5BV6kURAzlgSmP4OIefAZ65RLbMq2jf3MIG69f
         4qOgqEWifBl3ufFkg9Ueap08iUgGWyjd2A3qfDoFk255FSZJ7XYj/UEBtkH4OXFsuVpy
         JmwqXyjZcIBKqcVgXky7dlVM3Z+TjCdnJi1JbWa7ua2bVuy141JZ3H2n76JjQzL6+NHo
         qLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595354; x=1703200154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HXrlWZscexKPeTLHRr86+b+RQKQQ4cvNdnz5vm9wxE=;
        b=S6IWb1hIqQhmKlTe1iZuK+OPOewEYQNH0jbWLWBOK2ghvPNyyhzPadg3n3P78NDMhg
         hMyYQ2aGNEJPWF8/7gbJH72vLzX2R7dsv/A6AiG1rBSu3AgSvXPmYpia534BUmmAJBBa
         mLLlLOEl7Xgenxs9bcKGR0aU7+IVMxDE/lHy162If2oTFsVuE02kFjCSOHNgkLLE2Gx3
         pVKBijD4liYz7K6UOz9cUN/w2D6kqRngpnmAcUNlWxMd8ksbSy2st0EpFSPNHADBRJfN
         2VQHOlqyDOD0kgj/VwIYOd8/1NbgxKojYitkTg7O/mdNKbueAGiFUAvXi6KnKDmNycGm
         mQvA==
X-Gm-Message-State: AOJu0Yw1jiUpcrhlKzTYPC1iOhwW9Ij0suF4A02BqyboKLc6fq+bz4D3
	WHIn+dCc9bTx+2TR9w2MYC72wFl3qStJdmY=
X-Google-Smtp-Source: AGHT+IHKtbYPFuYPB36Y0v8zQcpiR+iJPn9hWzlwQdxkti5rxMhjKUbRGADbqz3nRhSeM6cT7MMl46XvWWbAOl8=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6902:14d:b0:db5:3aaf:5207 with SMTP
 id p13-20020a056902014d00b00db53aaf5207mr188009ybh.3.1702595354648; Thu, 14
 Dec 2023 15:09:14 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:53 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4743; i=rdbabiera@google.com;
 h=from:subject; bh=p/huEJEwFe0FjS6s+hxnnNjS+wXsIFC6E4ZBM65wOsI=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3WxW8a+jDwgy8HN8uTM7tMDm0N/PG1K8OI5pBc2Y1
 fzVlWNRRykLgxgHg6yYIouuf57BjSupW+Zw1hjDzGFlAhnCwMUpABO5JMzI8Dv/1eOjhuWty2Ym
 vjuxVXHWy4mC99tuT34mUOBRf7Hvvi/DX2HPCw9SMrhm+/z/Me2h+Pcfu+q835qEzRVY1jpNfJt jFQcA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-23-rdbabiera@google.com>
Subject: [PATCH v2 09/12] usb: typec: tcpm: add state machine support for SRC_VDM_IDENTITY_REQUEST
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
---
 drivers/usb/typec/tcpm/tcpm.c | 49 ++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5924e359e14d..e21bc2eea3fc 100644
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
@@ -1956,6 +1958,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 					ret = tcpm_ams_start(port, VCONN_SWAP);
 					if (!ret)
 						return 0;
+					/* Cannot perform Vconn swap */
 					port->upcoming_state = INVALID_STATE;
 					port->send_discover_prime = false;
 				}
@@ -1987,6 +1990,16 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
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
@@ -2281,7 +2294,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		 * if there's traffic or we're not in PDO ready state don't send
 		 * a VDM.
 		 */
-		if (port->state != SRC_READY && port->state != SNK_READY) {
+		if (port->state != SRC_READY && port->state != SNK_READY &&
+		    port->state != SRC_VDM_IDENTITY_REQUEST) {
 			port->vdm_sm_running = false;
 			break;
 		}
@@ -2357,13 +2371,22 @@ static void vdm_run_state_machine(struct tcpm_port *port)
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
@@ -4477,8 +4500,12 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -5393,6 +5420,15 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -6118,7 +6154,8 @@ static void tcpm_send_discover_work(struct kthread_work *work)
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



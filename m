Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25AB80847A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378676AbjLGJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjLGJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:08:14 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA777D5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:08:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3a1e5f8d6so6649467b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701940095; x=1702544895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XWVfbECKkYVkmbHjWZO+h6sR43SxXC7QmqywYAISO0=;
        b=zzRN7Acl4h7bJrdhOhfPFbht2ZvXXbBUeEEqBKCXHacasICpHsu2PoqNmRnzyLzUl2
         nLyh7Zu0D1Tu6LHhAaKiSqveacJQCSkxcLYVDl4RWTLUit0mJejy2nL2Fs1Bae1aYHKQ
         v2e6tI8Ugj5snuNgQa+aTgjgocsdV8iZGc5Oiw7XckPFZXqDA3bPcNqIdf5Lk5A8PDkn
         XaHvEBYpaUo2FOcdeXTVpZfk1jGmnEdmo0i37w/91gL2pzz/8yED7lQfpejnGTl+1Rk1
         TSYvWq11LLp1yVrvbDX7BiqjKaEAjMxOFfYH0yUTkadllGObPnyX5u1uaRhXC7wGGvjR
         04xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940095; x=1702544895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XWVfbECKkYVkmbHjWZO+h6sR43SxXC7QmqywYAISO0=;
        b=DqkAHnzD89howh1kPHkyG7xbMpEmNrxtdIZ+gdERp5K/ESiwlgZNadV/NXNsuE0GCY
         2RTWvjGA3gk6KejzmfBI1vSC/Nu1yV9X57fWfWy2kuhsmtV9fBYaIYjwRaGvrDgn2lWb
         tcDB6rsLnEla+LB64Vh7oOQSAbSziTGkDQYy+HONiCKToYinxa4QxYoWCciO/5QPZN/v
         rfsiNn9Ie+5YgTHXRWFWpFFdxdej5nt33eHpXzF9YN+3PVD6XkXzp1dhQ63hfd8VPNNO
         aZ2KKCoUIljmPG2N2Ua4zK40GcN44fuwseyJgIimRqvcbLYF88ub8Q+PIFm6B4b96Y8A
         XZyA==
X-Gm-Message-State: AOJu0Yzvh/sTVyZmMSZrnxEMTaTO0xjlDvLrFNDNUbqb/tHrUHizOvT3
        PR8R8UIKk5eqpooKsN8iD4H93uFDVQAT+N8=
X-Google-Smtp-Source: AGHT+IF6/n+XCgXEAd+gDT11AwSGUccx/1U0K8Jdi+mE1mBuUrtIEK2jbtHRYfxy+4WA6vTqloGig2LgrWIARtI=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:690c:fcd:b0:5d9:712e:202b with SMTP
 id dg13-20020a05690c0fcd00b005d9712e202bmr39599ywb.6.1701940095023; Thu, 07
 Dec 2023 01:08:15 -0800 (PST)
Date:   Thu,  7 Dec 2023 09:07:41 +0000
In-Reply-To: <20231207090738.15721-12-rdbabiera@google.com>
Mime-Version: 1.0
References: <20231207090738.15721-12-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13047; i=rdbabiera@google.com;
 h=from:subject; bh=LXtNBwuIotDleeOrfFY5zqTZHszmGVHgznxqotaxm8Q=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmF3XHSjD4lRgGpK8SntNww1/8+12zHv3PtGs+Wbyxbf
 MHsguy8jlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACaSncTwh3+1zpGz1fI1i3ee
 kLzV2uhpmNs4V/sAh3n70RU17/9X2TH8s3+wzGKLe5Rvg+EPMd/kbE92vp9POkVCExv1ezwWsdr wAwA=
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207090738.15721-22-rdbabiera@google.com>
Subject: [PATCH v1 10/10] usb: typec: altmodes/displayport: add SOP' support
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

Implement active cable VDM support for SOP' according to the DisplayPort
Alt Mode 2.0 specification.

When probing the DisplayPort driver, the state machine will transition to
Enter Mode on SOP' if an active cable altmode is detected. The SVDM flow
is as followed:
    (1) Enter Mode     SOP'
    (2) Enter Mode     SOP
    (3) Status Update  SOP
    (4) Configure      SOP'
    (5) Configure      SOP

Status Update on SOP' after Enter Mode is optional and not implemented for
now. When exiting the alt mode, send Exit Mode over SOP' after SOP.

Should an altmode vdm fail on SOP', the DisplayPort driver will drop its
reference to the plug and attempt to continue in SOP operation.

Add new dp_state enums DP_STATE_ENTER_PRIME, DP_STATE_CONFIGURE_PRIME, and
DP_STATE_EXIT_PRIME. dp_altmode adds typec_displayport_data for the cable
plug to store the plug configuration and adds a typec_altmode reference
for the cable plug.

dp_altmode_configure takes the cable pin assignment capabilities into
account when deciding on pin configuration.

Received Exit Mode ACKs are handled by a new dp_exit_mode_handler for line
count restraints when accounting for SOP* transmit type.

dp_altmode_activate now attempts to enter on SOP' if applicable, and will
attempt to enter on SOP if that fails.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/altmodes/displayport.c | 166 +++++++++++++++++++----
 1 file changed, 139 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 5ed470069c3e..583f99338710 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -50,13 +50,17 @@ enum {
 enum dp_state {
 	DP_STATE_IDLE,
 	DP_STATE_ENTER,
+	DP_STATE_ENTER_PRIME,
 	DP_STATE_UPDATE,
 	DP_STATE_CONFIGURE,
+	DP_STATE_CONFIGURE_PRIME,
 	DP_STATE_EXIT,
+	DP_STATE_EXIT_PRIME,
 };
 
 struct dp_altmode {
 	struct typec_displayport_data data;
+	struct typec_displayport_data data_prime;
 
 	enum dp_state state;
 	bool hpd;
@@ -67,6 +71,7 @@ struct dp_altmode {
 	struct typec_altmode *alt;
 	const struct typec_altmode *port;
 	struct fwnode_handle *connector_fwnode;
+	struct typec_altmode *plug_prime;
 };
 
 static int dp_altmode_notify(struct dp_altmode *dp)
@@ -99,12 +104,18 @@ static int dp_altmode_configure(struct dp_altmode *dp, u8 con)
 		conf |= DP_CONF_UFP_U_AS_DFP_D;
 		pin_assign = DP_CAP_UFP_D_PIN_ASSIGN(dp->alt->vdo) &
 			     DP_CAP_DFP_D_PIN_ASSIGN(dp->port->vdo);
+		/* Account for active cable capabilities */
+		if (dp->plug_prime)
+			pin_assign &= DP_CAP_DFP_D_PIN_ASSIGN(dp->plug_prime->vdo);
 		break;
 	case DP_STATUS_CON_UFP_D:
 	case DP_STATUS_CON_BOTH: /* NOTE: First acting as DP source */
 		conf |= DP_CONF_UFP_U_AS_UFP_D;
 		pin_assign = DP_CAP_PIN_ASSIGN_UFP_D(dp->alt->vdo) &
-				 DP_CAP_PIN_ASSIGN_DFP_D(dp->port->vdo);
+			     DP_CAP_PIN_ASSIGN_DFP_D(dp->port->vdo);
+		/* Account for active cable capabilities */
+		if (dp->plug_prime)
+			pin_assign &= DP_CAP_UFP_D_PIN_ASSIGN(dp->plug_prime->vdo);
 		break;
 	default:
 		break;
@@ -130,6 +141,8 @@ static int dp_altmode_configure(struct dp_altmode *dp, u8 con)
 	}
 
 	dp->data.conf = conf;
+	if (dp->plug_prime)
+		dp->data_prime.conf = conf;
 
 	return 0;
 }
@@ -143,13 +156,17 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 
 	if (configured && (dp->data.status & DP_STATUS_SWITCH_TO_USB)) {
 		dp->data.conf = 0;
-		dp->state = DP_STATE_CONFIGURE;
+		dp->data_prime.conf = 0;
+		dp->state = dp->plug_prime ? DP_STATE_CONFIGURE_PRIME :
+					     DP_STATE_CONFIGURE;
 	} else if (dp->data.status & DP_STATUS_EXIT_DP_MODE) {
 		dp->state = DP_STATE_EXIT;
+	/* Partner is connected but not configured */
 	} else if (!(con & DP_CONF_CURRENTLY(dp->data.conf))) {
 		ret = dp_altmode_configure(dp, con);
 		if (!ret) {
-			dp->state = DP_STATE_CONFIGURE;
+			dp->state = dp->plug_prime ? DP_STATE_CONFIGURE_PRIME :
+						     DP_STATE_CONFIGURE;
 			if (dp->hpd != hpd) {
 				dp->hpd = hpd;
 				dp->pending_hpd = true;
@@ -185,9 +202,12 @@ static int dp_altmode_configured(struct dp_altmode *dp)
 	return dp_altmode_notify(dp);
 }
 
-static int dp_altmode_configure_vdm(struct dp_altmode *dp, u32 conf)
+static int dp_altmode_configure_vdm(struct dp_altmode *dp, u32 conf,
+				    enum typec_altmode_transmit_type sop_type)
 {
-	int svdm_version = typec_altmode_get_svdm_version(dp->alt);
+	int svdm_version = sop_type == TYPEC_ALTMODE_SOP_PRIME ?
+				       typec_altmode_get_cable_svdm_version(dp->alt) :
+				       typec_altmode_get_svdm_version(dp->alt);
 	u32 header;
 	int ret;
 
@@ -202,7 +222,7 @@ static int dp_altmode_configure_vdm(struct dp_altmode *dp, u32 conf)
 		return ret;
 	}
 
-	ret = typec_altmode_vdm(dp->alt, header, &conf, 2, TYPEC_ALTMODE_SOP);
+	ret = typec_altmode_vdm(dp->alt, header, &conf, 2, sop_type);
 	if (ret)
 		dp_altmode_notify(dp);
 
@@ -223,7 +243,20 @@ static void dp_altmode_work(struct work_struct *work)
 	case DP_STATE_ENTER:
 		ret = typec_altmode_enter(dp->alt, NULL, TYPEC_ALTMODE_SOP);
 		if (ret && ret != -EBUSY)
-			dev_err(&dp->alt->dev, "failed to enter mode\n");
+			dev_err(&dp->alt->dev, "partner failed to enter mode\n");
+		break;
+	case DP_STATE_ENTER_PRIME:
+		ret = typec_altmode_enter(dp->alt, NULL, TYPEC_ALTMODE_SOP_PRIME);
+		/*
+		 * If we fail to enter Alt Mode on SOP', then we should drop the
+		 * plug from the driver and attempt to run the driver without
+		 * it.
+		 */
+		if (ret && ret != -EBUSY) {
+			dev_err(&dp->alt->dev, "plug failed to enter mode\n");
+			dp->state = DP_STATE_ENTER;
+			goto disable_prime;
+		}
 		break;
 	case DP_STATE_UPDATE:
 		svdm_version = typec_altmode_get_svdm_version(dp->alt);
@@ -238,15 +271,30 @@ static void dp_altmode_work(struct work_struct *work)
 				ret);
 		break;
 	case DP_STATE_CONFIGURE:
-		ret = dp_altmode_configure_vdm(dp, dp->data.conf);
+		ret = dp_altmode_configure_vdm(dp, dp->data.conf, TYPEC_ALTMODE_SOP);
 		if (ret)
 			dev_err(&dp->alt->dev,
 				"unable to send Configure command (%d)\n", ret);
 		break;
+	case DP_STATE_CONFIGURE_PRIME:
+		ret = dp_altmode_configure_vdm(dp, dp->data_prime.conf,
+					       TYPEC_ALTMODE_SOP_PRIME);
+		if (ret) {
+			dev_err(&dp->plug_prime->dev,
+				"unable to send Configure command (%d)\n",
+				ret);
+			dp->state = DP_STATE_CONFIGURE;
+			goto disable_prime;
+		}
+		break;
 	case DP_STATE_EXIT:
 		if (typec_altmode_exit(dp->alt, TYPEC_ALTMODE_SOP))
 			dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
 		break;
+	case DP_STATE_EXIT_PRIME:
+		if (typec_altmode_exit(dp->alt, TYPEC_ALTMODE_SOP_PRIME))
+			dev_err(&dp->plug_prime->dev, "Exit Mode Failed!\n");
+		break;
 	default:
 		break;
 	}
@@ -254,6 +302,12 @@ static void dp_altmode_work(struct work_struct *work)
 	dp->state = DP_STATE_IDLE;
 
 	mutex_unlock(&dp->lock);
+	return;
+
+disable_prime:
+	typec_altmode_put_plug(dp->plug_prime);
+	dp->plug_prime = NULL;
+	schedule_work(&dp->work);
 }
 
 static void dp_altmode_attention(struct typec_altmode *alt, const u32 vdo)
@@ -282,6 +336,32 @@ static void dp_altmode_attention(struct typec_altmode *alt, const u32 vdo)
 	mutex_unlock(&dp->lock);
 }
 
+static void dp_exit_mode_handler(struct dp_altmode *dp, enum typec_altmode_transmit_type sop_type)
+{
+	if (sop_type == TYPEC_ALTMODE_SOP) {
+		dp->data.status = 0;
+		dp->data.conf = 0;
+		if (dp->hpd) {
+			drm_connector_oob_hotplug_event(dp->connector_fwnode,
+							connector_status_disconnected);
+			dp->hpd = false;
+			sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
+		}
+		/*
+		 * Delay updating active because driver will not be allowed to send VDMs otherwise
+		 */
+		if (dp->plug_prime)
+			dp->state = DP_STATE_EXIT_PRIME;
+		else
+			typec_altmode_update_active(dp->alt, false);
+	} else if (sop_type == TYPEC_ALTMODE_SOP_PRIME) {
+		dp->data_prime.status = 0;
+		dp->data_prime.conf = 0;
+		typec_altmode_update_active(dp->plug_prime, false);
+		typec_altmode_update_active(dp->alt, false);
+	}
+}
+
 static int dp_altmode_vdm(struct typec_altmode *alt,
 			  const u32 hdr, const u32 *vdo, int count,
 			  enum typec_altmode_transmit_type sop_type)
@@ -302,26 +382,27 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 	case CMDT_RSP_ACK:
 		switch (cmd) {
 		case CMD_ENTER_MODE:
-			typec_altmode_update_active(alt, true);
-			dp->state = DP_STATE_UPDATE;
+			if (sop_type == TYPEC_ALTMODE_SOP_PRIME) {
+				if (dp->plug_prime)
+					typec_altmode_update_active(dp->plug_prime, true);
+				dp->state = DP_STATE_ENTER;
+			} else {
+				typec_altmode_update_active(alt, true);
+				dp->state = DP_STATE_UPDATE;
+			}
 			break;
 		case CMD_EXIT_MODE:
-			typec_altmode_update_active(alt, false);
-			dp->data.status = 0;
-			dp->data.conf = 0;
-			if (dp->hpd) {
-				drm_connector_oob_hotplug_event(dp->connector_fwnode,
-								connector_status_disconnected);
-				dp->hpd = false;
-				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
-			}
+			dp_exit_mode_handler(dp, sop_type);
 			break;
 		case DP_CMD_STATUS_UPDATE:
 			dp->data.status = *vdo;
 			ret = dp_altmode_status_update(dp);
 			break;
 		case DP_CMD_CONFIGURE:
-			ret = dp_altmode_configured(dp);
+			if (sop_type == TYPEC_ALTMODE_SOP_PRIME)
+				dp->state = DP_STATE_CONFIGURE;
+			else
+				ret = dp_altmode_configured(dp);
 			break;
 		default:
 			break;
@@ -330,8 +411,16 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 	case CMDT_RSP_NAK:
 		switch (cmd) {
 		case DP_CMD_CONFIGURE:
-			dp->data.conf = 0;
-			ret = dp_altmode_configured(dp);
+			if (sop_type == TYPEC_ALTMODE_SOP_PRIME) {
+				dp->data_prime.conf = 0;
+				/* Attempt to configure on SOP, drop plug */
+				typec_altmode_put_plug(dp->plug_prime);
+				dp->plug_prime = NULL;
+				dp->state = DP_STATE_CONFIGURE;
+			} else {
+				dp->data.conf = 0;
+				ret = dp_altmode_configured(dp);
+			}
 			break;
 		default:
 			break;
@@ -351,8 +440,23 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 
 static int dp_altmode_activate(struct typec_altmode *alt, int activate)
 {
-	return activate ? typec_altmode_enter(alt, NULL, TYPEC_ALTMODE_SOP) :
-			  typec_altmode_exit(alt, TYPEC_ALTMODE_SOP);
+	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
+	int ret;
+
+	if (activate) {
+		if (dp->plug_prime) {
+			ret = typec_altmode_enter(alt, NULL, TYPEC_ALTMODE_SOP_PRIME);
+			if (ret < 0) {
+				typec_altmode_put_plug(dp->plug_prime);
+				dp->plug_prime = NULL;
+			} else {
+				return ret;
+			}
+		}
+		return typec_altmode_enter(alt, NULL, TYPEC_ALTMODE_SOP);
+	} else {
+		return typec_altmode_exit(alt, TYPEC_ALTMODE_SOP);
+	}
 }
 
 static const struct typec_altmode_ops dp_altmode_ops = {
@@ -400,7 +504,7 @@ configuration_store(struct device *dev, struct device_attribute *attr,
 	conf |= con;
 
 	if (dp->alt->active) {
-		ret = dp_altmode_configure_vdm(dp, conf);
+		ret = dp_altmode_configure_vdm(dp, conf, TYPEC_ALTMODE_SOP);
 		if (ret)
 			goto err_unlock;
 	}
@@ -502,7 +606,7 @@ pin_assignment_store(struct device *dev, struct device_attribute *attr,
 
 	/* Only send Configure command if a configuration has been set */
 	if (dp->alt->active && DP_CONF_CURRENTLY(dp->data.conf)) {
-		ret = dp_altmode_configure_vdm(dp, conf);
+		ret = dp_altmode_configure_vdm(dp, conf, TYPEC_ALTMODE_SOP);
 		if (ret)
 			goto out_unlock;
 	}
@@ -575,6 +679,7 @@ static const struct attribute_group dp_altmode_group = {
 int dp_altmode_probe(struct typec_altmode *alt)
 {
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
+	struct typec_altmode *plug = typec_altmode_get_plug(alt, TYPEC_PLUG_SOP_P);
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
 	int ret;
@@ -604,6 +709,11 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	alt->desc = "DisplayPort";
 	alt->ops = &dp_altmode_ops;
 
+	if (plug)
+		plug->desc = "Displayport";
+
+	dp->plug_prime = plug;
+
 	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
 	if (fwnode_property_present(fwnode, "displayport"))
 		dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
@@ -614,7 +724,8 @@ int dp_altmode_probe(struct typec_altmode *alt)
 
 	typec_altmode_set_drvdata(alt, dp);
 
-	dp->state = DP_STATE_ENTER;
+	dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
+
 	schedule_work(&dp->work);
 
 	return 0;
@@ -627,6 +738,7 @@ void dp_altmode_remove(struct typec_altmode *alt)
 
 	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
+	typec_altmode_put_plug(dp->plug_prime);
 
 	if (dp->connector_fwnode) {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-- 
2.43.0.rc2.451.g8631bc7472-goog


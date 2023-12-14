Return-Path: <linux-kernel+bounces-234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C3813E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B95E1C21EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F106BB4B;
	Thu, 14 Dec 2023 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJqDBKEe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBE2DB81
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ca1c740ff4so88080a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595359; x=1703200159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IQ7Offe19G51JXB0kOzKEmzBAE/jVivsxuYkbsoqQw=;
        b=zJqDBKEeCUS3TBt+tafjQ03cXB5jmqcco0SmvOliWZHJUq2qo4c9lluElRgpJWVg9n
         nd61V/MPu2aixGp3uil8bcv3enxdEpJy6ZqeLx7pvco3w0nxMJfHkVQCUOR30sARJtfp
         kGJ27bs38niEo1P4o4Us+KLpJZwZvX6aPIMBCCMAhsuoUuar7gDPMqqw20tTutiJi9vM
         UobVrm8O82lVLQydyj5l+JxsjLQeRh67E+H5kxwkwE/bIoY1aAE9yCJtCT3J5W8fO+Oz
         N6xGm9pfgVIrSgBvVYINcfVrnPIzhwxbFHz2C8sWO/Tknhsj3l0Ae2OQak1M5jYUS9N2
         5eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595359; x=1703200159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IQ7Offe19G51JXB0kOzKEmzBAE/jVivsxuYkbsoqQw=;
        b=dWBn9A41uL4yaA5Hr496JahWAQItuh1IOt4GOor6CRpvG39XLhBqXNbEKcLiNEGpQ3
         uvJBlVd7n+kI01tww+95yvPS7WKlqRS+f6Oa3HTkXcP05pAcp5c0nhVT0bHPdkmHQft4
         bqdE0KsmmBiEP2SximbCMcNCxM6J+3mOYK7jqts6OFHagCeVtKp1jiWTslbNClDMV/vf
         jmTS2tbT9FKOdnlyQY7E5DmOARl6kEkrfrL8vDNSvI4DQkv0zGkcZtgiq8PCv4pvkuB3
         cloKXbsnOOK3AJ3U2KqY9TbgYK1xexoHpZn4NtIUjrwhf2MwikGvmAs9C7Rx414AKk+x
         mw4g==
X-Gm-Message-State: AOJu0Ywy0fRSxPlByawDKMXNjBSqkwJEJkuUzFNI2z2uFz6MusVqbD2F
	O4adZFov5FeKs/AOJDPdj2EG8cDIl3ZXmHA=
X-Google-Smtp-Source: AGHT+IEdTztbRYAWS7Gmu2NsVp3Frt00PuoI/s9hnmABgDqVG5/xKDQOz4i0IemB8l6SivjWIpRTbw5p03wcMG8=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6a02:592:b0:5ca:3aff:a2cb with SMTP
 id by18-20020a056a02059200b005ca3affa2cbmr958570pgb.1.1702595359401; Thu, 14
 Dec 2023 15:09:19 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:56 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11211; i=rdbabiera@google.com;
 h=from:subject; bh=2RsnYJUPf/3qls/7oIZN2O+MPD006tAhSP8VVqTiq80=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3ewn804f5N3ta7VNjOeT8h2vFPt7k2Sj7YT6ZdZPE
 7tjsf5ORykLgxgHg6yYIouuf57BjSupW+Zw1hjDzGFlAhnCwMUpABMxWsPIsHzb2cc6z73LT3uk
 /LpcxrG9wP3LvoyrW3TWtYWetlnWz8TIcENY+jWbpWWTRtvE/ut2U7/OV9x5wyOCcUqhb5F7lbs zBwA=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-26-rdbabiera@google.com>
Subject: [PATCH v2 12/12] usb: typec: altmodes/displayport: add SOP' support
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

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
account when deciding on pin configuration. dp_altmode_configure_vdm_cable
sends the configure message on SOP'.

dp_altmode_activate now attempts to enter on SOP' if applicable, and will
attempt to enter on SOP on failure.

dp_cable_altmode_vdm handles VDMs passed to the DisplayPort driver from
the tcpm.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes since v1:
* dp_altmode_configure_vdm no longer handles sop', now handled by
  dp_altmode_configure_vdm_cable
* dp_exit_mode_handler deleted
* dp_altmode_vdm no longer handles sop', now handled by
  dp_cable_altmode_vdm as typec_cable_ops callback assigned to plug_prime
  if it exists.
* driver data registered to plug_prime if applicable.
---
 drivers/usb/typec/altmodes/displayport.c | 161 ++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index f81bec0c7b86..06ea63bc536e 100644
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
 				 DP_CAP_PIN_ASSIGN_DFP_D(dp->port->vdo);
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
@@ -143,7 +156,9 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 
 	if (configured && (dp->data.status & DP_STATUS_SWITCH_TO_USB)) {
 		dp->data.conf = 0;
-		dp->state = DP_STATE_CONFIGURE;
+		dp->data_prime.conf = 0;
+		dp->state = dp->plug_prime ? DP_STATE_CONFIGURE_PRIME :
+					     DP_STATE_CONFIGURE;
 	} else if (dp->data.status & DP_STATUS_EXIT_DP_MODE) {
 		dp->state = DP_STATE_EXIT;
 	} else if (!(con & DP_CONF_CURRENTLY(dp->data.conf))) {
@@ -209,6 +224,19 @@ static int dp_altmode_configure_vdm(struct dp_altmode *dp, u32 conf)
 	return ret;
 }
 
+static int dp_altmode_configure_vdm_cable(struct dp_altmode *dp, u32 conf)
+{
+	int svdm_version = typec_altmode_get_cable_svdm_version(dp->plug_prime);
+	u32 header;
+
+	if (svdm_version < 0)
+		return svdm_version;
+
+	header = DP_HEADER(dp, svdm_version, DP_CMD_CONFIGURE);
+
+	return typec_cable_altmode_vdm(dp->plug_prime, TYPEC_PLUG_SOP_P, header, &conf, 2);
+}
+
 static void dp_altmode_work(struct work_struct *work)
 {
 	struct dp_altmode *dp = container_of(work, struct dp_altmode, work);
@@ -225,6 +253,19 @@ static void dp_altmode_work(struct work_struct *work)
 		if (ret && ret != -EBUSY)
 			dev_err(&dp->alt->dev, "failed to enter mode\n");
 		break;
+	case DP_STATE_ENTER_PRIME:
+		ret = typec_cable_altmode_enter(dp->alt, TYPEC_PLUG_SOP_P, NULL);
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
+		break;
 	case DP_STATE_UPDATE:
 		svdm_version = typec_altmode_get_svdm_version(dp->alt);
 		if (svdm_version < 0)
@@ -243,10 +284,24 @@ static void dp_altmode_work(struct work_struct *work)
 			dev_err(&dp->alt->dev,
 				"unable to send Configure command (%d)\n", ret);
 		break;
+	case DP_STATE_CONFIGURE_PRIME:
+		ret = dp_altmode_configure_vdm_cable(dp, dp->data_prime.conf);
+		if (ret) {
+			dev_err(&dp->plug_prime->dev,
+				"unable to send Configure command (%d)\n",
+				ret);
+			dp->state = DP_STATE_CONFIGURE;
+			goto disable_prime;
+		}
+		break;
 	case DP_STATE_EXIT:
 		if (typec_altmode_exit(dp->alt))
 			dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
 		break;
+	case DP_STATE_EXIT_PRIME:
+		if (typec_cable_altmode_exit(dp->plug_prime, TYPEC_PLUG_SOP_P))
+			dev_err(&dp->plug_prime->dev, "Exit Mode Failed!\n");
+		break;
 	default:
 		break;
 	}
@@ -254,6 +309,12 @@ static void dp_altmode_work(struct work_struct *work)
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
@@ -314,6 +375,8 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 				dp->hpd = false;
 				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 			}
+			if (dp->plug_prime)
+				dp->state = DP_STATE_EXIT_PRIME;
 			break;
 		case DP_CMD_STATUS_UPDATE:
 			dp->data.status = *vdo;
@@ -348,10 +411,84 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 	return ret;
 }
 
+static int dp_cable_altmode_vdm(struct typec_altmode *alt, enum typec_plug_index sop,
+				const u32 hdr, const u32 *vdo, int count)
+{
+	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
+	int cmd_type = PD_VDO_CMDT(hdr);
+	int cmd = PD_VDO_CMD(hdr);
+	int ret = 0;
+
+	mutex_lock(&dp->lock);
+
+	if (dp->state != DP_STATE_IDLE) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	switch (cmd_type) {
+	case CMDT_RSP_ACK:
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			typec_altmode_update_active(dp->plug_prime, true);
+			dp->state = DP_STATE_ENTER;
+			break;
+		case CMD_EXIT_MODE:
+			dp->data_prime.status = 0;
+			dp->data_prime.conf = 0;
+			typec_altmode_update_active(dp->plug_prime, false);
+			break;
+		case DP_CMD_CONFIGURE:
+			dp->state = DP_STATE_CONFIGURE;
+			break;
+		default:
+			break;
+		}
+		break;
+	case CMDT_RSP_NAK:
+		switch (cmd) {
+		case DP_CMD_CONFIGURE:
+			dp->data_prime.conf = 0;
+			/* Attempt to configure on SOP, drop plug */
+			typec_altmode_put_plug(dp->plug_prime);
+			dp->plug_prime = NULL;
+			dp->state = DP_STATE_CONFIGURE;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (dp->state != DP_STATE_IDLE)
+		schedule_work(&dp->work);
+
+err_unlock:
+	mutex_unlock(&dp->lock);
+	return ret;
+}
+
 static int dp_altmode_activate(struct typec_altmode *alt, int activate)
 {
-	return activate ? typec_altmode_enter(alt, NULL) :
-			  typec_altmode_exit(alt);
+	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
+	int ret;
+
+	if (activate) {
+		if (dp->plug_prime) {
+			ret = typec_cable_altmode_enter(alt, TYPEC_PLUG_SOP_P, NULL);
+			if (ret < 0) {
+				typec_altmode_put_plug(dp->plug_prime);
+				dp->plug_prime = NULL;
+			} else {
+				return ret;
+			}
+		}
+		return typec_altmode_enter(alt, NULL);
+	} else {
+		return typec_altmode_exit(alt);
+	}
 }
 
 static const struct typec_altmode_ops dp_altmode_ops = {
@@ -360,6 +497,10 @@ static const struct typec_altmode_ops dp_altmode_ops = {
 	.activate = dp_altmode_activate,
 };
 
+static const struct typec_cable_ops dp_cable_ops = {
+	.vdm = dp_cable_altmode_vdm,
+};
+
 static const char * const configurations[] = {
 	[DP_CONF_USB]	= "USB",
 	[DP_CONF_DFP_D]	= "source",
@@ -501,6 +642,7 @@ pin_assignment_store(struct device *dev, struct device_attribute *attr,
 
 	/* Only send Configure command if a configuration has been set */
 	if (dp->alt->active && DP_CONF_CURRENTLY(dp->data.conf)) {
+		/* todo: send manual configure over SOP'*/
 		ret = dp_altmode_configure_vdm(dp, conf);
 		if (ret)
 			goto out_unlock;
@@ -574,6 +716,7 @@ static const struct attribute_group dp_altmode_group = {
 int dp_altmode_probe(struct typec_altmode *alt)
 {
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
+	struct typec_altmode *plug = typec_altmode_get_plug(alt, TYPEC_PLUG_SOP_P);
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
 	int ret;
@@ -603,6 +746,13 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	alt->desc = "DisplayPort";
 	alt->ops = &dp_altmode_ops;
 
+	if (plug) {
+		plug->desc = "Displayport";
+		plug->cable_ops = &dp_cable_ops;
+	}
+
+	dp->plug_prime = plug;
+
 	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
 	if (fwnode_property_present(fwnode, "displayport"))
 		dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
@@ -612,8 +762,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
 		dp->connector_fwnode = NULL;
 
 	typec_altmode_set_drvdata(alt, dp);
+	if (plug)
+		typec_altmode_set_drvdata(plug, dp);
 
-	dp->state = DP_STATE_ENTER;
+	dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
 	schedule_work(&dp->work);
 
 	return 0;
@@ -626,6 +778,7 @@ void dp_altmode_remove(struct typec_altmode *alt)
 
 	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
+	typec_altmode_put_plug(dp->plug_prime);
 
 	if (dp->connector_fwnode) {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-- 
2.43.0.472.g3155946c3a-goog



Return-Path: <linux-kernel+bounces-87692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759286D7C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA392285562
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843A7C09C;
	Thu, 29 Feb 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKHhaNoN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E49200BA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249289; cv=none; b=BiKR/EYZxfJGzHD5Kjwa+EgMjYxJ8pMB9vHZLcqOMjvjwk2pziUzKTwoespCrg6xKudLmm7hKI6g3PIPYfErAxgxI0ez6eoC+ev/5YpMKmLWcXKd9kWI39PxwA1K59RDnLAVTKGp3TkjNuuHKyWp10NKayG2H2J26Cd5Mf8H2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249289; c=relaxed/simple;
	bh=edGmOSoQMVD2u38yE1yMurpWdztdrOqPIpxnPb19KFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C93tQe+3juS6nwtbEpqBKLyoDMyrCHOrk54NnTiVi4571L+UCwDrZ+Qqwkiw31aqetouYSpa4UE1sgTlv0Dp77s6vxQSSZis2O0t7vIDkovWtgnXpGzUFmw+8XnWNYetpq95VBQFpDWJx2Yw6Q2E+TVm1utb4YO8+m2nyR+EN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKHhaNoN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso2686397276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709249287; x=1709854087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6EX1C7KAOXRIXYaHKuIEyWBFy8Yv7CZZQhI1NgZXIY=;
        b=QKHhaNoNBIVuHv3fFcCZTBkVmtu21Be0hACblqvl8Q/wWRLOvEXyDq9dT74H9LujDb
         H7tukz+LhAM/516ZnHSgGVM8LAsGqff9oc49wyX2NoM6RNg/FzHGbBdASMUT4Tu1lhJm
         7Nhg9F/1prpQyI5I/ODQlrzw8erCKlktLHqmOuxE8jr+OyrJ+Ko5x5egTh9PmmzwYAiV
         EmC0v+rg5nojEwFwCatokme8QNYCr26Qc8oHOQ5MWb5lX4Z9LpYXBEIEa6aus0qy2RDW
         k2gBX+e0/FDVM4AEuUUNFFJVVlsCydmdURKaOOlAoNOqS4xBQ4E/1ahBELR4+DKiqO7M
         /bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249287; x=1709854087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6EX1C7KAOXRIXYaHKuIEyWBFy8Yv7CZZQhI1NgZXIY=;
        b=hfHJofKEHqrzDBiDaQs9bzgEt7gR46L91aCUXS18rMMxaB5jxwn7zzo3nFLJSUEH2y
         W0b/K9YcPtIhqXR+PrIboWFKt8wWjIOMHDbVF3jJ85FwgsJfmhNABaePY3iXG35YfULJ
         pqU/r1u0cpV1QM4B5ar0XpZDKKpIhQVBMHu+h9LJDBtYyN+2ypXRZGChvcOXlzUmbLJE
         NxMx5/x+7SH1p2VRnrswJd/6GkFxKdRd8N20kTc+JSSsUHavdA7HkqE5Dd8wLjx+XQTe
         5b3yDg9IdvXJ8CC/kaHXdRu3Dyg12YzWBlisU9miBBaBBHCSBmqccIBW9qjOYVYCKjJj
         OE6A==
X-Forwarded-Encrypted: i=1; AJvYcCWnYWLlGU1MaHopzPzZntv4HVodQDvPZ11+iXKxnZxOsj8sbJoG4BszQEaNrYZX4dYvongtA0/EMGw4RaX2rPspIg/sK7JpQg2k9661
X-Gm-Message-State: AOJu0Yyenrr+VKrPUWDUpSwpWBujGXLwZii0KKOSqGsBMaCt5wudTYdR
	haZcWRfEpvTKyqtgnPT6fNjx8RlNHI2QvWjz9JXTvgb21pmfexd1KkPsz4eET8cezYSUXVIB1FI
	2mg==
X-Google-Smtp-Source: AGHT+IEOZx8tXzIZbP2c+lNWxaVusTiE5AUhdazQWPrQEPMUK8kGR9/Q9BK0yVwzk//NIvAa+ncmUrSCJ1A=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:d42:b0:dc6:e5d3:5f03 with SMTP id
 cs2-20020a0569020d4200b00dc6e5d35f03mr872838ybb.4.1709249286897; Thu, 29 Feb
 2024 15:28:06 -0800 (PST)
Date: Thu, 29 Feb 2024 23:26:24 +0000
In-Reply-To: <20240229232625.3944115-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229232625.3944115-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229232625.3944115-4-jthies@google.com>
Subject: [PATCH v3 3/4] usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Register SOP and SOP' Discover Identity responses with the USB Type-C
Connector Class as partner and cable identities, respectively. Discover
Identity responses are requested from the PPM using the GET_PD_MESSAGE
UCSI command.

Signed-off-by: Jameson Thies <jthies@google.com>
---
GET_PD_MESSAGE responses from the PPM populate partner and cable
identity in sysfs:
nospike-rev4 /sys/class/typec # ls port0-partner/identity/
cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
product_type_vdo3
nospike-rev4 /sys/class/typec # ls port0-cable/identity/
cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
product_type_vdo3

Changes in v3:
- None.

Changes in v2:
- Re-ordered memset call and null assignment when unregistering partners
and cables.
- Supports registering partner and cable identity with UCSI versions
before v2.0.
- Shortened lines to within 80 characters with the exception of two
error log lines with three indentations.
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.c | 125 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  29 ++++++++
 2 files changed, 154 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7c84687b5d1a3..4088422b33c74 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -646,6 +646,121 @@ static int ucsi_get_src_pdos(struct ucsi_connector *con)
 	return ret;
 }
 
+static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient,
+			      struct usb_pd_identity *id)
+{
+	struct ucsi *ucsi = con->ucsi;
+	struct ucsi_pd_message_disc_id resp = {};
+	u64 command;
+	int ret;
+
+	if (ucsi->version < UCSI_VERSION_2_0) {
+		/*
+		 * Before UCSI v2.0, MESSAGE_IN is 16 bytes which cannot fit
+		 * the 28 byte identity response including the VDM header.
+		 * First request the VDM header, ID Header VDO, Cert Stat VDO
+		 * and Product VDO.
+		 */
+		command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
+		    UCSI_CONNECTOR_NUMBER(con->num);
+		command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+		command |= UCSI_GET_PD_MESSAGE_OFFSET(0);
+		command |= UCSI_GET_PD_MESSAGE_BYTES(0x10);
+		command |= UCSI_GET_PD_MESSAGE_TYPE(
+		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+		ret = ucsi_send_command(ucsi, command, &resp, 0x10);
+		if (ret < 0) {
+			dev_err(ucsi->dev,
+				"UCSI_GET_PD_MESSAGE v1.2 failed first request (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/* Then request Product Type VDO1 through Product Type VDO3. */
+		command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
+		    UCSI_CONNECTOR_NUMBER(con->num);
+		command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+		command |= UCSI_GET_PD_MESSAGE_OFFSET(0x10);
+		command |= UCSI_GET_PD_MESSAGE_BYTES(0xc);
+		command |= UCSI_GET_PD_MESSAGE_TYPE(
+		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+		ret = ucsi_send_command(ucsi, command, &resp.vdo[0], 0xc);
+		if (ret < 0) {
+			dev_err(ucsi->dev,
+				"UCSI_GET_PD_MESSAGE v1.2 failed second request (%d)\n",
+				ret);
+			return ret;
+		}
+	} else {
+		/*
+		 * In UCSI v2.0 and after, MESSAGE_IN is large enough to request
+		 * the large enough to request the full Discover Identity
+		 * response at once.
+		 */
+		command = UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
+		    UCSI_CONNECTOR_NUMBER(con->num);
+		command |= UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
+		/* VDM Header + 6 VDOs (0x1c bytes) without an offset */
+		command |= UCSI_GET_PD_MESSAGE_OFFSET(0);
+		command |= UCSI_GET_PD_MESSAGE_BYTES(0x1c);
+		command |= UCSI_GET_PD_MESSAGE_TYPE(
+		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
+
+		ret = ucsi_send_command(ucsi, command, &resp, sizeof(resp));
+		if (ret < 0) {
+			dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	id->id_header = resp.id_header;
+	id->cert_stat = resp.cert_stat;
+	id->product = resp.product;
+	id->vdo[0] = resp.vdo[0];
+	id->vdo[1] = resp.vdo[1];
+	id->vdo[2] = resp.vdo[2];
+	return 0;
+}
+
+static int ucsi_get_partner_identity(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP,
+				 &con->partner_identity);
+	if (ret < 0)
+		return ret;
+
+	ret = typec_partner_set_identity(con->partner);
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "Failed to set partner identity (%d)\n",
+			ret);
+	}
+
+	return ret;
+}
+
+static int ucsi_get_cable_identity(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_read_identity(con, UCSI_RECIPIENT_SOP_P,
+				 &con->cable_identity);
+	if (ret < 0)
+		return ret;
+
+	ret = typec_cable_set_identity(con->cable);
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "Failed to set cable identity (%d)\n",
+			ret);
+	}
+
+	return ret;
+}
+
 static int ucsi_check_altmodes(struct ucsi_connector *con)
 {
 	int ret, num_partner_am;
@@ -754,6 +869,7 @@ static int ucsi_register_cable(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->cable_identity;
 	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
 			 con->cable_prop.flags);
 	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
@@ -777,6 +893,7 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
 		return;
 
 	typec_unregister_cable(con->cable);
+	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
 	con->cable = NULL;
 }
 
@@ -827,6 +944,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
 		break;
 	}
 
+	desc.identity = &con->partner_identity;
 	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
 	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
 
@@ -855,6 +973,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
 	ucsi_unregister_cable(con);
 	typec_unregister_partner(con->partner);
+	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
 	con->partner = NULL;
 }
 
@@ -975,6 +1094,10 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 	if (ret < 0)
 		return ret;
 
+	ret = ucsi_get_cable_identity(con);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -1019,6 +1142,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
+			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
 			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
@@ -1418,6 +1542,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
 		ucsi_port_psy_changed(con);
+		ucsi_get_partner_identity(con);
 		ucsi_check_cable(con);
 	}
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index f0aabef0b7c64..b89fae82e8ce7 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -106,6 +106,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_GET_CABLE_PROPERTY		0x11
 #define UCSI_GET_CONNECTOR_STATUS	0x12
 #define UCSI_GET_ERROR_STATUS		0x13
+#define UCSI_GET_PD_MESSAGE		0x15
 
 #define UCSI_CONNECTOR_NUMBER(_num_)		((u64)(_num_) << 16)
 #define UCSI_COMMAND(_cmd_)			((_cmd_) & 0xff)
@@ -159,6 +160,18 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_MAX_PDOS				(4)
 #define UCSI_GET_PDOS_SRC_PDOS			((u64)1 << 34)
 
+/* GET_PD_MESSAGE command bits */
+#define UCSI_GET_PD_MESSAGE_RECIPIENT(_r_)	((u64)(_r_) << 23)
+#define UCSI_GET_PD_MESSAGE_OFFSET(_r_)		((u64)(_r_) << 26)
+#define UCSI_GET_PD_MESSAGE_BYTES(_r_)		((u64)(_r_) << 34)
+#define UCSI_GET_PD_MESSAGE_TYPE(_r_)		((u64)(_r_) << 42)
+#define   UCSI_GET_PD_MESSAGE_TYPE_SNK_CAP_EXT	0
+#define   UCSI_GET_PD_MESSAGE_TYPE_SRC_CAP_EXT	1
+#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_CAP	2
+#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_STAT	3
+#define   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY	4
+#define   UCSI_GET_PD_MESSAGE_TYPE_REVISION	5
+
 /* -------------------------------------------------------------------------- */
 
 /* Error information returned by PPM in response to GET_ERROR_STATUS command. */
@@ -338,6 +351,18 @@ struct ucsi_connector_status {
 	((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
 } __packed;
 
+/*
+ * Data structure filled by PPM in response to GET_PD_MESSAGE command with the
+ * Response Message Type set to Discover Identity Response.
+ */
+struct ucsi_pd_message_disc_id {
+	u32 vdm_header;
+	u32 id_header;
+	u32 cert_stat;
+	u32 product;
+	u32 vdo[3];
+} __packed;
+
 /* -------------------------------------------------------------------------- */
 
 struct ucsi_debugfs_entry {
@@ -428,6 +453,10 @@ struct ucsi_connector {
 	struct usb_power_delivery_capabilities *partner_sink_caps;
 
 	struct usb_role_switch *usb_role_sw;
+
+	/* USB PD identity */
+	struct usb_pd_identity partner_identity;
+	struct usb_pd_identity cable_identity;
 };
 
 int ucsi_send_command(struct ucsi *ucsi, u64 command,
-- 
2.44.0.rc1.240.g4c46232300-goog



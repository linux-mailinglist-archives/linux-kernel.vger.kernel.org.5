Return-Path: <linux-kernel+bounces-2154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33FC8158B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033011C24AF5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCFF199B2;
	Sat, 16 Dec 2023 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOI8CBGE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1418ECA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e526de698cso6283817b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702723604; x=1703328404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCoql+eGgqszKLUR0lOuaVmFyiaIoGW5HR3BXObH2MU=;
        b=eOI8CBGEPlcQ1SguA46ESGBwoczrbCkp3yaF0QrGrQzVctS7Pc2jD7sWyOM4ytUZA2
         yCnu0ekBt7W7YRfPmu/eZc7We36ID71YhctFBYrNUY1at6+7Jrc1wHC2VeOj0q70LZXh
         Vl0IuCu4bbUlDuMcBpzY56W4YMFgmUx++N1wk7tvhLj3bGWRq0tU2twVTAACc4NRHg6G
         7mKhAYeDB7eSImpbbPXKa6FzUtuvh4VOUiMbSda0hAdNAkpGe4CNsgsHJkvNevSKxOYb
         UUzVkEf4uvsR508uQXbHICvQqcbjT4eisrstKdO1oAicJT4yuJgRxc2hwpYj6GPNGoU9
         GFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702723604; x=1703328404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCoql+eGgqszKLUR0lOuaVmFyiaIoGW5HR3BXObH2MU=;
        b=EJa2Bud7KA2lx5+RmafGUaSg2lD5GWqDlL8Z91GG7x9Y99HLEo2i/ANX1cONPsZpvU
         xrzxk1oe6l2pXVtLqbVAsd9xy6r242qWmpJ0ZolYZGLf6rPqkk08N6bViA9NEyzBSCrO
         jfytMsG+Zq/w8zcM7MlbbMurvPzxO7Hc9FNptCSFits/uDRiTkQk0Dnk4rmkevDJIIuN
         ClHTAs+BqE24C6Qtmd48vjQXA4ccVNrUNY8VeEz9tBtKYSzoFJPFBHR1i11VECEtMD5z
         7Ch5E2AXsT00oYuoKTsJsjLwS8NDL3P0ffdrFiJNfiIGIEa77wv5yTYpWDDLKQVrnzfs
         0AHQ==
X-Gm-Message-State: AOJu0YwydPZkgmbqOwAnHckzNvcdk9sAc6DW80EItHlthK7+Bo+5pdTR
	CXPrRjNcHocpW+X9RpgZhv9HZIbJld5E
X-Google-Smtp-Source: AGHT+IH2IUz70Wba/OhEPBUZUqyJtWA7/3Z3ykUcqk08upTXIul2SNIz3+6ih0AJKnvLRMIU4yuqDbw6Ae3Y
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:dd61:6f37:fe44:8be9])
 (user=kyletso job=sendgmr) by 2002:a05:690c:3387:b0:5d3:84d4:eb35 with SMTP
 id fl7-20020a05690c338700b005d384d4eb35mr603173ywb.3.1702723604269; Sat, 16
 Dec 2023 02:46:44 -0800 (PST)
Date: Sat, 16 Dec 2023 18:46:30 +0800
In-Reply-To: <20231216104630.2720818-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231216104630.2720818-1-kyletso@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231216104630.2720818-3-kyletso@google.com>
Subject: [PATCH v6 2/2] usb: typec: tcpm: Support multiple capabilities
From: Kyle Tso <kyletso@google.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor tcpm_fw_get_caps to support the multiple pd capabilities got
from fwnode. For backward compatibility, the original single capability
is still applicable. The fetched data is stored in the newly defined
structure "pd_data" and there is an array "pd_list" to store the
pointers to them. A dedicated array "pds" is used to store the handles
of the registered usb_power_delivery instances.

Also implement the .pd_get and .pd_set ops which are introduced in
commit a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports
and partners"). Once the .pd_set is called, the current capability will
be updated and state machine will re-negotiate the power contract if
possible.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
v5 -> v6:
 - Removed the function tcpm_fw_get_properties
 - Merged it to tcpm_fw_get_caps

 drivers/usb/typec/tcpm/tcpm.c | 387 ++++++++++++++++++++++++++--------
 1 file changed, 298 insertions(+), 89 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ff67553b6932..e11d680fd8b7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -297,6 +297,15 @@ struct pd_pps_data {
 	bool active;
 };
 
+struct pd_data {
+	struct usb_power_delivery *pd;
+	struct usb_power_delivery_capabilities *source_cap;
+	struct usb_power_delivery_capabilities_desc source_desc;
+	struct usb_power_delivery_capabilities *sink_cap;
+	struct usb_power_delivery_capabilities_desc sink_desc;
+	unsigned int operating_snk_mw;
+};
+
 struct tcpm_port {
 	struct device *dev;
 
@@ -398,12 +407,14 @@ struct tcpm_port {
 	unsigned int rx_msgid;
 
 	/* USB PD objects */
-	struct usb_power_delivery *pd;
+	struct usb_power_delivery **pds;
+	struct pd_data **pd_list;
 	struct usb_power_delivery_capabilities *port_source_caps;
 	struct usb_power_delivery_capabilities *port_sink_caps;
 	struct usb_power_delivery *partner_pd;
 	struct usb_power_delivery_capabilities *partner_source_caps;
 	struct usb_power_delivery_capabilities *partner_sink_caps;
+	struct usb_power_delivery *selected_pd;
 
 	/* Partner capabilities/requests */
 	u32 sink_request;
@@ -413,6 +424,7 @@ struct tcpm_port {
 	unsigned int nr_sink_caps;
 
 	/* Local capabilities */
+	unsigned int pd_count;
 	u32 src_pdo[PDO_MAX_OBJECTS];
 	unsigned int nr_src_pdo;
 	u32 snk_pdo[PDO_MAX_OBJECTS];
@@ -6059,12 +6071,114 @@ static int tcpm_port_type_set(struct typec_port *p, enum typec_port_type type)
 	return 0;
 }
 
+static struct pd_data *tcpm_find_pd_data(struct tcpm_port *port, struct usb_power_delivery *pd)
+{
+	int i;
+
+	for (i = 0; port->pd_list[i]; i++) {
+		if (port->pd_list[i]->pd == pd)
+			return port->pd_list[i];
+	}
+
+	return ERR_PTR(-ENODATA);
+}
+
+static struct usb_power_delivery **tcpm_pd_get(struct typec_port *p)
+{
+	struct tcpm_port *port = typec_get_drvdata(p);
+
+	return port->pds;
+}
+
+static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
+{
+	struct tcpm_port *port = typec_get_drvdata(p);
+	struct pd_data *data;
+	int i, ret = 0;
+
+	mutex_lock(&port->lock);
+
+	if (port->selected_pd == pd)
+		goto unlock;
+
+	data = tcpm_find_pd_data(port, pd);
+	if (IS_ERR(data)) {
+		ret = PTR_ERR(data);
+		goto unlock;
+	}
+
+	if (data->sink_desc.pdo[0]) {
+		for (i = 0; i < PDO_MAX_OBJECTS && data->sink_desc.pdo[i]; i++)
+			port->snk_pdo[i] = data->sink_desc.pdo[i];
+		port->nr_snk_pdo = i + 1;
+		port->operating_snk_mw = data->operating_snk_mw;
+	}
+
+	if (data->source_desc.pdo[0]) {
+		for (i = 0; i < PDO_MAX_OBJECTS && data->source_desc.pdo[i]; i++)
+			port->snk_pdo[i] = data->source_desc.pdo[i];
+		port->nr_src_pdo = i + 1;
+	}
+
+	switch (port->state) {
+	case SRC_UNATTACHED:
+	case SRC_ATTACH_WAIT:
+	case SRC_TRYWAIT:
+		tcpm_set_cc(port, tcpm_rp_cc(port));
+		break;
+	case SRC_SEND_CAPABILITIES:
+	case SRC_SEND_CAPABILITIES_TIMEOUT:
+	case SRC_NEGOTIATE_CAPABILITIES:
+	case SRC_READY:
+	case SRC_WAIT_NEW_CAPABILITIES:
+		port->caps_count = 0;
+		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+		if (ret == -EAGAIN) {
+			port->upcoming_state = INVALID_STATE;
+			goto unlock;
+		}
+		break;
+	case SNK_NEGOTIATE_CAPABILITIES:
+	case SNK_NEGOTIATE_PPS_CAPABILITIES:
+	case SNK_READY:
+	case SNK_TRANSITION_SINK:
+	case SNK_TRANSITION_SINK_VBUS:
+		if (port->pps_data.active)
+			port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+		else if (port->pd_capable)
+			port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
+		else
+			break;
+
+		port->update_sink_caps = true;
+
+		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+		if (ret == -EAGAIN) {
+			port->upcoming_state = INVALID_STATE;
+			goto unlock;
+		}
+		break;
+	default:
+		break;
+	}
+
+	port->port_source_caps = data->source_cap;
+	port->port_sink_caps = data->sink_cap;
+	port->selected_pd = pd;
+unlock:
+	mutex_unlock(&port->lock);
+	return ret;
+}
+
 static const struct typec_operations tcpm_ops = {
 	.try_role = tcpm_try_role,
 	.dr_set = tcpm_dr_set,
 	.pr_set = tcpm_pr_set,
 	.vconn_set = tcpm_vconn_set,
-	.port_type_set = tcpm_port_type_set
+	.port_type_set = tcpm_port_type_set,
+	.pd_get = tcpm_pd_get,
+	.pd_set = tcpm_pd_set
 };
 
 void tcpm_tcpc_reset(struct tcpm_port *port)
@@ -6078,58 +6192,63 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
 
 static void tcpm_port_unregister_pd(struct tcpm_port *port)
 {
-	usb_power_delivery_unregister_capabilities(port->port_sink_caps);
+	int i;
+
 	port->port_sink_caps = NULL;
-	usb_power_delivery_unregister_capabilities(port->port_source_caps);
 	port->port_source_caps = NULL;
-	usb_power_delivery_unregister(port->pd);
-	port->pd = NULL;
+	for (i = 0; i < port->pd_count; i++) {
+		usb_power_delivery_unregister_capabilities(port->pd_list[i]->sink_cap);
+		kfree(port->pd_list[i]->sink_cap);
+		usb_power_delivery_unregister_capabilities(port->pd_list[i]->source_cap);
+		kfree(port->pd_list[i]->source_cap);
+		devm_kfree(port->dev, port->pd_list[i]);
+		port->pd_list[i] = NULL;
+		usb_power_delivery_unregister(port->pds[i]);
+		port->pds[i] = NULL;
+	}
 }
 
 static int tcpm_port_register_pd(struct tcpm_port *port)
 {
 	struct usb_power_delivery_desc desc = { port->typec_caps.pd_revision };
-	struct usb_power_delivery_capabilities_desc caps = { };
 	struct usb_power_delivery_capabilities *cap;
-	int ret;
+	int ret, i;
 
 	if (!port->nr_src_pdo && !port->nr_snk_pdo)
 		return 0;
 
-	port->pd = usb_power_delivery_register(port->dev, &desc);
-	if (IS_ERR(port->pd)) {
-		ret = PTR_ERR(port->pd);
-		goto err_unregister;
-	}
-
-	if (port->nr_src_pdo) {
-		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->src_pdo,
-			       port->nr_src_pdo * sizeof(u32), 0);
-		caps.role = TYPEC_SOURCE;
-
-		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
-		if (IS_ERR(cap)) {
-			ret = PTR_ERR(cap);
+	for (i = 0; i < port->pd_count; i++) {
+		port->pds[i] = usb_power_delivery_register(port->dev, &desc);
+		if (IS_ERR(port->pds[i])) {
+			ret = PTR_ERR(port->pds[i]);
 			goto err_unregister;
 		}
-
-		port->port_source_caps = cap;
-	}
-
-	if (port->nr_snk_pdo) {
-		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->snk_pdo,
-			       port->nr_snk_pdo * sizeof(u32), 0);
-		caps.role = TYPEC_SINK;
-
-		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
-		if (IS_ERR(cap)) {
-			ret = PTR_ERR(cap);
-			goto err_unregister;
+		port->pd_list[i]->pd = port->pds[i];
+
+		if (port->pd_list[i]->source_desc.pdo[0]) {
+			cap = usb_power_delivery_register_capabilities(port->pds[i],
+								&port->pd_list[i]->source_desc);
+			if (IS_ERR(cap)) {
+				ret = PTR_ERR(cap);
+				goto err_unregister;
+			}
+			port->pd_list[i]->source_cap = cap;
 		}
 
-		port->port_sink_caps = cap;
+		if (port->pd_list[i]->sink_desc.pdo[0]) {
+			cap = usb_power_delivery_register_capabilities(port->pds[i],
+								&port->pd_list[i]->sink_desc);
+			if (IS_ERR(cap)) {
+				ret = PTR_ERR(cap);
+				goto err_unregister;
+			}
+			port->pd_list[i]->sink_cap = cap;
+		}
 	}
 
+	port->port_source_caps = port->pd_list[0]->source_cap;
+	port->port_sink_caps = port->pd_list[0]->sink_cap;
+	port->selected_pd = port->pds[0];
 	return 0;
 
 err_unregister:
@@ -6138,12 +6257,14 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
 	return ret;
 }
 
-static int tcpm_fw_get_caps(struct tcpm_port *port,
-			    struct fwnode_handle *fwnode)
+static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
 {
+	struct fwnode_handle *capabilities, *child, *caps = NULL;
+	unsigned int nr_src_pdo, nr_snk_pdo;
 	const char *opmode_str;
-	int ret;
-	u32 mw, frs_current;
+	u32 *src_pdo, *snk_pdo;
+	u32 uw, frs_current;
+	int ret = 0, i;
 
 	if (!fwnode)
 		return -EINVAL;
@@ -6163,28 +6284,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
 	port->port_type = port->typec_caps.type;
 	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-disable");
-
 	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
-	if (port->port_type == TYPEC_PORT_SNK)
-		goto sink;
-
-	/* Get Source PDOs for the PD port or Source Rp value for the non-PD port */
-	if (port->pd_supported) {
-		ret = fwnode_property_count_u32(fwnode, "source-pdos");
-		if (ret == 0)
-			return -EINVAL;
-		else if (ret < 0)
-			return ret;
+	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
 
-		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
-		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
-						     port->src_pdo, port->nr_src_pdo);
-		if (ret)
-			return ret;
-		ret = tcpm_validate_caps(port, port->src_pdo, port->nr_src_pdo);
-		if (ret)
-			return ret;
-	} else {
+	if (!port->pd_supported) {
 		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
 		if (ret)
 			return ret;
@@ -6192,45 +6295,150 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		if (ret < 0)
 			return ret;
 		port->src_rp = tcpm_pwr_opmode_to_rp(ret);
-	}
-
-	if (port->port_type == TYPEC_PORT_SRC)
-		return 0;
-
-sink:
-	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
-
-	if (!port->pd_supported)
 		return 0;
+	}
 
-	/* Get sink pdos */
-	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
-	if (ret <= 0)
-		return -EINVAL;
-
-	port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
-					     port->snk_pdo, port->nr_snk_pdo);
-	if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
-					    port->nr_snk_pdo))
-		return -EINVAL;
-
-	if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
-		return -EINVAL;
-	port->operating_snk_mw = mw / 1000;
+	/* The following code are applicable to pd-capable ports, i.e. pd_supported is true. */
 
 	/* FRS can only be supported by DRP ports */
 	if (port->port_type == TYPEC_PORT_DRP) {
 		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
 					       &frs_current);
-		if (ret >= 0 && frs_current <= FRS_5V_3A)
+		if (!ret && frs_current <= FRS_5V_3A)
 			port->new_source_frs_current = frs_current;
+
+		if (ret)
+			ret = 0;
 	}
 
+	/* For the backward compatibility, "capabilities" node is optional. */
+	capabilities = fwnode_get_named_child_node(fwnode, "capabilities");
+	if (!capabilities) {
+		port->pd_count = 1;
+	} else {
+		fwnode_for_each_child_node(capabilities, child)
+			port->pd_count++;
+
+		if (!port->pd_count) {
+			ret = -ENODATA;
+			goto put_capabilities;
+		}
+	}
+
+	port->pds = devm_kcalloc(port->dev, port->pd_count, sizeof(struct usb_power_delivery *),
+				 GFP_KERNEL);
+	if (!port->pds) {
+		ret = -ENOMEM;
+		goto put_capabilities;
+	}
+
+	port->pd_list = devm_kcalloc(port->dev, port->pd_count, sizeof(struct pd_data *),
+				     GFP_KERNEL);
+	if (!port->pd_list) {
+		ret = -ENOMEM;
+		goto put_capabilities;
+	}
+
+	for (i = 0; i < port->pd_count; i++) {
+		port->pd_list[i] = devm_kzalloc(port->dev, sizeof(struct pd_data), GFP_KERNEL);
+		if (!port->pd_list[i]) {
+			ret = -ENOMEM;
+			goto put_capabilities;
+		}
+
+		src_pdo = port->pd_list[i]->source_desc.pdo;
+		port->pd_list[i]->source_desc.role = TYPEC_SOURCE;
+		snk_pdo = port->pd_list[i]->sink_desc.pdo;
+		port->pd_list[i]->sink_desc.role = TYPEC_SINK;
+
+		/* If "capabilities" is NULL, fall back to single pd cap population. */
+		if (!capabilities)
+			caps = fwnode;
+		else
+			caps = fwnode_get_next_child_node(capabilities, caps);
+
+		if (port->port_type != TYPEC_PORT_SNK) {
+			ret = fwnode_property_count_u32(caps, "source-pdos");
+			if (ret == 0) {
+				ret = -EINVAL;
+				goto put_caps;
+			}
+			if (ret < 0)
+				goto put_caps;
+
+			nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
+			ret = fwnode_property_read_u32_array(caps, "source-pdos", src_pdo,
+							     nr_src_pdo);
+			if (ret)
+				goto put_caps;
+
+			ret = tcpm_validate_caps(port, src_pdo, nr_src_pdo);
+			if (ret)
+				goto put_caps;
+
+			if (i == 0) {
+				port->nr_src_pdo = nr_src_pdo;
+				memcpy_and_pad(port->src_pdo, sizeof(u32) * PDO_MAX_OBJECTS,
+					       port->pd_list[0]->source_desc.pdo,
+					       sizeof(u32) * nr_src_pdo,
+					       0);
+			}
+		}
+
+		if (port->port_type != TYPEC_PORT_SRC) {
+			ret = fwnode_property_count_u32(caps, "sink-pdos");
+			if (ret == 0) {
+				ret = -EINVAL;
+				goto put_caps;
+			}
+
+			if (ret < 0)
+				goto put_caps;
+
+			nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
+			ret = fwnode_property_read_u32_array(caps, "sink-pdos", snk_pdo,
+							     nr_snk_pdo);
+			if (ret)
+				goto put_caps;
+
+			ret = tcpm_validate_caps(port, snk_pdo, nr_snk_pdo);
+			if (ret)
+				goto put_caps;
+
+			if (fwnode_property_read_u32(caps, "op-sink-microwatt", &uw) < 0) {
+				ret = -EINVAL;
+				goto put_caps;
+			}
+
+			port->pd_list[i]->operating_snk_mw = uw / 1000;
+
+			if (i == 0) {
+				port->nr_snk_pdo = nr_snk_pdo;
+				memcpy_and_pad(port->snk_pdo, sizeof(u32) * PDO_MAX_OBJECTS,
+					       port->pd_list[0]->sink_desc.pdo,
+					       sizeof(u32) * nr_snk_pdo,
+					       0);
+				port->operating_snk_mw = port->pd_list[0]->operating_snk_mw;
+			}
+		}
+	}
+
+put_caps:
+	if (caps != fwnode)
+		fwnode_handle_put(caps);
+put_capabilities:
+	fwnode_handle_put(capabilities);
+	return ret;
+}
+
+static int tcpm_fw_get_snk_vdos(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	int ret;
+
 	/* sink-vdos is optional */
 	ret = fwnode_property_count_u32(fwnode, "sink-vdos");
 	if (ret < 0)
-		ret = 0;
+		return 0;
 
 	port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
 	if (port->nr_snk_vdo) {
@@ -6596,12 +6804,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	tcpm_debugfs_init(port);
 
 	err = tcpm_fw_get_caps(port, tcpc->fwnode);
+	if (err < 0)
+		goto out_destroy_wq;
+	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
 	if (err < 0)
 		goto out_destroy_wq;
 
 	port->try_role = port->typec_caps.prefer_role;
 
-	port->typec_caps.fwnode = tcpc->fwnode;
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
 	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
 	port->typec_caps.svdm_version = SVDM_VER_2_0;
@@ -6610,7 +6820,6 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->typec_caps.orientation_aware = 1;
 
 	port->partner_desc.identity = &port->partner_ident;
-	port->port_type = port->typec_caps.type;
 
 	port->role_sw = usb_role_switch_get(port->dev);
 	if (!port->role_sw)
@@ -6629,7 +6838,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	if (err)
 		goto out_role_sw_put;
 
-	port->typec_caps.pd = port->pd;
+	port->typec_caps.pd = port->pds[0];
 
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
-- 
2.43.0.472.g3155946c3a-goog



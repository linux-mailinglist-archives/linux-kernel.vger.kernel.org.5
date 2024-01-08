Return-Path: <linux-kernel+bounces-20018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5D82784B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547EC1F23D71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936AD5579B;
	Mon,  8 Jan 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JX5s4fAP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3054FA5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f874219ff9so10799787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741392; x=1705346192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wth/8UoV+aL5LC0kJi/DVxESpme0aBOkMeRoyQ8VPg=;
        b=JX5s4fAPwkuDPyS0kVqY5cblfmoiicWE7EptOaOfAeV18pajJIDRKziwuawvDCgbWJ
         Xu8Qh0B6zij3cTry78J5D+Qayr3XWL0MzdN5o8ED0v8KX4k4Y8blHkGpIfXxEc50CIZB
         YYzzC0XBR8JEw81mnaIPA4wDzWPCmtYhHrnD6CE1JV6DuM8q2ATQ4j3iY4PcSfKMqPws
         DY5g15CE7qUY8dyT0uCU/YUh98wssxcOWRJNJNgakyiwQPETEDv6Cvb5AWMpKFa3HaVB
         0rW1s9DOdcp1gMV2Nh1cxSd5KpKb68ZPDqZPKD13RpDZ75Fqs/bnRDaTCk4Y8zfu0Nk+
         jKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741392; x=1705346192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wth/8UoV+aL5LC0kJi/DVxESpme0aBOkMeRoyQ8VPg=;
        b=J3qUOH6NT+v8F+/HT95kRlu5K09pgHi/wltnFOE8ghF8TYAx1Dn8qmRvzo/a615XnU
         UiTwuEOwqqRrEYgMQuO/PKbCyaJXKv6ZrsHlSPIyqqcodIkc3+WieKlmqDsOzMqcVeNL
         L+FiwGA5mtgL215h0hynWK3SI5s4hhFRZWkYMcWh+/3X0bdtCFaRhTV4cTXWzCjSUGOd
         UydWaYLDCpaUlK6jsWvpdkDvNDMccMgPP7awwhmAgdY+vpJbx86trHlp/+cfskDhkMvx
         maCncV+3HV3I0QVImCLr3oRAKYyghx6HhwylTgWRrHiBC95As2Z0LIsQ/hn8QAa59YZD
         Vvbw==
X-Gm-Message-State: AOJu0YxJoQ7JyvwP+d0SNQd/Af37IEU20yN10JjfhiQp+pIbH68mCnan
	BHbhOHbGKfyYo5IVVO3lncIgGrqB7wNyeLxsIdqI9w==
X-Google-Smtp-Source: AGHT+IFvaYMR/S/ZsUdsT9yfFqRaBpdsQUBK95oSocGAC52s8GXENtfDuoYYUqSRde+LO1erDZUAyGIxLwz6qQE=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a81:c706:0:b0:5f9:32c7:cc51 with SMTP id
 m6-20020a81c706000000b005f932c7cc51mr75760ywi.0.1704741391912; Mon, 08 Jan
 2024 11:16:31 -0800 (PST)
Date: Mon,  8 Jan 2024 19:16:14 +0000
In-Reply-To: <20240108191620.987785-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108191620.987785-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7965; i=rdbabiera@google.com;
 h=from:subject; bh=Y9LvmKwg8nyhTWBiDudZ8gZ35eWUccV05qkVwo8b+M0=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlzvFgT/z57lck7+abNwa/fptx4uGjZ/2e+p+M+BMlzS
 /NPDI4711HKwiDGwSArpsii659ncONK6pY5nDXGMHNYmUCGMHBxCsBEJn5iZJi8Xafn1tHJNzSm
 x9YGffB28s7Jn+p2fer2jP9TXmnN/ZTN8E+DN3fm6y8hfdv7nmiI3rKfwGum9Mf1h+Bi13b7tzc LOvgB
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108191620.987785-15-rdbabiera@google.com>
Subject: [PATCH v3 01/12] usb: typec: altmodes: add typec_cable_ops to typec_altmode
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add typec_cable_ops struct for enter, exit, and vdm. The struct is added
to typec_altmode so port alt modes can have access to partner and cable
specific callbacks, and alt mode drivers can specify operations over SOP'
and SOP'' without modifying the existing API.

typec_port_register_cable_ops is added as a new symbol for port drivers
to use to register cable operations to their registered port alt modes.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes since v2:
* fixed documentation prototype errors
---
 drivers/usb/typec/bus.c           | 102 ++++++++++++++++++++++++++++++
 drivers/usb/typec/class.c         |  19 ++++++
 include/linux/usb/typec.h         |   4 ++
 include/linux/usb/typec_altmode.h |  20 ++++++
 4 files changed, 145 insertions(+)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index e95ec7e382bb..6ea103e1abae 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -244,6 +244,108 @@ typec_altmode_get_partner(struct typec_altmode *adev)
 }
 EXPORT_SYMBOL_GPL(typec_altmode_get_partner);
 
+/* -------------------------------------------------------------------------- */
+/* API for cable alternate modes */
+
+/**
+ * typec_cable_altmode_enter - Enter Mode
+ * @adev: The alternate mode
+ * @sop: Cable plug target for Enter Mode command
+ * @vdo: VDO for the Enter Mode command
+ *
+ * Alternate mode drivers use this function to enter mode on the cable plug.
+ * If the alternate mode does not require VDO, @vdo must be NULL.
+ */
+int typec_cable_altmode_enter(struct typec_altmode *adev, enum typec_plug_index sop, u32 *vdo)
+{
+	struct altmode *partner = to_altmode(adev)->partner;
+	struct typec_altmode *pdev;
+
+	if (!adev || adev->active)
+		return 0;
+
+	if (!partner)
+		return -ENODEV;
+
+	pdev = &partner->adev;
+
+	if (!pdev->active)
+		return -EPERM;
+
+	if (!pdev->cable_ops || !pdev->cable_ops->enter)
+		return -EOPNOTSUPP;
+
+	return pdev->cable_ops->enter(pdev, sop, vdo);
+}
+EXPORT_SYMBOL_GPL(typec_cable_altmode_enter);
+
+/**
+ * typec_cable_altmode_exit - Exit Mode
+ * @adev: The alternate mode
+ * @sop: Cable plug target for Exit Mode command
+ *
+ * The alternate mode drivers use this function to exit mode on the cable plug.
+ */
+int typec_cable_altmode_exit(struct typec_altmode *adev, enum typec_plug_index sop)
+{
+	struct altmode *partner = to_altmode(adev)->partner;
+	struct typec_altmode *pdev;
+
+	if (!adev || !adev->active)
+		return 0;
+
+	if (!partner)
+		return -ENODEV;
+
+	pdev = &partner->adev;
+
+	if (!pdev->cable_ops || !pdev->cable_ops->exit)
+		return -EOPNOTSUPP;
+
+	return pdev->cable_ops->exit(pdev, sop);
+}
+EXPORT_SYMBOL_GPL(typec_cable_altmode_exit);
+
+/**
+ * typec_cable_altmode_vdm - Send Vendor Defined Messages (VDM) between the cable plug and port.
+ * @adev: Alternate mode handle
+ * @sop: Cable plug target for VDM
+ * @header: VDM Header
+ * @vdo: Array of Vendor Defined Data Objects
+ * @count: Number of Data Objects
+ *
+ * The alternate mode drivers use this function for SVID specific communication
+ * with the cable plugs. The port drivers use it to deliver the Structured VDMs
+ * received from the cable plugs to the alternate mode drivers.
+ */
+int typec_cable_altmode_vdm(struct typec_altmode *adev, enum typec_plug_index sop,
+			    const u32 header, const u32 *vdo, int count)
+{
+	struct altmode *altmode;
+	struct typec_altmode *pdev;
+
+	if (!adev)
+		return 0;
+
+	altmode = to_altmode(adev);
+
+	if (is_typec_plug(adev->dev.parent)) {
+		if (!altmode->partner)
+			return -ENODEV;
+		pdev = &altmode->partner->adev;
+	} else {
+		if (!altmode->plug[sop])
+			return -ENODEV;
+		pdev = &altmode->plug[sop]->adev;
+	}
+
+	if (!pdev->cable_ops || !pdev->cable_ops->vdm)
+		return -EOPNOTSUPP;
+
+	return pdev->cable_ops->vdm(pdev, sop, header, vdo, count);
+}
+EXPORT_SYMBOL_GPL(typec_cable_altmode_vdm);
+
 /* -------------------------------------------------------------------------- */
 /* API for the alternate mode drivers */
 
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 015aa9253353..8fc9795d6bd4 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2280,6 +2280,25 @@ void typec_port_register_altmodes(struct typec_port *port,
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 
+/**
+ * typec_port_register_cable_ops - Register typec_cable_ops to port altmodes
+ * @altmodes: USB Type-C Port's altmode vector
+ * @max_altmodes: The maximum number of alt modes supported by the port
+ * @ops: Cable alternate mode vector
+ */
+void typec_port_register_cable_ops(struct typec_altmode **altmodes, int max_altmodes,
+				   const struct typec_cable_ops *ops)
+{
+	int i;
+
+	for (i = 0; i < max_altmodes; i++) {
+		if (!altmodes[i])
+			return;
+		altmodes[i]->cable_ops = ops;
+	}
+}
+EXPORT_SYMBOL_GPL(typec_port_register_cable_ops);
+
 /**
  * typec_register_port - Register a USB Type-C Port
  * @parent: Parent device
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index a05d6f6f2536..38f93d72fd1b 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -18,6 +18,7 @@ struct typec_cable;
 struct typec_plug;
 struct typec_port;
 struct typec_altmode_ops;
+struct typec_cable_ops;
 
 struct fwnode_handle;
 struct device;
@@ -157,6 +158,9 @@ void typec_port_register_altmodes(struct typec_port *port,
 	const struct typec_altmode_ops *ops, void *drvdata,
 	struct typec_altmode **altmodes, size_t n);
 
+void typec_port_register_cable_ops(struct typec_altmode **altmodes, int max_altmodes,
+				   const struct typec_cable_ops *ops);
+
 void typec_unregister_altmode(struct typec_altmode *altmode);
 
 struct typec_port *typec_altmode2port(struct typec_altmode *alt);
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 28aeef8f9e7b..72ec8058543a 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -20,6 +20,7 @@ struct typec_altmode_ops;
  * @active: Tells has the mode been entered or not
  * @desc: Optional human readable description of the mode
  * @ops: Operations vector from the driver
+ * @cable_ops: Cable operations vector from the driver.
  */
 struct typec_altmode {
 	struct device			dev;
@@ -30,6 +31,7 @@ struct typec_altmode {
 
 	char				*desc;
 	const struct typec_altmode_ops	*ops;
+	const struct typec_cable_ops	*cable_ops;
 };
 
 #define to_typec_altmode(d) container_of(d, struct typec_altmode, dev)
@@ -75,6 +77,24 @@ int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
 const struct typec_altmode *
 typec_altmode_get_partner(struct typec_altmode *altmode);
 
+/**
+ * struct typec_cable_ops - Cable alternate mode operations vector
+ * @enter: Operations to be executed with Enter Mode Command
+ * @exit: Operations to be executed with Exit Mode Command
+ * @vdm: Callback for SVID specific commands
+ */
+struct typec_cable_ops {
+	int (*enter)(struct typec_altmode *altmode, enum typec_plug_index sop, u32 *vdo);
+	int (*exit)(struct typec_altmode *altmode, enum typec_plug_index sop);
+	int (*vdm)(struct typec_altmode *altmode, enum typec_plug_index sop,
+		   const u32 hdr, const u32 *vdo, int cnt);
+};
+
+int typec_cable_altmode_enter(struct typec_altmode *altmode, enum typec_plug_index sop, u32 *vdo);
+int typec_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop);
+int typec_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
+			    const u32 header, const u32 *vdo, int count);
+
 /*
  * These are the connector states (USB, Safe and Alt Mode) defined in USB Type-C
  * Specification. SVID specific connector states are expected to follow and
-- 
2.43.0.472.g3155946c3a-goog



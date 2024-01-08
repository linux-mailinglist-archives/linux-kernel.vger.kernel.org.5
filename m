Return-Path: <linux-kernel+bounces-20019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B488082784A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0591C24029
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA28255776;
	Mon,  8 Jan 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l28wfI91"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07655764
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f6f51cd7e8so24407147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741393; x=1705346193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cTxGOovJ9V9dXlWmUdvT596HOaLkkrDzIVt7n3ymDs=;
        b=l28wfI91yJ5LrTmUvphWBvDyTt5ZrIAc+S0Xoyj/AnxDbqscLQlk6r5cy6Kfdz06wb
         dp+1gTIrwrbd0/4FhG5h4HnrA6b2RBcHWKOnKd/SCj/ESadXO2ZDM7Zo80cjoapXskZR
         mWERzBVLIDOTG7uNyzkaW1W13WEqU9xvNt/MJsNGeIDf2N7f7e/TzegxbBTxjb0U7UvI
         xg5gbaIVj5gcA0sayvVsd7OX2k+qyqFp7Hbv06p65FZdq2/7L/j/vQ5lQrC3zteufmaF
         9tY4tt7IuZbuLID3A0mzmEk1tgRQB14HmUkecBm8/avFOgFc9Npyk2hSrrgAvAj0kH18
         zJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741393; x=1705346193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cTxGOovJ9V9dXlWmUdvT596HOaLkkrDzIVt7n3ymDs=;
        b=aLiunJClxXC6ZAsC/0hNoHlV3sr+pQy7uBtqqTctd2gLdLMRm04sRrKdvZnJRaRugK
         y+HURwzpI1ck9lqm+X7H8uNNTc4eSw4EFHAwb6uY+TM/wxu63AbX3Xi1HZy9ikd8yXvP
         RG9gYmaAXBYlqPaP5RssVvGZqWSzcR+FXlX/a2OWJoeNVD1swcqlNznSkLHEoc/wesLv
         EsvwEVFcX+IqCtcOEC/e+C36idDsb9j6TPZpuTu6AX00rEnP+LwLOgRSx4bSdsD6VPB0
         6hnjxOHslTRKgIhN70bR1FAa50PYafRRLwlfYY5IaRnlXPataaLVq3sHZQ9BmZUsdwht
         X2XA==
X-Gm-Message-State: AOJu0YzWzP3acXYtutzQoQc8KpXf3PQXVPPKR9DxSyTx5aLCgGR4AWVS
	/xsJ7YET9IIaLbiso3CTZ2DehdhsYNbSwYie3NOpwg==
X-Google-Smtp-Source: AGHT+IGQa+SceVtV95MiZ1OpzOT/MSy26HiBDmjO6UVAVpQ8YhCbkfDEzl7v0nQNKNS1tNbgPUrFRIcNlaQZe9U=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:690c:309:b0:5e6:579e:65dd with SMTP
 id bg9-20020a05690c030900b005e6579e65ddmr1849078ywb.3.1704741393710; Mon, 08
 Jan 2024 11:16:33 -0800 (PST)
Date: Mon,  8 Jan 2024 19:16:15 +0000
In-Reply-To: <20240108191620.987785-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108191620.987785-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4597; i=rdbabiera@google.com;
 h=from:subject; bh=j+lKxg3/XM4yeeEZLecb85/FMhalIVj7y0+SqcQ18x0=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlzvFgbQqZ9ln1+4MHumiKL+T+Df/e/MZ76wHDlxfh1V
 6yUFnozd5SyMIhxMMiKKbLo+ucZ3LiSumUOZ40xzBxWJpAhDFycAjCRT1sZ/of9Vxe8dMKE5cXn
 ppKLnSaWmysUZ0uq55terVhg87KT9zIjw3YFcdW65cx9Vl7LKjMXWs1eq60eyHH6veCF+ZYL9aa dYwYA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108191620.987785-16-rdbabiera@google.com>
Subject: [PATCH v3 02/12] usb: typec: altmodes: add svdm version info for
 typec cables
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add typec_cable_set_svdm_version and typec_get_cable_svdm version symbols.
Cables can operate under a lower PD revision than the port partner, and the
max SVDM version is tied to the PD revision. So, typec_cable maintains its
own svdm_version.

Add typec_altmode_get_cable_svdm_version to return the cable's negotiated
svdm_version for altmode drivers to use.

Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes from v2:
* added reviewed-by tag
---
 drivers/usb/typec/class.c         | 40 +++++++++++++++++++++++++++++++
 drivers/usb/typec/class.h         |  1 +
 include/linux/usb/typec.h         |  3 +++
 include/linux/usb/typec_altmode.h | 10 ++++++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 8fc9795d6bd4..caea2b829980 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2131,6 +2131,46 @@ int typec_get_negotiated_svdm_version(struct typec_port *port)
 }
 EXPORT_SYMBOL_GPL(typec_get_negotiated_svdm_version);
 
+/**
+ * typec_get_cable_svdm_version - Get cable negotiated SVDM Version
+ * @port: USB Type-C Port.
+ *
+ * Get the negotiated SVDM Version for the cable. The Version is set to the port
+ * default value based on the PD Revision during cable registration, and updated
+ * after a successful Discover Identity if the negotiated value is less than the
+ * default.
+ *
+ * Returns usb_pd_svdm_ver if the cable has been registered otherwise -ENODEV.
+ */
+int typec_get_cable_svdm_version(struct typec_port *port)
+{
+	enum usb_pd_svdm_ver svdm_version;
+	struct device *cable_dev;
+
+	cable_dev = device_find_child(&port->dev, NULL, cable_match);
+	if (!cable_dev)
+		return -ENODEV;
+
+	svdm_version = to_typec_cable(cable_dev)->svdm_version;
+	put_device(cable_dev);
+
+	return svdm_version;
+}
+EXPORT_SYMBOL_GPL(typec_get_cable_svdm_version);
+
+/**
+ * typec_cable_set_svdm_version - Set negotiated Structured VDM (SVDM) Version
+ * @cable: USB Type-C Active Cable that supports SVDM
+ * @svdm_version: Negotiated SVDM Version
+ *
+ * This routine is used to save the negotiated SVDM Version.
+ */
+void typec_cable_set_svdm_version(struct typec_cable *cable, enum usb_pd_svdm_ver svdm_version)
+{
+	cable->svdm_version = svdm_version;
+}
+EXPORT_SYMBOL_GPL(typec_cable_set_svdm_version);
+
 /**
  * typec_get_drvdata - Return private driver data pointer
  * @port: USB Type-C port
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index c36761ba3f59..759b98355eeb 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -23,6 +23,7 @@ struct typec_cable {
 	struct usb_pd_identity		*identity;
 	unsigned int			active:1;
 	u16				pd_revision; /* 0300H = "3.0" */
+	enum usb_pd_svdm_ver		svdm_version;
 };
 
 struct typec_partner {
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 38f93d72fd1b..b35b427561ab 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -337,6 +337,9 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
 				    enum usb_pd_svdm_ver svdm_version);
 int typec_get_negotiated_svdm_version(struct typec_port *port);
 
+int typec_get_cable_svdm_version(struct typec_port *port);
+void typec_cable_set_svdm_version(struct typec_cable *cable, enum usb_pd_svdm_ver svdm_version);
+
 struct usb_power_delivery *typec_partner_usb_power_delivery_register(struct typec_partner *partner,
 							struct usb_power_delivery_desc *desc);
 
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 72ec8058543a..b3c0866ea70f 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -95,6 +95,16 @@ int typec_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_inde
 int typec_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
 			    const u32 header, const u32 *vdo, int count);
 
+/**
+ * typec_altmode_get_cable_svdm_version - Get negotiated SVDM version for cable plug
+ * @altmode: Handle to the alternate mode
+ */
+static inline int
+typec_altmode_get_cable_svdm_version(struct typec_altmode *altmode)
+{
+	return typec_get_cable_svdm_version(typec_altmode2port(altmode));
+}
+
 /*
  * These are the connector states (USB, Safe and Alt Mode) defined in USB Type-C
  * Specification. SVID specific connector states are expected to follow and
-- 
2.43.0.472.g3155946c3a-goog



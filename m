Return-Path: <linux-kernel+bounces-225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43830813E07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C911C20E31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8A6E5BB;
	Thu, 14 Dec 2023 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ghUb5eY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E936E2BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d34350cbe8so850005ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595342; x=1703200142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaJDP0eW4BP49e8cim7c4sIh1qZQEFCXo/mVTiuR2jU=;
        b=2ghUb5eYpHw9IlJuL7Xx0/yuXl4LwqugrD1mgEn7saYZ6mdY//olXYzeToXY3wZehX
         Nv3EqErBL9ivf9aFRmj5z5jGj1B/isOvOZ13HEe6Zja9C4BvJLYK7PEJTQ1N673hz7jH
         apmXglOZhKftDU8rUfnoYlCXwwZX3QilAuh5g4Je472rCJdsnenVsmvSwBULq4NDFvZL
         n2z9le3o3AM4Yodz+I75o056u7CkkDLoXXs/YxyxI5HEVfjOUZHlXcgmyp3tm+TGzu2D
         aPd+XsiTP77+HOc4im9LrpUnG3SMCBxrwwUqvWx4wJVF2dXEG+ywFy7myk1dgHSRo0MA
         AiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595342; x=1703200142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaJDP0eW4BP49e8cim7c4sIh1qZQEFCXo/mVTiuR2jU=;
        b=c5EEn0AOD12FqPsSyqb5zBzDdElaFSRYdwjgKmg/hs+qSbawjtWez+17pOJdvxA5LF
         ojFnjrRVRu85KomgvsX4aYGp7goV24XXQOMApCNwjTx9swm1yC290070IHtG0Io7/0Jd
         kTBwicRfmMX9nmfPJNX4Rem+btNcP8DcxYwDYzimtwb4npGvHe2WmP1bv7CC5IWLyTWx
         LxZkzvyeQSOHkgGQL+SnMUII6r2eJTRMXU9Jt41aJSCYrJBU5rBkXdD6rmITwgOinDBI
         cMlmLXmLv99isjCFDMaqJps+H4dAfuQBWJn0N9CDyDtJrpWQRHYjSSRUC9hRpObxVbZe
         b6nQ==
X-Gm-Message-State: AOJu0YwDMUKZgz7XvC+/oA5FAlAU/OIQ0BMVKJ8c/f0DKZXIPuLrJAg2
	sY1Ivq4C2+FYchWIBaTaFC0IBHtD5qy0TD0=
X-Google-Smtp-Source: AGHT+IEWKr7nEHAmxHafU3nlYKCbT4fCtWmQ6OM705MHRfJLxsPDl6aJav/1P6zuwdbE+UiTlwRkm7TnzfHLREE=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a17:902:db0d:b0:1d0:5d31:467d with SMTP
 id m13-20020a170902db0d00b001d05d31467dmr1959939plx.5.1702595342729; Thu, 14
 Dec 2023 15:09:02 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:46 +0000
In-Reply-To: <20231214230850.379863-14-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4485; i=rdbabiera@google.com;
 h=from:subject; bh=ZnM5bBJf3ZRG1ccJnegsv7FJp5ViE3tVxlUX/q81//U=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3cyPWrev6pWd8vCa2am1mx4qaJ4JvcGUs+fOW2Xz3
 S2J2iuWdJSyMIhxMMiKKbLo+ucZ3LiSumUOZ40xzBxWJpAhDFycAjARwbeMDO9/peZ15jD5Wnjz
 zlg7Qenk0fVlNyVSlm608A2P7kxdbc/I8PpXdlT3zgr1jws02AOtJ191PHw/+kJFqZxJ1ONHD+/ 84AYA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-16-rdbabiera@google.com>
Subject: [PATCH v2 02/12] usb: typec: altmodes: add svdm version info for
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
---
 drivers/usb/typec/class.c         | 40 +++++++++++++++++++++++++++++++
 drivers/usb/typec/class.h         |  1 +
 include/linux/usb/typec.h         |  3 +++
 include/linux/usb/typec_altmode.h | 10 ++++++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 86b5a8414b89..038c6498e683 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2129,6 +2129,46 @@ int typec_get_negotiated_svdm_version(struct typec_port *port)
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



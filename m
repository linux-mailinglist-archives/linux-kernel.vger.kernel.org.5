Return-Path: <linux-kernel+bounces-105526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3E87DFBA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0DB1C208E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECE21EEF8;
	Sun, 17 Mar 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euIleBCg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8591EEF7;
	Sun, 17 Mar 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704301; cv=none; b=uqzESdjsRQ6RghSXDMRorPNIm3Mg30vDd6QXt8hVNRALaiNF7yd99SNG1b5SKr8Ve+9eJKjUrc2zX5o2GqrAmBbLzng1a4wL2535EsyoZ1TY7Tvr8HVZEYmeWxajuv2vjWn/zteTHxtkGPs2ouAaNvXRMhZMBdf1bwyeoYjIi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704301; c=relaxed/simple;
	bh=3F1Z9Uv5v/ZkHS5WWh6yiLmCqTUYZ+P/5oKzWizj12Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaZx14dx7+YRmNKJSvAhV1GAsUPzmbwKux+C23zMwLPK8bCmRFOZU609ZBljWrv+IADzMfbjXfHhokelc+fomVKKWxcdXJmDvmUvP1bogy6cRWWwrm3urp49MqPNwR9T+NSxxc9HYxCV94Jnd2Xdi2vZRxvpJIMYS5oOFLtBNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euIleBCg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6ade6a66aso3324658b3a.3;
        Sun, 17 Mar 2024 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704299; x=1711309099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UinOTZiM3YNMDKxNGnpGam2fV1kcoN0T5SiTjM6PDTw=;
        b=euIleBCgb/W06cBlpD+PvBPN9/e+dnz49aYr0R1MXfnPlRZgXcBTszSOoAgDlstnNM
         kOjqS2ywY/0xrvApSNLWEnr0dcLRDJBAhAZmn//406aIHEKcXKOW1MxL6DXeVIfTELNU
         cCaQkftk4aiXLE8cpy4FYgjyyZ4I8YR96V/y5io2+2LCMy9RKlxXLnUKTk8Ny8wGUK9y
         nF6bBADYwR7wTTtOuCKJS8GK+IFT5MDnKhowbz+kSPa89ordDiw9OUB1bzE9BXuPVdLP
         pD9FHjRTkjxdJ4LeoK3qM+GigXwbPVQnpkzt9KrqNd75DGZt73DvQFwfmrB5iWJL+HQE
         5s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704299; x=1711309099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UinOTZiM3YNMDKxNGnpGam2fV1kcoN0T5SiTjM6PDTw=;
        b=V3bXKdVJUdmAeDkRxp+re0juFy6zjGLwa8knkuJz+F5GrMi+NWbQIWLixjXK+3I8Jc
         1mo5iKUOBdHRMAdVeqZe/EcnIjWRkwdarl70bQp18er6vdP2fpc3vD8qfGAjN3S1BUXq
         CpD2hgii1vNWYsMaUXU4j1MHJZm1tcE9g6B3rjU/30mi/lrz1jVReXA62UqSjX6dPrP7
         8tiJME5mh+rgtajlCg+MuVspMc4rKHQmROsTA5nEXZpneQe+h/qras7ZDWrp68bu9zwc
         9PHRZA+OVkCwLFUj4N2Q+ZuTmZ9cUTGHDf04tXMzG7VzPBNnL0QcFfrFL6KoRH4yBnCI
         0pog==
X-Forwarded-Encrypted: i=1; AJvYcCV1K2Am6tjyergYgT65BxAQDV/1sA8+ISo7H+GFKAUu4lDQzFJCdHmIlgv3guozdNFOVjxX9IVa6WXa04wYxEWttSYskHWj6Z+R07sXcObKd4l80DzX0DF8Z7tThpmpEmWv0/kG+w==
X-Gm-Message-State: AOJu0Yyn2GaUycRJ3FH3wTlNG/44CHhFkXy+gq+HQBxO8f8qxWSLgMbh
	GQK/An5BsIa0YTjr4ZjVD5vwYrnQO7WGrPQL8Fme1u7RVRv4LD9JYNNlTySCyWA=
X-Google-Smtp-Source: AGHT+IE8sZpYbXV9uhPR2rh6t5U9D1DtJZ3euRB90f52HReQDmvoMLV1WheMChqENzxjwSQDTpqS1A==
X-Received: by 2002:a05:6a21:9202:b0:1a3:5090:7268 with SMTP id tl2-20020a056a21920200b001a350907268mr5531078pzb.47.1710704298563;
        Sun, 17 Mar 2024 12:38:18 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6125995pjb.44.2024.03.17.12.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:38:18 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org (open list)
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM)
Subject: [PATCH v4 2/5] spi: Make of_find_spi_controller_by_node() available
Date: Mon, 18 Mar 2024 01:07:10 +0530
Message-ID: <20240317193714.403132-3-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317193714.403132-1-ayushdevel1325@gmail.com>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DONOTMERGE

This externalizes and exports the symbol
of_find_spi_controller_by_node() from the SPI core akin to how
of_find_i2c_adapter_by_node() is already available. As we will
need this also for non-dynamic OF setups, we move it under a
CONFIG_OF check.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/spi/spi.c       | 206 ++++++++++++++++++++--------------------
 include/linux/spi/spi.h |   4 +
 2 files changed, 108 insertions(+), 102 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ba4d3fde2054..9ec507d92f80 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2320,6 +2320,93 @@ void spi_flush_queue(struct spi_controller *ctlr)
 
 /*-------------------------------------------------------------------------*/
 
+static void spi_controller_release(struct device *dev)
+{
+	struct spi_controller *ctlr;
+
+	ctlr = container_of(dev, struct spi_controller, dev);
+	kfree(ctlr);
+}
+
+static struct class spi_master_class = {
+	.name		= "spi_master",
+	.dev_release	= spi_controller_release,
+	.dev_groups	= spi_master_groups,
+};
+
+static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct device *child;
+
+	child = device_find_any_child(&ctlr->dev);
+	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
+}
+
+static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi;
+	struct device *child;
+	char name[32];
+	int rc;
+
+	rc = sscanf(buf, "%31s", name);
+	if (rc != 1 || !name[0])
+		return -EINVAL;
+
+	child = device_find_any_child(&ctlr->dev);
+	if (child) {
+		/* Remove registered slave */
+		device_unregister(child);
+		put_device(child);
+	}
+
+	if (strcmp(name, "(null)")) {
+		/* Register new slave */
+		spi = spi_alloc_device(ctlr);
+		if (!spi)
+			return -ENOMEM;
+
+		strscpy(spi->modalias, name, sizeof(spi->modalias));
+
+		rc = spi_add_device(spi);
+		if (rc) {
+			spi_dev_put(spi);
+			return rc;
+		}
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(slave);
+
+static struct attribute *spi_slave_attrs[] = {
+	&dev_attr_slave.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_slave_group = {
+	.attrs = spi_slave_attrs,
+};
+
+static const struct attribute_group *spi_slave_groups[] = {
+	&spi_controller_statistics_group,
+	&spi_slave_group,
+	NULL,
+};
+
+static struct class spi_slave_class = {
+	.name		= "spi_slave",
+	.dev_release	= spi_controller_release,
+	.dev_groups	= spi_slave_groups,
+};
+
 #if defined(CONFIG_OF)
 static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 				     struct spi_delay *delay, const char *prop)
@@ -2543,6 +2630,23 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 		}
 	}
 }
+
+/* The spi controllers are not using spi_bus, so we find it with another way */
+struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = class_find_device_by_of_node(&spi_master_class, node);
+	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
+		dev = class_find_device_by_of_node(&spi_slave_class, node);
+	if (!dev)
+		return NULL;
+
+	/* Reference got in class_find_device */
+	return container_of(dev, struct spi_controller, dev);
+}
+EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
+
 #else
 static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif
@@ -2942,20 +3046,6 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
 static inline void acpi_register_spi_devices(struct spi_controller *ctlr) {}
 #endif /* CONFIG_ACPI */
 
-static void spi_controller_release(struct device *dev)
-{
-	struct spi_controller *ctlr;
-
-	ctlr = container_of(dev, struct spi_controller, dev);
-	kfree(ctlr);
-}
-
-static struct class spi_master_class = {
-	.name		= "spi_master",
-	.dev_release	= spi_controller_release,
-	.dev_groups	= spi_master_groups,
-};
-
 #ifdef CONFIG_SPI_SLAVE
 /**
  * spi_slave_abort - abort the ongoing transfer request on an SPI slave
@@ -2983,79 +3073,6 @@ int spi_target_abort(struct spi_device *spi)
 	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(spi_target_abort);
-
-static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
-						   dev);
-	struct device *child;
-
-	child = device_find_any_child(&ctlr->dev);
-	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
-}
-
-static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
-{
-	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
-						   dev);
-	struct spi_device *spi;
-	struct device *child;
-	char name[32];
-	int rc;
-
-	rc = sscanf(buf, "%31s", name);
-	if (rc != 1 || !name[0])
-		return -EINVAL;
-
-	child = device_find_any_child(&ctlr->dev);
-	if (child) {
-		/* Remove registered slave */
-		device_unregister(child);
-		put_device(child);
-	}
-
-	if (strcmp(name, "(null)")) {
-		/* Register new slave */
-		spi = spi_alloc_device(ctlr);
-		if (!spi)
-			return -ENOMEM;
-
-		strscpy(spi->modalias, name, sizeof(spi->modalias));
-
-		rc = spi_add_device(spi);
-		if (rc) {
-			spi_dev_put(spi);
-			return rc;
-		}
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(slave);
-
-static struct attribute *spi_slave_attrs[] = {
-	&dev_attr_slave.attr,
-	NULL,
-};
-
-static const struct attribute_group spi_slave_group = {
-	.attrs = spi_slave_attrs,
-};
-
-static const struct attribute_group *spi_slave_groups[] = {
-	&spi_controller_statistics_group,
-	&spi_slave_group,
-	NULL,
-};
-
-static struct class spi_slave_class = {
-	.name		= "spi_slave",
-	.dev_release	= spi_controller_release,
-	.dev_groups	= spi_slave_groups,
-};
 #else
 extern struct class spi_slave_class;	/* dummy */
 #endif
@@ -4749,21 +4766,6 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 	return dev ? to_spi_device(dev) : NULL;
 }
 
-/* The spi controllers are not using spi_bus, so we find it with another way */
-static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
-{
-	struct device *dev;
-
-	dev = class_find_device_by_of_node(&spi_master_class, node);
-	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_slave_class, node);
-	if (!dev)
-		return NULL;
-
-	/* Reference got in class_find_device */
-	return container_of(dev, struct spi_controller, dev);
-}
-
 static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 			 void *arg)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e400d454b3f0..f6fb7bad9a90 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1684,4 +1684,8 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 	return list_is_last(&xfer->transfer_list, &ctlr->cur_msg->transfers);
 }
 
+#if IS_ENABLED(CONFIG_OF)
+struct spi_controller *of_find_spi_controller_by_node(struct device_node *node);
+#endif
+
 #endif /* __LINUX_SPI_H */
-- 
2.44.0



Return-Path: <linux-kernel+bounces-75872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B941085F01C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26628284979
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9F200A9;
	Thu, 22 Feb 2024 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRy22DHV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2A1B819
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573606; cv=none; b=c/BLYryRoq9CMTg3Y83MWqJji/+UvXWfMsuBXxzSQQn3tPNrIcjosmJrdGJOqgzR8egiIvicm4OLn07KRjO4+ZLWz8AeBAMHw6+oJE1VTuO5ny101AEOEDuSp7anjHFempAfdigM50P2AO85mjAUIgyMLA3Q+lw0bECnCm6Vrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573606; c=relaxed/simple;
	bh=BYJ0NZJqbtsDWKL5M2UsBKoeU9XD22jULrfryxgvv50=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=A2W7vmNH1ie5PWB8BloS4tVENmITJ04M8SwhlFYxAFMdb9AHRYfekz2EUFhdPbDKWriKKAWzrakzOYPIT/mhmsx2u3CA2BZ8pgDt08kcHEsO6O+TIT6GF6QchKKbQdSNtO4S81bm95JbG1tDwAwgaNiPPwqu9aEgmFqYVY7e7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRy22DHV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6085e433063so51729177b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708573602; x=1709178402; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=raWZBAYgki529t/WhxJsWod/PF9BbEcSvIxTt/14UCc=;
        b=zRy22DHV0i/8GoOTEt5NG9RaIEs4ONI6qGKz6htHAyLu0Y+ze9SUdiW2cjkX0yaar/
         5py1BMb+AXTxLTxM/r5bmJE/TFtQveF8t6Wh4y7/mE/GObgFuXoGxWoJ0XU3zlQU9Y0l
         MkAZ9LzptdK/LCKuVz9Q4aohP6s4kottbwx+xHwg/6IMFQj+xwCiUSQO2oO5+zfKYP3L
         iCyh2XeE6ocTm9+OUU1ti8E5mdzxOUj3R+ooLnffQtg2CgOgdDcZs6Ej8ixOe5QcCubq
         meaulOtQklEC+J1kZ7eq6BQS8uW4mXGYNol8htPnb0gRT2+jSbrC+kG4X5ZpCydPSwNY
         +sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708573602; x=1709178402;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raWZBAYgki529t/WhxJsWod/PF9BbEcSvIxTt/14UCc=;
        b=ppTbO9oxSnR8hP7p7/wVKlX1prjPUwwM5JPxeBaE0kvw7Mh0CI+qMPPaYCJbb/crTd
         28gO/S6VqSN7nxdK4SnFN4Q15HT7hyd7Ws15HWIcqNO1qhGVVEEchz3n68T80IbNbx/L
         jIFIg9jN75gy2Wu+WR9VNgt4duYC48uEvfV7H+OQKQYogMu2vYwtvqNzCFkNqh3eZ41B
         f988Qlo3ZUJn1xM/K0wbwcis3FUmdXuNlFz9QOLF/qWJ5hM67EKWKHVf7bMGsL6wDVyT
         0ageVRSR1nitZe/+2atLBHpKeQYRAes1kV0Frrj9rlfTDSE1pS/eiMSWwk7qgqR5zdFO
         iFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6npc7tT/Z7vkD98llJBJd5VqG4U+TwIPhrz16zj2DF88oaWSDREUfVUGzdjFcfuMoHKLAl9WcGU8fx2ajec/6QCeLIz7+ejcH4CQM
X-Gm-Message-State: AOJu0Yw86kq88dX6ry8O4EFUNcIqggRYPNR5MURQZQr9Ul+cByphPrCT
	Mltc5vGY1IvSipwsWY0Vx5GJn+yP1DB5kAFHDAU0zrIucHXGMkyYAAZ8Mfi7LQC2vfgPTmXo9QW
	fCQGZiE3usQLZ/w==
X-Google-Smtp-Source: AGHT+IE/lOZLkCoDwwKEREqFgcV+j6qm2injtDVFnE3QKKkoaWAEUaYOgBuNsQDaJd9X9bCZCw8l/KV68FOgUzU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:451c:c6c5:1fb1:a2a1])
 (user=saravanak job=sendgmr) by 2002:a25:b47:0:b0:dc7:8e30:e2e3 with SMTP id
 68-20020a250b47000000b00dc78e30e2e3mr329609ybl.2.1708573602344; Wed, 21 Feb
 2024 19:46:42 -0800 (PST)
Date: Wed, 21 Feb 2024 19:46:22 -0800
In-Reply-To: <20240222034624.2970024-1-saravanak@google.com>
Message-Id: <20240222034624.2970024-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222034624.2970024-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v4 4/4] of: property: fw_devlink: Add support for
 "post-init-providers" property
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for this property so that dependency cycles can be broken and
fw_devlink can do better probe/suspend/resume ordering between devices in a
dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index bce849f21ae2..15ccad6cba4a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1066,7 +1066,8 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 }
 
 static void of_link_to_phandle(struct device_node *con_np,
-			      struct device_node *sup_np)
+			      struct device_node *sup_np,
+			      u8 flags)
 {
 	struct device_node *tmp_np = of_node_get(sup_np);
 
@@ -1085,7 +1086,8 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
-	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), 0);
+	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np),
+			flags);
 }
 
 /**
@@ -1198,6 +1200,8 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  *		 to a struct device, implement this ops so fw_devlink can use it
  *		 to find the true consumer.
  * @optional: Describes whether a supplier is mandatory or not
+ * @fwlink_flags: Optional fwnode link flags to use when creating a fwnode link
+ *		  for this property.
  *
  * Returns:
  * parse_prop() return values are
@@ -1210,6 +1214,7 @@ struct supplier_bindings {
 					  const char *prop_name, int index);
 	struct device_node *(*get_con_dev)(struct device_node *np);
 	bool optional;
+	u8 fwlink_flags;
 };
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
@@ -1240,6 +1245,7 @@ DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
+DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1349,6 +1355,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{
+		.parse_prop = parse_post_init_providers,
+		.fwlink_flags = FWLINK_FLAG_IGNORE,
+	},
 	{}
 };
 
@@ -1393,7 +1403,8 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 					: of_node_get(con_np);
 			matched = true;
 			i++;
-			of_link_to_phandle(con_dev_np, phandle);
+			of_link_to_phandle(con_dev_np, phandle,
+					   s->fwlink_flags);
 			of_node_put(phandle);
 			of_node_put(con_dev_np);
 		}
-- 
2.44.0.rc0.258.g7320e95886-goog



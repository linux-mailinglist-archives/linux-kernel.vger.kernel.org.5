Return-Path: <linux-kernel+bounces-71332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB7485A39F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B8B1C2136C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC232E64F;
	Mon, 19 Feb 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="EUuagCe7"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2C20DC4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346411; cv=none; b=bIFu/dO86QAJNOS0CltCcgguovqJ98sdL4F4R/Ux+Sq0ZXz/TOzhWOLNMXO13LzsuqKBGqXyhWBYZgDj0kaafwbCa/4uLGAi425G6hDZryiGPpAG1PBmM3rtNSUBB8udL90eyNAa3cneo0Mn3eKdl8QwrTzP23X02IHYPfyeiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346411; c=relaxed/simple;
	bh=DbweASTEXHvNHHbDdR8OnHgPokqfSwG7rbh512B1lj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZOzZq1C1UolVrGXaZU+RvtESrTWZ4PSsnmwAC1D9smSfv97dWBmXMRgbZLUe8nr6Z9hr6Vc5cm/7FYsGMEhLHaEml8MVWShXQowHEd7iexGdkXPSbw8iMSGTpmC18mr7qdzuCSAp4+ZLpGMb9HWT11+vMpq0Cd9O5/Qekminotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=EUuagCe7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93edfa76dso23387875ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346409; x=1708951209;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqp09n7s8zSXfMfH82VCiLrRu+5FdThwynVc1xzdBm4=;
        b=LkYjQ51LbTIXGxpt8CZeZM0I1HN0rT1xnhnaR/0c16+eOAmxEvRPJZ7QdERSvTimc9
         2nudSF2JwWHErqocWwKO8e04TvaDUTXjVxn6hGHpWCy5VDNdrMvC20dTyCKoOAyT3xzm
         O9v3SFdPEo6tj2U6MACnQG6iy7JUEuRPOFKS73IcWnLP0W43a+YgelHObo+767RlX0Si
         Wn80Dwb4BldNVps0kZoqg3wY1b5jkSzV+ysIyblvhHUoUMfQVM59rgA6HPbA5Ye7ggUS
         tkBDIVVkmB6qRrQHT1Oy4Dy3ePkCRr4Z8VCoZbWYWTnL7ZEqSalwiPeOxRQ7kClzxJCl
         UICA==
X-Forwarded-Encrypted: i=1; AJvYcCW0WK0qlDLARa/iNdfOOSFfgI1gGcPMRQjV4QM6QRDqVexoxOp7Trz1yJWASelorWn7EB3y6PpswWZu0t/fScnKJ5QTqJvg17oSluWp
X-Gm-Message-State: AOJu0Yw4wR9qMX49xGs0ZtClKr61O/ohQpJWh3zrru6yILt32V3/Pbiu
	2oSw7g4A7HkV76ENXbBxnyKVlzvMK0ikBtTBKyN9fxQXBo7x1migtwnsD9q4xCgFcA==
X-Google-Smtp-Source: AGHT+IEzOcyrQNaeZ8NHui8RLhzYqr7vsb1ZnJ2FVHcLfKWy/PFZRAzAJT3hrppWWRPLFRqdpj/2wA==
X-Received: by 2002:a17:903:986:b0:1db:db5e:6712 with SMTP id mb6-20020a170903098600b001dbdb5e6712mr6666851plb.58.1708346409476;
        Mon, 19 Feb 2024 04:40:09 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001dba739d15bsm4264878plo.76.2024.02.19.04.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:40:09 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708346407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uqp09n7s8zSXfMfH82VCiLrRu+5FdThwynVc1xzdBm4=;
	b=EUuagCe7S/6/yXzp7Z3+rQT/7HoQMInIBNUcLZr6wE2f29W/TyU2goKrx7h4lAd+XZ4CH0
	otEKx/7M+n5pbPmrNK+dJoWwhT1BnAeSJutBy2ckrJLnlOPhceKi/MWTrjCv5wwh05mPGu
	Av/kffvuaqnETo7hfCh5ZeMBrCvpHmMiuG4KnzXqzg0MVFYK+MMzGjx/p2wK96Pld88fu6
	sG6pF6wzjsbyFn6xflvUnWDt+psrdwUKGVBaUNoRgkJEM/OfK3g225yILhOAsXM/PzmUpX
	/HrT+Hfad7fsIZx5nwgCo20H6VcVwwZY++rp/HWB0wBuZGCsy61Fjf8n0ZjPzg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:40:50 -0300
Subject: [PATCH] greybus: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
X-B4-Tracking: v=1; b=H4sIAFFM02UC/x2M3QpAQBQGX0Xn2pbdyM+rSOL4cEpLu61I3t3mc
 mpmHvJwAk9N8pDDKV52G0GnCfE62AVKpshkMpNnRtdqihKj5w2DDYdaHO4xeMV1yRpzYfKiohg
 fDrNc/7jt3vcD/TXi92gAAAA=
To: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4624; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=DbweASTEXHvNHHbDdR8OnHgPokqfSwG7rbh512B1lj0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00xW7Nefy4TJNlZLv/bpaOaI78TMjGEzcuTza
 Mz/ae//utqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNMVgAKCRDJC4p8Y4ZY
 pnDRD/9cmNomQhIAU/nkOiUExUM2pxbNd/K/pTr+/ohcxYOgdqOfgtbC5S9il98tMlts4r/F5hy
 GDt2vbiHiQF/UNXnwMPuvfOolQDRKmXrZ26yiMUx7nxDNbG9roa31XxhfDqcd2BAdmQ8H+Xy+1a
 yJZmg1Cmi1FTZtcVx6MLKU8VFHGGRUzLCwhn+pRcwbongd8hyQopEE4/Pul2p/j4ldJr7J71gw0
 xIPG+o+QR3RZs+IPY+HSsfeQbcp1WaRuBOmxsAQgGjO37p88RsYVCF4EQkPPcAvRcD48kqFu2zX
 Ed/7GzEVxHmHNibdJMdqe+fLj+Rzhb9jnT/eDlDx7kt+i0PQEWhDi7lFWEn9kBGh5qud0+NudMG
 qHossSpY1bciBdZBT06i5pQkzPjaJjPn0EDdSYks1IQeUVkjcoSQ2qSxFp2mQe1Ow72nxvY3T9Z
 956FyeP0HaoXIxG4ume5kX0OoDMyrvAd/m66CDCa5NSidPwG0w+B8CIwPWhM7RdJKWG4huGotwS
 BD+wRxJUYiIC9EGpzBp8ajQhpeFbcxul7GFx+rFg0BpSBRPU27YMouLi3bqsx/yLWltRcRwcB2P
 ztewUH/6cKFVjYqLEbOS8ekKbnuzSG+TdoOwqphtMBNoSA0PTqdEw3hAKYPR5NLFJTv38gv6Mm6
 CIFsZbDoo6J7Z7w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
greybus_hd_type, greybus_module_type, greybus_interface_type,
greybus_control_type, greybus_bundle_type and greybus_svc_type variables to
be constant structures as well, placing it into read-only memory which can
not be modified at runtime.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/greybus/bundle.c    |  2 +-
 drivers/greybus/control.c   |  2 +-
 drivers/greybus/hd.c        |  2 +-
 drivers/greybus/interface.c |  2 +-
 drivers/greybus/module.c    |  2 +-
 drivers/greybus/svc.c       |  2 +-
 include/linux/greybus.h     | 12 ++++++------
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/greybus/bundle.c b/drivers/greybus/bundle.c
index 84660729538b..a6e1cca06172 100644
--- a/drivers/greybus/bundle.c
+++ b/drivers/greybus/bundle.c
@@ -166,7 +166,7 @@ static const struct dev_pm_ops gb_bundle_pm_ops = {
 	SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
 };
 
-struct device_type greybus_bundle_type = {
+const struct device_type greybus_bundle_type = {
 	.name =		"greybus_bundle",
 	.release =	gb_bundle_release,
 	.pm =		&gb_bundle_pm_ops,
diff --git a/drivers/greybus/control.c b/drivers/greybus/control.c
index 359a25841973..b5cf49d09df2 100644
--- a/drivers/greybus/control.c
+++ b/drivers/greybus/control.c
@@ -436,7 +436,7 @@ static void gb_control_release(struct device *dev)
 	kfree(control);
 }
 
-struct device_type greybus_control_type = {
+const struct device_type greybus_control_type = {
 	.name =		"greybus_control",
 	.release =	gb_control_release,
 };
diff --git a/drivers/greybus/hd.c b/drivers/greybus/hd.c
index 72b21bf2d7d3..e2f3496bddc3 100644
--- a/drivers/greybus/hd.c
+++ b/drivers/greybus/hd.c
@@ -116,7 +116,7 @@ static void gb_hd_release(struct device *dev)
 	kfree(hd);
 }
 
-struct device_type greybus_hd_type = {
+const struct device_type greybus_hd_type = {
 	.name		= "greybus_host_device",
 	.release	= gb_hd_release,
 };
diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 9ec949a438ef..a88dc701289c 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -765,7 +765,7 @@ static const struct dev_pm_ops gb_interface_pm_ops = {
 			   gb_interface_runtime_idle)
 };
 
-struct device_type greybus_interface_type = {
+const struct device_type greybus_interface_type = {
 	.name =		"greybus_interface",
 	.release =	gb_interface_release,
 	.pm =		&gb_interface_pm_ops,
diff --git a/drivers/greybus/module.c b/drivers/greybus/module.c
index 36f77f9e1d74..7f7153a1dd60 100644
--- a/drivers/greybus/module.c
+++ b/drivers/greybus/module.c
@@ -81,7 +81,7 @@ static void gb_module_release(struct device *dev)
 	kfree(module);
 }
 
-struct device_type greybus_module_type = {
+const struct device_type greybus_module_type = {
 	.name		= "greybus_module",
 	.release	= gb_module_release,
 };
diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 0d7e749174a4..4256467fcd35 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -1305,7 +1305,7 @@ static void gb_svc_release(struct device *dev)
 	kfree(svc);
 }
 
-struct device_type greybus_svc_type = {
+const struct device_type greybus_svc_type = {
 	.name		= "greybus_svc",
 	.release	= gb_svc_release,
 };
diff --git a/include/linux/greybus.h b/include/linux/greybus.h
index 18c0fb958b74..5f9791fae3c0 100644
--- a/include/linux/greybus.h
+++ b/include/linux/greybus.h
@@ -106,12 +106,12 @@ struct dentry *gb_debugfs_get(void);
 
 extern struct bus_type greybus_bus_type;
 
-extern struct device_type greybus_hd_type;
-extern struct device_type greybus_module_type;
-extern struct device_type greybus_interface_type;
-extern struct device_type greybus_control_type;
-extern struct device_type greybus_bundle_type;
-extern struct device_type greybus_svc_type;
+extern const struct device_type greybus_hd_type;
+extern const struct device_type greybus_module_type;
+extern const struct device_type greybus_interface_type;
+extern const struct device_type greybus_control_type;
+extern const struct device_type greybus_bundle_type;
+extern const struct device_type greybus_svc_type;
 
 static inline int is_gb_host_device(const struct device *dev)
 {

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-greybus-c97c1ef52458

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>



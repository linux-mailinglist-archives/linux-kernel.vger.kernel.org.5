Return-Path: <linux-kernel+bounces-70544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C5859907
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F2A1C21190
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4F471B27;
	Sun, 18 Feb 2024 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="NJeG1C0W"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B694871B2E;
	Sun, 18 Feb 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283858; cv=none; b=PyVA8u3o+CUPaGSAOBE+CkVNkt8idPpYwTcMrmOzdNfwo2aC582oqSWb70V1pW5cJ4HnpzYNTHI1JDa1E1b5aRPkXvAxVQCEP0AyTPhU4R3GWHUqovJOXtcTVFcs77QDwAbNoVhpSEZQ1m7sLfLdpily1ltZBT1bWH9BkJRLjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283858; c=relaxed/simple;
	bh=t6x/ZRYulTG708GhFefbeSEFl1szUQdpUP2dWsVwTs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBPu+kL1jlzF8I0JjWFsGbXFUeB+sP7Js1oxcfFYF+xuFRo+13q8VjgdWpKD2AlUQ8I+SY7KlsVgbPWVNM73i6tMNz2S44Md2UK0BPERN1CnPRqMZjTLVP5HTOHcx9ELeHNxdmqsdp7FHA3/fNR2eK4+Ewewrj4O2I6XlMHprwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=NJeG1C0W; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso3067833b3a.2;
        Sun, 18 Feb 2024 11:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283856; x=1708888656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8qO94QSFDmkAfe4dTVfqhOrpLyIFW/SZ4BSF/6KA3Y=;
        b=U1SjWzuYiVjvQ9Ktjkxx5v20clQt8lVkGzOjKmkxY5EwX7hGvURglU3jplam06wGBw
         DmgfJ47/igMNzPvpVEqZAf1df9az6ueXGW/av7HzkSpfiMwQ6/8hmLAepA3C+/uzmpju
         j6O+1sCGknB2yE1C39cjl2SyPo6QMkz2oIWOBe5OSGtaKQmtrO0Mcte0sFLwVTEQip13
         Zf2LViDpUI3YZyqpxZs5wW67wUooOoa9X00YUNe+nmAqlSpSxlIyBFLIusjyPqBi6fHV
         hYAbNvu33tg7Jo1PCufEDP4wHEujIAJPDdTAGG2ZswdUosJfhV88DG4rIJbXZ0tk8WXN
         7kwA==
X-Forwarded-Encrypted: i=1; AJvYcCUbivqqaUfA6SV8ySglYDEjTZpXVioQn5oq/WRhdeoPo6IA/gOPoKh8fxMqm9Muy5WvSd7eDu6vHCfV1ph+aU+RX+dkqsVVRs0ytZsQ
X-Gm-Message-State: AOJu0Ywm4Q3XU9Bh42I6hJv+YGKBBhg+/sDMhZEEAq+VZjS7xFpWTs+4
	up0SCtQV0tOsVbHJMqvJLrMqU0FwqCo1Fgid4ADZcSnSR4/rMiblyC3Q54VPwQSukg==
X-Google-Smtp-Source: AGHT+IGdpBVwQlsOpG3K0M5nxy3WkpuZam6+fwp2r8RgxhI6KyY5sW8pK+XNrWLJDPFpdImWDT34rQ==
X-Received: by 2002:a05:6a00:1b42:b0:6e4:5a01:1b4 with SMTP id o2-20020a056a001b4200b006e45a0101b4mr1040827pfv.8.1708283855911;
        Sun, 18 Feb 2024 11:17:35 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n7-20020aa79847000000b006e43c263cf1sm1360473pfq.185.2024.02.18.11.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:17:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708283854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8qO94QSFDmkAfe4dTVfqhOrpLyIFW/SZ4BSF/6KA3Y=;
	b=NJeG1C0WWBxnPQSqYr72KYe2qn9gnvlvWTlC2CEqn6ZUYhZHpdt76a7rWt75PFPJeCXMxS
	+WEyIFamykosXa9KnRT9Z9thP644hl12taMO2oFYBNyr0yt6K6Dw290iep+Rh9xwG34ZUC
	gz1vQANWK8RE80UkArTx0LyVR+uINAmwlYJ+8O+6vYY4gnCcfUWojvX6XzW2arnJkp7Xpl
	gtFKOSyVDv4BcIe6VryQSTATl+zrpDc4wdDEwRFGeB6SpnhM0TWDsThE9ImcPzuiecsG1h
	Qi9jHzOO91j8H0Goot9+3G6Z01T9STacemd+XoZmmTeoshL5fELq8rqs/l6U2w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 18 Feb 2024 16:18:09 -0300
Subject: [PATCH 1/4] usb: typec: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-device_cleanup-usb-v1-1-77423c4da262@marliere.net>
References: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
In-Reply-To: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4971; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=t6x/ZRYulTG708GhFefbeSEFl1szUQdpUP2dWsVwTs4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0lf1czi/cExGsCNDi2qIVX6RXMBwDiC1OQwzK
 yS/12GPOkiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdJX9QAKCRDJC4p8Y4ZY
 pqwnD/0XxI+dN1COkr7ACdhtjVtszHj+xU+RKB8lXEk+PZLk/4bIr45gYXtydNAxzryTKrZf7Rq
 yoOubCsjHv9wRILA3JGcygk4kSTY+q/nODzUeLRHHPeEPbs4yhqieGDT2kBMpbhR1VRHWfOKKc8
 tJvyP5mGQXQLBAjwoIqONArMu0mdO2iBnNGqe2M/VJbrT//sQPJDPQIBr46DujGWu1iMxx1c0KB
 1mNpXQ6efUs2Hl1aJ19y68fSl6+RJq1bD/d3zO+N4Nr8pg3UGRXNFcBFiEtkmaFDG4Mt+xiYWjf
 FmxiLNi06D9Brz3aFe6rHLOPSiq86E+98kwwEzOiaYJyaJnJH0UudxYKAgJF9OuPQan1G9SpdR5
 Ml31uIsqItk/pXrWtznMc2GrJsu2JK4eOnW53pOcdPCDIedhRhn4U9vOCN+q1/v58/T40VoQCNN
 HyCKVGhueh89XfgIF4UsQu+dhGXH5icL7Hjfvr5hjmw01BhJ0j0zkbvvjwsvtwaUyUS2hkYwM1M
 EJeMo8zjudD4gzpVexEkURuQS4dXajXAnUZsO5CpDC/AW7ztHdPk2oQUcnNhod5QD+4tCu1Yl36
 DDteNKBWgvXl/wCGlq9NHx/+9UlYwZ7Qd3mPTQQihrPtpzu+F9OZINQB2dZq8VvB+/06P11d5f0
 nXykaZGu4VxQIPA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move all the
device_type variables in use by the driver to be constant structures as
well, placing it into read-only memory which can not be modified at
runtime.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/usb/typec/pd.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index b9cca2be76fc..d78c04a421bc 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -157,7 +157,7 @@ static const struct attribute_group source_fixed_supply_group = {
 };
 __ATTRIBUTE_GROUPS(source_fixed_supply);
 
-static struct device_type source_fixed_supply_type = {
+static const struct device_type source_fixed_supply_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = source_fixed_supply_groups,
@@ -182,7 +182,7 @@ static const struct attribute_group sink_fixed_supply_group = {
 };
 __ATTRIBUTE_GROUPS(sink_fixed_supply);
 
-static struct device_type sink_fixed_supply_type = {
+static const struct device_type sink_fixed_supply_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = sink_fixed_supply_groups,
@@ -213,7 +213,7 @@ static struct attribute *source_variable_supply_attrs[] = {
 };
 ATTRIBUTE_GROUPS(source_variable_supply);
 
-static struct device_type source_variable_supply_type = {
+static const struct device_type source_variable_supply_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = source_variable_supply_groups,
@@ -227,7 +227,7 @@ static struct attribute *sink_variable_supply_attrs[] = {
 };
 ATTRIBUTE_GROUPS(sink_variable_supply);
 
-static struct device_type sink_variable_supply_type = {
+static const struct device_type sink_variable_supply_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = sink_variable_supply_groups,
@@ -258,7 +258,7 @@ static struct attribute *source_battery_attrs[] = {
 };
 ATTRIBUTE_GROUPS(source_battery);
 
-static struct device_type source_battery_type = {
+static const struct device_type source_battery_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = source_battery_groups,
@@ -272,7 +272,7 @@ static struct attribute *sink_battery_attrs[] = {
 };
 ATTRIBUTE_GROUPS(sink_battery);
 
-static struct device_type sink_battery_type = {
+static const struct device_type sink_battery_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = sink_battery_groups,
@@ -339,7 +339,7 @@ static struct attribute *source_pps_attrs[] = {
 };
 ATTRIBUTE_GROUPS(source_pps);
 
-static struct device_type source_pps_type = {
+static const struct device_type source_pps_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = source_pps_groups,
@@ -353,7 +353,7 @@ static struct attribute *sink_pps_attrs[] = {
 };
 ATTRIBUTE_GROUPS(sink_pps);
 
-static struct device_type sink_pps_type = {
+static const struct device_type sink_pps_type = {
 	.name = "pdo",
 	.release = pdo_release,
 	.groups = sink_pps_groups,
@@ -371,30 +371,30 @@ static const char * const apdo_supply_name[] = {
 	[APDO_TYPE_PPS]  = "programmable_supply",
 };
 
-static struct device_type *source_type[] = {
+static const struct device_type *source_type[] = {
 	[PDO_TYPE_FIXED] = &source_fixed_supply_type,
 	[PDO_TYPE_BATT]  = &source_battery_type,
 	[PDO_TYPE_VAR]   = &source_variable_supply_type,
 };
 
-static struct device_type *source_apdo_type[] = {
+static const struct device_type *source_apdo_type[] = {
 	[APDO_TYPE_PPS]  = &source_pps_type,
 };
 
-static struct device_type *sink_type[] = {
+static const struct device_type *sink_type[] = {
 	[PDO_TYPE_FIXED] = &sink_fixed_supply_type,
 	[PDO_TYPE_BATT]  = &sink_battery_type,
 	[PDO_TYPE_VAR]   = &sink_variable_supply_type,
 };
 
-static struct device_type *sink_apdo_type[] = {
+static const struct device_type *sink_apdo_type[] = {
 	[APDO_TYPE_PPS]  = &sink_pps_type,
 };
 
 /* REVISIT: Export when EPR_*_Capabilities need to be supported. */
 static int add_pdo(struct usb_power_delivery_capabilities *cap, u32 pdo, int position)
 {
-	struct device_type *type;
+	const struct device_type *type;
 	const char *name;
 	struct pdo *p;
 	int ret;
@@ -460,7 +460,7 @@ static void pd_capabilities_release(struct device *dev)
 	kfree(to_usb_power_delivery_capabilities(dev));
 }
 
-static struct device_type pd_capabilities_type = {
+static const struct device_type pd_capabilities_type = {
 	.name = "capabilities",
 	.release = pd_capabilities_release,
 };
@@ -575,7 +575,7 @@ static void pd_release(struct device *dev)
 	kfree(pd);
 }
 
-static struct device_type pd_type = {
+static const struct device_type pd_type = {
 	.name = "usb_power_delivery",
 	.release = pd_release,
 	.groups = pd_groups,

-- 
2.43.0



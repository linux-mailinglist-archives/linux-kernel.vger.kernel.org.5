Return-Path: <linux-kernel+bounces-51714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32854848E88
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654CA1C21A10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364A2260C;
	Sun,  4 Feb 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="qFu3M4s3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22102230C;
	Sun,  4 Feb 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057593; cv=none; b=ukpMYaui5MPpS+zsquCKTDBxnTp9Lvd+V9nqicS0QO8ZfXXXDyjcSyP83qyuH9Kk6HeHQ5pE/am6LX2xALnjQnTnzyakgksGvIbBK7iT5f2k6wN9YPSSdphpgZ/tHKYhcUchzpfh7oYCAsCXjHbA/rpMgpJ1vqhZYqY9Hn24rqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057593; c=relaxed/simple;
	bh=y7Np6tLWWpdCtIwpp/IJ4o4JZh5nikX5TUM9wJMdrd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6p/TZRgW/t5xmu9K0LHAZD78KfxOQ+dVIrPSKM9xNgKO8hirqMiGt8mRhgjxAyQqZwA/temOTnlFvcbwcpM30hrabyHImSc0MIqrVKti7lyO4ukBKfVCs7p8kLcZMUM/D5b/oHOz0h7iracEpt24N2PfJtVXz/QhXTOQMV4cqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=qFu3M4s3 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d72f71f222so28662375ad.1;
        Sun, 04 Feb 2024 06:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707057591; x=1707662391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuGDIWyePMJPlEmvb6FvKHxToWSzmOOCGNIDM9oq29s=;
        b=MKIdvNbmeeXmM/f+KLd0BIDxM0j0AxuIUG8hOraIk2sv1qMOELLzA78m51zbvuoawD
         94yURhAhMye3ZAoS4RlXSJm6+5aQaM74eyYd0rOgjBKpsxVCqD2IghXOnf+2hM2MhYEC
         qy6GBuaipCGbrWe2kQlUSxcg53JNwfZCpDSrJyYLIavNJZm0JA63P7wds4VJznsKh7c+
         X0CFylmZ+WT5fHv5ZV45IH4q5d16ttn6c8g9vZbHoTPeoF/ATkYvwEC0tPdrT3dSqs+f
         FovtLhVItp3Zw1lLXKnoatC685nfg+xxjhaNAJjjlrgH+ui8LXrPT8EDPUsa77oO66qz
         9UWQ==
X-Gm-Message-State: AOJu0Yz2292xaybT33sMx6WOYMT1U7Q2uVacb8I0xnQELpRoCq9Q43Ab
	3Blmavkjv9BBXKvqJxG0iIidKx3Ep1PxDIBe09VmBU7H6zze52rM
X-Google-Smtp-Source: AGHT+IF47iBaYdPHXf0P3QhqPQ+a3ySNF35Wrz27r5kJ/DCdEUI7USWH+DPmUw0VtrCmF9eCWnjM9g==
X-Received: by 2002:a17:902:e84c:b0:1d9:7124:a89a with SMTP id t12-20020a170902e84c00b001d97124a89amr7804611plg.58.1707057591144;
        Sun, 04 Feb 2024 06:39:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFaRJwAH1XwZS0PfMdlYUm3Tht5TlPq0oTP9SkuD8imQOdoeZlxBlyz+AkjdSAkrVxculM+OGPhk8NryA23bT+3LSBYRssc78itKLXZRDjk99+hvNyLYPl8qDC0NimOZmizIHH0z5/AwNoUSXp0m6SOVUTB11iqVxqoCgplayaOjbcwlknyES76d+Nf79WXBFHT3FFGltWlcbxb5o=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001d7365fe0c7sm4577546plr.164.2024.02.04.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:39:50 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707057589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuGDIWyePMJPlEmvb6FvKHxToWSzmOOCGNIDM9oq29s=;
	b=qFu3M4s3NjOyG/OVSa5MPeQqjFNignkRuIMmBHMbge+l8bxYGHnonXGUiho3JiA0edI7SH
	jQHfa6grewCkQ1Vtem9Y2HAhD8aqwuOkaopQOzTM11zxsrsSsWog7/aBuzUzRxAuN5vxBH
	pcx4vaTsrmOV8o9zz8409hWIKPZ2s0Osqn5FrUwVfwdOGw+/nxCq/ytApra15uu4KsYXPz
	YV17aBBbtZvbdcPvQosbyNDmU5jxTVY+MaUZ7z+ZzdLP2SLZHEGJCDJfcXxZ3ttZWXHQyn
	mTGnVu+QJ3tEIH/Vsnst8M5H3KLfT11ZA7Q1PTzu+xJqcym9koLYDegalHBlQQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:40:16 -0300
Subject: [PATCH 1/2] platform: x86: wmi: make wmi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-platform-drivers-x86-v1-1-1f0839b385c6@marliere.net>
References: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
In-Reply-To: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=y7Np6tLWWpdCtIwpp/IJ4o4JZh5nikX5TUM9wJMdrd0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6HQaxYZFNBmMncA7xzXrILFnq+CIS5//996J
 4coroW5A/GJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+h0AAKCRDJC4p8Y4ZY
 prDWD/9wfNaXVEL8ZY9gWrC4KrtGnss3tvYm2Is7pKlfPe9GvvBI/5F+JsoVXj/kf2K2kQyo+NN
 9nP6HKRwrXPRiMRkkQ2uRHTKx4o8ddDNbraYOI00dY5uyYNoIRiupM4UoJd/1BR02UDawgl13VP
 FKvn10dm6IQdFf6vxz1AuLOPRx136gYGWGl9UojjAOUkp8XHg6bosJ36vYvTltRDaqtfsQclMVs
 UJZR4Vg3ACBaO8Hew3sUdMGHovMmMLIyKVe2PTxzrdNj5iZdvzj8iYPyHCPnyM4IuvKQo9Kqav2
 7bq7grCsWuhD6rMz5tjFDitScOOnykkkQKkQw7+tHMl/4OUf5ZH/+HY0iAC2+2R2jC6dO3p2ob+
 71bQgis/p0+n6YZwCXS2tomfK6vdET06oFbxDuhNVoBJmOj0HqA9Pgk+WcZJwZI3aO1cHwl6KyE
 TCUIExenNbWAJLh3NB6TiWyw/NTBvcnKZ26WgVYgaLZiEFdm6JEBRxft5NaYChPciQ2dgbNI0P8
 V4o+UfIQSjLrrKO3ErUxG/tBfCJJuWezPH/NgLLbWMWhxr1TowOcJLeaVpsMsvTJl7wZX6957lU
 o/Etm8xNHxZxVN65Kuup5cSUxu6yrmEUxgr9VElVNLmI/yvBThQ+S1v2uQN1S29HMkwQgE/jMbt
 6gUUqEkE8b8Jhog==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the wmi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/platform/x86/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7ef1e82dc61c..859dfff515d0 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -219,7 +219,7 @@ static int wmidev_match_guid(struct device *dev, const void *data)
 	return 0;
 }
 
-static struct bus_type wmi_bus_type;
+static const struct bus_type wmi_bus_type;
 
 static struct wmi_device *wmi_find_device_by_guid(const char *guid_string)
 {
@@ -899,7 +899,7 @@ static struct class wmi_bus_class = {
 	.name = "wmi_bus",
 };
 
-static struct bus_type wmi_bus_type = {
+static const struct bus_type wmi_bus_type = {
 	.name = "wmi",
 	.dev_groups = wmi_groups,
 	.match = wmi_dev_match,

-- 
2.43.0



Return-Path: <linux-kernel+bounces-152472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020E8ABEF7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39121C2088A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0B10A03;
	Sun, 21 Apr 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LglZMmpd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46E635;
	Sun, 21 Apr 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713696598; cv=none; b=M8+vVClmtaEjqzwY6tggx/0xbEGqpQ/uhCT/hVRVeXwzotuTIuGG25fbukX7DA4lTz3C6qQmqyuuvjW4qg1NncFQMg2BgBzzEtMwfeHFlZmALezBxiPKgbtlUQh05RfVHv2sMoSmAaKPvPPvzZXqtzKxnlJndd18y5nCFwMywyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713696598; c=relaxed/simple;
	bh=LVoCXclreBgtsmr5oFo4bwowtcM1xBMbzbyZzQ8OKPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdyvgtx4yIfu0qa2zYxN6UYtgi2XCBGkTgXPEjwKtIlsrCNDkEwq7Vry0lfTElxGPsPJRJ/Vkj4APXEF8ffnXqpQPME8z8okuy9iZ6zzDlY0vL63UwHzDAH3kBxyJP+5+iiu9s845aSvDpciaYbAD9HHWFaSgc0ZlsCfCR3kpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LglZMmpd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e5715a9ebdso27943875ad.2;
        Sun, 21 Apr 2024 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713696596; x=1714301396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YMdAkat8vhxj4dx4OSt4iQjjgWZ4TG1gL8TgMmCIgQ=;
        b=LglZMmpdmB2iNReXBceIvzKkqqAudNo47CaUwP3f5WKWf3n9Lhu2AVwc0PbHhyiaNX
         jydX6RtpjdPmgsHjE3GXoCZdrXYd1GTZJAq4eqcEB3nI3xjPCS6QNuFjD2lfaSd69pNR
         aIsUkIEC8c0eb+uvFajDhclgTmoQbAxCX1ZC5VG4mTsEYuJ0Ruf7N60XPqHPQ9pW7BPN
         whivV/dkiLPX33LM/eQu/ltIHWx7RwhJc2aB2JlR0HX+nqjVETA72zmmDEtR29CBTz9L
         3GENIyH4FfulpxCYBp+jnsEKpKnb3wgnRSDa9UL2dPg+mhjJyi5RfjFjAmdmi/wvfnO+
         bhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713696596; x=1714301396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YMdAkat8vhxj4dx4OSt4iQjjgWZ4TG1gL8TgMmCIgQ=;
        b=l1vcsSwaeb3UiuKAbKQDMT2Y8Juratos70xdmQEfSMj5nhc9Q6J2K8R+1rK61H6evh
         doQ35YYUkt+rtW+FeJE8qeLAmVmFlh3ZrzUlENk6NM6rb40BVKs8BghO8KVgtE16eFCa
         qoesQ3tWbOI5iXGnulczKeG9jLVuZVoe0jE1WriktaKbmdZ6wDm+y2BkuxuECkw34pY1
         UVsavEyxzaHoB/LD3OwfctZ3zlmntCTdBcsDUWlnlFtSP9SRG6OpSXWXUce1RrA4nFVg
         R/FWV8alpAJzYh/bdblZgwT1MsaYvPm5qYmEnDYCEZ5y9/EJhvvWP+md2f91J5nImpht
         EBFg==
X-Forwarded-Encrypted: i=1; AJvYcCUWIOX842bJ+Zgn8KhtleHkp99+h3EwkksnaoYn8ht0jkk/5Qsmp/oXWJ0iiyIO26/uRnpUKVI0kmD9/gTPWZeSOV6we5UXncrCmcPfSfJge2ScWI23hIp3eVIBzK2rmBxqbN/t3BKrW/w=
X-Gm-Message-State: AOJu0Yz7I5I9GLoWX6pYjl/udjiLkwDJGus6N50OihJqVd0ilr9Z8sTO
	RMGMqlSmCibqLh7Pp4RIJTbtoNrjs1sOcX3ANuKxDMje8Xvpi6yFe5vv4Xdb
X-Google-Smtp-Source: AGHT+IEQvoqu3PAcMjoIH/OZqy7yDGFXPIPisC1PaUDN4HjBqxOcFxicJw16ppg1tMDfL8/OtDH0uw==
X-Received: by 2002:a17:902:e5d2:b0:1e4:6938:6fbd with SMTP id u18-20020a170902e5d200b001e469386fbdmr7137713plf.7.1713696596443;
        Sun, 21 Apr 2024 03:49:56 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.158])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b001e49bedbfa0sm6133088plp.285.2024.04.21.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 03:49:56 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH v2][next] backlight: sky81452-backlight: Remove unnecessary call to of_node_get
Date: Sun, 21 Apr 2024 16:19:17 +0530
Message-ID: <20240421104916.312588-2-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`dev->of_node` already has a reference to the device_node and calling
of_node_get on it is unnecessary. All conresponding calls to
of_node_put are also removed.

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Changes in v2:
    - Change commit header and body to better reflect changes
    - Remove call to of_node_get entirely

 drivers/video/backlight/sky81452-backlight.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index eb18c6eb0ff0..e7cae32c8d96 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -182,7 +182,7 @@ static const struct attribute_group sky81452_bl_attr_group = {
 static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 							struct device *dev)
 {
-	struct device_node *np = of_node_get(dev->of_node);
+	struct device_node *np = dev->of_node;
 	struct sky81452_bl_platform_data *pdata;
 	int num_entry;
 	unsigned int sources[6];
@@ -195,7 +195,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
-		of_node_put(np);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -217,7 +216,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 					num_entry);
 		if (ret < 0) {
 			dev_err(dev, "led-sources node is invalid.\n");
-			of_node_put(np);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -237,7 +235,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	if (ret < 0)
 		pdata->boost_current_limit = 2750;
 
-	of_node_put(np);
 	return pdata;
 }
 #else
-- 
2.44.0



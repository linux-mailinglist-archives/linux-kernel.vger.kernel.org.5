Return-Path: <linux-kernel+bounces-166009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C35F8B94C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831AA1C215D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729F8BFF;
	Thu,  2 May 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/cfPT9/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECF819;
	Thu,  2 May 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631829; cv=none; b=rD3TMCbFzq7oArNzxnr06gx3W4Ts8gTaDbMl+U4eEn6UFeNB5gsbPsY0Dg5TeaVTp1iRr8DaXxo98weXcpayOVsvpr5aaunHkkyfnWegaJo6WuuC6Is2BZMXkvdWlUN1sC8cEwMKUrzSCLYBALp0jaDUn0q2wI3lIO4d7OHlqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631829; c=relaxed/simple;
	bh=+AGde7ihoVL37RNfwg2ChkKnBeZbRb8zV7vZfOgq33c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nH8ToHoir727riz92chxtCR2HLJWu1jCFowP0WbgGFMPE7z7ybXjTYXQx3XIqAdui8CwGOW32M727eP+UfXNmOxhRoveKnEzpPzj24K8ZP2KEg+zgndlgBMv2v7BTt1LPty/pm6uwA7EG2RYGsC1WbimzLc0XCdkCKpWytefl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/cfPT9/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec4dd8525cso19819535ad.3;
        Wed, 01 May 2024 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714631827; x=1715236627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoLV4NBTi5WshpxXLizBmf79HWwJfptg7//iRnwuPL0=;
        b=X/cfPT9/34432LS4NL37vOIFs89N8f87G6haaKx8vVFUfB4mbe7kLFD/koClphcUJa
         YthT8yug3FcSH6vpymlvynraBXxgq52jMrU6X91feSKUwl+miBzhyQUArMD7KaGhVGBb
         OZnN6gKm2gk0pfaRJWxNvQFECYDTUSWcpz8wACCLy3+capfGfOYjyI7TlQoNLVPjPxFR
         1oYKkh+4rH7i8TGGQY42e3BjgaHyWDgH8iVc7scaOohAfAY2cZ9J4lTJ5VOO59D4jmoJ
         hmhQqll4Tvd46BP0Lnp2/9wRE0QOga2s1LirWFNZ6dQrBcCysZMYdxBKId1wWz3Fm2wf
         b10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714631827; x=1715236627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoLV4NBTi5WshpxXLizBmf79HWwJfptg7//iRnwuPL0=;
        b=hsSxGBgbgGdjfNZU3ayomvocVsfy93JSqq4YsZJZtPnn5XerMPl/eHCXxnNu1dx63h
         S32g6YfcMpWawzpSLSDKDBRs3QGTkn4iDP7NHdb839Hf8bm6aVcVgxNkPLOqkADFwews
         DxrR0aofjmH29xwM5jN8OQfJZ4LYJIGz7XlAnwWkEuqGAMQuyJoYSiV7t1/y3Cg0z7O0
         VhboLr5Nw7POPo8FZ+vRsJR60dgAyVi0nok95ArY989FQ2VUrEEGojkpoxIzDDGbZZ9S
         Gt1inXBL4sDGhHM5/0anYj7oQtSTAP2zm9tx5Ca7F3cQzHS3aAKNAo64OtPIInDhPeTs
         xePw==
X-Forwarded-Encrypted: i=1; AJvYcCULIKhSudAQzZNJnsSiQHPoa44RjJ5qQ6a0k9836a+b+GK9Pn/KtjyAHwl4j0sNr4oDi/vZrCgJhZ9MFoye/rGccadCGqs1wGg2v9S9ZqCw+Jn4j9XdN3AblwIoWzWpC6HLN7MAVTtOOvw=
X-Gm-Message-State: AOJu0YwzJP4vKnqnclmiChYtkd6NCb7B9sWQe37ag6Kq6cin9IylEvXG
	LXd0ZWVHp1YS6Csn2PaPWCmUC7Fb1Pte9dcByB+DQX5z3eKDsfIj
X-Google-Smtp-Source: AGHT+IGRsFloWjksJZp0KragxTnZKgqBKV04pCsU3xT3150e9iJsRxDV8vqtiXoBmaMkF0RRlmSAFA==
X-Received: by 2002:a17:902:e883:b0:1e3:e4ff:7054 with SMTP id w3-20020a170902e88300b001e3e4ff7054mr6427245plg.38.1714631826997;
        Wed, 01 May 2024 23:37:06 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.146])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170902fb4400b001e8d180766dsm450881plb.278.2024.05.01.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 23:37:06 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	julia.lawall@inria.fr,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH v3][next] backlight: sky81452-backlight: Remove unnecessary call to of_node_get
Date: Thu,  2 May 2024 12:06:22 +0530
Message-ID: <20240502063621.65687-2-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.45.0
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

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Changes in v3:
    - Remove unnecessary braces

 drivers/video/backlight/sky81452-backlight.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index eb18c6eb0ff0..19f9f84a9fd6 100644
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
@@ -194,10 +194,8 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	}
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		of_node_put(np);
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	of_property_read_string(np, "name", &pdata->name);
 	pdata->ignore_pwm = of_property_read_bool(np, "skyworks,ignore-pwm");
@@ -217,7 +215,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 					num_entry);
 		if (ret < 0) {
 			dev_err(dev, "led-sources node is invalid.\n");
-			of_node_put(np);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -237,7 +234,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	if (ret < 0)
 		pdata->boost_current_limit = 2750;
 
-	of_node_put(np);
 	return pdata;
 }
 #else
-- 
2.45.0



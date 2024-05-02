Return-Path: <linux-kernel+bounces-166778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C9D8B9F68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED6B286C66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004016FF41;
	Thu,  2 May 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOwoRAri"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87616FF38;
	Thu,  2 May 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670640; cv=none; b=NIZyHdjgFPV5nrtugjebqJDE1azLMHvDq1P48A/oZdLhZll5wn8r6TbRULhpPtjjm1DPhfbi7pt4oo2f2c3OcRbOfmGL7ugLtFswwRl8v537Gy+pVBboBmXv9T4jN2lZ+ew4p06kkfCCUK0xPaIJm8nteaQUR2bBgjXs/Y5exrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670640; c=relaxed/simple;
	bh=+AGde7ihoVL37RNfwg2ChkKnBeZbRb8zV7vZfOgq33c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFRgwvY4uBN9/u4qREd8Zja+owqPC4qzzCKasaJ0gR24aXr4vQLyMHhOOhzR44r0nqgzcrq9s6m6QAgTe7YOP+02c4lXaZaov2rbk3Gh/Tq/+nYP6SZ0dHQdwE3LCVp7cWuWVlELNs2aUF9xYF64lubMgOGN4vb+LhHjTuavj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOwoRAri; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so25319805ad.0;
        Thu, 02 May 2024 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714670638; x=1715275438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoLV4NBTi5WshpxXLizBmf79HWwJfptg7//iRnwuPL0=;
        b=hOwoRArihruWh461sb14KUBy2pt34t0m5KO4CDcaWWdHjmV92ae9UQ7+QtCjaRYlDw
         uys/S8AAbO1h8bCZi/yfsueSpNWTsRUOjSxVovIgNqNDTAFPWZ+q/809wLL4E7vkfi9G
         OVcDYeZzoszbF+KcXxN8zhdQfdFTwrgImXknLKc1nUXprrBjczODuZkfY1M7FNeJxEmo
         xjF91PxwHSOJeDKed4+mBmcEPj16KHsyIEVSdlHImvu4yo+k6Ii7tgx+omEIIdSETd9q
         TCt87muL7qOBUfHMSjMjl7Ur4C8Be4oHWpf5CqxnEfXy+j/u9BL5O046CvYV4o875dbA
         dO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670638; x=1715275438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoLV4NBTi5WshpxXLizBmf79HWwJfptg7//iRnwuPL0=;
        b=ajfmtpJTftrnNYPLUx5tD1Ir4ThRR9chrCzt8st+Aj2/0h9FLsnMbTY2FnIAnM+0xb
         5+sOlm8w9xakReHena2feVTWZyQTmFY75mAlBOX8fpDDMsdSlZP7jZj/PqcedwRlRccC
         w+2/8XYxnuEdMJ49m//sFtVltppT4u3ArLtDh922P1+rTYJDmnPE3162PNX6Q4X/3DfT
         U9AKJHcNMR9ftOiq/ifa+1mlnaL/ywQichGZm5Dc2U+fI2md24o9h2x9MWuetpAELLiQ
         SOGEf1/xZWoybFIpn9BAm3gjnsbqb6eeVwfBER6zlfsR3Tp/ka0/3Jxl1GJqdYbNo1Zz
         31sw==
X-Forwarded-Encrypted: i=1; AJvYcCVBbkIQucZVsWGzE78woDhBUsClhJdR4UAQ3vZYRq1aubpvxBvhj6g4AyD7nk0wRTMPJc7WTUEyl+75/pwzijlQZlIx1y4ps37AusLRoN75PdsOvmPhBwfMPen1ntKoejtpRUUfNsSy7/A=
X-Gm-Message-State: AOJu0Yzcp9x6vOXhc4mxqDsuWiOfq6oLh343AEFiPz/RNKGQyyp0FlDO
	lhWjpOuTirHzs1JPJlKXtIl0FIVzVqJOJXahbCjGfYzVPRHLIvkY
X-Google-Smtp-Source: AGHT+IEyeN+w/2GKnAAXaO0iG1dRQeaeYXXU53saYgxjY5324IkOkLk95/QiEGVAl7Bnc0yRghOx1w==
X-Received: by 2002:a17:902:da8d:b0:1e9:cf94:5bea with SMTP id j13-20020a170902da8d00b001e9cf945beamr433078plx.35.1714670638524;
        Thu, 02 May 2024 10:23:58 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5fc9:c3c6:40e7:b56b:5c47:4a78])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902bc4c00b001e4565a2596sm1568513plz.92.2024.05.02.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:23:58 -0700 (PDT)
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
Subject: [RESEND][PATCH v3][next] backlight: sky81452-backlight: Remove unnecessary call to of_node_get
Date: Thu,  2 May 2024 22:51:21 +0530
Message-ID: <20240502172121.8695-2-shresthprasad7@gmail.com>
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



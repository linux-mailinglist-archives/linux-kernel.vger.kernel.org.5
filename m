Return-Path: <linux-kernel+bounces-112360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9B8878E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0091C1C219B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0B46435;
	Sat, 23 Mar 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHOsttFC"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B72942A;
	Sat, 23 Mar 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200540; cv=none; b=JUv+uMzYr3JomVYn3BVEtvBpZnuzKs4FRahsTy0Sp/lj/iK7AaF+LA/uFcNQBkBtcfjHhDBSi8lkv2I8xVCIsTGPFHRNBkpnlGum4GhXdkoujNXafKmCmIs8kiizkSRYtBIXpRg+G/ou9TpyRAigPf2qAFyAHC7BtbOPM0EO1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200540; c=relaxed/simple;
	bh=yFDUI6x6hmSF8fS6smv8BmO9sfjw/v+7224JoNNkZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPU2J/ms8rIVWniGoYnqS6qpW900HC2/m0l18vrJUTtBvQSJusxMf8s27dQXGmbblgkLCDmQEP5sVx5H6TRxGII9ZdrgMAQvZRvSW84vM69rPnC1m/oCkyDXbyIzAs4z6PwSeocGz4OTNDHh+8aJpprd7iODjAYco1B0Ri2Ezlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHOsttFC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33fd8a2a3e6so1835614f8f.0;
        Sat, 23 Mar 2024 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711200537; x=1711805337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zwG1vyYusOfDUs/yU9E4qQ9XIYsM0NPCoK6QrfbLsc=;
        b=CHOsttFCcjbcUHgOSDCV1KVcdnO2n2KomKbTy8CUY/7/unyQfydR4Ww51/76QktnVp
         yOwFZxIW6vPqujcmaR83VNg+4qB3AUF/NAO0xQVpzVmNADK9aFYZZIzPW6G1LfSHhMGs
         kR0nco3clweE0cS8/5ziBDGcGVE7EzajTGYmEP11a6zH+rODx2dpKAwPCoaiZboW6nY4
         dBMJbVBW0vWr6H9NMh/Y1UmWzhnh5MFNmFPJlN3ZjKW3k89CB/SvlRTNzPKz6K6LcEcA
         TKf57egk5nS6VGrcafalRZA6dyzb93uvO9/GWR0SWbG+wLhtO3pxDBf75T4pJNSqinUH
         eIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711200537; x=1711805337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zwG1vyYusOfDUs/yU9E4qQ9XIYsM0NPCoK6QrfbLsc=;
        b=S9VDSrwj3YEd1qJbd9Urgf/30jS24LNfw9OrTHDsPfZTnkhyOSgrPsO5n0y1gtb4hn
         nn5ILxyxwgovrQTJHqFUfSohD0BkueaguoMzYlXt6x0nGySV+rAe8NzMl7XCSQ0SYuf/
         uLpXuvuZCAldNG51KhqmezsOQOPDHl3g86tGWM7tYr4JG7qbvvy5Z1MqvfWaWPMwyzml
         W6AH5QQVUK30r7+n785r5gvfcMuJhh9gWUfbvrY5Tyg1Oj7/K9zzE98rV+I1kUr3ducp
         S7EFUzPa1xl/XuqR/QUp+E3HPjCBXISOeYoRd+Pqy1BepbBaJ4kAHGVNpSaOw0Aecyk4
         J+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+pOYs4HlBJPrgQYNXGYAa8fiEObDNbVKhjr4ZQMAgURExW1yF4+FJBoj5+JMI4BWubh+wgAcFHrCIBlXZB6qDbKVyJLLhS7QILr3gJEV4M7bH2Mh1aBDVF/ZJhtZr+tehhJsvk5SnRuw1NYhmm6XXJZ+2RBR6+cpOLXeXf0tTHkLVZ/I=
X-Gm-Message-State: AOJu0YxL3uCfDyZBh5M48DT32drQHIhxP178oTiZRyyoLToz8znCNK3R
	XP6I4slNsYx5ry3qfvRIP5YjTILHH9AMii6xB25S9yBGkIBZEWc=
X-Google-Smtp-Source: AGHT+IENR8QMP5qQWKeIGQ/4dPn3qxLpYPx925ZdrXpFlIgCRoyh0lnIm76I/c23VHjVPV1Fe41R9g==
X-Received: by 2002:a5d:5486:0:b0:33e:d461:6c1c with SMTP id h6-20020a5d5486000000b0033ed4616c1cmr1316456wrv.21.1711200536763;
        Sat, 23 Mar 2024 06:28:56 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b00341babb8af0sm3076061wrs.7.2024.03.23.06.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 06:28:56 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 4/5] regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
Date: Sat, 23 Mar 2024 14:28:01 +0100
Message-ID: <20240323132757.141861-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323132757.141861-2-knaerzche@gmail.com>
References: <20240323132757.141861-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rk808_set_suspend_voltage_range currently does not account the existence of
apply_bit/apply_reg.

This adds support for those in same way it is done in
regulator_set_voltage_sel_regmap and is required for the upcoming RK816
support

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
  - none

 drivers/regulator/rk808-regulator.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index d89ae7f16d7a..a6a563e402d0 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -534,15 +534,25 @@ static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
 	int sel = regulator_map_voltage_linear_range(rdev, uv, uv);
+	int ret;
 
 	if (sel < 0)
 		return -EINVAL;
 
 	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
 
-	return regmap_update_bits(rdev->regmap, reg,
-				  rdev->desc->vsel_mask,
-				  sel);
+	ret = regmap_update_bits(rdev->regmap, reg,
+				 rdev->desc->vsel_mask,
+				 sel);
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->apply_reg,
+					 rdev->desc->apply_bit,
+					 rdev->desc->apply_bit);
+
+	return ret;
 }
 
 static int rk805_set_suspend_enable(struct regulator_dev *rdev)
-- 
2.43.2



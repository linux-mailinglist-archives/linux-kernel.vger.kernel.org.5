Return-Path: <linux-kernel+bounces-147208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4228A7104
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C941F229EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD113342F;
	Tue, 16 Apr 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7wpHcPv"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630D1327F7;
	Tue, 16 Apr 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283979; cv=none; b=azlxJ3AN4oiuOTXjBW3qGNR0c1Gt0iBfbLbkFqoCvlVJs/SFgBLeAdb4I32B/VJxZDmlpVmdXqE7KbMjv5ww4TyeyiNVsb+LmQpvKuz6jtGOrWk3uBr/NAgmYXBJ8qV+SVxQcdeGlW6rn8YZnbA/NN3Kb/Ktoo/tALCLXIRztQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283979; c=relaxed/simple;
	bh=yFDUI6x6hmSF8fS6smv8BmO9sfjw/v+7224JoNNkZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMbO3OmCxP4pm4aWhskjqdOLbyOX+S2mKkLfP504EK8EuVVnPKWsKAXml95ewNbWO29QhR2ZntGq6rxeQYvEwQuMgu4H1lB2du4hsDtBzcDvW901rsZuKFZMtskATi4rqQzfVRJEhxFaJOnF5cZ6RBrg/InKwrW+CsA9Vp46lEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7wpHcPv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34782453ffdso2709680f8f.1;
        Tue, 16 Apr 2024 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283976; x=1713888776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zwG1vyYusOfDUs/yU9E4qQ9XIYsM0NPCoK6QrfbLsc=;
        b=J7wpHcPv+WzIMppIKK80xmpVTohoYRgTV4sAeYhz0WY2u8iWyP8X0VOPlOEi3olqvf
         PhdlZk4/l+fD/OXB3d3Woa6zKxYTTKDyQPb34AP6CNVnVblyCMNXdfw/8DikY6eYDHda
         CgZpDdwcC2O0rfaADeEk7X0lQwrneM3nSTRQtssN/PYGvyNNNHLImKZNEPucIG+u5FL/
         Ti3YIfyZ07DVaHNYmyhnGBiahoyuESRUDJtF63m37OMlXMRzQfpHzU2PlUZEgzB6Rhja
         jwYHKB44RW7ACTRf3Ng7DyCn9pSNssE60Bxn8b+cOSvCPZNtgUwIkm8ReuG78VpuqI1n
         8bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283976; x=1713888776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zwG1vyYusOfDUs/yU9E4qQ9XIYsM0NPCoK6QrfbLsc=;
        b=V9fNmz4ExZjSPaVld59ybvhf5qJuzOUbqh2+8IVHASMvb+rUKxAJJjIuaX7EeV3+Us
         G8fifFpNe+fyEJ3+4IeYNP5wotE5/90pDdAt+bge8haRMv86g4Vm+is/tU5AouOjdadv
         yri3jaW1VXuN/eW967V6UI04057Iht13s+W1+lOMPKSKb7KPuCGMbDpPiu/KpLSMX9dM
         wnqh63QwULEfss4YVycX1p0uKnsDUWrzX1S8CbqkVvjsFEX/WSf3NEbiUnq7+Xm/4aI8
         vAS3QgvkCiPB1YzPG8uW8kUuRuc3Si/3moKq5Qy7mgHoFfT6EuzrpA8SG4CM6CXbxzOv
         hOew==
X-Forwarded-Encrypted: i=1; AJvYcCU9DFMRQHInX8nKi7JUgCTREzyfpKjN6wZVG/uKjqTA9KwmCPZxQHlS6qQFiPtBKXUbPfHalMrzuq3QAPDnabByAvc5uJDZPKyzQeKV9appKOFlUFSv6kmsXKbaAZNVJ/DfVBfk/OAucyVyWgcA3OtPCcIymYcR1tYY5MS+vMXm/u6OH4E=
X-Gm-Message-State: AOJu0YwPkdKtg4Ehsw9aPyRZt/D/iVvPAymEUY07laKflm/UEtap+f2g
	zKgsT8iy4WT1t1sk0f2NwiMVKbtsXUK08sdBv7Eofn8StJIPWwM=
X-Google-Smtp-Source: AGHT+IGMe+iJYkDGt1YjasP0yrXzRUUjO+gHKNh67XOXBew5FKSvCvjpXXd96vum10Rf276woMkZ6Q==
X-Received: by 2002:a5d:6888:0:b0:33e:cf4d:c583 with SMTP id h8-20020a5d6888000000b0033ecf4dc583mr10316960wru.16.1713283976632;
        Tue, 16 Apr 2024 09:12:56 -0700 (PDT)
Received: from U4.lan ([91.66.160.190])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe447000000b00343eac2acc4sm15350743wrm.111.2024.04.16.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:12:56 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v4 4/5] regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
Date: Tue, 16 Apr 2024 18:12:36 +0200
Message-ID: <20240416161237.2500037-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240416161237.2500037-1-knaerzche@gmail.com>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
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



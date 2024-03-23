Return-Path: <linux-kernel+bounces-112271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBC8877AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18FCB21218
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD86182BE;
	Sat, 23 Mar 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi+CYqNL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24586FC05;
	Sat, 23 Mar 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184353; cv=none; b=dvGnlqhNaBN+R+Xk9z5qpAIQzqoKmVILXnx40KZfXf5hcH0X5+6dUO6WzEktW7kRkvMLLYkWVriv54xj5FbI0Q4gj2Ae193lYLvyu/t5wa9+iZo0ZXtgyYpvemV1lqriuJP9KlUSklMtAmHPCcnK3AEboMMCm0WDnUIATl3lfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184353; c=relaxed/simple;
	bh=yFDUI6x6hmSF8fS6smv8BmO9sfjw/v+7224JoNNkZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4XdHRgjygCeCUq+gOJj/5JZvk2vHbq8kyKoDsq0rcoij+aHxNicxuIu8dUkjVyqBEpADmUu7stpAxGz7ECAFw3Pti5KDrHy45KJTzyb2AO4gppLuonCliuIlRivRDfFP0WhngWYM4TCFm+HbyK+GBejvHHUt4YNvDUqjJ4OyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi+CYqNL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41464711dc8so23454265e9.1;
        Sat, 23 Mar 2024 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711184350; x=1711789150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zwG1vyYusOfDUs/yU9E4qQ9XIYsM0NPCoK6QrfbLsc=;
        b=Mi+CYqNLMHsIgiWPWpLvtVdH7NyUrUxDa13ckI9ipx0mnueccGCTWYU1HM7cZkIQO1
         Koq/cQCoLv2GZrq8E1mvUSS1GIJf+uHGnjp5WddRHtMUNrQH7OlpRUCCjSbhGpRY28LU
         /ELSy3U/ATcVm/YEh0nOhc+2gWiX3DtdgZUlT0aKe903pYz2Iv5B23nefzD8r2XWKIzr
         NJNh/MryONm6X8txFYR7h3s5mFwGKTaBVNBrGEC9B4UEOYiH/LCTwmiEj6SIM981+Icg
         rnoZfzvlar7dnDTLGtDF8cNbF8cTVtqN7Xrvxy/kTleCIB27Jyy0poKTx6jAYO0JrWpZ
         jI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711184350; x=1711789150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zwG1vyYusOfDUs/yU9E4qQ9XIYsM0NPCoK6QrfbLsc=;
        b=Le9p9ckkwhLKphTUT07DgJIySe+XkW1nOGAdnU2A4C11LyAEpFrcvsD8eB8NZ6XZj7
         QQ48fS6a+piv/vwkdunF33Czjap7Vnkn4xLJ6aCIFVadoVFrE4xeSyIaB6mXncfk8TPi
         NwEjIKwADeV1MBJigjy32YA9sVhIdeKBXibt8YIqy3dmPND/YhJZ+uIk3Yk7W2hngeT0
         S52/2sSxnFnpstpCL1LqtJiPj1LISq2H1mRBH9QCD3dveFfKvbBVApM3nUeJkAzdoYc4
         /Az8v5huY203UX4Nzy79BdZU6MWgJlhHxB/isT7Xx3Q4ZcLhuVorUFWRUZXWEJW8bs70
         YRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx28KVB8ilALlpv08kqWZLVBJ0BIUvcIbzEk2HM6FywhCUwZaOp2h8L82nXH+yBfA7lVZVetAvrfnRCS+NuyY/NFl1d7t/KeREBv7R6vbgyfJ5t3MRBC18JRbi9a9d5MHHrFoEELgW4lWP7aMgXLeiE4hpdCZ1G+/6roGYUp2+mKbN4/k=
X-Gm-Message-State: AOJu0YwIMrcwW9q+/aC/gAqRrOq63aJv6CKtvLu0nHxoFuBOk2EGoE+p
	o/WwJGNN4c4miQf4/P27HfGndARRHyuOd7ntnMGzwlWr69+TRV0=
X-Google-Smtp-Source: AGHT+IHznD+9+YL+PhMqu1olEuo7dDG11iwTI/3gJ3ZJPkykeHsdd1UQWmv/cHmdTlExvD0zfoxT+Q==
X-Received: by 2002:adf:cd0e:0:b0:33e:7065:78f2 with SMTP id w14-20020adfcd0e000000b0033e706578f2mr1187446wrm.40.1711184350521;
        Sat, 23 Mar 2024 01:59:10 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6b50000000b0033e93e00f68sm3965031wrw.61.2024.03.23.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 01:59:10 -0700 (PDT)
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
Subject: [PATCH v2 4/5] regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
Date: Sat, 23 Mar 2024 09:58:51 +0100
Message-ID: <20240323085852.116756-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323085852.116756-1-knaerzche@gmail.com>
References: <20240323085852.116756-1-knaerzche@gmail.com>
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



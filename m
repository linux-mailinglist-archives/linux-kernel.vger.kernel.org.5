Return-Path: <linux-kernel+bounces-110161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C8885AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354111C2121A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426BF8662A;
	Thu, 21 Mar 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjrIB8hv"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64686256;
	Thu, 21 Mar 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031987; cv=none; b=bDJhVpb/ApyBhRNcs9nQ65kS2+xUB02auMR7v6DHGfsnRZVCornEtRONu8HBPgaqodOV1bOa6yXoitU60gs/F9LsKzBzb/HA/39540vLhIuf6b/eiOU1A0StxQbAD/FrLtcXyYErU996cy/AM7NClM7+6nm88c1BIAPn5v8FgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031987; c=relaxed/simple;
	bh=vnmE19zTDbQRmq0wlWnWJ4jiLaVlkiQiimfWdUTie2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7CeiCIoxsiPNMBa70pu/SZtoNsKbYu7AvUplEJWVjz20npzEQXixw10NAoI1XFQQOo7qLlNMicZ/rL98M7XE0rReiFFgHycbKo8A32PE/L+2wGk8UVKLM5GCnskDvoQZx4A6y70e1U1TC+mzzHWdC1toLHdVD2h4hZ+UJAauCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjrIB8hv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a450bedffdfso128564566b.3;
        Thu, 21 Mar 2024 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711031984; x=1711636784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LydLOROwhTaCdZynw6Kh4hckrTZmMO+b98vvkEN6A+s=;
        b=VjrIB8hvTlyM3meMfUY6hmSYv9L43XT4X4niNccH9ytriUHJuAkQmniKRLP2LAYlXe
         nSXvFne4rEcsZi9llGKxupZVPQGNzs0MR0HmeoZBNRzO5omPhMWN5TbbbfCjLRqLC0tn
         axQM+a9ryze6JQqjtR217HEvx02oUEsgEluwy2GqWeRF+/XaTkrqbN5WJNerRwB6KX4h
         FHxCVKKDEoTOJ0rFdEZaX+W3T4Zz06/XN8wky0H/McbO+fk9AUQ3g5q7+T9vve6y94hl
         owJ/7dt5aqJfVcIhHGrMSCC6ziCLnSd6k1QK46DQ495T1S3JkyCBEPZvaJbLV4g90q91
         RjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031984; x=1711636784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LydLOROwhTaCdZynw6Kh4hckrTZmMO+b98vvkEN6A+s=;
        b=uhum54Ig7KgUi5tr4aw3GR8Ezuq2JUQCyk+wP2xdepxyH5p3lmlyqv31n1qk3t64r0
         5wGuw5MMBgGZx5Yvs8YEduByuguUCdKPFOtb3Ocf8oUHN4+iNyIN0Ud4J6N2Ny9QgViY
         ocZh45JZeNUBCeGAHkHu22Tvp1VKxSTpJLwQ7oGmurktwo+YxHvnoRvM6hvzazhS1L74
         7vuCOa1lPK9fsWuedflM1fiWfPXbgj1Rl67srAqNFgqUL8Hn619gzhh9mWnWHwJV2tVT
         V6d6/c0Jbt6fWfCHDNRmMTbhYxGpx00Rjplw0NsLaxNqEmKAucnycVnhlrMG78F6DX2R
         F+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB7+A6cQyzGarbiVIGKtgLvrNwanET+VNR4jJWaDIRW3fI9GxIi1ZA4uF+Lxzrl1lpLSBSJBYfZZVWHgtN/JHuQPN1GOdIR6bc72MJLGJQYxpe/edCt58Tt/NXgSIldFOwShuyFNsRqhAyu1oRGCqeNoX8+vMM4opkJeel+t4DU67RBB0=
X-Gm-Message-State: AOJu0YxWbr7T+xhhhhj121sxRlvpVeGR8AmxegNpi2G4pIsPa7z+MFqR
	zUouSnSN/I+w94lNk9SgasCmRb160/uBudqxCvv7UXrNLtV3Qgw=
X-Google-Smtp-Source: AGHT+IHH3uZgNQyrPnC5b0jWraJRMEbzRmtQtPcEw0er8UiT9MbitrNSKUukclX6EZyeBR499tLRkg==
X-Received: by 2002:a17:906:f908:b0:a46:ecdd:6a2 with SMTP id lc8-20020a170906f90800b00a46ecdd06a2mr4149893ejb.53.1711031984307;
        Thu, 21 Mar 2024 07:39:44 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b39:dab4:8e20:e918])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b00a46abaeeb1csm6147923ejb.104.2024.03.21.07.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:39:44 -0700 (PDT)
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
Subject: [PATCH 4/5] regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
Date: Thu, 21 Mar 2024 15:39:12 +0100
Message-ID: <20240321143911.90210-7-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240321143911.90210-2-knaerzche@gmail.com>
References: <20240321143911.90210-2-knaerzche@gmail.com>
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



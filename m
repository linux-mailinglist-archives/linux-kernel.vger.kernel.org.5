Return-Path: <linux-kernel+bounces-122073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B9888F187
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E091729E1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A6153BFF;
	Wed, 27 Mar 2024 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yna9t4UC"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331C153823;
	Wed, 27 Mar 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577014; cv=none; b=EpKOR6qFdmpXFWw31xUqi/jdljdiaPfrRv8nHBRvy6YOnwJd341dHdFOLZYbwufyjizRrwRB8b+0hMVkGBKUDTpd6mKnYwxezo5VW0bSFmnXtcgNdahGYN+CK+ZzJSYta4uv+ldkf3RKKe3AGUYebVvnbiP83ZeJ3PvLyYm0Rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577014; c=relaxed/simple;
	bh=6vozEqHEhJDmfW8F7V1J2kENv1p/cRuEsguYmBkjd0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdWyE3vc2C0Et53IM0uDu6geGqiF9mSiWDYpzL+E+Je5NxwNm6LigW1toXaPJuUhhNHpW6+ciFwi78YrlmRVv6D2LW1NLIWv0SoRaJxCqJS6UIFPStTyAJShojky7JZOxCpTmF8XA6yk2BjPSPu9qURCycG1Nk3rbqeJiJDg6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yna9t4UC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46cca2a979so16545466b.3;
        Wed, 27 Mar 2024 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577011; x=1712181811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx6zwby/FJqxDCQdpz3aFTZqErHsdP1W3h8awIRw/pU=;
        b=Yna9t4UC7DX/V3BM0OMBUYGsLOPKG37xBjy+hdm/a6g6TTl2sqMAJduDxtou8bF4VL
         +53LAjmZlMIfGSX74gV8TCamzTMMxOG+2TOSSPOAqjx8TWfftpOSUu85oDZ44y1J7i6J
         RNcYM4SXAjig3+NjeUErKsgcH+c4Ag3F1+7c+G3Lon5ySJj2JV5dWzx3PnojO8zJJfez
         qbCNLqjPzvk4c63cNa78iqDDZUUdNZ/rUjEm1KJvYgLrV7kozaRiCfrXJyoAnkUF8wBv
         3DSLcSI4ZFig+eIuP64gV9f4RvOZekB6zkpx2UEp1azOQlLK4jkAQEzLrk64KIBQu+6K
         YmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577011; x=1712181811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx6zwby/FJqxDCQdpz3aFTZqErHsdP1W3h8awIRw/pU=;
        b=pKheBOuluOiD1vWfzAJ5/DULCMm2XRq2XuCYiYBKCvJxWj5eS1Z2oj6VCqr62u8O2D
         qdpHYFeITiIVycYb7L3yTtAr7wQTSeHHf1V3ByU7GbHjoJdbK2SNEhhbBZXVHeWCEQ6E
         Ltdytz05vcAh5wL+D5V6s6lcMNwc+OjyL2MYLrEzAVk6AbK5cKKR6Xo107p+D7tCbL0n
         8qbFAPkW18ypv6ZDPEK81k3mhQEgGak2QZagDM8Jg3ecbHyvN49vG0Z08CPO5W/vYO79
         aERRVS3/arT2zMwYBCZov1Qn0R7or90zqCWU5IAf+68Mws6XYChYgNNxa6rFc1AxnpPQ
         GAbA==
X-Forwarded-Encrypted: i=1; AJvYcCXNqN1Zk3IbSAL8FOz+XlH2k3QzUX/sXDDFpKF9aKHAbcYXO3FmkSQ4Cxi5pshGoj2kxwDCcQZOsKihxdwyWTz/TvYV+Qxb2Mci41jBW2BQpf/u3GnwGRpMR3sRJ25QhcDPwGtbkeDLjQ==
X-Gm-Message-State: AOJu0YyrauEpTzquJtEwsn3Kdw07o3jmy5sGF4tZuV1yjaDW8cd9zTzk
	Je880wKy2M9H9AN6SSW5VCPJ4037TyrwtCOWnP85H7RW58E2Er/p
X-Google-Smtp-Source: AGHT+IG0xXGFFMRO5C7/D46gAQRv3uijdQ9DwhNQBUaj4SXhq62Wom5IOQ1fYVc+hg9WWWeh6xmcZQ==
X-Received: by 2002:a50:9b02:0:b0:56b:986b:b4e7 with SMTP id o2-20020a509b02000000b0056b986bb4e7mr1002229edi.27.1711577010582;
        Wed, 27 Mar 2024 15:03:30 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:30 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 2/7] iio: accel: adxl345: Group bus configuration
Date: Wed, 27 Mar 2024 22:03:15 +0000
Message-Id: <20240327220320.15509-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327220320.15509-1-l.rubusch@gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the probe function group bus configuration and the indio_dev
initialization to improve readability.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 35df5e372..5c24ef9ca 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -229,18 +229,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	if (!data->info)
 		return -ENODEV;
 
-	/* Enable full-resolution mode */
-	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
-				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to set data range\n");
-
 	indio_dev->name = data->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
+	/* Enable full-resolution mode */
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set data range\n");
+
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
-- 
2.25.1



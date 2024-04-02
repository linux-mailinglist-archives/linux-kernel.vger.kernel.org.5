Return-Path: <linux-kernel+bounces-127809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FCC89513F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935CD28887E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CD79B84;
	Tue,  2 Apr 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="Q+CWbW5S"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A479B9C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055594; cv=none; b=Bm8X2bEYae9DjyTevX+H8eEBKfoE8U326ueqgCwCPLyxITrnAQ6EQDTKkGei3V1GC/DSjOgVUF/qPF3WOpcw5szY0CvBN4gMvgog0x1kiSbifPhvytuG8EJEa2xvA5y6W1pbh8NkbDSsW3WjwFTb+HqOF4wrnlCVp5dujvPLrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055594; c=relaxed/simple;
	bh=l1cPwYzGO2B7LjOodxDrogv8WrNh3h0xyRSrepwr/W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSn32E0qQ+Zwkf08LSzxuMf5WN5E+GJ0GF7uFchEZQ4WCUVKpsiloh6fiHZ2deKtRE8bDDYsQNktKuOc6nwqIxpdBcv4Vji8j2oHUNNm4d1kivWogkYCvE+8pnfvBKzKj8bPfNyNYJIS93OYA5yNv7OglmpyX0yR1+Uv1VK5p/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=Q+CWbW5S; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e60a64abcso302574566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1712055590; x=1712660390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xHYPXNx2h46gZYDFc9h0qpHaxqChYbQzhX9Mgt5D3Y=;
        b=Q+CWbW5SqaS7Ge9+y2Y4sI50VcO7HCtfjR8mXZAE0zA6MgzvzZFtIdbTJFACSt0KL5
         pymRpSWftZgux+WymEFYLuMEKJ0gvKB0ThinPpUCWUZbn9lzZnOaSSnhfh6zMR5Ri9qR
         t6quktat6Q05F2x7s+olNl+Sj/+27UABwOWOOXPRcwCH8EWheSiOhhmDsi3QL2T+PhIK
         /JxdecSuwLan1O4axbQ6exE6tAw2O3r9lrV/VE3/7SZdjoKXuGQO9+FdH8eJaLr+2aaG
         aTZmzGw3gyr+RUJs9JwoWOTrKr3/KdcS7t/eaaytukrORlxGeyoDGZ97Cdx9DC8fqGhA
         wdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055590; x=1712660390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xHYPXNx2h46gZYDFc9h0qpHaxqChYbQzhX9Mgt5D3Y=;
        b=EwXM5IWYj/SAKGx4O6z3GdFqlMTHDY6Yn/QD2WMJwNNO9UPdX9DqJ5uH3oE3q7BJOR
         0XygE3doSi1MO7HZNI1eimBdDounITXARVCYjGMQnx2QvTh5onulef5GROwkHVfflUD5
         8/7JFADhGadO/ImWyjf70GCt2ZHvmoJO2QyAHICFrYwvFVbllBfvzeeVy2Lm6B6WB2Tm
         VH6sEREQBK4VbTLd+0eSWyf0fqwvx2aZ18Pm0a1ulrRAPZHIHFViM/PeG9hgRmOq0Uw2
         ogeABSa7JA0XyYFtL5r7UKm72u0jwiDBLAX7zheveWf6ngRoQfJALxSC9GntjB1jMbJu
         Zm1A==
X-Gm-Message-State: AOJu0Yx+NXgE1/VQiy+/12ddk09fRivm/XNdIOKeBfXSaRJM5+QZQj6c
	qwpgv+bQl/mip8inllbTUT3PzXqqcgmqRP4PmXgd/1tKkmueadn9rNuvB2IU533S+e+bTxo6cMo
	4A2JlAA==
X-Google-Smtp-Source: AGHT+IGa+NA1FgnIiV2VfDXy9ye9++b9ByVqAg4FCZ08kg46GwnDhf8HaPy5NcbTWJ6S0TKVE0o+nA==
X-Received: by 2002:a17:907:3f20:b0:a4e:4981:d3fb with SMTP id hq32-20020a1709073f2000b00a4e4981d3fbmr8787279ejc.29.1712055589421;
        Tue, 02 Apr 2024 03:59:49 -0700 (PDT)
Received: from localhost.localdomain ([188.27.131.149])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906275100b00a4644397aa9sm6398780ejd.67.2024.04.02.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:59:49 -0700 (PDT)
From: Alexandru Ardelean <alex@shruggie.ro>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: adrien.grassein@gmail.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stefan.eichenberger@toradex.com,
	francesco.dolcini@toradex.com,
	marius.muresan@mxt.ro,
	irina.muresan@mxt.ro,
	Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH 1/2] drm/bridge: lt8912b: add support for P/N pin swap
Date: Tue,  2 Apr 2024 13:59:24 +0300
Message-ID: <20240402105925.905144-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some HW designs, it's easier for the layout if the P/N pins are swapped.
In those cases, we need to adjust (for this) by configuring the MIPI analog
registers differently. Specifically, register 0x3e needs to be 0xf6
(instead of 0xd6).

This change adds a 'lontium,pn-swap' device-tree property to configure the
MIPI analog registers for P/N swap.

Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 4b2ae27f0a57f..154126bb922b4 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -47,6 +47,7 @@ struct lt8912 {
 
 	u8 data_lanes;
 	bool is_power_on;
+	bool do_pn_swap;
 };
 
 static int lt8912_write_init_config(struct lt8912 *lt)
@@ -78,15 +79,31 @@ static int lt8912_write_init_config(struct lt8912 *lt)
 		{0x55, 0x44},
 		{0x57, 0x01},
 		{0x5a, 0x02},
-
-		/*MIPI Analog*/
+	};
+	const struct reg_sequence mipi_analog_seq[] = {
 		{0x3e, 0xd6},
 		{0x3f, 0xd4},
 		{0x41, 0x3c},
 		{0xB2, 0x00},
 	};
+	const struct reg_sequence mipi_analog_pn_swap_seq[] = {
+		{0x3e, 0xf6},
+		{0x3f, 0xd4},
+		{0x41, 0x3c},
+		{0xB2, 0x00},
+	};
+	int ret;
 
-	return regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_SIZE(seq));
+	ret = regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_SIZE(seq));
+	if (ret < 0)
+		return ret;
+
+	if (!lt->do_pn_swap)
+		return regmap_multi_reg_write(lt->regmap[I2C_MAIN], mipi_analog_seq,
+					      ARRAY_SIZE(mipi_analog_seq));
+
+	return regmap_multi_reg_write(lt->regmap[I2C_MAIN], mipi_analog_pn_swap_seq,
+				      ARRAY_SIZE(mipi_analog_pn_swap_seq));
 }
 
 static int lt8912_write_mipi_basic_config(struct lt8912 *lt)
@@ -702,6 +719,8 @@ static int lt8912_parse_dt(struct lt8912 *lt)
 	}
 	lt->gp_reset = gp_reset;
 
+	lt->do_pn_swap = device_property_read_bool(dev, "lontium,pn-swap");
+
 	data_lanes = drm_of_get_data_lanes_count_ep(dev->of_node, 0, -1, 1, 4);
 	if (data_lanes < 0) {
 		dev_err(lt->dev, "%s: Bad data-lanes property\n", __func__);
-- 
2.44.0



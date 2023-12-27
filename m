Return-Path: <linux-kernel+bounces-11913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9BC81ED73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFC91C22377
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C72D272;
	Wed, 27 Dec 2023 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="e7pUpx8j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D676FC9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbb9f39e30so871641b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1703667032; x=1704271832; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rg6+ljdZgixSWbRXWj3kXbuUdDrmIT/jkzTN+vEmTm0=;
        b=e7pUpx8jpTVHfI+An8aR/60t2nc4uTFap1tWEBkB1Rf9G+yaPGg+D1SuPFC7oEAceL
         YhtKt25EpqG0vTNhjUBKk5p0+WFTjlBC3H+5h0pi5WlbTczDUwHInafcCdNlhGZNY0Zj
         k3KJUEZl+uZ/w/QW2z4GR8uLJHioyh6G4EKt2IEvTsAgHJWEBrEaf3jeB/+IjnHgY7g0
         mYNb4iInnzdI/f2r22l8eLjYq/aQx7iMVL/uC9utU3WWQnXF2b0bXi3MWUegzDra4xGt
         k7bLLCfFAVlQJsD0yfjdu5hySS3/kMIC/6BTUFidM52C/c75+6k6AAGWNgW3eUA4W09i
         jF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667032; x=1704271832;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg6+ljdZgixSWbRXWj3kXbuUdDrmIT/jkzTN+vEmTm0=;
        b=XbQKxNVH4is8A4MQ/A30+CITV5IbrPfWBSAyVOGAOJ+IEhNCLoYECptWynzdQyUSFi
         loRUdr7bYNQIKJxy+gN9fLhRsNuvAxwRA50crcGohZ70fLpuvDlx7ooRcGMDwRN8Cqoh
         SzwCt2+bsGlKAl1y2I3px5J14c7wM3JAuTZnp22Y9gxQbPZFQF8N0/7LrOsg4R6x3Qsv
         wGfMFXaO/xAjykRj3GUUbELjYE7shDkGW0jjLEtGPmXdqp/3qIca8ykFnrH4PTq4Y8tP
         D4qEGho6lenGZs8R+cxN0AnC/r/sN9gLcWBnOOBXp1b1ARruZasj3+nSiF33Sc6oBaHo
         Xqzg==
X-Gm-Message-State: AOJu0YzeLyqP0t8ValfRcpJbXaOS81n7I8SON7cm2zZmAUOCnnrYOmP4
	iMD4vyb01Qq2tGmoN668wppCtKQqTi7ELQ==
X-Google-Smtp-Source: AGHT+IEJyHe4ceLIVHZcj5qUbVaq6KZiQv8OtfJUHoIFiBOMhcirHT542PcOwmxn5pfhVafApPBDqA==
X-Received: by 2002:a05:6808:1415:b0:3bb:6d9b:845 with SMTP id w21-20020a056808141500b003bb6d9b0845mr8824660oiv.44.1703667031736;
        Wed, 27 Dec 2023 00:50:31 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b006d9d39354bcsm3157505pfn.74.2023.12.27.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 00:50:31 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linus.walleij@linaro.org,
	dianders@chromium.org,
	xiazhengqiao@huaqin.corp-partner.google.com
Subject: [PATCH v3 2/2] HID: i2c-hid: elan: Add ili2901 timing
Date: Wed, 27 Dec 2023 16:50:13 +0800
Message-Id: <20231227085013.1317-3-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231227085013.1317-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231227085013.1317-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ILI2901 requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 100ms,
so the post_gpio_reset_on_delay_ms is set to 100.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 31abab57ad44..5b91fb106cfc 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -130,9 +130,17 @@ static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
 	.main_supply_name = NULL,
 };
 
+static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_on_delay_ms = 100,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
+};
+
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
 	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
+	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.17.1



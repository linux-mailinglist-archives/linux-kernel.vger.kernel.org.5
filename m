Return-Path: <linux-kernel+bounces-10974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836781DF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5AAB20EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032110A34;
	Mon, 25 Dec 2023 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="hpIJdxwO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCA10A12
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-203fed05a31so2608344fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1703496547; x=1704101347; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJRavJQd/R4FAxoUrS2zZEwoVbqLgFXWyrD1r6G8+C0=;
        b=hpIJdxwO8jAX1oTKCiaEjTyCbo8jI2I+cYzleJGls8zkn7JPB/lHFJXTk8eXURhhza
         B7YROpD4S9rNmJlrWjN/l9eU64VCko9TTFQoAl5Nr7XSgAa9p6ArDr9rESL9lXt+U/fw
         L4qaIKLW+cWO8+liN509hmJPJ/siXDJZn9qBN2a+lVGBtnc80M/SIXeMmwVYs9SLcnzk
         LMdT8QNtv6BExxwtYB2y7ZNZ1UIHzl0q08WpypO86unuWZok9xB7NUoLyeLrq983gJQz
         YO1H5mzNGbNzPtXdHiajK92vTUWsKB1lRDBzf6sbr01eOTfMXa3fCXo+0Zhezn0I5WzS
         RbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703496547; x=1704101347;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJRavJQd/R4FAxoUrS2zZEwoVbqLgFXWyrD1r6G8+C0=;
        b=FdgeWVri2FY0gW4zFnvnhqiWzGtRHrOw/3/0Obmy43GQRf6UWxZnWnabqPTiIv3FAf
         /Zomv2lPzaIh4wuQnI7T549xc+lBD0ijRzS8K7Ino1ARgP3B1U5/33TWpOBFnwJoCo4M
         /NIaYi1jQlSfU0KbbJ5MtJODJnow+3VHxmv6DXHTm9DVNGbMOZTsX2BeoyuH+1je25lD
         52bIsJFkx9W2s3tsm7U6GwgCUvNqGPByLgNxrJmDMoK3w7gs/u4Wrth/ZNRmjf3PV5XY
         ksz/PXPq4erhuFh1PbE7JpdkRy+2hjtzEVKeaCEW+6EoSsaxpnQLvpAQZTrvokTyf8Q+
         5OmQ==
X-Gm-Message-State: AOJu0YzgM0HJDzU4wKIkRWGAxAIZYolaHPw0ac4RpEYt+W5gBwolv4C2
	QjRUaqlblpfqO6fdVRH0lZ18vGYABIvU5+foVpIvNLyB+a4=
X-Google-Smtp-Source: AGHT+IEb/yOcg6zMso4IfDNO4WFNOh2byPsTCGxp7TAn8FmpQ4jQXMnIGRYBy/bYlqzUwTOZxUMgmA==
X-Received: by 2002:a05:6871:6111:b0:203:faf4:9a2d with SMTP id ra17-20020a056871611100b00203faf49a2dmr6204241oab.63.1703496547319;
        Mon, 25 Dec 2023 01:29:07 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id l16-20020a656810000000b005cdfa6f5aeesm4393267pgt.94.2023.12.25.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 01:29:07 -0800 (PST)
From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	dianders@chromium.org,
	xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v1 2/2] HID: i2c-hid: elan: Add ili2901 timing
Date: Mon, 25 Dec 2023 17:28:43 +0800
Message-Id: <20231225092843.5993-3-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231225092843.5993-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231225092843.5993-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ILI2901 requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 100ms,
so the post_gpio_reset_on_delay_ms is set to 100.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
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



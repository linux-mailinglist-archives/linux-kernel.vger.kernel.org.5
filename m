Return-Path: <linux-kernel+bounces-11326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CA81E49C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16471B21ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12155223;
	Tue, 26 Dec 2023 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="vvGU7WOM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72741852
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb8f3d9f98so2891356b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1703558276; x=1704163076; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJRavJQd/R4FAxoUrS2zZEwoVbqLgFXWyrD1r6G8+C0=;
        b=vvGU7WOMNazfcy7UVP9yR3JZLXZmmriIAaz8wvoVDm1QM/RdZFgMKlgTEIGElAWn1k
         XrIXhwHAiuW2QPmSZRhVxdfc8dLI79luRI6t3jOXZbh0zLyrofz/XQ624tkpr8t/AlzW
         8fB9s6cTPJ60TokO2BrIOyJBJa5d7N+TQAxoO9JPSH4j6wUz8A8dlSK3tkWdh9fEBA9D
         BcpRWuq9/Od6TawMwK0M5seWKD6oXPicDzUTtUbZvTbNPfBl1BddEe23dyREfUmHQs2M
         vDxZaWDBDEQtFZAoo9z6ab//SFOU2WT+/GWl/n1rAQCWMSWvyMYt/zm+RsCzD0W4wnE3
         O8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703558276; x=1704163076;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJRavJQd/R4FAxoUrS2zZEwoVbqLgFXWyrD1r6G8+C0=;
        b=tAyvwb7Q0hfIaFNTsps7Mh7TOn3q3erVZ2g/W5L+L0HjO4e8b45spb0ALaY+5D2gGq
         v8dd7Z96i3w7ibeZ7KVn+AQzibeIFMrnQ/2OCdGYrfHwNFCSQ8uH9KfIUkQX53rqa4gt
         AHtiXQA5E89wWeC1ZwUGv+jT4/fD1Db/6BEJN2KsQJhzSgc0FOaupV/Z0OnJLjRCV4af
         JbGjkDFQmbZ8vmc12NanmxS9hAATIQxojpfujhNHDo6RHW0fa98IbDfnRzMcq2l/jFqv
         tVxU0DNLqeZ2wBJu9e+9MPC5/m4REyQuG4ft5BsW0Bjyt9pQo4v5P+jiLgwV9DY1hEDz
         Yedw==
X-Gm-Message-State: AOJu0YyUM9ggUBsKg6e4ctz7focakwpr6SJybxgNk+mLeyRQythJgvcd
	EdQ2ifY4ulAHijWJiSJXs7GtdAn4H+QgZg==
X-Google-Smtp-Source: AGHT+IGm2pxlhyYkOod9Tx6M+PMbYfnwMyTrGfF0FZg26RcstOF4WMJmZ1P2dwPM1ijwFyU5sTj8dw==
X-Received: by 2002:a05:6808:d4b:b0:3b8:b063:adf5 with SMTP id w11-20020a0568080d4b00b003b8b063adf5mr9148436oik.82.1703558275695;
        Mon, 25 Dec 2023 18:37:55 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090a8c8b00b0028c2de909e4sm5083190pjo.50.2023.12.25.18.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 18:37:55 -0800 (PST)
From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	dianders@chromium.org,
	xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v2 2/2] HID: i2c-hid: elan: Add ili2901 timing
Date: Tue, 26 Dec 2023 10:37:37 +0800
Message-Id: <20231226023737.25618-3-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231226023737.25618-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231226023737.25618-1-xiazhengqiao@huaqin.corp-partner.google.com>
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



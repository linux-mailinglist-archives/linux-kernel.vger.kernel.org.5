Return-Path: <linux-kernel+bounces-2816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E5816255
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C2028231E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FEE48CE6;
	Sun, 17 Dec 2023 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mseP0aXD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2846481D7;
	Sun, 17 Dec 2023 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55333eb0312so480018a12.1;
        Sun, 17 Dec 2023 13:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702847361; x=1703452161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAUbIAntM3d+P1r7PxLEQx0z9V8P0MjzX6e4WUbLKOw=;
        b=mseP0aXD5abnrW5Tv6VZybfDnf3cG9KKDug+wW+GoNP+H45Sb3iw5s3e4ku6bdxiK6
         LxaeD3xMqB7sAGgGXsZwU9YlSF3wVaajPZ9Ot61P0TlEUOPHmD814LxBQ0t+Fcj4ghUD
         CZf9fx1e4QDfH/KBv9Me9bdiVlsbxahTnLGv4zraNHMiRJ4BXXQ5kyNVchIeFvndbjN6
         ce4ReTDfQBj0GIYzlGWkJC/YHfZkLwVPLdc571HPZ82DqDZvQoC4PpJXJBmGP21+J019
         1kghp+SUr8smCclUXmzsa9UOeAZ/iw3lg4s1gjuDilksSE5JOMmwKVBTbAhwrMa+SskN
         cUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702847361; x=1703452161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAUbIAntM3d+P1r7PxLEQx0z9V8P0MjzX6e4WUbLKOw=;
        b=uZ4vU/46xSGcv1nGl4d2+adgkpPGH5cTxwCW8xHAarub14iA9UL1xbCG5dSjPyiWWU
         dhVnd+sYKkWt9TdjqAFO2CF6h9EKIq7ikkyMnkhkMQIf2D7vFeI9Dz2UELRUJSJSwpB/
         hNoKoYnzXlQv9l2C3/Eadi/WoLIfKcx5Pu/JqQid2xlaK1JKdVlhH8HY101hSh5o8VPS
         X8gp+SbUZ2UdomLKbqFQpiRPavsrz4CwU4jFB5dWqBKcwK8VvFhnYjx8Qe3qy0+ko6yr
         j/qvGXJTrMcsbmN3tPflWrmPYrtsND1j9G0utUC2a+1K/RsOcNWlVMl8w6O7010kr6Px
         u01w==
X-Gm-Message-State: AOJu0YzDzdgC3wFw2SxLiVxHjY3gcI1Kd34jSl4IeoT6Ubec0WZu4O/R
	c0hCib8PaEKr1iqE5KyQVKk=
X-Google-Smtp-Source: AGHT+IGXBluqcGQB7k35DpbnUHnaijO7J6FnYJlOKlthAcSTpRKN4IAiy50prOqyAzcchEuhhGrjqg==
X-Received: by 2002:a17:907:a0d:b0:a23:3212:9c37 with SMTP id bb13-20020a1709070a0d00b00a2332129c37mr1452093ejc.50.1702847360868;
        Sun, 17 Dec 2023 13:09:20 -0800 (PST)
Received: from wpc.yadro.com (188-169-139-214.dsl.utg.ge. [188.169.139.214])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1ce58e9fc7sm13316096ejc.64.2023.12.17.13.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:09:20 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Andre Przywara <andre.przywara@arm.com>,
	Maxim Kiselev <bigunclemax@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	John Watts <contact@jookia.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 2/3] thermal: sun8i: Add D1/T113s THS controller support
Date: Mon, 18 Dec 2023 00:06:23 +0300
Message-Id: <20231217210629.131486-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217210629.131486-1-bigunclemax@gmail.com>
References: <20231217210629.131486-1-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds a thermal sensor controller support for the D1/T113s,
which is similar to the one on H6, but with only one sensor and
different scale and offset values.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f989b55a8aa8..6a8e386dbc8d 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -606,6 +606,18 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+static const struct ths_thermal_chip sun20i_d1_ths = {
+	.sensor_num = 1,
+	.has_bus_clk_reset = true,
+	.offset = 188552,
+	.scale = 673,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun50i_h6_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -614,6 +626,7 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
+	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.40.1



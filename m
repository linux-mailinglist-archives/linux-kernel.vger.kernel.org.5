Return-Path: <linux-kernel+bounces-42422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE884012B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D64D283323
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AE55E68;
	Mon, 29 Jan 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWZ0wymY"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314D54FA3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519806; cv=none; b=HcIfkrn0XHRlkqA1SoXEbw3UeQkHdPSqyD6g49XjEDDaoRJXlr0M6ZNOevxrTT45d9HxrGtorCdB21EOWCKxl0iDvkYBl0EwzX7ctpghKVZj1IObCtevAVbqA9/fx6Q9hYQTm6MEnGkRhLisi2CXXSe8GzKwWOc9wLENyvJMmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519806; c=relaxed/simple;
	bh=49ZjLfuS6hYCoynE8R+3ZRJavMyqVtQtJiDsFdItKsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBXB9Mdg/n2wOxSENlUaJ89Qgm9y0izoGab63r7IHPwIEhqXzVH2ZY1y40fkR7lJcQRAYzcelgy376/LXg1/BiI+fOWziHEzE+bDRnPm5zXT/hNYxqUBZ9NvgEEI1uS1kjqbo12pE0zTZHWYx0gqMhpoeArhWuJglhA00nM2EM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JWZ0wymY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ae5e7d787so1242700f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706519803; x=1707124603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUfXQ3bAJN2kzFzoSk9/i7ywvhXEzIXnvWTj3lNXRvs=;
        b=JWZ0wymYz7pCK/tH0h/Ukc41wRQWWIu7ugyw8/PrzrNzJ+28LyS+djPhua/MMb+vDK
         9aP311o6noUWFfY/wRDkI84nqjL6JnJ/7XS6d4yXSA8RJej2+HSJs36Gn5vtQUKogEGN
         P6n+zIqQYhSF++y0xcq1/UOu2jzZ3RrZrX5ssHPe79KT3SapxXs8zmxIWbFfAej5e/22
         JiqKqGR+oig/XMub82gmdHj8PbqZZY84o51Xa2h9EzqXIdcq9qtyE/vlZlwQLRy1eeDa
         siRx3FnKTCkjf+rJinW7k5ve40ZebbDq15ckum/7zoC06lgbryVfLhJpKJzuV3dVPJuN
         JQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519803; x=1707124603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUfXQ3bAJN2kzFzoSk9/i7ywvhXEzIXnvWTj3lNXRvs=;
        b=bxX5h3ipkhQuDYJmWVTG1S9IF37G81CpW6jhiu3jSsCu+Lkkw9yfvKnZvLsWPQb/bO
         o7hCMlnWgUyUzk6HJo88QPDVQ29gwvRUYakQ+fQINM8LlsCMc3TRXaiYLbPxUkP8WJ+A
         VUT9rFdbP5FCdNgB0xjjavEnHlgsglIF6FF4Y7sHfFgT7rhXnlr/MQvkI72LzctBTZwd
         7WarOgizg6DGnLDgL1S2MPQ+wDEThDXm6J1ewUvkgDsjChTA8yyNxAYA6K72IWXN1Fax
         t2TtYa8hZf/t+xfX2PaD1B2CEuUKzAQX40ptyLScNIK3NzZ3f4eBGNn1SXVspE4Bc+zT
         jfPg==
X-Gm-Message-State: AOJu0YzN6lLm1kSsdyrZadABuGLoIuW29Amdb1YnZmiUnkESi6JqdACB
	b8UibOn4150ckYK6j7oEitxtyqSR70UE0eM2npM2irsFYqiUHXjDtbjedSBF0hg=
X-Google-Smtp-Source: AGHT+IH7/3/syRoKKVYUpsMjqPugMeAm03riXuAyJSDBOYS9S5xfHWQqNbQkvEFy3TDF4hFd55o1Jw==
X-Received: by 2002:a5d:5f46:0:b0:33a:eb49:bbab with SMTP id cm6-20020a5d5f46000000b0033aeb49bbabmr2535069wrb.13.1706519802659;
        Mon, 29 Jan 2024 01:16:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b7-20020adfee87000000b0033aebf727b2sm2818198wro.60.2024.01.29.01.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:16:42 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 29 Jan 2024 10:16:37 +0100
Subject: [PATCH v15 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-topic-goodix-berlin-upstream-initial-v15-3-6f7d096c0a0a@linaro.org>
References: <20240129-topic-goodix-berlin-upstream-initial-v15-0-6f7d096c0a0a@linaro.org>
In-Reply-To: <20240129-topic-goodix-berlin-upstream-initial-v15-0-6f7d096c0a0a@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4566;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=49ZjLfuS6hYCoynE8R+3ZRJavMyqVtQtJiDsFdItKsA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlt2z1MAhNxiWveRnebI2D26HzwOBTklJtDHtx7/7e
 PPlbpB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbds9QAKCRB33NvayMhJ0UnWD/
 4toRNlSIUWQrAbDK086f/jsFrf6L57UwAaoy8iUvgP5Pv5Xjd2bo45wh2PoRdSRPgOFR0ScauOOscY
 CjO/zf99Ifz74vWEDEYgdvDBBLvnniGGp++JfMZdx8V8Dn7PjA5DbMosLPLraEwOrF7pm6BSLPj/2H
 r2vHdjHB3UjNEV6/vtUCavH0AGM0P3rpIVlRihvZj3PVqlSgg5fDkjm/MQ/FtFEhnw9vJqilydeCyr
 +dmP2UK0Yn3ZZGaU2LN2PTtQRdte3DX+mivxPOAtyQddXt3uowdwqKCWNWfKCqNYY4F7o8sKEul+uu
 PvU+DCPPY1pyOJ8kQg7o3cJXUHgprjQFCx/oSDAudihQA8hYjT8QHKismmh+c5+/cnIjc851okcsrh
 O+gNteWdWvUtVPlSdM9bWHRnas0Nvrt5px/g/XGroxaCNFnhccbQVfj1wlQuld82EQcFA/NRaf/GoA
 kErLG1F2PCxm2pM5sw91DuFuIj/dDv3zsOo3V89lTj0DW74f0OGTDNuYZS9RNpBXNAhZjeSfYcWIRL
 OgvOpGrJ8JyzskQPdbBYH7pvAAaSiiTols+yuPco7cMzD8vAojk+ZKCTxXYfMM9XscCn5JOF24o6Rn
 dDSXPmGDoRV4lyqb+ri/Jncql5WNEU6lZZGNYpYcVlSpYWiqUWV5o/gj0/iw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add initial support for the new Goodix "Berlin" touchscreen ICs
over the I2C interface.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig             | 14 +++++
 drivers/input/touchscreen/Makefile            |  1 +
 drivers/input/touchscreen/goodix_berlin_i2c.c | 75 +++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 950da599ae1a..cc7b88118158 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -419,6 +419,20 @@ config TOUCHSCREEN_GOODIX
 config TOUCHSCREEN_GOODIX_BERLIN_CORE
 	tristate
 
+config TOUCHSCREEN_GOODIX_BERLIN_I2C
+	tristate "Goodix Berlin I2C touchscreen"
+	depends on I2C
+	select REGMAP_I2C
+	select TOUCHSCREEN_GOODIX_BERLIN_CORE
+	help
+	  Say Y here if you have a Goodix Berlin IC connected to
+	  your system via I2C.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called goodix_berlin_i2c.
+
 config TOUCHSCREEN_HIDEEP
 	tristate "HiDeep Touch IC"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 2e2f3e70cd2c..7ef677cf7a10 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
+obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/goodix_berlin_i2c.c b/drivers/input/touchscreen/goodix_berlin_i2c.c
new file mode 100644
index 000000000000..6ed9aa8088cb
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Berlin Touchscreen Driver
+ *
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/input.h>
+
+#include "goodix_berlin.h"
+
+#define I2C_MAX_TRANSFER_SIZE		256
+
+static const struct regmap_config goodix_berlin_i2c_regmap_conf = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.max_raw_read = I2C_MAX_TRANSFER_SIZE,
+	.max_raw_write = I2C_MAX_TRANSFER_SIZE,
+};
+
+/* vendor & product left unassigned here, should probably be updated from fw info */
+static const struct input_id goodix_berlin_i2c_input_id = {
+	.bustype = BUS_I2C,
+};
+
+static int goodix_berlin_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+	int error;
+
+	regmap = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	error = goodix_berlin_probe(&client->dev, client->irq,
+				    &goodix_berlin_i2c_input_id, regmap);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct i2c_device_id goodix_berlin_i2c_id[] = {
+	{ "gt9916", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, goodix_berlin_i2c_id);
+
+static const struct of_device_id goodix_berlin_i2c_of_match[] = {
+	{ .compatible = "goodix,gt9916", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_berlin_i2c_of_match);
+
+static struct i2c_driver goodix_berlin_i2c_driver = {
+	.driver = {
+		.name = "goodix-berlin-i2c",
+		.of_match_table = goodix_berlin_i2c_of_match,
+		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
+	},
+	.probe = goodix_berlin_i2c_probe,
+	.id_table = goodix_berlin_i2c_id,
+};
+module_i2c_driver(goodix_berlin_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin I2C Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1



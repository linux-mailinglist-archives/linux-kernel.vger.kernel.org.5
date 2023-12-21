Return-Path: <linux-kernel+bounces-8640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9681BA88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF0D28976D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5028255E6E;
	Thu, 21 Dec 2023 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zay4BHk0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13C55E68
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d40eec5e12so3612695ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172114; x=1703776914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUfXQ3bAJN2kzFzoSk9/i7ywvhXEzIXnvWTj3lNXRvs=;
        b=Zay4BHk04FOoz+ATIBUmGHe2np5IbfU7LvaZOZIlGxShYVT4Zqs7gNrFjRR7en7G7f
         sXdHrFzCgUHsYUIW4EeHMhuG9jUUJ89KYedeeMyH9nBbpPMMA3cUb26u/O8ftGWC9bFQ
         VYe523uWGSK0Q6WO9fvT5DaWlsz1DZcZw3K8E+yWf3xXse1W2i3omb/AyVOXmA8XX3sJ
         Qjrh1b1CJquosUmziIQo+SekobLu2r7Tmg0lOuRxr8F54ggL+fdyEz+F3Q/2FHgagc1F
         zoKPn4lLAmmk92Xbq7mQl79Kt3bhF4NpfD/kqEb9WmHR4CGi043axJhzuUx/7IGzvVDa
         M1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172114; x=1703776914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUfXQ3bAJN2kzFzoSk9/i7ywvhXEzIXnvWTj3lNXRvs=;
        b=BNiXk3AmoeNiP1qz4hKnqQzvDPQk8tf5Z/b3qxdqtPIMXI3zK9G+D38LFRZQyVj3ok
         1/TIQs+/A5A8+JsvyFvPxLFYYKZeAnauTxl9uHFnwpP5rGuJjiBNS2LO5lNuqjTeiH8k
         1QGFXd7yLzDf3BHjbbMVz0B4msNa5by98hqzzMAXTVD0qrEvN5e3nnC0ACOwzQ1jQaTK
         WUkzie88qMjS6AapVBebmR3jIeFFh20kO0+EkBEKEJEPE4f0dJ13dN/7CoAl11LtzDlh
         MLcFMj8i3W6rJ5umoIHVC1Ig5/OhEuqCD8zDi7PKRW0rJXlRP9RLVZMiAsnH+NU7WnsB
         OVXg==
X-Gm-Message-State: AOJu0YxioCE1p223HRt7qiP8GmPebm7jja6TYyNrawt3hkYAbl4Wk5A/
	JKt9idMH+GL7IoIz8YGr0uKZMKoUVVKvTNyq8q+KwXPq
X-Google-Smtp-Source: AGHT+IEPmRRO3L7fBeRutAAzt8SxFhim7jFUsZIfsEQYNpzulxO7CQQ2CVy/rlLb+uV0n+v4vexE6A==
X-Received: by 2002:a17:903:1c4:b0:1d3:6605:db01 with SMTP id e4-20020a17090301c400b001d36605db01mr14836672plh.64.1703172114588;
        Thu, 21 Dec 2023 07:21:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001d3561680aasm1756217plb.82.2023.12.21.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:21:54 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Dec 2023 16:21:21 +0100
Subject: [PATCH v14 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-topic-goodix-berlin-upstream-initial-v14-3-04459853b640@linaro.org>
References: <20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org>
In-Reply-To: <20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlhFf23xt+NOzc5YGMhPZm65IVbPBU/8lzLfos76xA
 D+xq7YGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYRX9gAKCRB33NvayMhJ0VE6EA
 Cz7aW4NS+LNnD7bT5SORh84SLZ4A97UkKtBed5zPG1ea/axEXWPIzl2Ih4WUJyRsyYNSjVmJmQ9Rg5
 YQpvr3ZapcZVgGc0IqLZXvCs37+fvP+aZ05e/lbGfGb4sDaZf7gz6NJAVZktQgnYW2w097/OJtsbTZ
 HPU0w0eLXPpEpQ3IlNRsoNh+2U1own5TDA47rjU/SvaXNXCNkXuVzHBAxZKzKZR4gc1TWdLHcKtheh
 ZY49KCTWoi0chyfy29TcwTQiFjICkp3HgBOyMpr3mivZ+5n5KTQhkAmomtJRTs8JypE/UswcyG1Z30
 Ue7xbNsRRRsDR81nbvT8tHXR43ZhsELBgl2X4beAqHBcDFWMkHI3jNvApH4yn3+BPwlEfwstWoaxpj
 hRHY9gk5OCUW1mMpI0zYOkjRiFHTex6ij68UXlQsfH+Ju14XrpX/c+IIdgACFXxadzJN68bwBXppPJ
 5rTfKo4473lPrb18EY01z3vkGkCyvR2+g6VigDddCjHf6+QJIukCE0VNdhKSfDd0KZNZZNzfaugK9T
 Lu9xsAuE3Yma8JbioRRJ/9yRSskUq7FQyvYwvBuHNSCBXkfehHMZaEcCJPJ8fy2mRy7D6M9/NVNaS3
 3V0Nq4V8OfL290URTwPVZNVef2eM2B0yPojgQUA974LU89A8XXElXb4VrhHw==
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



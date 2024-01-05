Return-Path: <linux-kernel+bounces-18025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E678D825762
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7044B1F22427
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219A31A89;
	Fri,  5 Jan 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7sHsspT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C182E854
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28bd9ca247so180645466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470367; x=1705075167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tTyPxtOHyPhs2m2q+fBlzqfN887mU2OuCBzVF3uVpc=;
        b=W7sHsspT/V4ihEea9GxR/wqQ3RnazzeC5k6cllOX3977/PLex7eZ/NmG45QcqcGQq1
         YYtCG4dYNz8BP3pZ1ldRFgZbOoH/v1CpTNEXpFDJlSGv+ieMC8pLuA83Adm6g5yf5yo2
         eGbyP0xqgmSHN/jnOzT9IHVolhszkJfFKt84HAtGYX/woyQ0MWhiJKQtoyNqmV5BNS5s
         vMLk4Igu9li+eT8U9K7VYdyveWtGIwBPOxhJQ6dhoWUkcbEVKrhF5gDdqYriupRvxlIJ
         FBuG9vOoDm+RJQE2FCRfMe5wF9R0gzDy9Hm9vksdg+cUaB08cITuA5zTrD+Y6s+2Ypbw
         tf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470367; x=1705075167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tTyPxtOHyPhs2m2q+fBlzqfN887mU2OuCBzVF3uVpc=;
        b=oHl/CwsQNPf75OiBasQk4jEyWa/4ziaw2q93Cxt/N2Vc1WsVFvz2GWb4uvavmd+OPb
         rJqw65+akRHL+3IFHxWQtx0EDJDm1BzD9Wds+DxpOmp412o3gY28dvK9xwirf3LRWaz8
         9x+Ceo83/lT7d0XjbXjvzRhppZ01+FopNdg4G9ZQ5C/BBW1CpjhqFZXQWbRC0fauHt34
         FXs0xZ5NxawWDMUEwToOWOpW4j8DUkr6hWr2wSwI7JLiQje9YDKDJa0iH4h167m6jkz7
         mr35R4SkCn0OrDlccQpxko33UupAAZeF8vvmPG6baTTRAx0hBqwDJjetFiWPy42jj1In
         jGhQ==
X-Gm-Message-State: AOJu0YxxDjFrdDvVrjEUhoSAPlmoRkpTPgUzIGuSoKXUtFNDUF9SAeQB
	0ocO6w+PZ2tStLdYvhjhG6ntatYiemNykQ==
X-Google-Smtp-Source: AGHT+IEJllJOQYWFJfcK4fFNCU2+uk/9rAtZgBP1Rn9juMOU1AONaO8vekFgnIMLnJEdjkon7/9SEQ==
X-Received: by 2002:a17:907:98a:b0:a27:d9ef:8ab with SMTP id bf10-20020a170907098a00b00a27d9ef08abmr1310502ejc.2.1704470366902;
        Fri, 05 Jan 2024 07:59:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id su8-20020a17090703c800b00a29910a9366sm326024ejb.8.2024.01.05.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:59:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 2/4] reset: Instantiate reset GPIO controller for shared reset-gpios
Date: Fri,  5 Jan 2024 16:59:16 +0100
Message-Id: <20240105155918.279657-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
References: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices sharing a reset GPIO could use the reset framework for
coordinated handling of that shared GPIO line.  We have several cases of
such needs, at least for Devicetree-based platforms.

If Devicetree-based device requests a reset line, which is missing but
there is a reset-gpios property, instantiate a new "reset-gpio" platform
device which will handle such reset line.  This allows seamless handling
of such shared reset-gpios without need of changing Devicetree binding [1].

All newly registered "reset-gpio" platform devices will be stored on
their own list to avoid any duplicated devices.  The key to find each of
such platform device is the entire Devicetree GPIO specifier: phandle to
GPIO controller, GPIO number and GPIO flags.  If two devices have
conflicting "reset-gpios" property, e.g. with different ACTIVE_xxx
flags, this would spawn two separate "reset-gpio" devices, where the
second would fail probing on busy GPIO reques

Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1]
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/core.c             | 176 ++++++++++++++++++++++++++++---
 include/linux/reset-controller.h |   4 +
 2 files changed, 167 insertions(+), 13 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4d5a78d3c085..ec9b3ff419cf 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -23,6 +24,10 @@ static LIST_HEAD(reset_controller_list);
 static DEFINE_MUTEX(reset_lookup_mutex);
 static LIST_HEAD(reset_lookup_list);
 
+/* Protects reset_gpio_device_list */
+static DEFINE_MUTEX(reset_gpio_device_mutex);
+static LIST_HEAD(reset_gpio_device_list);
+
 /**
  * struct reset_control - a reset control
  * @rcdev: a pointer to the reset controller device
@@ -63,6 +68,16 @@ struct reset_control_array {
 	struct reset_control *rstc[] __counted_by(num_rstcs);
 };
 
+/**
+ * struct reset_gpio_device - ad-hoc created reset-gpio device
+ * @of_args: phandle to the reset controller with all the args like GPIO number
+ * @list: list entry for the reset_lookup_list
+ */
+struct reset_gpio_device {
+	struct of_phandle_args of_args;
+	struct list_head list;
+};
+
 static const char *rcdev_name(struct reset_controller_dev *rcdev)
 {
 	if (rcdev->dev)
@@ -813,13 +828,119 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
+static bool __reset_gpios_args_match(const struct of_phandle_args *a1,
+				     const struct of_phandle_args *a2)
+{
+	unsigned int i;
+
+	if (!a2)
+		return false;
+
+	if (a1->args_count != a2->args_count)
+		return false;
+
+	for (i = 0; i < a1->args_count; i++)
+		if (a1->args[i] != a2->args[i])
+			break;
+
+	/* All args matched? */
+	if (i == a1->args_count)
+		return true;
+
+	return false;
+}
+
+/*
+ * @node:	node of the device requesting reset
+ * @reset_args:	phandle to the reset controller with all the args like GPIO number
+ */
+static int __reset_add_reset_gpio_device(struct device_node *node,
+					 struct of_phandle_args *args)
+{
+	struct reset_gpio_device *rgpio_dev;
+	struct platform_device *pdev;
+	int ret;
+
+	lockdep_assert_not_held(&reset_list_mutex);
+
+	mutex_lock(&reset_gpio_device_mutex);
+
+	list_for_each_entry(rgpio_dev, &reset_gpio_device_list, list) {
+		if (args->np == rgpio_dev->of_args.np) {
+			if (__reset_gpios_args_match(args,
+						     &rgpio_dev->of_args)) {
+				ret = 0;
+				goto out_unlock;
+			}
+		}
+	}
+
+	/* Not freed in normal path, persisent subsyst data */
+	rgpio_dev = kzalloc(sizeof(*rgpio_dev), GFP_KERNEL);
+	if (!rgpio_dev) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	rgpio_dev->of_args = *args;
+	pdev = platform_device_register_data(NULL, "reset-gpio",
+					     PLATFORM_DEVID_AUTO, &node,
+					     sizeof(node));
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (!ret)
+		list_add(&rgpio_dev->list, &reset_gpio_device_list);
+	else
+		kfree(rgpio_dev);
+
+out_unlock:
+	mutex_unlock(&reset_gpio_device_mutex);
+
+	return ret;
+}
+
+static struct reset_controller_dev *__reset_find_rcdev(struct of_phandle_args *args,
+						       bool gpio_fallback,
+						       const void *cookie)
+{
+	struct reset_controller_dev *r, *rcdev;
+
+	lockdep_assert_held(&reset_list_mutex);
+
+	rcdev = NULL;
+	list_for_each_entry(r, &reset_controller_list, list) {
+		if (args->np == r->of_node) {
+			if (gpio_fallback) {
+				if (__reset_gpios_args_match(args, r->of_args)) {
+					/*
+					 * Fake args (take first reset) and
+					 * args_count (to matcg reset-gpio
+					 * of_reset_n_cells) because reset-gpio
+					 * has only one reset and does not care
+					 * about reset of GPIO specifier.
+					 */
+					args->args[0] = 0;
+					args->args_count = 1;
+					rcdev = r;
+					break;
+				}
+			} else {
+				rcdev = r;
+				break;
+			}
+		}
+	}
+
+	return rcdev;
+}
+
 struct reset_control *
 __of_reset_control_get(struct device_node *node, const char *id, int index,
 		       bool shared, bool optional, bool acquired)
 {
+	struct of_phandle_args args = {0};
+	bool gpio_fallback = false;
 	struct reset_control *rstc;
-	struct reset_controller_dev *r, *rcdev;
-	struct of_phandle_args args;
+	struct reset_controller_dev *rcdev;
 	int rstc_id;
 	int ret;
 
@@ -839,21 +960,50 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 					 index, &args);
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
-	if (ret)
-		return optional ? NULL : ERR_PTR(ret);
+	if (ret) {
+		/*
+		 * There can be only one reset-gpio for regular devices, so
+		 * don't bother with GPIO index.
+		 */
+		ret = of_parse_phandle_with_args(node, "reset-gpios", "#gpio-cells",
+						 0, &args);
+		if (ret)
+			return optional ? NULL : ERR_PTR(ret);
 
-	mutex_lock(&reset_list_mutex);
-	rcdev = NULL;
-	list_for_each_entry(r, &reset_controller_list, list) {
-		if (args.np == r->of_node) {
-			rcdev = r;
-			break;
-		}
+		gpio_fallback = true;
 	}
 
+	mutex_lock(&reset_list_mutex);
+	rcdev = __reset_find_rcdev(&args, gpio_fallback, NULL);
+
 	if (!rcdev) {
-		rstc = ERR_PTR(-EPROBE_DEFER);
-		goto out;
+		if (gpio_fallback) {
+			/*
+			 * Registering reset-gpio device might cause immediate
+			 * bind, thus taking reset_list_mutex lock via
+			 * reset_controller_register().
+			 */
+			mutex_unlock(&reset_list_mutex);
+			ret = __reset_add_reset_gpio_device(node, &args);
+			mutex_lock(&reset_list_mutex);
+			if (ret) {
+				rstc = ERR_PTR(ret);
+				goto out;
+			}
+			/*
+			 * Success: reset-gpio could probe immediately, so
+			 * re-check the lookup.
+			 */
+			rcdev = __reset_find_rcdev(&args, gpio_fallback, NULL);
+			if (!rcdev) {
+				rstc = ERR_PTR(-EPROBE_DEFER);
+				goto out;
+			}
+			/* Success, rcdev is valid thus do not bail out */
+		} else {
+			rstc = ERR_PTR(-EPROBE_DEFER);
+			goto out;
+		}
 	}
 
 	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 0fa4f60e1186..e064473215de 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -61,6 +61,9 @@ struct reset_control_lookup {
  * @dev: corresponding driver model device struct
  * @of_node: corresponding device tree node as phandle target
  * @of_reset_n_cells: number of cells in reset line specifiers
+ * TODO: of_args have of_node, so we have here duplication
+ * @of_args: for reset-gpios controllers: corresponding phandle args with GPIO
+ *           number complementing of_node
  * @of_xlate: translation function to translate from specifier as found in the
  *            device tree to id as given to the reset control ops, defaults
  *            to :c:func:`of_reset_simple_xlate`.
@@ -74,6 +77,7 @@ struct reset_controller_dev {
 	struct device *dev;
 	struct device_node *of_node;
 	int of_reset_n_cells;
+	const struct of_phandle_args *of_args;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
 			const struct of_phandle_args *reset_spec);
 	unsigned int nr_resets;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0C814699
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8130BB23752
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099D2DB9C;
	Fri, 15 Dec 2023 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSjxN4sf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD02D7AF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so595325e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638954; x=1703243754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGq6oPhsUVdTqLZzaZ7S1PrPM+s1Pa6z7b1UfXTkK90=;
        b=nSjxN4sfn+nnxIexIqM3DXjXcNGNerTSz1L++TDvqt6gv5h5OT+IXJjXFiEy3xVcKG
         BRsx99I/GAWgf2FvTu9UW5x9PUA1ozz5C4ovx651G6F6RUYbD1+2zYKdgOE8cNZXaBj/
         weeDt9hM9yGZT3AiEcfr5CDQRaC4ZR0Q8Rz+FTji8vFP8y5nsEhsMqW8cmVruq5ckeih
         7rJYQlfpaPsNfAv1axSJM3zVbVSQhU9ifo8DfJr5dGOihMYWYuQ5I1I7JDBCQ5PP5XXi
         kIXAScLsBpWWFYpR47fW0Hrry4nTBiGGZRmu6y22rQUjm3W4yigrykbQ9W/vw6OM639x
         4yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638954; x=1703243754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGq6oPhsUVdTqLZzaZ7S1PrPM+s1Pa6z7b1UfXTkK90=;
        b=F3xegViPVb4rXl8UsawgYwez7x5xymLuq9YA1aoIunSudcFYlMmibLQYyd6kfNmn8x
         JctxC/6hcBHWgs23c20Q9270dKXDd0XMEGWA9lnJWE51+qWQteXghPBw7MCqwkaiFIyi
         b3FBGVwo49F6pXDtjvdQlkFSsquO1b/WzvB7LhnbCvzb/P5vKR6GAXDk8IohHBGaqeZ1
         M2uZAWX1Jg8XgAAHdxEGdppvZER83W6ZyCVccazo/fbP6+WFtpAff8sVvWOF6SJnkCWt
         5vcS1qywnLwNWmYavdYTRd1FJgRzI/hRbqLUNA6e6pKHMzaNTMjvzP7JZT9W8BmP1Nzf
         +A7w==
X-Gm-Message-State: AOJu0YzGKZg656qu0azq3bcgYInenB3jex5qGLDrloMAqdgX91MAwNFt
	6ZrLC97K3YrdVqyq+ltu9HXw2A==
X-Google-Smtp-Source: AGHT+IHJNyhfre9Ub5s9kt/QZ8VLj3RUMseHeajGQRiN/+J9AdgpX9JKxHmR9vKdVijcRmM5HFGBBg==
X-Received: by 2002:a05:6512:1294:b0:50e:1393:c0e2 with SMTP id u20-20020a056512129400b0050e1393c0e2mr2903488lfs.103.1702638954390;
        Fri, 15 Dec 2023 03:15:54 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:52 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/10] nvmem: core: Expose cells through sysfs
Date: Fri, 15 Dec 2023 11:15:34 +0000
Message-Id: <20231215111536.316972-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7200; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=wFPl5M4upZFBWsXan//pUuNPPb+WjnuRh9SgwcAYUGs=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVYrl0n9Azrn6XrOdQtTAkulRaZNZRWlb8AB 1VasyA+7ICJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1WAAKCRB6of1ZxzRV N7pjCAC2ETBT3/zy/Z8mUX+CsRQTdjJ+QdhqHM+GwBL2VHUMc1Td4uyvwN1LBFWxNuo5h5DP9EL NPZs4CcQQ56I/4Qh18RspwlhfLRVrT5BAeOHKB1mkUdUr6MRxLJVPEdyr9mDXISfJ9YGLmdnzbA zrTldma50xfHMTj2tvwbNuxqYkBktP9NHCEebY7QHEhrt6bhnfWCHPRmT8872z8M/xY2iGbQ87M xE2kg/uH4GbQM6omL2o+Uthp7/Xs0xRqyf0cExP+/MEJUG3GL0W8k/w/7SUD29I7Eokbk80K8Ut IEx1Rn7jwrBPZxzIonFzsCxAJDZjxuI9AJeI09nZll8gL2R9
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

The binary content of nvmem devices is available to the user so in the
easiest cases, finding the content of a cell is rather easy as it is
just a matter of looking at a known and fixed offset. However, nvmem
layouts have been recently introduced to cope with more advanced
situations, where the offset and size of the cells is not known in
advance or is dynamic. When using layouts, more advanced parsers are
used by the kernel in order to give direct access to the content of each
cell, regardless of its position/size in the underlying
device. Unfortunately, these information are not accessible by users,
unless by fully re-implementing the parser logic in userland.

Let's expose the cells and their content through sysfs to avoid these
situations. Of course the relevant NVMEM sysfs Kconfig option must be
enabled for this support to be available.

Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
group member will be filled at runtime only when relevant and will
remain empty otherwise. In this case, as the cells attribute group will
be empty, it will not lead to any additional folder/file creation.

Exposed cells are read-only. There is, in practice, everything in the
core to support a write path, but as I don't see any need for that, I
prefer to keep the interface simple (and probably safer). The interface
is documented as being in the "testing" state which means we can later
add a write attribute if though relevant.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c      | 135 +++++++++++++++++++++++++++++++++++++-
 drivers/nvmem/internals.h |   1 +
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4c2154ddf8a7..ba559e81f77f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -299,6 +299,43 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	return nvmem_bin_attr_get_umode(nvmem);
 }
 
+static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
+					    const char *id, int index);
+
+static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *attr, char *buf,
+				    loff_t pos, size_t count)
+{
+	struct nvmem_cell_entry *entry;
+	struct nvmem_cell *cell = NULL;
+	size_t cell_sz, read_len;
+	void *content;
+
+	entry = attr->private;
+	cell = nvmem_create_cell(entry, entry->name, 0);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	if (!cell)
+		return -EINVAL;
+
+	content = nvmem_cell_read(cell, &cell_sz);
+	if (IS_ERR(content)) {
+		read_len = PTR_ERR(content);
+		goto destroy_cell;
+	}
+
+	read_len = min_t(unsigned int, cell_sz - pos, count);
+	memcpy(buf, content + pos, read_len);
+	kfree(content);
+
+destroy_cell:
+	kfree_const(cell->id);
+	kfree(cell);
+
+	return read_len;
+}
+
 /* default read/write permissions */
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
@@ -320,11 +357,21 @@ static const struct attribute_group nvmem_bin_group = {
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 };
 
+/* Cell attributes will be dynamically allocated */
+static struct attribute_group nvmem_cells_group = {
+	.name		= "cells",
+};
+
 static const struct attribute_group *nvmem_dev_groups[] = {
 	&nvmem_bin_group,
 	NULL,
 };
 
+static const struct attribute_group *nvmem_cells_groups[] = {
+	&nvmem_cells_group,
+	NULL,
+};
+
 static struct bin_attribute bin_attr_nvmem_eeprom_compat = {
 	.attr	= {
 		.name	= "eeprom",
@@ -380,6 +427,68 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 }
 
+static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
+{
+	struct bin_attribute **cells_attrs, *attrs;
+	struct nvmem_cell_entry *entry;
+	unsigned int ncells = 0, i = 0;
+	int ret = 0;
+
+	mutex_lock(&nvmem_mutex);
+
+	if (list_empty(&nvmem->cells) || nvmem->sysfs_cells_populated) {
+		nvmem_cells_group.bin_attrs = NULL;
+		goto unlock_mutex;
+	}
+
+	/* Allocate an array of attributes with a sentinel */
+	ncells = list_count_nodes(&nvmem->cells);
+	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
+				   sizeof(struct bin_attribute *), GFP_KERNEL);
+	if (!cells_attrs) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
+
+	attrs = devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribute), GFP_KERNEL);
+	if (!attrs) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
+
+	/* Initialize each attribute to take the name and size of the cell */
+	list_for_each_entry(entry, &nvmem->cells, node) {
+		sysfs_bin_attr_init(&attrs[i]);
+		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
+						    "%s@%x", entry->name,
+						    entry->offset);
+		attrs[i].attr.mode = 0444;
+		attrs[i].size = entry->bytes;
+		attrs[i].read = &nvmem_cell_attr_read;
+		attrs[i].private = entry;
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto unlock_mutex;
+		}
+
+		cells_attrs[i] = &attrs[i];
+		i++;
+	}
+
+	nvmem_cells_group.bin_attrs = cells_attrs;
+
+	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
+	if (ret)
+		goto unlock_mutex;
+
+	nvmem->sysfs_cells_populated = true;
+
+unlock_mutex:
+	mutex_unlock(&nvmem_mutex);
+
+	return ret;
+}
+
 #else /* CONFIG_NVMEM_SYSFS */
 
 static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
@@ -739,11 +848,25 @@ static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
 
 int nvmem_layout_register(struct nvmem_layout *layout)
 {
+	int ret;
+
 	if (!layout->add_cells)
 		return -EINVAL;
 
 	/* Populate the cells */
-	return layout->add_cells(&layout->nvmem->dev, layout->nvmem);
+	ret = layout->add_cells(&layout->nvmem->dev, layout->nvmem);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_NVMEM_SYSFS
+	ret = nvmem_populate_sysfs_cells(layout->nvmem);
+	if (ret) {
+		nvmem_device_remove_all_cells(layout->nvmem);
+		return ret;
+	}
+#endif
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmem_layout_register);
 
@@ -902,10 +1025,20 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_dev;
 
+#ifdef CONFIG_NVMEM_SYSFS
+	rval = nvmem_populate_sysfs_cells(nvmem);
+	if (rval)
+		goto err_destroy_layout;
+#endif
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
 
+#ifdef CONFIG_NVMEM_SYSFS
+err_destroy_layout:
+	nvmem_destroy_layout(nvmem);
+#endif
 err_remove_dev:
 	device_del(&nvmem->dev);
 err_remove_cells:
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index 4946456c76c7..18fed57270e5 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -32,6 +32,7 @@ struct nvmem_device {
 	struct gpio_desc	*wp_gpio;
 	struct nvmem_layout	*layout;
 	void *priv;
+	bool			sysfs_cells_populated;
 };
 
 #if IS_ENABLED(CONFIG_OF)
-- 
2.25.1



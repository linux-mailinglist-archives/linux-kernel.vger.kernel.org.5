Return-Path: <linux-kernel+bounces-812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E4B814692
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32855B21D30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C825577;
	Fri, 15 Dec 2023 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1t1c6rg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD324B39
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33644eeb305so365369f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638949; x=1703243749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS63jOQC9GkVvD/V3gnNGxfqDZcjIOnsJFZBb/UDQUo=;
        b=P1t1c6rgB8ALJs3XZXs6iwW0BTMBRA9CMnUPbYHVsZf5e6djiH91MnvXk0vL5rSRjn
         a4oyTWWn0dJhy6uoyoQwkjcLCX8fwYJN1zb2HPtasdc1SPBoJ9nLV8K8q28VSfwlSZtL
         lNApQZ/JrfGDmRSmNYI7KdS72K2sp73U7TWty1/KbMdwY7ZyclA6hqg+m0zQqyHQyb5o
         8Y35Hxom/S+sBPbMD60aKzGWgYu7wynEcOaVaPKtrnevG8qxpA8+hGOGJg2f4alJW7W6
         N+6krhlLr42wQX3xKYqZgIGNu+LlnYHk4uhtzkbcCVFb1ojSPnpPkk5J8AJMO0/rKLZN
         Bmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638949; x=1703243749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS63jOQC9GkVvD/V3gnNGxfqDZcjIOnsJFZBb/UDQUo=;
        b=hiCWE8Ci+BN3hbjHAXCvkjh4VyEhd3DDs9jJ9SnEpswMagZsP/Bls5J7HMsk5UQgu6
         WtTvr9bXOVcPfs5sYGWal3lgZ1BLVFC5rJy6UR3n0DrUym7Lxwa94sRy4ZqPKVj43Ve8
         w9FLifWMB1IZssHhxlk2AmHSgxAvBa1XL/jOcxTc4U8J0IvCDPc99ayIwUN7JXSnrBUc
         r3H7RuSOeH3ItBF0rf95AkXFbeY/IyZYf71ZLjJeUrltjbUzEniSBsMZAqKsETWcF/L3
         gEr9n1iRWgyumfgCQNTFKEWEQey7be4RhqEciIrxWTRTOxgCA5uWz+ogNpgii18ZlmhU
         MtSQ==
X-Gm-Message-State: AOJu0YyzpxXPOi/X14HlsVAG0Hp3yyp8RyZqXXvfQqc/HTicRshN66M0
	sShIYenky7QA+ZywOED4vuf1pKvJJ4la4HEFqRc=
X-Google-Smtp-Source: AGHT+IGpRCwfcPMbXdRNr3VTZUkVRoaZGPsWBzZK7CSfIDETmvrPl+Iw6W3aY+6bXLrJCucVp/kbmQ==
X-Received: by 2002:adf:f70b:0:b0:336:4bfe:5ab2 with SMTP id r11-20020adff70b000000b003364bfe5ab2mr985429wrp.8.1702638949128;
        Fri, 15 Dec 2023 03:15:49 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:48 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/10] nvmem: Create a header for internal sharing
Date: Fri, 15 Dec 2023 11:15:29 +0000
Message-Id: <20231215111536.316972-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2565; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=d1EHrgw6/UsDnp63wQlkSGInigR3iNX9QLiyg3bQooY=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVXpdB0V9fnBQLtQID2BdPAhCafnEKO73j8W jQhMlQ0uRyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1VwAKCRB6of1ZxzRV N4tQB/0Qpo/abKZeansCugSOlN79NtCIjjJQ9Rv26Kiaty+3AwNSasbjC5KbCMgeLtU6EOC8/Yr 1gVO7ChnZ3lVT9UeCxMaQ4igZsEHNZX2tkhwCyzazIvVe3kj9bdjkr/tXVqE8rIAbl2eV0H02Ai h3ZkZVSqX9v6RXmfdE2USB9NdKHa1ZlQoerUjg9knQu6VdkHa0OK62/uFcl4Nhd+fFlJ++eWGek vxFkkBTKouVfk8UP757RMA9y6xh1I7p6d2I+cDz26Eej2HrgER61e5lFBXiTvNc8E6QzQ1t6a55 /rHTjmD2R4GT2vGWcZtWlhyKvHT+2qe/VTZ3vZT8Ioi4seg4
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

Before adding all the NVMEM layout bus infrastructure to the core, let's
move the main nvmem_device structure in an internal header, only
available to the core. This way all the additional code can be added in
a dedicated file in order to keep the current core file tidy.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c      | 24 +-----------------------
 drivers/nvmem/internals.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 23 deletions(-)
 create mode 100644 drivers/nvmem/internals.h

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5b6ec8e04bb..b5e5ce67398f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -19,29 +19,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 
-struct nvmem_device {
-	struct module		*owner;
-	struct device		dev;
-	int			stride;
-	int			word_size;
-	int			id;
-	struct kref		refcnt;
-	size_t			size;
-	bool			read_only;
-	bool			root_only;
-	int			flags;
-	enum nvmem_type		type;
-	struct bin_attribute	eeprom;
-	struct device		*base_dev;
-	struct list_head	cells;
-	const struct nvmem_keepout *keepout;
-	unsigned int		nkeepout;
-	nvmem_reg_read_t	reg_read;
-	nvmem_reg_write_t	reg_write;
-	struct gpio_desc	*wp_gpio;
-	struct nvmem_layout	*layout;
-	void *priv;
-};
+#include "internals.h"
 
 #define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
new file mode 100644
index 000000000000..ce353831cd65
--- /dev/null
+++ b/drivers/nvmem/internals.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_NVMEM_INTERNALS_H
+#define _LINUX_NVMEM_INTERNALS_H
+
+#include <linux/device.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+
+struct nvmem_device {
+	struct module		*owner;
+	struct device		dev;
+	struct list_head	node;
+	int			stride;
+	int			word_size;
+	int			id;
+	struct kref		refcnt;
+	size_t			size;
+	bool			read_only;
+	bool			root_only;
+	int			flags;
+	enum nvmem_type		type;
+	struct bin_attribute	eeprom;
+	struct device		*base_dev;
+	struct list_head	cells;
+	const struct nvmem_keepout *keepout;
+	unsigned int		nkeepout;
+	nvmem_reg_read_t	reg_read;
+	nvmem_reg_write_t	reg_write;
+	struct gpio_desc	*wp_gpio;
+	struct nvmem_layout	*layout;
+	void *priv;
+};
+
+#endif  /* ifndef _LINUX_NVMEM_INTERNALS_H */
-- 
2.25.1



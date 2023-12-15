Return-Path: <linux-kernel+bounces-608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642981437A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5671F24725
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D718AF9;
	Fri, 15 Dec 2023 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5DOu1fH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3117747
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c517d0de5so4515065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702628506; x=1703233306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqNjncwqqjJXTlOOAiExi5LnEF+/WvA2Fq4G9Cr+svw=;
        b=L5DOu1fHuPmbuD8K2wySR3lGQIKm8MTlpaNQdHPl3f9f9D++eJ36UBQyeAUq8lpoSw
         FrvvkZ+KLKNKyYhqk1uMMCBkp8wTbETmWGFkG6dpFZtHcqS0Xbi8AcqzwcHn8/rzSqWC
         05tRVpaW8Tt+FvzWrLr4a/9xZP/qYmbUcmDJvHnr5//sow/uJMlnb3Yw40BR2j1bfCua
         73Z+/JEwG9kviVQquONYNzLq+RJsMOj/gfEAT9gW3kI2iAyBHUeqC3iQUnoSCx1u2Pe1
         p/udT/xF+NsUzeA2bbWJdOd+NCpWx8cG97BirLVDaKK4mcgyU4mXMSWbtPqcIWrEhsP7
         2/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628506; x=1703233306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqNjncwqqjJXTlOOAiExi5LnEF+/WvA2Fq4G9Cr+svw=;
        b=d1aKEOsVVdqI7YAe6dbLitsmb/N38P6pjwWmr619xqX2LXmiqQV1tXVuKM06iG0/Ue
         RjVK07vZ/OrU9/q/Q6dVj4/tHsheE0RaFJK+jnYjSXbfwoVww1eEP0itZLFJnbh6Z+Uv
         YcOTCPWsDocd37FF3UU28VVVjx767CNySdCqASQUw1/1Lgz8zH1jpZH+IpcbZFy7PCOb
         uzs1MErMc+Jk0OX4dfLtp8UZ8s56fgxen56mKxvNUsMOals5MWxusjio0l6zzUj/+zTO
         kImtt11zCoi9nHx5dgmvouHb5zdUS642bW7NTgcySSbvHechfZVyNTAtkEzl0Bo6/ttE
         aWxg==
X-Gm-Message-State: AOJu0YzS5xgFffJFi+rlSBmseXRzBt4iO44FsY++tr1Cv+JlPO4oEHZQ
	jh0A3V2mR1WbQHTR1eQZ7EbvYg==
X-Google-Smtp-Source: AGHT+IEAprxPB8+tgE3JnpMosxNYTrH7hypu72LvvlwTtYzO4+cM2VZVHdoj8gUmTcXKKT9/DpKA0w==
X-Received: by 2002:a05:600c:4384:b0:40b:2977:3d7a with SMTP id e4-20020a05600c438400b0040b29773d7amr6188952wmn.31.1702628506656;
        Fri, 15 Dec 2023 00:21:46 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c1d8100b0040b47c69d08sm30365570wms.18.2023.12.15.00.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:21:46 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	michael@walle.cc,
	miquel.raynal@bootlin.com
Cc: richard@nod.at,
	jaimeliao@mxic.com.tw,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 3/4] mtd: spi-nor: sysfs: hide the flash name if not set
Date: Fri, 15 Dec 2023 10:21:37 +0200
Message-Id: <20231215082138.16063-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215082138.16063-1-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557; i=tudor.ambarus@linaro.org; h=from:subject; bh=hQA5sORbw3xtkYv7YIEfdLni0OPdPoQur1BiyIea9wA=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlfAySzUrbRUhPFtUY+SLXVrH2ZVFiRqJ+XTJmx 6Y8ol5Q7c+JATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZXwMkgAKCRBLVU9HpY0U 6d0GB/9LEbjWhFVspZLCZOYxkhAWms2RGSpBdOGHiBozm1pTqpVVvwgUhHQOoexQ+ApAgD5n+qo QNAAdxWhNakleE9iq5tV8QmhYTzaplcyg+8RlsQbpS9fwMGwk98LmHE7Dt974gmuJNFR+IBYhIS iURU69hhL1D3pl2sjh2NaDHEgQuH4WFqIX8+0zP5WCzDyoFB8vjfwsJ99rO8kcR7fF0wwWTvXC8 YU6aEWiUELfKZkvsZwfO7Gru5IgDkqv1mUZumIF+IV/q8zpgf4phkuAwXNfNDfDaXyGWeYi00gE RW7HHx8c1LR/98xHAE3GF2eR9wF9LRM/x8dt/cPZV7u8YKWz
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

The flash name is not reliable as we saw flash ID collisions.
Hide the flash name if not set.

Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
[ta: update commit subject and description]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor | 3 +++
 drivers/mtd/spi-nor/sysfs.c                             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
index c800621eff95..6d7be97bf7d1 100644
--- a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
+++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
@@ -25,6 +25,9 @@ KernelVersion:	5.14
 Contact:	linux-mtd@lists.infradead.org
 Description:	(RO) Part name of the SPI NOR flash.
 
+		The attribute is not present if the jedec_id founded in
+		ID table but flash name didn't include in it.
+
 
 What:		/sys/bus/spi/devices/.../spi-nor/sfdp
 Date:		April 2021
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 2dfdc555a69f..96064e4babf0 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -78,6 +78,8 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
 		return 0;
+	if (attr == &dev_attr_partname.attr && !nor->info->name)
+		return 0;
 	if (attr == &dev_attr_jedec_id.attr && !nor->info->id && !nor->id)
 		return 0;
 
-- 
2.34.1



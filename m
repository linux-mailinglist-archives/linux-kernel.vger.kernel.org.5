Return-Path: <linux-kernel+bounces-89830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830F86F637
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4561F231F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3726E5F6;
	Sun,  3 Mar 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh8NdNmZ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8E6CDA5;
	Sun,  3 Mar 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484788; cv=none; b=BGS4PtiLXXpqG/nbSGqegyQlx5Q/CAKyh0Ibvp6Kzv++5r3+sqhiMMaHDlTjyMqH5L7Rdhlg1Iz9vqvYx2JZpOeGUxmnBQYf9Jmos2tOs5Jd+DA/y1hbk6DS4KPGu+gLgWJZuzO+P2F068ie0Ok9RA7tCOoOjpvabsOskhUYVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484788; c=relaxed/simple;
	bh=Wfe7KoyPBJuztYDXFmPvXzBPupp06EERxKSm+IcMdrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdmm8xmoKdpfVeH72KuikzYzR5CzyqpzfPXNZd8tu628SHX0KLrbnSxSkpLW7n7M+KWPTGopnN/ME4A8SyT8xrfWemohfYg0FLpYfjbW16Pxl2JOFW0RPYoBOTgM7SdxDv8JD2U+F0XhAi59iOXTnMYjFSkM/veC6ifaQdrlfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh8NdNmZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a36126ee41eso576597066b.2;
        Sun, 03 Mar 2024 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484785; x=1710089585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+LGfZkm2kC8YjDAnvH8fwRgpj06URDP8BZpJfKxTVo=;
        b=mh8NdNmZuc07NcAXflmSH6kQIL2R8eeabkWgfLViXbRZIvx+LgoauOzhMWxrLwTZmJ
         dxKplpKTp6c646mGEGmCr8oHfcSWN8aKsmQ3xya6gTV3tJL4WfQwYvBgQ5vamzlRW0Rm
         5Hmvs0ireqXbqC4U4RqM76xmXxJPD71lOKaxVxuhF0IQSEaB2Xr+weZM+IF3NkoIzWs4
         HQMSSQrnzXzxdGU9xyqxS6b05a3OmS9FNA3TVRw2GbwKw48cqKghbWO6tziqG2I7tr4s
         dqWaEQjcnmlGOAsvxjTtNmUd7FmnOzesMnjnpRETMCixaFMvL/Y7QaQKb9LZn4ET135b
         dEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484785; x=1710089585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+LGfZkm2kC8YjDAnvH8fwRgpj06URDP8BZpJfKxTVo=;
        b=mYjuQlOog4PJuIF9iqImtM2bhee6crAP5rOkWSlAE0sBKpfEgfUnmFtR+JDGr+5LWO
         X4rKxLJMjUD45FgNQ6hmiLj4AQ2CjF8gSCAY6JJagXs3RcjrAqljBouGQ2GUGbQG8p0u
         f7DTvcgBfrIJpUBJOYVcvR9doz6SQCbZxFPPBJK2kcbqWkrdTlPO6nPSQoMllwbYRyCB
         iEBarVl8PpPxqdWoTQPo8XMBzC1ybPGQsz3RSQta4wWqcXdQkDsI2nnray2MHMFWNLOo
         xwT7iOjzkCJVyYSYjPK4fjW62XbJhs1FD003D9ln3L0579sXuzXEXg1F8xI0EGwiD2jB
         OeTg==
X-Forwarded-Encrypted: i=1; AJvYcCVVXiEb1kmLDK/KpU1QHcm8j8kOjclfyOv+V6lHq1eXug2ZVhHGsq0j/N3/7oPtuLc6EUp6cGzNLWAJzqKyWf6LBLDhsFjv+mBVFN8UP6i5YVkz37jbjNCzm47G24Q5JNGtG6NLxtTk
X-Gm-Message-State: AOJu0YySMfHlZU7Vsi9QdCL9+1I5eDaiDTJ0IT6foPBRQB3K2a+7/p97
	N03Ii7R2A2gxm4j444laOshWeX8BKnZxsQMbMHJDrrcUEQUytSNg
X-Google-Smtp-Source: AGHT+IGLHdpuVRRL7XZYY+Cu40TxzcnpQ+KtuPjarPvLbWkrGLDMQfR0DCyrG6Eoco4FDr3HkqGWmw==
X-Received: by 2002:a17:906:3e09:b0:a45:514a:24f4 with SMTP id k9-20020a1709063e0900b00a45514a24f4mr98967eji.23.1709484785435;
        Sun, 03 Mar 2024 08:53:05 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:d4e3:724b:4d69:34b2])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170906f8cf00b00a44f14c8d64sm1413992ejb.135.2024.03.03.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:53:05 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH 1/4] iio: pressure: BMP280 core driver headers sorting
Date: Sun,  3 Mar 2024 17:52:57 +0100
Message-Id: <20240303165300.468011-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240303165300.468011-1-vassilisamir@gmail.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort headers in alphabetical order.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe8734468ed3..29a8b7195076 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,20 +27,20 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/nvmem-provider.h>
-#include <linux/regmap.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/gpio/consumer.h>
-#include <linux/regulator/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h> /* For irq_get_irq_data() */
-#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/unaligned.h>
 
-- 
2.25.1



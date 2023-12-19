Return-Path: <linux-kernel+bounces-5705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32386818E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40BA1F26DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBEB3789F;
	Tue, 19 Dec 2023 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhhI5cMS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663437D1A;
	Tue, 19 Dec 2023 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a236d2cc372so221492266b.3;
        Tue, 19 Dec 2023 09:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703007640; x=1703612440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
        b=HhhI5cMSl5XcCLfTqX963wYSwRYBLiiRdOlWc6oZ8wLAfNpVoZTPH9QpwVBnN9NS3Y
         EOGTArgNl4MQtcvZr4RJXcMj1iHGHBz8I5KyRRU7K9UdAhuEe6GbfKr9Vy3mktrrBtZS
         es5NJ2ZT44IkPwTSt67A/rMcTd0K0vdIw0qVSjXLCel9dKvHhhIun30vDztyl63TfWjc
         9/6DHx4NR3zr/URTHc7t4DWjde/HZA8Z0MD/PSvFQskAz2qbEo8qzFDYJnpAIUE5uxee
         IB6bqb0QsH4l7FhaH7DX/mUXqF5BlP4CoeXWmUtesucxcbOT8ZaoKpGBPoNI6JGzldtC
         WLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007640; x=1703612440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
        b=Ln7zhZx0m8FlJ0vSzMJ+B33nyjSDEZv6hXmq3TNX7mAOyoUxzUVuXIxoXtnaJ2s1M7
         Sf32snT7g3T+Fxop+nFeBIfy0puGKwb1bHLyDFTdqiKIQjFWFeTMOi12yhhKJpaEaS8B
         4Jy1j1HtrF51kdFRhDXTV0dDJoiRwM85mv7wgqwzhDTxz45i/6r/jr7hCv/TDmgp+IGV
         EHi6YImLwgenuv1lGkPMVLQosVZ/LyeT7gHvjoeEEDuVaiQ1FcthsiNhwYP2fNxupNWI
         hvsBXv/7N/3phdeetNf3/iHt0QUAL4jF7dI9mJmL9VRuZWNwuuZTQ/XrUB0pYgY3opCt
         3f+g==
X-Gm-Message-State: AOJu0YxgZE6K+9WchTZrvxXHMEOJheKz8qx1bjhE7wWmTpJTlCzSjKrK
	FtHfEkKiQIvrCTSCBcG0Z8w=
X-Google-Smtp-Source: AGHT+IE4Iweh6+hO7rOhKCZkig6kqe51ihdxK4L/LdTZ6cXOsGys0uUBqLTu6ozGXqXinvBp5StI5w==
X-Received: by 2002:a17:906:74d0:b0:a26:8c0f:b0ca with SMTP id z16-20020a17090674d000b00a268c0fb0camr53272ejl.75.1703007640440;
        Tue, 19 Dec 2023 09:40:40 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a1c85124b08sm15834840ejc.94.2023.12.19.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:40:40 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/5] nvmem: core: add nvmem_dev_size() helper
Date: Tue, 19 Dec 2023 18:40:22 +0100
Message-Id: <20231219174025.15228-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231219174025.15228-1-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This is required by layouts that need to read whole NVMEM content. It's
especially useful for NVMEM devices without hardcoded layout (like
U-Boot environment data block).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4ed54076346d..980123fb4dde 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2163,6 +2163,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+/**
+ * nvmem_dev_size() - Get the size of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: size of the nvmem device.
+ */
+size_t nvmem_dev_size(struct nvmem_device *nvmem)
+{
+	return nvmem->size;
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_size);
+
 static int __init nvmem_init(void)
 {
 	int ret;
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 2d306fa13b1a..34c0e58dfa26 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -81,6 +81,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
+size_t nvmem_dev_size(struct nvmem_device *nvmem);
 
 void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
 			    size_t nentries);
-- 
2.35.3



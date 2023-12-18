Return-Path: <linux-kernel+bounces-3755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C281709A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C552820EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB391D127;
	Mon, 18 Dec 2023 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuuAdaOY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3D129ED0;
	Mon, 18 Dec 2023 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a234205785dso162700066b.0;
        Mon, 18 Dec 2023 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702906663; x=1703511463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNpHTEQT4LZHegIzvZ+kMOyv6eP7HeX0Sd04kR5jmCY=;
        b=HuuAdaOYspw94wdKG5bxUvEwaSKcJwHgm21VXu42XHPfv0xkuizanPZtMM+MSgVwjP
         3geGuAyYD02xoOvt3XocMyKMnFFSHDnFFbxUA71/h8Cr8RF7yfgzYIfIknE1e0uBIQpp
         pn3aj/afodScdM8BTNBkZLopVs6hcybjKx5Tz/UR5pX+P8P5piZNPH57xwRdMspWrVwK
         EixReDzSZ1TWfF4dqXdrr2F5w3Qi3xjNxWl0q2FWCTPF8b9/K4t+O6iR2KPPwqoIT5Yr
         iDeW2VoMhicMpQWAv4n55p8lmTNK4owoqNn64CaAkkYbR7l4friYS8Mv0NbSaQ1Pm9xr
         uIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906663; x=1703511463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNpHTEQT4LZHegIzvZ+kMOyv6eP7HeX0Sd04kR5jmCY=;
        b=F3lZoSUZKngm4sNGSzO0rpCs9i+XrWe6g9L5MFru9EWLUz2oa1vIQvbCv4SI/C97Ou
         M04Wxpz0i28N+Zeto0CZXScVqN/wUuIt5wDVGQltEBaHogyO+Ne3tt2EiAoZ4dj2DJOs
         joY28ZkKTxSeFgPMoel7MXlFM0s7udpaTNjdUyE1DAF1um6Pc0OlQaUqusCwP28z40mf
         eB/XvFnOLY++EoT+amA3qUQ7c3laD7Rjn7cXuHeulKvdh0R8N3gNlBUG2S4tc7EfU5SD
         TXeunLYYaK43NQHKqXYvIeePVmvHtoP+fUPAQ7gRECCQH7VMcI7CtkZsxzTybec8U4+J
         5+mw==
X-Gm-Message-State: AOJu0YwKkXskzHwMA4gZ31dhhTUlUG7dB8qdsVxKKGXBolSE9RGAC+PY
	n3lASoBy8vWf3xrL6Mm6eos=
X-Google-Smtp-Source: AGHT+IGtGbsdUUc3O88BnV6j6UsM+dxyCX5fJtxHEDFGyKvcLjEb50ze3OtdtgF9HqxDX13eg9axjw==
X-Received: by 2002:a17:906:3f46:b0:a19:a1ba:bad8 with SMTP id f6-20020a1709063f4600b00a19a1babad8mr3339416ejj.126.1702906662688;
        Mon, 18 Dec 2023 05:37:42 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:37:42 -0800 (PST)
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
Subject: [PATCH 2/4] nvmem: core: add nvmem_dev_size() helper
Date: Mon, 18 Dec 2023 14:37:20 +0100
Message-Id: <20231218133722.16150-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231218133722.16150-1-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
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
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ba559e81f77f..1b08bb072f86 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2176,6 +2176,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
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



Return-Path: <linux-kernel+bounces-79607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D832B8624AC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B0B283C49
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB53F9D7;
	Sat, 24 Feb 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSW3TjKI"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EB3CF73
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775149; cv=none; b=ldvK+kroS4I/9Ria1WIF1AOcMDAr/5d+fJmvzLCfPHLjf/RZI9jATb3m1UkAIj5+Mof2MwELoDTUNpOlc6pFLyfGWMxUz6PxuEAgwRBEoS89SkhMtFWn/2+IREyLmLOo04+UuaP+6YPikHpyvfjYbkfXWyrz+Imsj8syOzg25FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775149; c=relaxed/simple;
	bh=5dyZQ4Vh9bJV/vcHRhq/mZBaQkKJnsxChAlx3FjeSIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2WKKlRPppgu7EY1q+1++nn1cNqD7bphcXgIIZQr6bRWQR3EFF3QVMd+YhZcqc9zNkCbI00xSpVDYcG9gQ8KZErucWKD7zidtSrpyq+L0w3hXSgF4OIhGO3QP4PFCgtQbb6fmaJ3cV5zd8xdJ2RsxSug/AohpKDhWFB70qIp1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSW3TjKI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so185793266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775146; x=1709379946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzveBIxLakGfD0cdsIZlA0dFteMRKWG3Vk1FrE3imik=;
        b=mSW3TjKIYY+7ZSEo1F2LR3XHUoL5dV/nM0ICKVQpRWlQtKSY2ABeh1mLESqX1jhdhv
         A65HuSsbdP8AUKavIe3IMquPZWUbI5PA9XslbL7pZTd+u6J3H4nXnrkoFAWuLvT2Z//I
         9Uc6o1bK1Azq9efn6UbCp+yM2l8scGpSYWHPo4zVJhaAQGiFG+KX0v8NXxLwzxKmqFgj
         9tjO1muQ34D7bAruZ7MvvI9rnOVQSHwyPpqU1KegkKR7euodPZO0ZeoueDSmd9ZqTgiR
         0VYY6dwY9wDwGhhOTqeFU/WA6F4RqjufTG3GpFR+JLKE2weOI5/XUgjZIB/OVgJi7FXW
         uojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775146; x=1709379946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzveBIxLakGfD0cdsIZlA0dFteMRKWG3Vk1FrE3imik=;
        b=ECPnwMui8IHktpzj05lnGMuUo8BZ1rbt0FqrEPJ0RupUxF1gsUuDJ9lpcrtzuaVvcj
         32XBZ1YPPWWDDNnKVt+nFj+tI85x4Os2h8AfdI4RrMdok3l4Wb3bXXdjD0koS+Wj0Y6x
         57nsC4i5Gf6Rk78XX+Srf4+KDvkuogUadRCvL/wRBX32m0g3O19h9P+OcJoNposDlolB
         t+XecAXxl6iWoqtnjx0lZIsFDPqxd8a6xW1I2xK+nhSHgt4Ty7/IGIl+crDsWyCbPpKl
         N/yOefcmnjb6jq1q/rcwjKZYWh6uIg/wuuFfIhIlfTBe1P0/8JZ7/Ne9CsuARQGT3dnW
         PDUQ==
X-Gm-Message-State: AOJu0YxVQntupO2/UpTzaO+qQPkIKEUM97THfFG7G0rcbtRoepVvwFLD
	mOsrekcHxfmNWH7F6T2YtRN9YQ9GE5y9gsJD7J4/YcNzElwsDnX8cIUi2tGeCyM=
X-Google-Smtp-Source: AGHT+IEpd5PlPRsGDHw+PzofE5h5q0BHl1i6M7E+yEJ8KzdfntNMAQFH1d8ia8zh8Sdjycc5kMTsmg==
X-Received: by 2002:a17:906:b154:b0:a3f:d1e3:b906 with SMTP id bt20-20020a170906b15400b00a3fd1e3b906mr1207657ejb.25.1708775146148;
        Sat, 24 Feb 2024 03:45:46 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:45 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Michael Walle <michael@walle.cc>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/11] dt-bindings: nvmem: add common definition of nvmem-cell-cells
Date: Sat, 24 Feb 2024 11:45:09 +0000
Message-Id: <20240224114516.86365-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=P2NyplVumNiZcg9Mp9j9BQ+uKvSsw6Ugatz/uYFEo5g=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLP88NrJkVscZYIWbXKQs9FH11RQ745UlG+ Ddwg/LmySqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N5yzCACCYmIcLpgKardB0yXudbiR8EXRIABl++s0xY87Y/nZdne0nZPCHlSDiZXbbYPF+LXcFro sbuUBAWgRH++oHq/FaDaAZW8M2SQ95mNEucN5rIz5N5LaOpQ24NirQ/blwp8nH/uZh49iauHRIl dATWX9FgT4rFZXtdJRZe7J2zGPEksVWlQZV6xRIwHNW8qu9cglGTiZcf7GaERaQ0Op55ki4JFlL aksxd81gKuHSabOhyAQsK2b2LwMicwlNughluqrG1rlFjiW476zS+Jg7bogNr/jg2+htCmtzW1S 7fxYAdivFDFVmxBK9u19YdcGV07gOkRAXq9/x4oVDwtmv+LW
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Linux kernel NVMEM consumer bindings define phandle to NVMEM cells
("nvmem-cells"), thus we also want the common definition of property
defining number of cells encoding that specifier, so the

Suggested-by: Rob Herring <robh@kernel.org>
Reported-by: Michael Walle <michael@walle.cc>
Closes: https://github.com/devicetree-org/dt-schema/pull/89
Reported-by: Rafał Miłecki <zajec5@gmail.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20221121105830.7411-1-zajec5@gmail.com/#r
Closes: https://lore.kernel.org/all/bdf7751b-0421-485d-8382-26c084f09d7d@gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/nvmem-provider.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-provider.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem-provider.yaml b/Documentation/devicetree/bindings/nvmem/nvmem-provider.yaml
new file mode 100644
index 000000000000..4009a9a03841
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nvmem-provider.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nvmem-provider.yaml#
+$schema: http://devicetree.org/meta-schemas/base.yaml#
+
+title: NVMEM (Non Volatile Memory) Provider
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+select: true
+
+properties:
+  '#nvmem-cell-cells':
+    enum: [0, 1]
+
+additionalProperties: true
-- 
2.25.1



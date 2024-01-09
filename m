Return-Path: <linux-kernel+bounces-21425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE4828EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC331C2312E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595413DB94;
	Tue,  9 Jan 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFWfbkRc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16B3D577
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7c6e3c63so3622068e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704836263; x=1705441063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Df5vbAJJu14yKYfvCr4fxtDlzFXpAT3tR5jvbBHluqQ=;
        b=YFWfbkRcOHKiTZdcmpDxQFyWVW6egN7PGpayOa+HqUmjjKDj/fEvGRWEEdSRnGnDry
         wLzQAvMiOzw7H1PU+0qh3Jv1zM3DsH2c72SKg4YXyFcpbKStzZ5NdJzzccFDBJXaYYWu
         SqjtiEbTVWSmT7ibTXcEx7LMvaN9lxJRbZKBLL9Kv8WEj7neZjY1s1GHxsqC2Bv7NXeF
         fL815P1lyds6qVmbOhN9Y/I2YGU9kws+Df8x0fdEgcVR1CGdqHkqP41D2NXMBVud6jX0
         w1tyjOXNWP7By2fH2VmzCg71wAGQvJwq0c0hmZyotXu9ilMA5tBKghgBhaBw/2DAN/BE
         /uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836263; x=1705441063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Df5vbAJJu14yKYfvCr4fxtDlzFXpAT3tR5jvbBHluqQ=;
        b=PNUS0tJ9Z7dSdb8I6gFdVGkFHAMPsxQ5Fu4XkuvS97465vC4oEGoM9S3GrQDuP/u3e
         Wqx/5ASOkMBQzM0mtg6HXpGZEOgdSfFe/ImNi9NXdgmNtj1XuexV546VpsiR2RaRskgj
         dcnEf1IayKHBCXCtS4A9hdmrG02zUHEvDnqbT10uhDmg/x0ytvgdiKQX+5NM2NMbriJz
         LhiVSRtZrCAIUKO6VL461r45vfYe3DKZ4NiTgC+d8eddwm2TGZusSKVgFFC/1GEZ6YR1
         fxYiyJrZPs4aSSQsjdSe/vRY91huBBfSVRxNQcEKdEOxkjtOP5iM+J/Q7F8GUfy056J/
         5N/g==
X-Gm-Message-State: AOJu0Yy1VTVlo9jDGxo2gNJy412RZgXhdgSzsumkaKnKHkrqnmKjSxZK
	v1Dg26/iKRkZinyzackwjMlFpk8iSkiFtg==
X-Google-Smtp-Source: AGHT+IGaixYqKBLJGCt7Dc8bk3FuZ2kSYvJcJs/DSrS/IfT6nLOs57OXi7Hzzt5IyKJ5I0YIuzzo2g==
X-Received: by 2002:ac2:484e:0:b0:50e:7b7b:5557 with SMTP id 14-20020ac2484e000000b0050e7b7b5557mr1310256lfy.145.1704836262813;
        Tue, 09 Jan 2024 13:37:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709063b1100b00a2356a7eafasm1413272ejf.199.2024.01.09.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:37:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Michael Walle <michael@walle.cc>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] dt-bindings: nvmem: add common definition of nvmem-cell-cells
Date: Tue,  9 Jan 2024 22:37:39 +0100
Message-Id: <20240109213739.558287-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
2.34.1



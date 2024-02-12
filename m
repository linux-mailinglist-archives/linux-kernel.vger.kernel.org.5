Return-Path: <linux-kernel+bounces-61392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D708511CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D273928341B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53A39AD8;
	Mon, 12 Feb 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbfhFC6D"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26E39ACC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736029; cv=none; b=HWX0ZYdcovYQThF3l2M4fB+LvXxPk2rjBP6rXoUtpVjx7Yd1lv6QpYiZa5+cpmvRrSv/4P56WeEHA09hrhQkfQ8ZvNyqWLueUBvLxUQ7BCpJj+RrncyZ84lod4pzlXjPbOBrFOWzkAnHeJCrP2wj40nSK3TR6UMHe7usF0QXvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736029; c=relaxed/simple;
	bh=DY8o/VQXRUa5QoIDTX00ECuxzx1WqON+8o6HzkJeLU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kUwd3KcxpFz+sZgDWiQK50jitnDxntYNWe4NaCJX8waQC0LMCBx2baBfcMef1M3SIn8oPXa9Fc2REjU0zjJEeLIMrY48RI4dIL/VHKiNdCWIMktrmYej9Pq4L9hlyphbTBPTTKhNexIWP1495DriQGyHILx9oGeTneasJ9FasNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VbfhFC6D; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51167e470f7so3656168e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736025; x=1708340825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+V+DtL3M3Rj9vRnNZ3NZn5Sw4Np7ene/6WMj7oNvNE=;
        b=VbfhFC6DDj+x2O+/5jfNDWSFoDfEgJVcTbo/25FDTksBJlH8zJVnz/YvBatdNVyxBZ
         F1cz1K+nXnB8x4hOrCqdVS/y1H5aL70PEIl093w6xSYXb8WPjWsbFklHBE01AZx+Yg2E
         hMvFMwhf2tSKg9YL1GNyF4J3Vb0viaczbZLIlyDyJ2ZtFSTp+d38Gxi9OZ9Ulank7n+m
         CUkom+5BGbaji6KixfBadIt/uhwYejAs5ZXbAJwEL0Omj0s8H/ToBQUEj1bV+qeRYqKd
         NHW5QR8tEOEOZw0YgZ38Xkf/UMz7fVze9VzTxrOoAvAv2ALSV0/a4CzdHMIFrIjYwdhp
         096g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736025; x=1708340825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+V+DtL3M3Rj9vRnNZ3NZn5Sw4Np7ene/6WMj7oNvNE=;
        b=ANTCpJNagrSTA5QtyySePqqIUtpyisYfuq8tUSJz0BoiORYqvs61fntSOPfesOejuT
         9qNVM3pXrVZgWK+EinelhgMwRyJlmm/beY7pFyIBpt6l4PGlsZTVeXg5ecoZdAS6tcxz
         K/mN8ZwfRdf/XSUMmFc6hymWK7v+VvP7uN6be9TpMeDeibVj7tEzVYASyPMjXSn55APF
         zc/mWO8sbJ5bsOsFExs/U1xz8ORk7Ie+rO44yjPpQwhKPNtae0xmi68kAYWrtvZ6jHua
         vknh5Y1mkEEiixf3ttpQR637f5zmnaoRe/bkhOFJBLbDBD7htP+484Fn08afA7FHd0p4
         pC/w==
X-Gm-Message-State: AOJu0Yyz4gFI/FmzKIQLnVDDgTDMOe+rwoX+4VmYdog+6CqGqmDt6W4H
	sLDyBNF3ftivb/ew56leY3JSg0FNlGlDo7csg1YnvxTn/WqYVyffQxxjcMLLVvo=
X-Google-Smtp-Source: AGHT+IEnEDr5gsCbLJgFDMFEY5M22eDodlKJiLGCqkGUnM0t1LCQruxYy9V51zcei2bYBNfvPp8wFQ==
X-Received: by 2002:a05:6512:54c:b0:511:fb6:b1a0 with SMTP id h12-20020a056512054c00b005110fb6b1a0mr3959494lfl.52.1707736025497;
        Mon, 12 Feb 2024 03:07:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaBfnzmJBmbV9qNbkHkX1vXjbHEfJwRuyb/GnkZgxZZXFYaUdh5X6HksxuofKt49BdfajkqO67fTexlfe0VR3tZHxs8C4t/qBul62EC1cqyH5rd/C1r2QEZYEjPEsDj7n3UBhZFEbzAPJg147HXH6caCT5WeQrCzG0BxHk/iYTZMCFzxNu8eeSuzT0DUgBxzYHqe3SKsMCN5qowEEdCwEPiIy3huL+dB61OQjlwlXEuMiltxaWi5XnzE2bUFD3/qRgFZZGxppIMdjRS3mow3rmljzLjw48WfgOCavtc9JMy/dgYp1xVZoxVK3ggMVuVqShfzbDwiLv
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id v1-20020a05600c214100b00410395dc7d1sm8256067wml.7.2024.02.12.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:07:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] misc: qcom,fastrpc: Compute callbacks can be DMA coherent
Date: Mon, 12 Feb 2024 12:06:36 +0100
Message-Id: <20240212110636.57945-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently on Qualcomm SM8550 and SM8650 the FastRPC compute callbacks
are DMA coherent:

  sm8650-qrd.dtb: fastrpc: compute-cb@2: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 2dc3e245fa5d..c27a8f33d8d7 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -77,6 +77,8 @@ patternProperties:
       reg:
         maxItems: 1
 
+      dma-coherent: true
+
       iommus:
         minItems: 1
         maxItems: 3
-- 
2.34.1



Return-Path: <linux-kernel+bounces-116845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771888A3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0932E2945
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E414430F;
	Mon, 25 Mar 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyyvSCR4"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728016F829
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362979; cv=none; b=Zpup5fijx6Pl7U++5OsWFWrGYcoICnSNe51zyQLdYLtIbGNSLzlPgWDGYeWh4BPio41MejYYyYBuAqbdPvmfObP755BlN5O3Oam7/qhq/iR02Xs6UlQxaeHKisA1070zC+pNxG0icm6TqRpAFY2S0uD42JD3QlEjx9MqlVaZp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362979; c=relaxed/simple;
	bh=jqvU3Y2sBVXpLMRkDMJYk9Nm5Kg4ldvtAjFdlImDn3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SzSdEO9O5kJSK0qbNRrctsfbGS2Lxx6pl8GQe9b4RonC4KUAwbDs+b5lcWbOfJukD2RvUkLgpg9/3vaM99DOVwyds01uVCSsdAEvsG8/tvrXbef4P7CVQXtzj42MhRq0G5nsxkC7ovvBv0HmFqsOszEeyw4wf+hXVtlQLzqZtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oyyvSCR4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a465ddc2c09so231969266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362974; x=1711967774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sOPezhldmxSnr8OT7bAHjF4t98n/YFRx58g6GLuW1s=;
        b=oyyvSCR4onxuZ5WG3yDM3NZKytDqtmFRVbIBEHpGrgxbLccCUF+vAoFQgcKlehRMT4
         6Xx7dsnoSY6AjQhQ50nS7vG92eynCwz0r2yskCLi75Dh5gTQzUwZ/pcEZo/F+p7k20Qa
         PubTvMCGTobjcqOWjWNddyO7eP4dEcrnI+eNFKNyIixxxTxbXWAEFJ5XmpXRomDW80ol
         ubeLYROG/gf99pUY8diaxrn7uB/Klz4oxya5L2u91yh2FC1diujmh39SJS/Hb4mTN6m+
         BO1TIlHe8Yd7FjfDJjiu5X01bBaexh1T9Dt2U7OJcWxQ46uT/IHTZbXMcHQPr53D83Gn
         V6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362974; x=1711967774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sOPezhldmxSnr8OT7bAHjF4t98n/YFRx58g6GLuW1s=;
        b=sfuZLjK44YI0Ulo/cQUMIWMOLKgDhpi7bQR88vRq+92YZUSQy1dlus46Yf7vWOqOwq
         GiJy7O3Gtft5iVU2TmQuDACx6VA+00UogfzhnXtroje2eSvqqb/WmgXLNTdCfIrdtVyv
         NyB1mCj/tiB2I0Uw7dtf53wsJq6GTfrAVR4T3MLc0Wk09UCf/KWr3iUMu2ko3aEMKbhb
         9FmSSIsM2EEd4XkEm4H0psg+o+pSLokjgejWVK8pNYr+YsAidwrVH12w97DL2q8EPoWl
         U+MrPJvoGfJ4mWh7esNyGUTGxuPZaEOL0Gjw7iwlxaVH630FV472s9bnJNB0jHk0Sd/k
         1UgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc1/BRSJKzEuHdPgVsgTsBVUzX9ZJKyL4DMeOVliE8zJAKD986514oOlZ7H8NT4nOZBBqJSey5vf3JEdLDI1kcedpVBjGrEHEEKBKb
X-Gm-Message-State: AOJu0YzJNsKxzj0f1KJ9kfLpdxc8+DcAbPm8eki8Zv+SoUFT3vYRWWdV
	qLe6BRU9lKCvS6beymuHX1he0Jwvzl0u35FP1SBkPRpEcvsQnl6MhV4PEBCRPn4=
X-Google-Smtp-Source: AGHT+IGxM8s228b1XWbE+SeGTrM1fDdyMya66yBrGFVuE7WBvD2ok2jlRcn2B1rUDQ1HBTx/Bvze3Q==
X-Received: by 2002:a50:9e44:0:b0:568:d19e:7ab0 with SMTP id z62-20020a509e44000000b00568d19e7ab0mr5606866ede.36.1711362974289;
        Mon, 25 Mar 2024 03:36:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id dm28-20020a05640222dc00b0056b7ed75a46sm2827319edb.27.2024.03.25.03.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:36:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianhua Lu <lujianhua000@gmail.com>,
	Del Regno <angelogioacchino.delregno@somainline.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v4 1/3] dt-bindings: display: panel: add common dual-link schema
Date: Mon, 25 Mar 2024 11:36:09 +0100
Message-Id: <20240325103611.28240-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add schema with common properties shared among dual-link panel ICs.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes since v3:
1. Re-phrase description of binding and ports (Laurent)
v3: https://lore.kernel.org/all/20230823081500.84005-1-krzysztof.kozlowski@linaro.org/

Changes since v2:
1. New Patch
v2: https://lore.kernel.org/all/20230502120036.47165-1-krzysztof.kozlowski@linaro.org/
v1: https://lore.kernel.org/all/20230416153929.356330-1-krzysztof.kozlowski@linaro.org/
---
 .../display/panel/panel-common-dual.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
new file mode 100644
index 000000000000..cc7ea3c35c77
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Dual-Link Display Panels
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+
+description:
+  Properties common for Panel IC supporting dual link panels.  Devices might
+  support also single link.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: First link
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Second link
+
+      "#address-cells": true
+      "#size-cells": true
+
+    required:
+      - port@0
+
+# Single-panel setups are still allowed.
+oneOf:
+  - required:
+      - ports
+  - required:
+      - port
+
+additionalProperties: true
-- 
2.34.1



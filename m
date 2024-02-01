Return-Path: <linux-kernel+bounces-48375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A4845B27
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCBBB28B58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926ED626BD;
	Thu,  1 Feb 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFvaswjG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AC1E894;
	Thu,  1 Feb 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800697; cv=none; b=L/TC+v+jJEMGSmv2cOG8XICPtLMKeVlgI1V/JW/6Vnw+eaPQA5ZKPgcX+1r0GqWZ2vs9pwRjAV2JEw2+H3iKpaA+I/bJpgkjhVzzCFAiM+Jwk1XyNfejS3B0RZ3Fe/XEHvV6oSKtY5+k+r2drzBn9QqgUkHASaPutRzm5pUDT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800697; c=relaxed/simple;
	bh=bggx5HzauvZU9OkSp9vlWgoNvtT+JuJSFKaHN79sbXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHrV7vdhsL0aciDZnP65fs19Tevbr+KPTJtUrkvz0cREAtGpF9/687sBwY97VOCkKb5C7/rGqJEnhohQ/jYRmvIvjb7XwGYZKUkU4Q3TSz9WqxYpsj+ctyARdi13zRT2WbaJWK+y+t4L04kTrxbVhyNKIKASuDGgVjQEVfQXDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFvaswjG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so11956991fa.0;
        Thu, 01 Feb 2024 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800694; x=1707405494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1Ibo8v/sTW9ZV+SHnIB5lIu7S/Dsq2pFigCp4Xf4aU=;
        b=AFvaswjGdeTwS871I8B1Gi/qcyhFVGwsx7wHdVASDR+x86KQRylIM3v9jGqU0FoSYc
         ElvT1vVMUGPI7jLqk3JOIPPuNLJ81ng/drunIZcQc05ow6Ojk2BKczWsFCfuusGsBEMk
         0rkN+YId/JuFIVT/vQCuBJzwvAL4pQFbYQl1mMtCQvouPuj8TXsFTJwBnDPoLA09wcr1
         EeSn9i/l4fnV+RGC4IJBMmnQO/cnyvnymipIznGH6wagcc7+0wsQO6wqqul/i88zfZuA
         /VuSLzhWaai7wv1zFw1+qcfmN2RSqdOtwp6ys2UtpzsLM+n9zPg4pYEdsDmVOvzuyTA/
         w0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800694; x=1707405494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1Ibo8v/sTW9ZV+SHnIB5lIu7S/Dsq2pFigCp4Xf4aU=;
        b=rurByiMgb5kANPLicYUqrH+xyvb5OIdjawVwUQnjjC1IMFi5I8xLusNYm4dEmaASS9
         Bc5MAEvU7EdSbkvtiHKzU2+qc1Z6Qdzyrti1RiwqbXMDtboA9ZASDM8e3NEcMI+fOweY
         QvIAdrwQxk+aWKrY/HAofV2Doi7zpr3SlTPUfe321G0I6a7eaB5Fef3rGQs733XgwaB6
         zFjkOuzIK5aeCLw8WiIJcpU1UdhARr3gkjVmUJOFXwbjYaZjOS8OzB3x2uwD9ElFnzV2
         VycGB0/9QHYzyWkZVd/e3XFTbBeUVqsnw5RTeWGbCSDfMi13rmAFTLZ4WMDIHw1TFuKO
         mZXw==
X-Gm-Message-State: AOJu0Yw5xvjcgyOk9poWxB0RHwOVLlxM8QZgvyPW7QdgP1HNVZ9oamPF
	lzogLBinFrdaTUSy1wY0T2j9WeUWUfd8isH4W9mk1mqu0qyutmv8
X-Google-Smtp-Source: AGHT+IEnUDKRJCvh0O404vK+KTJexrkdslnQr7U492JDijOxUYHSjjMjS8Ry3M2j68SgRL3JSaK2Og==
X-Received: by 2002:a2e:a405:0:b0:2d0:7c49:78bb with SMTP id p5-20020a2ea405000000b002d07c4978bbmr948215ljn.16.1706800693861;
        Thu, 01 Feb 2024 07:18:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+2E4bRvJIUKOwlaksewdMBpOsgPZ1q4uQ/XMsq01qOZRFF2OuNvcZ+V+MUicvCkAo5yo07Pw0ku2MGKOzg6+v6oIAmd2O20SO7SI7ntabXn+lEwpDvyOOSTS8xZhYCa2B9VcprnhmhISZTlqff7aesPxYzqIlgdTIucfWW66lx8+I9bxuiJq5QrCI3yvNs6ZriwPdy+HL+HBdCbOrcQkf1mC9GlW6TPC8r/ct6F3LBc0R9e2NCQ0NE1wpfqE0kuXWtHQzuWMFP39tEh+vpTViQz6Kq0KTmwg38HiFO6gV5WJAcYQnodSNFRPl8meFJm02runRmF/CVCdM4p8gRXgNAs8b1OGdsxtEM8SAVNw8fFnD7uILP+RVekG/vyrZa4aIW3Ipzoi/6VHOXMoVmh6Yf/YRP6liz6A6/ST3pUtyUCBQ+4lLP9DkZx2syQt0d6yWb+YVvYCRv957iibpeJ8p3eXl6M6UoYHo5hRvbbgnLT+Bki5ExlTkU6o7TMDdsYVOVdB2axzG3jNx2bVtcIneOXQekyKcFwlHND6ZHB4erM8wPT5YKst/T08+QMCnyBPDSmdzYeErGF9Q4NbB6IY7jRR3yVa+SsW8kFtVZHb+2HZzsICPKGJa
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:13 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 1/9] dt-bindings: net: document ethernet PHY package nodes
Date: Thu,  1 Feb 2024 16:17:27 +0100
Message-ID: <20240201151747.7524-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201151747.7524-1-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document ethernet PHY package nodes used to describe PHY shipped in
bundle of 2-5 PHY. The special node describe a container of PHY that
share common properties. This is a generic schema and PHY package
should create specialized version with the required additional shared
properties.

Example are PHY packages that have some regs only in one PHY of the
package and will affect every other PHY in the package, for example
related to PHY interface mode calibration or global PHY mode selection.

The PHY package node MUST declare the base address used by the PHY driver
for global configuration by calculating the offsets of the global PHY
based on the base address of the PHY package.

Each reg of the PHYs defined in the PHY Package node is an offset of the
PHY Package reg.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/ethernet-phy-package.yaml    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
new file mode 100644
index 000000000000..d7cdbb1a4b3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ethernet PHY Package Common Properties
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  PHY packages are multi-port Ethernet PHY of the same family
+  and each Ethernet PHY is affected by the global configuration
+  of the PHY package.
+
+  Each reg of the PHYs defined in the PHY Package node is
+  an offset of the PHY Package reg.
+
+  Each Ethernet PHYs defined in the PHY package node is
+  reachable in the MDIO bus at the address of the PHY
+  Package offset of the Ethernet PHY reg.
+
+properties:
+  $nodename:
+    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
+
+  reg:
+    minimum: 0
+    maximum: 31
+    description:
+      The base ID number for the PHY package.
+      Commonly the ID of the first PHY in the PHY package.
+
+      Some PHY in the PHY package might be not defined but
+      still occupy ID on the device (just not attached to
+      anything) hence the PHY package reg might correspond
+      to a not attached PHY (offset 0).
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  ^ethernet-phy(@[a-f0-9]+)?$:
+    $ref: ethernet-phy.yaml#
+
+required:
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: true
-- 
2.43.0



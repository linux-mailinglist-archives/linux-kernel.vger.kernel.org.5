Return-Path: <linux-kernel+bounces-55382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187A84BBF2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB908285B53
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D605C142;
	Tue,  6 Feb 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ9/syYM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAD12B9C;
	Tue,  6 Feb 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240754; cv=none; b=BvYkGs/INv14giJv67Cf6xJRUDFICuKHXkXQ7iKu1hCS3oMiL/vJW9sewD+O9olbloSCgtJsbPY/BdsET1ysEGbTbHbgbqUA5i1sdqPE44pWBsfAJeccMG8LN1VTELDYSNxmdOAw5Zb3xxK4utfF8H9d9uljngM68Jm65oP9rUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240754; c=relaxed/simple;
	bh=ilTj5VWnzbXDnAmzljy5yyfGbnvyZnNPzs2eb6s2nj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPyjp+bYUfggKtQHKTs9gkaEwUMOy925DRPNbHzH27m6k2E8xWsAU2bsQlz2oqVs0Y+2c/W830j5dGb8y+Mk9Q3le/4CAM5PeWVWLoKxXqgDOyx3c/LUiEHFElxNyxnXlakleshIiKK3nIb/CUy5SzDwfVrm8GcC5qWn0UKGhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ9/syYM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so5342615e9.0;
        Tue, 06 Feb 2024 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240751; x=1707845551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hloNsWsZXa6Vf2TLiftzXJ4XARi6FJ1Kn6mZNuM3PA=;
        b=kJ9/syYMXuy8TjN31Rk8350olIkgfMDeIvS4VfOMoxHCw61GJU+LD+mMWt9dOjXFlr
         goFkeJScEZf8pCPN0wwwsc26cE2pX6OyeLzXtvx2Eph33Gd7LJgCP0fitNAq36Uu7Lj9
         w/aJn3pP71BYHc8BbPvbGVqfasdj/O7azqJ5LepEpOOrTVNP7QOD1fd1OjG8W1nY5oSU
         VJ//HflgeefLF1Wd8knf6eyzAQijzCcAF60vfvftaTGjXc0slngCxRA0u0RCxkKf9O1Q
         DpJP0D3XydX+jb/m0az7HPQhFC9o23DsEc0BlTe7GnG5/i0dXqpiU/u51vuQvsn/978L
         qiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240751; x=1707845551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hloNsWsZXa6Vf2TLiftzXJ4XARi6FJ1Kn6mZNuM3PA=;
        b=Qm1nIu1i1FvFzY63ILdT4gKy7f+ncluty8LG2HJzYk1bz37q2TU8TY5fAq2bkAOsh9
         vPE2oot3kW3xZGAEl3QeauxDNRS1gXztkpYsfwBfDbsYaqnk+E3wpuurmcfGL2p6ygws
         S1oGOSNSzTYpA/ihE8HK0bA2YmgJfw+azDeYHHA1b1krONJRcGFwOqQXw+gNFjBm2E1s
         r6SCKE6sybQ4sxa7N/Uxm3G/TC74hynbMDhOKUi3XC8ROHJSrQqJhZMXz+O9p5A+UFPU
         Qg9swBFa02YyZJjH1ekOnlbN7mUCYLtf1U/0PgQVtfhPguqH6Vo56Nkk79fUBSF5eN6G
         MBYA==
X-Gm-Message-State: AOJu0YznX5MDsy3eQARUyc3+3UPCMuz0eHOSC/LDDiNTde0MOPA1gHfJ
	YjyB1zVSh051F3+NiTSLq+nzKJs6rpje0DMYguKkMhg9lWmGE1qO
X-Google-Smtp-Source: AGHT+IEA4QrnnNM/8eK+gYClRi1ppp1d2OpxthfD7v0aXswCDlRC1NXg547xJqw8pQ36v+HQxLemqw==
X-Received: by 2002:a05:600c:5128:b0:40f:b0d9:632a with SMTP id o40-20020a05600c512800b0040fb0d9632amr8007669wms.14.1707240751116;
        Tue, 06 Feb 2024 09:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgFauZBrcLwuGEQZ+pUc5FPpEwZmhYtSW7xcv5F7v51NwwN+53pqsLhik7Fjd9JMukH1SMkY2X98V3OAoT1VyNK0Dhc48eRNk4KAaeMBVdt44kVL2vGI7ufgBBwMH5IsXPIWNF8o2KTKYSb9iSxbEmkjP5yaOYNYh3fQyhLdLhZKpocvth8SEhZ4J9rIFZepv8PCNOKWZg33H2nOAOJ34Yi+XlMRxup14Y6BicswuXaIeNCyN71TdBWtNPGtRbSaGVhUXdYVHIEj3KgW4R0Q040AmFobIAW0gQivurX+VrEzTitjvHyMKoDqu9dZSNUyZdAy5t5AOJ/BVP/pu+WgCGQxRu5Zv1jytEwYxU9oucjyHrEePGS02uIgu39r0hwcN5cH02F/8bYZizBTC94RvB96/qRcWDc3nDoMAlYi3nByNqCZ/73Kt582xKmEex0CoUxenSL9CulzSBvcEIbr+MRemT1NjLJyZ18FZDUB/lJ2i/es1aL05IxzQD+rfaogZt9sHtEOcWVhzYcH/+H82CHl8Qe56Ir93GDLy7sIfwvLVL4qwJs0RFtqOXTXkpA09Z3sdxakUfJ2/qC+kwmxO1OTlqM9/3lIOBiumTg0TAPCOFx0/ZQov6kZP4w7pqgB6uzcK+LdLesPVM4528wHRVKhDq5DhNWaDBIwSSQnqnE0Wlo0rB9Q==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:32:17 -0800 (PST)
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 01/10] dt-bindings: net: document ethernet PHY package nodes
Date: Tue,  6 Feb 2024 18:31:04 +0100
Message-ID: <20240206173115.7654-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
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

Each reg of the PHYs defined in the PHY package node is absolute and
describe the real address of the Ethernet PHY on the bus.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/ethernet-phy-package.yaml    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
new file mode 100644
index 000000000000..e567101e6f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
@@ -0,0 +1,52 @@
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
+  Each reg of the PHYs defined in the PHY package node is
+  absolute and describe the real address of the Ethernet PHY on
+  the MDIO bus.
+
+properties:
+  $nodename:
+    pattern: "^ethernet-phy-package@[a-f0-9]+$"
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
+  ^ethernet-phy@[a-f0-9]+$:
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



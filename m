Return-Path: <linux-kernel+bounces-60536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A585064B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8541C20BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA375FDA2;
	Sat, 10 Feb 2024 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP4mMODC"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338965FB82;
	Sat, 10 Feb 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597980; cv=none; b=afntwBWXemNfPFP5eplnf5XNd+ZEny6tTv076amB+R0v9nWMsAlr0Ls9DL+TkE6X2CEs55vPxesRxvuGgqrYgOjsDVQnPvLsQxpYFcXQG7JUff87qUnHlDCgnwNfrp5HIfRqYYJvL7foUcRhpVx8sygu3dQQQrH9iACZZbB6H/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597980; c=relaxed/simple;
	bh=rXbR43z2QOxKE3AWQxboG8VV3Z0YrQTTjB7YbiAIRvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXeQZjJXo8CeNIE6sk7+E5C87bbhEP63ViMAcH9Ey9eI4NAGbn6HNHO3FHYfDw9nLFOOqYSOVX9N2Ms238EjF3XbzSXy9KsR4X4bu1mCwCAWcpJJrnJv+hj+Qc9YSFmeHiBueV0EumoWcMFHip4J8YPLqT0AhBYOu4a/A5nuGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP4mMODC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a8900bb93so16110441cf.1;
        Sat, 10 Feb 2024 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597978; x=1708202778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkNsLeVU+SRAFCzJ9Atwqu/RzNdjkmQfb6CAAkLA5vg=;
        b=GP4mMODCiBzrNkoz/6FnmXOBvPqeWkRE9iD4Vcv+14CEdVrssDi2KV0BqOu9eNlnnC
         DvqPBQ+qkywwJT3jV5zhIzi43K0A1hv1kZHe1dHgzYAkjheOX5iLsUmhwWwOilEhe7RF
         gnGM/A2Fh4nX2xbEEnLUrEFd/J5yvpnfNBrF0VNF/S3+FZ/2g7lEhREdx0g+03SvXtZh
         YNa5oCXxU6rWIPgYDur8sNxvrRvCLJDAWHB4drPSa5jCTf4P0xPtGNOATEgZ2xvt3FAT
         CDT6brJbldHsevFb9GHgz7jJ+H7EPVwoHueQBHifI2+//ZvDcVvCJar05+ZiOXBadaT5
         +pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597978; x=1708202778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkNsLeVU+SRAFCzJ9Atwqu/RzNdjkmQfb6CAAkLA5vg=;
        b=uXhhJncXOZrYPihrxVV4QE5El367nSGrEqAMJP4IWu0kyBR8ANv0l8aXyKkfcXX58A
         NRIRBopB1ICWwK720zwn5+sI/f5cJ2M4tkK003sliGNs5Yrc8m5roYCMoHlYmn2KoS+a
         So5AOQKknxA6irvphwRnELQHLbIf0UVDDF0EZF+HJlv2+zO8hwBarHtjai9PUmYBR+Q6
         Lw4cz+abwnzGOiSorCivwnZOV2igcxTD/KxkmE4EZhp2c+cfqXgDQqILMFGiw4yPLWkU
         Jk3bJAuOkmk2CjoO7mnHCSzciLksZ4B6TikiO2GL7Qh404y0K7RgBGvvw8QJkljdXd4W
         NCQQ==
X-Gm-Message-State: AOJu0YwA8UjDQlDoVT45zKto94/2C5nzTQ05Ooh1IXNPb9G5aIgEyrFN
	SvC/pOf4hzwLk47diw87uQXTMTOnAoi8HBprgkmejNKIEsubCABw
X-Google-Smtp-Source: AGHT+IF94WoT40Z1SKL5d5z4/OFRL+ZpRt/Mh1eBS3ikAJhmzuMZZOJeU+bidfzzLQ+2XJfqDqceaw==
X-Received: by 2002:ad4:5967:0:b0:68c:c977:df6e with SMTP id eq7-20020ad45967000000b0068cc977df6emr4198960qvb.10.1707597978047;
        Sat, 10 Feb 2024 12:46:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXp+RFU8mZpxCtEceZNXbFefupSCxccqNul+K627frYKB5kqD9Ci0D+HmS0VoTCA2l9hr/+GH5IEcWuxD25v6REUdfZUD25aWmh0501FUYZ7hhykFZQ8Nfsm5j1pZUQKgB7V4mw3i35kMli+wNH+wyOQnWXtWEt/Z+AYOEYxqEWiQaN/mj7t6rN+75gPm0o8CzSQqROVyLdY8w1wOr3ecmy/x318kl18r3p9zq01TEPkR5dpSrpwv1wrX/YuQ3b+IPqcofgjgj37lnx/fwywbQbOq5OR+Gw7piXYfii+ITjOplrII9MaXDC8CZ9X///b0LUK498XQ56zkKvBjwQNX8+DSvqqr/emzhFJWPrW2tRlMlZxhm4TcZT0hj4D5OlLVtxqMKqAV0ycOGLfE5XEoMpvgmYt9nluCcbp3kASNAM/CmZuBN6S5C8MpXrPU/6bTBHKqabD0xJhWrR3kED5docHGr6g5huCauJ9Txg3bI5znAdAJSPOKlpLpFg18cAdi9bcWKV6LjCVBoqcTxSTB9+aTl/Pz8/iQd740Z8J6C2PmJWVfSaP4Sn+OiXTFzwLqnfaedqXz7AtEx3vwwF81rWTQw0+AcOoSBI4X+3o0fCD/LVCwUr9wV7K+9EmdE2P4SK4hSwGP/QJ/KVVMDzfnVd
Received: from aford-System-Version.lan ([2601:447:d002:5be:27d7:3989:2897:88a7])
        by smtp.gmail.com with ESMTPSA id m20-20020a0cdb94000000b0068c9db26ae1sm2079526qvk.41.2024.02.10.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:46:17 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/6] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
Date: Sat, 10 Feb 2024 14:45:57 -0600
Message-ID: <20240210204606.11944-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210204606.11944-1-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

Add a DT binding for the HDMI PHY found on the i.MX8MP SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V4:  No Change

V3:  Removed mintems at the request of Krzysztof and add his
     reviewed-by

V2:  I (Adam) tried to help move this along, so I took Lucas' patch
     and attempted to apply fixes based on feedback.  I don't have
     all the history, so apologies for that.

     Added phy-cells to the required list and fixed an error due
     to the word 'binding' being in the title.
---
 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
new file mode 100644
index 000000000000..c43e86a8c2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8mp-hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8MP HDMI PHY
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mp-hdmi-phy
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: apb
+      - const: ref
+
+  "#phy-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mp-clock.h>
+    #include <dt-bindings/power/imx8mp-power.h>
+
+    phy@32fdff00 {
+        compatible = "fsl,imx8mp-hdmi-phy";
+        reg = <0x32fdff00 0x100>;
+        clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+                 <&clk IMX8MP_CLK_HDMI_24M>;
+        clock-names = "apb", "ref";
+        power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
+        #clock-cells = <0>;
+        #phy-cells = <0>;
+    };
-- 
2.43.0



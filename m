Return-Path: <linux-kernel+bounces-150754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342318AA423
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2E21F21DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF8199E91;
	Thu, 18 Apr 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbZkmYTm"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E12194C91;
	Thu, 18 Apr 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472704; cv=none; b=NRoz5q+da8cWPG4uwu4yIwaTL0ntXsqYoX4NpRmEzBuSeRn8yKliKZXAeYIMUe/O7c3+twh8+0Wl0eGsRdm1qpjSRWI+QJPbrkjigzGGBC7eaczibqE6JAgN59wGZzdAyiATUSdP8ifBn64bNDOBFIrgwsaih0Iob61Dnlx4XRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472704; c=relaxed/simple;
	bh=l3v8uiGH9iMneTQKAJQigSsmEW/6PSJtsODaXuUHOxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gtBmxxuvmysryS9kZ5vGqx9qU1w0eJtp71NrKZs+bsfrNgaKJBHd59iWBjIpiU9yBOeulmCcoJ7++w+N84e76SEGdXkfNG6ayKWKP/2zDtWvQbwnCX53xdo+y7G3kDrW9uQ4mrX/6PaJdBrC19vhbpEaVAYcajZN00uITO5VOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbZkmYTm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a526a200879so161769366b.1;
        Thu, 18 Apr 2024 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713472701; x=1714077501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpwB/CJEZck9aj444xbdNc4njqRLnc/SoD7JSsSXE4k=;
        b=XbZkmYTm2dpj1nC0JZzzvR7K+aC3cAON2w/6LCIIMRF+HV+Snp1vc8VM3k8IkddXR4
         oKjvHYfoLbKGzu1ipLxkG2nGyqBHnbUHlfmnJOfrQqjJHEGOWQwRpgnrxW/JFxUxkv2v
         XVo7r12wwmgLyE1dg/knwx6IImx8SiRWCmPmAnILBLy8MpKFrMFu1GgT2ZK9MQTfNN2A
         JuliiLY65yw5+7VEwD+qcuOtJd2ctHrK+daorDGSaYXYrN88rw+VVQWzMtIv+HgqyNoj
         90ZFUIKlBfG6NVEPcW2cKFZDkHM0s4+mUslROtLixKW9ozGeTdSqUHGQduGB1xN8ybqB
         BGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472701; x=1714077501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpwB/CJEZck9aj444xbdNc4njqRLnc/SoD7JSsSXE4k=;
        b=luS/5qkYGOa1+ZUmSBUM3wjaP2LFMyjYMQ8wdI0fi1mnl9kkR2beqzY7o6rAVgk6y/
         0bOTSFzRfuI0HEfDmznwiNAZs0ZWy91Qs5L+d8/EtpxY25yg3vWWBY35Eke8ocBq43qs
         pTRTppF83YM4Mk6dOmUVl524ZGBpQm2IDXNZ/fc74l9QKroiIBMgXBjE6FNDYK1n0FDj
         wdZ/WyJxxUMti/SILryqUNW0LjUr3Re1XIWlh95F5caMiRcbOUNLndzFSp8R+LS403JQ
         /rlXxTtfiZyLiuDUb6EHtlSJKSDUvGrGyIz2L0d2tcSGuw93uVW81Vt0RIu5gAuz+2NF
         1lwg==
X-Forwarded-Encrypted: i=1; AJvYcCX2MG5e89cyYEIwPo+i/MYj1b1cpaWzO3QfkFc6BhZqLbYgJ4BOv1jnu73As3al0GjybEw4lxrKIHh2/JHWHY7BByTfVcaqFY0DFgSNIS/enzHEidfovxLZYJuiSAjHEL44gHKdW8BQvA==
X-Gm-Message-State: AOJu0YyLKdLRlviUcMKp8s82W0T+AYqFM5GZ/BasoSRWCY8wbvnC3kGv
	nX50bLJVzq4P6vNfjlKZq95xPdlFFWlWbnRVjA51zpwEKbFS6qoK
X-Google-Smtp-Source: AGHT+IHy3ebiIyjZ2dOdwO1gTQ1CoH9YGtMxf7V/6zF0j96aRPInH4QXAR7n/SqRIS6C1ntyLMb/og==
X-Received: by 2002:a17:906:dc4a:b0:a55:635d:ddfb with SMTP id yz10-20020a170906dc4a00b00a55635dddfbmr145305ejb.3.1713472700682;
        Thu, 18 Apr 2024 13:38:20 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906079500b00a473774b027sm1305649ejc.207.2024.04.18.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:38:20 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>
Cc: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: mfd: add schema for 8ulp AVD-SIM
Date: Thu, 18 Apr 2024 23:37:19 +0300
Message-Id: <20240418203720.8492-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add schema for i.MX8ULP's AVD-SIM module.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/mfd/fsl,imx8ulp-avd-sim.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml

diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
new file mode 100644
index 000000000000..4020c6e37f80
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/fsl,imx8ulp-avd-sim.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8ULP Audio-Video Domain System Integration Module
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  The AVD-SIM module provides configuration options for components of AVD.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8ulp-avd-sim
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8ulp-clock.h>
+    avd_sim: syscon@2da50000 {
+        compatible = "fsl,imx8ulp-avd-sim", "syscon", "simple-mfd";
+        reg = <0x2da50000 0x38>;
+        clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
+    };
-- 
2.34.1



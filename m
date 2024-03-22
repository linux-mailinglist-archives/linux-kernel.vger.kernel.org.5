Return-Path: <linux-kernel+bounces-111990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166C8873D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D174B22464
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A579DAD;
	Fri, 22 Mar 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5C2ovsg"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9F79B83;
	Fri, 22 Mar 2024 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135489; cv=none; b=h3YedM78/yNkeShbfyS9rz3FGI3C/mhr4Pt4LDCrUrxNBGmM2APP+hge/TqjfpSOIc7blJwJ646W90XmviX1mhX8fET2sokJaBgA+vhwRt0bL6Z7xM4bVk5h4IWFi8Xgdg26E3JSaO9adQAibrEZUYaKXySejrivC+Y8yXY/BKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135489; c=relaxed/simple;
	bh=dydiCo7iI1NW4gSDYIevGCRXxnVvyAdCyQwXxWD9D14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4h/vSnfu9obZyFfSCAkMl41BuER8NcdrFrv5Pq3nBVwpm9/8HUWdVkbB3t1oT83NGwZWdSqFULKGTE3e02laKZaj75pLgBJKhYNh8aBCFb3Xt8gTJBzAUDMG+WP8E+NKvP9drtzTa4kA88cQzSlgpBNKLr/s1veYCr/DFutwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5C2ovsg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d4559fb4so3142967e87.3;
        Fri, 22 Mar 2024 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711135486; x=1711740286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOSsKufZ/8yCjM1/hlvnqYOYaN3abG+vGfagOCNtt2o=;
        b=I5C2ovsgg7f8m3eioAu/qJF6J1HQFEM5S90ko1/+QVSdRaVUZFh1If2Li4QyYghDHV
         s6zFWpIG0fFMvUac98Q4Is5SDmsqGWZ1WDxAk3v1Jw5zir5VZCAmD3EH2YTtI2jfka8o
         O9KIxaZHx0Mn20YtLV+Y7kxAaa8oSvdpRTikiK9gwMAE1A/5NxoNjDCEphcc3bxVgO32
         8QFRMCw6igW3Ck4qP1LAFF3/c6ONJcSlkJF8Bd0Iyyq4KU024Opg+mLNPw6sScqz5AeY
         TeteR1D7hPq3r1hZyq77zp5s/pAZ88oYvUjO3JUueowHmUmi5s3BMXK3ls9+N+2QSaEv
         h6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135486; x=1711740286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOSsKufZ/8yCjM1/hlvnqYOYaN3abG+vGfagOCNtt2o=;
        b=H7K3Te5jEfdOknO4tFM+VJiRDy0B+EpsGDuFx74ncFtCpmkNwEdRy5j7HZ8+6iabcs
         OKqPiBleYlcMpb9DVE3A6YcUJzTnYb8Yq9e9+YJCP8VSBqWtdLSh5I7YbkPytDX2E73H
         8cHcrsL97RoutKeVu0TNM8APh5vrGdVSpT+lBMomC9UTd7dpieve6L3rexBFLocP5t+1
         AvCRPsw8tI6EQZPjo7TOc5SQEmws8sllbnCQRjxDWJZqzN7ihmtGpZLRDzdDD1AtqNvl
         3HliTy+Y3x0/gY2HfDITcaT9aoReHdvNUlYeq9x34vwtR+/hE0Bu7GPdhnGnxKRKf+fa
         wFzw==
X-Forwarded-Encrypted: i=1; AJvYcCXLh3oCecC/4NtqJQEeb8XkWoNFpCdPgC3M2YcMFDQd2+gPB2W93892wQY40+/K5nekrmus4HAYHwIxorjRnzDBvz2T2Mopt1z05NNIQdK6ASBGHlWhOn1Qw9TgBb9tiSu6U2S4QOUPaQ==
X-Gm-Message-State: AOJu0YzulExg+O9srRvVrq3aV/ZcU0iu6K7VKc65jnnlKb137dRHiMgF
	Ifdd2S3o2apMPWzpOdZBkdfzB7UlPFDSNHP3FEikMJZ7VGyuT/NT
X-Google-Smtp-Source: AGHT+IHuDeX4dcgp3CoihbTxC+N3DhZXs1ducT1pLshzXnGYUwm8bzwKCXmTT9H7MVuempz6zsEdZw==
X-Received: by 2002:a05:6512:4dc:b0:512:ac3a:7f27 with SMTP id w28-20020a05651204dc00b00512ac3a7f27mr242869lfq.66.1711135485537;
        Fri, 22 Mar 2024 12:24:45 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7fa-7d92-6b28-0504.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7fa:7d92:6b28:504])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b00a46b87c32besm138572ejc.39.2024.03.22.12.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:24:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 20:24:35 +0100
Subject: [PATCH v3 1/5] dt-bindings: hwmon: as370: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v3-1-6697de2a8228@gmail.com>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711135482; l=1927;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=dydiCo7iI1NW4gSDYIevGCRXxnVvyAdCyQwXxWD9D14=;
 b=uCAp20yjInGDG8gzJ0FIAQrtzc84wwJxhwfUU7eg3Q01+/KMV2/ykxX6enHJhFF1zbBAr06Fg
 /fNFWQrMotKCbHp7vDRQHzsfqpghKPeXdhpvIC9B3qgFCAr+VI1Na47
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

This is a straightforward conversion with now new properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/as370.txt  | 11 --------
 .../devicetree/bindings/hwmon/syna,as370.yaml      | 32 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/as370.txt b/Documentation/devicetree/bindings/hwmon/as370.txt
deleted file mode 100644
index d102fe765124..000000000000
--- a/Documentation/devicetree/bindings/hwmon/as370.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Bindings for Synaptics AS370 PVT sensors
-
-Required properties:
-- compatible : "syna,as370-hwmon"
-- reg        : address and length of the register set.
-
-Example:
-	hwmon@ea0810 {
-		compatible = "syna,as370-hwmon";
-		reg = <0xea0810 0xc>;
-	};
diff --git a/Documentation/devicetree/bindings/hwmon/syna,as370.yaml b/Documentation/devicetree/bindings/hwmon/syna,as370.yaml
new file mode 100644
index 000000000000..1f7005f55247
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/syna,as370.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/syna,as370.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics AS370 PVT sensors
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: syna,as370-hwmon
+
+  reg:
+    description:
+      Address and length of the register set.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    sensor@ea0810 {
+        compatible = "syna,as370-hwmon";
+        reg = <0xea0810 0xc>;
+    };

-- 
2.40.1



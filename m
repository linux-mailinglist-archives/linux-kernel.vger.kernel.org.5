Return-Path: <linux-kernel+bounces-110566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CA08860AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4411C216FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF2134416;
	Thu, 21 Mar 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4H6jTQA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EB58AC0;
	Thu, 21 Mar 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046639; cv=none; b=ihp97EZmKxoUMYTSpbOpIJtl+iqVIqMUylFWe5OqR6M1I0wm3MhDjSfB/nOenjcn/GyFUl8iRZuqADWY9IScWJt0YAUiaLjCQtXOjpBCNznD0r/hwFCVPsHqBo9Q9gzk9r76KmFjFblK45n9NbZJCtcPd7bjl4sUfNCwN1zwzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046639; c=relaxed/simple;
	bh=KZoVHUkOuLwqSF6Q3U+Iq8ld3UyOQ5Eh+x0ZRakG7AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VM4I1MId4cD66OQkUXJZ5932LoKUqzJNSaPnDijn8UgcAUL1yDAHxOUtLuUtQiE1kSXBcp+ZCWb2wXgSc1qnhOOyNfzhaCbWp5TwQpe2UGFPPx+2as8LDqUnyAFX11lxuBFBQHDXzWAqN2MEMgN0SHBIfOryuj/q56OoNU+KgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4H6jTQA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44ad785a44so163483866b.3;
        Thu, 21 Mar 2024 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046636; x=1711651436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXrRijFskjj/x6bHaCTthhZrS7dvFVKx/yThbyuTabM=;
        b=B4H6jTQA+DiaQGXeG0hHF0ILHn8FxUec2W/HUmZ6KSWH4OXBuScXVPandlxbufCpCi
         AmUyswOqCGi0sLcYHIDJYpees6RROXzZf6rpl5qyIkfHtQU8qA749gkTssorLI94bG0P
         Wj5IX7j81anVdikfmj9Y1AOW/MwHBP4s8M43e4YbkTszRyzQk7w2yP3AXR9RI0TwR2aZ
         R9WcHupbCY3PWYpvDBUuPdO8PFDLUyGzCpzx0s4oGDd5Embysd51VETMyaO6o/wHz9Kg
         hrMMgwKSg1FuN/rWDUAQASI6mL3nO7ODmOCWUCgiALJP7ZKYd5Np4XAmchAXAmcwjyf/
         v2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046636; x=1711651436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXrRijFskjj/x6bHaCTthhZrS7dvFVKx/yThbyuTabM=;
        b=q/9/mBveW74qdLpPDNJiTmAfK/MmVkJuVlaW/YjQUcRRqFSDteIRA+jkN5iMcEjWvq
         KP8NdluIxTJA0CLhbH0/OKPEOGpdmtvNt4D8fk1iEBH7Km5WAZ5EQ+l0rSmsVfoL17xj
         bHuHIDj5HdBin54iJa2OpUWF8cy//AGOQPiVC2XbsSmsGMz8wuJXJgXYkPGxy2CGqds9
         tfrtNBCMYsO7R++uTIt7F9Gj6yGWY7f/nFA9zaHSnYnf4ua1IiOQOCz4WJSIGhJ5xOWQ
         DNRHcODJtYU1kljHD72G8NTdNIBQRc4CnU9N6T/G7uzBxWEl21DxJZIamqFrIm6Lw47+
         uwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn/MovZda49DNh9pefyd8sG3LKtZQ0wgWMoUra5+Kwh2tF4WX8nJq1v/9HAO7nnKjS+M3fQDo5Z3DkhtGOlM7BNUNwGKPl9dJ6P1yyA5ordvBIt8HUEgKRcnspKlf1QbwV4YA9lLK54w==
X-Gm-Message-State: AOJu0YyUMgiRwHWHmy39xOsK7DhhVypxrrzEXfisv8ewwSHfu78ltg8P
	5DnrctjxH4lnHBFk52u9hNBEjAOCCswqFHK8JV+tI5T7zWhtyNXY
X-Google-Smtp-Source: AGHT+IG9T7BGcTdrPesGcvj83c6iEs3oewPglnZiOuu/XZQVzeB9m7qcgDvuSRwkRNXDR4GMAkeMaQ==
X-Received: by 2002:a17:906:fa92:b0:a46:d001:4ac1 with SMTP id lt18-20020a170906fa9200b00a46d0014ac1mr186929ejb.47.1711046635918;
        Thu, 21 Mar 2024 11:43:55 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00a4576dd5a8csm188627ejd.201.2024.03.21.11.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:43:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:43:42 +0100
Subject: [PATCH 1/5] dt-bindings: hwmon: as370: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_dtschema-v1-1-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
In-Reply-To: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046632; l=1883;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=KZoVHUkOuLwqSF6Q3U+Iq8ld3UyOQ5Eh+x0ZRakG7AY=;
 b=63I2hYN1+cDH++nFgodgGj/vcHWjnLPCypd4vLoj69cY3p4KiaCOMN8vcvrmaXuAFJb/T+8du
 i46xfcAQXp0C/JkOEosPup8wgArKbc+IndvOX04hVdlUTNQIMtAXirw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

This is a straightforward conversion with now new properties.

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



Return-Path: <linux-kernel+bounces-1290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D62814CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C83C28661B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A003DBA1;
	Fri, 15 Dec 2023 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB/RBvI3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE63DB96;
	Fri, 15 Dec 2023 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d347b4d676so7257595ad.2;
        Fri, 15 Dec 2023 08:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702657532; x=1703262332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggW+Hin3YweLGTCQFbER/wgiOuVUGGluSvES+5w5My4=;
        b=EB/RBvI3niBcnuZFnpDObHy9NNaQi1L8/PvRR7qAc+9rVKuqUtqlj95zlVANPd1mo6
         EAqm2NuI9BMFtBtezkKT48BBzvWQxy7uj9CoZdoANahV7BMtsuNAGPEcIvZwQ+qVQOEj
         Xh8USftH+dd7QZB6kXASuFaZRL53HGYS3ArEcIbxFcixdcfeTkxrROwNHZfE5nwpLDjw
         LBr8RnMtkSooEFFxCGh/mck6nkD+xbpkXeA12Td4Or1QoEpe5RD163GmD4b9cf9Vn7zz
         u6OHta/Sb5f5AT26sVQC1U71ePeu9DVfcXj9L4Jud1gtP0XtRwEmMwgNRNcYAyGspdvo
         so3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657532; x=1703262332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggW+Hin3YweLGTCQFbER/wgiOuVUGGluSvES+5w5My4=;
        b=F0bBbMFl1RE29KhuNRmMIHqaWMWxVCTnCZ6XUc1mD9lpJS5bVwPi4G0+HfE3JTBpaF
         JKmSBbLwV+/bTJuprqBn/CQg0pfbiIZVP91pKWCCp5Q3DlkQNz3DV/xdeCv9krbOrBpN
         yP+VlN4n4VJFInf1Cr38PqQ/rW7Htb+Ij1k620Pj/4SA2qKM4zvDA21E4H0zaL6ofNOU
         DDeq/ebddm4XI05mSuEAdcu6SZNGHc4HDhLqhqw6sppyZvG/hWplErfwVxTZM3SBQCQB
         KVn20MZS0l4Auh2mD1aGUq+jPxOxQ2692otCqZtLAzqA2VprWhHcCAqAgj7sbtEuPG1l
         vK4A==
X-Gm-Message-State: AOJu0YzKjoGWLTbDJc3oZirJiXxmz6lD74HF99BvprmR0jWi2jRDHppc
	6+GzX7k/6jmmKHFzQjV0XeUY+HzScs49lA==
X-Google-Smtp-Source: AGHT+IEZkZrISCa/tBzbEB2K6p4h7wFtOEwKMpl2olxVPhly92wynedxoiejUlKaUpDsKvTYc0YZkw==
X-Received: by 2002:a17:903:234c:b0:1d0:c418:1758 with SMTP id c12-20020a170903234c00b001d0c4181758mr14588199plh.66.1702657531891;
        Fri, 15 Dec 2023 08:25:31 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:581e:798e:871c:98db:5638:a4])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902989000b001bb750189desm14468665plp.255.2023.12.15.08.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:25:31 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: iio: chemical: add aosong,ags02ma
Date: Fri, 15 Dec 2023 21:53:10 +0530
Message-ID: <20231215162312.143568-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215162312.143568-1-anshulusr@gmail.com>
References: <20231215162312.143568-1-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Aosong AGS02MA TVOC sensor.

The sensor communicates over i2c with the default address 0x1a.
TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.

Datasheet: https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v5:
- Made vdd-supply a required property

Changes for v4:
- Changed node name from 'light-sensor' to 'voc-sensor'

Changes for v3:
- Fixed commit message
- Removed "asair,ags02ma" compatible

Changes for v2:
- Removed device from trivial-devices
- Added standalone binding with vdd-supply property

Previous versions:
v4: https://lore.kernel.org/lkml/20231125100139.193584-2-anshulusr@gmail.com/
v3: https://lore.kernel.org/lkml/20231121095800.2180870-2-anshulusr@gmail.com/
v2: https://lore.kernel.org/lkml/20231115125810.1394854-2-anshulusr@gmail.com/
v1: https://lore.kernel.org/lkml/20231107173100.62715-2-anshulusr@gmail.com/
---
 .../bindings/iio/chemical/aosong,ags02ma.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
new file mode 100644
index 000000000000..35e7b094e878
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aosong AGS02MA VOC Sensor
+
+description: |
+  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor with default
+  address of 0x1a.
+
+  Datasheet:
+    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - aosong,ags02ma
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        voc-sensor@1a {
+            compatible = "aosong,ags02ma";
+            reg = <0x1a>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
-- 
2.43.0



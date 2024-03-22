Return-Path: <linux-kernel+bounces-111021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848F886707
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FC51F23122
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412461756F;
	Fri, 22 Mar 2024 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrrqdepz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FD16428;
	Fri, 22 Mar 2024 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089947; cv=none; b=BqgP/+UdGji7yuJ5Qex2wdpkewwVLx3D2B2UFlEJS0/i1KYUXCMbasIySnQ/bXpfPfFB1wNpEsWk33b7tCvErD4j3xP/fdaISZ2LJWDH6pKamzhJeuAjXgqxDy7ipJBcTWtIM6gc8g0Mzls0dXvAdGOI2NykJkxNrp7WY1H0yZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089947; c=relaxed/simple;
	bh=SL6IFykbfJaWw2tZ5nEHGx/wGHJSnUvcwuO85EyOS+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ei55Ydib2/53WRhrYqua4ZNRsE45A4fMGX9eDB0sc6C029R18h7iDxUlMxNGfMX10+/rjBB9XTp2wYV4yiGtCBjSzLDaNYVU+LwhfGZWjNbHI6idwnse2ANpEmd4ssOmQyDVr04/zF2XX7KoonYMhx4eTPJ8T7W4NLt9vwaBpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrrqdepz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e6777af4so3285377e87.2;
        Thu, 21 Mar 2024 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711089944; x=1711694744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZod9FP10mmkUa93vUHm2PRSdkHtpevTJB03xjoBD4k=;
        b=YrrqdepzlNfcd0DxtIYMFtaZKHoNFrMwrXHXMhxV8j/4648uGrqO3C+WdKTGDx3ycs
         LAAMQk6ruk0vfcp+2ZSlGH+npb0+M3qiIViZKUMYiTZMpx/yDdIzoLJalFjgFcl7uOlk
         oVAjqcBsMgCKCgqjrCuFk/0+tW1CCVFmX+9APPvmweAsCl0v+iT5/P4bpJhyhV9PcEa6
         fNyVSuF+lU4agOgME9XVrV1wW3oXuCJN5GZQs1G/nNJgPFTyCuCS7/lmlgTPiN2GzNJD
         27wKV2jr/ivZ2H5iGqPfK+JElu6FnbdUZueY8CQh/4SR4FJtZcjSiHccCWkOrl8gPIE2
         E5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089944; x=1711694744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZod9FP10mmkUa93vUHm2PRSdkHtpevTJB03xjoBD4k=;
        b=T12+fN3cPlKAkKvV0HCOqhLVz8H5bqoVS/1gZ3uFTGigTZawpbGy1he1C1kIfRadSO
         Lhi494uIT80uIMRIsLbQ3grjKtISoenPTWeYhnoqeQMZNKbBrGy+yOyul3VKi7q0/Owf
         /lV8hbQWAMs1glg3TcN30ZIrY4quKYvcpFGvjANlLwULxXsFPlSxs1v/jUPpGIvht8ID
         2pj9ruEqnByDTJe7/TfHS4/Hy4sP1Mkr8fXq/m3z1l4asmXcoNFwduT2FkQi9LNY1UsW
         fILs6AHjltFwLGZ2c9rwWyjvsAMQ7ks3G2g5ZdqZozGap5TpabRtjbf6qMqOD/e5eREN
         OoSA==
X-Forwarded-Encrypted: i=1; AJvYcCXsqXK9cPfrmBW+YT6nrH0FMBPtQPeHP/mN1XSfamV/MdMa53+fH1SbAXc01plNlzTG+NHHNasCJa00dw/F3lLd/Vrh0HZrVD5xtiNXaG09SBheqKG+ywWF0ksqf5Q3FoCcCU9oigyDrg==
X-Gm-Message-State: AOJu0YxTH+McXFh6cv4Xqqe9HRJltqrO6/PCbrHZB1m7bAr7VSiMEgCu
	S21CcBVDGdFnnYLmHqgII8IvH2QfAeD7oeuAJbnkIn9RD5DN05oL
X-Google-Smtp-Source: AGHT+IEvhheqdTHLtMcisH689/ys8IMvmi721V9abnrt00Akg8dBPfthvPkOmnuHkzcXFZpwv1Uq4w==
X-Received: by 2002:a19:2d47:0:b0:513:a6a7:ac88 with SMTP id t7-20020a192d47000000b00513a6a7ac88mr1177483lft.14.1711089943870;
        Thu, 21 Mar 2024 23:45:43 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906375300b00a46bb8a44cdsm679694ejc.198.2024.03.21.23.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:45:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 07:45:29 +0100
Subject: [PATCH v2 4/5] dt-bindings: hwmon: stts751: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v2-4-570bee1acecb@gmail.com>
References: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711089934; l=2153;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=SL6IFykbfJaWw2tZ5nEHGx/wGHJSnUvcwuO85EyOS+w=;
 b=CkO2xlSGeh8rTae0P/EWaWMHbfjClGj75C0xpe4LCm8S42cYNo4Cki3o6uosOvj7Ud+oFOnrw
 1rcW5AhWz8XAA2Wxug+GswK3/pTwD3BzJ2uSBHK9ZvC57hlShLBOKCs
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

This is a straightforward conversion with no new properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/st,stts751.yaml      | 41 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/stts751.txt          | 15 --------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/st,stts751.yaml b/Documentation/devicetree/bindings/hwmon/st,stts751.yaml
new file mode 100644
index 000000000000..9c825adbed58
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/st,stts751.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/st,stts751.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STTS751 Thermometer
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: st,stts751
+
+  reg:
+    maxItems: 1
+
+  smbus-timeout-disable:
+    description:
+      When set, the smbus timeout function will be disabled.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        thermometer@48 {
+            compatible = "st,stts751";
+            reg = <0x48>;
+            smbus-timeout-disable;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/stts751.txt b/Documentation/devicetree/bindings/hwmon/stts751.txt
deleted file mode 100644
index 3ee1dc30e72f..000000000000
--- a/Documentation/devicetree/bindings/hwmon/stts751.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* STTS751 thermometer.
-
-Required node properties:
-- compatible: "stts751"
-- reg: I2C bus address of the device
-
-Optional properties:
-- smbus-timeout-disable: when set, the smbus timeout function will be disabled
-
-Example stts751 node:
-
-temp-sensor {
-	compatible = "stts751";
-	reg = <0x48>;
-}

-- 
2.40.1



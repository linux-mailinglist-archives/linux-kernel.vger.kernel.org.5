Return-Path: <linux-kernel+bounces-112508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B32887AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F88281EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F95D747;
	Sat, 23 Mar 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/IX5rbZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E75A781;
	Sat, 23 Mar 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233996; cv=none; b=VgMSE+//utlP3CPTvs0kU44i1ZsRa/2MPInhAM3q5pCNmDQ7uZFFXU+wNQpNmvlCZp+7Fb05uTY7ZFDztFl9Y8rebnCSp6xm0yXa4GjLNfrFqsT5RSXb/C3ZjNKCVQv9ybePaQpqUeyxv2TVrze0M6CVMHMLCbwiOcbJ2s6Rmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233996; c=relaxed/simple;
	bh=KsOB1Cx1AE0hQx4b4ElDFKUK4NMTkP4wB55sSj+0OgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZjJkXvflbHL+ZlSaI/xstI7CSiPnPhSTiWJWOtAeamf+41Ry23rSD72mREZXImcLRXH5nwPkuHhln260FCjAH1c55SGmq9f1lqG2B6y2qt2ss+JeBVfUGX5OL4vcKpo4fYbsG4xnWaHNrOD+CsdisGNCSkXwXI56oPA+WT+bLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/IX5rbZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513e134f73aso4228107e87.2;
        Sat, 23 Mar 2024 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711233993; x=1711838793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7F0fLmvFShDUvgX2kPM7vLCKKBKWroKRJEPwwDn+1rM=;
        b=C/IX5rbZp2JIQxJ1dJpveFYREhkriRtDw/MXkdcDm+XS8CEMPyI7A6mTWim0Pt1MD8
         gIBo7YoHvNCwqc9KG3E1U1deP6CCNbE5Q/jlUp4xJlQDS1clBqMG/vdLUb8aOq59YvcL
         0dAcQQMqRxchIBpDORuOpN0sMOflySfOSHabckCmzp5lIUyVudWGuOGvx9CpJOm8kqe+
         PmfxrORedHJq4RMbN/PgD59leIxSGLPqRyMPhBavLdmQD+zG+93TjowT8x3FrHskL/Ee
         0SYHl/m/dEcdB7DHHNEePwbjsJ/YhLDigVi0R3HOWOmWVwhKNb0jDLvo7ptORphqTaQ6
         MQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711233993; x=1711838793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7F0fLmvFShDUvgX2kPM7vLCKKBKWroKRJEPwwDn+1rM=;
        b=LBLwnv3lcFG1VyhSDsAkBMFSBIF8/3tfQmcSGuxc9zs8pVjV6bq0XNxwRTkOPqqXF6
         6ThCasfQqQPcBAUCIEp7DlC2kbAfL7jvVvaZoL3duQ+86DkJgRq2cxjEpxmFAgbciMtC
         FCBgpUhBbsMYQ4uPbOvTAqP2NMZMxgbt5CUW0bhVI1KaTb3s0XXHsgoEw6dpA5nuoWFh
         L6TAicnkHC7Dym+Ue8DEtzw2SnUaSfm06pij3i0gF4JoYT8ZrRR/moZOzqQOPJXMtZEu
         eKZbAHTkjSaslR+0Y52U/x10AnRJDJ5f/6FIx3NHqyYxIh4XAMDgvyiDLcuQZtvXU8Ue
         y9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVcGl/UlMLQBJy+RhQG2OZZjexodo6DMmC4L0cx7tK97YSbdwxOSdzzhzHozDaJBNTo7AQUsXR2pL/IvJfCdJcr7UQb/FEOAtzXMLMAYTWCtLSB60ruBpMhm+qx6cdrBIG9FUtebd4SHg==
X-Gm-Message-State: AOJu0Yzo+K7jyQAm+SaTn/KZWTggfsDmPwhZ29JWr4/HNGPXdcQeMfyk
	uusqZJfJAOtPyOX9K+pGsM508l1cUKkFoJbqy6zP4Ur1q0RpWEUZ
X-Google-Smtp-Source: AGHT+IFZOWf0rDuTu0xnQtuVLwD6mD8m50Yh0VA1IHGnSIjl3N3FqdbSHH6rWtY58DEtKlvfluppTw==
X-Received: by 2002:a05:6512:32a2:b0:513:d482:a6c6 with SMTP id q2-20020a05651232a200b00513d482a6c6mr2612965lfe.30.1711233992726;
        Sat, 23 Mar 2024 15:46:32 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-195f-8ce5-d7d9-2242.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:195f:8ce5:d7d9:2242])
        by smtp.gmail.com with ESMTPSA id bu22-20020a170906a15600b00a461d2a3374sm1350424ejb.47.2024.03.23.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 15:46:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 23 Mar 2024 23:46:15 +0100
Subject: [PATCH 3/4] dt-bindings: rtc: digicolor-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-rtc-yaml-v1-3-0c5d12b1b89d@gmail.com>
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
In-Reply-To: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711233987; l=2259;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=KsOB1Cx1AE0hQx4b4ElDFKUK4NMTkP4wB55sSj+0OgE=;
 b=PFEJjX81qC9arhreYmX19OiEZdS1JKEEqnL130OxQtBY2DNjl6Y2i3Gh8g2usogby3LELH+Ov
 E8MJYUf2RXhDFlBZrGMyaaWQoWTbeSVAF43QhNtBA6gQnBQrDxMEyS6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

The binding has been renamed to match its compatible. Apart from that,
it is a direct conversion with no additions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/cnxt,cx92755-rtc.yaml  | 37 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/digicolor-rtc.txt      | 17 ----------
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/cnxt,cx92755-rtc.yaml b/Documentation/devicetree/bindings/rtc/cnxt,cx92755-rtc.yaml
new file mode 100644
index 000000000000..bdd6f0718b0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cnxt,cx92755-rtc.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/cnxt,cx92755-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Conexant Digicolor Real Time Clock Controller
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: cnxt,cx92755-rtc
+
+  reg:
+    description:
+      Base address and length of the register region.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc@f0000c30 {
+        compatible = "cnxt,cx92755-rtc";
+        reg = <0xf0000c30 0x18>;
+        interrupts = <25>;
+    };
diff --git a/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt b/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt
deleted file mode 100644
index d464986012cd..000000000000
--- a/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Conexant Digicolor Real Time Clock controller
-
-This binding currently supports the CX92755 SoC.
-
-Required properties:
-- compatible: should be "cnxt,cx92755-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: rtc alarm interrupt
-
-Example:
-
-	rtc@f0000c30 {
-		compatible = "cnxt,cx92755-rtc";
-		reg = <0xf0000c30 0x18>;
-		interrupts = <25>;
-	};

-- 
2.40.1



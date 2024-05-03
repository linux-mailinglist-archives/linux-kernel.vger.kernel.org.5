Return-Path: <linux-kernel+bounces-168240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D8A8BB58E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419C4B219DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC47441E;
	Fri,  3 May 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwazBxnK"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E085820E;
	Fri,  3 May 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771371; cv=none; b=OrpnDJlbRfFiMy/NmqIHFuGGZvUN7oDExrAwl+WAUeHHD4LAsbRpPxQHaSJ/P/hMMMCZuEWShg87k7w+SAKrJd98GdFH72Njv1jl7FFcvGnTHwQZYY0pmXJyCKfvOVTFf3Lk9mHgem+elsqVw2iNPx+PY1QjvG+ZmwVNzsAjk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771371; c=relaxed/simple;
	bh=4Szzoa+TyTyxXCukvaGo65ZhEOjBu2aeG1aUMemN+Cg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RafWm10IvTF2tzq5on7U5Q263QK/x6NdoFJJ89iYmWskCVYLAIxk+3iFM2r/gx4qwc+709RizhwJ90SZBLcWP6G7IzqmkHdz1fAbVJoNp8J0f1jUWBo91DNOHG0jEc7Yu2dB9OVFXHI+lKGKLUPLCnPjuvNwz6W/yA7Z5i6fsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwazBxnK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso1467425e9.3;
        Fri, 03 May 2024 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771368; x=1715376168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxHnyeDaT3SsXXHJpHgStueHSADUwIVIimkKgSvF4qQ=;
        b=iwazBxnKrqiL/iY7WkVFQzUl02KwV0erAYgtCiyQyFr8SZRA7fzLzsR1Cwop2K2kgq
         5KRrspvl2YBGcBxnwtDNhcBVoA6oXcCyuGOLjrlNpNdhc5NAopM1zqaQq82JI+daw/R7
         xmNxSiXA99MqZFim5Bp8SrVd0SHFPPDgARNfCoY7gOPKUmq3Ha/qBFuTyt89aULLH1eO
         +FX/rptOM0W9GPuMgfOgMpMW9rgcFxfl8LhdPJXAD59Cqq5GguXPcpDI7AuTtkFski+L
         QVzGXzizcH7mOvtgWlZKoz1OC4b05QE6hn7TUS84swgbuL7V2+F8gSlBfjBFZsVkSn36
         kMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771368; x=1715376168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxHnyeDaT3SsXXHJpHgStueHSADUwIVIimkKgSvF4qQ=;
        b=TYCBHTWEnDORSpRkJAkUe4fw/f12fFxzVPu8BVDO8RBPw/GxU1UTu4zLnBcRFxp+TT
         UfrFMOKMKoIy8O8pIbx+9gy6O77Vz3RNg0ZXKrsXOhamO46ZVod6KRPdSOAscLmG14Q4
         WICt3H8SO2Ki0w5xzDezPvhorLsJzGFII0uXrRc6egG3pHblhk2K6fpJrP1J6IFXjrB/
         suYVpGhwJ/kIKc43ICWwoS6L8bQ8eq0nGB/BICUDbNqyZsNutpBxT5hDzR1kC/rNPwLs
         UDNFJV50nVWuDL+l8AXGtyTmLAtPKM71/nq648cMO6cCE1IZxZljtZLxGShuXBgeUqcR
         Zzqg==
X-Forwarded-Encrypted: i=1; AJvYcCXSkjBKN8chAq6fqHti4QG9r8Se8R6/kxa8axPvUNlet8d9PKjWWdwl3Ec1haqstVBTpc3KYGusqYphwH0RTvpy1ItTKAftXrNWrXuDyV2e0B4zg6Zwhw1Eo3s2YjuSQmCMEHJdLNWmzX61+seWsTvabj5RbuElFbUcPxgMbaUqiFaDxb8=
X-Gm-Message-State: AOJu0YykYy7QSffzsCjzGM5KFjGram4v2I8BM3j/xggotnME/VQWLY5J
	jiRxFt6OiF+LdMPzvs3Afu0fpdzoEna7StDfoG0UxJcqYn2+lkPi
X-Google-Smtp-Source: AGHT+IGTQSlmZA2APkmcG4k0in1aO4SGPsIL+pLK9c8gmAijAfAuYNcjXfO+FLS/FyMhkMuCYpFD3g==
X-Received: by 2002:a05:600c:500f:b0:41a:446b:10df with SMTP id n15-20020a05600c500f00b0041a446b10dfmr3160205wmr.12.1714771368583;
        Fri, 03 May 2024 14:22:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm6918729wmq.35.2024.05.03.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:22:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH v2 3/5] dt-bindings: mips: brcm: Document brcm,bmips-cbr-reg property
Date: Fri,  3 May 2024 23:20:59 +0200
Message-ID: <20240503212139.5811-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503212139.5811-1-ansuelsmth@gmail.com>
References: <20240503212139.5811-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document brcm,bmips-cbr-reg and brcm,bmips-broken-cbr-reg property.

Some SoC suffer from a BUG where read_c0_brcm_cbr() might return 0
if called from TP1. The CBR address is always the same on the SoC
hence it can be provided in DT to handle broken case where bootloader
doesn't init it or SMP where read_c0_brcm_cbr() returns 0 from TP1.

Usage of this property is to give an address also in these broken
configuration/bootloader.

If the SoC/Bootloader ALWAYS provide a broken CBR address the property
"brcm,bmips-broken-cbr-reg" can be used to ignore any value already set
in the registers for CBR address.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mips/brcm/soc.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.yaml b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
index 975945ca2888..29af8f0db785 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.yaml
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
@@ -55,6 +55,21 @@ properties:
          under the "cpus" node.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      brcm,bmips-broken-cbr-reg:
+        description: Declare that the Bootloader init a broken
+          CBR address in the registers and the one provided from
+          DT should always be used.
+        type: boolean
+
+      brcm,bmips-cbr-reg:
+        description: Reference address of the CBR.
+          Some SoC suffer from a BUG where read_c0_brcm_cbr() might
+          return 0 if called from TP1. The CBR address is always the
+          same on the SoC hence it can be provided in DT to handle
+          broken case where bootloader doesn't initialise it or SMP
+          where read_c0_brcm_cbr() returns 0 from TP1.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
     patternProperties:
       "^cpu@[0-9]$":
         type: object
@@ -64,6 +79,23 @@ properties:
     required:
       - mips-hpt-frequency
 
+dependencies:
+  brcm,bmips-broken-cbr-reg: [ brcm,bmips-cbr-reg ]
+
+if:
+  properties:
+    compatible:
+      contains:
+        anyOf:
+          - const: brcm,bcm6358
+          - const: brcm,bcm6368
+
+then:
+  properties:
+    cpus:
+      required:
+        - brcm,bmips-cbr-reg
+
 additionalProperties: true
 
 examples:
-- 
2.43.0



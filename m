Return-Path: <linux-kernel+bounces-167729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED98BAE2E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74C01F231D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A991552EB;
	Fri,  3 May 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtsuXQ30"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5CE154448;
	Fri,  3 May 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744515; cv=none; b=FwnV4zKlzF8+pxO/2gSQrTZduDN+etWogg3nUOPWnPiXocBYrjV03RAZWfh410hAtMERj1VzksFrKzpg6MNs3dobH1GE3J6ug4ZNhd0pzX5IFkNKCijHM2ZdoANnnUnmc3Zdeabj/gcMAA9QVnbm9FABkBNUTEaM5XjZfuP0XZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744515; c=relaxed/simple;
	bh=OIzxZQn7CvkwNbQSajH1O/UYqWh0ClrXXc1cb8RDamw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrdFmlpDxJ8uTRjQytLKkSrolhmpDMIE7pblLeCXkhwTxu1GUXuzVCkPjs3uoNdhEVisusVk/J0ux3tWmTVjxrfo6+iS3ziWlbDIrXblBBInX4AgVgHg76SgU1e02i0dJvoGoDsP6OhYMReRL8FhgAqQEqeM1OKD27SOtMvswC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtsuXQ30; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b2119da94so69208895e9.0;
        Fri, 03 May 2024 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744512; x=1715349312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbM0+h3gaZWkGvZA7ELfOgr9IRepjvhTKfyvSJLi/uI=;
        b=UtsuXQ30AoKfg/NetYPEHDAVBtxPzPhsBT0lV3QLCLSxRuztOepRcEV2WG807DpJZd
         BY0/oDwv0v+VP6WtVzD59q2KT0+d64IEdkguXFM4AwQOMblhmF3zYw9T2rXvM/lZCeb1
         kJz9LQjp1SSGjZgM6OYXKmyh/9hR84iJB3nTefuo3aKmgrnksz4sVHO34uiLTZktgmGa
         t7M+hn4jZDU8cnKP4esXFwwyLMU1K7gOlYwHrQZAODE2XNZsTV08ETSfDEgcEJ49rFod
         SvP87s/I+WTaMc5BpLDeF8BoaVEmYxTWYQh5aFwawzBqOx1KihiZ3duYjPh4ZPWFdOyI
         cDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744512; x=1715349312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbM0+h3gaZWkGvZA7ELfOgr9IRepjvhTKfyvSJLi/uI=;
        b=tT5NGbFmyqMHhx6Z51rsD75eBJT00/oyaqDChgtgu3x+hkUhO3aGfSO2nKLDcDymLn
         Cr4ZUv6yEH4F9/JkHp+NcGMiVLGscWsQGJfEElB1chuwUa7aZpTlmWiO7JcxWrDgIlSd
         MT1ZYefuJT87Nz73BYCAzSPcPNsVkPgct3e9Aviopl2VD2aiRl0dEn/q10LVZqVaRWtf
         X5o8I5GDCfomPdPudwf8+Z344NQvLhr2PGSMAIK4BRSSUMo5XHNfSEtOTd532JJ33JYh
         y2YeQt/MF6TsWWiqPTdJwMTkbNuhQ4T1ZkXJzooGLDM3NBtxKxa7E/bbaGIY6RklgEhD
         hOAg==
X-Forwarded-Encrypted: i=1; AJvYcCUZwp968tpceABaR+5h0n4BNeSRSFypD7p8JegD8oKexzKuHf3j9EGDh5WFgk+2MN7jNkiT50ecgCUZOAi+FrReTPsxZxnzua7xh0+kzAfe8OUnh5lfaVZlVlLhNuF/sg138GUZCgyKBHuFPd2Zlqron1Ka+LjEXDXMJJE4BhkLBpGJFd8=
X-Gm-Message-State: AOJu0YxRYj7y2w62ULBp48JIA1xsdfRh5ZxLDBcCLBLSv63eIPVU83BJ
	F2pOXuYSMnvTM1ctTMKzrezjRKO1I6upRSzh0wSlP4wIiT4D0Q9W
X-Google-Smtp-Source: AGHT+IGyIRX1wx9xJzEe3+xlmN68HAq7yVtlVirObqKJ1/LO2NF/F6bkbCf4wkECBMQpAXAaMegVhw==
X-Received: by 2002:a05:600c:3596:b0:41b:bb90:4bf with SMTP id p22-20020a05600c359600b0041bbb9004bfmr2262674wmq.18.1714744511684;
        Fri, 03 May 2024 06:55:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:11 -0700 (PDT)
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
Subject: [PATCH 3/6] dt-bindings: mips: brcm: Document mips-cbr-reg property
Date: Fri,  3 May 2024 15:54:03 +0200
Message-ID: <20240503135455.966-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503135455.966-1-ansuelsmth@gmail.com>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document mips-cbr-reg and mips-broken-cbr-reg property.

Some SoC suffer from a BUG where read_c0_brcm_cbr() might return 0
if called from TP1. The CBR address is always the same on the SoC
hence it can be provided in DT to handle broken case where bootloader
doesn't init it or SMP where read_c0_brcm_cbr() returns 0 from TP1.

Usage of this property is to give an address also in these broken
configuration/bootloader.

If the SoC/Bootloader ALWAYS provide a broken CBR address the property
"mips-broken-cbr-reg" can be used to ignore any value already set in the
registers for CBR address.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mips/brcm/soc.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.yaml b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
index 975945ca2888..12d394b7e011 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.yaml
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
@@ -55,6 +55,21 @@ properties:
          under the "cpus" node.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      mips-broken-cbr-reg:
+        description: Declare that the Bootloader init a broken
+          CBR address in the registers and the one provided from
+          DT should always be used.
+        type: boolean
+
+      mips-cbr-reg:
+        description: Reference address of the CBR.
+          Some SoC suffer from a BUG where read_c0_brcm_cbr() might
+          return 0 if called from TP1. The CBR address is always the
+          same on the SoC hence it can be provided in DT to handle
+          broken case where bootloader doesn't init it or SMP where
+          read_c0_brcm_cbr() returns 0 from TP1.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
     patternProperties:
       "^cpu@[0-9]$":
         type: object
@@ -64,6 +79,23 @@ properties:
     required:
       - mips-hpt-frequency
 
+dependencies:
+  mips-broken-cbr-reg: [ mips-cbr-reg ]
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
+        - mips-cbr-reg
+
 additionalProperties: true
 
 examples:
-- 
2.43.0



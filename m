Return-Path: <linux-kernel+bounces-155708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F698AF5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E00B24FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B413E8B8;
	Tue, 23 Apr 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COkEhOaw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78213DDDE;
	Tue, 23 Apr 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895159; cv=none; b=nSwaV8pzWY1B9wAFcdEDLI1JsUzxIbXZQRDi+N2jpmA4UEzIZQnyKNWegh1ZlqJPwNCO0XUSLuEhU+EW1F1Ccv6/gNb9AeC216tbnRB+BAhdA3VxEAwgiKEdCCRisQpBcw6uLBNedq2z3KfjdDFbPmpxqNOp5fvtUImxJ+C4/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895159; c=relaxed/simple;
	bh=UJLGYHQPbzZMT2YvNoHPmmDmdCG43VKrbHKS/AxLT8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrstQjWsOFL0Wr2k+6AQZlZjjbnmq1C9oGab2jx9ItuKZUVLWc2mgcAN10EBxyZXOwZluQrWJZ9nyhBMxC1VMzNbHwlWQjoykrS921r2jwyEeEu14Tw/VYE+tMFXZat/Sy7j1MrI1DkkPDY9Ngsq5LXQk36cgLe64L9CCz5LWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COkEhOaw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41a7820620dso16867805e9.0;
        Tue, 23 Apr 2024 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895156; x=1714499956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3y+6qH+3vKHvAcnjlxDf4ow6EVje8GMB46X3eweU1s=;
        b=COkEhOawaCY7rEBE7PBuOxy2BF1aS67fJAWmE8MsMgcxz7j3L0DiDMppyT1IYYZKgx
         DJEb3Jijpda6SofSA1V+y4trk+UZ7KVWiajBQoeKwxvzfjPFSBE+LHyAsaBRPskd+Lp1
         r9hIwkgwrJiw/I2NaMqApUtY4D686Fs8yDDfntmfkypFVeTdinAFAmQyoJSjAZEAUR/+
         zlPsMX70YL9XUUr3Qtbl/0EH5zqC+tRrKCBjK8J4iG8YvftaGmA9WJWoazgCEDxZC9tE
         DMGcV6hZDG/XwPTNbxW4MpAHP7YaMxtFNLEzWDL3TPxUlt/1uMI2heh3m0dJKXvFQ6jA
         haXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895156; x=1714499956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3y+6qH+3vKHvAcnjlxDf4ow6EVje8GMB46X3eweU1s=;
        b=qYEbwwsTXrwBmKHuhHQhvzaRNUEK16U7DmoZk8p1WYz0S18Y/INP4A7Q0kF/iZ5s+i
         IZoj0IvkaZZb3LxSl49PdlfwTOMEQ48MgJBvEL3buTqFAyG3bSB2N5Fc9HqSWBnfpFrR
         R0SD4DTC0eTuPL7nhY135z4mLHRGGRKv5fnzZl7I8E1FuW/y0DTvdbx9Ld0nH3+5HfiX
         Be1U4u549BTdWEXJtnm2NJ/pgHLAkZTQLkB0eMPtLSIqwTdmZYd6q73+inJ0JDhZQuJD
         /p6gykulorRyYhCCKDSvw8HTFklOu1KHiySrZR6IP+UtS6yps1Q10puarQAJuEJTeZiz
         FJLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJUz2DRKHaNAXuVBNoWrFJ0AuYVhSkyo8mNUbFBZwWnHDxOaROq01kBsF8dEvarOFji7dkD08XVsbQcSoVGy8vHJ8hi7IiuCSiYFwBvXMsDqGUYtrxOy83K/LI+NNX8+5hCZQEAB2Bdsap5a3eC3aCSvJnIrdSsnxSEqCkgxGS1O3/jJi+KRZkv9vB
X-Gm-Message-State: AOJu0YzKELb6hZZqzRbwaxl543UunJ8ASHA+j4xwLqgpAUNOOHQwvhY4
	EDvDbHYkSzyIAM48TKQdlzb17kxiW0QQ5cBxRQeI4vWPEBB4IqLPNWcoimp/
X-Google-Smtp-Source: AGHT+IGEXm1eVY1mbC4/Ky0MszLIPjs6V7S8bUGR3gSWWN2y1N76KS+eFGAM6ll5g9HwakjojtEo8g==
X-Received: by 2002:a05:600c:1d01:b0:419:96:965 with SMTP id l1-20020a05600c1d0100b0041900960965mr10653246wms.37.1713895156597;
        Tue, 23 Apr 2024 10:59:16 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:16 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 01/13] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the object
Date: Tue, 23 Apr 2024 18:58:48 +0100
Message-Id: <20240423175900.702640-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Drop the bogus check from object as this didn't really add restriction
check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
RFC->v2
- Updated commit message
- Collected RB tag from Rob
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 4d5a957fa232..881e992adca3 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -79,21 +79,6 @@ additionalProperties:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
 
-        - if:
-            properties:
-              compatible:
-                contains:
-                  enum:
-                    - renesas,r9a08g045-pinctrl
-          then:
-            properties:
-              drive-strength: false
-              output-impedance-ohms: false
-              slew-rate: false
-          else:
-            properties:
-              drive-strength-microamp: false
-
       description:
         Pin controller client devices use pin configuration subnodes (children
         and grandchildren) for desired pin configuration.
-- 
2.34.1



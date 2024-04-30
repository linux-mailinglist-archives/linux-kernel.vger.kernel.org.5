Return-Path: <linux-kernel+bounces-164124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C088B7952
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F7CB23EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CD81C68B3;
	Tue, 30 Apr 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhViLikG"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA91C68A9;
	Tue, 30 Apr 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486512; cv=none; b=SXR7VAX+4J6THhZqXRQLpmR6P5EHVZvFREe2QJo9uXyUqPAY81c/CHRNCumclAKpdaFFO9ecFI0PHuKFl9yUPazWbKk/iHI/GNK4bWOL5Czk6ty6ZJ7HTyTk4Cib1ePoW+8/LZV++oQq4Pkpq2EomP47dQ1IzDh49gElhMcPCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486512; c=relaxed/simple;
	bh=H1f/cjbXVrukZwHoRkAAwV+1+emj9a4hTyz8Updt7oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snxF+2sfgYSSuDTtBNR/ZGNe2zxnGOtl8I5PBeINMg9wHr4xPdNQzoqJP9Z5PS2FMAL4x4o/GLG6z1HlO3DclOKFEVkSY5ieZL/p5xC7AlsKFvmquNoQ9uLV64m21QelgHE/ix1L4q068lZPgPgMV5fM0OKlTYRUh0HXeTDUwDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhViLikG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b27eec1eb1so585159a91.0;
        Tue, 30 Apr 2024 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714486509; x=1715091309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2Y2kGGbmaaifliYlhou15ypxyrXTa5jJJJEbBWlCRE=;
        b=lhViLikG8D6GCHyf5nfQOWJZyFRIfmX2bFfHfyvb0fEW0jgCC3nSvHev5j7wNuXFKc
         1tkIsrA+qP6Peb2zpLcKR1w6hxuK7/TO2LR5TfG8vkAaHJ7jk7JRk5EGqFhunVeyoDcq
         BDIE//n6LwC83nrWg2Rl4sk7vj9zzjac+EazlkvkmfOMAd0UZT8OElwqlzE1o6QE8uj9
         TCRPtKx30SW9z47vf0cp0OEhkdJTgQ9bxNg3SXECmpWAJXKKqDs2Oy1bYKQFooPs1xUd
         JoyIjdme/nmpuDRZs8LVu9iFFoOIOvQVdMnuQG7Ezni+1CgE40QnhP0GZZQeF9aYVAW2
         Wn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486509; x=1715091309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2Y2kGGbmaaifliYlhou15ypxyrXTa5jJJJEbBWlCRE=;
        b=mtwHX77N1rhJjIMoBDLPYWt9oWqe2+WXwG0aCGgOqpPjnFjsvJTrBjH0jbhuQhm+Oc
         oGoTIBBB3MlslPwz0Z1r82FICRr2YoUv4ulUU05RKwmXz0cui/xwbN8weAhTOoN6kAY2
         RyVjufcjtcucAyT5nJ6wvZ/aOLFr8d8Wmxsd7lXLDAwFFDLbRGewZUsGQnS8gb/nPO5y
         yOc8D8a2qfKVEisJX+Bessx+1nF0qaPA7s7jTH1MmVgkbhEXodHeOXa4zgxmDy/40Vvs
         kg19NoNP7FVtGQBl3WDz6JnrYOGrz2kmwF2CW0JrbobwnckCx+3AWRxYGmr9SkvnEkF/
         USow==
X-Forwarded-Encrypted: i=1; AJvYcCVYaqiDh4l9xvagYAB4hK069Cv8lz/C7cntkO3/CsHUYT7gV1J84nSoo55v3j7hXdh8UZE+wVxkZqroSkZzCeLAF89/qq9fONkKFFxpHyXGzqwWKUinfWASKgrDd3fDDnGVTT5cvWwK0Aba3VMX
X-Gm-Message-State: AOJu0YzWBXJc2oBtrzzesNssShiLLz3ikmVRNvv4jt8tAkGhpC44Tgiu
	9Lk/36tiVWL33XB4IE7cirXU3JRFUufLZMSaeAROt/m6PTAcNiLx
X-Google-Smtp-Source: AGHT+IHP6FVNC2v9adI7AWskBEGCEOXQ3VNHcLtolk/uKaGKkx1QbyuMK3r5uLpYWO5KjNJP2qgl+Q==
X-Received: by 2002:a17:90a:d58b:b0:2b2:765d:1de3 with SMTP id v11-20020a17090ad58b00b002b2765d1de3mr2378771pju.8.1714486509362;
        Tue, 30 Apr 2024 07:15:09 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.80])
        by smtp.gmail.com with ESMTPSA id az24-20020a17090b029800b0029bacd0f271sm22883227pjb.31.2024.04.30.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:15:08 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Five SoC
Date: Tue, 30 Apr 2024 15:14:37 +0100
Message-Id: <20240430141438.132838-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430141438.132838-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240430141438.132838-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on the RZ/Five
SoC is almost identical to the one found on the RZ/G2L SoC, with the only
difference being that it has additional mask control registers for
NMI/IRQ/TINT.

Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/Five
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3->v4
- No change

v2->v3
- Dropped items for rz/five
- Collected the RB tags

v1->v2
- Dropped the checks for interrupts as its already handled
- Added SoC specific compat string
---
 .../renesas,rzg2l-irqc.yaml                     | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index daef4ee06f4e..44b6ae5fc802 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -21,13 +21,16 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043u-irqc   # RZ/G2UL
-          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
-          - renesas,r9a07g054-irqc    # RZ/V2L
-          - renesas,r9a08g045-irqc    # RZ/G3S
-      - const: renesas,rzg2l-irqc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043u-irqc    # RZ/G2UL
+              - renesas,r9a07g044-irqc     # RZ/G2{L,LC}
+              - renesas,r9a07g054-irqc     # RZ/V2L
+              - renesas,r9a08g045-irqc     # RZ/G3S
+          - const: renesas,rzg2l-irqc
+
+      - const: renesas,r9a07g043f-irqc     # RZ/Five
 
   '#interrupt-cells':
     description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
-- 
2.34.1



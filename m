Return-Path: <linux-kernel+bounces-155741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42D8AF67B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422E6B21F17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBC1411E0;
	Tue, 23 Apr 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpbUHcBv"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FB13F437;
	Tue, 23 Apr 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896693; cv=none; b=ohexgYbbA5bbcteAF36Lo/M6ET18LAnt4PLuS25RPkBece0BwIITuHgFbshrfhN+kiUDKG5EorrrK4sYrTCsbtc/TrbRkfIpg07nslroAgvpp9R8sXj9cO4E/D7pI5Rj+6fOV6WZol9UEvQXSaU/3w0vLRs2JsyglMeH0ELR2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896693; c=relaxed/simple;
	bh=y4UWqPTTQ16KbYceLassfLv+o3K1fLDGHhfI86xgT5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4P7CQHWQLIi3tT8p/T+xKuxkPWN21CQITT//jbcg9PUM29d0HmIg40544lRsMyoCV/B51AeZfAqQOf+/cI+d/IpdzdXjtQbzLCc9mQ2zRuPAxb2BCOjG/4I+rchDiZvD9i+Vhbp0J7Tkgsp0aHmDYBlnYdYjKxZ8bse3E/58KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpbUHcBv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34a7e47d164so3608024f8f.3;
        Tue, 23 Apr 2024 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713896690; x=1714501490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti5j86HeR1DD90dqXtcMI4GGDjbxhYOJJR+sXMnaW/Q=;
        b=VpbUHcBvVbw505jfHhL6kexC3+nk/riBlcqxGCJRPjE6pFPsvDqdcZ4ejOFAVYBJoE
         p2sbF4k5m/if6OnjbGkdxtqC8xUWBoaMY2Me6vrAYUZecUKKQA0nsMaeb97gBkW5ujZu
         J6ytBIGOzQpd9mctWsvLaQLNBWPwfYSxZqvmeVqGmtkJd2wqccSx9CvRGVcZaObqtnRR
         qiPqiq3oW+/Lm/cs+ytbCNS4Fe7MkoIBjmw79UG43MtyGcmCR7XniuthlUqjbHOw9WLV
         1aZn/Ldc0iWsOOq/xZ5Jl/dQbSczVcon958lLbUhd/sbf+KCnsnNUyswW1WTd0z60KOB
         rqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896690; x=1714501490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti5j86HeR1DD90dqXtcMI4GGDjbxhYOJJR+sXMnaW/Q=;
        b=v4584LMTPEVjEhcsFKA8EKVU4zToNot7l+nO1eY6fDsSJU+u+3bPewC/jXeO0uQZs1
         TB6xDeGU3BHo02X4A4E92OHIJ0RSkOnpWs8C9Ns+8PYpJBIwYiYgLnoNiVH0GzFTWwlC
         ErwvuuPX/2ndlxuYpr75z4FwuNIDA0gp/nPQ/ncp3HXVUKkKvHxx0Wph8pYySp/xmp2U
         4xz8e9lsze5yAizi9Mpwr2cnDzBELoChoyWysB3Qi+lLcj7L3684N2sHPBM/XlkHcx10
         cdn9R3+8wBhkTTuVmS+HpU2z3UsnFbUElRszflRAC2Z3NeV/HoV8uWaUI7xivCpjmvng
         AoRA==
X-Forwarded-Encrypted: i=1; AJvYcCU9WGrgGLbYu5B4KbTUgFiqbYLLb/9YYCtmK+ZYzOwMG42rCvXXbi5BXJqIv8/8/MEkSKfDhRYx5hd0FhyKBaboe/hNP71gCt0ktdN3tJjVehv93kVJSGmdP8UJw960KwLXCdmk8DD9YJLydRwqlFH0SGRznjPXZztPSHMUaNr2ywn89YIWFEfZM8w=
X-Gm-Message-State: AOJu0YwgiyVgc1kiJPHvJ04nvLoBFrKYMYBRWPUt1xh4trumbpYHN/IF
	D7Tr99/e2LFC7KFhfNV+AKp7xOobV6IeYsv77AL+JmLKoNOlNMnU
X-Google-Smtp-Source: AGHT+IExqLgMtKEkRc3UWuO+1KKfz5v/ObFBLuxk/ZDcPZvGt1I1Ua4GFp83UinLv9FI9681zSKRMA==
X-Received: by 2002:a5d:504e:0:b0:33e:363b:a7dd with SMTP id h14-20020a5d504e000000b0033e363ba7ddmr34242wrt.20.1713896690157;
        Tue, 23 Apr 2024 11:24:50 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b00349ff2e0345sm15319164wrn.70.2024.04.23.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:24:49 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
Date: Tue, 23 Apr 2024 19:24:27 +0100
Message-Id: <20240423182428.704159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The SD/MMC Interface in the above listed SoCs is not identical to that of
R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.

Document 'renesas,rzg2l-sdhi' as a generic compatible string for the
above SoCs.

Also now use the 'renesas,rzg2l-sdhi' string in the if check for making
sure the required clocks are present.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1->v2
- Collected the Ack
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 2bf90095742b..afc2652fa6c8 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -52,11 +52,6 @@ properties:
               - renesas,sdhi-r8a77980  # R-Car V3H
               - renesas,sdhi-r8a77990  # R-Car E3
               - renesas,sdhi-r8a77995  # R-Car D3
-              - renesas,sdhi-r9a07g043 # RZ/G2UL and RZ/Five
-              - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
-              - renesas,sdhi-r9a07g054 # RZ/V2L
-              - renesas,sdhi-r9a08g045 # RZ/G3S
-              - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
       - items:
           - enum:
@@ -65,6 +60,14 @@ properties:
               - renesas,sdhi-r8a779g0  # R-Car V4H
               - renesas,sdhi-r8a779h0  # R-Car V4M
           - const: renesas,rcar-gen4-sdhi # R-Car Gen4
+      - items:
+          - enum:
+              - renesas,sdhi-r9a07g043 # RZ/G2UL and RZ/Five
+              - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
+              - renesas,sdhi-r9a07g054 # RZ/V2L
+              - renesas,sdhi-r9a08g045 # RZ/G3S
+              - renesas,sdhi-r9a09g011 # RZ/V2M
+          - const: renesas,rzg2l-sdhi
 
   reg:
     maxItems: 1
@@ -116,12 +119,7 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - renesas,sdhi-r9a07g043
-              - renesas,sdhi-r9a07g044
-              - renesas,sdhi-r9a07g054
-              - renesas,sdhi-r9a08g045
-              - renesas,sdhi-r9a09g011
+            const: renesas,rzg2l-sdhi
     then:
       properties:
         clocks:
-- 
2.34.1



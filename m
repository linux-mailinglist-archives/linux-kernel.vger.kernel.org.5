Return-Path: <linux-kernel+bounces-164222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB08B7ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFC6286E13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEF17B4E8;
	Tue, 30 Apr 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWL/rxZ+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF377710A;
	Tue, 30 Apr 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489226; cv=none; b=qQq3z6MMVhJOH8+0g1ojUMONRN6Vm9z11IrsYpiuMXlLr3py3V1HzZGSfeiSu3hE/wQ2/4aCwqrufjuBqwZrBknfrM59n+Vi1qLuP/ByNqvNosDTFoQ6MjWGpIFsO8PTZ7j1O6Gy+NsMBbLBaQ75ZrIlG2aBaB6RIXcCOhSsdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489226; c=relaxed/simple;
	bh=qwtVApGHLbBDbNhTV1xPYBSKmHjPuinUCjnZEAfXTZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HATO0PPzioC2Lt/HMFmT62nTa7M2FPFOyaJNXyDjJxw5buHucl3Ymy7SaGL2spmugXSDyqOu9zSj/GULpCOU/wNz1tSWrjuDsBrHifv2ns5kVM8qyq2Plcvw3yU9I4uAmn1GsyVGbJ2Wp26QU0gQdVchuGlT8/NAxhDQyChgUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWL/rxZ+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso4911898a91.3;
        Tue, 30 Apr 2024 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489223; x=1715094023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSS8c164iuR91zosuGw0IP7egn+PiDXa2358wfqi7iA=;
        b=aWL/rxZ+CWwN9XGsaUD/FOEHwpbqvzLDb20Qlm4TUMaq2BOm1y+Ihm1XcXXGsy5kaY
         km9cvyIsny6+Pnx1BMrQCIl4iSMnUCnLl9YiP30JN2/f9V7CGgRaVLgOFO7AQNL2UpEL
         zgp6VTwbKQv5fXC2Eh1V9VYc6wbWPKV26Nr5PtpedDBU//DScBTwFcFb1G3So0EQT8cK
         fZNz6Dkk3m0i3kprVczzy24G264jgHDVpFuSNHXMX8h5pJku3oqFtt+OUUkkcOaMjop4
         g/mGO9MKc4uJK9X4ZrmosYx1Lkpq4e6bbE0JuWXiMu+sxlL0G/8V3nmFV3qN/QZ3so5e
         RDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489223; x=1715094023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSS8c164iuR91zosuGw0IP7egn+PiDXa2358wfqi7iA=;
        b=ZjzmHCQrbGn8bGMZYbckYU03oBUHW+oYXly1Pv2YtJJkYIQNJ0pwHA8KhcPi7dtoB9
         X20vuJqRhFkeZ7Q+jCVjmiXlk+w7OoTVrTIu+5CcVgq99CKqB8z2OVovpJsSLP+sEJ4v
         6H+5gxjffg2BpQlnFf5yMLj9XTzxN2SBaciPLRSuIbrdUiH7fRKyOP0UPEPhxo54X4dj
         JCWvyRbZRhBw6+ZI6ELdasVkGJ4LBRSz7TanrD/JrjeY48d3R/Buf3rYhb5kywFTDtvQ
         jkSalHyFfFeT7VvVNTitL3UrhntALCskoW45r2232Yhkmv05i7UpsQ7VhM+mwI1yNyrz
         83pw==
X-Forwarded-Encrypted: i=1; AJvYcCUNuV/3pXXZ23ZFUPdckTVpnoYo+TzIElYyEDq5J6ZXpBJbpYaTkMP3kuNywypYlkWEOvYtPgohvrej4etw6oVUG/3+4Gk96lrHVxfScNOy7ne/FEzG0KNMceHC76C9oq67Y+U3622SlWEnUTY5LTmlf5sx0YPjToLUejJn6T08hKN1z9XWhjnVhSU=
X-Gm-Message-State: AOJu0Yyq9v6A2kS840/ufbIl9ytCaXZXw0n5gGsfk13yN4EvegT4dWrK
	U4PdiocJJSvlNGJrO2GjLtzPVZ7P2XQVvN92FrXdU9awAKNuL1AXUB9nlkVxJ4g=
X-Google-Smtp-Source: AGHT+IEkZzquWkAi5nJHyIBIpGO9jRpw7Yrzz0E7+K/Ao3Efb9iJOpHfjqpvANG8gAYwiufq5+WCgw==
X-Received: by 2002:a17:90b:1953:b0:2ae:3f00:137a with SMTP id nk19-20020a17090b195300b002ae3f00137amr11866454pjb.46.1714489223190;
        Tue, 30 Apr 2024 08:00:23 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.80])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm15428745pji.22.2024.04.30.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:00:22 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
Date: Tue, 30 Apr 2024 15:59:36 +0100
Message-Id: <20240430145937.133643-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430145937.133643-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240430145937.133643-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
- Collected the RB

v1->v2
- Collected the Ack
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 34e50eeed567..3d0e61e59856 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -51,11 +51,6 @@ properties:
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
@@ -64,6 +59,14 @@ properties:
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
@@ -115,12 +118,7 @@ allOf:
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



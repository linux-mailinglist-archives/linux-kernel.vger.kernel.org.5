Return-Path: <linux-kernel+bounces-154050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10DB8AD696
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811681F22314
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E282E410;
	Mon, 22 Apr 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amw0PveD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D201D543;
	Mon, 22 Apr 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821434; cv=none; b=O2fEzV8iwx16Y1vZViDW3QcnL+rrCqrgTKgNFht10jmiW63yGsKDkg/SMs3977TK7Gw+i9Vi8u78bljDqAvqVmexFyXgkAr3h9Q+u5gmk5rAD97l8C8tslFb/SkcmLN3AhbQtTv9rvqbqWtKM6P2NcaJakRC6gqXw2nMgdri6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821434; c=relaxed/simple;
	bh=YSAZYUKNk//Sbo98e/WAYOvJPUNoN/VQqr5B4yAiKnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMDPA36fTBAHUoLq6kMVp5WOPl9zjj85s2/8pIONZKvXB+8IGB8+ugOUVAGNWaR1AD24YV4kIG3swJBUMaHTSPIJGN7mpAnATQ395Ma1fw0FrFUoz+lFesHzVH79/S09kV0R+Tf1MpoWzcVyD7HAkNPNfD8rk2PWz29sAgA5XrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amw0PveD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso15166175e9.3;
        Mon, 22 Apr 2024 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821431; x=1714426231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98JmTxaKvTilzo91WXbJMv5ZidyNUgnTi9gdp2tAp7I=;
        b=Amw0PveDweVa6W188cB7f3OGoGn8hV6sj4cWOpWu9ibZxxc33Lb5BwHtqmNgH2oP18
         lEHXFup953MybkdQ4dhG/lTKFMMkj0xHfh+MR/oMTefErRPsRCVsXYhiq3VtPxJNd7JQ
         0pfam/k8M7m1tdq08TlzqSBGNe9SPT/YCzaaI9PPMc6iU7xaNENFgvJaLmX+wNDOgqYg
         h/G613CmSg/peheDPMcGCHS1rlDmkcrjvepysPgG1/2bThG9kmSYraf98UHSV958nzFt
         h0WoL08qEJkqI7hNKb81y3vrZJyUD8SOal/nOIyLDnbZAV2+xVw/LvCSaJbWCfvKHx5H
         OsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821431; x=1714426231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98JmTxaKvTilzo91WXbJMv5ZidyNUgnTi9gdp2tAp7I=;
        b=ozlkYi9Ne0Lw2dRN199HZf9Pmjmm6aG+C2jUwd19BVOE4fQMWWPBFcECsncJPq64QL
         kTC8c2VaetBBCi1PjtUPgTZ+TZEFj1/jQ5k2FLSLWLAvaWJZRAJjAkEktcTcQk35Yhpm
         sIqWqQDU8gI+KUQJ0wrfg61OgHw5SGgj22GY0m3mSegy0mhiTGfdvcK97VWnx1PW//Dx
         N9XR80Ftg26pG7LeU/gHRrAiOzQQ4J41d7Y5XXmOBAlCPGCYv9lu2h+B0SvKTnGnqUws
         h0HvN5ekd1sl4HgHFqxYn3JvGSGV7Tdy/aeEhP2JOhY2bpHAT66tuLg1ngb19G/dmRuY
         7yzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKNPGpLwoSjbSZnjrNF3kIA2sLdLos2TsUCrojpuyY94sZNB8yDzvNT8exFySvadr8dlYHL29nbz1YV0mrKnnP42DCGj21LWAkkdkaRDEkrrofk6jqW5pGIJ6mB2c4d073q/j5Bhb3qeftjbrJNtDfWkZTB5K+hRhxSsvSXNLQvDMsBXexMh5UAmo=
X-Gm-Message-State: AOJu0YyojeRmH+44JrJbnCvkeytOvBPB/P/2GYHU20M9KwGb6DOsC5KJ
	n9RD0s/A+huLzpKKxJB12/s/QppNIVuV03KHjwu0FhAoc1e2xFRI
X-Google-Smtp-Source: AGHT+IFRGERFqzSgGRwbNXXsT1DN/yW70mWyS3hUgmQuJpHIZHTLtVrVPNl6M6h7uNeqGlLiJMHS9g==
X-Received: by 2002:a05:600c:5252:b0:41a:908c:b841 with SMTP id fc18-20020a05600c525200b0041a908cb841mr1675745wmb.32.1713821431532;
        Mon, 22 Apr 2024 14:30:31 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm12886793wrs.53.2024.04.22.14.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:30:30 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/6] dt-bindings: mmc: renesas,sdhi: Drop 'items' keyword
Date: Mon, 22 Apr 2024 22:30:01 +0100
Message-Id: <20240422213006.505576-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Drop 'items' keyword from compatible list which have single const value.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 29f2400247eb..90c8b1b727a8 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -12,16 +12,11 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
-      - items:
-          - const: renesas,sdhi-r7s72100 # RZ/A1H
-      - items:
-          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
-      - items:
-          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
-      - items:
-          - const: renesas,sdhi-r8a7740 # R-Mobile A1
+      - const: renesas,sdhi-sh73a0  # R-Mobile APE6
+      - const: renesas,sdhi-r7s72100 # RZ/A1H
+      - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
+      - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
+      - const: renesas,sdhi-r8a7740 # R-Mobile A1
       - items:
           - enum:
               - renesas,sdhi-r8a7778 # R-Car M1
@@ -40,8 +35,7 @@ properties:
               - renesas,sdhi-r8a7793  # R-Car M2-N
               - renesas,sdhi-r8a7794  # R-Car E2
           - const: renesas,rcar-gen2-sdhi # R-Car Gen2 and RZ/G1
-      - items:
-          - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
+      - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
       - items:
           - enum:
               - renesas,sdhi-r8a774a1  # RZ/G2M
-- 
2.34.1



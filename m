Return-Path: <linux-kernel+bounces-154051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7208AD69A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BA61F21F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3983C464;
	Mon, 22 Apr 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHiHNMjz"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BE2574F;
	Mon, 22 Apr 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821436; cv=none; b=mt3SifqgxO/pDj2vXyEwdgIFsuxX7YgyN4SkYx0mjWGWFtHtUi0Er57E8u1RG4KhD1rEXeYb7gzB5ZHc5VGIPPxP0l2qa9vYx4MxCe22NZl0gmT76X9a8Ou4+6zHNqg9I2soBRioQDc1BH9mProiQnrRIXkGlRYd0qwWPV+YECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821436; c=relaxed/simple;
	bh=PwIi9g6Ug0mIHJNzXb+sP4XD/avIBOx+oQwvDb6AHbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPp43v0t/qbgJXk8OsJ+kryyihJRFo3w8bPOK5CcWhRSdFNISzh8VLBVWquEzasrtCB0cp5IN6q3Ugyqx89amRvfHmdRQI0Lf6lS/b1wmqxpgd2wuEpZW5ZGjdGRZfodrU6AltF2s23pAlMwMuFShZGYLtkEgfY3m6J10tlbmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHiHNMjz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d1003106so4140344f8f.1;
        Mon, 22 Apr 2024 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821433; x=1714426233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPgzLl6O9oFCEjrO6ofAwonjARzMxklQoB+90Nyxras=;
        b=FHiHNMjzA9FOn/h8nITu8sni5r2k3DY/Fjl92Gd2Y3JgOzIb6w20wKywXFSH+vVGQo
         HTBM/UxA2FjpqkRHQNXVCL2KGTeRdutd7NLREThGq81rw2LWPe9Ftbis6xrznPZFM6Q1
         q2e5ezSlXyFED3ltL4SmxmBjKnEd3m9PpqjiuInytk37ujKPgTjkprtQt5tOef5FdilP
         TWvLTOdBk9qNQDQ6V37bcRIrP36T++Tae3hOfgw3C4yPsfTH9pfsxgDA7KuYmXaEmQbl
         XTueGMl+vDnplRTOM3gAS+ybnsAYJlCZcLAX4yCQ0R9GcQAKWDNDiAHlvGtIoRnsTEQE
         J/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821433; x=1714426233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPgzLl6O9oFCEjrO6ofAwonjARzMxklQoB+90Nyxras=;
        b=Oe1X4kYcYU1AZGhdqaQvsveCX2aQCz7NyoObI08J4YElozunRcY/WfzFb8HGSMwd2X
         OZodbJ2xEZACjY3Pe66ecrI4OKxhzo/R5coHfw3pn3ahc9cTBWkjsg4qfeB7fiH4NVYI
         Od4LM6YXBgby/M7V0YU/F6ou5TtwVZwmhg9GVX2WKcXTNjtzkL2ev08g+eY6KtwsCDD2
         1vn6C8VV2ADyLGMM5ettsu0zwg5j/ada81Z7FO9kGBc7NmHHr/KdJAQnrgjhuoEA8dnG
         tHZgaTK0nA85f58EuOkj0abMwRe7PGdv+LDUty4FujACqW+TE4H4TPu3f5TPe7pJ7a1g
         0tYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSCazcP7FT7yp7KnawnVTvbLycBfMM9qqhORM9FaHKQKnOSb/G6IbX422+H1x3FBNCHIr3EAE+WY+7zxTcBCDSW0RnNFNfj3daAql1MxqZMde0UKSr1tQPCtftaBHRA9eY8obtaXeFkg6Y3heIFkylNhu9TPJZyrbZUQW5BH8LlD46bjTPY/ipN5A=
X-Gm-Message-State: AOJu0YzI1nTOPjA8pR+64GGPtwpwoC5p/UDuzQ12r5d0q6wA2T3W5rVH
	xT8uju6RRkcewWQe6Xa7ZyxWjFLSid65qtuihnCjvMEi3CXufaUQ
X-Google-Smtp-Source: AGHT+IEglOArdPPSz9YDWTgmy2GoAwAHbIIsIBz1fKbm66qjdNDYpmH21JIDBDvXZmRg3H3FT65JcQ==
X-Received: by 2002:a05:6000:b85:b0:347:ced:c7c7 with SMTP id dl5-20020a0560000b8500b003470cedc7c7mr10081846wrb.9.1713821432988;
        Mon, 22 Apr 2024 14:30:32 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm12886793wrs.53.2024.04.22.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:30:32 -0700 (PDT)
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
Subject: [PATCH 2/6] dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
Date: Mon, 22 Apr 2024 22:30:02 +0100
Message-Id: <20240422213006.505576-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 90c8b1b727a8..bbfac046a3a8 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -50,11 +50,6 @@ properties:
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
@@ -63,6 +58,14 @@ properties:
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
@@ -114,12 +117,7 @@ allOf:
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



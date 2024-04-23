Return-Path: <linux-kernel+bounces-155740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7EE8AF677
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35BE6B22DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC913FD8B;
	Tue, 23 Apr 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaUCpyr9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECB13E418;
	Tue, 23 Apr 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896692; cv=none; b=PpM358TD0aKzx6dW6R0FcAW7N0cBxwEhQdkum+ewQbvWtoWxA73A7WTPM0tp0bJKvbZ8XtcMRry5IlLX+zTHv3aYAN1QixalFrUV/Gm1Fh0OOFauBowFjMABOHWDrHWwFQfs0afLt+gK1GABGR1kxUBtW2pW/zaKvfdJSZRZY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896692; c=relaxed/simple;
	bh=aNvr6nJ8MdjFtJCWEU21zXsCncROQPWhmpZ2dVqpnkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=io0MB+w49Excyw5Yzujrh2DVXBZaHcyfPYjS5FFFWIk0FUcoNc/eL+1EwDFrSX/0idNNBepLx550UJxZQD0CuNMD41RuifOazjBfgxZA5gTFxpWvsl+JDiSPG/04ikjkA0qMpmFD2dcGhwSiHHBcOry4Q+AKQaroXGkc9qKLWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaUCpyr9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so823315e9.0;
        Tue, 23 Apr 2024 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713896689; x=1714501489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkDtJgHTmbZfUqKXKkWH0k+mpiwz1rvoj1AAD569Ce8=;
        b=AaUCpyr9puGcUarNuDZAHh0gkdUYkwu8lCCz1kTVhU378yBBeKZaSxlkMg+NPIK0sN
         PaKrJBvL8HTVILempW7JxeLINGmqu1bLC4ONm1OxdMwKy2qYn1VkSkL5NCRxGKaYCrMP
         1TkAHAhlUKiy/wD3/0mpT1AGrrupShWzZxa2KZxI8GPfBFY6yg7U5kNxoGn8b4xEQK9a
         05XrsVl4GXfxoaAj2r6Dh5mI1AjGfvhz/n8vJqj0AJ/0HWzUA5CJPMRqHNofft53bbft
         fGWWGDmHBfq4TJGfCK9Y/V+zhNFguJNenibAPRtd6uXMPriQwlLjxDeJGgwi7Kt5jaUG
         uh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896689; x=1714501489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkDtJgHTmbZfUqKXKkWH0k+mpiwz1rvoj1AAD569Ce8=;
        b=MjaeqsmA/NpGTIewAX0vYH/cimYNb2r6Vg1EOGl6bYE7oL60yUnjixcOj+mCvXPDkV
         8xmiXapZqLKaiG+cloWgdQfTuS2X59Zqs1rZSY7y6zzFkh1HRKSnb80i1svTRvzc29R7
         oIUsrT9YEYCRIcFUarkdsHgv8NM8LONYD6lF1+ggH1nbx6CP1gX1Bcfcslr6QwgGmmnJ
         xPLJfoZA7jbOTRlykKgO2aSVeED8gTXjxmAzIptpR+lLJ8kZKM3J8b7+sh1IRPPAq9oT
         GMplXvfHIW98i0JEb7GN1uL3uFfeThhkPG4pbI8BeGQdo0gO08VUvXjyS2XW36Zg82Cn
         rqYg==
X-Forwarded-Encrypted: i=1; AJvYcCXTgj5g0yJV2cxuZqZbRLmOnN9BgAMb2dZx/53MsafowMwWqqsnygjiQr2cHrbIgwOM9L5t2hdFhentAzCC3L2aNdMyFhN0rOWWQXbkm7/o7NjPItuLV5/t4F8cjMHkmPrQ9qV6oAx1k8vDX+GX0SDE/DI83x0STnvGSNXrUn/VorPVgr2/9HEC5Ac=
X-Gm-Message-State: AOJu0Yz0r0FGBMKnxdxd1YKRow4YbFm8jHQfDbf48DbVR5GDSNUspejr
	tnC6Guz+HqaN93ExKbnb4/4bxIdZ20dwAR11KERiBlKREmxtutSs
X-Google-Smtp-Source: AGHT+IHM1tyEdQ4qlLv3higgniB6ZbpM0BDIHxfcP7jUXqORO6HXwKmxKG5erJfD5ChzRGKY4SCCrA==
X-Received: by 2002:a05:6000:50:b0:34a:68aa:e242 with SMTP id k16-20020a056000005000b0034a68aae242mr2510078wrx.0.1713896688995;
        Tue, 23 Apr 2024 11:24:48 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b00349ff2e0345sm15319164wrn.70.2024.04.23.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:24:48 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: mmc: renesas,sdhi: Group single const value items into an enum list
Date: Tue, 23 Apr 2024 19:24:26 +0100
Message-Id: <20240423182428.704159-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Group single const value items into an enum list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- Updated commit message
- Grouped single const value items into an enum list. 
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 29f2400247eb..2bf90095742b 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -13,15 +13,13 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
-      - items:
-          - const: renesas,sdhi-r7s72100 # RZ/A1H
-      - items:
-          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
-      - items:
-          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
-      - items:
-          - const: renesas,sdhi-r8a7740 # R-Mobile A1
+          - enum:
+              - renesas,sdhi-sh73a0  # R-Mobile APE6
+              - renesas,sdhi-r7s72100 # RZ/A1H
+              - renesas,sdhi-r7s9210 # SH-Mobile AG5
+              - renesas,sdhi-r8a73a4 # R-Mobile APE6
+              - renesas,sdhi-r8a7740 # R-Mobile A1
+              - renesas,sdhi-mmc-r8a77470 # RZ/G1C
       - items:
           - enum:
               - renesas,sdhi-r8a7778 # R-Car M1
@@ -40,8 +38,6 @@ properties:
               - renesas,sdhi-r8a7793  # R-Car M2-N
               - renesas,sdhi-r8a7794  # R-Car E2
           - const: renesas,rcar-gen2-sdhi # R-Car Gen2 and RZ/G1
-      - items:
-          - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
       - items:
           - enum:
               - renesas,sdhi-r8a774a1  # RZ/G2M
-- 
2.34.1



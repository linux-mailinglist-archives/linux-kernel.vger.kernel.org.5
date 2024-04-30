Return-Path: <linux-kernel+bounces-164221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33808B7AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D4E1F2453B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F317335E;
	Tue, 30 Apr 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGVibM+x"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CD7710A;
	Tue, 30 Apr 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489220; cv=none; b=BLA6PYo6XQWrjQZsH3AwfttRIg85pp86CGZBDnqLQ1tfwH+bo6OTXJe2ICQDq0rokLrewU2evHm6MPrkJHmC9ceTS4UipCJpZ6vfqoxThN2lr8dNjGeRm/YNwM0PXzjzr03aGBKvliK8e0iLB5GNlDaRup5ML/Nq8SJUmt1L5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489220; c=relaxed/simple;
	bh=dwkEyrCmyrS7u2t4L2MiqdX1k32bDX8blEQpk1xIqf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzyfFXI5TN8dyf3eNDxeWfMQEUHzKgbbPKW5uNl8cLKT6AcQ7eVwiaJ2J+AIyHjHaxM1hxwT3uDg8hY4OAC5NEIcztJ/1mv8WPZ55ef9Q8XdIcJrWq3SLqUuDgNwQnETGPj8x99pKD8sf4BO2NawTxpeM4IwoeEtTe5TtRQwqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGVibM+x; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4536268a12.1;
        Tue, 30 Apr 2024 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489218; x=1715094018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sud9GSSiwXLBgJiH3GFfgiBTcc5n2z4WnRT84AW5WTc=;
        b=FGVibM+xi1lNFCrDtiz7EQk7MdvuSlIqFFUCR/fEF5oJgtoCYQOOPE1JyNjvEbBdaX
         nOkcwvwmn0jCMz0BUcBcIHeHuqfIZGn7BqtYbsadULeiTF9754lfJXrvUUGN2aDTWGZ5
         KWAnS/P59/QE5EX14OUx101POfcRb6osI+ZKRwmJj1S1q5DUWcnISg1u+LS0HOc//4OX
         jtJUHK+AiRKKQ0Mgm6XkozzNjngvDyxLp3p5sFhVbcQ7wPMNZ9PtH7LjcEBpvtXH+tYh
         gpbWOyYwdD+je5JgwdNgV6/tNH7zfIZ6gDlR1dml+RbXHhzGI7yRe2GbIQBy7w16kimA
         qCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489218; x=1715094018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sud9GSSiwXLBgJiH3GFfgiBTcc5n2z4WnRT84AW5WTc=;
        b=hd9z2quFrGggWFF6gMT7jZ0zRZWiOp1HtljRhJ9k8Q2iQ7QzB1ZXW4UYBUpLffH+AD
         w1NDDPF15QZ+GAO9pa+/27dJrtcCkFvC+MURe0kjfFnH22u7rt2fk7KNU/B0DNYXRHvH
         XHg/bvWZo4JPThHjIo6kWlvLB9XH5MFjTY8kudn5jbfmi34aRxrBM5G53fX92mep3HDT
         ijDb9XpJ/0WejIh4C1MGqxECNzz9hC1DtwZFDdDp/Xz/rgY/v4Cz9yvEBIZyex9mgP1/
         HR/O1wb/sGPHTcctMXFePUh3I+PZQPfLOdP6b2MU9owknzU9MAHTAzEm4C70oGuzO8LD
         +z0A==
X-Forwarded-Encrypted: i=1; AJvYcCWlCfcOV0S/sQmKtRqdMRbnNIWhUZIQndYY72/OQSfEL78aCMLK8JGmM2xnL4Iwh1uBTvI4PCOLxzJWrH7y60p53/SoBGtC1779pGZm7U1Z4vLq6vzyTDT5i1c9v8gmYw4T7LyLNZ9OQwr573wace+2QtBKpQksMD1znlDgTGjCacMhpAxuQa6uXPA=
X-Gm-Message-State: AOJu0YzxCN5xbtWIRBz4JQ3NOgLXOAEVbryjTtn6Xk43DS53XdgDHgyx
	iczerQvNxH+eCr2WkoEk22nTFc48O5IbO6VfVmeetb2CgNq30rKm
X-Google-Smtp-Source: AGHT+IHtovlmuUxq3c/eqtASIKg3CMhMA14a9XHqhvR72yfg2yjOab2tXrt0JLYfVkaOEY0s3V7/ag==
X-Received: by 2002:a17:90a:c292:b0:2a5:16c2:8551 with SMTP id f18-20020a17090ac29200b002a516c28551mr13018412pjt.19.1714489218046;
        Tue, 30 Apr 2024 08:00:18 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.80])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm15428745pji.22.2024.04.30.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:00:17 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: mmc: renesas,sdhi: Group single const value items into an enum list
Date: Tue, 30 Apr 2024 15:59:35 +0100
Message-Id: <20240430145937.133643-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Group single const value items into an enum list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
- Dropped items keyword
- Sorted strings alphabetically

v1->v2
- Updated commit message
- Grouped single const value items into an enum list. 
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 29f2400247eb..34e50eeed567 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -12,16 +12,13 @@ maintainers:
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
+      - enum:
+          - renesas,sdhi-mmc-r8a77470 # RZ/G1C
+          - renesas,sdhi-r7s72100 # RZ/A1H
+          - renesas,sdhi-r7s9210 # SH-Mobile AG5
+          - renesas,sdhi-r8a73a4 # R-Mobile APE6
+          - renesas,sdhi-r8a7740 # R-Mobile A1
+          - renesas,sdhi-sh73a0  # R-Mobile APE6
       - items:
           - enum:
               - renesas,sdhi-r8a7778 # R-Car M1
@@ -40,8 +37,6 @@ properties:
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



Return-Path: <linux-kernel+bounces-55158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E8B84B8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF107289958
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52A1339AB;
	Tue,  6 Feb 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QYeXOGuO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1721332B2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231459; cv=none; b=tamTtyTeat98dFDs82Nv86bFSI4VR75hvz2sTBh22JxGoTSZwb0WM+GIkFkIA1nOZv29hVa0+Pk4GbTZo8sx4duX+EiSjDViUne/iNV0aanGTHuAxiOnoOlcjbUa9L7RAkJJjTdGARBGKVDgR3GRMoDG+xpe4LkoPlTtHgRkXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231459; c=relaxed/simple;
	bh=n/iIoTt4CdIC7Z7PYC2xA5OpZKG1rRXfvCAELL/uC3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7UnNyF/yrlWnCoT7cSbL8+ZfLWc8NZFXX9xCWJzs9S1LG9Z6dLWbay4j6qVs9gN/6KErHWIAPCdFGW122wmygEsLK1K4/G4ggu3F2rEvhLv1pBpYlgAt21WDEf1enO2jNkuEIc1Ad60q7tWvp2rC6qiaSqn5GdBmz7iHgE6Tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QYeXOGuO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe2744e5cso4311575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707231455; x=1707836255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDuw9+ziqpp2LTPkuprkw43SW7UlWl5m+opLAnRrync=;
        b=QYeXOGuOB+0w1ioXBqOiwSSD2CtWuGnRrxSgxzINS/veJLsF9uKsa1d7mMpCTtWhsL
         z7SkoWVRsGmsjaGwTNkYFabIZF05pYYBguzz49LizpTaFfN5EVJeLKlNIVeh74sp9wCX
         sFfqrAZC+TkTExGTp4E7piFJYQvdmBfFoRzEw95G5+MflhWnHUFRBB5YygBBKBNoKYvE
         QoTH0gS/0edGMzBD/LPeNz/121FvAfQcAjd2tKLDsRP8ggcMlv6FEGpeSrEUG3EjK9Sm
         VJl7n0s+Gqpn2Ks8iRx32IN3vgvt835lu6iXf9U1ATdpTQhpTPcf9IRzu8aW+MCdS6DY
         AKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231455; x=1707836255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDuw9+ziqpp2LTPkuprkw43SW7UlWl5m+opLAnRrync=;
        b=F5fTYmo/2Dwr6psVeULXIMvYAAbnZpu4SCQ2MqNCYDjKHZf1sKjJW2uRa7ubv2dGWk
         qR4jAA0hYpmMou3IArf1ZipIFkYo981bqSOOXj42FnwLRYRlUsdqLU8UdA3M1p2YBvDJ
         fNqHQXlACEfwjD8HiLx2P+7moK29ZPfbzVJ0mplYXW5CIJ0ZkveL9GWw12tyQdKs/AWY
         L/+cio80CHA+7AMATymbXSlPA9LAGiDafVnq5HDEX24iCOOdKyWtpvd5fcarJtAaUAFY
         1cdkUwgciQyvKjS3NAkSPWjR+vgOFHbzmm8ez2lkFulstZDKpX5ZYEnu1lbCzCelOu/n
         oZrA==
X-Gm-Message-State: AOJu0YyH2Os6uwpTU6Zrh6hLVHd8iiEADJm3Jwebrr8ls4mikc5Xk3Sa
	C0KxQSOSvzvfy4+TLryknkpStXqwDaF02Fql7qmcGauHLb7ymm+fT63z7qkbDIQ=
X-Google-Smtp-Source: AGHT+IFWUZhvu1Op3ONCs8HKFh7ZnxQTqJbptHCczEPX0pwjlbH/88Vtvj3qlhtauOBQnzW/yDQfnQ==
X-Received: by 2002:a05:600c:4f04:b0:40f:d242:a2d2 with SMTP id l4-20020a05600c4f0400b0040fd242a2d2mr2128630wmq.12.1707231455728;
        Tue, 06 Feb 2024 06:57:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKwo1WacIy9JzhNBPozyAsTwJu42VbiXVrShxEmsJ+b1dtuf5ptoyQ6WNCuGK9OSuUIdQwZf7mgkn40vCCv7+mDIH7y010+gQUAsPFthaYQAW9bya+1AeY+zfQC4HCkEM2Cz4p0PXA/buzoPlMlhI/6ghVIw/53ddMH9CtqxSXBYe2B3fqh0fVtpnCrc/E8suY0fdZBko1Ikz7wk8TuK8v+Celc+q+JMyQkBGb0aq3F0iHMECbtnsdm85SWUI222v8vS7j8iorWTFKyqDVtzx+SlvArOaX2CFmJXgW2wB9cRKiMRbp5bJ0IiSEzsGX2MkNp3+RdWXe9UxqPubsQdP5NyMpp16q2HmAdbd4kFTlXIgh+Rc+q996g3NuG2Vt+NPl7mqY/K1yCfEuG6zTw5UQuOQG+QmDB43zMnXu7OQ+WqoBkfKREbpPutmma3UyEzW8Z6MJPXdYggJj5f5ctJ1j3wEniQ9MziAi
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2257896wmq.17.2024.02.06.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:57:35 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip information
Date: Tue,  6 Feb 2024 15:57:19 +0100
Message-ID: <20240206145721.2418893-2-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206145721.2418893-1-msp@baylibre.com>
References: <20240206145721.2418893-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nvmem-cells to describe chip information like chipvariant and
chipspeed. If nvmem-cells are used, the syscon property is not necessary
anymore.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Andrew Davis <afd@ti.com>
---
 .../bindings/opp/operating-points-v2-ti-cpu.yaml | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index 02d1d2c17129..b1881a0834fe 100644
--- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -34,6 +34,14 @@ properties:
       points to syscon node representing the control module
       register space of the SoC.
 
+  nvmem-cells:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  nvmem-cell-names:
+    items:
+      - const: chipvariant
+      - const: chipspeed
+
   opp-shared: true
 
 patternProperties:
@@ -55,7 +63,13 @@ patternProperties:
 
 required:
   - compatible
-  - syscon
+
+oneOf:
+  - required:
+      - syscon
+  - required:
+      - nvmem-cells
+      - nvmem-cell-names
 
 additionalProperties: false
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-57896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95B84DEC1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6B1F21A97
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBF6F095;
	Thu,  8 Feb 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOYBr+0V"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA756F090
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389503; cv=none; b=Z1Mp7K5sZ+Eo1F1lJM/A1XEqqOKz49Ep2VusqVFlDOWH1vVv4rW8GzZlZ5DhfpBZfRRnPaLZw3TpXlcWwL2h6ch+nxTi9bwa546pr0etI+3in6OviE4RliAsQkWSHAPonzl0JmA1RaT7+t2LPid+2eDHUcl4Y9Udtls5XTpGwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389503; c=relaxed/simple;
	bh=Y9Q33V5cNywwYcH0vQvCiQwIi8LN7bT1qcZvxh32K44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxg1Luc6tvjsRX2SAZFxO9Razzt9kKwnYe6Uy8YUs1fYmS9GR+uAbaXPBEsg92khkralFcI1xx4wpbec1N3jDYgBWqUjF4UAN3mmc+UyFfUxnnfkf1df7WZ7yT01YeH9QZaHZMtxJZnWHFMJiO0OBjbg70B22eSykOFCavryfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOYBr+0V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso13175575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389500; x=1707994300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZtgzLYcaNK4o+LXBfW80EZbVjpcp14R9fNv0eJF3dE=;
        b=tOYBr+0V7yj3Ov9DJaEvsXXk7MghBUWjLjcWNhstrGbEDyhqBMUGPQjp3J7Si+eayN
         HGBdDIM+lsTRXv6+GboYiJMHwIVJoeeG2gu9nXrEXAEri5ZP6D2Oc88F5iia7yomSnnd
         s+DEVlO3ciZY4TgfQKJA1DDbiNtlO4xXtC1Q24ZfHj+aDh6ZbUy0hZZAyvuOQSF7/e2m
         WeZ8Pf+CuYNfRd2WeLFwB4cQr0zMialnsy6AR/7JEwrH5OVdK9XSCyqAG/TqUFzF8gr4
         wCcmo2kAaatv8U1HPV4eIbalrbE9Lc/iBnirmOM7P2ua3tMLwSMPQgi+Yd+TXbzk1Cwf
         0d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389500; x=1707994300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZtgzLYcaNK4o+LXBfW80EZbVjpcp14R9fNv0eJF3dE=;
        b=vZ3nGFj6IXJWFxCk1SY8J2okiiTW8gDiwvwR0L3TWF6c54SKUwb5+17Bw6KDRikOQ/
         gu0ssic6VyQfgwY6p+8SefcS913RmnnV1DwMqBicgpiG+DyywOr44DTv00qUVjXTPoa5
         u7Nj6zq2iaGW/AGV798qKEcD3G4rsYBb8j8kdu+g5dXxINvBIb9cHM473jB2aWFyW71u
         cwQzQtSmA13fRlNySUkVg/9NkHizEetket2pT0B5Oy/ZueToj8+kysySXGZfZWE+p/PD
         s2Lj86FdAZT7iIE6aVooWfaWSoV88LFr5Vx2lFuyH5nM+DXCeWsjtDGEiSMAWsuCwWGR
         EocA==
X-Forwarded-Encrypted: i=1; AJvYcCXya/H9a/nkQjz0/YkwJzB5RrsbDFPxys/jvlDLdBuu9FjAXTVx7E74GqZckhIV7bRT3pfT8eTNB0dOi4yhSIMNCYn7MR5kexnMuWRI
X-Gm-Message-State: AOJu0YxWHYRpSrTvXwXZBcEuhLiIid5QH3NSYnc9a+ii2I1J0CyB+mDM
	uxKf/wg3UgGgPU6hW3h70ahlxdsM/xYom+Mi6J2QrWkmGXiVdgX28yYsPgpilIc=
X-Google-Smtp-Source: AGHT+IFMOeiw/F96hswvrWfecH89o6R4+EF/X6GTU7FbdOnQNhlWxNaRnfD7EWEkNlclgXNhnpJbow==
X-Received: by 2002:a05:600c:1907:b0:40f:b2aa:2da1 with SMTP id j7-20020a05600c190700b0040fb2aa2da1mr6496530wmq.7.1707389500373;
        Thu, 08 Feb 2024 02:51:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTmBgjmLwVGXqnbORfl0cRsyU1iQ/v9wchcMGCeFgo+VnGOYSoIpV8i9duVEB+HL2hpyeQC9m4rPffauuyeAwl8U5ZTC/agtfBw5+487bJo8lESjmeehzAHd7+dqPp9/jJyNxiLpGMAYP+b/oB5bBMomNq7MNiUzIh3rH1UrghsBErd7mbIJl5YKHLf3YAFGOghzdTiwXwvoFMlAGsl5e1LOa05EibzuoRTaGiBDG6ddtQKQ3XQ8N+Fa8ZHNIScmJDozyXjCvS
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id bd18-20020a05600c1f1200b0040fdb244485sm1272451wmb.40.2024.02.08.02.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: sprd: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:51:37 +0100
Message-Id: <20240208105137.128601-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{'
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi      | 2 +-
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index e27eb3ed1d47..2b8867fad285 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -113,7 +113,7 @@ CPU7: cpu@530103 {
 		};
 	};
 
-	idle-states{
+	idle-states {
 		entry-method = "psci";
 
 		CORE_PD: core_pd {
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 6b95fd94cee3..de468189a4fb 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -24,7 +24,7 @@ aliases {
 		spi0 = &adi_bus;
 	};
 
-	memory{
+	memory {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x60000000>,
 		      <0x1 0x80000000 0 0x60000000>;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-60463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90887850548
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0DCCB23259
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3365CDC4;
	Sat, 10 Feb 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="AB17Nc0R"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB82B9C8;
	Sat, 10 Feb 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583151; cv=none; b=LFLaaWfwCZ24O+DVpOjDdS3ZV53bEvIlCQPpJa2Ws9zXjEX72ve6whjlzX8CfdKzi/ZYSkpEnVD4aGzvPLevcrZezbC6e4XUolx+dAY19ZGDugD9TJLevcKkhcooMdWs5Iv1mDCM6cjvSBz920YO8N05NKoRzvb9oBOZYlyBuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583151; c=relaxed/simple;
	bh=Z0ejz2Z7KadDW8L5DtUsqa9+gFcYsfukyK6vqWCH2qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEE46Lp/Qa7dxU42KkJPIUMe7ZE5NeoJ/53g9afM3MqKfonuU0x5nyG1l9TVJR+/rDriw7lj0g2SQdH2cb1wgLyalUPVAc+7NPo2XNzhT0j487D/cJeC4LzuwBtkQiFpq6mLa4nmtsFoLNmFKUdttWuVolh2vswdfU0tx8/MTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=AB17Nc0R; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707583147; bh=Z0ejz2Z7KadDW8L5DtUsqa9+gFcYsfukyK6vqWCH2qU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AB17Nc0RmHj3klVKrj1IsNpUmIxZe1/kCy8J+9uD8jij3g8BrFptG/atwQ+YtT+13
	 TqPrzdhEchku2RKuqLBfNJ63eVeUD+DOxSNYhD3UJZf17PlsFB0YL9somQTfy3TQvW
	 57oBxNISDh0HURSA4V6p1aOrS4cgtcdp5QaR9huU=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 17:38:56 +0100
Subject: [PATCH v2 1/3] dt-bindings: power: rpmpd: Add MSM8974 power
 domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8974-rpmpd-v2-1-595e2ff80ea1@z3ntu.xyz>
References: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
In-Reply-To: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Z0ejz2Z7KadDW8L5DtUsqa9+gFcYsfukyK6vqWCH2qU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6aoRiRisauepXEiWVHnu49b09eKAS1bnXrX7
 jEvQCBqlRuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcemqAAKCRBy2EO4nU3X
 Vr46EACLtISs42mjjGJW4gCRA6r8/lZm3z/2tG+WrUKm9zBrVWLiXv1o+JEccOM4g1BPUv/fqyE
 +52k7YixnX5fG6yYrT+SbJVqcCahMqZEdVZlZ2zLhDOk6xIg/RXc1NCOzXaZuL3VraatW+63m5Y
 pNLeFrhGYsijhBNoFczuMOlQY7RfG78R06GZK221OWcXn7wUrEnoJVy8WvhNze9Gt9B3xRQ7kNE
 ffvZVRDvQJ++pEG9EwmHprPQcYsKlHfw7e/1GAgEl0r/vwzpJdcGc9sb6+0Ly0/43gJ/ru+1eJ2
 ObFTS/a5fPAt82CthnAb4J9CgTr9G2pCzElf4n+noJGR00/2xrk2vRVSvlSSXk9VxjaZyXWyrio
 AyG2d4IipBbErgKEnkNjUzNh9XOM+kodStb5Eo1dHuVdUir2qY0ZY41euH+TRZV81XWKdBzlCJ3
 15UYpjEVtJII5+3k/GW9MNSIjtzNmMGhW2MDraqzqavmysPqdxMuzEhX+SRmn59owTj/dm3UqC6
 yzCGYWUqcPHW1Pb21D5WDk5YXw7DT5zi4UBe72eeAEwCp56edc6/x+ZW+c3+hIc3xCwNLV1dZqT
 drKZa/0PEzGW0Sx0IlI5npSpSEHxyoHTYlvq5ygn45FTAxt8wfgIQtPeT6+hyUMdLdrw1oCoOsC
 tyRDMnl0QwM9Pdw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the compatibles and indexes for the rpmpd in MSM8974, both with the
standard PM8841+PM8941 PMICs but also devices found with PMA8084.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 ++
 include/dt-bindings/power/qcom-rpmpd.h                  | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 2ff246cf8b81..929b7ef9c1bc 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -24,6 +24,8 @@ properties:
           - qcom,msm8917-rpmpd
           - qcom,msm8939-rpmpd
           - qcom,msm8953-rpmpd
+          - qcom,msm8974-rpmpd
+          - qcom,msm8974pro-pma8084-rpmpd
           - qcom,msm8976-rpmpd
           - qcom,msm8994-rpmpd
           - qcom,msm8996-rpmpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 7f4e2983a4c5..608087fb9a3d 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -308,6 +308,13 @@
 #define MSM8953_VDDMX		5
 #define MSM8953_VDDMX_AO	6
 
+/* MSM8974 Power Domain Indexes */
+#define MSM8974_VDDCX		0
+#define MSM8974_VDDCX_AO	1
+#define MSM8974_VDDCX_VFC	2
+#define MSM8974_VDDGFX		3
+#define MSM8974_VDDGFX_VFC	4
+
 /* MSM8976 Power Domain Indexes */
 #define MSM8976_VDDCX		0
 #define MSM8976_VDDCX_AO	1

-- 
2.43.0



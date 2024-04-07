Return-Path: <linux-kernel+bounces-134317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219089B03F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1DD1C2099F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E72210FF;
	Sun,  7 Apr 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="BEU7aTqj"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEC182C5;
	Sun,  7 Apr 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483946; cv=none; b=MJdj60qZ1TXvhyBWnXIjzkXMZQWSzk6nUwHAF10aT2AqbjYsqTNauOSq8cPPaU5c1LPt+ILUFX1R6bBlVt46VTT3bqWpyBEh8Y9dmFiyZtgDN/alhIF9SirMhXZA67QPvA/9Rm3QqaWAtr3VhLYPnwJQMD/zs2xA6P4KpUOkk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483946; c=relaxed/simple;
	bh=hEn5KuCngulRuFJMxWsYDUEkMcFBFdCbgV7etqkL83Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcXv/ckj2UPIcJ3puiyvpcqx/NbwP3hLmlUYaWewIzM11NWDrxwTqFvtFibPXFjK5rxqQgDjlC39iwjwRyJ04KuSvJNAvuqOg2CmH/e0hftjwAISpE3/JMa2tq3f+wtT8s3lzAY7UDswIt9l92CmOLZY+wgG1r7VErA8bvS7d/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=BEU7aTqj; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712483942; bh=hEn5KuCngulRuFJMxWsYDUEkMcFBFdCbgV7etqkL83Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BEU7aTqjc3rtebte69IGb3+z6Uz1k5whz+mwyQRtZpHrPcchCEvqmFUyJobCQ17fz
	 YBkkS3PJ70PuWNKwrYr793zD/NTGq1BFAdaiqANKBoqEDO3YmrFd9HilA3QtPfJQAb
	 TE+w1VmQZcw1zgsjfx1zSXk1a9rna6k2lJDG09zE=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 07 Apr 2024 11:58:32 +0200
Subject: [PATCH 3/3] dt-bindings: remoteproc: qcom,sdm845-adsp-pil: Fix
 qcom,halt-regs definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-qcom-halt-regs-fixup-v1-3-a0ea4e2c178e@z3ntu.xyz>
References: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
In-Reply-To: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=hEn5KuCngulRuFJMxWsYDUEkMcFBFdCbgV7etqkL83Y=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmEm5ke2yuYjMeIg+qdRpSzS5xbundtHacGOgRK
 qMRv1LUtD6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhJuZAAKCRBy2EO4nU3X
 VjXHD/9GYXBgKvBVXEb7vQxl/PdN1gu7j104J148R24dTrJvlTa0iVLB41oIO/x/kMtwdmhz8PX
 YTKA3MI77zTItBtF4CPDiPYtxpOXz8Q4gvjlTZoLqnExasP1aaTW4yQA6Mjrnu2WDFponfFLhyH
 76cKI0LzLZd06co4+aB2oR6lo0h8bTofWHrYvD4yf+ILqTtJFqYUq5i7FyVejIgeIRzFYUEc9Bz
 vZ8ulKuEi/bzdMG6xGHIJhDbG3ib1B91Npw9qga1UvQNkVEGt9e8pqi2e70b04WFmKjoixOK0Nb
 XlJlg1+FCx7yiGKKKsugYWD5QBOzS6pzJtAdCr1N70mICKYptsj9X/cjXsTGNZvj67yCwDS2aWu
 kwfW7dTtqLI/Zs1iTX5xeU0y69b7Okg8ajFXrkBv+qNB2B0WPKWVvXb0rDynQS+RIOy2FqdkIbQ
 n8WMDsRE6jm5P/mJQRfOaxKPDBQ2tYOxErMvTNXa0bcXGEXpkDhh4VPyqsuPS4934/wSB1Qx/LG
 3lAqbwg8VtB4aBExm4or8HroKHDB4U0FhE3kPb5rXAxbIyJAFVxm1alP1JNev1UWhaFxwhacphy
 GZUdVfut110mKzML3xI20lqARNfAP1SbHdeNgqzQkTOnw7DPiZxspDvkGKE+wlWG0kRksin6Mm2
 e9VQuoBtYKYvFmQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Set the 'items' correctly for the qcom,halt-regs property and update the
description to match what it should be.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
index 20df83a96ef3..a3c74871457f 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
@@ -81,7 +81,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
       Phandle reference to a syscon representing TCSR followed by the
-      three offsets within syscon for q6, modem and nc halt registers.
+      offset within syscon for q6 halt register.
+    items:
+      - items:
+          - description: phandle to TCSR syscon region
+          - description: offset to the Q6 halt register
 
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array

-- 
2.44.0



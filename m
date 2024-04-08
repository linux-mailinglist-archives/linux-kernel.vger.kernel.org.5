Return-Path: <linux-kernel+bounces-135873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD789CC79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C3C1F251C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FDB1465B5;
	Mon,  8 Apr 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="yh4zZlrK"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA34145B17;
	Mon,  8 Apr 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604744; cv=none; b=AXMGI57zvo6IVqcWJnUk5pwQq1A/tlOPkr5CG1rhz9JaUrbnz1LonNYXNDxOTgfiBEKgZ9QVm4lLjaLLq9/DCLb2ZGmTjrFd6HMXGaLcoqKncxBHnPa/4RNSRPisyRL2AUM23vS7sUqhgtZ95XqS/ua/4ayDctYzUgsMHLTbd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604744; c=relaxed/simple;
	bh=Nccis8rsaBck9fRu/CatUT+VUUebOHkgbYvovF4nZ3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNuymeGuDWXaEWb7erwGzA3cGfMpwaMffSr2xuEaQU1ARlOMJ4J/F/VBpYR0PzyfakxycW7stjH3Xupk90C2FoSdUma7ZYD9kdEQ7YlmpGpoN1AyALastL3KoNXaGDfpvr9e8ZVgyhq7sxwmH8MsTetUnhPrKEm6zJWTG6oQWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=yh4zZlrK; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712604740; bh=Nccis8rsaBck9fRu/CatUT+VUUebOHkgbYvovF4nZ3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=yh4zZlrKcOKUuruJ745llOOpJYWzwqF4t/9fnDiVVtnYCBuRkEBqfWCmlSJk7rZrr
	 nBhM0f2gzyeLSRJuV1Zqm34CwCZt92AmCiTF48jgVWJqfnbKvWUKDwYYHGq04lGM5F
	 EE2M5du0JBaWy7cO2ejiny7TgoaTdR5HTO+OdcMc=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Mon, 08 Apr 2024 21:32:03 +0200
Subject: [PATCH 1/2] dt-bindings: mailbox: qcom: Add MSM8974 APCS
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-msm8974-apcs-v1-1-90cb7368836e@z3ntu.xyz>
References: <20240408-msm8974-apcs-v1-0-90cb7368836e@z3ntu.xyz>
In-Reply-To: <20240408-msm8974-apcs-v1-0-90cb7368836e@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Nccis8rsaBck9fRu/CatUT+VUUebOHkgbYvovF4nZ3U=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFEZBBjwtSDCjmjKAyEKXtgGVDOEURN04C83op
 6/LDnF0F9aJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhRGQQAKCRBy2EO4nU3X
 VuAzEACygPzVZE1hC/n2HuL3hKa08RRERS3Cw63C6cudFU/KgwykUNDTCjhAPQP9OEPrv8tQJwS
 eYs5ViRgJaUh9wcxGWwU6g/3KBW6H0LSrIe9NK0TTol7pJiJyCoFFEfC6Y17GwsH1c4E+sNbk9H
 06gWTlrZv2Nu0bozdqBIgfkvnZe86FcX4OcUO8RDvf2exVnwl4lFNQ8SpLNtPKgT5kdOPmkZkb+
 S1PRhq4C85u0loESma6nUAYsm/yq2I4MgKJGF7hekxAJ2NbQwc5oAJzQnMMaeQDGNosS7bLgX4M
 52JUusXAwadT31d3kwgCYzIMJvBp2X7Ro146iV5btDd8o4AqlAixnSr6Uxik00/3myafvblX+gK
 fznvJUd1FzxIOg6WCj+qgv3t3R8cIt6Jy0o+riJxzdO8mZuLy/Sbfi1LqhUwSR2HYng422LEVTW
 N46XMZZz54fYOcIrOIajcTnvmplbjpWAqm1+xjyNV9rGReOmuDZBaLqGv7z15elm6iKg/Crwgbw
 eiSYhRAWDoyQVrT/N0LB2sTVZ1+I+uuDDnwrSYm7OuhCy+U4gpHGJjmi4opwShEWr87hn/2vxtt
 ct/AZmLoLcB2COSEyN8o7ACyxQCsxeSXsi1o6J2i4R55rjLHoyCb+klZetSmSYp1Il//LjNIzH2
 3sh9YlOER06qeoQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add compatible for the Qualcomm MSM8974 APCS block.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 79eb523b8436..982c741e6225 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -30,6 +30,7 @@ properties:
           - const: syscon
       - items:
           - enum:
+              - qcom,msm8974-apcs-kpss-global
               - qcom,msm8976-apcs-kpss-global
           - const: qcom,msm8994-apcs-kpss-global
           - const: syscon

-- 
2.44.0



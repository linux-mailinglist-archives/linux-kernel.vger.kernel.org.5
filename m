Return-Path: <linux-kernel+bounces-155842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92398AF7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9E41F23BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2BB142E7A;
	Tue, 23 Apr 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANUt1QpM"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1514264C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903589; cv=none; b=Jsa48kWYsu0ASlAtUppxsbOA1Tme9J6STVJFQEpR8eEe6lR9lAd2pNwIBEGiWYtCrRQCCaVAtWZs1+dFoJzrT26Gofv7sBPenUdLnA8lzIJcENmb9c2FyR7qLd5T0m2jlktoN/ydoYNLKu6I9VMg953BeRyrnWmtPvG4ex8TWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903589; c=relaxed/simple;
	bh=3CzwqGzDuhmrqft8+3cpPppE4Eh6d7hkdadYYz33FRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0NI07zLO9T31i1tWjEskSI9obOgOonzXhGsAkGx/h/LNSLiNYdV1Pgf9Y4mu63m/tvLggUGYeioVL1aGaj9Wv1whsJfnwWBfN+dTd4HinC5Pdnp54UDbluCk8pX8TvHcr1YjNYOxKuW1jBXkS3QDxGAnR5vdkti0eRNpnMrp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANUt1QpM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso4875472f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713903586; x=1714508386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZh4v0xh3rOUzx0lgDgNEZWx3gWz2MaFaaSz5XXw27A=;
        b=ANUt1QpMAnAwsan6YBcAFIWwAHC49enP4KASWbSVjTA3F+hXc109Ns/GD4IcHvsglp
         8pUDJPSGO2Wx7X154NGQ0RuiuBxhgMYzZvd8gLtv2EC4F9ESZfM06A3bysumKICrTjkn
         4o66Dfou3h7Er4r5GAzdUBDdAmVr4cL8xr9xqu4mAoVgLACXrxWZqadISh5DcDwIcB5C
         FpZxksy4Zidl7I6A0s0fgzvpMT8zpO+mtmkcLKyET26gaTvNHRj2dZYWrRmtd6toxES9
         lYqWNJXww4IUFPeRi5fkQJ3UD6gCP0QJXG7AaLnYL+6+kwYyZ50Jvxlx0I3dCkm0V0nW
         gg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903586; x=1714508386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZh4v0xh3rOUzx0lgDgNEZWx3gWz2MaFaaSz5XXw27A=;
        b=ScsJbKeYnhtpSD03fWKe7ol1U7RjFNeBW26x98x0yaZ2olbvNqzIJlISW/Q0soJgQv
         AkgwcT5EuKeE6gq+nFxwonaOrjhqhVNwItQ4ajzFc3XdBfG33igChg234TDQVan6NklV
         CoZ0uuC3/Rdo2mKs6ydZKvYlvGJgFPIIfxTV6j1rt+PAihSkxxRxJmUlgOHkbvDesxxw
         o2p4FX86Qyix5R4G44zrniJWnrYPc6I+6CfHI9XbLtJUN83MEdPcmFAjaFVQXpPmpKxp
         UscK7me5hu2yx4UWqAVjnMrSr7jd2dyn4UoDk15NPga4LmIX4R8Fx6YcK4W9ENJij90T
         4cZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo8+Dr2E66hmPZFOwvMa4ZtxDpxpr3U+jNhvm48thlPSHosHxYA6aRSrFbIsW8o0l6OVLoZAwuOA2zxu2bDmrxBRIA/FsyGpu/MOLL
X-Gm-Message-State: AOJu0YwiqaYjA3RdQoua7pSjGnC1v86dtWvwkXyg2W7gjtxRtzk+pouy
	wsL9iTylZbbwDMu36YIwHE3B3ELOL8Q6D1/dsH1h5PvV6ssyDUWWy1Zo090zF20=
X-Google-Smtp-Source: AGHT+IEVk8IdQBDdbt+6eUNjL8ZwuM4GtjoAlH1F78ZTMRMT6v62264S4wc8kya9gMioEKJPj3KZJA==
X-Received: by 2002:adf:f18f:0:b0:347:2055:f49e with SMTP id h15-20020adff18f000000b003472055f49emr183121wro.33.1713903586677;
        Tue, 23 Apr 2024 13:19:46 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709061e4700b00a52244ab819sm7552431ejj.170.2024.04.23.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:19:46 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 21:19:45 +0100
Subject: [PATCH 1/2] dt-bindings: usb: samsung,exynos-dwc3: add gs101
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-usb-dwc3-gs101-v1-1-2f331f88203f@linaro.org>
References: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org>
In-Reply-To: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

The Exynos-based Google Tensor gs101 SoC has a DWC3 compatible USB
controller and can reuse the existing Exynos glue. Update the dt schema
to include the google,gs101-dwusb3 compatible for it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../devicetree/bindings/usb/samsung,exynos-dwc3.yaml   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 1ade99e85ba8..2b3430cebe99 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - google,gs101-dwusb3
       - samsung,exynos5250-dwusb3
       - samsung,exynos5433-dwusb3
       - samsung,exynos7-dwusb3
@@ -55,6 +56,23 @@ required:
   - vdd33-supply
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: bus_early
+            - const: susp_clk
+            - const: link_aclk
+            - const: link_pclk
+
   - if:
       properties:
         compatible:

-- 
2.44.0.769.g3c40516874-goog



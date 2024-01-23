Return-Path: <linux-kernel+bounces-34866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD0838880
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576F3B2242B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41156775;
	Tue, 23 Jan 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR9PPjrK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9E56478;
	Tue, 23 Jan 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997209; cv=none; b=X7XrT9HfiquscC+BdtmdiSKfSXjXXHna2Qfj4u9D3FtQrO5N/rhTPLHndva92VTHGplMoiUfuQ6PVZFJMMIZ1KIzvMZo5SmZLYseXu7YdAIAp/G0Hgn/UB3BTenl39bDDJhK1SfWsXizoIFxq8ms42jeFQ/hE+VtOZTyFXvhoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997209; c=relaxed/simple;
	bh=9lxj8u4aDM7kKtk7HKEsPhYcu6NOgcXgkGng+hS9kkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWCdtKnZNXsucNtV0TKLgrez04D/yfX58UOCbWcTRCSP9yQzfBaU0i1benb5n2kS9vMp9Q8fxIpD3oB4pJxPfwsbbY3fL6s8HSR4Go9Bx9G4Y1e34Yz6B1L6tUWaL5bBiy82/q1fKGMXIX/ieLDMCTKWhCpT88CmipV2o4/Ljm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR9PPjrK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dd7c5437b0so177174b3a.3;
        Tue, 23 Jan 2024 00:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705997207; x=1706602007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=JR9PPjrK/+7L5aM8HEOqHY1vT23G7EemkNQmZjt1+ydYDcoLoIJFVdDSs07dJ33wTb
         3H79mzE/hpcdba+69AiYYIUq4oUQEvlrIDCJ5JqMSRg9Txx9m5TbjOhnSavts7AT7uAz
         Kmaxl1qc/eq6jfFsfwvgYuy8CgTuYv3iep1dP2Tu/P43jq5h11fAYXvKreuhP1Yt7c9T
         pRHUn/B8eyCQmIsjd3IBaiL4uPVfmX1SF9hKw0hiGbef8VOjcvRi2YD3EcVVo5vzSL+A
         9+mKxQyE6heZHlyEaGsWbr1vJO/yGFaDR//TTEa5MsbH89p7HOrp6QicLAx/1MyzCyU8
         yuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997207; x=1706602007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=h53hG7Jo/1VOEw8yTDgP3Vy7QeBVKhi73lcMvdLU0zmzlk9pcQo7KMI3AJC2fJAaot
         69BFbuvAZBzMjiqrklC2o6uNU/ME5ttX4pG/OPZ49wv22G4BAV5h/GLJGN8Y1n7Ckije
         UhymMmnZjR/DkVlzmCx1O0+w0kiiWJeUOGyBMVqQkXZTuBY5Mt1VKPSm0onx8BfYPeFn
         2trtPz3X1CizB6ZaOG/wIXm/sRqzNS4fMMrH5j9TY2j3z2fE6M00sT+S6k8S+fPe6WwF
         epsMV07ndUVCzfJzV1oUfhHF3dw0VM7nLPZrK1pHx2S+XdguQCZ62e/kQxqSrICQH4qe
         8S1A==
X-Gm-Message-State: AOJu0YxiWFmnKyEj7xy1cTdYhl0xyw7p5EJImxWpiRp3smm2Joicg/Ps
	NNCjgbSKQzlje6GxMSFPWoqIy1mWuNz31vv8KQLcQ7LtMQ7mqzxO
X-Google-Smtp-Source: AGHT+IFTbqBkk9UCtznJ7k18XZVrJ9VPUSU+XpStrngPQM6qoGg2Lrrz+Kg+3EO6/GOmj9S2v5w47Q==
X-Received: by 2002:a05:6a20:47e4:b0:19b:624c:c7bc with SMTP id ey36-20020a056a2047e400b0019b624cc7bcmr4564695pzb.118.1705997207302;
        Tue, 23 Jan 2024 00:06:47 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902704a00b001d4816958c2sm8277113plt.166.2024.01.23.00.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:06:47 -0800 (PST)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management node
Date: Tue, 23 Jan 2024 08:06:34 +0000
Message-Id: <20240123080637.1902578-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123080637.1902578-1-ychuang570808@gmail.com>
References: <20240123080637.1902578-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add a compatible 'syscon' to the system management node since the system
control registers are mapped by this driver. The other driver must access
the system control registers through 'regmap' using a phandle that
references this node.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
index 34c5c1c08ec1..3ce7dcecd87a 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     items:
       - const: nuvoton,ma35d1-reset
+      - const: syscon
 
   reg:
     maxItems: 1
@@ -37,7 +38,7 @@ examples:
   - |
 
     system-management@40460000 {
-        compatible = "nuvoton,ma35d1-reset";
+        compatible = "nuvoton,ma35d1-reset", "syscon";
         reg = <0x40460000 0x200>;
         #reset-cells = <1>;
     };
-- 
2.34.1



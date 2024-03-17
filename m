Return-Path: <linux-kernel+bounces-105534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D9287DFD1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A3B1F21226
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2C208BC;
	Sun, 17 Mar 2024 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFjzbFHr"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C721EEFD;
	Sun, 17 Mar 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704878; cv=none; b=gz0MTojXTwuFoZWRRoMxqijhzrfb8JFPrRLjCfvv4azeN4FzlM0YGNFiV+UsweG6KmFxrou3ldCzaQlNMKUN9LSe9ieKtM3bocod8X3uZC2M/BXi44WM4HU0aNr78bMx29zECn5uzRD8Zr0Wd+d/HEpjKbSOmPt516xCyW2QmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704878; c=relaxed/simple;
	bh=tAVWYYe9dpkSRvGr9SnXb4EgP8xnjDbkrGFp/vqltQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBpGCn5RhURrcjAojT+OcGdLTXMF86By2l6UQduvBIZi4FMP2zhazrSOfa9U6yIu/lUItKFxNjQx39LW6/nIFgjA2eAegmr8xneYN0pNvEgKd8K8gAH1TNn6MWeVMqP1Yw067ioC3/w+5F6/UisV7teLUNZz6yANG0L5DOBwWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFjzbFHr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56aa2beb1ffso24470a12.1;
        Sun, 17 Mar 2024 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704875; x=1711309675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2WVTygkXOkhQKlJ16ez8Cadly8Dz43/RCcghJb/HIc=;
        b=IFjzbFHr4GSTl3FxTlCu7s41pEc7JwvAznLUtA1dZkJYkT1RQmLHGIw00TipSXmz6w
         JaLA46dns096zVZn5IPW+tslfsNY07X9oR1u352Ul4Mf9nEnZSQkq3CRjvC3zKd2cuFC
         ogunqGHyn3//faQHB9EZOuePsWcn1viYKx74cu+3KS56YwDmQ1BEhOPJr5jaf5nt0xwT
         AHO+TAwloIJ769XdyMXo/syxVoiiNMowIR0J+Sx1s0VIvjsLsJ7egDGWgg0vb3PjLO/A
         ZYcD/9IJysOOrR1fcweUnajIWQ1ITCkSuhjJ8WAeuXQHFGsOvaXNUQ9azIP39rLJBgux
         D8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704875; x=1711309675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2WVTygkXOkhQKlJ16ez8Cadly8Dz43/RCcghJb/HIc=;
        b=buBVVgrbHSY4FRtFAlVkqx+V7/dGwh8i4oAiuJsgHhUZwrcM9dteRLhOi7kQSh21k3
         QFVOX+wgvJ9IyxD0DmtwHoCJH6mHlOncltbZfHQwuI21JrSCmvhgxPAITN32q3cF3gO4
         DuCiUklMbFJ3E1ij1ZkfUpQcGTD7GE07qVZnKgxi602+i8g9L6xhllpzGMeGFyIFyHB4
         4vSGOkLVMtCUpmq0r4Eb92FYQMjpk9DKFo62+9U52seRtgGdGCmclEhQtpckJG/FW9y+
         yXlCCnVBN0rXsNzNUODbq2gRnFBMlJVXEY1D46FuVU0VdLlX5O3r1G75c6+siqdibUkX
         u1iw==
X-Forwarded-Encrypted: i=1; AJvYcCX8uAghkX7PQiofteRunjegUOc3LZ1E+gjekwuw4cB3VQppjmtDSe36Z/Tif63qUcHH2b3joyTgCTfhvfUxswnC6DIjUh0+Y3o1ivjO
X-Gm-Message-State: AOJu0YxLqJIKVR1OWSbzuXclCFMtuzc51/bphJKWnbfte4dh2FBy7lyI
	QReGoiteGeY/1rImtmURQGmTafcNCLNYrbrPhGrN6ZsYJLRzo26A
X-Google-Smtp-Source: AGHT+IHp7mCzbQyCsHrpKahX1dBIPRwRQebxkYul3YQfTo5zZuWGAfF6r/KqoxX5oyAjRqBRwUKPNw==
X-Received: by 2002:a05:6402:390b:b0:568:c3c5:4641 with SMTP id fe11-20020a056402390b00b00568c3c54641mr2012523edb.40.1710704875118;
        Sun, 17 Mar 2024 12:47:55 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id i24-20020aa7dd18000000b0056ac092a7fasm8234edv.87.2024.03.17.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:47:54 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Sun, 17 Mar 2024 20:44:50 +0100
Subject: [PATCH v3 2/3] dt-bindings: arm: sunxi: add T95 AXP313
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-add-t95-axp313-support-v3-2-0d63f7c23d37@gmail.com>
References: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
In-Reply-To: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

Add T95 AXP313 TV Box variant to dt-bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..6fe137605ba5 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -860,6 +860,11 @@ properties:
           - const: allwinner,sl631
           - const: allwinner,sun8i-v3
 
+      - description: T95 5G (AXP313) TV Box
+        items:
+          - const: t95,t95max-axp313
+          - const: allwinner,sun50i-h616
+
       - description: Tanix TX6
         items:
           - const: oranth,tanix-tx6

-- 
2.34.1



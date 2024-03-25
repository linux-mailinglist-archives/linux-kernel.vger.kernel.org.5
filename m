Return-Path: <linux-kernel+bounces-116918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12A88A4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C2F2C55E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905711AD52A;
	Mon, 25 Mar 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXcJkJRl"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DCC152184
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364998; cv=none; b=VJEdyxfIscozij37PJFcnyBEBqs77XUUFJVi7oKz79i3vLzx/8CMJOvdzwoN1llIjrdrUtPOTsi154ksnHVBnWeg8nHSsv73c3uA54hyt6HUi3k8IHxhCiZaZ5TdFb1Ig/jSyObArINVfCjsqMFQbRG12fJqZQQQd093iSTRrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364998; c=relaxed/simple;
	bh=N3wP+RQ7VRT4++7kCDqamWluNf4gtoR05YTHGQbChM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hB0Rl2fFJwJkN0JfEEe5ld1RY0zEkATgqVYhTo2riqLljkl6c1xZ5R3KlJvSkNvzA+C5IKX0JKnB4+3p5PPE1m2nlCzdkqsiYA1gRYX76vopuh+Q2uEI+MU3vNK4gxr2nQM7OTR2AZqmVng/WZluZ38KC+wsJyNG5j9K/8rbNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXcJkJRl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ba938de0so568572166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364994; x=1711969794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALpBomvj7h++qduRiPAlY6JUwZx9tyV38eEVHtgwhRk=;
        b=bXcJkJRlq28zDAt88H2fE0pJ+Ft/mwaIq/xRRuNrtFsS+vpWhz2A0ceVD8KRg9hyZo
         baUW5l++VtNZ5nMQqmoxa5VOhW7lTg27PLxaJS7DiG0D5SpOJTwGTb+N+m2uZ1iCfxnF
         gUpoCBi3ZCmx//NKkjyDDqSZVJ7gWMYpVnQcqU97Dwp8xPz4iBknsnvnPsE+OA99dlJ2
         dY72mAQOfMMPKbdVtOPZU9ZbF6I3ExImv8vvdnerUJujO6Gotgxx1QjjF8cyV1Jz6khi
         tL+TT5/dBubiyK/OMbwEGiPrn1ZGMJn8IeAVcYaY29r4Q3IQ4FwE62mWIDb7BBXv/L5s
         yMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364994; x=1711969794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALpBomvj7h++qduRiPAlY6JUwZx9tyV38eEVHtgwhRk=;
        b=jQc/g9Zr0+Z26VOQb7Jb1hhd9WAtIlpyWImt80LTZlWAdW/yCSQMkfqjBb9OstugrW
         Z2Idvb+HaxE6KrdOsaamg+Cyuo1czbn1/B4r5KuM3BdGMZern1iA953J9cY4JV3OW3Jm
         nLa5HRM9tf/Wkh6cBPICMcRm3hiNe+BsCD90PxEWgBzii91HDl1p4VsJfzRBVABitNxD
         RvPbkOqkDqElh/8IFeQ3tq5b4/OhTGE7ad4e3vrYNhUqjPrI9539PDetGYxDBA1gILo2
         Tuath8M2h2a8QpITZE2J/ZQ4o3193r09RLfFhQqbF2/efuzVFVM86IGsKa4jP6hDlAR4
         dUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKJiTOO2AJSv0cJ6vTy5YklRs7/rVM47Kfno4JnPj6ztnlJKoBtvnF2UxgW2V76bc5fY0wCdxJ+rl8kXDxo5dIsJ2SBVVyO+J2k3kx
X-Gm-Message-State: AOJu0YwhqFFkODOOyOsdKrCQa/a2Inz8wQsQKKnbVUza0oaIcqzCMmRQ
	0bTjbgxJTZpYgaN12ZlD8++Y5wFnYH8vZtXJrQ5+EvBaO3cA58mZ7Tc0Uebo8VjqGIw4bYCYgih
	cTYAzDA==
X-Google-Smtp-Source: AGHT+IHTN6DQHKMcMFkMHcH41yhpPoygiYbtAqR88ncB2YWUNCJzDz7yqSQ1t/HPH6gmW2ko0LDR/w==
X-Received: by 2002:a17:907:a088:b0:a4a:3403:343c with SMTP id hu8-20020a170907a08800b00a4a3403343cmr1950743ejc.31.1711364994351;
        Mon, 25 Mar 2024 04:09:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b00a4650ec48d0sm2972367ejb.140.2024.03.25.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:09:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 12:09:47 +0100
Subject: [PATCH v11 1/7] dt-bindings: arm: amlogic: Document the MNT Reform
 2 CM4 adapter with a BPI-CM4 Module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-1-04f55de44604@linaro.org>
References: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
In-Reply-To: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=N3wP+RQ7VRT4++7kCDqamWluNf4gtoR05YTHGQbChM4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVt86XeBshGAsC/W5VtvCbe/DoZodm4H3bJEm+JB
 zIV1/QuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFbfAAKCRB33NvayMhJ0WewD/
 0WgBP29RRzC8rjfiULD0LJYiLhZkvw77UYyaHeYHtPBrXItWG3Qk810jaJOq4MZUVGkZyWlhZp0We2
 SJs5rZxZNqNF0JwHDuDfrWgiyn6uWFimoLJli2jnyPadMwHFIqgEHSzf3wVU9igmUC08vVrUwDHPa2
 YM/elkPKAYphEAIz4gNl6OskajHTgRTh24p3dP93sVkKN8LGoeC5+/GpE0ycNHxkD4mo9mGynz92K5
 +p0xwSRUK3WSmNDXQ/AxnZ7/uc/HRNk7PAiR8+Nafic0rf9yElFYpYhmk/Wk2yfJapkPGqH3+friKt
 W3QilPmyYO3nhV6djOApbC/K5i9lBfjxnEPeLw4y1ULfRBsLygDNi79zb1jCTdeAtz6bp4vGVf8WIz
 FPcB7dSdVBqrYMwH+wjZZgZSNoa/JxbyLtboRh8B7K/RgsgtaKxZbnra+cRR479hCii8TOH8qHfR38
 GSJVzS9NPRb5b2fEBZ9+bVUOrRegB6pR6mLue0TjFBAp/cPBBNZmPEvKs/nzURJnoDcoYMJubp4S6J
 J37idTx1I8WMSvIV0fdzbwjskU18g2se3voQgPXhOL6OZxrTEKX+Xzijrsv+Xf0olQ4uPxJibydWF6
 Ui2F7n+val4hewIvamm2jh14mmUTqZfydQ2TbtAooj7fmKrro/ssTPPxzyPg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The MNT Reform 2 CM4 adapter can be populated with any Raspberry Pi CM4
compatible module such as a BPI-CM4 Module, document that.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 949537cea6be..b66b93b8bfd3 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -157,6 +157,7 @@ properties:
         items:
           - enum:
               - bananapi,bpi-cm4io
+              - mntre,reform2-cm4
           - const: bananapi,bpi-cm4
           - const: amlogic,a311d
           - const: amlogic,g12b

-- 
2.34.1



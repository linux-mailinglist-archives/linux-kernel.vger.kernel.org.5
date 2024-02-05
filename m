Return-Path: <linux-kernel+bounces-53160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4384A178
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5ED1C22A07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE0B4595A;
	Mon,  5 Feb 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GIWes4dd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32B4594A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155741; cv=none; b=nwFFJ9BDWWrLGY1WvFQvO2X6q5V4Ysb7lUIEmF45emQ5oNiFbgBnzEQ/1uV123c8mvPZzGWiE+qME+YmZmy3tGRO58nkM2qf6MESaqQSwDpmRK29XTSaJCFr8gFuc6QRvGsH66W0bTm+4AVoPsv0aEcIH4vrcpkbHT1VElDThgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155741; c=relaxed/simple;
	bh=dsHeljQP++qeke1zASpQ3YPnuH6eGTAu4r6z8mvmrbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DqFcIl0Nt+w5L2ox/J1w1YgrhdSucg0w5usUJzERinFG/G9Ts6HJzEk6AshcFpAu+Qwq7NMOkYul1o4RKAT1XHqLuBLrp655kcQYfJG18a4AOKp8jfMo22lvlmh3zZBbiBSGeRKk3WOrak2eNUdrqJe3TbNh7F0LgZAPhah5gW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GIWes4dd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b18099411so968527f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707155737; x=1707760537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szbyE8B5HmerWTS9QCGM8GNA9TtBAZ10zn0t2kxJOBs=;
        b=GIWes4dd+dQkjv+erx0AlSSljN0dFYyqKuAMYMgJ+G0/2BkYHDL7S21MDxnK/2KbMV
         MzHEsYK/S7ZMdkNHRP+OvgwR+jJe/W7Cs5F9qCFSPZQ3yQSHkPGr1xvzIjVmNcmZe6bV
         g3nDCeCPtqd6bf/G06nK2BAcYF0rc+zypP3qMQEUNzeLwKe9AiUvauJdSDM67XGzB4Ny
         3jSDdFo4151ygMuSiaFyYHyQjceKotluR2zifZpxs9RryZm7dfF6UIayCvh5aZZ+gDbI
         RaMKc14D5EO7dkWE3faSvPBHkGog+dsQ/haHLtZidnvkrP0r5IwXN+FPVlUp04RLEV8e
         /j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155737; x=1707760537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szbyE8B5HmerWTS9QCGM8GNA9TtBAZ10zn0t2kxJOBs=;
        b=ZLnn4wrnDU0pOEUw/QXWYiZGTni4YM6khe0Ng75Exx5FQvbiXfq1xfMALm/iAQ4/U4
         YrhM8d+fx0Yc6jQzvfd4ja2prKX+ckO8aAJUo3PIdHxuiutO4w9GB2ud81D1RbFPks3p
         hVPMy5nNHfodAJBpa36fImJUpLTo1Knv6+9LTK29PX0eHj/Z11Y+HCppuKAkDM8Ce5qD
         PpaUGNaxkC9twjIwZCxGptUzkKiB49haR1yVeqzAO/5qc/GJY4Dhz6DRaLBx4SM7qPaJ
         WIE2C4cBQ3ri+Y8PbDhd9q/mXWlsTY4oxCezhf+JABY+uyS06WwoEok50U4XgbIY0KHL
         PFWg==
X-Gm-Message-State: AOJu0YxIpGnkjYE2ktNrZ3Gz4txU0nbpCJtMTvJTyBm/o5EqY1Ul2ETa
	nY9EX8PjipPw+v5LcMWGG2Z2WznegjY9WkNgorzKOKqABg7y+3rk6cXlZBGtKHE=
X-Google-Smtp-Source: AGHT+IHzPv5LMbjyU60gsDCwrFazyTvvle25BDscy8+ByFFpC7e2TQ4l8+2KODtVkD57MCSsp9Hdug==
X-Received: by 2002:a05:6000:d8a:b0:33b:3fe8:640e with SMTP id dv10-20020a0560000d8a00b0033b3fe8640emr155686wrb.16.1707155737401;
        Mon, 05 Feb 2024 09:55:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVM50fTjxTu0/xwr/5kMMi/SDP0CggyLV2aA//oJFKPwxW7n64dPykTFS0U9qE8rqv5Sc/wDNjmK5Dq9fhxmoYnuFCF+VNi7IcUqwGxpB/1zS7cXPmMA15BKXOJVHCm7iPpCaiCFeORxD9HGhs5r3BVQ9MhzlY8ON6S0mE8bX9WlRzQjbTkCChDcXOeBYMT8rxOHkKSHgxVeYqrri9eeZnV2vbdtGFeIZOTrA3g386MnQLa74//9u3PcDlop3CFKicmbz4dFvVhr4o3OdheJkOj47cv1KhZfLNbfX19XTqvbAQcSvBOL88AtC+hod0RPb9fd3NblrYr3gYEqFecREA+N9EvwrJezbA+7o8fojrD3FIOMfQA0JHcPBF7orMpL1Y3cZ5BR9rrrb89Hxp1N2BJavlEbeuECXI+KyY2jRIe7ImTf0M9xK5wXezlFUWfva3mbhYeSKV140KgIuR6ecCBmN5Vg47pE5mplktNY3zkWTXKu6FDYQTLxNTpDfcUzcgLbiaCJYD/S7F+sFuZauZYMpCb4uUutOpkAhiQcEf59b8M6G5ynRfib0V3u58hDb8EVMXFWN/jp0h9oul/N+m22WV4SJa5/fi27fJAncxu8cf6RZmuzknLNRdwiKjCn0zQO2QMO4Bg/DPq5SVlrIQc/FFpcLaGvwXJJQ3x4ckF69ArauH5I7OwGmsY/Dm+J/nwfslGfDcjnICd7be+YGN5W+BMGd0zcO0o57F/ngCUjVbSpPXJMomej1CG/T+TLYfeWH5WxcwVEJc8r7IDlBMYgjNIebA9GwGhQcrO
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ee8765901sm517556wmb.43.2024.02.05.09.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:55:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 05 Feb 2024 18:55:28 +0100
Subject: [PATCH v10 1/7] dt-bindings: arm: amlogic: Document the MNT Reform
 2 CM4 adapter with a BPI-CM4 Module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-1-dc06073d5330@linaro.org>
References: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org>
In-Reply-To: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org>
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
 bh=dsHeljQP++qeke1zASpQ3YPnuH6eGTAu4r6z8mvmrbM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlwSETaOGV/LfGvPj9RkwIO8SpqVlmJ5bu/JPHvBxw
 MhoMyGSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZcEhEwAKCRB33NvayMhJ0UlYD/
 9D5EgwF9dY0ePJOrDxc0L/pBLl3YvRvByoSAHYyvlLebG1LealyXE13WkrJPxKU2gxouPPprPZoSg7
 xV2Cmd5Ci3GvXtq/VBV5zMQOXmvtORdpoKgYhFB0+P8L+ttJHXyH+X8QhaDyfefFOr2zexMrmoEDf2
 EtjTA/3rGN9AOpi7bOr9FxtyR3/kgAN6unsXB0W622z0QDAK110rj4ITdGXemGRgomf11zjk4fyvpf
 IKkCct4yYWkopzIKn8HXVU1ETWmrB8ovYPIGENVEn2b2o2fj0VLXai9mUhU88O/PIlUVaoQ+V7jY9a
 MNV+Md/lM9z4lQlHEjABIHPMtMipSJqkxFUN5SdKnTP/ovZpZu68S3XKCf/8f42zLwbiXtVz3qyeCw
 BX95wWutuiELlGhLkxYoB87jlFl0VzRce1lASTpG0BtlTWUInPiMHVgW6Ws4DbkrYD4WL/VhdieM+T
 Yykb94ImYEKlvsVGMpkyojwJ7H1gyeZrXRpTafAc16tdBH77g2D1Ev8X11FrgQaI89mmL4zEENO+pM
 GqfEggf444uxQs3HuyFDX9fdCepIaIKOSCXhkHh+S4niRQPbtev0i3ZGw9yh+BM4Yae+erHyobbvbA
 08bciuZ5EXewIPkwV7zyBR28akMd5/uA8UA0WFFxskAkp+NjyF3maME9d2IQ==
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
index caab7ceeda45..2154a4614fda 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,6 +164,7 @@ properties:
         items:
           - enum:
               - bananapi,bpi-cm4io
+              - mntre,reform2-cm4
           - const: bananapi,bpi-cm4
           - const: amlogic,a311d
           - const: amlogic,g12b

-- 
2.34.1



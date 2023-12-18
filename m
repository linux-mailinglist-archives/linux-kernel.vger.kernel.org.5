Return-Path: <linux-kernel+bounces-3699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC37816FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077E1286B58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EC1129EF6;
	Mon, 18 Dec 2023 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPmGrbRc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2249129EF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55372c1338bso497156a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702904757; x=1703509557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zf8GU1jucs6jTjct5l69bmCFz5L/L0QfZmLNB/CjUWs=;
        b=sPmGrbRctPwUhob3NhJ2Mht4JSfRoOWJiM3V2sGnfRocTi/V+0JnGpJQmeCYs0O2xz
         4Z0DvOjjeFAJeOqY3FABFmR+gjrdkuQbTsx8x+XOaKEqvq/5D7snTauMcdE9d/8CLWQq
         XhNOVZI/1+ENS4JSD+5ZyluW3u6TLJzKsJD2641u6tJlkWsUAzAh3PFaLz16/6sGxDcj
         rmvtkaxsvh5mqi91KxzUzFf/MdgtbAlVloHJ9jcUyqreSKWqwQEMb2G7id6kpP5TmGHa
         WstSnwwkYbGvgBHz4rP5FfSkvKQgEv8wY3ZaENGHOyTYRcg4SD8k2VO6qMRA6iE/2FOh
         l8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702904757; x=1703509557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zf8GU1jucs6jTjct5l69bmCFz5L/L0QfZmLNB/CjUWs=;
        b=YiKg/3FNe0iI3WNcRaouh0khygFYXA0f5Pgc2D+ZOKuP2UDSbhg3LqF5VKSodUEU7z
         eh1ftswBifWUNXa9rUFkQnO1VxS87uWvWpz8DlV2oAYw7yGPAsPhZyvALcua6ZczYg1t
         /oVa8r6FeWuV1SUKNAy1QtH9Q81wxSpg8fe6Wm0+grZ9cFIUF0VDbisBrWRN3prqp6yO
         MBqOSde2O1j+hoTxUdatNjnzic4KRkXZTAa5E1IQffEXNtRqNE/B3MyvHeg8hvpXy/+R
         oqvcyx9IbNowDupzl5awHQvWGp4ScMdP3p8Tge0KlPPRMC5K2fVicIdCVz9UrL9VVk5R
         pL8g==
X-Gm-Message-State: AOJu0YzPHOPm5OlYVlmSXKacm0bBJ6RlDg0bXOAXoBwqjq4Sa9INs+7S
	N7RCy6bk2bgnczsAeY8e4J7XqA==
X-Google-Smtp-Source: AGHT+IEdbcnRsIGQQTEEoVP0zaBZsY9T309dnnP5VQFvrOWCpgKybfRfxBuGkcwem1DLUb2bJvNoFw==
X-Received: by 2002:a50:bb49:0:b0:54b:d16:4c4b with SMTP id y67-20020a50bb49000000b0054b0d164c4bmr8502094ede.19.1702904756948;
        Mon, 18 Dec 2023 05:05:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id bt13-20020a0564020a4d00b00551d6d51401sm5943048edb.53.2023.12.18.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:05:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix path to header
Date: Mon, 18 Dec 2023 14:05:53 +0100
Message-Id: <20231218130553.45893-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the path to bindings header in description.

Fixes: e1c4c5436b4a ("dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp binding")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml           | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index ae83cb8cb21f..59d34a2a2196 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -63,12 +63,12 @@ properties:
   "#clock-cells":
     const: 1
     description:
-      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
+      See include/dt-bindings/phy/phy-qcom-qmp.h
 
   "#phy-cells":
     const: 1
     description:
-      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
+      See include/dt-bindings/phy/phy-qcom-qmp.h
 
   orientation-switch:
     description:
-- 
2.34.1



Return-Path: <linux-kernel+bounces-79511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB2862373
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C24628359B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61589175AE;
	Sat, 24 Feb 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLhWWwk1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308910A25
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708764037; cv=none; b=ior5jGk7JmJc0QpQzmvemf/ciiZ4+mmojCy3JJ7isbV+eOmF4olikfR1+Ct61+rNkLD0oF+KT2pweX85ULfqNJNOZEHOWXiaPNbMTv9qytmsTDD8HLGIDGMgwaWiIdz1NP4BbriVpbVCJfmcZPwoAxxQOnwwi+yKKKU98kRXdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708764037; c=relaxed/simple;
	bh=uX3vEx6MRrc9d64luCegnAYitKVAyJ5fR1QXwdhRkNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ahNz6mhcyTo1g4RZXHeXGnQJXP+2SkPCvu8tZQRZRDikFP3Zx7nOD8OBpldD99yLNqNNp3RYy0cFskbwvGRVHugARZmVeJA9wlDknTN4e7RVh47UkJwI0lJcztxVXtluP7jVGetq2ofWOwsqSlMGaHYBn1oPSnjL5dfwItMA3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLhWWwk1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso1773403a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708764034; x=1709368834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvJH37YjGS48Ib/CmPNjZ447xJqMURoFa7cg6zI1jYA=;
        b=eLhWWwk15LnmWBHSFC2hXMjkOSlRq07qzcKQ/Y8hMrNjMOcwo8DSbEfr7VF5CGZdaf
         t1BpzYE2WPgVc+tEGuXvrmHlHzX5RAaJoshhcZGgQpzRab4dnRRSQbviQ/7FZ53pNEVk
         SUv6OlFOHgg8N9rwudJaYqZ0euizzcqtd5vbly+Xdi9h9YsJkE8QhfyJQ/VnAHQVJY5c
         DZM2vEv6ndROO5NFMWWJEUiVomLR30JwDRV5DDb9Hahux5o8ifdUbAf4AibBe4p0u4q0
         5LcftCMU0CyXv8TVMo/Ut0tHSQqxWgWglNuFJInSLsQWt8WiN8J8C1he/PZKxJIZV/eJ
         kzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708764034; x=1709368834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvJH37YjGS48Ib/CmPNjZ447xJqMURoFa7cg6zI1jYA=;
        b=iJKR8wkNHD38g9DiCQcKBdBtckGFx3XtqWXwjDB+VfISjAey0yVsd7m8GDgd2U8l26
         +emv00krHPx4yvjSCbtN7v2R6SrktWMQrCtAr+as89jOxGm8qnjE3D87SNUvUwqeQkfJ
         He6qnl/mf9NCkkjMoNY18nkLvXeH5I+kSNteorfeny6c3dILL74sciDAtyLnt99MMNbQ
         jIDlr5oM08A7Gy0NwceImK1XF9zedzA43+YroPrOYrPCbLe+8GASrsvhpQvOMqN7iOyD
         MtPcmESgzEiNnPG47lUMcYTLosSDYYw/5oX7A+iXYDxUsegxzQGDb9D7y/gqQbEIfupg
         mvPA==
X-Forwarded-Encrypted: i=1; AJvYcCV58i+bGJ1KRZ7+agGQOYYzlzSEXMq0Kmz1zTEyS5jdOL2bSHbuOuaAavRqhsKH48cIMZR7xK24DjAjAtf/6IarNMrAOf03ebKfyaH6
X-Gm-Message-State: AOJu0YxJ829fDYTq2h2mEBk602e+UlR9DMBhb7n2QIj5svqbcKC2wTAF
	kLWsh1LOxwce/2hPaVjLfVGqsKYTgJxzfK+2SgV3R0p/zDQ6vkxJE1Cz+mlNxe6a3gE9M47YyjK
	yYNA=
X-Google-Smtp-Source: AGHT+IFIU7s+LjT6/xTV8xWct55epk/sIPhbKkNF5wKGi/vPldzFYrr5+qQKxMuA/dqrHswAQzx5iQ==
X-Received: by 2002:a17:906:3b86:b0:a3f:7c3f:7681 with SMTP id u6-20020a1709063b8600b00a3f7c3f7681mr1270333ejf.36.1708764033910;
        Sat, 24 Feb 2024 00:40:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906695100b00a3dab486a19sm383309ejs.118.2024.02.24.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 00:40:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: remove unstable remark
Date: Sat, 24 Feb 2024 09:40:29 +0100
Message-Id: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amlogic bindings were marked as work-in-progress / unstable in 2017 in
commit 7e8634e821e1 ("dt-bindings: amlogic: add unstable statement").
Almost seven years is enough, so drop the "unstable" remark and expect
usual ABI rules.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index ce0ea36de0c0..edbc21159588 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -9,17 +9,6 @@ title: Amlogic SoC based Platforms
 maintainers:
   - Kevin Hilman <khilman@baylibre.com>
 
-description: |+
-  Work in progress statement:
-
-  Device tree files and bindings applying to Amlogic SoCs and boards are
-  considered "unstable". Any Amlogic device tree binding may change at
-  any time. Be sure to use a device tree binary and a kernel image
-  generated from the same source tree.
-
-  Please refer to Documentation/devicetree/bindings/ABI.rst for a definition of a
-  stable binding/ABI.
-
 properties:
   $nodename:
     const: '/'
-- 
2.34.1



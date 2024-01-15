Return-Path: <linux-kernel+bounces-26369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B882DF57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB76281D33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8678199D0;
	Mon, 15 Jan 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/8g6Nuj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D9199D9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5597e3da072so128675a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705342860; x=1705947660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yC2xyFUISb0IkOhvfcovWkWsLnq71surBiWkKTVQGT0=;
        b=B/8g6Nuj5OJrli31+2SJRhF77Qp1XO2+fmHqq5SAQ8GWn9t6F5pHpjet7vfKE13uQn
         GgECunRcxjIK/pQBLvx07IAyf9InLHQrluG3pj8xXd+sRdCoo1ctBB2W2oF4m7qT+PWO
         Sia4h32rvk+esDh+U49UEjpw/cmaE5K4cnyKDr4J4/tczHhEkMtq2BHQ1JtbkGJgKRUg
         lq9Xm/g/CZwwwAXF0qRwoVX9mdav8hAdZ6HJft/ikKKL0Vs0BCkseIYQo1PlxJZXYUu7
         VS3AMFvpXnSggh3JIusGuRfQVXsaYYcSPiZkpSvcl4rrpAeCWVXpRXLwANwwJ8RVpMej
         R0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705342860; x=1705947660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC2xyFUISb0IkOhvfcovWkWsLnq71surBiWkKTVQGT0=;
        b=eU1coS99/q9x/dwNbdFuY0VGDV1QCXUh5tQ5qSSx8bidQH5B7JyLsy5AChv+O2m9GR
         K/J3qutz+prrK6M6BVL6y+vwlmU+in0WIcEHe61RFBOyC8vonMM3KohdPW6qDiUArpXk
         kyztxbN19cd0fMjDPfN8m2+f9JJXzJnUZDxru0jfuNtGLy8c1cW2V/oJxlvL7lrC7wUE
         6mEPVa2LoyWug0sv/gfc4MEpG0LTdWagL+0ON0Gmz3bLLY/bBTJo9XsbSJUSQVjLOLwr
         +cA0xOWaWDZBs9ttHBu19o3/25AJsrBC9V3VgwfIdtocC25Kvy+JAMAU/q30/L3qacle
         iG7A==
X-Gm-Message-State: AOJu0YzzOflhX/mckoxgrtnagJzQ/iHmzJe+cZdzIEpg8IHoDWSSFD4U
	2XBoQ8y9WMn0wuuRFdiAs1hA/EOhiuhwxw==
X-Google-Smtp-Source: AGHT+IHuehd+Ath+q26b0iCYWIHVrRKBBl34yztJzpBl9VLQAw1YZyBaq5SwHv4MR7kgx5tnyEedbg==
X-Received: by 2002:a17:907:1115:b0:a28:f816:c4bb with SMTP id qu21-20020a170907111500b00a28f816c4bbmr1876808ejb.117.1705342859983;
        Mon, 15 Jan 2024 10:20:59 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090652ce00b00a19afc16d23sm5530420ejn.104.2024.01.15.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 10:20:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: input: silead,gsl1680: do not override firmware-name $ref
Date: Mon, 15 Jan 2024 19:20:57 +0100
Message-Id: <20240115182057.1610195-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtschema package defines firmware-name as string-array, so individual
bindings should not make it a string but instead just narrow the number
of expected firmware file names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/input/touchscreen/silead,gsl1680.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead,gsl1680.yaml b/Documentation/devicetree/bindings/input/touchscreen/silead,gsl1680.yaml
index 95b554be25b4..5381a96f4949 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead,gsl1680.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead,gsl1680.yaml
@@ -31,7 +31,7 @@ properties:
     maxItems: 1
 
   firmware-name:
-    $ref: /schemas/types.yaml#/definitions/string
+    maxItems: 1
     description: >
       File basename for board specific firmware
 
-- 
2.34.1



Return-Path: <linux-kernel+bounces-80680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3D866B21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CE6284605
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF971F944;
	Mon, 26 Feb 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSBoM3jT"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AA20337
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933042; cv=none; b=CbQYuKG1LTFrZPM9zFjbX5AxrdUS5soldskDDVc5qo56IGROoFz20tABsuLZPzKfpGQQHwN5GbXgS/JWu/OyZ1BmAR0HhHJqYvAoTxD7KWFLEyJQePo8kwf2ZhtVtHobJsCHrFpFkb7HmliGELDPuSA7wSUXH/fC6qusrBd+0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933042; c=relaxed/simple;
	bh=+CPBBu9WyqTLEESsUyBowQXqNEsqLAta+C9KRApRjH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icYDgMEX98lJCfcfjhlTNxDKXJKkid/0jAox2bQqC3QaeGEvXvqM2u44dTNFxnMkNMohnaXlz8O+wyjW4ozZj5idEd2y/dZ+Kug7XCzRgnDp/izKpOx1gePllBi24cY07UsuOS/wFr/g7TAOqvNbjPf1P0NMRoBv07y9DkLf2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TSBoM3jT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1650142a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708933038; x=1709537838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f93rFz5E3AeU8cJwJga/R66WIzynOr8vsYGsktU0xqw=;
        b=TSBoM3jTIjO2dAEvEyGbji+B0VdHDuXUNxxtL3scDftfpm0xdqiTiGkHE2G0HGEHi9
         zVQlaBquclIqrM1QXmQvA+Zo8QnDTrwwXDYl5yOeDZg7ByU87/FgINj91zSlZhxhC9bf
         pcdntgdIkk8w3w0CZvhXpW3U1FqBvjc2wqFEUtN1e8OX9Kdasf5LIruwUo1EH4DvhgLS
         U830juSl7dUdPveTO311aq2Nc/7jBgY9dEHf7Rh0lMrLoe9WK4YTZtEK3JZv3pRqCYIt
         lo1NvtKP8nthCDS/87mVNt1piq3kU/NcjSKBktAupN1CWdeTzU6UfJ+K+FI+VBxTEbQd
         pkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708933038; x=1709537838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f93rFz5E3AeU8cJwJga/R66WIzynOr8vsYGsktU0xqw=;
        b=h+shvrfB1OjgVKa7lGk81t/MDboatmemQvpiMvT3mPDCPrhNQy9x4uC7telpUNmJzx
         xZRZEDzuZob9woO2kgYdATrWeznNjjjms7wuQlVh4a1tR1L2jZISnFGUBFruJEm09aj8
         v1pBJVEyNC+Tb7lHjaou+xN4vz5m7ebZRx5DgAydnlAa9d0+gH2dkbd8GMTg3R3nGGux
         WapKItS38l1d3OE8f+m4rIRakV0FT5BxnzcdKWj/PBF02O3zF73V4jyB+4tSb5iYMeY9
         qWdrA4Dqfmw0b+xeu2RYBu8XCxczLY6anCizlQlZ/bcmiyzsp93ONvsKyuwov1nbXe9F
         OnUA==
X-Forwarded-Encrypted: i=1; AJvYcCVFTd5CduX0L/Bu7VmUebzk5jMlWmvZF6m7AVwHO99tJwTJxuGSz7P5uXav7T/fz7gy72VbIxSPJxpY4WWF5BbH/JW2UC7/XnmgdKGF
X-Gm-Message-State: AOJu0YxGu8W6QjuxhU7fDDQqhBmhUfGo0s/v+JxgeGYrebLf3rUHUray
	G55hhSfrRgVPEP4DoIswpLlwkbcpWrSddaIK0miSAjACqLx+HPv9hfdh7eB8hyA=
X-Google-Smtp-Source: AGHT+IH8BkFJeP/UC99e0jX4wZGL1PJeUfLlzAWh6qlnYrXXQUFlZiCkpfV2Ek5S15L9cROt8UR4IQ==
X-Received: by 2002:a17:907:1701:b0:a3f:365:2276 with SMTP id le1-20020a170907170100b00a3f03652276mr5277748ejc.34.1708933037889;
        Sun, 25 Feb 2024 23:37:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id y8-20020a170906558800b00a3e8c3fc3ffsm2187425ejp.10.2024.02.25.23.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 23:37:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: leds: qcom-lpg: Drop redundant qcom,pm8550-pwm in if:then:
Date: Mon, 26 Feb 2024 08:37:12 +0100
Message-Id: <20240226073713.19045-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"qcom,pm8550-pwm" is compatible with "qcom,pm8350c-pwm" (latter used as
fallback), thus it is enough for the "if:then:" clause to check for the
presence of the fallback "qcom,pm8350c-pwm".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 6649ca2ec805..699db7995dd5 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -141,13 +141,13 @@ allOf:
           maxItems: 1
         nvmem-names:
           maxItems: 1
+
   - if:
       properties:
         compatible:
           contains:
             enum:
               - qcom,pm8350c-pwm
-              - qcom,pm8550-pwm
     then:
       properties:
         nvmem:
-- 
2.34.1



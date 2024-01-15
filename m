Return-Path: <linux-kernel+bounces-26367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8DB82DF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572DF1F22CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83C1946B;
	Mon, 15 Jan 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2/Owckg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3CA19472
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-559565a3008so1177501a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705342845; x=1705947645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yI0z1EBMjyfzrrKKJYC9G/TfAYY0KS2lk1QKsvfTpXw=;
        b=m2/OwckgTgVR1/ZFdbkgjKwZaZyQzcl+v3+/gxh0QV42FtjLjlt2c92P1VEhu0LlWo
         DPK2E37sEQgNxYJONPTDp/lSVes/mssNQ+QMchs8vFil1uf3RBIFhhaK6G7dwAAhPeh4
         iPnSEv3OJKmBlndGgwVf5Xo1NB94E6vtQzj6HYcuxzn2weaF0Hr8wc4vh2Li0+P+KBR7
         pTRPBB1svyibToaF8XmkTlFB6IhLzVRZgfQw/wnK7ygpXMv8We2SLzatOY2k8bFy515l
         sS9JfZytf+etDFC9a5yvSjaeEK68N+KmRurn1hOAk4RdBGNLES3dojS4dxKzWn3RhJ3z
         VACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705342845; x=1705947645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI0z1EBMjyfzrrKKJYC9G/TfAYY0KS2lk1QKsvfTpXw=;
        b=P98jaqAmrkl+C7GFMlpm3mJC9MbosXy+UqT7L3ePDIvHD8Hewt+rADzsnMPUjXNYeF
         vuKycDCvMx2T/H+gs4K6ceJxLxqbkLch3J263VCYTq5M7EOZVea+nDn5vUQC2p2stHq/
         OuHmfDXYxCQE0hCqtdwIyIW4R74a6KzCG3dyRhIVwrWqCjKY7Zhp5nrxCbiLHDY1sxW3
         VQNM3V136R9ftEcv5ql/Qn4X0R+K6sNQSM95UMj/hVtHjsYMfww74LjR6ro5QCyodfu1
         X/+IkUdoXX6YB0Gdxn9ys69Y16m0qMy/dfeI5FPu8oJL/yAT72Xdb/6+8fjfVIAsu+Jf
         kU1A==
X-Gm-Message-State: AOJu0YzLRg3ke8cUXtcJmnlya3g4W0qWdyu6T0G5d68BUgByC1Vkaoan
	HKRAz29qPaa0rdX9yTNqCfe8DTZZSHiyog==
X-Google-Smtp-Source: AGHT+IGnRpCOOr+n+ZPFPjAXDPvj142P9E0o/W17+Ui/ChpAdhCEdlTKK2f3b/LvVE1QSl+SU/KlpQ==
X-Received: by 2002:aa7:d88c:0:b0:54c:b889:9c12 with SMTP id u12-20020aa7d88c000000b0054cb8899c12mr2647466edq.18.1705342845122;
        Mon, 15 Jan 2024 10:20:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c25-20020a50d659000000b00557c51910e4sm5944434edj.85.2024.01.15.10.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 10:20:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff LaBundy <jeff@labundy.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mfd: iqs62x: Do not override firmware-name $ref
Date: Mon, 15 Jan 2024 19:20:42 +0100
Message-Id: <20240115182042.1610134-1-krzysztof.kozlowski@linaro.org>
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
 Documentation/devicetree/bindings/mfd/iqs62x.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
index 044cd7542c2b..f438c2374966 100644
--- a/Documentation/devicetree/bindings/mfd/iqs62x.yaml
+++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
@@ -31,7 +31,7 @@ properties:
     maxItems: 1
 
   firmware-name:
-    $ref: /schemas/types.yaml#/definitions/string
+    maxItems: 1
     description:
       Specifies the name of the calibration and configuration file selected by
       the driver. If this property is omitted, the name is chosen based on the
-- 
2.34.1



Return-Path: <linux-kernel+bounces-4277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E16817AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28064B233E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2771478;
	Mon, 18 Dec 2023 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXRey07o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D671451;
	Mon, 18 Dec 2023 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1ca24776c3so897261966b.0;
        Mon, 18 Dec 2023 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702926637; x=1703531437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EnS+pRSTO4R91TDbHHpG803uRr+ViRWAjg2k0SmyRQ=;
        b=DXRey07odRL/Io2U1ZrA0OLX5MwOzD6Du1EKyUAWkGizia29wHAEJh/+a9qHJK1NYT
         yOU0RISWhNpvdhAXmHK7kqzheK2FOZTIpgV8sQsQaAp9QAn0/1+8dMbV4XXMZqNtBvkl
         ceyPQMnN6Rdv/cPriYv6c5S/hz88ncEEs3qL3f3Ek375k+oTsm6R7smMvruKuFc1HJzu
         VIHiRwPM9PVuJvaryQlcHY4KzqhegU5JTRfuu9dfoMrhOj9+Y/u/nS8A7IP0uBkHcxiC
         FDyZjIrJHYLcwjkc6wXu1leGReNUwBAAzMscoWqOXOpVri4M9fvfqwaymopXFcJTWvBj
         2zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702926637; x=1703531437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EnS+pRSTO4R91TDbHHpG803uRr+ViRWAjg2k0SmyRQ=;
        b=U6O40/exUNWJT/pCDeGDanHmkSjc1a+nRRyadqwcOyMlB/+JCveOz1ELP2msP7gnB4
         dr1L+1NYl1M+VxL8CLha0mmonSTvZWY/QRUrljoO1UYipFqY5Y4Ks6+CiiEg6+9lQ3hJ
         5C8po4fM1rpXE3L3TglXpyBzDo4VsPuGuNUhyU/UEpOviMkRUaq/43+6ib3uzljxzllb
         C5hNdhaNgk5oBtHtU5RFJEe5qORWlzfIWu7Gz8Ge9IzL1Ua2cuAsFS1w0U9PqLqTnd8k
         WmbNmjgwQWgBRJfOXU5bfAgryRNGaRTEnJMXEP6hyJa9NG1fZEPy5irSYyqYRTcbMcfv
         8fHA==
X-Gm-Message-State: AOJu0Ywg3E+B7Ujqh4EVQwqYLP/DFLh1W4At7hztRHPnqPJ2T24Np7JW
	ZBB/zdSOVmyqAozBnQ2oEgA=
X-Google-Smtp-Source: AGHT+IGBOv7NALkdr5/NsoJKUe/JSNE6cADSD354tEAY7LWTAvF5QSqUnYxGRWaUVnshCDESka+swQ==
X-Received: by 2002:a17:906:1114:b0:a23:4a3a:1ac0 with SMTP id h20-20020a170906111400b00a234a3a1ac0mr2781314eja.36.1702926637192;
        Mon, 18 Dec 2023 11:10:37 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-339c-9917-d041-4030.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:339c:9917:d041:4030])
        by smtp.gmail.com with ESMTPSA id vw6-20020a170907a70600b00a1d80b665dfsm14398956ejc.26.2023.12.18.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:10:36 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 18 Dec 2023 20:10:29 +0100
Subject: [PATCH v4 1/5] dt-bindings: vendor-prefixes: add Amphenol
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v4-1-7940cfa7613a@gmail.com>
References: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702926633; l=874;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=PCidHchbaiTdlYu+9md1vtBsSrbu0tUQ7foLUj3NqoI=;
 b=ldvsXskcRVn6x93WkQ9BvNMj3ijNMjFWPAANPm+uhN/FAeniPrs4jLnTZU8povQWqsef4ZCPf
 X4NFacqEC2zDwqrELLqqDRMXreQVL+UlVrkXqkmTzuhdNdblj2+UvUs
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Add vendor prefix for Amphenol (https://www.amphenol-sensors.com)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..4a49f24b906b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -105,6 +105,8 @@ patternProperties:
     description: Amlogic, Inc.
   "^ampere,.*":
     description: Ampere Computing LLC
+  "^amphenol,.*":
+    description: Amphenol Advanced Sensors
   "^ampire,.*":
     description: Ampire Co., Ltd.
   "^ams,.*":

-- 
2.39.2



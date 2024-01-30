Return-Path: <linux-kernel+bounces-45315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D95842E67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9692E1F24BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525678B55;
	Tue, 30 Jan 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUrGF28o"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F371B52;
	Tue, 30 Jan 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648815; cv=none; b=TefC9DVorK4kmLfipRXNE48n8St2b/IxXWkd4IFseS6l0Sm3cQb5CFCUisZArSrGlLbOVKtefhCE/3od8nvZP1JDobqjgLdMCyONsMcGlQSzJAGLd8Hn8wouCgCi0eyyFzZn4LYX9xes4biUUH09XV996tlNZeZKBiQFLCGqkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648815; c=relaxed/simple;
	bh=pBakjDF9u3VEIbwvo6t1HrfC65+zkN2H7ZEX/eg+pv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VA7XggSynqja3l/h5OH/kpuX9zw+dSVZ2Ex5wWHJcnyMUwvJRd/F02NscMoGwma7dMR8/0gFcuUCIGKPDHBRsZhax7+E8bUCWHmoBC5o2md04d9LdPwN7i8GnHkQDMCIE3H/4o6IU2PY6KCdJpPkxF28SZD1R8+DX/nOkoIJC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUrGF28o; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51120e285f6so783379e87.2;
        Tue, 30 Jan 2024 13:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648811; x=1707253611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISMBkNudHXdkcESLM4GR2mZ6tTZ9A6XlLdPhEHw2Btg=;
        b=aUrGF28oXYzP0Ll403cDEHt6MsE9NLZjnDyq2kBuSTmUk1wmleldAt92hg6+830+Zo
         CpAHKv0Inp4p7WK4oDvfrS8x4A1JfIpQABJyeyzeqpk8f3J85lekrYSDTkUQZcE3sjlg
         rMVEqRLCgE8rlQGiZ33/i/YwrkzYKTNPtwEYLiKWlGJzwFs+wZrGgW2KwOAT+rzCO6iN
         aiZOATDeNEQRCI1kDnPDZD/aX/HOKBFfEF/eJCaWX6Gw1J3drbgPFYBnXK9AZAx9EGDU
         t4JswR3xkosRi3FC0HOtpgYfxSsZXzxso9ats0VJq3S/9FCAat35EkLc3yZ67Zx5qpA5
         QqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648811; x=1707253611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISMBkNudHXdkcESLM4GR2mZ6tTZ9A6XlLdPhEHw2Btg=;
        b=MmvF7X/ki4iSyjAUT68IW+HWgCvC8bmRNm0WiOS2QFw/ywJpe7ZXSw0dm6lI2wNZL0
         dHQA84aAjLWydIJ7ApdfNM+7P5R/u/rUAqeaj/K3S8NmArRVvETD3Qg6DTbcnO8xXrrZ
         U/3pE+IWDbwoSx/FYTo5fsLCDdUVLaflX5Wckqw+VrMKHG8GiNk63jJVbyhLyNG9mFL/
         D86vcGX6Jo3pu4duePcF0CdH+txhhOU24bcHQBPSiiOpI8tbafSq8fRMsk0KQI7VPmL6
         X8GEokHeyR98a6jzK0K1EEyRZRgdnbrY7fTVKY04rLZ86sBOI977ziAN+bjHqA7bi+LG
         GmUw==
X-Gm-Message-State: AOJu0YyoQ+03NTrZTC5jF8MUKDG3TSecdKSB4L9KQTh+JIJ4N2ifA2t+
	80sw+2vZKqWQ0YfpmZj6vrJVZ77L2mBV1GqqQn4f7Hr9TwxfFwtJ
X-Google-Smtp-Source: AGHT+IERyYODG8+xDHQhK/Z7O01m7wJQFeW0i+O6jhWPmY5zjhUbKTuT7gxkEBspp5cJ9eoU59eGiQ==
X-Received: by 2002:a19:5513:0:b0:511:21e4:5a69 with SMTP id n19-20020a195513000000b0051121e45a69mr413103lfe.40.1706648810964;
        Tue, 30 Jan 2024 13:06:50 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7400-ff68-7ab4-4169.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7400:ff68:7ab4:4169])
        by smtp.gmail.com with ESMTPSA id vv9-20020a170907a68900b00a354a5d2c39sm4177658ejc.31.2024.01.30.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:06:50 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 30 Jan 2024 22:06:44 +0100
Subject: [PATCH v6 1/5] dt-bindings: vendor-prefixes: add Amphenol
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-topic-chipcap2-v6-1-260bea05cf9b@gmail.com>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
In-Reply-To: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706648808; l=874;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=pBakjDF9u3VEIbwvo6t1HrfC65+zkN2H7ZEX/eg+pv8=;
 b=6ABM6vQxe9xrfSPvtPn+CADP1c75AP2WG5SR0O6NH6rBb/7vKG2Ea/7RRNtsTOF1mJdBaNxuH
 EcGm7Pebi8WBb4+1IcikBcJxsCidBv9HuVzw7MgZUdNU9dC7TUu8kS6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Add vendor prefix for Amphenol (https://www.amphenol-sensors.com)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..25158559471c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -107,6 +107,8 @@ patternProperties:
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



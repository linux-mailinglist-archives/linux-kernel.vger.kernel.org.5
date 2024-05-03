Return-Path: <linux-kernel+bounces-168428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA038BB87A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854771F226F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A48625C;
	Fri,  3 May 2024 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRVmP9EM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFD84FB9;
	Fri,  3 May 2024 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779967; cv=none; b=pz2QzD0pSgAWtCMMLgE33dbECls1iQcHvZeMm4BwA9UYg1MnSrFexG1bpB2kZBXmFhAOIg8ZnmDvTFqxtkSAXK6+DTVP3csdYbqU1qHhVUIUF8LM4GO5mGCVoRIcYiNWfhUAyglT55EyAoe+wfMaonasiv153RiRXLsXPy4CaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779967; c=relaxed/simple;
	bh=RmyvOpXjU3UcXTf0FoNq4yBXKHe7nIpgvx+cXgQJKcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmg5G9OrbRPnn1fc3hSNIA37r1x6b7blOLm2QZp8g/KPY6T6hBhp07Ysse0B4uBNWOSI2LOpqT56LIIzWdLQEItwGKnOX0PGcE2h3F4fDVeE8SJCvjmOaGGOfamE2bfj9NpGIVsHiSwvU0akeh53FKz0X46y0l0JbwUcXiarUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRVmP9EM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b2119da94so2020995e9.0;
        Fri, 03 May 2024 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714779964; x=1715384764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EO+m93QGXslHrjPGmO8FASbDolTJm2yN6BHLs+HE6ts=;
        b=fRVmP9EM0WzU/KOsduliGbnOJcBuaY3+D/jm9Bf0RgoI+W814lujPksKMsTdYn9522
         k+fu7Nw1Ufg5hC8m5QcyaJX5n/Sq2aWmDpU73sRwyXrpIqfOiqKrPMxwy+CuBYtCAqk4
         L6AlR+5E2tlzuMifcJibPpjIfYiDvlcpKE8J6QOobykzJIqKKxxXKGWI+Wyp+X3tdrde
         +uan9/MnbQoxpBjVUy2c8Uh7z68qq1LWqJsUggcpPpk8gnvAZzqw/FWvTl77qBxUEKYV
         eeNthvPHwR3j9iesMrB3biuKgbRpXB22wawrdHpw5jTfSgTW65ntOXaWfzXjGbIk3mAc
         AdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779964; x=1715384764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO+m93QGXslHrjPGmO8FASbDolTJm2yN6BHLs+HE6ts=;
        b=VjgO3ICXDMCB9Z0Uj6vrPWnZ+/MhenMc6wqTpBYcu2NZV/Rwmv+FRFuA7RlmycV0Qw
         Gaf3kv9tacg/vhp6qK+KBk8kLJM771euWuCfZEf3S3ElierY379qUo0Jp+YIl11MhRTh
         U3IqttYXh/YfpDCS6vquW9iN+atQTMklCcn/rI6PrLGRU6g9eAGZIWFV/Kt98R5O3AOJ
         S7R6weT7NZtfqW3YniS/iIRwW2Ksid9cp2n1eC3AmYxBLGj+MF/YK6Yg7J4/bpXxmAiv
         L5F6JQAxENrVIdFHytPogiINQcbPtYUjVICtfyATacLNNNlqFg6EYCloWM79jnQmbFtZ
         kVOw==
X-Forwarded-Encrypted: i=1; AJvYcCVBO/ZhNu5VoRuEwWkMVwUsEzAdqvvabqCbjtTFm7q1BKmg0p94OSkUyC1U9CS1/8oyMVZNp6xrnuu2bwqmKIhpU5SLdln8EpfGMdUSFMMpIjMkwqFYxTOjVzj7Z60b8/BNeyBx0gKDEQ==
X-Gm-Message-State: AOJu0YxPOUopxquvSIJe0wjWVhDTA00V8BsUgTZccYi3dnjvAl7gSJvB
	kumxxQsE2GJ5qrKOHBLtuWgjscEjevPEjwUyU97giIk+xqTiFs3aF2CthYIy
X-Google-Smtp-Source: AGHT+IHZ9bhWxtPGRDpN/5tByeGf7VMDmWaPFBU4UThGiadCA3rZcHfp1fA1ARiXajSXlmKNg4G/VA==
X-Received: by 2002:a05:600c:500f:b0:41a:446b:10df with SMTP id n15-20020a05600c500f00b0041a446b10dfmr3296067wmr.12.1714779964257;
        Fri, 03 May 2024 16:46:04 -0700 (PDT)
Received: from [192.168.1.130] (BC24954B.unconfigured.pool.telekom.hu. [188.36.149.75])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b0034d743eb8dfsm4819405wrt.29.2024.05.03.16.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:46:03 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Sat, 04 May 2024 01:45:25 +0200
Subject: [PATCH 2/2] dt-bindings: iio: imu: bmi160: add bmi120
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240504-bmi120-v1-2-478470a85058@gmail.com>
References: <20240504-bmi120-v1-0-478470a85058@gmail.com>
In-Reply-To: <20240504-bmi120-v1-0-478470a85058@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.13.0

From: Danila Tikhonov <danila@jiaxyga.com>

Document bosch,bmi120 compatible.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Barnbás Czémán <trabarni@gmail.com>
---
 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
index 47cfba939ca6..9ca874aea837 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -16,7 +16,9 @@ description: |
 
 properties:
   compatible:
-    const: bosch,bmi160
+    enum:
+      - bosch,bmi120
+      - bosch,bmi160
 
   reg:
     maxItems: 1

-- 
2.45.0



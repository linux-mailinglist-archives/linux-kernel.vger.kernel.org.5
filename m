Return-Path: <linux-kernel+bounces-152406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA188ABDF6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0933E1C20D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39EB205E31;
	Sun, 21 Apr 2024 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RY4mbmPN"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DE8F6F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661494; cv=none; b=t8rkphajGV1z1LPKrN0aPicZA7CuhP3uhH2ksgNpOVEqhY50uQ1S1IxtdettkNu3UUuBAuSZKsiPbc5D18lEgQfHK/a8FDlGyuYCYjVbdxj/nRBRSbt2JUz+6RNwy5EhcuHYCyRf87IdXeymbWJxMyzNwraRscy2FqoYbE503XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661494; c=relaxed/simple;
	bh=PDP+pfWfSCvmvZn17Dj5qqvNgRLWprJakVgT4fj7WMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Odhu9voypHXSz+tgsxpQBKBTS8EV3XrVXVxFHPSVKlik962szsJuLo9dd9zilNw09wI6wW4YGRDXul7stJy9J7lI23cnUxd4kHQUvrmh4bHB+Lbp7f2HTGH4wkOaOw5QyX/b2XN9rByBzhw9A/SyqmUrQIXn49O6YQMAiI98+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RY4mbmPN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c70ef25e19so1614103b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713661490; x=1714266290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=RY4mbmPNbxicCOfB9TEmLevjkM8GxiU+3jiyF3jEoMdfunqFIgk9GiRCwOM6OAGTD/
         GIefpl2QPUbVKBpRcr7CmH/3HKvZiLkQV6jVeo5NtBy114SmkUKffc9o7Hc78EMFsTem
         FQySWJNhrQiMu2nSAZrPesFvmlUdzwd229nwbss2l2aiTfLhkqDqewlQTka7ErgIXHdp
         QJxRnKkqH+8pA1RoS0tLHjQ4AhxKSF3noqDbseSKUBrXOjf3+U/ANPZxubg8HX8bQMWJ
         h/hsuNZlNirL3b5MznKZ/23SUv8V7PbgZrFGHIMlRbNPUBGvR9qw05Yg0QGdOwuIjLgr
         JHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661490; x=1714266290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=TuNOSWz8oIQ55P+43i+nRV+QZOFNcKnxOYXcJKWzSe1VsVMpq+WGh3Mi+UsmRT3y6i
         tq6TkUV/ePn+Ad7mx5fxdezAQSO7/M2uEVZ0jWoTAjLFaze/uGv3KtgGg9wIetzkDgXb
         0yBnBJ2qWctLpbGF+CwzdkNAxRfpdUAhC7cG6UNjEh6kT5rRLPElHQq1OSX+0kvt17Zd
         CSu+6oWxgpMUgxtHwZ5vdNr43CLopXXJ5vycNpqsSO+iXPU8i8LrEd+jbTwIX5hgZxeX
         BiiDNfnUR7ViAXpu4KalMNLNj5Ku+TJrrooV/SyZcxNifn4e7u8TLoWpcaYUp6jcIv9q
         J3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVjw9mTnvVTNAyOEIAHEpybi6xgf168JhGYgbzcGqRPDqE7x0/67i2SEkpFn8CmvI3u2u7BWlIwKRCtXNLxY7cLpo0fYtba1rRYbKnR
X-Gm-Message-State: AOJu0YxLX+mq6NQF8PaTKApwg76PWMokYzk+luycW5rj/EqiacQI7dQX
	iSbjaXQhQpybPH9pu611/RNgIcHJrwAJ9Hn4NxD6pY7qMDTAhW2v6FJQHImEJNo=
X-Google-Smtp-Source: AGHT+IHgwgu86RqEqJ440zaOibq3z3LImfEw+LLCOmkiUs5NeZODsGrPDbBsx/BKGgl/AQfbTefjSQ==
X-Received: by 2002:aca:d08:0:b0:3c7:4eff:f5a6 with SMTP id 8-20020aca0d08000000b003c74efff5a6mr5012320oin.36.1713661490626;
        Sat, 20 Apr 2024 18:04:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm5249627pgj.1.2024.04.20.18.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 18:04:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sat, 20 Apr 2024 18:04:35 -0700
Subject: [PATCH v3 03/17] dt-bindings: riscv: cpus: add a vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dev-charlie-support_thead_vector_6_9-v3-3-67cff4271d1d@rivosinc.com>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713661481; l=1443;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=heJ5mXr7Tx2wdFjG631ibJba5Q6SNbmXVyEpdKm9JEg=;
 b=YEjxKtbY5d7XiWDTiqBxcSBLOYectVNJpbMqu5/jHCbEbZ5l1wJ+MUDVVz1YIIJGA01BgcnNg
 0HMrxLA6DorDn5h4tdh5RWRkwuoRsB+sKvNkmlQQwt6LlqImE4+EPn2
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Conor Dooley <conor.dooley@microchip.com>

Add a property analogous to the vlenb CSR so that software can detect
the vector length of each CPU prior to it being brought online.
Currently software has to assume that the vector length read from the
boot CPU applies to all possible CPUs. On T-Head CPUs implementing
pre-ratification vector, reading the th.vlenb CSR may produce an illegal
instruction trap, so this property is required on such systems.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..edcb6a7d9319 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -94,6 +94,12 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
+  riscv,vlenb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VLEN/8, the vector register length in bytes. This property is required in
+      systems where the vector register length is not identical on all harts.
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false

-- 
2.44.0



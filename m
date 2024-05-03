Return-Path: <linux-kernel+bounces-168031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B968BB2BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE711F21860
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625551591E3;
	Fri,  3 May 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BaDDNSgg"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB7158DBA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760327; cv=none; b=HJMnX4nW2Dpon9lBGqTqOF01FgqZgOv/XGtphoUI/sD8amFOaHPprEiH+oFWL5kspy3vWyfUjYaJ9pv9kYOrYaGy45u5Mox/CxiNyGPPHpYOH8CNozug4TwdcY5Gpl1Dm/5aTp4WDi641Ssj0mKDyscT+dykl4OPjZzT0Q9Hby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760327; c=relaxed/simple;
	bh=PDP+pfWfSCvmvZn17Dj5qqvNgRLWprJakVgT4fj7WMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwQvP2z/2W6YjbCEZN51UdVQVpTDGhAC04jiDEapZfKkFcsN0zbw2BEJfoBlz7zFXdBClWf8TiQHFLTJyb6FC0ql12ypiR+JWvfhRBzEhtW1IWNpPHkcFJkiP3CEXqcTKnMh/seeShCd7N+wZN7LV+CyXoZ/0qDM2s8bSLSRdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BaDDNSgg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso9899b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760325; x=1715365125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=BaDDNSgg+db9cwVJePUdyWVE1Jp8Ennia521+H77y+o0moV8Xp3TmYngvlRGKDDOXJ
         8TmH+bUet3sIGn23Z7OKNW3Q7tsDeVFq5KFprKI9b5eWSXEaSainOTA6YGd+1Ze1sxuN
         IRp/ciJO9XnhTxhEurFX5QmF9O6zfuISNRmEoa4APRcLvoMhp18j1la03SSkAOToNpow
         qgK9+OrCDP7E60iK6RWn0dweivjoWppmZVkiWAYMIpzBZOMe9eCqZH9UK6k6/tP+MS3c
         pvxvsHz9KdlM8qoR/7wPeK82PLp/oP80evtNgi1tJHnP4jPU9nhUHLlLUQa1+iPYJnmc
         CJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760325; x=1715365125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=RKjrfbd7/pY+nzlmQbigHLkI7ghrPx/mHzyCdmK9PtTzkPtTTDxSHx5pr22mnZIeUS
         Uv9aJzFrP9VAGYRPoZnPYPYaVhX4dwxVDcPO+7ySTLRtkdflLnqRMVuuXREx6TuOVt4u
         gfyaZBu1wwp3NOtYyXwLTtuvx8A88Ph2DyeTJgbEthBQgozP0AOawb4xmsAEwGMNNlWC
         6qDz5IQI1ycofJHmmF3sUczT6P78uZSffJ2MifixGER0NZnoT6bC7f5jr00hq7Uu9+j2
         PHjzpG42+6iHyQlNqwV5EtVDIOWrop3ld5HA5PrSbtf3ugavFSfqcnYvg0POiEGKBapt
         geTw==
X-Forwarded-Encrypted: i=1; AJvYcCUQYi8LexzkWa47BjbNHse/Lh1mjLNX9JJKVRoutU5MntGNqMR4diMiquLgNCPWQ/xJqrFRGNln8Ctz0nz3/QIEp2aNoUCBhS0OkwjY
X-Gm-Message-State: AOJu0YzCr8xkFjS7BawgZzvv5Bl7qzc6GAQlj5dcb9LF5Rol23DcvT2C
	3B5kJfdp/1HW4sawWdcSMHSNGtkvGbh4cVq27XySYgZ2RSU+UZVIo/Wc1sT2sXk=
X-Google-Smtp-Source: AGHT+IHI30fGwc5aCXifihplnCqF21Ywud7b+pXK0ZB29mwiXSifKnIROgJMcOan1fwlZbT+pmL24A==
X-Received: by 2002:a05:6a00:22cc:b0:6f3:ea4b:d24d with SMTP id f12-20020a056a0022cc00b006f3ea4bd24dmr3830280pfj.9.1714760325524;
        Fri, 03 May 2024 11:18:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:18:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 03 May 2024 11:18:17 -0700
Subject: [PATCH v6 02/17] dt-bindings: riscv: cpus: add a vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-2-cb7624e65d82@rivosinc.com>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760318; l=1443;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=heJ5mXr7Tx2wdFjG631ibJba5Q6SNbmXVyEpdKm9JEg=;
 b=MANeivyUeAYOzXwSGR3gfRRzHTw6Pw61Zb5xoor65at3CiK4Ie+9408tjDxmq/csHeP+IJG6P
 N8Zi0GEi+JoCtDK4iOsRWQHVE5uARUc0GT4i6BEO2Bc0gyaUqRWDOaf
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



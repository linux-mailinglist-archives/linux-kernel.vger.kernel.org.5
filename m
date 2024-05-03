Return-Path: <linux-kernel+bounces-167232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A728BA625
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43493B21D8E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE08139597;
	Fri,  3 May 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wSODGb8w"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3B13957F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711608; cv=none; b=GQSZJj5GjKgQAFVB7xO+NoDgCcHILZs+oR0u+8k73x6Q69fH9zpBcTknyz+xJyRboF+E1vgEqcyBevq2sTeCHAJYqqYNJdH7g/UT4SVj1uZUXhQDxZr25y0pP2IRtY6AF8gtx7Qw0NRQ/WLvxIzz5eMhUg3r63KYMAeDGMnr99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711608; c=relaxed/simple;
	bh=BFeF/rMqjmAL/T3qO395y21tghoeF4vuGyaBxCV02tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EE3ZdOiaG9xhGGM7IbtH2qWlwqNLMQse7XBp+iHoFG6dg5gWnOuStqu5/GBhF5uBNaO+CFyTQqMA+lwFxD8kFK74RM59jUW4AiIS6dVFOoymQYTTBdt8L8qYfH6OJTZZ/2/JFqqwq9G+K8vCbYcrcVHDrSHrX7w2JyvpcObAEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wSODGb8w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e65a1370b7so81149625ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711606; x=1715316406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gP3BTCO/eMabIcPEHZlkkrT/LBtjjbwR/exXvwDsR0=;
        b=wSODGb8wYNV4ddXn4F+NM3eOhDt240Gb7WDD0tOEFvgNxZq4ATtUMPk+p3oRB0dhhL
         UcQZr0I8topsRblDAeK4OE45Fl03LKSYgYLiBQ7u0odulZCjfg+p5I2kyUhOjZYa2iTz
         MlCz0FV2exBa31GjlXiV4YocDuh0KoIEigxELmvy52vBkaapsJ2jwEmOXGcQV7qibkep
         IgZyyPo2TQsjIiBj8W5ojG9k4pXVtGhLGlwjU2cMIyTvftslH7B8hDzDPwYVOP8hpena
         UV0FTZnCSxrkCp58FuBizVGs/GVVd8eD+q7p7TcWG7mpBz5Urvraoac0JIgGciWQ0doh
         sqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711606; x=1715316406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gP3BTCO/eMabIcPEHZlkkrT/LBtjjbwR/exXvwDsR0=;
        b=IGZ8w6z9c0EiOYLl3IFu48PkjzdYWvMw6vz5Wj9rugZ+1tQiyWCVR8aQc5Fh83bVWb
         Wa0+muztF4BdDEqpo/1K/HiYfUPH4O2MEOoX3yLov70UgJV5C+D7mic4ppi2R1C8kFOB
         S/ZKnmg1cVlYl28yNddoBMKUaSqHBv6b4sT3+o9BCt6DVtVxl9zzILJ2FHZE7A0Ju4hf
         2+kPK0suepteZI6z4rBLDbcjbPpkZywBrIO6eIa4Fn4GVCJ1tAYnvzRMvJ9TR13EKblJ
         aL4XZWBiM0lHZOdnbUQb5VBhzzuA3GxVRqsBTBRjBQjtqZIQM22vJEWI0tLS21kSD/no
         3fRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHUI1Kxfa6FOGdujZZWJuU//oWI6sSgoY8knKUvbaTJ9WjksKwGiAZFN8n55XeV14IB9uJVvmCdjNC45HnYKgpIPXCyOa/GAf3f54k
X-Gm-Message-State: AOJu0YweRAw5bSYe4rwIJBafP7Gh/XdPMwnY+D0/oaVZSdJ5W6lFiu9Z
	KNL7SHZ+dguEkpiAaELqHJTFjFxDDc2o3G6lMTEJW9MzQmURVxBN5PBZ7lIPwGo=
X-Google-Smtp-Source: AGHT+IGj1ONAgc+kZn8Vit+kAEhx9nnFFqmH8jc56LAHeK2W7eeNxdNjrfMVxDLPsmj2wTx3n9FXFw==
X-Received: by 2002:a17:902:ccc7:b0:1eb:fc2:1eed with SMTP id z7-20020a170902ccc700b001eb0fc21eedmr1841442ple.41.1714711606253;
        Thu, 02 May 2024 21:46:46 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:46:45 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:36 -0700
Subject: [PATCH v5 01/17] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-1-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=1767;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BFeF/rMqjmAL/T3qO395y21tghoeF4vuGyaBxCV02tk=;
 b=oyLK0Y3PHVDiXz4KLcIk3Zze14XD3Dj8FvvOLsEWb4mhVtA7Gk0Zj1s8367QGoX9DEP1j/2yN
 hDvPvqHGDMfCgkikiIADs4vpG9jXpfT5XFPyort30d88L/FSaRukOAJ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The xtheadvector ISA extension is described on the T-Head extension spec
Github page [1] at commit 95358cb2cca9.

Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..99d2a9e8c52d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -477,6 +477,10 @@ properties:
             latency, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        # vendor extensions, each extension sorted alphanumerically under the
+        # vendor they belong to. Vendors are sorted alphanumerically as well.
+
+        # Andes
         - const: xandespmu
           description:
             The Andes Technology performance monitor extension for counter overflow
@@ -484,5 +488,11 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # T-HEAD
+        - const: xtheadvector
+          description:
+            The T-HEAD specific 0.7.1 vector implementation as written in
+            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
+
 additionalProperties: true
 ...

-- 
2.44.0



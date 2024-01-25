Return-Path: <linux-kernel+bounces-38753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B022983C560
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663481F21B07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C6D6EB4D;
	Thu, 25 Jan 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4dykocY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3273196
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194218; cv=none; b=DWoxSVvvDhQjcP6s2Rc4OKYXZisZmO3aLMcYbRPJy9KWEmfkkaamXWnjpSF4GbCnZ4j+UsQ2/VGCIL5sW9KeTLJS234pOsPt8u7Ksp5eu9ZXCd/dizVS9st2jhUUe5uRmRTnybNWz961Dx7LpZ63R8OOB+VM5ts1kN5+NwAYSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194218; c=relaxed/simple;
	bh=HUS+pk9N92y7YBQl1ZH9U+K4lAXt5pbyiE0NqzVBDmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvRqMukJX/UQO8kspoGhvuLLSjUR0+rjzgkoxUhcj/o6CzfFnLYp3E2R4H8GGtLyKFVPHmsWk3dUF8hMBZYaaP99jS/jGLbFdr5PSGpaTm0qzOcBA54di6tnAaNycO0iRd6k99pf4UesCwIPA43egrfBhQBF5iYfWMsWNlA4RWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4dykocY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so87376175e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194215; x=1706799015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RbS7SdUaAw1K/g37Ed+dGAKWi2x8GPreQeT5KyvnlQ=;
        b=V4dykocYyNiq/b404iwjiGVNGxpPEcxyPahcaPuBwOuNqhWN8R1e+JCpmY7RQ04qeB
         lm05XVAZDP0n+uBQ7y7ZQbimlaXIF4YABCWW4t/CMe56MwPI7THCrZEHrex2ToE1B/eS
         hcyqzDkFWJiUq+6GU11pJiERa2s7rNa3mRLexhCjfYBpPBhKW0pDE23GGMHueHrJ8BKg
         xjCZd5eZzy6g73DR4Ulq8bn7ZqPBLbkF43hAKtmxZ5Lm9TpWk5Obit0+aSWDwkANsne/
         0FqcVAD1J343oDazgNUHv4svlDDGUmSCfxMLWLCBtM7Pn0KqESuGibgiKCk1fA4BsTQ/
         J5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194215; x=1706799015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RbS7SdUaAw1K/g37Ed+dGAKWi2x8GPreQeT5KyvnlQ=;
        b=M1SIjd2pHAbo6fAwto42a/DNcPj2tlmfPaXfTR1Fe2SYR+HZTBcauoKBTNCvu4m3mv
         3kncsCDT3Ka9iX00IfU3LMR6Ec4qq6+Eqf9tb1MKgRzueacm0TFBiacd5nY4fJd3LZcx
         pDPJigFmVAFG1Rl6UTgQxWkhGiT4rlpztGczjODIm1iT3cCZ8X3sDxKzl0sDS7TNrcy9
         a1Fl1ctPSDiFc/EZBfdwyCfaJwMWPZgl96kR6YzIXNMjBlsPRLrlJXm6gOdn2WkB1jNh
         Hn9kfkDKxGrkPJVYnjBG89AEuDF3tAj69RmsYz2ccLpjwzNks3QUXaRP5z6HjEDQWPvB
         A1Ww==
X-Gm-Message-State: AOJu0Yxh5WV04ArB1GmwW4aBxEBY9X0uLVWVaMV0Y4V0cP99vsflY0rY
	R235429mkAvLF+ikW7WaqDn6udxxHvoydY76C+2ng1TKuq3Cm5oe97a2yjE4nss=
X-Google-Smtp-Source: AGHT+IF3rsjwZxEnfNF6i1Zh7SUR5ZRZ73j3LOKjqeaRMZmPLsyBw6tsN1pEQ9sr6wHSVaZZSQO7zQ==
X-Received: by 2002:a05:600c:1c99:b0:40e:cc93:2f6b with SMTP id k25-20020a05600c1c9900b0040ecc932f6bmr604869wms.151.1706194214900;
        Thu, 25 Jan 2024 06:50:14 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:14 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 05/28] spi: dt-bindings: samsung: add samsung,spi-fifosize property
Date: Thu, 25 Jan 2024 14:49:43 +0000
Message-ID: <20240125145007.748295-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now the SPI alias was used as an index into an array defined in
the SPI driver to determine the SPI FIFO size. Drop the dependency on
the SPI alias and allow the SPI nodes to specify their SPI FIFO size.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 2f0a0835ecfb..4ad5b8fe57aa 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -72,6 +72,11 @@ properties:
   reg:
     maxItems: 1
 
+  samsung,spi-fifosize:
+    description: The fifo size supported by the SPI instance.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [64, 256]
+
 required:
   - compatible
   - clocks
-- 
2.43.0.429.g432eaa2c6b-goog



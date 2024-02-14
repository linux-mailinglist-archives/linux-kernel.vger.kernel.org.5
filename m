Return-Path: <linux-kernel+bounces-64622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D28540F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8801F2AED5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF97B64A;
	Wed, 14 Feb 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkjvLLHn"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA537AD32;
	Wed, 14 Feb 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872079; cv=none; b=VIW4G9f/KWOnBuCHw5aF/TkSN4K5tgBBL7BI8DVp3Df+aiYqvnQuQBc4BsYaBPqzw6b7QNaLApIx1gRtNQBT92Yhb1y4C5zeDpjPAbJYFnt1zCwFNhU1QNSqGwiaU4qvCY/Eh1QyloZp4qgYpThs94ZPn6WgfZTJNHMq9V1KzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872079; c=relaxed/simple;
	bh=jaE58dVT+Z5BQAhxxugZAsJOr197wav/S9cgS2l1Mj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blMnutjZ8vKhzv2RDb2/F6zj+tmVXYPAaKX13E8UbKosIGsRUws0wcMj4CKevyvvq8DRnlT6ih0kI9PeakDOoqlqysO0+qhIGUXpzpnlpQ63p64n0ax1WiWR6MBxhJEc3Y+IinKzkHje5QKq7YP4pzIMQN2rLBAYjpq7ibvDH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkjvLLHn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e10303de41so898991b3a.1;
        Tue, 13 Feb 2024 16:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707872077; x=1708476877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik8qJ3aCWPUVoqq8sIut4tSoLjkKaRHYoxxij3VGIi8=;
        b=RkjvLLHn4ebk2FttF+X1uItRF28lx0H32/zablDRIiLLohRjmYemIIb579u9WJ56+f
         SVWiPzQUFIgkmgMLSvzkFkozi3NXEzZL2ijplZmWPXg0ScpBxXUtocRuSyLvjcOARD+F
         VDZKIPdrVH/pgNkEcssfInTKmxNm10+jazYptQ+SplxYp1Zk2KEJ8pMlMcoQ+1A8Vgel
         QUtQgR0qEkI2rNA1AoluFp5niX6gSLgZk6BYyscjumxBU6df7+UKUetvvYx2cnLWV32p
         KmG+3ZN4srXg4pEJpQPFFI5FkO89m0c+ZY50mEb+rJuvYWASuc1cHwWt+RdDxq70pSx9
         JwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872077; x=1708476877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik8qJ3aCWPUVoqq8sIut4tSoLjkKaRHYoxxij3VGIi8=;
        b=f0nLXV5z/LpFV65nl61g2Sa8iIOVg7DgLlcWlcfzXv7rAT9gGblcdqkKhCfeoqXVLc
         OsBJgY/dkTnr3PW+5OE1AUNjWK+dIwNK1zG0LiuvqHFDcLKPt6bnE5qBtJ0Xsc2zRFig
         z9l/dgY+gMAXfKQnbl51dHigHq6wfR9pGUWf/UpQDqbHXMB+aW3TnmhbaU1wZJGamMCV
         jOMQ9jvDk9xxoHvRbjnEBPlPHmE/nwe88SvjvLXEj8HaW8TGTOhOoEtyJgqvJvOplRHF
         /rTro2qUnUjpzRWx/fQWP1IjFd6vUQ8xRU3lvGk/F1Ly/OmzDmeENNo4oqnEneuvFLil
         oYSw==
X-Forwarded-Encrypted: i=1; AJvYcCVxhx7RysmrotPqyRIhAwmIOI4Z0gZjsHpNOH11EdU7iw6BT/xNx60p9KB6kaMcWxEEjzLYWLtZDC3xKFTbwf3g0Jgqa7H3y/iefiP3Y3xJ8ChLF7spMnH0dKvwYpD4xbbUjFBOg+u45w==
X-Gm-Message-State: AOJu0Yz8oo3FshoMIPlF6gDUk90K7QKU36yGfMl2LjH5/9GkwheYG9XG
	MN/CvQb3agwMRgjKfr9FFVtgJuBwSWhdE6sGrLo3TRU83IWzXj5c
X-Google-Smtp-Source: AGHT+IGpheeiLwW//SBsF14UYTSlU7EveP7OitIBf6UHm6rJL6jNa50vvPvgf2w9aWjJPiG/glY0iQ==
X-Received: by 2002:a05:6a00:b48:b0:6e0:46ac:edf1 with SMTP id p8-20020a056a000b4800b006e046acedf1mr1080028pfo.18.1707872077120;
        Tue, 13 Feb 2024 16:54:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnguT6OkIVGW4ggbpKGoTxK6L71qamsSxSdUvwF10mdNemEO3vq3tzJobZU0X0OmLn3C0iLtIabscqBfxR6GzTb6CGOUYhhzJ9h2kGKYcsiSLRfkTMLMK4Ry8JuQyPiTS+feBipj4Hj5SPLlBPW0TyWfJJDRJUAG2Yza7DTJKkhZdcEOHwQpDqnG50PT8/sphnoMGU1jzTEUHJChWsXB2cwFGIvie6d5EKXUvXt7kLULSprAhy8w39U0JgrtYvNh55j+xyoLeJISh8EFpbrJQ/tKMsEZ/yUZl8xC6yKLQL/A/AMI18Gev/F+iEt4T4+4XSPLyz9EW230ZlWwUNxLoj1SaQrjYdgaFLLekRH72UibWl17XBXIn4zt15L6b4VdU3d2DiQ3oKamkbB2QeUY3t1SqeHySc9/9NZeLO9fstBmJyxnwdjc9hpAGeSRd0C0bQ1OJ0QkIEqne6oUhxgH+XQeWl0sN4BHl26kEcB+s+ts8DGwIFXvw7D7MAB27seF0ijRAtg4Z9YpyQzyJ2GxJcuM4P9c9Fn0DPIbN0/kCn9aPLjVin
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b006e094bf05f4sm8005694pfl.213.2024.02.13.16.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:54:36 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 13 Feb 2024 21:54:16 -0300
Subject: [PATCH net-next v3 2/3] dt-bindings: net: dsa: realtek: add reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240213-realtek-reset-v3-2-37837e574713@gmail.com>
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
In-Reply-To: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=jaE58dVT+Z5BQAhxxugZAsJOr197wav/S9cgS2l1Mj4=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlzA89Q7luKADGUZgWZiYNYPeWfYp8lZxwi1pYK
 ZvAahwWkNiJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcwPPQAKCRC7Edu60Qc7
 VsygB/9QsXTLWrMn1RGvjQYh6cgiaF1WDeOWERyUSibltZi2OzMOrvRr/Tfh2Ukq691Eb2b/2fn
 ngwPywiDNS7BHIBunNBcW7gytMw/5PgMYsEAErJV7vW5Yca/L2cJJ7pI8VMSZm/8jXgC9qNZwRW
 nj82KgqUKHipADDnjihiBb8LVFuLiFgdVTKaCKuOS2xbgaHeWin1aG1aN4QIFCnZB8Ct4MFpIq4
 MB351/swWgGEQV96ape6P6VlXvFd5WlpfSm/w6o6bXNmt9PNyktZF/V9x8IiCua0rIXId0HnnAd
 rBAbwPyPyFS/S6YqQ+a5Bp122pRXGBah9QnEp4HoHb1VzrYm
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Realtek switches can use a reset controller instead of reset-gpios.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 46e113df77c8..70b6bda3cf98 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -59,6 +59,9 @@ properties:
     description: GPIO to be used to reset the whole device
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   realtek,disable-leds:
     type: boolean
     description: |

-- 
2.43.0



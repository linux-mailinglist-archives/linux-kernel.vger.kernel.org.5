Return-Path: <linux-kernel+bounces-86608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971C86C7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C7283B92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C37A706;
	Thu, 29 Feb 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFPh2E+J"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC25645B;
	Thu, 29 Feb 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205091; cv=none; b=gBCGIGKFT3d0LLsEWnc189raASL0/O+NGo1w/s+orpq8UqoAY3ahk+78aFhpGM6aANHVYRMdhIeM4XHSRsi2iJEXgUl9/aNh8T3CgQwXVAVGAiafMbuC4zkrwHBTak7EEEtCgyZUXAkNXua1A3R/wsz2OQTFV6Cszm/wLSrzjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205091; c=relaxed/simple;
	bh=XPsbpw3Ya203VVljXb2dm7Y5oJM6qHuo1gKjM/dy0PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCwVJxWCGO0vGRWV3yvFPQpP/ak/eaFUE5OtaJWUSw+OSNwcPiUfPR5RAdgMALFpn4Ikow4Y5nKyBUMeJk8TFFPXkP/1F6CdLNYjxM/c6fgsEarbG1bew5bEWyR8Ipov+QSA0BKuK/574tg96RmiX4gypQQteVo6STHAmTT5NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFPh2E+J; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5629d5237so663167b3a.3;
        Thu, 29 Feb 2024 03:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709205090; x=1709809890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jO6eku8lXVRKAP6IeLQ8bJS8fk+8Lg2YNxQYKhinIjg=;
        b=ZFPh2E+J5uINQkjPMO0SU+RjQjQOWrIs0qW5eq7cbKlObjoXHDIEwKSRvjYnWin7mR
         ugbfrjrvKYnhIyz9vpb6HWrLPxD0bipKwAByKfP6o9Ol/+QE3TIakKuWyR/5fv7LbUft
         DdDYFOZAuYLz1Z/p/kkgeExRetQjgkrg0XYWq7uFjjVp0sudODWq4xXf4WtSe8enBAub
         GZLzdkuBCEunneruJshaSiFLK1S+31NHWIa1j3e3201A+DV0zsd3E0hUI6C0qGHSx9MW
         77e9N7lvgUwTd7eMn7bE3eyQVnAN7NSH4ZsKw/DEAVEinB3qW6JCEWGnGvu8+XWdBVrR
         hrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205090; x=1709809890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO6eku8lXVRKAP6IeLQ8bJS8fk+8Lg2YNxQYKhinIjg=;
        b=uJ5jVNVaBgsguKoi63LGiAoxkmuxsibkSmhBqtHCvUw/VgM0ZM4pTC8FGNH/2VxgjY
         x+gshSG+cfEHp3lO/9dLn/5EqG06mzO2bT9dWyxrtbcEzJPvAJrJdVlwvHFQzThcCnTl
         wxDbXi5YyM1GKY+Hu9JgUuaq23c21HwiVcvXcDXxnxiYosWy8I9W2S4BaxHh/+C4+I83
         0Iw3Uml7orsZboG1YawuSoVaTnu2lCmH4vXzrHTy/Saw/HRjSc/4HKTGVJNsFk1jW6iH
         Fa8xgKK+2tuC1fz30U/fgqhDT7s7+6iDH5sv4e4O09tRjxTL6AagDUueRnToj20Z150V
         WZYg==
X-Forwarded-Encrypted: i=1; AJvYcCVw6s40Y+tjJMZITCZZLeTGnGOSvwVI7cW7QYquHDThP6PGduokqsNSPxTfypEnhixLB3Dhs1PyJkRqfI97/yac4tlZzKIzGEHousN/Qn7D9UBwRj3RxfFuNQrHYytOTFpZw4SlbmA15A==
X-Gm-Message-State: AOJu0YxasOpCd1pmbstzobtfpoNH5OwTKXGnW8i238yDIGIkPCcwvNGv
	Rx6GIhgzZGNNc4GPraLPrRwDyKwr1Om58+IURdrmHlpstQrV6oAY
X-Google-Smtp-Source: AGHT+IEEUhledkGZQdNvS8ZfWsIcs1RBN17VYoP47ddRaH/RIRP8Ha9Yjztrg8wNgMQP8BGOPvGfxw==
X-Received: by 2002:a05:6a21:3a41:b0:1a1:2b0e:f23d with SMTP id zu1-20020a056a213a4100b001a12b0ef23dmr1034065pzb.62.1709205089685;
        Thu, 29 Feb 2024 03:11:29 -0800 (PST)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id k6-20020a63f006000000b005e4666261besm1059693pgh.50.2024.02.29.03.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:11:29 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Thu, 29 Feb 2024 19:11:22 +0800
Message-Id: <20240229111123.1932504-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>

---
V4 -> V5: Update all changelog from v1 to v5.
V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use a ast2600-a3 chip,
so correct string to asus,x4tf-bmc.
V2 -> V3: Add a label to indicate it is new compatible for bmc.
V1 -> V2: Remove blank in front of the string x4tf.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0047eb4ab 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1



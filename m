Return-Path: <linux-kernel+bounces-164376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A58B7CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E22280BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3C17F37C;
	Tue, 30 Apr 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A75TJBzX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC417BB1E;
	Tue, 30 Apr 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494608; cv=none; b=KW98NK8tNPZKR5ZUA3QsBeSarjOQD7pI8hArr0qmLn/z50d38DHUgniDqLzvOLUxqxvsI0gWvMNAi/Ty8j4uO5OMW9z0IFDs3902E3d/pOpIh/pzfvuogXEbVYXSCve1/czl+bAGea9KKPSlVrrA/4xPC8VhG2sYnl5CPSBdYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494608; c=relaxed/simple;
	bh=xxXwGUgzcyjKmbdWvmTXYmHdWOU+W3I5jGlXNZcADpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZR8jumZVIZBiKItLEQFY3qMCGEt0pgDnVQd2Y2owtJUft5nvvd3buhYWSC1r4S3nht5PHz7AJzZ+Mf1OeQHE5Bv84v1jP6NR4t6cIi3wBNm/GtvYmJd0UaRmAwVPzwh0ZLlsM6GAfqpd7T3i/JZ/7uUSqmhmejN6Ptlka3PoZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A75TJBzX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so54523525e9.0;
        Tue, 30 Apr 2024 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494605; x=1715099405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHavMm7bNBHTHKKGjlS2nj7k0TOoIyHmRNV2CUCKaX4=;
        b=A75TJBzX1S3S/4JRbQ0Fbc36vhHX068F/MEJt54Vai4qlfqouG+xoXxll0x3rJHuAx
         pBib4/DAD0A1LH6T43fnWDWaiU86YbKRblY+rPpQeS3lVMQJyxaDOCxYk+v7atXLrZnf
         bwYc6t2Sq8EOkYHXdljFFEHEr28hm3JnkXt8/vip7T8bX+cHGBdVaLLTCj7N5vC+7NJ9
         MHTEEVAm/oTwFNCE45d2IZzyWqbEunEntfDXQRNeN3dWw9Zu/7o0puUSNyPce1lGwLFg
         0o4tjOoHky2bGWN0b5dhwEyqMvWOiDuJ3BTX8ugRLGR8XkTcebf5zAqK8ldY9/89UlDN
         fd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494605; x=1715099405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHavMm7bNBHTHKKGjlS2nj7k0TOoIyHmRNV2CUCKaX4=;
        b=gDYBKGoVcUcClzLGDMu0Y5D1+q9sW69TbhBY1FLCuRymhHEyIkGO06VqWCDc+47iKQ
         DXzLJi7PVY/U/w802gAS97n/pEkXRkHKq2P4zawazos8afUOeI5UnGh9+2HP+JaF39+W
         LXavI6nq2vwX5HsP9BO6d77q25MV7YViRH8syLx7QPpJUlbTbPdhz2cSVAJBlQYtHaej
         4gleLpxVjIYD/fXSxmX4Q55Pzhl8Dro6qkiN0nIqZlyQ3CthHTWZGNKPf6iQsFHvUy6t
         MMc/7eAjvGFzD7XGEqR0UU4McWwfZl8iUcP+dPgGtCGT05RjFKiTmR2saoDcVLGGhOl/
         1ucQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKGiHKQKBiRk3e+1pNuvgSGw7LEvFHWDX83mUUvju8OhkXdbicjjTyNIkGyjSDVbttdLH7+KsxxI7nidQSYHLO5imoCQ7o2M4WRLoGQXPPRXaBcDW0v24h9AZwXKEiq3Bf8IyffcI0mfO+TEsemqxSzRb3A03RPHVZClnGc+i4zgSBXA==
X-Gm-Message-State: AOJu0YzzVjZoV1WoCkC9UQPlvnv6P0SdBlXQ934jUF85JyySma/8AHpe
	u3TWfekz3t+DhLaNu3vHeSlfrYx0mlJQjV2Dp0PTZQ/67DGRFD7n
X-Google-Smtp-Source: AGHT+IHWyQoArTTKLFm6tJkJnxkqN22moxU62bIxKKR3O1AOwhF9LWQWrkinWLRZOwX9+weW7VefXQ==
X-Received: by 2002:a05:600c:4f52:b0:41a:adc3:f777 with SMTP id m18-20020a05600c4f5200b0041aadc3f777mr42057wmq.16.1714494605229;
        Tue, 30 Apr 2024 09:30:05 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:da4d:6b2c:f166:22e6])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm46505396wmq.0.2024.04.30.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:30:04 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v7 2/6] dt-bindings: iio: adc: ad7192: Add aincom supply
Date: Tue, 30 Apr 2024 19:29:42 +0300
Message-Id: <20240430162946.589423-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430162946.589423-1-alisa.roman@analog.com>
References: <20240430162946.589423-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
in pseudo-differential operation mode. AINCOM voltage represents the
offset of corresponding channels.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..cf5c568f140a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -41,6 +41,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  aincom-supply:
+    description: |
+      AINCOM voltage supply. Analog inputs AINx are referenced to this input
+      when configured for pseudo-differential operation.
+
   dvdd-supply:
     description: DVdd voltage supply
 
@@ -117,6 +122,7 @@ examples:
             clock-names = "mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
+            aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
             vref-supply = <&vref>;
-- 
2.34.1



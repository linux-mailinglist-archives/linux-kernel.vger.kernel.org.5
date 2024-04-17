Return-Path: <linux-kernel+bounces-148958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73118A89AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D62F1F223B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F819173343;
	Wed, 17 Apr 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+FTHk9m"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F317332C;
	Wed, 17 Apr 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373278; cv=none; b=hiYg5izfPSSk3KRo6CwFVn+PYddaFridIdwXdYC1PQ+4E9Kh27Ipw3rvqL99Ci2yUTeMuLHQCnajLGSwLQLyrm6Z/SFoSnZa/gPo2rRTzY4wWZdij7qgD29yfPCVO6gAWbxXc70hPjON+Nso/wPNYvUeaS//xcji6TiV1346Crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373278; c=relaxed/simple;
	bh=TOyZKbeCGpd5qK8JqBhxEudXpI8VIDThjxkgR3KBD4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LtfekLQAd3iZ6LUyxzGnAY7+qGU3sSOPRUtzE5t6nRb3gMJzrYj+jEc5F86VonEEjGJqp8bMQ0WEb35Hs0rNsX9R6bZ3m8Jz3TTfoK03mIT3jdXW5lsXjCyBUQd1H08lPvuwYUFVvaK5o2PyG9j+DUWEmqiDLKFQHYtWViJsd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+FTHk9m; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so67940761fa.3;
        Wed, 17 Apr 2024 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373273; x=1713978073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCV+1nW68JSPi8LOst0Jr3R20tY+mLN4dqQafn+72gs=;
        b=H+FTHk9mWZoLDsfEssNGl06FYQ2XkcZqFaQM5A1uxNnWN8I3xVs98YJFoz63yA8rNY
         8yWAVaTNJzrE0YLZKgNA9ROJwi2sUvb4ptZaTlu5cWRP1uub41Bdu00D4hpogHwMCAQQ
         R7hPXZha4MNX7UgzMOjd4pLuHY3weDBn0blMQsxTrCtkxraBPkajByVbgVHtqHOx9fv8
         A+UUAVikaUjbM++Df85y0LPeDan41MDz1gvjFjbF9l65VVh/Uss2oJUFXfnzjkPoyJuv
         5l5QKXel+f90p16iMjxRGvEQxtTqrrEed+L5qv3rk7OCPzkytZZDOpYuxEbKtqQS/1eD
         PRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373273; x=1713978073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCV+1nW68JSPi8LOst0Jr3R20tY+mLN4dqQafn+72gs=;
        b=YoqFlLwod7285DKhCOe1CSB/c+NTlk0Flr7+6h4c0qIq3V0oAhIhNOfd2YD65NcclG
         iQIFIuAGK+equDtPEWv3aXEGNkiQ+jxSzhPzyUH+r06wrXSUsShbuDjdhFSgOyiGfqDF
         MgmFgMMFw0Qda48Kk6WkH6Gd3JgZwnpLfKSIRpbw74cI9hhYV23xwZYZSePPaU/Cm61G
         VlhRCccSWYWYNr4xe3mmhthMYX4VeRZGemE6Rb3GB9b+yjn8iNfivCPBlgqyHkpldris
         fEAm6p9DhpCul86bgGHjgMCBKtWMtme9YbLlZsSTG/LwnkfC7Qsdu+WvYS/WlW6mOeTk
         D2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXgVWfawCgZ18b+RpGCwyUHw2uN2KxvHj7UmeHOLEyjCyMAjE3Cgp6d2ZQ5kx4YcYhWPJoIf8t4PWDdzyv6Wrm2KU25MxFLqGA7Iy5fN2Om2tlNVNgxoZu/9tCgtM9isxkI8J8VpEM2joP5l1KYqPadS11dUAmQdCfXgJgYyGWP9Rd8qw==
X-Gm-Message-State: AOJu0YzEFNyRP9/bELokILPHUMkmlolF4MuB5xVwaBcODKGfN+1MnsDE
	BKHkpvUOltqbSaE9u7Dl6SOlUkW0KogLfJzBkXroN2wjawCIEhoc
X-Google-Smtp-Source: AGHT+IFwgCFu/sSAPuv3xp3yaJ0ULBnAv7pNb9bLlOcEAccJrbHBak4G6ZwupLNX81w0GOcglWvZ3Q==
X-Received: by 2002:a2e:8046:0:b0:2d8:658e:7e9f with SMTP id p6-20020a2e8046000000b002d8658e7e9fmr10318053ljg.39.1713373272538;
        Wed, 17 Apr 2024 10:01:12 -0700 (PDT)
Received: from spiri.. ([86.124.122.31])
        by smtp.gmail.com with ESMTPSA id g2-20020adff3c2000000b00343300a4eb8sm17949441wrp.49.2024.04.17.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:01:12 -0700 (PDT)
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
Subject: [PATCH v6 2/5] dt-bindings: iio: adc: ad7192: Add aincom supply
Date: Wed, 17 Apr 2024 20:00:51 +0300
Message-Id: <20240417170054.140587-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417170054.140587-1-alisa.roman@analog.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
in pseduo-differential operation mode. AINCOM voltage represets the
offset of corresponding channels.

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



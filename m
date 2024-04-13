Return-Path: <linux-kernel+bounces-143764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC38A3D24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCE81C20B40
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A545970;
	Sat, 13 Apr 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf4/L0JM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493111F94C;
	Sat, 13 Apr 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021175; cv=none; b=p8BHyY8BVebT66z/SptQ2QqEbNlJ6gxJVfPdSFe9swo24UZEaM79xR0eYPS7pLdk2HuPXApQQTpzt6W4R592f7/H47T9irJ9p8d01JWubfJ51EDmEkscYGOIA8XDQTvMqbUDsyEvkWnOqygkb0yQLQgCi9EeNfUkWHN9XVc//MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021175; c=relaxed/simple;
	bh=7DFxNs6cCw28WpWPlFtO5E2+9N80ZigYuLgXuDTJF8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYfmQNLwNPVjgDgxkdrzrPZIBHvxwCz9iHHmU/wrGWKpoh5U5tuCmc5u3oBSw+8AQs9DDr6K+MbR/zVGyS2VjXkFV/q5ljGUsJQwu3ox3yfQK7GkNFCbmCmxIwhgZAKwHbIFKZJaReeE/iQHS3JvJH9LGciTrXMMXznsttjj+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf4/L0JM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so1472896a12.1;
        Sat, 13 Apr 2024 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713021172; x=1713625972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBb11tvx+5eI8LczNJrgwOTTPkpu4Q5YHuvpeo/+GrM=;
        b=Vf4/L0JM6DDX5TnUXKplsehsvWVtdso+6HNOJPOqmPbNQXXFLJgGADHqYolWCM9E25
         mCE4gI+vikkzXZhthfHxx50SAaJGnmlZ0O4bAKhrxB1vR5B8VNW8EhEFrNWNcjnYp9KO
         msr1v9odo/Z26f8FnDXRsEk5xMDzs7nFno/LMy8FIsMsxBmP2GHyoXPx8kg81crOZn17
         dvXoXFjD81hsiZLxgKqe0PXA3twxFjIBRKbAqnNovQ57QCWxS6dlnbcwnHbKYlQIYWC7
         mkzo5Vo1TFw5Jq2KOJy1w3n2Ij70KNYh0UyamsHiTwIM5GoKiz54aV9cFx0JLLnvK5bA
         Qw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021172; x=1713625972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBb11tvx+5eI8LczNJrgwOTTPkpu4Q5YHuvpeo/+GrM=;
        b=krk9o1rz/i3Z1fBMb9CgOdfh2d3IBr4jQGbSX0ppAo4tvKikIyXkc4SZLuZV7AsuiY
         22ydD80p6rA5dgSoNF/rMB/B8gQrMo5t1Fu0bRuOmFI1hU4iticNu27Ksc2j5ACdZdT8
         ThrGluWV+eSVVNAwkfMOWle4JXKM/nQmkiDkjReXbqHjtt9wouIps4v8MVyrmhbASD0E
         o0VNKY663osEUrUcKjRylbdNgwM4/J0HIhgynXnhxGtYtze4GDBHnmyl0l2xul/aoAI/
         Mn8eJ8smrfBT6kkAOgK0B2LSalEjoibr2OmzYyWyo5c2mfUx/00qe33LKcjZKnk2kiv3
         2SVw==
X-Forwarded-Encrypted: i=1; AJvYcCVfWRDgo7rgQvrMnBU04oFBXw1oZ/TEpWFn7KcRSlHMYpYggcCW/QLGsBIIXPE8s23uT1v20/TWv1/0JUcQdVvUtSlA7Qyfp0n7pIIgVnF+/pHptjhwRZOnX1K7s20Pj7dgeAkVWYkrRjDmABdDGKJyDc9eAl6wEwtn+vtEwNQlU27Duw==
X-Gm-Message-State: AOJu0YwdQGrlUtK+73adN9T1wgfWP4AX4tVs7RtkSeLvoQTU70p0kj5i
	c3RD7Vpj2KAGe05kLcdWfbBaNlG04MGEmouP2MpblP5Izy1YZpjN
X-Google-Smtp-Source: AGHT+IGYMOu3Gkzq5afKgGUw+AgREB9x270AgBtuh2/Bwqk3fdetT/jgQXBB2GariPF7W6U0MVV1VQ==
X-Received: by 2002:a50:d4d8:0:b0:56d:f075:72f6 with SMTP id e24-20020a50d4d8000000b0056df07572f6mr2750727edj.40.1713021172473;
        Sat, 13 Apr 2024 08:12:52 -0700 (PDT)
Received: from spiri.. ([5.14.146.31])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm2749883edv.22.2024.04.13.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:12:52 -0700 (PDT)
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
Subject: [PATCH v5 2/5] dt-bindings: iio: adc: ad7192: Add aincom supply
Date: Sat, 13 Apr 2024 18:11:49 +0300
Message-Id: <20240413151152.165682-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413151152.165682-1-alisa.roman@analog.com>
References: <20240413151152.165682-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AINCOM should actually be a supply. If present and it has a non-zero
voltage, the pseudo-differential channels are configured as single-ended
with an offset. Otherwise, they are configured as differential channels
between AINx and AINCOM pins.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..ba506af3b73e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -41,6 +41,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  aincom-supply:
+    description: |
+      Optional AINCOM voltage supply. If present and it has a non-zero voltage,
+      the pseudo-differential channels are configured as single-ended channels
+      with the AINCOM voltage as offset. Otherwise, the pseudo-differential
+      channels are configured as differential channels: voltageX-voltage0, with
+      AINCOM as the negative input.
+
   dvdd-supply:
     description: DVdd voltage supply
 
@@ -117,6 +125,7 @@ examples:
             clock-names = "mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
+            aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
             vref-supply = <&vref>;
-- 
2.34.1



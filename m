Return-Path: <linux-kernel+bounces-112822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E3887EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11DF1C20A7D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808810A24;
	Sun, 24 Mar 2024 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5e6yOoM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093CD266;
	Sun, 24 Mar 2024 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711308037; cv=none; b=JrW+CIKqIhEr91QrLcKOF3/fQbKGW310LRWir9M6rklO03Gn8o3y2Q5T84sIGZ+M1Y5lr8ildRh8rLtKy6WzDK2zqY4m98JMZlplD7kDBm2Wl5wS9RA6Lo0YZN5z8KwjizrmcrMlZrNT+9zzHJxPuIknSFJTdAHh+whoWfUnP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711308037; c=relaxed/simple;
	bh=GrXjztPw+XYfY9y2yOjcFyIrvlmcxTnXaibHQHc1YxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LnVbcZ/VuB/PuVWHjkDBYVCb4Kt8MH5aM3+9Cc9RgT8bDkUTHvz6gnkAWJZf5sKqxEo7OZINAyk7SAt4fulr8Hh4of2M5OIyQZC1njTN857O0OTmr/WpRt74HHax7vSZoUD2GoTwTJGu/zDdlHVJED9uYo+NMQ/7ZFMWI0X1PV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5e6yOoM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515a81928faso632708e87.1;
        Sun, 24 Mar 2024 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711308033; x=1711912833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZYnM0jkKAq47KvOpn7l4ei6Fc6pMxgv5dReNbRmKIM=;
        b=c5e6yOoMHWfNFWdjuOg5LkIKiRAPZ1qCq+9ZlDQSf1f7+HsW8bdYte4y270n2oEmiI
         oR33PxsEVmdUyJfjmP8YKCgO33K12ogLqsRz/lXE2rpCCEj2WlekEzBBp4VDPW+RAwC8
         3rZlhQP1YCGlzlwZ73dUrMimZoRu6khjY3cT2IQP6hhSe6F1rYV1BGZZzXy3ABt4sSi8
         SQ4biEsxgrwnhHB5BULesiKOFfFJuD2UXFrGN3Dkd4rx5DvO4JxWXFZsqNMIDxI82JWr
         J/ogNIFzzBaErynyE598QRUzfnh3CnzbB6QEX8vHAueh1e/OBxNuzjcwnM1+oRUZBLPi
         +9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711308033; x=1711912833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZYnM0jkKAq47KvOpn7l4ei6Fc6pMxgv5dReNbRmKIM=;
        b=cnePsTlq+oZEpJuPB+Qldz8eCCkGaVBu0WPGdeeHvkLVdZBoWxyCfGY8jV8S/jkPoC
         UmRO4KBhQ/lFAt4RARKVtofd/s9TBkUEUOwbnUtiZmpdo+IZhbRdTRSwOfdSkTwDMjil
         CSz7wV4tGsHboVrTdnXCppRzsfFTuU5RYtlYkJm18xhVCLqg//LYxlBbYR9ZQdFWAild
         aRipE/Fj8ObKsU4EL9K9e1GeEFCeOheBLzUUWlPA28l7iT3ZP6aTgUy0j1/mxzrUqJF5
         ZaH7aswABsgWw7vw3jnEzCNuxPKXKkk77NXBUq3YJAZ2960bZ/ubevZDIgWPrGg88TPR
         7zzg==
X-Forwarded-Encrypted: i=1; AJvYcCU0FqvJpbvqGMr90GpeV2ToiNfh8owTMR8XTCB43bEB13ZI02/KrfqoLof4sKKI74uPMFGNqP2Ut76AXZcWilz/iUOUrTaob11jaLb3yDZp5Dg7R4Tom2UGM2SXkAzbrM17ZMi847gHog==
X-Gm-Message-State: AOJu0YwSEZc1jah8BBOKowmQpTu/LdE5wyWDcJ3u7/0IuVzgsm/xPuYL
	RYx4A5iHAZx8qsZTCSBH8P067MAwM2ibgbtGZTn9pk3LjVQFm785z6g3iMtqnGpJsQ==
X-Google-Smtp-Source: AGHT+IHhHdZDefp8A684pnpcHoRSLxnIO8WQbPQ7HrES93d9SS/oXDPzM+rOfuCCSAr/MmzYCNK2ZA==
X-Received: by 2002:a19:5e5e:0:b0:513:c5d6:8356 with SMTP id z30-20020a195e5e000000b00513c5d68356mr3405938lfi.12.1711308033200;
        Sun, 24 Mar 2024 12:20:33 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2e5e-f14e-aa7c-2010.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2e5e:f14e:aa7c:2010])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090639c200b00a471cbc4ddbsm2248205eje.26.2024.03.24.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 12:20:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 24 Mar 2024 20:20:28 +0100
Subject: [PATCH v2 1/2] dt-bindings: iio: health: maxim,max30102: add
 max30101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-max30101-v2-1-611deb510c97@gmail.com>
References: <20240324-max30101-v2-0-611deb510c97@gmail.com>
In-Reply-To: <20240324-max30101-v2-0-611deb510c97@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711308030; l=1505;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GrXjztPw+XYfY9y2yOjcFyIrvlmcxTnXaibHQHc1YxM=;
 b=waheubPkuVz70SJ/AMeaa/3zmN6lvRu3hweA86YtLBdYR9fT+pZXBk0eNxgCTSz4FveHORwGv
 uuuuVLFIZnjApKBAmd7Wm20LhytKG4NFGdSAJRqhWKD4YYoyBvTbyiC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Maxim max30101 is the replacement for the max30105, which is no
longer recommended for future designs.

The max30101 does not require new properties, and it can be described
with the existing ones for the max30105, which will be used as a
fallback compatible.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/iio/health/maxim,max30102.yaml       | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
index c13c10c8d65d..a0fe0a818d86 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
@@ -4,16 +4,20 @@
 $id: http://devicetree.org/schemas/iio/health/maxim,max30102.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Maxim MAX30102 heart rate and pulse oximeter and MAX30105 particle-sensor
+title: Maxim MAX30101/2 heart rate and pulse oximeter and MAX30105 particle-sensor
 
 maintainers:
   - Matt Ranostay <matt.ranostay@konsulko.com>
 
 properties:
   compatible:
-    enum:
-      - maxim,max30102
-      - maxim,max30105
+    oneOf:
+      - enum:
+          - maxim,max30102
+          - maxim,max30105
+      - items:
+          - const: maxim,max30101
+          - const: maxim,max30105
 
   reg:
     maxItems: 1

-- 
2.40.1



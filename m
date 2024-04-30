Return-Path: <linux-kernel+bounces-164378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C600B8B7CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65FA1C2333A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB031802DA;
	Tue, 30 Apr 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcZkkDzt"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B81802D4;
	Tue, 30 Apr 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494614; cv=none; b=ZkSUCTlga2Tfd3KZN8snlgp8cV6gjJgKTekCJ46fwhbgdfxJ1IoGorRpEk4qqVQXWOZFTneCzN0NURqdARD5Nx9MgcXT/Vnv7o6IeuXmqJu7D453vHjzgcK7d9lmZSKTBAt31jm6TGljESfwmnxOYgSTLyWOuHUf/hzYbOCbECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494614; c=relaxed/simple;
	bh=1l18mfE8wyoRHpO6f9b1gnMlgK8PKnoa8Ycot4xvN3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4PE15ZCCfRR/QZQ55i+UArELLZum1Q1NadsdJ7JhLX9DNow0j+bKpqJUzX5H/P3aWwITv7n475faXiz2TlOWk+szeRdehv5Xn+KUhCzh7q5nSoOPWetG6GG7tfi6cF406+a12XPiP2b4YCa3uFykbT/d/F3zrAb9Srr/7KioqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcZkkDzt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so71258001fa.3;
        Tue, 30 Apr 2024 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494611; x=1715099411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKGyr8ooUWLvcvyQZTaIw1vP3EpPrzjAmCpAnM0qUZ8=;
        b=mcZkkDztIXVuwZrPivYIeG2iTey5XeSKaEWjQQjW2/odNW4TAF5vULGzjlhT4a1Y2W
         Gox+5PfD1wYUQKYsFlrw0LPnT0/GrE5jvrPkFJSSGhZYORW0VGWWMqY4anPAKWfU5skE
         Owg5SexlEWe2GHvGQZz84AetuPG4iEEm6skpIzmPCX7V0j6lLyPJI0zuGyaVty+Zr1zj
         G2S3BIxorCce9oX14ELsrXP9rYUjwOQ7cinTJf3nX75ffHz+Z1yHs9v7Jdo2WWkrL3ZA
         dqRTlsnpSaWHjToNTNVEWNpND+1G5wijhZFWkRAAGxafRKb7uP+bPzqqLnC6f/VNzF1R
         q5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494611; x=1715099411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKGyr8ooUWLvcvyQZTaIw1vP3EpPrzjAmCpAnM0qUZ8=;
        b=xUj++NQe8kuTPDozgsbIGclDLA+jhBGA+qhhIaLieVSgmTYCaS/Hzi8ed/Pvr0m5KG
         XyBsZL48YgaoLmpBzz1xbS/F1hKChV7rl4E9NjSq7fJFHG/MoBzSUaFKpQ4SFrN+lw+X
         uXMRVTuQYY0lkuOvVLv1fscFdAzLEwIBku76TnB9ekpVoDhE54zS8qFvwOaB5/xBhrPm
         1Kjmj/Y5PUsRt/vMEz5FxqEcw0byj1U428dFRGgLZFPO+pexoyOBehmSOBb78xe76TcT
         lB9efkF52F9YE2Oj0Ne4sQ0Ty9TJYLn/SFGVe/GmXSWnMCq8gPX/7/TSC1i8v1e1oML2
         PVeA==
X-Forwarded-Encrypted: i=1; AJvYcCUPciptGeu17l9kieOJCzCp6G3d6pO1UX1xwKEfvgSt6QEZqDpQoaRJQGvEfDuLuzmznRth3IqdubRfc/89GcMJ5moHEvnVGl8S7YbHwmXchxRGT2/5yJppYGtDrJTJmzDOOyDMZUGvjtbgV/4gak9+dXJLCUhygUwftLDFx/yEFL9PLw==
X-Gm-Message-State: AOJu0YyTukdKlM6c9ZcmWlutbjK/DGFHfvowmHwDXXkDApkr+jGdqPdo
	oGMlNGD1t5qp75zZyvCRRw+3uWw5YxHCx3bT2l6FRwzQsOMnoVcM
X-Google-Smtp-Source: AGHT+IEh7OyEak1WW/GbpXTV9prm5LuMO8ngGMvVqM1T/iPDCKbDBbmT79+mPB/FBlOJTen6M8ivyw==
X-Received: by 2002:a2e:9247:0:b0:2e0:6cd5:cbd6 with SMTP id v7-20020a2e9247000000b002e06cd5cbd6mr167212ljg.6.1714494611516;
        Tue, 30 Apr 2024 09:30:11 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:da4d:6b2c:f166:22e6])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm46505396wmq.0.2024.04.30.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:30:11 -0700 (PDT)
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
Subject: [PATCH v7 4/6] dt-bindings: iio: adc: Add single-channel property
Date: Tue, 30 Apr 2024 19:29:44 +0300
Message-Id: <20240430162946.589423-5-alisa.roman@analog.com>
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

Devices that have both single-ended channels and differential channels
cause a bit of confusion when the channels are configured in the
devicetree.

Clarify difference between these two types of channels for such devices
by adding single-channel property alongside diff-channels. They should
be mutually exclusive.

Devices that have only single-ended channels can still use reg property
to reference a channel like before.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 36775f8f71df..0c3eae580732 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -38,6 +38,14 @@ properties:
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
 
+  single-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When devices combine single and differential channels, allow the channel
+      for a single element to be specified, independent of reg (as for
+      differential channels). If this and diff-channels are not present reg
+      shall be used instead.
+
   settling-time-us:
     description:
       Time between enabling the channel and first stable readings.
-- 
2.34.1



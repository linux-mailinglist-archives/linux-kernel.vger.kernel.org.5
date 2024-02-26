Return-Path: <linux-kernel+bounces-82336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7738682FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99DCB2340F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FF013172B;
	Mon, 26 Feb 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hswmQevp"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAE131E24;
	Mon, 26 Feb 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982764; cv=none; b=nrAYP0iNccttNf0i3qxWeLNOP/nLyVh2JMwtg/VYq2F0L2w518P6rzmkj/LGYp5arWsJEsEKK91ZQz0ISmaR2wUED/S+MC+2KHSOhnZ0I2BRaCw3QvD0yGuS40fmOniO96XyxV6J4zTh0I3yg3SkJb9PFdaPTIg9jsJsbN6CWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982764; c=relaxed/simple;
	bh=plh10VuMojhQ7wzSifZveM3iRuWPqiS+3GR/CvVqCLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVQzkhlMafoMwEaTmP0CWOh7JDKTke3u7ce7EO7LY/TkJsK1LDw7F8Qjz8YVKjO0UtPQTaIZNlMtJJdo4VIJGEZfxu6Nj2IvM+0iCAeXE2ugX3QDgUYMP93CkLPPKPZPQ7rpUT/s+xVO2kBjcQb+5sBour8Ov/0KESza+JDN3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hswmQevp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a437a2a46b1so121673066b.2;
        Mon, 26 Feb 2024 13:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708982761; x=1709587561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjOh/UQPhwu1ysWxAs0vISEfQvcgjub2FXkP8IJA4e0=;
        b=hswmQevpCXznZZRXJOrjwBeD358Zz1R3m/9wtQmGbxsGL8vzHW8LxvKf7RiP3RyET7
         jmDrrMldC0Ue38Ey0RDEnPwgAx6Qs/UwKPxiix/NIKJUSeIRtBzac6Mov2/VRUsrZ1Wt
         w8/qWo+A7mmKqPNzIhPowC02dKkKwZifuH+Z7hcn7Yxj6Lx0hrAuvHJQkvMiBSJKe6tK
         QYM6Xg/OOh2zwbpwx2do2tz8A8bmxIyDWAfLSnlMYjmbqXn/OgpIDsQZgPnwvBY/JLkO
         m7dEKkbTaKaZInlhdY6KzWPiPU9V34KHf73GHcVhYW6okndadg7RrxpVJxR/5ZzDNQDs
         TRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982761; x=1709587561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjOh/UQPhwu1ysWxAs0vISEfQvcgjub2FXkP8IJA4e0=;
        b=qO0oPfrM3JUlQIkQIq3DS6Ct8oW6PytpMAbCo3IDogxwH+0SgJMgkYC1//jK08KpHz
         O3T5edNMJVGJobe6wmkjO9cVVYeBfbUrdHnR/ML6N0LcsbYfWAsDPPMfCOEDqgmswzgv
         +n1cJ8sJ+0Kbzd8Xj2mTEEHjdZfLtW9dO+wJpQBW6OOr7y+Na22//J9lK7mQfT03XsfP
         eAkEVGX74fhQ2A7oiKO1R9ETV+ZX2WMFcB/FBBRY2VBrDMmQgA6Rx46ZWoFGB+dr2bZ7
         93sfObggLAIIiVpKJQOQTLD86Yvff8AEWEZdL5mi38SVExEF/zUb3ShBVGr6QxIJK4dW
         MKqA==
X-Forwarded-Encrypted: i=1; AJvYcCUQHmU8rrnbhnbOmICuKfGet2z4FewgH8p7Z1rF/S5a5EylzMAk2ZWP/gM9ncTRM/zFlAL4XzCDKht1Hlu8AbOczXmNbwMnRHD3M6nVpjwPsOXCuKYP3Cch1qZ7NGJ/L5mB1ThbPtHZdquMzxin99sL2bHbh/D2sflEt1T4q6+ZYfoS8Q==
X-Gm-Message-State: AOJu0Yw3r6iNCvtjPuNkT7oPFzTuoM+m+P22sRzG08AWLeZibugZMrqR
	89oD23RO/MVWS2DDboJco7Ei10kkEVkPSw+Raz/wb/qkrk9/e8RbeobzUdUAEjQQ3A==
X-Google-Smtp-Source: AGHT+IFNMUIeqPv416XAvABV+6Ykhm1JLZB/tAXc76TCa718VjoZvY4Q0PhzJTsjiP7E/KQtsQUCLg==
X-Received: by 2002:a17:907:bb8b:b0:a43:827d:53c5 with SMTP id xo11-20020a170907bb8b00b00a43827d53c5mr1533588ejc.32.1708982760734;
        Mon, 26 Feb 2024 13:26:00 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-06e1-5ae1-dc32-d149.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6e1:5ae1:dc32:d149])
        by smtp.gmail.com with ESMTPSA id uz28-20020a170907119c00b00a3df13a4fe0sm122386ejb.15.2024.02.26.13.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:26:00 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 26 Feb 2024 22:25:56 +0100
Subject: [PATCH v2 2/3] dt-bindings: iio: humidity: hdc3020: add
 reset-gpios
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-hdc3020-pm-v2-2-cec6766086e8@gmail.com>
References: <20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com>
In-Reply-To: <20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708982756; l=1261;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=plh10VuMojhQ7wzSifZveM3iRuWPqiS+3GR/CvVqCLs=;
 b=9SlNqWHXPe8gZiGxzTnvxP1t9rXDzpK4ZkSCDpUJuK/rEz6XW+MjTwUjiLJodTrvCOAYagqLI
 62PvWnClLJgAz033D7FPtwe+AzbpuZ4ieEo2ZUZRu7WTxQFVnpi7ylw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The HDC3020 provides an active low reset signal that is still not
described in the bindings.

Add reset-gpios to the bindings and the example.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
index 8b5dedd1a598..b375d307513f 100644
--- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -34,6 +34,9 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -43,6 +46,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -54,5 +58,6 @@ examples:
             vdd-supply = <&vcc_3v3>;
             interrupt-parent = <&gpio3>;
             interrupts = <23 IRQ_TYPE_EDGE_RISING>;
+            reset-gpios = <&gpio3 27 GPIO_ACTIVE_LOW>;
         };
     };

-- 
2.40.1



Return-Path: <linux-kernel+bounces-73718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697585C7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01779282892
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52901534F6;
	Tue, 20 Feb 2024 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2pP2Nv4"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57080152DEA;
	Tue, 20 Feb 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463706; cv=none; b=NCxukVDc2OQQFH9juRd5IhLATPOldUP3XqEdGBOTe6+bBXW1azb1cTzy9YJePGfs6nsGuSLNblrd5mq5GxP40xc0PS0+v0lNp/+qpS3lLXHzL/3eIuKf1VkfzPBNQJm8be983Ol5+VkGj64IiTaPmoEBecPi2SrW8tILPxFCjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463706; c=relaxed/simple;
	bh=plh10VuMojhQ7wzSifZveM3iRuWPqiS+3GR/CvVqCLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmSEeOw3JDkXXDydDKzb6uXsjMQsFk8NI2HOh0aLSPJrTh1vY+usMgTG26+Zbgn7/87oVmrPC+qz/G9Hi3777MeelnYrOJRxdwtjSfBeNd+YuTpwUbeeWaMgCVSvJ0FFWCyfu7r53DmfW0ZYm4Np6wK0NV3+/G9h4dLSv1QYMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2pP2Nv4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso4806151a12.1;
        Tue, 20 Feb 2024 13:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708463702; x=1709068502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjOh/UQPhwu1ysWxAs0vISEfQvcgjub2FXkP8IJA4e0=;
        b=e2pP2Nv4AGLS5XYkLBXkAyY7MuzJHYu1Yv1FK2VzX0Pis3NQu8hlala7tChDY67qR3
         EoDM2Xkl61Gzn3qeXwBCa8ndMVdYXPbH2OYiu/fG82PDe2MBvsHcX+FBltnX+6oi6y+A
         Jx60Nb4jfStB5q3B2qGxaLDV0L1mpgNX6taKoHg9Bb0A074iZ7a8NP/WK1GM9gIj72QF
         bPfjvVt3K0VmBSUyHTDrOyn5NntORT8IqNLaeaTAefahNTwZ0epHNwbojv14mo+0OdT6
         OYQtiMVTUb9Uqh83qCmKN+eniCTmyypB0REA8tLS4zQ+wXmkwvcjSbv4OOdSKLeI5oAB
         9+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463702; x=1709068502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjOh/UQPhwu1ysWxAs0vISEfQvcgjub2FXkP8IJA4e0=;
        b=gbUz1F7OKXnmtsART5AmSmgDZguNjlmB4F5nTJAK5KrBoQhR/f2t+BTWXOVpPzdT9Q
         aza5jEKYPW2Pm1OvJN4+9sDknubAReBlIDkR76R+VjEDzfmCRv6zgKdnK6UZfrvdRnSK
         X7mpsCJPox9IGkpxIqYPnikkYKJg0sf7zczYxQegp6ZmApd4MlmsVad6rV6kjt07BVYU
         9WqjDQV4oprjwsZ6MBAmMNyLAV67Kb2zB2dpPD57wHG5M7oT4SQJ3s+GSSACPfv3w/Pn
         qM7NmbRxsq/sm9syClE8TWKPDSdq7PGTONUuDGI4t1R7t0NZgP6vhpDuK++KgnxKMdQq
         Q5jw==
X-Forwarded-Encrypted: i=1; AJvYcCUm67GxJTHLs4RkAtIcCQopepFptS8fG2ohjoiNvFyR1oTDuWWWY+CHU1MjDoVGv6NWyrCwf+j3giVPFvPFQFdtSSwv75XrQ2tJeoAyyULAdYSxXreWZVF7nr8EheZXbF63GLLk9kOGe84e3VzuV+T/o1FTzqnO7qN6vUC+qaG2YH39OQ==
X-Gm-Message-State: AOJu0YxgD/4f8+s/QZVddBnrKOfd56yyDUKBC6SfvWUoVQXgHmMV9eC+
	TzJBy+azRSggg1kex8MR5faKn1K4nM3yJOLTcYVJGKUY7nR+xJbBZm+DFARN3vuG5w==
X-Google-Smtp-Source: AGHT+IFLdUG76bEfHGUm3xL49D66pMvD1ulYU3aPskEtnAJZpeVkYzD6gVSJVPtVYJfg8GtofqXv7g==
X-Received: by 2002:aa7:c746:0:b0:564:5764:a5df with SMTP id c6-20020aa7c746000000b005645764a5dfmr5123925eds.27.1708463702035;
        Tue, 20 Feb 2024 13:15:02 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d60d-797f-077b-a805.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d60d:797f:77b:a805])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00564da28dfe2sm538137edb.19.2024.02.20.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:15:01 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 20 Feb 2024 22:14:57 +0100
Subject: [PATCH 3/4] dt-bindings: iio: humidity: hdc3020: add reset-gpios
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-hdc3020-pm-v1-3-d8e60dbe79e9@gmail.com>
References: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
In-Reply-To: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev-8b532
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708463696; l=1261;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=plh10VuMojhQ7wzSifZveM3iRuWPqiS+3GR/CvVqCLs=;
 b=GnHgNYg80trx+7eLcOPnsNYdIJ2vZx6nca6RTKiHYbyHH3jh27qBRlTPMMFma+e7xFCerehSP
 z8LVP7UwzbHAbubqJa3vMx7GA6S87moFCcSpP78Kd4LA1gcDjBCnDfU
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



Return-Path: <linux-kernel+bounces-89920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5A86F752
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244981F210FA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6247B3E3;
	Sun,  3 Mar 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLqBTsJK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD27A738;
	Sun,  3 Mar 2024 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709502870; cv=none; b=X+Z3yHJN6SZuNcfOAaaTWzMRqbrKYBIJA7pgKz7VquZLMAC26sx6StIEelCpQebOYmAmH9qNwrr/CLbMKi7C1SkPAgp2Map4jkGm7vDSy+JksfLgj/W1ozSTeZ6NtbGY6SynBpjdIWpDTdTcOMHH2yPQ3lpHFlPqE2ci6q+s1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709502870; c=relaxed/simple;
	bh=FyoFAj3XNHmn1ZPjLNGWR7C/mqk62+JmZYN8Us3NcAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNtN7xWHVM1FXrlGoDGNocQir/+s3Kr4mNQiWnC2Ak03Zypq26QMF7seWgzGEJW+aj9y+F07j2TmMT6nrdW8s3gE3T7iLkliIadGQ00j7vqo6l2dJdSOblIfngLXvC+/ij5YrwKBg1gT1HAlz2n9p0i/sEJVv24BmP4rdQGMQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLqBTsJK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d28464c554so51613111fa.3;
        Sun, 03 Mar 2024 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709502866; x=1710107666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYWBE/cU69IZWYVF1QnqRyE+9E0HjWVFlCV9Txn1TiE=;
        b=cLqBTsJKl7BkkD8gAi5g/33jlytYWDXZOkjiZq5NvuXfLXgSPJ/LAByg6Acj0W02Go
         3v487MEiTyD1OGOKepZUJpH1n6Jd7COMyubiBmSWXF1Anjy3AYYK4vxvsQuflvjJlkQD
         JAWjhMKgqqdkFewyMsL4ZHklnKMnbN3bWqxhMHkuVXzemnKdZm5LULR0YrLAKgW41MVg
         ZZGWlwNzkx3GepHX1QVYIqJBMRejtJq0S8Wf1BwL3SPzdC5byulA5wh7t1tiud9xxFSe
         6Ej21Wptzb2FVcMMSnMnbviCl6ulQh+Le/0aeZqOeOdsf5qVQD0/RhI2GlfeYMQIQG++
         q0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502866; x=1710107666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYWBE/cU69IZWYVF1QnqRyE+9E0HjWVFlCV9Txn1TiE=;
        b=i0EHo8lSPty6qai0WZgLDvO1rC9AyPBS0xHsIUZA3vn1FQ0UxAXSLxFtQSYedusr07
         YqWGq1ypPotjVPvyvj74QnERR7GD9JLT7z+LXtu2vPVnlheo41RY/a4X+ZX4nBk6oUaG
         NXwRkFOTWyS0UQGZoJ7qP7+HSf8Z31C8ZzEBKDUp9fLja+kMu/4bHpouHTil0fu5MG22
         UlvGQi121gxSKIg4siEr4amHrCVk2XhKKO1k2/GPUdMh6iPMdFq00y2XGIWdu5QjlAdI
         oEekAgZ1zBfWqwlQoUYNmagwHQ1wfcgFw8PgDfKd3VmB7codHWyNKSnoZF2V5FKpkY1V
         /ZAg==
X-Forwarded-Encrypted: i=1; AJvYcCWnHm70ikBC/i9KmPs2XkgAwPBEt8ty6w+J5a4iMx7qlmIClrxwMAnYf76zHozlu0/g4fdWg5Ny8MNExIfeAldDYXkm+xaC1ZP8Tmq34QmryJyR8okWVbCt0TlBBzwufODz07CDFyKcGyykD1YXjlSE6ezUKDELsflCM77ihM9FUA58Pg==
X-Gm-Message-State: AOJu0Yz3wzSiR8WlRjii8A2MDFCboce2zbG/2+kIxMpkL7/NZahd3++k
	35+zx54C/tqiVzOgbPCx7Zirriti49O8ukZAgWdWkW/ViC0Ax1gZGhcJdud9GjnXyw==
X-Google-Smtp-Source: AGHT+IE8lrQZt4yf2NOcmxYnZSegdVRNezb1RXhcelAz4SiIe7XiJTncw5NoliUUa5EXVaB8rgPSAg==
X-Received: by 2002:a2e:95d5:0:b0:2d2:5668:3a40 with SMTP id y21-20020a2e95d5000000b002d256683a40mr5024483ljh.4.1709502866415;
        Sun, 03 Mar 2024 13:54:26 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id n22-20020a05640205d600b00566d6950d14sm2783250edx.92.2024.03.03.13.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:54:26 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 03 Mar 2024 22:54:21 +0100
Subject: [PATCH v3 2/3] dt-bindings: iio: humidity: hdc3020: add
 reset-gpios
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-hdc3020-pm-v3-2-48bc02b5241b@gmail.com>
References: <20240303-hdc3020-pm-v3-0-48bc02b5241b@gmail.com>
In-Reply-To: <20240303-hdc3020-pm-v3-0-48bc02b5241b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709502861; l=1328;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=FyoFAj3XNHmn1ZPjLNGWR7C/mqk62+JmZYN8Us3NcAA=;
 b=uWOq6TOxCi+og8LiQrahRgzmKnOlQnEdg8sgoANEyUEdYybucjlCulLDtM+CS453cuqlnIR8D
 R+mXaOkGRUGADzz/Lk6X9eDCVw8Wtbx7+IsF3v3V9Zz3GyxguVrCrII
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The HDC3020 provides an active low reset signal that is still not
described in the bindings.

Add reset-gpios to the bindings and the example.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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



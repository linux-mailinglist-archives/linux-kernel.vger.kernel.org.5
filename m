Return-Path: <linux-kernel+bounces-88316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07ED86DFF2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D761F2217D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8C6CDB6;
	Fri,  1 Mar 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVKSgPXD"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C006995C;
	Fri,  1 Mar 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291562; cv=none; b=hWtblprNlm7p32wgaYn5a/L/VwUeeaL3FP0UiZiunMdob3pcPMW8khv1w2LWlYLknosMRkNmPeaxcAg1IDVkFNHiFeZHaLL0Fgeu95XrVMtUmp0WFpB8bdx4BIXTV92JybuLYKKK7ifqlbGZTLqkop/BQnHr5bE+hC6m/iNrtoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291562; c=relaxed/simple;
	bh=G0Ytuzuhq5IT80Qym7JsUFTIlvAQ8ypbq/Q3B8+0Y5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjGov+WQrHbVPqWWAqSxGjq1BR8wPP0NdHyqhTosYS1Nsjsg53BA1Q7ZMBn9BG4BYDrxUDDww2jV/FCgvRuWIH9vq2seV29CrrpODkVcb0szqh3eYGASoQuWdj3D31LlsfFN+7cAHcnUU6OtUDTDoV8g5KO+LayhO11etT/suMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVKSgPXD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a446478b04bso180924666b.3;
        Fri, 01 Mar 2024 03:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291559; x=1709896359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WpDmXfSvrjV3LnFP0ToCDaEvJaHWTSkPddd8OTrd0Rw=;
        b=LVKSgPXDziy8XJcRQuZPN8smUI+AgzUZ1nCh/2QnkXl9WixBRJ74rM11mFa2BhqHlj
         +yzmprDhuwfm5FpTKDuQ9eGpz+hScAhB2zKhqygdRYIa/KxjrBW6DsLiOoTFU1npLT+n
         JphCUqXTpNBWnRej+T+TecjYtttQrETE7UqOdHv+aWyxjHYLEOqqPbXEZFLZN8yetdkB
         YQbvyGUlIVbvQ5uNZYD6TO1SoJxTosL57ecNz0ffNXvLpQ6Q0VZZjMHuvWXC6avPPIwP
         Oo+LCNY5FfdwsC0c+Y/+LoDZDapqq92hVfwfwN2f5+wF6L5z2bgkESGbKMivvYcMuUs6
         SCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291559; x=1709896359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpDmXfSvrjV3LnFP0ToCDaEvJaHWTSkPddd8OTrd0Rw=;
        b=V2EGVcZUAD3KegdGMFrEMXC5eDjIba1SMV4Rm5ZYMGL/gO9MQo6pMrspt7t9mvyZmA
         6pwruf7tv38yj3C0JO2iQ+L01Fsw63ah8QojUMvP+QmMzhN/q2kmLvOFJfl6A1cfYMnJ
         4O0x1Ordq91qKB2hLl3Kzl1nlsHPgAnZ0QyTLH0XWMWzIm/q7M58dNBLu4TWheFvmFHk
         GLCcoztCX7Pv0aVrcRPDJXbmPNITR+LXMEKqDHwDyUvUM+BvbHOBeAlDyozhk71NA5zB
         KmEgHY8npR9ryZPqFYhEw5awL0J3kQULcmt6Yke9KIHi2xlwE0HIAu0J3gW8y4/YbHl/
         c4JA==
X-Forwarded-Encrypted: i=1; AJvYcCVhyLS4p4pLy1oftfAPUDrZfiX+Mn7n3nnKfF3SBXYci1WWLNFeC3zmtrxMTVVlIELJMAKbCcesUEEq9mnEOZjNhbqotKO+q8vPeM4/++uZXtmq2QnW6d+xScxaO7tdLCKfQ5RZ68sIPwzhPV/9RHrZObsYDSTOqOgeG7Y2uDg6CfdtWw==
X-Gm-Message-State: AOJu0YxLPdr7lHZY3iBln9HaEMPS04xJ7H9dn3QOJcmnPxrXiGfItAYN
	lhHDVOT/uFa3AdZizwawqKKzauNpWDziAiXplhsZhhP5NnXLbS1nCVarK41I
X-Google-Smtp-Source: AGHT+IGaeVRjJhAGnRJBtIfjSECCgFgo+xctiX9YHIc0geBFEJq7kepaf3yCC0sfrkrvuOimxT4b4g==
X-Received: by 2002:a17:906:5fd1:b0:a44:4fbd:a8fe with SMTP id k17-20020a1709065fd100b00a444fbda8femr974495ejv.1.1709291558645;
        Fri, 01 Mar 2024 03:12:38 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906089200b00a43a478e4f0sm1583254eje.180.2024.03.01.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:12:38 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri,  1 Mar 2024 12:11:21 +0100
Message-Id: <20240301111124.29283-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MC33XS2410 is a four channel high-side switch. Featuring advanced
monitoring and control function, the device is operational from 3.0 V to
60 V. The device is controlled by SPI port for configuration.

Changes in V2:
  - fix title in devicetree binding
  - fix commit message in devicetree binding patch
  - remove external clock from pwms and create clocks property
  - switch to unevaluatedProperties: false
  - add missing properties for complete example:
    - pwm-names
    - pwms
    - interrupts
    - clocks

Dimitri Fedrau (3):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410
  pwm: mc33xs2410: add support for direct inputs

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 +++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 418 ++++++++++++++++++
 4 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.2



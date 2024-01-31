Return-Path: <linux-kernel+bounces-46449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A3843FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02421C223D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57C7AE70;
	Wed, 31 Jan 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwro7rvO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF07AE6D;
	Wed, 31 Jan 2024 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705978; cv=none; b=dDzXnXH35iEC4lPaxKg67024tuVdD5VDbdJMWqBp8nof6EvN1nShuPJJ6eq3/rgnVbHhXluru1MOwdu6ctx/vlX7B6UHto8PcL+br1zK6+wLKPL//D6TaWkFjDUnWuhShhkF8710T8F+Aw8B4zTYTi10+w26BBemGP5UQ9kFx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705978; c=relaxed/simple;
	bh=5qWwM4rybSn3sQwL/T5QTpDSTH0pGNitJxfA4afPac0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KD2cSF+4OWDtPKHpngG4D+IKNLIFHhlcKJPtpBZJSZ2OaVb47/BBHoq9NeXQIy5sLH85FLsjyjnW/xHGR9DNfvVkMTx8xD9AWG0zgAupz819x1voAbdzxn96rbMwJr97iM6A4lx1K2r3tijkuz277xZul5yXzcLf9ZRKC57q0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwro7rvO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-510e0d700c6so3817910e87.2;
        Wed, 31 Jan 2024 04:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706705974; x=1707310774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qiLW6Y7RRXrik6dDAtU4CB215hHq9HP/DTZOIjF86/s=;
        b=jwro7rvO1uWkHUv4X4xiprZmX1tc3eSbrurA0kucSzfv+gv6dR7UD9Q1R8Hjg8makX
         EbQnTJ4pCNqSt9q8WAtAdw/jImsexC1y0Ge0LZyzdCY0/ro7gq8RfYq9C37/WSKGeqvZ
         IKoMEpmtcd701ZzbtssLL8MHAn2aPt9pQ2XtC1A+c1Wxxe0r7R/f/nB0bdDXOSucPpfp
         12iWRsscgRoPjfG0NB+vGbr8jltMTO+tRXphcT23r82zWbg5FGUNxSMpKQY1kqye6J+P
         DP4JawbZ9BxznLQE5jLkAxwC9ba4QEhV3Uts/F3iF9wYmD/L6072FuInvVOuZFjS/Ysk
         5tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705974; x=1707310774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiLW6Y7RRXrik6dDAtU4CB215hHq9HP/DTZOIjF86/s=;
        b=ReDcIE2kauGbVM/vd3IemNyIbrB/bndB1cOYW57EEwjYbVHRVYOBxRaGatqEwzhTBM
         iXzKMc21dO2YLaS6mgN/ZTlq3hdTOtLNKEyzwbpEoKSpUJsYpbF3sCx2T2f/auW++NMB
         yquVuxEqOBZ0chfkey3bAm8F3NGCYJBKjGa8Q0BH6s8G+t7Rs5u1ZzPASj02TFN2meW2
         5vuyZFfn0hf+rX+U6n7DFciqT5yojUTNYuTUelmPM/CXzgicfbenMMbByPuhzz1pWwMv
         8aDMjY0eMwEXo7uyUaiGARNVKx1JkvM8+gddqTZZnxr+v82y9LpOR+ipMli/Mrg9NYn/
         QVdA==
X-Gm-Message-State: AOJu0YwmYGOLmcVOV/oWyA7UDbX9FGRaYsv8fquMwehx0aDC+ldWuiky
	JRSbsb0NzhUc/NEEhFSz3a61gHsSYXqkzAwgpSW7IOY9h4T/hOyfDZwBhU2HeQq7qsI=
X-Google-Smtp-Source: AGHT+IEZD1EYbijfOfTXbD+S2VDVznBXDRi9jVFPUhgu9Z0dahqmdHXj7u5Cz0Un4MBqxKqBijOh6w==
X-Received: by 2002:a05:6512:282a:b0:511:863:4a0b with SMTP id cf42-20020a056512282a00b0051108634a0bmr1358837lfb.60.1706705973568;
        Wed, 31 Jan 2024 04:59:33 -0800 (PST)
Received: from localhost.localdomain ([188.162.49.60])
        by smtp.gmail.com with ESMTPSA id h25-20020a19ca59000000b00510faaa62cfsm1361135lfj.222.2024.01.31.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:59:32 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	John Watts <contact@jookia.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date: Wed, 31 Jan 2024 15:59:13 +0300
Message-Id: <20240131125920.2879433-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

v5:
 - dropped unused varibale in the driver
 - fix dt-bindings

v6:
 - add apb0 clock

v7:
 - fix a remark in the driver
 - add maintainer

v8:
 - fix compile driver for 6.8-rc

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  88 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 380 ++++++++++++++++++
 5 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1



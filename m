Return-Path: <linux-kernel+bounces-54219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9E84AC5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA312858CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C46E2C7;
	Tue,  6 Feb 2024 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV5n33+a"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D43D543;
	Tue,  6 Feb 2024 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187953; cv=none; b=ISsk6goRFnQSZQaJkKCF9fANFrsb2oyr32Pv/RkpLZ/MT/qnT3DJicBQTKgo2PrhXAxTWyAkCGjcyZjjo+xhhAeOzzgLDo2rUzKIpYYxd4u/pA28tEKXdr6cSj/SOMsh9fQcfCgsSPjqILShAgkTfvWKvagAF0PpBRXw3ZA9WeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187953; c=relaxed/simple;
	bh=CIhBAn1OTElk4h1B5drR6PBQbg52jGxbabczO2S5kCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gI2HOngu+Wx5TWHXnPMlSzWF4uG6JMTcAMv8vOkh0rQQSPNHn6YSO/09rWeOADatZPEKcqUAAL0ll1ePc+X0lemPLteHyjOogYXXBTzfVXBDRXb75TDHMLy2RWkzyK7pt5vhaso2wl5PZMIPIbILamQAxNjdDYvKK1YTXhtwRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV5n33+a; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e02fa257eeso107727b3a.0;
        Mon, 05 Feb 2024 18:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707187951; x=1707792751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISGNh/R7KOPf4WD4INL9jBNwxYTfU9uVKM4TWwNiAak=;
        b=cV5n33+aOGpkpJga1F+EZArsaJsbHTZZSzEaZ+iuDbLAaXb8y2ojZeL5itLpDUox32
         //LN5OIAs66AlihKQ5aih031MGYA66VbEXKNV3/kkFVQq2Ho8bhGhXJ6ejhSYdm1g9QT
         w/KFnovWEocw+EAqpOpWZzaHNhzK/YKRugMIpoH/1HcCq1qI7RF0WLlXWpcOv5Q9f/u2
         oz6Yset/eZNT24ITvXJS/88rC4mNP+a9517+WAa4466dBDssJHZ0202SAJi9nrFz078f
         HTln7WLhc3wmFHABc/RhWnCUrKQu8YEfKE75GoNgVUasIAmObL9V/j4JLoOG6dXG2kez
         wxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187951; x=1707792751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISGNh/R7KOPf4WD4INL9jBNwxYTfU9uVKM4TWwNiAak=;
        b=d7/BMgLskOWbibASPgXJpq1uBfIVVyqH/ck5DCMyk7Cgc4iNpFPxDvZQU3qdIe9Op8
         iJmg8olfLap5UJhWex7YOktY62j4vd7yiyoUwHHy5GyH0tuIcQMRQ/TH6ZxLydqGi6Ei
         bRte9M1T5mEA/8iDj24kPquiiR+eJY0i8PUoQmEynBaJkDMcPlLLdJLR8TrVWmqS7Ye0
         Tf1oIKwIoaRacg1g110vSKwCVXeOn/6yUliQlIyJz3rGVoRf7BnHu9yTkt2Mk61/VIIX
         fQXHSx3Lb/d4H4vPai5VXxg5XJFk6f+pL1Hde9DfL4qrJg8FN/0kAqFZqC/lu5JfZzph
         XWqg==
X-Gm-Message-State: AOJu0Yxo7vBKqSUS5v99V22IrOwpnp390qbcoNgxCNysAJ0C/Uj4Nu9v
	Pmd0mRp+R31acfqeqw4+DAAHCHakkzLZ6EnLMPuArsi0HHJpAJtbatDCyTMM
X-Google-Smtp-Source: AGHT+IHcz7hjFdYEduLcrpKjrNiierqBL1EIINAQvCoE+O54HnPZInn81NLvC2skbbIpiABC+oQX2w==
X-Received: by 2002:a05:6a20:549e:b0:19c:95cc:1d47 with SMTP id i30-20020a056a20549e00b0019c95cc1d47mr707770pzk.6.1707187951157;
        Mon, 05 Feb 2024 18:52:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVaKhEroopJl8jNwSlu5JoFk1bbAHKcM0/61+X1Kd0DVgc3yAXdgaRARRU2iSAbBgG4YmY9Kd42uNXVzTgkSW+6N0iLPuFduZqzEKPt4fMUSQzB3fYA8en0PYXVZjmepuXpjgHXqZ3jKH51vMfrIfACVk2TgEB0V3GdUDl6vlqGnhccSAhyqL9VT5DZnG7YkrrYmKE4ob7f1Gldck/6FQSnKe6JFmo3rCMIKuuUaxy7e4MlJx8LG8GW3GJ9MoNE2qzR4NYNobS3djwBSrM9U4cNAJtIrX2EzdmitcwObPSsg4IJ0nU+V96MtdhJNaVOybpVo4ohQdB+P3/dBlkZfK07fMjTflKVJVC1wUH/mFnehPOUiApMo3devNoEHk1cP4N4vL+yM+nnY3s=
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gx22-20020a056a001e1600b006d94291679asm622542pfb.78.2024.02.05.18.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:52:30 -0800 (PST)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: [PATCH v4 0/4] Add support for nuvoton ma35d1 pin control
Date: Tue,  6 Feb 2024 02:52:19 +0000
Message-Id: <20240206025223.35147-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

This patch series adds the pin control and GPIO driver for the nuvoton ma35d1
ARMv8 SoC. It includes DT binding documentation, the ma35d1 pin control driver,
and device tree updates.

This pin control driver has been tested on the ma35d1 som board with Linux 6.8-rc1.

v4:
  - Update the pinctrl driver Kconfig
    - Add depends to CONFIG_PINCTRL_MA35D1 to prevent compilation errors.
  - Update the pinctrl driver
    - Utilize devm_kcalloc() instead of devm_kzalloc().
    - Employ ARRAY_SIZE() instead of sizeof()/sizeof().

v3:
  - Update DTS and YAML files
    - Corrected the unit address of nodes gpioa ~ gpion.
    - Removed the invalid "pin-default" node.
    - Removed the phandle entry from "nuvoton,pins".
  - Update pinctrl driver
    - Fixed the Kconfig by using "depend on" instead of "if".
    - Removed unused #include of header files.
    - Utilized immutable irq_chip instead of dynamic irq_chip.
    - Replaced ma35_dt_free_map() with pinconf_generic_dt_free_map().
    - Implemented other minor fixes as suggested by the reviewer.

v2:
  - Update nuvoton,ma35d1-pinctrl.yaml
    - Update the 'nuvoton,pins' to follow the style of rockchip pinctrl approch.
    - Use power-source to indicate the pin voltage selection which follow the
      realtek pinctrl approch.
    - Instead of integer, use drive-strength-microamp to specify the real driving
      strength capability of IO pins.
  - Update ma35d1 pinctrl driver
    - Add I/O drive strength lookup table for translating device tree setting
      into control register.
  - Remove ma35d1-pinfunc.h which is unused after update definition of 'nuvoton,pins'.


Jacky Huang (4):
  dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management
    node
  dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
  arm64: dts: nuvoton: Add pinctrl support for ma35d1
  pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver

 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       |  163 ++
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |    3 +-
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |   80 +-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |   83 +-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  150 +-
 drivers/pinctrl/nuvoton/Kconfig               |   19 +
 drivers/pinctrl/nuvoton/Makefile              |    2 +
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        | 1211 +++++++++++
 drivers/pinctrl/nuvoton/pinctrl-ma35.h        |   50 +
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c      | 1797 +++++++++++++++++
 10 files changed, 3548 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c

-- 
2.34.1



Return-Path: <linux-kernel+bounces-101084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8287A21A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4179F283471
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78B10A24;
	Wed, 13 Mar 2024 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJzfGgIs"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900ADF62;
	Wed, 13 Mar 2024 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302249; cv=none; b=b19kE34OCEX4VfQgHjLivLm8kD6O62UbwfwTsZ9s7HwS8cy8Lt+hjYYjapEa6u7vP3kNHKi8vvMKbpu5Rz+WjA39e/x05SKwPB0MPOlB3Kg1q0bBkXK8lY4TFlN+X+E0iN3uUK3MZYop66LHPNa1LT+FtkhXRZemLva8CMLm0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302249; c=relaxed/simple;
	bh=mMCqrX5ys6pZ/zh0FM2mM7MOiPYvzIgqQWPL+8JEJ30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7L7PY/J6XGdOB90qT8EgqmtfD6xkjCVaiy7G2nTaMNrLmhcGHwgA92Gjo/S6dwHbIePxpj7UYD3wVm9thvGIXmejPSQvmQhSeML/SZaYl7/Mvy9AOPlNiAFKBg/XxyRlMhVp6/yDxxGRVsDVPb0sCd7j+sy8lUeNYJLBuQATnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJzfGgIs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e649a2548cso4365338b3a.3;
        Tue, 12 Mar 2024 20:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710302247; x=1710907047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HygAHjwPzgq2yfeMwPFxpy16XS23OG5KKP0Xtf/udRE=;
        b=GJzfGgIsWrpgTrwW1HRiBhDpQYFjKhSH8jSaSIgaoekaSPwh2e5S4D8NQXUs7cOs1f
         ZbGf3gRcLhNUxfM6WtRHeoBXESvqK5Lt4D8s5RhH1UpkVmtMDDIk+4mgAIUJpfFsq5OL
         ILcHys4ydjhWYcFn83eOrXgtGxAVoOP2gX9LH0oEjpArwcHkIAmrrjXeXXA0SX7WOORd
         KUA0Hh7WY83LRwEq3XaC8tz+ZYdJ9lalovvJHoGqpcdA0ojmxo2nXHHm9kR0Uu69Vez4
         DwDRDs9GrxSUClSnHqauoDSbSGB+0OcLAr8eVII3SXgQYnO5oD1/W59M6zahRj9eZOZA
         47kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710302247; x=1710907047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HygAHjwPzgq2yfeMwPFxpy16XS23OG5KKP0Xtf/udRE=;
        b=KFFSgZw7fo7Jr0myfj4ahdKY+/LCX1cj8SS7uD9F9AXNsxWUtCLZaePuYaoi03w6vO
         rgRIIIu5WE2Ag7vCddN7Bewes9x5ySFVoVkP02Z8ZVZz1P8IznIinBgWGscPYsCZ3pAI
         EQ0WWZqvtPmdwx7NqPCsjJRTvxjBx1COLPyHkbsbHWzKTQe8m+m4/5qU3IspNdB7IehH
         11+x6uUGpuXqce3vdGMX9hL0SETVH3mse8DlNSNaK1pcGNNRENfSCcC3K8zdGoZ66/G/
         BH4eg7GDuQq1RY+Lc8HKsDWykbhndeMiGvwX2kguonsjI2nX+dy51L0KAiSiD3VIO16X
         3uKg==
X-Forwarded-Encrypted: i=1; AJvYcCWCf2qGVowBCVpCacTTNP8JAiXEgUuEyxq18FqiEV9jGF//hhEUemXccFwoxzSl7CUqzPFEE8JrB6bGtO4natwmVI9thfuQRcX6PTCpFClgY+eXTRcXxne1LMQhkNALcRmfq57Gk6cvTxMcSdcWjDYLKK9+OR4rREydD9CDE6fBM2YgAH4=
X-Gm-Message-State: AOJu0Yz2fOuqHwJFvtvze66DBmDx+6PL13zKCw2/ziyJ43gC8PFbrguB
	Mvixsw/EThna6ZLfIHQJ3ncAWuJ950kRTcQFxHVHI1wMKgt8Fy89
X-Google-Smtp-Source: AGHT+IFmD0gFBLcV7Tp09i9d4J7qIKfyrdyspfwdQYfnK1eOkEw9AMJzK9yQndrHtHiojBqAgJ/3lQ==
X-Received: by 2002:a05:6a00:10c3:b0:6e6:9421:bfda with SMTP id d3-20020a056a0010c300b006e69421bfdamr1528104pfu.22.1710302246702;
        Tue, 12 Mar 2024 20:57:26 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a63fb11000000b005cd835182c5sm6721605pgh.79.2024.03.12.20.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:57:26 -0700 (PDT)
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
Subject: [PATCH v6 0/3] Add support for nuvoton ma35d1 pin control
Date: Wed, 13 Mar 2024 03:57:16 +0000
Message-Id: <20240313035719.768469-1-ychuang570808@gmail.com>
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
ARMv8 SoC. It includes DT binding documentation and the ma35d1 pin control driver.

This pin control driver has been tested on the ma35d1 som board with Linux 6.8-rc5	.

v6:
  - Remove DTS from this patchset. The DTS will be submitted in another patchset.

v5:
  - Update the pinctrl driver header file pinctrl-ma35.h
    - Include platform_device.h to fix compile issues.

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

Jacky Huang (3):
  dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management
    node
  dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
  pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver

 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       |  163 ++
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |    3 +-
 drivers/pinctrl/nuvoton/Kconfig               |   19 +
 drivers/pinctrl/nuvoton/Makefile              |    2 +
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        | 1211 +++++++++++
 drivers/pinctrl/nuvoton/pinctrl-ma35.h        |   51 +
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c      | 1797 +++++++++++++++++
 7 files changed, 3245 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c

-- 
2.34.1



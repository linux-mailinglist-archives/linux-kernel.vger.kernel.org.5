Return-Path: <linux-kernel+bounces-136603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E1589D60C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946881F21EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCC80630;
	Tue,  9 Apr 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUCGSqHs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C38060A;
	Tue,  9 Apr 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656605; cv=none; b=VoCqXUSeqfyRvFQSP3JzD2noNcsUjH9StRx69QdY6Cb7Xkcyimu/nxt7txUwrPkRm9bCaJwyaBuCCSqyKUmnmLVWjac4Bp7S0Js4iiesPzP/pzPrfOS/v4fgJXin6llFGDEQC4QqYCYLwsDDlX46gL83o5QocQ5Bqhk3Li3jnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656605; c=relaxed/simple;
	bh=5kdIyr7d+TqYs/Wm27GviIdtHrnkZbUdmJ6L1NB2+mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJidscL3aPLNCXrhzpIJJgRqmqlVaUE+G5nSO+mU3Izo2bw7IS7wJsnYqo4Sqpv3MICV19pAsT9CUpVOL0aIhOidDGkho2Rwvq6c8agz7dmiQS2D+uv3GpzTvGKiIERVlcLSqIr63z00PUUM6KcxPY/gmABNXtXunuZgwm86Gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUCGSqHs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e244c7cbf8so45122195ad.0;
        Tue, 09 Apr 2024 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712656603; x=1713261403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYDT1gagtsYDBQ7j1Wl4qvL1OaVYrsLw8iRUF0LZZa4=;
        b=TUCGSqHszkifKbFkWyFqbw+HW6hV1xLWwJLKLNq5T1w1rbMINEQCbk8uV3TrNus2K2
         n19wOhf0s88ZWoDTsajd6dvntj7tGrXzCGi2tit+X1RN9erCCya6lFFDHdC6Mk6JaYJb
         gAy4wMArXfMW49U9pq/LrTojoniWIoDq6mJa4Udu19iXgi8KBytnC7ym6cRA6btqr32z
         7tdP1InyQX7ZC1JkG9a4BjebDcN8HaDrplH43hS8ko+0zXP5M/+Qji2+bH1/YSe/2slz
         ce9ACb8MoXqEWVmlaBQ90yKvCgurF36kaHwqgN6XFvTcnbjm0gYMipPAjF7fRDMMCVYV
         gcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656603; x=1713261403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYDT1gagtsYDBQ7j1Wl4qvL1OaVYrsLw8iRUF0LZZa4=;
        b=NSIBP9noLaK9GjvC6n6qcd4/XPKzJ7aLC2tU9ZqalcLE+im/RNO6DnliWh8ijcLdP5
         IFDmOTqzkvHiPBLUlKy87QDH5EBrFGNWt9IrOYuw4cjrpJ1FnIODvhqEhQD1EhJmdCLM
         FZL/fVKUcagn0ED9CCBjlwQjfc0bka62xH2NNPd76d9z2IEqgLxYZP0tHI3ewxr8clL9
         lw6c6uE+MVUzZpR0/9Kq5BleA69VRt+muPuCSa9cY8K4PhCZc194a3IzIPds2Ua//7cw
         jiI2yJh9oBjjCntTxE3oU2nzxKJiSe4JVF1KX6Bwx14dzGSbnL3OV8YvipPUUbi7ooOj
         T2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZlP4uJj/uQrnG0ztlUn1sn6uqiKcjVE1ZgZHC0UIaN8Vza27NoRBcYWMGGbSfOg35ytthhT8P+qUahWdp+VqntrwKAlXoS9klIIGmnQ1XzDyCo6CG5FG+nCgIdNwFby33UJdkTBsmPAXbeleyPtUo2txxWVRKIH7SQmJmSXS0G+qsrBU=
X-Gm-Message-State: AOJu0Yy/z6djReloNHBb+Lb6ZvwtbkF0zWvK+2L5yhCYIKWnmTBFxctV
	6yVgIbSaCoWSqKIubql3scC/txyC4FvrGwYmlhaA7n23oRDf5SGW
X-Google-Smtp-Source: AGHT+IGbspmJ4y0DWy0bXoZNhmrveZTGkCJ0U/luzwHbiILv8Pozmxr4Mq8N7vYEE073vwEM59r/Tg==
X-Received: by 2002:a17:902:d2d1:b0:1e3:f2d0:1a4d with SMTP id n17-20020a170902d2d100b001e3f2d01a4dmr7381037plc.45.1712656602759;
        Tue, 09 Apr 2024 02:56:42 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001e3f1596baasm5100445plg.298.2024.04.09.02.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:56:42 -0700 (PDT)
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
Subject: [PATCH v7 0/3] Add support for nuvoton ma35d1 pin control
Date: Tue,  9 Apr 2024 09:56:34 +0000
Message-Id: <20240409095637.2135-1-ychuang570808@gmail.com>
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

This pin control driver has been tested on the ma35d1 som board with Linux 6.9.0.

v7:
  - Replace the magic numbers appearing in the driver with defined constants, or
    provide comments to explain them.
  - Update the ma35_irq_irqtype()
    - irq_set_handler_locked(d, handle_edge_irq) and
      irq_set_handler_locked(d, handle_level_irq)
    - add case IRQ_TYPE_EDGE_BOTH
  - Use handle_bad_irq for girq->handler, instead of handle_level_irq

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
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        | 1233 +++++++++++
 drivers/pinctrl/nuvoton/pinctrl-ma35.h        |   51 +
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c      | 1797 +++++++++++++++++
 7 files changed, 3267 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c

-- 
2.34.1



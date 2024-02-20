Return-Path: <linux-kernel+bounces-72151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8E85B011
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C555DB2187C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D2BE4F;
	Tue, 20 Feb 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlpJj0tg"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4494C63;
	Tue, 20 Feb 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389728; cv=none; b=P6NRkTCmpReaSsQ4pCoLWp05H1rjfO3GdvmdDWAVWcWrmRtajiieqyad7q4KoSqCjJrFfd5V1Ye0IqbfCsUr12te/LVa0QiT7LuIf0brU5vQYPDq60QHN+u9myiyTN1ggRXDJ5PvWUJb4HMhefZew+8NIee0ZqnI5rCgnhh3X/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389728; c=relaxed/simple;
	bh=isFZRqU/QindhA8jyP52Q3TJRY3mvK6OJTgs+zYmt+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fY2g3jGnqpb15z8VRqXuJjbOuLXQNTX4J4tsjmWJhNqp5Nfcpl6gfSKjMyndS3et39cCD2mqP8TEOu74sOyiAvUCpaYps/phW5CvsxJZivOX9/HfzPmEXxgq7uNiTedak5NNbagLmBlt/XnD8lWicnCr4jsJo3gEerJBU5FtHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlpJj0tg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3267612a12.3;
        Mon, 19 Feb 2024 16:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708389726; x=1708994526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6VN1Brni0/Tp50Gu9RGeDhBJRhZhzjZgGi+3xEXJ7I=;
        b=UlpJj0tgLEC7f3/c67lM74JJj764shqJLvEmLfr6xeRX3ee/YopxHwCe1hJaNXEQjy
         r93ryF0yknEYI22WdlSEfpg/bhZqwUP5xZOonYeBkfMT98gFw/xVCJg7o+znCb9mDVl7
         2wmU5iLoH8yt6O1Qv22tu7c4Pidyeb7wwmapf72MXXBuKHflYf5QgMNf9oJdJ3WBLOtM
         W2Rf+AtyuwcRBIUKCTbRD252FLzpjeCOtSoXkBpDeuYD4CpcOkKWN9xovEzrwIO+2HGS
         xJVo6I+WuC50rR0QFWppEvmLA63ONTJKe8xthiMCjxExtNoCw0wPCYZYDBt/MTw+g6ww
         3J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708389726; x=1708994526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6VN1Brni0/Tp50Gu9RGeDhBJRhZhzjZgGi+3xEXJ7I=;
        b=VUl1c7nRRzoIwW0Q1GE125pVb5lScc7gNKc0YqM55mRusRZqQoWb0X+xFbSJWOn9oB
         takM6Mh1rgXTUEkZNzw3klwjh8nNx7ON6Juh53CUWvevydBsth30hJkodpISLFpfxB98
         ei4Yk76wO3HuHSpfTaVN+HdoGow/QN555ZeVDX4joUJfVe7khTOlZhJFHIWn+P6ZrxOz
         CaLU9oF/0S8/mnyMW7nUzVrEqdnS/7Ht/tO3iwaDICEXrjQp7KrD7nsCARmIxWpABq/5
         RlD/CPS5gDc74A5F37ctkNjFTu4W06AFfGS1t6jr68Bl/FR4PHSEWqbGO+MkSBJ1KXII
         yZaA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2iBs7d+LXBdpHJqpWvAOhQa9hxhdMk77ZD9G09sjXEz0UryYnU4XfUi2Ye/qgauJdEk1esYV0KhxqRXmeQuvewgbEHQvZWwrv6EwrCHIm2QpqvQebiJAF4dBsNrDP5X3LpWq14B/G+tl7xKj/A2opDCYyQVq1KTPX1Qy17R1Z3rrBg0=
X-Gm-Message-State: AOJu0YzYp0gp99s4/AiDAKt5OulSy4rSukh2hUDzxRakqrvFS2dBMvZu
	PsRP+3XrWhW8OsP5/wARfPnnCc/TxqX7t49/OeuHCqOKhK01LGGU
X-Google-Smtp-Source: AGHT+IEHM69vGr3cgZ5j3CjQTgkbjwl8XjDEf2FDav5T0t4zSLwrW2rKbP3r/aS5Wva2ajffTEXvTQ==
X-Received: by 2002:a05:6a21:3182:b0:1a0:8578:fa97 with SMTP id za2-20020a056a21318200b001a08578fa97mr15579743pzb.48.1708389726256;
        Mon, 19 Feb 2024 16:42:06 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id cz3-20020a17090ad44300b00299bf19e872sm1831393pjb.44.2024.02.19.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 16:42:05 -0800 (PST)
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
Subject: [PATCH v5 0/4] Add support for nuvoton ma35d1 pin control
Date: Tue, 20 Feb 2024 00:41:55 +0000
Message-Id: <20240220004159.1580108-1-ychuang570808@gmail.com>
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

This pin control driver has been tested on the ma35d1 som board with Linux 6.8-rc5	.

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
 drivers/pinctrl/nuvoton/pinctrl-ma35.h        |   51 +
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c      | 1797 +++++++++++++++++
 10 files changed, 3549 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c

-- 
2.34.1



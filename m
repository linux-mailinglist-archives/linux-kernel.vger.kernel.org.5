Return-Path: <linux-kernel+bounces-34865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C983887D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9671328381B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C1156470;
	Tue, 23 Jan 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcO/LY9v"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958B57321;
	Tue, 23 Jan 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997207; cv=none; b=V/j1tqbgDj+m60a3ZMrbftrC/IkiVj0OPQtLK9Z8q9+xoatH7Vsr0CxzVDxuQoHEgR0ORqvo2vjisckrdUDfd8a61Sg14ss/PZ0VwPm0o8F3XBajEEO9eop/UjnjDYqLY+bVKSumFvwqrd0g+91CGxD+o1J1Uw+DXaZfX3rGAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997207; c=relaxed/simple;
	bh=wZCMZkl4DLl+Oi3QKuUSzT07b6LsgsMWRrez1zYeNSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6Bg9tMgzpINgd1dhn9QWkLRKJXkfVZf3L+cRqaaP2WM/nQRV6Us7zVG1kmRn33BEuNGpzyaWLwNsbcdoLpU/d3ce4A2EndLxG5cY8L5X7UnjfkAwsRVrDJ2YPG0u1C+av/yLqMylGT2mCDkuSuC8QAheOKRSTUwB5Hk31tWLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcO/LY9v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7431e702dso12535315ad.1;
        Tue, 23 Jan 2024 00:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705997205; x=1706602005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmLfi4PEbgnP5hy8qSr5lBlgf4Y5tfjsQmCiBWimBLw=;
        b=KcO/LY9vmC4W9W02vGD+YQFQ/YiDjiOVFjOQRARBXhDeDjvfvvQuWuiZJnBsHHv6pD
         8jCS5Nj6ktAZe0RDV5b2uDPyLuO/7sa7mJMdgLeI6cQVzr17w561/+rYo9s7xvQ+cedR
         ZYn/dtCYdT9gbGxMHzJLJwY7r8NNhIHoBEmix0GONHfnL1nQRTT8fL6ty2eGuUXo2+61
         Qg+EoCzjUjHdKRcMe8YFyAMrdBjUwcUJy5/DjqXTfQU/MqBN+/HHBDXhT3uIlUX7uIbM
         Wpk3TSHRP8wTlLqedDcqMVPouYUpAjVNLJWU0fR22XCzr60ymAhPoE7f3SFpMDbQjdtl
         Z26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997205; x=1706602005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmLfi4PEbgnP5hy8qSr5lBlgf4Y5tfjsQmCiBWimBLw=;
        b=avgI563oeIOdlWB/5Bllkh1nRJnnWrYKtDGaWRvoppZYcbmChP7cb9jjH4OY591+kh
         M6VXw6Yceox3rSyeixPZV7WYH1IVIL+8/aVTC9zJcU+giZStuTI1X32wi9ECgWEGLNt+
         KHXU75RFYHmy20md//446Hf/6+BlmtY2pEAiNuicR0YYmCvPe9jUlkdGtJW00RatGbaQ
         liDk5HWwRAcpbmINfap9vl+4Ugs9r+MeZnbGTZwRL9i3192g773uQLNYrO1LTiRbwq9O
         PEQMxUOqBpb9RcrSr71vPX8wiZP+OGXRjy2PWDjnEFcZsTJDBDpsFz/Ri3+dSMZL0VLF
         LaJA==
X-Gm-Message-State: AOJu0YxoxakkTZUwUDLNNZzge2vhxDlSdVotQqAhfRrBOYbEK6VB2JU4
	4L3KTZBVu637IvtGtJKG5QjWr/AhiqTyL5WAWmiPztpbVXnmuirFxJfCHekx
X-Google-Smtp-Source: AGHT+IEqZRX80smMbaQb2UJQj8BD3UxhTcQ9x+P16zAgKycfy38xa55QhSP5dyYDvnKPiIV9HecRWQ==
X-Received: by 2002:a17:903:238d:b0:1d5:f248:38a8 with SMTP id v13-20020a170903238d00b001d5f24838a8mr2374318plh.131.1705997204931;
        Tue, 23 Jan 2024 00:06:44 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902704a00b001d4816958c2sm8277113plt.166.2024.01.23.00.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:06:44 -0800 (PST)
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
Subject: [PATCH v3 0/4] Add support for nuvoton ma35d1 pin control
Date: Tue, 23 Jan 2024 08:06:33 +0000
Message-Id: <20240123080637.1902578-1-ychuang570808@gmail.com>
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

This pin control driver has been tested on the ma35d1 som board with Linux 6.7.

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
 drivers/pinctrl/nuvoton/Kconfig               |   18 +
 drivers/pinctrl/nuvoton/Makefile              |    2 +
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        | 1214 +++++++++++
 drivers/pinctrl/nuvoton/pinctrl-ma35.h        |   50 +
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c      | 1797 +++++++++++++++++
 10 files changed, 3550 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c

-- 
2.34.1



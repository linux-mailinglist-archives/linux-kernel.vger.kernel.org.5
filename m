Return-Path: <linux-kernel+bounces-112356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DB8878D5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F499284D60
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA53D393;
	Sat, 23 Mar 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at9o7Now"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB01B95C;
	Sat, 23 Mar 2024 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200501; cv=none; b=uKN89nktNN8PHCdXy2mlHYoUCibgIpDoF7TMcgWq1PFO+u7y3xVU58giuFqJd8yc27q5ebJVNKDCSJMdtz9g3FNqIGZutfdlLWvOdsLzTPn/u2ZiOpn6kM5ipn+jdxLDMBThVREV30aNQ4A4jpL7RfPQ1Wy3niHyOLsXMcu7Ago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200501; c=relaxed/simple;
	bh=FVG1NGLm0NqbBCJODls7SI+MMlqwX2csixRc1Mf+tTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gULu9PlnuejP1rmzZreC9aerTBjcbrPH5qwJxLZSvumR/hu/GFNfg5eAG5/pm5hFy+4D01TW4u5nwx1Uz4VzwZZcTjvGgBXaTmhavfQtYMP14zEgOQ9Q9+2j/Z8Fwnxsgz6EUotTM7R6OD0xGvIF6Psb/9tkRX5PiqGKaO6iQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at9o7Now; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341b9f6fb2eso787349f8f.2;
        Sat, 23 Mar 2024 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711200498; x=1711805298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ1pELuVvPRDiO8S0zv+ldR/r8hfFaunbVkRqdzuPe4=;
        b=at9o7NowD8bCYYmNx8aPVjl6o5GlszGcwPT8qveI40JKnt9bmCVxxk2M0gBnze2lBY
         v34tsNcv0QRa7ZjMq2XepU2VrXy3lL8wdlGNaympe0XSZPiyJ5SEfRMeKH42Ioz1U2bo
         4dDLiRrUuBLDf8EuOM5P7dmsNAh+0n3NxIaygLRdshxcEUJ+7Mof+LWWiqJZf3JdZ8Ip
         Qqz1lcz8UwEniR/5JuH5cO35V4Tf3gmpmwmbpP7pRpK0d5el4XlaXmL61PSOj1pYdgCm
         z1DxKd7+Zc8F5RjQGbMbhIweOJGnFQXVNGU+mfvi7vOgpqw35pibTeO5AdDJgLa9UXKf
         YgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711200498; x=1711805298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ1pELuVvPRDiO8S0zv+ldR/r8hfFaunbVkRqdzuPe4=;
        b=I0Y+d7gisqwsFYKJTfLY+8fIMQsQ+lS6tSq118jcD3byL+jD0jeNx+7lDmIRAiV9W9
         doRrPV0E7PnCa2BrNhdgzcuwQDDOdT56phxa+KklxCyaMFqdXQkLzc2mvi6qwi2pxF/4
         9KjpDpH9o2GA4aDSFX10S/RuH9MBq8+0cRkMMxNp2Rmby7GsbV97cRDyyyPpOYVYjZvi
         q8caZZK0ql05jdCmBfeTNvuPDHVLoz1wY3Tjfgt4QSVYnsdZ5Qii/D1/Ipd5Q9HwnLM3
         ZemX6/EwTY/ZZFZYIGZvbKIpZxyxqjis6wVeFLIdXK4wGjqmSqez1AnF88w9lrsfgSfK
         lMLg==
X-Forwarded-Encrypted: i=1; AJvYcCU1vImtJuTBLqb/9jk6SkR5zifg9Eef/SwnFGm3SsJAznHu9CQg88Zho+WbFj/lfPJXePFJS2HqDDmpHBcvh79DaMZxbeMPsi3ru0O7bbBTcwwJQ6alVJsj36IqO1pyz9WdRfU0rDtajdUBapvebJWIktRUvjUIl0TfOTVrjZTjSNOdOvk=
X-Gm-Message-State: AOJu0YwQti+GCoY280+dAyI9tKx/9VTuPxtrHtY0ii+xPUEtPuXNRaMD
	e0JtoNTpj5AokYqJb8NJCAgUc0tQ8OiSXYznqeUnbbrhPSQlhP0=
X-Google-Smtp-Source: AGHT+IHWBxgXRVeLan1IbXLwr5IkdNxnlpfI/0AVMaa+FFCBgQFF1+WMjd7RRQ9wtNDRtuN2vh/s0Q==
X-Received: by 2002:a5d:40cb:0:b0:33e:1f2a:d88a with SMTP id b11-20020a5d40cb000000b0033e1f2ad88amr1468113wrq.69.1711200497586;
        Sat, 23 Mar 2024 06:28:17 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b00341babb8af0sm3076061wrs.7.2024.03.23.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 06:28:17 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 0/5] Add RK816 PMIC support
Date: Sat, 23 Mar 2024 14:27:53 +0100
Message-ID: <20240323132757.141861-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to add support for Rockchip RK816 PMIC series. As per
datasheet it's targeted for RK3126/RK3128 (RK816-1), RK1108 (RK816-2) and
PX3-SE (RK816-3) but might be used for other SoCs as well. The MFD consists
of an integrated RTC, a GPIO controller, two 32k clock outputs, a power
key, 3 buck- and 6 ldo regulators, 3 regulator-switches, and charger with
integrated fuel gauge. Charger and fuel gauge are not part of this series.
Two of the switches (otg/boost) are part of the binding, but not of
the driver. They must only ever be enabled if no battery charging is
happening, but it will be enabled automatically if a battery is attached
and an external power source is connected. Thus that needs some
incorporation of a yet to be added charger driver.
Integration in the existing rk8xx-infrastructure was pretty straightforward
and only needed very little tweaking. In order to not further bloat the
driver(s) too much with additional `#define`s I tried to re-use existing
ones wherever possible.

The patches are loosely based on the vendor's implementation, verified
against the datasheet and tested/measured on a RK3126 board. As they are
touching several subsystems I'm sending them (very) early for the
6.10.-cycle.

changes since v1:
  - integrated Krzysztof's feedback for the bindings and the resulting
    driver changes
  - fixed a sparse warning 

link to v1:
https://lore.kernel.org/lkml/20240321143911.90210-2-knaerzche@gmail.com/

changes since v2:
  - integrated Krzysztof's feedback to v2 of the bindings and the resulting
    driver changes

link to v2:
https://lore.kernel.org/lkml/20240323085852.116756-1-knaerzche@gmail.com/

Please see individual patches for details about the changes.

Alex Bee (5):
  dt-bindings: mfd: Add rk816 binding
  mfd: rk8xx: Add RK816 support
  pinctrl: rk805: Add rk816 pinctrl support
  regulator: rk808: Support apply_bit for
    rk808_set_suspend_voltage_range
  regulator: rk808: Add RK816 support

 .../bindings/mfd/rockchip,rk816.yaml          | 274 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   4 +-
 drivers/mfd/rk8xx-core.c                      | 103 +++++++
 drivers/mfd/rk8xx-i2c.c                       |  45 ++-
 drivers/pinctrl/pinctrl-rk805.c               |  69 +++++
 drivers/regulator/rk808-regulator.c           | 218 +++++++++++++-
 include/linux/mfd/rk808.h                     | 141 +++++++++
 7 files changed, 847 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

-- 
2.43.2



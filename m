Return-Path: <linux-kernel+bounces-112267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2118877A3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BE21F21D9B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA3DF78;
	Sat, 23 Mar 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up0kFY8X"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04B440C;
	Sat, 23 Mar 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184351; cv=none; b=t+rOrXJEkTFg3rcp2BDgPAvM20hTo20vLpvnTBffFW+WHVdViuy9W0LtrXT6eKoIBhwoJWkyz0l78cEhGt2XL0Dfw/obZwGOEARPJa3nJHeo8Xq+URbTt/64ZGlrrA5ctdtcor+S3v1xTtK2w0t4Cdcs3EZd3hUhPp25gMtqd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184351; c=relaxed/simple;
	bh=ZF7BygSUYovg9SblZ0QPIcT6MWiSeuKLQERl2UIN+fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkOSRI9PNSIcD2IHgjGl1UnYxttE9y0yJ6GOkZITf6D8U2MeQHjtbOK5PG/ELBVmMH/6k2D0Q33z0Jf8nwMsn3NZXGzH3ujtcLPl7BB+ACIKOhYCmMBWe+1YddoxljK6fTn2jAYHsiyHRLRSRIGlg1yGMJnYjZcqOntcgs5xsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up0kFY8X; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so36154061fa.1;
        Sat, 23 Mar 2024 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711184347; x=1711789147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ9+KdXwScarwq3eZMEvlp2qSxDqomLTVGyznQMchR8=;
        b=Up0kFY8XHHnScoFm/eueXph5caWBEzkoHN2sdQEqHNz7Bjpchox9bSATSWQ2YpEHae
         09P0SSBdleu7WBQbcQ4ZIdSG38VP6MisMO/rqkAJZCrk79feOM1cW3WaFudiEBlf4JWa
         A+eJcYf1W8p7VqJOAroda+rxgDADlgn1Wsl4Iq8cQ5JLBfMeKJ6dmDEzteSgbWybaN56
         kX0vMGFbnrVnm3AuYZX11l+3f+RS+UYM3iJpJxbQmbud3dkVbtceI4KeiXoXSqKWHP2u
         ehfvFllMj4shec1mLYbs8UTUNJSPHPX78XEDncoV1UMIufaN8xrubxNJzYvM8yLIOl84
         vVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711184347; x=1711789147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ9+KdXwScarwq3eZMEvlp2qSxDqomLTVGyznQMchR8=;
        b=F7lZ5rtTwwlrWqgBZgvINBizAz5rM1DDJVlr7dvy1qqDQ8C7ad+DklJ0NylMQwpAlA
         sxihCv2OY1k4NChdAOigOw7p4e0MR5XlgSD+TmVOnEFGLJLs/pSSyBCICiKbeYajE4Ll
         +TEAAmNPwV9VTgpMRH1w9aOpHHIJuqI5nOZAo/F2vb4KFGzVzR+cLAnP3WLY7+7Tvsfh
         ow1qNseU3LhWpA/0NsN2vhVaDGT5qtANVetGcV5OgCo4Vct830hTGdArw29o/QssvLaF
         jeJLyz2+B5i8eksjUlihVwWXwqGBML9rZTG0fmw2XkosqYzITI3HNaKakpZRa3M89dRR
         hmrA==
X-Forwarded-Encrypted: i=1; AJvYcCVSmWDZfEWErkViTgrleRiWobT3rEgZgXTOQo9zwWP+CKa8NrJNk/OWygruCE7JtX5bUlGljuTrc3dhHJMhxWlXek/4xCkdJ/yt8+XLA3pWZpanjTx5uYh2uVbgP8aB5zp1+WutyLf/TYet2FTLbVgleafT3x9S7MUHQH1YFRehoVc6ajY=
X-Gm-Message-State: AOJu0YywXQiwdITF8Q6ZjZdMbwlxakc7fPVkAq/5Z2x1WdHr8Lc4TWMg
	TnSz4d3YcIaHQ6vrPBASR0kOzdd00J+nrTId1yNQ9bJ2/7MAhe0=
X-Google-Smtp-Source: AGHT+IGg0Fs7Ikhhf8Mkdjx09JhICxh/CwvAQBZW6CoPdutXLKfdUq9oRvKyht996A+Ebz9GhYfLBA==
X-Received: by 2002:a2e:934b:0:b0:2d4:d50:2358 with SMTP id m11-20020a2e934b000000b002d40d502358mr989680ljh.18.1711184347509;
        Sat, 23 Mar 2024 01:59:07 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6b50000000b0033e93e00f68sm3965031wrw.61.2024.03.23.01.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 01:59:07 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Add RK816 PMIC support
Date: Sat, 23 Mar 2024 09:58:47 +0100
Message-ID: <20240323085852.116756-1-knaerzche@gmail.com>
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

Please see individual patches for details about the changes.

Alex Bee (5):
  dt-bindings: mfd: Add rk816 binding
  mfd: rk8xx: Add RK816 support
  pinctrl: rk805: Add rk816 pinctrl support
  regulator: rk808: Support apply_bit for
    rk808_set_suspend_voltage_range
  regulator: rk808: Add RK816 support

 .../bindings/mfd/rockchip,rk816.yaml          | 269 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   4 +-
 drivers/mfd/rk8xx-core.c                      | 103 +++++++
 drivers/mfd/rk8xx-i2c.c                       |  45 ++-
 drivers/pinctrl/pinctrl-rk805.c               |  69 +++++
 drivers/regulator/rk808-regulator.c           | 218 +++++++++++++-
 include/linux/mfd/rk808.h                     | 141 +++++++++
 7 files changed, 842 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

-- 
2.43.2



Return-Path: <linux-kernel+bounces-110157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4B885AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD6CB23CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8E85278;
	Thu, 21 Mar 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITXQpA7x"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73FA947;
	Thu, 21 Mar 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031973; cv=none; b=Mo/sTb1+giAWOwNwnxVaYN1JMR7m3Tnom6De0avLFz7IK4dV+j9bB5BbNl7+nyhr6GyzvMygIK6Rwstbq9AVnbolCckaVpda4CSrA+XeaBksjcbd/AuE5rd4Ox9Nx5l2fyKQS+m26S3yDo1JcEx0Hp45aqD3xYTdBZ4biRAE2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031973; c=relaxed/simple;
	bh=ooTH7gf09au326sfah1yiJQCIw1o/Ntkez2jlP3EqUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJGVyHly0EepaLUepJ89IdDxY6j80giMuCnBkL+11VX8cx+vJerG8ubtCdyFc87y+V8EF7oFi3RE9p+aF2DoS91GgTXpMIBL/oR3TKb0M8xyyU+S77DaLhDgv2HdmaauZqr/RLdzd5Ttj5Liz7sDYYAU5sYEob06m+LnNFFTiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITXQpA7x; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1495840a12.0;
        Thu, 21 Mar 2024 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711031969; x=1711636769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qXITx5mQ/vCXW+D4l5s0fzydZH5TzXg2O0bB4XMDMU=;
        b=ITXQpA7x3fVvybree77k+XRpSFldQGJ5ntNXV26xMW8DBqcEjhWabb3hAuERd1KLNR
         8YlmwCLub6VY+V9JO7bvA/Ac1JHylKqxPKWub3wc56r/pwZRFCR6tb3Syq/sltA6XcL5
         13ZuMkuyt8E5tJ+mnNhjyKQkVwC86ouAJojNMDpilpPlNeiov1nU+mTu9tT+3A2aJMGW
         7l0z9tWIIbFCVvJNKcieb7+U6LwEmS1ZsxA0pfagsij13bwjaQ2UexEXspLz8JN63ery
         HAHgxQyNrtK7Jxo75fvtj5jLM+QBqMwyTxz9sk0/o5eHnScz61nWX/qyz9i2XlITUX8V
         9xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031969; x=1711636769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qXITx5mQ/vCXW+D4l5s0fzydZH5TzXg2O0bB4XMDMU=;
        b=sBUuZICYCC3fVS8z3iHrhf8eiLFnir88UQ7wvye28LwqRMOkr7fPhcaI1frRGfb/oP
         T0R4WBSJUi8gGq+JkFcPOsCKPGO0RCN06J7ez+09lkCne2Fjhd6enGoznOyyJa+wCaaQ
         f7a2lTVC/Mu9hDb2FF86NjCKqlXa88wuixZGiHHnuVLeCNZpOHnsmhaRVfAkNz1Fc1vD
         LJfDHBgihZVXvuIZJkqLKQBoZCF/7porlyNrkb60vhbJufVYDmvXcuqGfcql1zKzvddm
         vxfFL0+GaXsmcXsEHRdGPHBVCHkenJ9uslqkP+geuhcHu+xyEJjIupwYV5YGOaLFt/lC
         F94Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI+/VKwlh//uIv9p2JsPAgPxpTq//ikDT+5STEWfXnxgjjzJnYLuUfd+oiJWmAzDpggZzQ+5hDH8mMPSQjqx924O5z4sN8u5dGK+x9/Jzu1F3xLAwOXalrL45X6yJ962sXSx3Ex4RiGmaus1W12QKBRzDPiYeCs1/B2GfcZnDceTs4/vw=
X-Gm-Message-State: AOJu0YxXpxSHSPh/burmVQZNg08nht1zOqL2XbJTli8iO0FLUUu3sBzh
	+N+dCVCHgp1tlc2FWjaIhFNheuAliKxaoVUa1sp+wkDBMj7kyqYD5fMFaqc=
X-Google-Smtp-Source: AGHT+IFTcd4jzFilF6dem225sa68PADk/S7/hKSTYPC+aEHwNm7QUVNRqEyLe/nR363LVmUMjJocqA==
X-Received: by 2002:a17:906:f757:b0:a46:fb17:8871 with SMTP id jp23-20020a170906f75700b00a46fb178871mr3147904ejb.76.1711031969400;
        Thu, 21 Mar 2024 07:39:29 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b39:dab4:8e20:e918])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b00a46abaeeb1csm6147923ejb.104.2024.03.21.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:39:29 -0700 (PDT)
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
Subject: [PATCH 0/5] Add RK816 PMIC support
Date: Thu, 21 Mar 2024 15:39:07 +0100
Message-ID: <20240321143911.90210-2-knaerzche@gmail.com>
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
PX3-SE (RK816-3) but might be used for other SoCs as well. The mfd consists
of an integrated RTC, a GPIO controller, two 32k clock outputs, a power key
(output), 4 buck- and 5 ldo regulators, 3 regulator-switches, and charger
with integrated fuel gauge. Charger and fuel gauge are not part of this
series. Two of the switches (otg/boost) are part of the binding, but not of
the driver. They must only ever by enabled if no battery charging is
happening, but it will be enabled automatically if a battery is attached.
Thus they need some incorporation of a yet to be added charger driver.
Integration in the existing rk8xx-infrastructure was pretty straightforward
and only needed very little tweaking. In order to not further bloat the
driver(s) too much with additional definitions I tried to re-use existing
ones wherever possible.

The patches are loosely based on the vendor's implementation, verified
against the datasheet and tested/measured on RK3126 board. As they are
touching several subsystems I'm sending them (very) early for the
6.10-cycle.

Alex Bee (5):
  dt-bindings: mfd: Add rk816 binding
  mfd: rk8xx: Add RK816 support
  pinctrl: rk805: Add rk816 pinctrl support
  regulator: rk808: Support apply_bit for
    rk808_set_suspend_voltage_range
  regulator: rk808: Add RK816 support

 .../bindings/mfd/rockchip,rk816.yaml          | 259 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   4 +-
 drivers/mfd/rk8xx-core.c                      | 103 +++++++
 drivers/mfd/rk8xx-i2c.c                       |  45 ++-
 drivers/pinctrl/pinctrl-rk805.c               |  68 +++++
 drivers/regulator/rk808-regulator.c           | 218 ++++++++++++++-
 include/linux/mfd/rk808.h                     | 141 ++++++++++
 7 files changed, 831 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

-- 
2.43.2



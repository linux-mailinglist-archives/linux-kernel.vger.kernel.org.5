Return-Path: <linux-kernel+bounces-14717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB482211F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BEC284415
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E3115ACB;
	Tue,  2 Jan 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/diWnij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F307156EF;
	Tue,  2 Jan 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so55564005e9.1;
        Tue, 02 Jan 2024 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220729; x=1704825529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSbX98OpsIFhknrkPUlnLd/Gb/xC0302JuUUTWaUNQQ=;
        b=F/diWnijXehkaytk6d6bz516XLsD6t29KKBQLoUd9wiI7FxEgYSe1HuQrXWq4SzNUf
         uoZIjjBKFspPIjfTbaZIrSCmcQ4kbALgQoy1cE7/DHCZWEB29KmHt8zU+gzA36tolp21
         vQVeQOYbpELVh4o63Qy4U2MEz/G8Ozg1j2d+gJwe68EElPcEmQV61hQ/Sro7VAGjFkkH
         9lKUQ5v/UK9uNPtKwD4ITMP7GVkAG/t4S3xgezWauUvqg5lsgLpHEHEl9xA5KYMRIZzu
         34QOo9BUNn4iJc3iFbCyzY9zmqcZr4k1kPTzBndTdX2IKwJ1XwJbk+l7OXPBr9gY6WdX
         P00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220729; x=1704825529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSbX98OpsIFhknrkPUlnLd/Gb/xC0302JuUUTWaUNQQ=;
        b=ARZkmpptTy0FjyZiZjYFwPoij8nfJanwf07BzVOa33IZDrUdLlerX4MoLq16fYPDaX
         DA9ZQYb2krKk+NtUtXz2zpCIYF4ooO+fbikb4rkzxkTnDEefL3Moqv/w7QuoNYXufcyP
         KJsPh8zRGNChmD7t/WNSJepukyqbdBdu9+Z0PWpQEWr6XNRxt76l6kvb2lfNJ9U6VV79
         Tc78CxFUC3R3eNeLDDPelMTduZa3XQkMXp0IVh9k8IsJVUcnLOwfOHFe3fZ0JeWxP2+F
         ya9lOz/W3fg4L0HWzCNIwsuE4NA0LXe5KmETMETYXG8y3PYInzjUqf5WR9N/aT+z1tOI
         Rhsw==
X-Gm-Message-State: AOJu0Yx/mJpbspeFnbM3dzr+Z8pLFFcel5q22zuTal+Z6v6Bdh9Hgn+z
	J6hB7kJuH5t7e7V7l2okJv4=
X-Google-Smtp-Source: AGHT+IHS1rXQmYTNGbOeFEUNy2APVbixEkLwy9K4cxhk/vuhAL2D1ayBVg6w75D32M9xrGQChzIoaw==
X-Received: by 2002:a05:600c:3542:b0:40d:5a6f:fb72 with SMTP id i2-20020a05600c354200b0040d5a6ffb72mr5752891wmq.57.1704220728913;
        Tue, 02 Jan 2024 10:38:48 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id p15-20020a05600c468f00b0040d4e1393dcsm37963071wmo.20.2024.01.02.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:38:48 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [net-next PATCH v6 0/5] net: phy: generic polarity + LED support for qca808x
Date: Tue,  2 Jan 2024 19:38:29 +0100
Message-ID: <20240102183835.5332-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series add LEDs support for qca808x.

QCA808x apply on PHY reset a strange polarity settings and require
some tweak to apply a more common configuration found on devices.
On adding support for it, it was pointed out that a similar
feature is also being implemented for a marvell PHY where
LED polarity is set per LED (and not global) and also have
a special mode where the LED is tristated.

The first 3 patch are to generalize this as we expect more PHY
in the future to have a similar configuration.

The implementation is extensible to support additional special
mode in the future with minimal changes and don't create regression
on already implemented PHY drivers.

(changelog present in single patch)

Christian Marangi (5):
  dt-bindings: net: phy: Make LED active-low property common
  dt-bindings: net: phy: Document LED inactive high impedance mode
  net: phy: add support for PHY LEDs polarity modes
  dt-bindings: net: Document QCA808x PHYs
  net: phy: at803x: add LED support for qca808x

 .../devicetree/bindings/leds/common.yaml      |  12 +
 .../bindings/leds/leds-bcm63138.yaml          |   4 -
 .../bindings/leds/leds-bcm6328.yaml           |   4 -
 .../devicetree/bindings/leds/leds-bcm6358.txt |   2 -
 .../bindings/leds/leds-pwm-multicolor.yaml    |   4 -
 .../devicetree/bindings/leds/leds-pwm.yaml    |   5 -
 .../devicetree/bindings/net/qca,qca808x.yaml  |  54 +++
 drivers/net/phy/at803x.c                      | 333 ++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  12 +
 include/linux/phy.h                           |  22 ++
 10 files changed, 433 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

-- 
2.43.0



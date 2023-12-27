Return-Path: <linux-kernel+bounces-11915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5381ED7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289AB1F22BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0A0199CD;
	Wed, 27 Dec 2023 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjyB78eV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3C24B2A;
	Wed, 27 Dec 2023 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d514cbba3so36347925e9.1;
        Wed, 27 Dec 2023 01:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703667784; x=1704272584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z63r7pTq+SRGl9GETybyvgqCF34V04xy6H98jsuZPZI=;
        b=WjyB78eVUW0jNKrhcEjddivwhRngwIyVYc6jwaxeW9rdgBgNBtB2dhrdDT9LSON4jX
         xA58WHUVehWFkxBlmIcjm12vPKm81ZxgwjbchCxUlEn4LB+ygsnZV5qzia9RfQaJk38i
         yA9zSQ5z1QOEup6HZrMwIxtU2Rf37nmTv34+vGn1UMiz0tByVi2/ILpHjzNwYRBGoq7l
         IhnECBkjHSxMHu06AHRilRPYyeTwdoPvwReBbHn1VVzIk9h0NyXZrjwrMJ+8BURr+xIE
         bsCffrak7AS3jbsU0qbrYqxTloC608ldgC/TccibaHMBaFhtkyUildxSn+T96UUXuc/v
         +HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667784; x=1704272584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z63r7pTq+SRGl9GETybyvgqCF34V04xy6H98jsuZPZI=;
        b=dmP5TswD1PS5K/v10pC25DuQPMQtVfGjqdi2aO47a+ghcTaJ4Yw+5/uRPtz4r7rW16
         E/M/j0wcsXX4hUPutxRnvXe7AqOq49kMw2ehPySZaV1CjRwp6qkD5ieA6WH4DeaFWWoM
         UBbSUup1t4N1Gh8grcni0plQWlb0y8ETRXmLLqanBgBLdEHWmHsoJDWTLWLUnAKYzUeJ
         2CTR2vOUME8AuMiBpx4VdJcVKUmX1Mhxgv96FtaJIeeBgroVX/GHLgf5BM2mCvnaej0A
         2q43BtQyVXXijaWXISyeoeVPSi52B5Trync+0YuVg9YCmg+Ie4rYoZNkXY07GulhFMeq
         LR/w==
X-Gm-Message-State: AOJu0YwdVaS17cJ/2xsCEYRg4RqdBV4s1TQV7FyWqPPMAiJni4cuxLRq
	4EKjNQGZNAaP4v4g8CNmhYo=
X-Google-Smtp-Source: AGHT+IHnuyc35+3QB7TWpnYL1hpXdfnP14Z+QTgo+E3w6csqT773gDAld+ldCoxjApvJfhAQ2a0YiQ==
X-Received: by 2002:a05:600c:538a:b0:40d:2cdb:c99d with SMTP id hg10-20020a05600c538a00b0040d2cdbc99dmr4595418wmb.46.1703667783651;
        Wed, 27 Dec 2023 01:03:03 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056000104900b003368849129dsm13616525wrx.15.2023.12.27.01.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:03:03 -0800 (PST)
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
Subject: [net-next PATCH v5 0/5] net: phy: generic polarity + LED support for qca808x
Date: Wed, 27 Dec 2023 10:02:26 +0100
Message-Id: <20231227090231.4246-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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
2.40.1



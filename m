Return-Path: <linux-kernel+bounces-16550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768D824012
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF44285FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A0210E9;
	Thu,  4 Jan 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grgDXxek"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98620DEF;
	Thu,  4 Jan 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e72e3d435so354412e87.2;
        Thu, 04 Jan 2024 03:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704366084; x=1704970884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/MRWpJxpo5WpqOvOF6T61bALH/1fkde2/3TE3AX0Dg=;
        b=grgDXxekshjT64MJTewrScvEpUBpK8cGbbnZkBEPZgZmYZZW+X4x7x07sdaJpH8LBJ
         1ZOCtV+aaU1PsDjc+/Qf6VXqOFBYopMLKcd6BYOtv5wt/hY5L209+O6jPz0jp6URMvbn
         3bNS6Sk1U19QyV4N7pTbim4E/ZoaXyWZhVoI2BWslMU1ROvKmuLNB18l4YXD6jh9kAa+
         7MbZkt51mR78/Y5Al5cdlY4tbLtyzZTC9d8GaFzdlii0H8EKKsqPiQHqjWP4OZL7nSh5
         8gHpKhZzCpIIFBYE0eMVToMvMDVjMT005th/rYMCvufmRwVYzR8AmGguvsCpGHfvOtIF
         i17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366084; x=1704970884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/MRWpJxpo5WpqOvOF6T61bALH/1fkde2/3TE3AX0Dg=;
        b=oipn0Ibj94ls1HX735f1fyYSGlFfgs3yk5vBvGHwZkCQKNPPURtB0acFjaJgMuwT86
         6Ji/Ry0Hg9dcQMBa76P9mJXm+A2whgAvyBu2KVatWEhHPApNOnco8qIQI9p8JwwD2YTQ
         hfX32ONVV3kGlaZl8+1sbhky8JjJ41MWv1HjDW0ynqfDnBCIzAJAgItZoo9SwsfugH6a
         B8gGGpX076XFfOaY0MLUsIKieFjSMda3A/rkTM/i3QWkKJ8O6hu04eOJXwrUR7sm6q/4
         QNq7BJ46QC4bp1lrUeTE7nRn3d8PUlu/T80bwR4SIsHIOxCXzgqkHmnwnh4lzEYltFYK
         pLRA==
X-Gm-Message-State: AOJu0YwPgUDpprj9TkS6hIHbjO6nL9tEUGM8gDMB4VT7jdJj9SCLzbYN
	iGQ1Hn5U7xv/P7H6F4WVLHc=
X-Google-Smtp-Source: AGHT+IG2U8U3DyLWmid2os85oSzrlmqvMXgeKxltKwT31ud3i1MamX8APpCOCIdMkwLsQlvEvwFm3g==
X-Received: by 2002:a05:6512:3121:b0:50e:5a8d:1428 with SMTP id p1-20020a056512312100b0050e5a8d1428mr162305lfd.141.1704366084208;
        Thu, 04 Jan 2024 03:01:24 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id b14-20020adff90e000000b003373fe3d345sm9550242wrr.65.2024.01.04.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:01:23 -0800 (PST)
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
Subject: [net-next PATCH v8 0/5] net: phy: generic polarity + LED support for qca808x
Date: Thu,  4 Jan 2024 12:01:07 +0100
Message-ID: <20240104110114.2020-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/at803x.c                      | 325 ++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  12 +
 include/linux/phy.h                           |  22 ++
 10 files changed, 425 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

-- 
2.43.0



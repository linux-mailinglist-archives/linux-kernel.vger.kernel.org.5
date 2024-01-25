Return-Path: <linux-kernel+bounces-39250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0A483CD87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C171F25DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7991386B5;
	Thu, 25 Jan 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3ynXEbt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84566745F9;
	Thu, 25 Jan 2024 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215042; cv=none; b=WVh73Mrwl/e32oTyj/46psdwFws0A2bvT0e6EGhl4WUSOJSU73zLWv37cstbYij6BGZ/1r5v7052WkEd58Q5vXGGPN71muovFAMRhhG22AIMQsCN4iFS/e/vsnbheqz1KBp0LinWwA/p+cd/EOcXvosJ7Tuh3nSVLGTz8n0SwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215042; c=relaxed/simple;
	bh=XbNKlhxL9eBHsnZrFANg4aSuKdkPlXeOFguiGbZWtSI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cxH9e3ZKFhfkeIlRVVnqrnsXVFhaiF3lqiqqQ1KWmBWsdLXZTxGBv7/laXyVNJJOdYWd8UYfNTRaxZm6Rx+WfIp5a/Qz8GtXcR2Jk2FVRBfU8O41I5dJwdpIXHbrFJsQRRObsGLa1C8yNTXpHRUhkZR9kYvMVuSswzGm4jmnU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3ynXEbt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso59109625e9.1;
        Thu, 25 Jan 2024 12:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215039; x=1706819839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=usoxiC3FDcTPSibyEkVXiYsO2Tz+iJfHrI4jPy9mSt0=;
        b=F3ynXEbtppf2wbpdrgnvbYSIGbUepZp2SI8HftIHNAiuuJ95L/5XKP0QO0erXq1n4k
         GW1etYrd/z6pNQ12BA+YiRRez+wdZqrWoUQxbNAEVU3is0y5bwhI2LeG/Jm1aKmSDDoe
         cOMC5c/m4O74dDza0Si+vWbezRTkuWTeG79+6mM8Xf6LPGLvd+7kPgPKbrBOjjSW+BBT
         QYFLW6mmv97ixHT47Q/TbN2qA8hnXzNkkwZiztOmdmTd4ysh1tDn8dV9zeJb81naAW7K
         cLmj3Gv7WEPtR5xrI0cP10f86I0BV/SI4YmlUaVUwixX1AzhapJikVi00Pdosz71BLSE
         bFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215039; x=1706819839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usoxiC3FDcTPSibyEkVXiYsO2Tz+iJfHrI4jPy9mSt0=;
        b=Iena3xHOjJAAex2DNkAEPmlxNhzsa6g28EC7Oq4XoZrsK139vi1noN+ZpAbPZfuNLd
         691SO4sf6f8sBQMjBQqsdHulsEfAO2YIInlHXAcToN8eUziku2HsKNE3UKUzzbPWW1mV
         RaxhE+SJRRz+pmlMNcFaz39OrQ5xnmWWrnO3XC/JUkFK/+8GVkTXI0G9VBdbWz9MTkBI
         n0Z8pqh4eMiGKi8Dz26tk9BOY/uh7y8gKprJ9cBNIxCq4RB1OHpa3L1NA1uOJIHyYBiY
         K+eoB7pPJLB28AjAvSx9gzvNYlDbZ3Rp42Uo/EcbQfSXylWyTNiZ+w93HaagQ5foH07Z
         rS9w==
X-Gm-Message-State: AOJu0YwfWCh/MNdwap1pCk0V4vC790TkILIbezmE8UP+Z3h/Dk03vf9i
	tvrP8CmMHJaO2TTrggs5EtGGaTMX/dfXbxrb+j2JegyQtmBj4dIh
X-Google-Smtp-Source: AGHT+IGQqGQu3vY9rJ2Gp7SnjSyos2lXwwvM5FpsVkTmbrG4S5+mPRRKo4ksKFkuuCTkYfWdDYeTjw==
X-Received: by 2002:a05:600c:16d3:b0:40e:ccf5:b647 with SMTP id l19-20020a05600c16d300b0040eccf5b647mr95609wmn.370.1706215038444;
        Thu, 25 Jan 2024 12:37:18 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j32-20020a05600c1c2000b0040e813f1f31sm3817700wms.25.2024.01.25.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:37:17 -0800 (PST)
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
Subject: [net-next PATCH v10 0/5] net: phy: generic polarity + LED support for qca808x
Date: Thu, 25 Jan 2024 21:36:56 +0100
Message-ID: <20240125203702.4552-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/at803x.c                      | 327 ++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  16 +
 include/linux/phy.h                           |  22 ++
 10 files changed, 431 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

-- 
2.43.0



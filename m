Return-Path: <linux-kernel+bounces-17922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A426825526
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C86428599F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BA2DF95;
	Fri,  5 Jan 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmWVi5xn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00524249E4;
	Fri,  5 Jan 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e3712d259so9463105e9.3;
        Fri, 05 Jan 2024 06:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704464850; x=1705069650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=APs6M2apAcMc7l4gyNVGbiDS8kiXtv8paG4oTVl8I+M=;
        b=EmWVi5xnxcxZZ1XXRNIERX3OCp9zflu6KisHrOmviY58TiVMUSZMcco1e8EtJC6MK7
         d9IAjs2vnZhI9Rn3kOAW1Z7yC7JH8LFulJ2OYs8GulJnXpoNJFknqLLZiYmoXCWbw7Vs
         r1cPt1PoFq1NLjsXBBc5NSRtWtA7DWu7TTYM9GghnsilLlFUXn8PmmdoRnIIjd6nFNoy
         buH1GGrUxCrBanbqYMZgBBgSC/Tg5dw2udn/10hE5ptXBy/+EhJTnwjHbj91Giu/1nXc
         0fjSc1cILQGPKCxp8U+MHGw5biqNdXnZHdBKNaGc4FKUzCYKNPSP1eX04G1qSBrQWumd
         BCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464850; x=1705069650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APs6M2apAcMc7l4gyNVGbiDS8kiXtv8paG4oTVl8I+M=;
        b=ME154JN+MZq4qWVg/JOUY4ha1L1xHSt2PAPva/ZNI+CKRuMsl0KI0aYZiAQdBrz7NL
         GhTLyhMj5tgebWTtsLXHSgfR0IIngkncoku1CiPKubHXfs7/PGM1PyaRcfBhjPFprGpW
         IrwDlgnZDt6fqHb6ERvto+0XsKQ1jWX2ODI7B0n5jVPszWP97ofDa+4MuwgoSP0/Z3jo
         P+EXNH5HqGEBoyaEN2+hC0dLCKRyR8rYlujyBDqSJqvFDbRGLqNKE05TaWVyYyGOP59Y
         tbmx7x3cq/OtdGntF1yjTkhUff7tcigfHifR8btlJGUVKao2t/6Linh01Gieu9lPSYbb
         NAfw==
X-Gm-Message-State: AOJu0YwPzM+wwUrZMMFtQx9fp4wcWqhxC38LgXRu8Y61RBmTLMMDrdCy
	KZ+C6RiuqiRzgQtzzL0SD3A=
X-Google-Smtp-Source: AGHT+IHYUKZEg3ZHc+KdILbEa3OOY5XvzVdKgu2YvZoApQ8eTegy++Sxib9JfwSlgU2ZR06SaA255A==
X-Received: by 2002:a05:600c:3ac7:b0:40e:3ae4:84ef with SMTP id d7-20020a05600c3ac700b0040e3ae484efmr112839wms.73.1704464849826;
        Fri, 05 Jan 2024 06:27:29 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c190a00b0040d87100733sm1721901wmq.39.2024.01.05.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:27:29 -0800 (PST)
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
Subject: [net-next PATCH v9 0/5] net: phy: generic polarity + LED support for qca808x
Date: Fri,  5 Jan 2024 15:27:12 +0100
Message-ID: <20240105142719.11042-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/phy_device.c                  |  16 +
 include/linux/phy.h                           |  22 ++
 10 files changed, 429 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

-- 
2.43.0



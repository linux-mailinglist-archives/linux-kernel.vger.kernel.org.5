Return-Path: <linux-kernel+bounces-16098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820128238EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25975B24631
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0441EB3C;
	Wed,  3 Jan 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN8IGB0/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB71F95A;
	Wed,  3 Jan 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so60942835e9.0;
        Wed, 03 Jan 2024 15:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323091; x=1704927891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKP/S6XSZaDGcudVaS0h8PY9BVZmPCIH7/appJgF/zE=;
        b=GN8IGB0//uItkWoSyjYTr838W2TQxNmKReg1+0q69V8sdVz5Vzksmy/wV16EJATn7R
         tRpyxVTzwA+65mP7QBQPFpOElGNenbgCU529cOZHc9ADW5qsdVM9K2+JkqysThs6tB/c
         McbR34DbCv8FkPgRU67bbk631aluf6vDpyrQstSRDkZBPWLGkG4UaG/PPsa7w3zA2rX7
         H4DAc1KNe5Qwm3m4KT3OGcQ6TN8jy+NebWQf2NVF2koianMSc39jbdaeoWTd2rx/rxo7
         GqRhnfEOrPptxGjcIQ6K+uYK/qxNsdUO3gpVJboy8wS8Nbb0kHqKcO57mZIRgC3M62/x
         JPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323091; x=1704927891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKP/S6XSZaDGcudVaS0h8PY9BVZmPCIH7/appJgF/zE=;
        b=jl7/e7nYbZSpJCUlkb73awcm28Qwa0L6QvRXitJJywO7hOtUTQ49XHzXczOmosbLQn
         Qrv5ksnK20oZMkBC3wyPBuft1zQjuHQ53197aALwDBPXAP3DcCQ2+KwbKhEgmYVYfZ+k
         BAg8r6/8E/hyA63k+8dmrGP/6RWxyWcdrwKQeW4qlhOitnhZp/SmITa/MK353ZJQ1yqA
         etrOgIVBcY9a/89kl+PQkbFL8qaJ+D7I6MRWKw5oUeWRqjzTWpg9Mju2joDgElMIZnk1
         tarIUyecw4UZVJcSudyyBrRj54g81Qx5r8WEnzDc66wn8PKMHad2wTBaqqrFX0775lSK
         NxpQ==
X-Gm-Message-State: AOJu0YxSxvslQtfFQV3zLyoLvsqT78kBxG9sGROdVm75OrXr82S1icfA
	UNOTWXKfjedH36iW2maBQXI=
X-Google-Smtp-Source: AGHT+IG1+90FL/z53soE2V8+HrXb98ZdAJ4W4hmXkScdkrI8R6H31ryA90iwZMBeRr9IjlI2AKzZ5g==
X-Received: by 2002:a05:600c:2116:b0:40d:5fd4:ce2c with SMTP id u22-20020a05600c211600b0040d5fd4ce2cmr5275517wml.53.1704323091218;
        Wed, 03 Jan 2024 15:04:51 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id w13-20020a05600c474d00b0040c46719966sm3740969wmo.25.2024.01.03.15.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:04:50 -0800 (PST)
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
Subject: [net-next PATCH v7 0/5] net: phy: generic polarity + LED support for qca808x
Date: Wed,  3 Jan 2024 15:12:33 +0100
Message-ID: <20240103141251.23446-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/at803x.c                      | 326 ++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  12 +
 include/linux/phy.h                           |  22 ++
 10 files changed, 426 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

-- 
2.43.0



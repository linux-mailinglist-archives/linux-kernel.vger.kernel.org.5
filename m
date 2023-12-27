Return-Path: <linux-kernel+bounces-11917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D42C81ED87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD061C215AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2832D7B3;
	Wed, 27 Dec 2023 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjH+9fVK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCEC2CCDC;
	Wed, 27 Dec 2023 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33666fb9318so4831092f8f.2;
        Wed, 27 Dec 2023 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703667789; x=1704272589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cmsj+MoZd6CCP0Gk1jswJO8zXGhPor2mMopnaqDXKNM=;
        b=YjH+9fVKdUOukVscAmESs9ja0wqCtPBjpXJse2CT8r61btQoKu6/bmz6ByqplB42OQ
         VSj9VFBIvk0Bhlq449m3mVgJwP5NRGgVZ3TzlANwQB0WgVOe+bimVlunvRdHF6AILQCV
         utk0u6KXEVV76BNG3eYfZkndp/mEQ0OIWt2FBVx2ZTTayt69pxi50r6mA7/dsroKHAV/
         nQWz/kpChQZunOquMXoC+ebt3SadI4XEhjz2zOfdqPve3Ivy6/B6dYzvuRF80+ZaugsW
         RacyWiwtAgK9igbM62tN+yBvLnlhBr9TXp7zbOtC+ghhpo5Syrs0mF9QiRxZ3UTUBnHB
         U3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667789; x=1704272589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmsj+MoZd6CCP0Gk1jswJO8zXGhPor2mMopnaqDXKNM=;
        b=BIEzq5dRv8rPhaaT/LfU8MijsbbHMt6Ny/Umnc8XskzzK9U+pgyspW5tQjPoSzAvpt
         jc8sngV9LJIwUR+OIbOPWVGJQ9dpQ0ft92W6dJZRldFwnQ0TafmUCtzt3Ktj17AbLj2w
         YKp2SIbI0HO1eaxcR4PxS2dUlX57/of4MkYe/5PpaHBBhbwt5qvBCHekgKJOM3Bof48U
         vsHR0DkIfJuvl9Wy3OtxkybprUnT6+Ju9cv/bwcUNM1dWN78bSV5HUkg/GbVTKaUz/ZH
         B8e0pLIm3xlusb0S1d5AeN76HpN/yTusbkx+yscglNc0m79OpkQDy416/83cGhjByBrZ
         l0iw==
X-Gm-Message-State: AOJu0YwlqPK/CvnoHuBa5LXIB6ee7vIRgAQ72SKe+PBxtGrOyetyXuP9
	lqpmvXnNZzbMin0AKQE+d/k=
X-Google-Smtp-Source: AGHT+IHHsaIuTdzyY6EGsQXG120Hnd9I7mUH54bEZwAsYXgidJXrJL92gmVnfimcwq3PRJHagcE36A==
X-Received: by 2002:a5d:65cc:0:b0:336:7bf2:89da with SMTP id e12-20020a5d65cc000000b003367bf289damr4865220wrw.95.1703667788502;
        Wed, 27 Dec 2023 01:03:08 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056000104900b003368849129dsm13616525wrx.15.2023.12.27.01.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:03:08 -0800 (PST)
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
Subject: [net-next PATCH v5 2/5] dt-bindings: net: phy: Document LED inactive high impedance mode
Date: Wed, 27 Dec 2023 10:02:28 +0100
Message-Id: <20231227090231.4246-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227090231.4246-1-ansuelsmth@gmail.com>
References: <20231227090231.4246-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LED inactive high impedance mode to set the LED to require high
impedance configuration to be turned OFF.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v5:
- Add this patch

 Documentation/devicetree/bindings/leds/common.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index f5b40df6b421..9e7b4aabe0bb 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -206,6 +206,12 @@ properties:
       Makes LED active low. To turn the LED ON, line needs to be
       set to low voltage instead of high.
 
+  inactive-high-impedance:
+    type: boolean
+    description:
+      Set LED to high-impedance mode to turn the LED OFF. LED might also
+      describe this mode as tristate.
+
   # Required properties for flash LED child nodes:
   flash-max-microamp:
     description:
-- 
2.40.1



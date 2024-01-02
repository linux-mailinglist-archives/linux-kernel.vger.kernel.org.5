Return-Path: <linux-kernel+bounces-14719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DB822127
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8996A1C229DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CADE16410;
	Tue,  2 Jan 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh3gxCZt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3C15E96;
	Tue,  2 Jan 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso18913865e9.0;
        Tue, 02 Jan 2024 10:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220734; x=1704825534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=bh3gxCZthU5o+NeI8ltUHmKObu+vqs75/OmR/mOiwJb1a7HHkKHxKq35y8hkKSXwSY
         49T8CQkmCRztA72jphRniikpbqnwJUdqU8RTnwbKXWQSqYxwGTJLiM34ga8EkTf5S1nm
         B43vbdNb0shIE32C/GKTqtvTYHo1h2/LL0AVSBMGPY0taysPABwy3cpIGPgdTWBUy0YZ
         IUuM1AI1bLi/y8mLOtJVeUlHX0bEuiYv8xmoCyBYjawruRBppFX1bSewdgCGlA9Jn1SK
         +GhZQog+ubJxoFLck+n+5o24ZH08bTP7fs38wJxC2/0K5f892WuyRmCbY8cuRmFCjF7X
         nPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220734; x=1704825534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=dp6dgJg/laUgD81XdkjI6FLpJE4YpZDw8ClslB9OeMcIZ4AZ9/VEKXVBPfDrJhSXVQ
         FyrZkBdYz4S7rXxyfOe6LL3rKNEGELCk+8letHUf8phfDZT4aBD3J7FgRJLNKa8D+afb
         SMHf1VDGmK9DCGnirwf5xKzXn/fvAAAzsfSFYp0Vv8PZ1oVjuGq/qt1ZcRUh5gFoeobl
         NfZq9Z7ki9W/umujo24Z36CJyALeNLg1t+azKM7uEzlBVC3BUmf3E1OYzUb2h+S248yi
         5FPyThG4GzjIQaSt8//84BgIGF2/HuOVRptakxm7JIkp/p0JdCFtPBrt9V/asruXFe2v
         tN4g==
X-Gm-Message-State: AOJu0Yz4SJyPQDZCzXBHx/315NavpCsJj35DIS5wWxLNssUbqRp17m56
	XagH0M5czSRr1KGDp0QlM4g=
X-Google-Smtp-Source: AGHT+IG2pSckG1PHUYNy3YxM7pXKgDcud+HdSBT6t5jofi46SzOyR64N936joZAMYxi4RPr3iwsGdw==
X-Received: by 2002:a05:600c:5207:b0:40d:88ad:5aad with SMTP id fb7-20020a05600c520700b0040d88ad5aadmr842755wmb.362.1704220734080;
        Tue, 02 Jan 2024 10:38:54 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id p15-20020a05600c468f00b0040d4e1393dcsm37963071wmo.20.2024.01.02.10.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:38:53 -0800 (PST)
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
Subject: [net-next PATCH v6 2/5] dt-bindings: net: phy: Document LED inactive high impedance mode
Date: Tue,  2 Jan 2024 19:38:31 +0100
Message-ID: <20240102183835.5332-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102183835.5332-1-ansuelsmth@gmail.com>
References: <20240102183835.5332-1-ansuelsmth@gmail.com>
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
2.43.0



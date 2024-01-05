Return-Path: <linux-kernel+bounces-17924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B05C82552E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5B91F23A69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F82E821;
	Fri,  5 Jan 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpQ+RKxx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8142E633;
	Fri,  5 Jan 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e37524fafso8137415e9.1;
        Fri, 05 Jan 2024 06:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704464856; x=1705069656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=QpQ+RKxxvqz9+IaT9cV6jEadSVNpR9iXiXF8Ysoli/y7pJjRTlv1LcdkOx2AepRVAv
         OhDdGggHSRNP5kVaLBBI/D+emsNtG5+Ir627RmZs3LcgF4/q6kY5jWzd2xj5OcdAJpwU
         ygNvsD4wwVoIW25Ki9hQRcRsetsUcuU1mtJKjxpm9pVOD8l29Afk0h+c8F0obkCktTVD
         42/P98AoPLuPBRORBwH06/OLnlMvC1T/xTJus6skPplvRVmOnVAMSUcAQpXj4R9baNqG
         OnR0algRZseBAzYkosGaoW5/ql//Kgof8ZvXAcw3YcWu9857FNkzCBxCZpT5Zrlk80Wu
         JzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464856; x=1705069656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=LlwRrX5y3mkoXx+NmdRsHqVhsMh4f+ol2VqjHfzO6P/D+jALo9i5Qcm2iLqcGYi7PV
         a1EJCzJfS63xJ2q4urVRpIARseDg4xhP3Ljjhd+o5po1MEEchZrx8962+GGuipTnLjNo
         l76zFJxinrXnFVYh+IVyhhPbMKuZOic5ZDgYoPTKCVfdgajY+lDzrLtq/DN9s9gjEp2Y
         5NhCUN6IFlAZQOrfSVhafOZxEiA3XDIkO5uX6MltPDfvZq6BSu2G8mIq+wKBBIU7lpdR
         ogG7mM/VszTD+5xuOYrFFC4CPwM1NPMa/xJTvK8evph9FGSb6KciDQgkb3sRwIjvG4F9
         XqKQ==
X-Gm-Message-State: AOJu0Yz4kuzyglokvnrIxwKfKCYPPFFdWEI7O9d+t8ggHpInnZvgE88b
	lhfWcwcZWfxvK+4qC0BiYVY=
X-Google-Smtp-Source: AGHT+IFfcXHjnx5V7BZ5cTpo27hQwIRRW+1mUNvK0E8CWe3CijUDyyx0xylOWwoq5V6gW0DLzKs6AQ==
X-Received: by 2002:a05:600c:2154:b0:40d:6eb4:4b9b with SMTP id v20-20020a05600c215400b0040d6eb44b9bmr1190874wml.144.1704464855959;
        Fri, 05 Jan 2024 06:27:35 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c190a00b0040d87100733sm1721901wmq.39.2024.01.05.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:27:35 -0800 (PST)
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
Subject: [net-next PATCH v9 2/5] dt-bindings: net: phy: Document LED inactive high impedance mode
Date: Fri,  5 Jan 2024 15:27:14 +0100
Message-ID: <20240105142719.11042-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105142719.11042-1-ansuelsmth@gmail.com>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
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



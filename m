Return-Path: <linux-kernel+bounces-16100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DF8238F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC838287FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33162031C;
	Wed,  3 Jan 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5UCzeSC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B3200BD;
	Wed,  3 Jan 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d858c56cbso40289845e9.2;
        Wed, 03 Jan 2024 15:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323096; x=1704927896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=R5UCzeSCwblBfnj7+IdMe02l0BEGWlmDgQmINpMmBbLfUNKUPcYl04pCEfn0ATJa6t
         ChSx4vKZ1cf2ikhhebUkBm8uoUz0dF4hZS1qLCQSkkay04WTlRbAH7m6dtYrG4BPztw9
         +/JxMsVAr8VWpksmz/ns4ka/lrt7SRmGYAmHAWzWr4eRk/ReLukOfj1R/K7xdlfboHUI
         m39+t8VSSPOSeICUUonoSTx49poynvblAVd/uGGdih2fxJTPsaMj5KguhqH8naCpp/ye
         CU43nSvEGOQAoH0uLVU82Qp/FrmGMGZ5IFoXv4zzDJSMDgAPnkY+1xnbanqIMKCQiXdJ
         JWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323096; x=1704927896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=FzRyNcRiNklRj66rTEyx10S0ryCchuTstJoxWQv7axno2ah35Pkd5TIiQd/zaUy/lY
         PR+/ASwkJX/9C8L3O7p7MIqPl5Q/bvSrpy2JgsucGSNujMC/bZpn+EgK4iCcU0xOVDNO
         /0QgM8oUbYQzIMLeRXBDRdz24wI5NPeMhgjF6hO3+ahi4Jy/WiXxLYR7Bp+mFz5mfwz4
         100/+0uyEw3j9qrMJ93vq2OvkKWpAGy/Uap2mpdF7hpJcN59w0AvHQfgA+yMdihJXBTG
         B48/v5g+MLldVWAeTWLwoJLtkUY4cogexmay2iCYXl55mjG/XG1cYH36HmXFeRKK+650
         Sh4A==
X-Gm-Message-State: AOJu0YxcQRSUw0PF+wnFDZ96ssyYi88ViF2cxaT3wDuUk7qvVCk8PFVb
	GBkK9VRoo+WJTu4e/J9NiJY=
X-Google-Smtp-Source: AGHT+IEAVNEAcleOlB2W5/bAdYXwKfnSvU9P7XbrS0xxugMIP+FNehY8AITsXS7fXv3uDf4OWrww7A==
X-Received: by 2002:a05:600c:12c8:b0:40c:3dd7:98dc with SMTP id v8-20020a05600c12c800b0040c3dd798dcmr11664398wmd.75.1704323095960;
        Wed, 03 Jan 2024 15:04:55 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id w13-20020a05600c474d00b0040c46719966sm3740969wmo.25.2024.01.03.15.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:04:55 -0800 (PST)
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
Subject: [net-next PATCH v7 2/5] dt-bindings: net: phy: Document LED inactive high impedance mode
Date: Wed,  3 Jan 2024 15:12:35 +0100
Message-ID: <20240103141251.23446-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103141251.23446-1-ansuelsmth@gmail.com>
References: <20240103141251.23446-1-ansuelsmth@gmail.com>
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



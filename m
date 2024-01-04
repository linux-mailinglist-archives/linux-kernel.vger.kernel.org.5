Return-Path: <linux-kernel+bounces-16552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABBE82401B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A68B239AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26B2137D;
	Thu,  4 Jan 2024 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLbmi8iV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB432111E;
	Thu,  4 Jan 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so3725455e9.0;
        Thu, 04 Jan 2024 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704366089; x=1704970889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=GLbmi8iVVfw/li7xkJJBSONlhyc9aS0ul6VOpT/+4QgUEPl6m6leU4H+0a7PRmv0rv
         2ix3P6SLumG1HByWePoywnvbC/f20VWInuvpuEUPzH1uq5O+hMDL6Ud8lLnwBUuQl9za
         gjzyh2xNN31JhU+akX2E93R2aQKKNlwSFPRefezvCdLsKF8+pnYxeqgPOHZkvF2EVIeo
         ZvT1kNxZEkr+N2ahJ9DJWEuSXd6KF/R+Z717ZAeHAm/vSNp6c0TvKkr+5YDV/Z893chp
         dC4XUZcD+7eGu08inlt2s3ARytQ0ME3LxUipSt46m70wCj1jt4nzewiKFL8N+J5EQiXp
         dlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366089; x=1704970889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcUZ4vm1rSPsRUwCzo7AkcTm5VLBxV3HcN4vc65kHms=;
        b=BSFWrhdWv4nk9sJipqiF21MGxjLqCMdaE5/hhHV0VKR+sYeA6QUieHpS6G+NEBBCSq
         mOXSLaM7Z5L0Nv1rbzFKwXWokyRzbZu45bhX3hANP2dkWK3Mw78LHW50thszoz59uyTP
         tnMRcM5fVyszxTLDxF32bTIP58Kz/JYluYRiV8HmTlsmIVdR66W+TyHDhkqQfwQuqv4A
         fzw7zm75FeZIQZmYObXuauWjAONFRglaPXln7oxicDDaEc8M55+dwo0D/VylHDGXhjIb
         pzbDvCesSFO+MXVmJrZ72HzhPb8XaqvpOq5A/I7VX+jWKTj8Ym/D4BSLghlcFVatnqqv
         ZnYA==
X-Gm-Message-State: AOJu0YxCKoSs1JnWb5y2b66Gv0di0mbGTP3F8qFR68kPGUtXQdu/PfqG
	ZMljs7XE+qNJD0myQT9E9uw=
X-Google-Smtp-Source: AGHT+IFQAgwEgUrx4kY0PoYMtT7xEKwCbcr8FnfP625KPtcqR4xZ3Kl3APGhMSaC+DedNeVDazA0yg==
X-Received: by 2002:a05:600c:78a:b0:40d:87ea:f7fb with SMTP id z10-20020a05600c078a00b0040d87eaf7fbmr173585wmo.93.1704366089164;
        Thu, 04 Jan 2024 03:01:29 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id b14-20020adff90e000000b003373fe3d345sm9550242wrr.65.2024.01.04.03.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:01:28 -0800 (PST)
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
Subject: [net-next PATCH v8 2/5] dt-bindings: net: phy: Document LED inactive high impedance mode
Date: Thu,  4 Jan 2024 12:01:09 +0100
Message-ID: <20240104110114.2020-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104110114.2020-1-ansuelsmth@gmail.com>
References: <20240104110114.2020-1-ansuelsmth@gmail.com>
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



Return-Path: <linux-kernel+bounces-39252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A683CD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E55B24830
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C213A26B;
	Thu, 25 Jan 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKNgm6fS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D11386C4;
	Thu, 25 Jan 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215045; cv=none; b=qqmmIRkIPdUOavm/VyBZDSc4FVMYJYQyCWvc3xHMYH4NMtNcHkr+ev/3+X5g3vscuFe4bL8R+2DUkwklpPNozxxj2kESjnIqHCmYlaFfR85DvFpPJ5HtxgrfFUUYHygBTcjB6l0Q+a3LBG5VBORBSG2W2/JnVgUigd9wvzkhg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215045; c=relaxed/simple;
	bh=iUsyVrZ4GJ5Klbm0Khe7vDzT24Z5RgHckASsUAvK0vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ysz1oxl+EzanIU6EiKTtbk/L4yaXBcdy0r4qtvudyKsABfSfiva8wJKJctWzn6y2Qg1Ka9XzSMcCIIWGcVvIRAZSE6NPbnViCY5QgDPKtgWSyKu4z3xN9XttXyUXcX7IfvP6kk6BE7OCMLgefjf0odr+ruSNETrPZeO+0aU7Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKNgm6fS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ececef212so12614875e9.1;
        Thu, 25 Jan 2024 12:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215042; x=1706819842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdqsoEdNiWCYgQOHXWofWt/j3+GwbBKp3oAusyj+aKk=;
        b=AKNgm6fS0o39AfNP2ZHEvr7N6XjlZia4gOVL8foEDbIu1ETimzygBYJTqANqGPrQYG
         PYtPFMjvxPUmwvqveoRzsc/2K5EqUM5ZENfpU43k2qjaoIf8bwdg19yk/rGb7qv+V+7w
         8g50fYRo2XTQGigbJYbwaRX+Tavrs8bpLGONjMFnZZcF13pGIRYV+v/wsQpQw5Ys8ily
         7tM3w6rEz5loyGS1Z0aW/xA9hNGK99IOt5zkrvTqnctm1RHhtDqQsBFlWU/WL6AMm1D4
         MLfBDNoen7F/V5NzNiDLrmtROsDL4BE7lBRcepMeYwN8oEp37sZ1BFaWrp7At6ZVspaP
         2Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215042; x=1706819842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdqsoEdNiWCYgQOHXWofWt/j3+GwbBKp3oAusyj+aKk=;
        b=W/rZomPnlUClF6eCxb9/Ti5wXBXcs3K1UBiDcYScL6q4cy/WQVzmndm5m9Q+1AdnoU
         AnQG5EogOli9ZynspNEcGdCZer+737o+s3hPptc/cwx5lHp7eklTj2Gj95TCILDYm3WJ
         b32hO/8DqbKyWmRm4nztngRu0AtAUBv3LEfAMTGhIwX3pmpbUJ4ODRfN1FxTlMdozgEM
         rFLBq3mjzMjLQ4jZjd63/B0nHVQf65wJzbzmGO6IBJABt5qEcyyXrpcbU0aOcLqpFDWG
         fkVW2a7Xe0wi7z34XndDA/QXg7JXRoOeP/3ijItFQ5JHKNwz9b6BjlA0VsZfWSf6ORgM
         xXnA==
X-Gm-Message-State: AOJu0YwtyHmntcjXDeWh68MawN4m6rBUWogiu0TVWa98IDKdv+sJAD7t
	K2Vr7+zCNZAGxoeygXheJJKrEr1bo2Ip/zeBZ/vFilp/t9SKVKEt
X-Google-Smtp-Source: AGHT+IHhFgLNNSTjFD514m1PHP93teE8cgPHHoYOOmXZIYY8+ymSxt9skwZFAjunslVwGF3tLzVadA==
X-Received: by 2002:a05:600c:540c:b0:40e:ce97:444c with SMTP id he12-20020a05600c540c00b0040ece97444cmr183159wmb.58.1706215041381;
        Thu, 25 Jan 2024 12:37:21 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j32-20020a05600c1c2000b0040e813f1f31sm3817700wms.25.2024.01.25.12.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:37:21 -0800 (PST)
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
Cc: Rob Herring <robh@kernel.org>
Subject: [net-next PATCH v10 2/5] dt-bindings: net: phy: Document LED inactive high impedance mode
Date: Thu, 25 Jan 2024 21:36:58 +0100
Message-ID: <20240125203702.4552-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125203702.4552-1-ansuelsmth@gmail.com>
References: <20240125203702.4552-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v10:
- Add Review and Ack tags
Changes v5:
- Add this patch

 Documentation/devicetree/bindings/leds/common.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 5633e0aa6bdf..8a3c2398b10c 100644
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



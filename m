Return-Path: <linux-kernel+bounces-70526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB958598DB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6339F1F21583
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F1745E2;
	Sun, 18 Feb 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+4sgNXF"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B371B52;
	Sun, 18 Feb 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282852; cv=none; b=E3BAQUH4lF0lCNhNOPxTEP3fdBpM95WUueHVzJaDotyjyVTp2iL7PE6XSlal0ykVMNvuBpLxKclp7WB0A8eT1ve1Ox8vzwqMbsMxj6o7e/Zte8h3WoTB3kiiVVtDkS7om8vQtXEidHuzD7I8KcRSJlLuBEgznjMfZOgSHGTJsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282852; c=relaxed/simple;
	bh=Pdd44FrDd8LXtjrVj7SjYcAmMigl0EYIfRo3HodS0aI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9ohhOQPVv18EDQ60FaSAN8a5Hhbo9NhCte5tK3XR6gfQS1eJAP9WkYxXXywSqS9moQqM1RFZQmrGJACo1z/j9arvODe9JEXHcuy57GxbhjJQzudlc7FLCdm5VLh30ow9NpXAvFyvcWSqPb6da8zRRdkMAFr8vWpKPLzgjKMgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+4sgNXF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d3b43c492so415147f8f.3;
        Sun, 18 Feb 2024 11:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708282848; x=1708887648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xb5ObgV1b0NTnABEN6/+CA1UUGUDFrITZUbF1bp3zy8=;
        b=O+4sgNXF9pAPla7XmtNsfrqLrIxM32qAwE+LtGEGJxdHPFiEg/1EKpmPgVFm7KqtRK
         7RCI+HZZKfBo283RYhPVBHf8r1j4kp0wkedg3Axl9PrF+pRuQmXBmV7ycUJ4sgg4Crli
         6LH1UgcPYtVdUYAcOty6yIZToknLfk9vdX1XJFQcvVA7htDG7w4k7S/xrHKG7a4PJGHQ
         r4Uta0TmfPUQflSGvQT+qoSngDMWKqcpaoJZTNS4oA2WFyQ08R4i9KNbGBFltRyNwHea
         3skDXQxu73QN2T9VCtBOj4jw/+EVc1XyWdKjN+Y80jUAoHBFu9p8y5cEU17XpUhRATLK
         iiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282848; x=1708887648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb5ObgV1b0NTnABEN6/+CA1UUGUDFrITZUbF1bp3zy8=;
        b=uFBsqZXKirqVdEWWSxI+nkbQ87SKBw7xmH0Cad4sODsNCr0G7DHcghsyvdOGj3u2PB
         Sf0hd7uTpR0kTXHZvoY9PlJ3EeDr/aOuWlilBfwrLYBLCdGefo8yB1zM6y++Yjx6CDXw
         F3w21KY9sJOPJpqqEhpvtx71xKyByOgRWy7mgHWkvV+JBn3Z8FfWQZsTp/IMh++ioJNz
         xLu2Vk3ylVLbv2AHkZWfDYeaPNnYaOp9LVoJtnhkjMaPQWf+OweSC3A9UY+Q+RcWFUgp
         4cGxiIsGazkJnbVM+pAx3jLt/VK/vcqphWFxmFuRipgcTQ34ofd4ubJkS2Y91N5XB82p
         orxA==
X-Forwarded-Encrypted: i=1; AJvYcCW/q8ai/S0HGLV5zax89eScV787vWNe+/fLd5Xa+y7brAASHtjAYpMui7VdemlndbXfWYPRSiDjg481doYirJqZnASSCFKwrcr1NBalvFSVH7lLWosDgypKRYg1gj8Tgt7IDLH8
X-Gm-Message-State: AOJu0Yy7ppOVwa866G+EGiX00+FGGatSiLpqv9kHnB/Z6jSbpxo97uZI
	sH+TBQP1hfqZU3PRAwvYv/1/YvB3MT1ux7WDItkvFRYF1Fha/4yl
X-Google-Smtp-Source: AGHT+IGeLTCRBQbTQBliC8oMMSJfO+qZyMbqLc485X63GPaf7JnQ0jL39y0I2o29fHXxDw/BjYXZLw==
X-Received: by 2002:a5d:4704:0:b0:33d:1d2f:1fdc with SMTP id y4-20020a5d4704000000b0033d1d2f1fdcmr4021243wrq.38.1708282848175;
        Sun, 18 Feb 2024 11:00:48 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm8115762wrx.79.2024.02.18.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:00:47 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 4/6] net: phy: support named mdio_device_id PHY IDs
Date: Sun, 18 Feb 2024 20:00:30 +0100
Message-ID: <20240218190034.15447-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218190034.15447-1-ansuelsmth@gmail.com>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PHY IDs defined in PHY driver .ids can have a more specific name
defined. If this is the case, overwrite the PHY istance dev name with
the more specific one from the matching dev_id.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 60a60f182729..9e359e304f91 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3471,9 +3471,15 @@ static int phy_probe(struct device *dev)
 	 */
 	if (phy_driver_match(phydrv, phydev, &dev_id) && dev_id) {
 		memcpy(phy_dev_id, dev_id, sizeof(*dev_id));
+		/* If defined, overwrite the PHY driver dev name with a
+		 * more specific one from the matching dev_id.
+		 */
+		if (dev_id->name)
+			drv->name = dev_id->name;
 	} else {
 		phy_dev_id->phy_id = phydrv->phy_id;
 		phy_dev_id->phy_id_mask = phydrv->phy_id_mask;
+		phy_dev_id->name = phydrv->name;
 	}
 
 	/* Fill PHY ID with dev_id if empty and PHY is C45 */
-- 
2.43.0



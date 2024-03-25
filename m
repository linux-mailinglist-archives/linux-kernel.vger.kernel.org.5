Return-Path: <linux-kernel+bounces-117963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47188B1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0161C60AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2926DCF5;
	Mon, 25 Mar 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3z0KRCq"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6A5B669;
	Mon, 25 Mar 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399488; cv=none; b=uw39/Jj33xx0Mt5s/jPGxDl6XpOgJsvX0vAvikEEIRMfKfQBRN4NmxwMlCx69hOyVOG4GGql6A7uIPCm8OoY5ViZdqxdMSQ9aj1cayvijdWJVfDT1dPhs+GM2FefFE94nFG2DR2Y4nqug/8Xa+LxRzm0alrelFPtENX/BYXjYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399488; c=relaxed/simple;
	bh=V1fxWWUvpUniIImiS9q5KVpT11WA5yQQPruCDPMUSws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dha0aAb2KISMsFXuBNfi4VpWHRJya7KTEEL9WVetOYwvrQ7T+XpqAGp5gVbzSpBe8pi7NOQyUZE6TpKwq3HJyt/4cDkBrFxhrk63+f1+PCls5jSUdx4/CkrbK0ByKnNQBmgG30FNGIQB3JI639b7A9RoJAsSUNANlGAet2dKXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3z0KRCq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e10a4083so5380057e87.1;
        Mon, 25 Mar 2024 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399484; x=1712004284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upMc+uew/Oz20hh4qPvr2Qm02HG3vgIg6J6Sq4FrSK4=;
        b=N3z0KRCqqUgPkwWsdzQ0F0ljSs48VgqoPkcTX+yC3ZzWHJbkBsDY4BesAosAGjpkzQ
         P8hHFX6902mP8V58dry+yuMJWLi6xoD9MzJK9mFT/eUyvLNHohyLn17iLqFw/6XGp+Up
         M8BhYOb/+3loJqoMlkTGXrL0qbV9b+dMAo+IBzUiixUzwnjHN77AmResyqXdHV8c9RgY
         eMG6HByOHjA8XNJE5eGCXwYpqDzwzNk8v3WMjiEIZRcGVhjFUOBWLvXeqBUrnVP2NuMc
         bhGot+iF4lEhvRLe8BX2eaUw6vOCLpqugrGr8AykRqiNe6gDhKNm3FxbiO0PghrIYP6o
         lqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399484; x=1712004284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upMc+uew/Oz20hh4qPvr2Qm02HG3vgIg6J6Sq4FrSK4=;
        b=wKxFU6Zl35oLPHAK5hfAXqnIt6bOJtgYU+27KXv1s7xVETk8EMCDF6Bdoe1d8SAjUA
         4N/PM86qVLTOSG/Weogqer5kRBxMTlCFHJVojSwVwmP4RDAWwGLfH77tR/WXBulhk/zQ
         u0h36Q6eGpGP70uoGlU4Fo9kxHUiyzLLcUi0CDk/mi4TEKaxtVpREkunSiEwWHOTHx5X
         Znh5bEPWMkgvJhgVVl8mByFP7FYZAhqXMZg82alado8ZSCO9huSjHNgCdHA7nrFQT+e8
         FZyLXXGOWOI+53DbsT/s35aal4Uru9X0VFT/ynv4gAnZhoLtailnziUukzvzPYm2uuD7
         +4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV8b4HL77rZBHxfNmF6tVYjLXADBhBjRN5sQnT+xz+Mse3Ao/w4NeCJDlEtcrseBbPceYClP+UCClFwqebfvdwbP8TPyT3MrmIfe4WO
X-Gm-Message-State: AOJu0YyrxhVVLbHFP/6p7jRK2rjncNfRXjJNCZhRJksfXAj4w5RKX+WR
	/9IwFoAX09utAdZXjThmzyuKJ+n6KLNZ9ViBipwt6MNKYt4xLrHvPbEzv2rwo/0=
X-Google-Smtp-Source: AGHT+IERwi+xu4sSKlMiTteICjWVfDnpA1BVajpzCdkiAiB6C+cBH4pfnY4wxHtaOzFnd4bVmw9S5g==
X-Received: by 2002:a19:5f08:0:b0:513:bea3:7f60 with SMTP id t8-20020a195f08000000b00513bea37f60mr4938304lfb.44.1711399483925;
        Mon, 25 Mar 2024 13:44:43 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:43 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 03/16] net: dsa: vsc73xx: use macros for rgmii recognition
Date: Mon, 25 Mar 2024 21:43:28 +0100
Message-Id: <20240325204344.2298241-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's preparation for future use. At this moment, the RGMII port is used
only for a connection to the MAC interface, but in the future, someone
could connect a PHY to it. Using the "phy_interface_mode_is_rgmii" macro
allows for the proper recognition of all RGMII modes.

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v7:
  - added 'Reviewed-by' and fix 'Suggested-by' in commit message
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index cb2e7e256279..8ed8fc997d6d 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -807,7 +807,7 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	else
 		val = VSC73XX_MAC_CFG_TX_IPG_100_10M;
 
-	if (interface == PHY_INTERFACE_MODE_RGMII)
+	if (phy_interface_mode_is_rgmii(interface))
 		val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
 	else
 		val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;
-- 
2.34.1



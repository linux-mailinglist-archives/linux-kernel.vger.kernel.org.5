Return-Path: <linux-kernel+bounces-129572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4AC896CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700981C26271
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928D143869;
	Wed,  3 Apr 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdW0a3WY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED21420C4;
	Wed,  3 Apr 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140681; cv=none; b=kAngya11DEb40HNu8BOa7cNmQQLedfv97F9EUnZbrxa8xzI3zOd2+Q+UCT4trKBcUicFdivo+Y5Di/gOSRV8WhoTlbbsETAq16SgkHe+VbLRLVdBcdXsUzaznGygHt1R+iN+kykQEOnndB9/hPrzdIPOiKSa0XxRQxOB5O6Cs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140681; c=relaxed/simple;
	bh=t3bwAabuZAkVWJLP6p2Sai+axAPa856q+m+ZpJxFDFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i20iHMhb7HHy8LQ3VQJOmhAn3D3O13F7IeiYnOVOIkavSLRrUuBuRgCnrS6sddrYYdBbi0LfOhzYZ3JsarSaLbKt18XYrHUnO7yFv6mInFQ6zdOdXcbDVnbuB2wIotpGkHGWuSYVErUfrMv8rRp9JUBevo7wm/sN117J0pKrEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdW0a3WY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51381021af1so8637066e87.0;
        Wed, 03 Apr 2024 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140677; x=1712745477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqdRvG7HCmMVrAK+ZpkIEKtbg+m59HnhG1C3SXg/kTY=;
        b=HdW0a3WYU5qzoUf4Ke6a62XsgAuoEgM4ioCQMfSQLkISNFv0eWt6ych2V1TrJsQKwG
         2THXRMBbBZv1eJo+ZjwPVHoIABxRaa4mAT7qX6/+zKarhcXc6et6ErfDnKYvXYaLMleb
         hh/sl46DBcJUxMgQkWT2FQuYcAcr9w7NCQtBKNk99cPJl6jwqsbbc8wQov8DwbOS8Ler
         R7JJmn1T7mO/VtkaQVlfmSP+MlhXwmRR18MfXxrsbXxrAlMTL3d9pq45iVCMix6loFr9
         FIWq2IGLR1o/pQmJu2K1Ywb+MaxnqSe1tpTeFwIjY+dsDe9ys/wYGqrDyEf48wXN26qO
         Xy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140677; x=1712745477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqdRvG7HCmMVrAK+ZpkIEKtbg+m59HnhG1C3SXg/kTY=;
        b=UPlUlFazjZG7I00A74fUQjc/HsO+j1WIyx7kGJGsYO5t7YzdnjGP+yqBwplKyMoq1/
         F/qVuG6n+N64vWl4HKxFcCeZrQeu4VBIgkd1eY7scpybRlrwR5jj51lP4qLreMyFyEdr
         r8vTKwvpzZ0TpqcHZHhKc4jYGH36JECVXRcJCxFv6E944KbOzSF1e7E5bZB0g4pfAjOT
         kaASTz/txyCmCo2peMUoV7r3hKiI3YH4hAUQtqaiFIGcCh2J+rLsYhGm904/82tBlJDE
         9ofi7gmx58PaFIZTuyh85duM9wu/WE3Y6QN5kNHDUBV2CjnKe6wl22sxGSH35SbzpSxI
         Swjw==
X-Forwarded-Encrypted: i=1; AJvYcCUjIgpckcARpi3RK1jPXfP01TNJGfVfcdJOokMu13iS54z6atjAlQlfW0A19E1L7mUvczwGp2vVvxthh9vV+52jGasQ0gYAPie7NgEm
X-Gm-Message-State: AOJu0YzAx5JIzLX+xIoKOriGp/bUcWvZJrWiGaEMVvJEcKMTKQwumoVj
	zYxdJBwgKbg5+lv6LqdpzzOic80Yim/BoXaeDrNoqeRRmM5HA9jweKaYxDpLpAo=
X-Google-Smtp-Source: AGHT+IEqvmm9A2+zbcgp9m+T421x8gaJu75WdKF0aH61bGlBotbFkmVzcoDkSQL1ag94CyAoKzWkZQ==
X-Received: by 2002:ac2:4839:0:b0:516:c1b9:316b with SMTP id 25-20020ac24839000000b00516c1b9316bmr37248lft.15.1712140677259;
        Wed, 03 Apr 2024 03:37:57 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:37:56 -0700 (PDT)
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
Subject: [PATCH net-next v8 03/16] net: dsa: vsc73xx: use macros for rgmii recognition
Date: Wed,  3 Apr 2024 12:37:19 +0200
Message-Id: <20240403103734.3033398-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
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
v8:
  - resend only
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



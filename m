Return-Path: <linux-kernel+bounces-89178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24C86EBA7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A3283589
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9FF5A4E2;
	Fri,  1 Mar 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw6mCLGv"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8575A11D;
	Fri,  1 Mar 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331462; cv=none; b=WlMBdkbPpUtXfLpE4oEyH0jgRqi6oc9ruvmrcLluGJKxAAP2fIxcBR7tF211+kftDmsmfhYjLqKq+ineeksxLunJ5ytY+86ktXqk2DnNy7L/V29VjkyDt4EJYI1E9ZPnZp3NHOAVyM9rkMlRZ0qKj4lKuYLzpyNoJsOhA1gN9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331462; c=relaxed/simple;
	bh=JwjSgNGcouDuJW2a7u8TjPRSQvah6uYvnF4LKqBzFvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6jsLgZIvhKh37dbnxXQo7C7LSNQBNFCR3WtkU59xNqkv6MiiH/VlSPrnpZHPE4+upjGmMUHseOhwg+AhepdEeaH3tO7WZQNE4XL8nkh4JePZ24v4VOAI4yMnBR71rE3Pwr5ePX5q5AI46rvfmPH5E15fo4dPcOT3y5lGxjyd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw6mCLGv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a446478b04bso267857966b.3;
        Fri, 01 Mar 2024 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331458; x=1709936258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz1OG2yxyOrvNMyrVQ5ZIeKhi3z1LeqYLOa11e4nui4=;
        b=Bw6mCLGvYO1GGZ0oIOvMW6LpN4ryvjiPr92curFHl8L2gMmLFDBTMb+ds7EisMRBLl
         GFSmGHWpxHzsCOTBa1e00qP9OVOtFq/DPOvj5J9bbaf6c4M6vTxMTMmf1+0hE1+aweTq
         uJSxUzB7Vp9cnnGVWpiuT18QXPgmvHpuQhjdzLIalnF3KWuhgJpIjijtnLcmn6WSE36R
         2gSSzdTiyl2yvVYAv7f3xMFHB28ldLB7y5dzXQqd1zlcd56zHlAyCREY61UWykJUi7Gq
         D9otQwUk0nIeNTvwrP7WRctkrCwhIfDVU0CBrlFKHCI6fvdqwfevAAglfXj3+GZZrRBC
         HvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331458; x=1709936258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vz1OG2yxyOrvNMyrVQ5ZIeKhi3z1LeqYLOa11e4nui4=;
        b=ggItA67wMXmStY4cB2hIP8sjLo12DccCfqzrewKaoXtf0kAMN1vVB2nTy4yjV5leh5
         LWI0whncKsgnGYqVudRyL0dKE95O6Nj+jFcOCP6u4BiW3i+kNGyH+nj3R1etR/u8inuI
         JgoQz1Od4Kq59y8paPYGoARGKVAlyk/My7Iws5I8te+B5izufpIiXfEexhWhI9/xgJ18
         b81F/FoER4kR4i9B3r3LaT9M+tJmrbgPlgKwRVpnDzMM6PgXtia48o5V9ZGHnmV6udGZ
         gmTGbp/vq1vSprVbvMdodTBU4hToP49PZWTWC2E0+/M0yA95Ai37m8iE9YGcqLOMtx57
         B4DA==
X-Forwarded-Encrypted: i=1; AJvYcCW1PbY45spzrLfGOhfmJ/q68Ta3aDdMe4ylzVoLdBtHZNnD1KfLFBIZWOGqRH9in4Url+RYbEjX0zG7xHmh9jzE5kxKC91nv/ZDKWy/
X-Gm-Message-State: AOJu0Yy5npWqpPKtM16BbRyA7gOLNRaJAgtMw/NlebyJbaZkD+kjJXvw
	DBu5dvu3eyAxxMvzsMNSSTHLCzAwYQ6HrS+ZeGrnh6N4le/Vc8S9b3ZhNnXiPJo=
X-Google-Smtp-Source: AGHT+IE8A/4PjNv1nVKCbZ0Br9figjNeDwmXGy19uYI2037lbnQDZ5k65ESm0OdTNBAUc+odOnK4Pw==
X-Received: by 2002:a17:906:240a:b0:a44:2b1a:e257 with SMTP id z10-20020a170906240a00b00a442b1ae257mr2113326eja.55.1709331458353;
        Fri, 01 Mar 2024 14:17:38 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:17:38 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 03/16] net: dsa: vsc73xx: use macros for rgmii recognition
Date: Fri,  1 Mar 2024 23:16:25 +0100
Message-Id: <20240301221641.159542-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
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

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
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



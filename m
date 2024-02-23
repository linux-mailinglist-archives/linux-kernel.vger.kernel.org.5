Return-Path: <linux-kernel+bounces-79162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E633B861E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F201C241CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA614AD04;
	Fri, 23 Feb 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfKZKgPN"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFE149396;
	Fri, 23 Feb 2024 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722119; cv=none; b=K49Z3bt9RhlsoHXTMrka4dDGufLseT3wLxwUL02m/ELYsXBYdKHwe1nlV9SBgDF5P9fkKf2iUWCmbi8EWJ5YGzuD5JL5rYEHsZjj0LdgM11xF6MY1OcmheanIE+++sAoSasXUUkOaUPEAjg4B+H3XVX/M1Ac2CUQP/z+Xw3YGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722119; c=relaxed/simple;
	bh=YzSS2jEc2yrsg0NpWculskSZdP/jfRB/wDseRYqsnQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzASsB/+gTtupduUxA99jpfZ8tL7r20lJwmLbNgu9okV9pU24w2kA2fXnLuF7yyvr/zbRfK8YRM3igKXWY6pm4Op/Agvigufzl39HaGKrKIC2dDkje0O92CBwZrRcKUk6TfDl62nu6NVfpzliDOgK/ztEhF3hzcg8ZKmkUXc+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfKZKgPN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso1563064e87.1;
        Fri, 23 Feb 2024 13:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722116; x=1709326916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kegIZxvQ3V5ErtuAqBTi6g+zqDh2Ar8Wl8I510MU1cI=;
        b=KfKZKgPNVQpc5bk9gznxBwZ8RuF9ki4tAzdxZW5js68e+FQ9dqr87CyrEjovVW3XbV
         mkjQcVZaXQhDpfXgRQ+a0vsXY2zAum1Ozgl5pRhrMu7cHYkmU+i/bKnVbnvbJatY8rfp
         pEq2i9npa4p37gz43fgm5Fbt/P+dQ0KlR4TaAv0r7tNuLMShv7ofRRz7ktzmFPhSXGXV
         0HRTcB5x5boFkWN2nS9FYfxumU+f2ORGJjmEbHtibIIvZRByeh7RXwtfS4H33/EX1Yj4
         VNcXYoNgDfMurN+w0jmePHS2omrM+m3UTPwGniPwlbsnRRh36wekkyxSR+KJekJW4HeR
         DAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722116; x=1709326916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kegIZxvQ3V5ErtuAqBTi6g+zqDh2Ar8Wl8I510MU1cI=;
        b=nHXXWZc7z2TuHaeRQ5hI/eyguZIALPDPVujGIha5sWDkJr9hEncAnTGX0yXNT+EOb9
         NSP4TuiS57kIYJPwYDAOB+OJW35XFQtTHQM5GPlny9GeEm1r0X11XVdFBTu3G82V1JEj
         VzVjcVsZjZ6RGfV7nWiqDCD2k3ErKuC9PhWWxaz1ek3IFED8Iy8LxT+JJ9rp5awcoN1q
         A7JgXmqPDpJVnLGNFfUPJ2kc0kjGbcYoQj7HPMJXn0puJnR5j2f3h+0LocdM65sXz/jv
         44BTV5YRqZYjNZY+nkvDdNKwVrHTSajB7w0mqxtL8QuGO/dqH488N6MZ8onbxogMaR9G
         8vag==
X-Forwarded-Encrypted: i=1; AJvYcCXub1jtOL5w9oeJ0sHO8JGWQVRernOuDTg+VEIVlXBFe3qZyYg2EKBt2uRcgHwgAjrEVSJKdzQ5iY7l+fvqoawYDZJZ/yKQgjhMJQ74
X-Gm-Message-State: AOJu0Yxj2qSSxvEqMsm4WbckrHaUprIUWxfS4sbHb+72Wzy2NyAMv/nH
	l42iOCkVp5exa3B6H6PK6cTgA13W+yjF3gAc5Z67JUJsvuh2ylNw+yhio9WKpbw=
X-Google-Smtp-Source: AGHT+IGgyEg0sSyltk8/UVl/EpN6TNnB0v97hxaR/op/E1C/vNMfbMqSHl94BzUKMKWTJmd/taf2NQ==
X-Received: by 2002:a05:6512:242:b0:512:b935:c542 with SMTP id b2-20020a056512024200b00512b935c542mr634057lfo.59.1708722115443;
        Fri, 23 Feb 2024 13:01:55 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:01:55 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
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
Subject: [PATCH net-next v5 03/16] net: dsa: vsc73xx: use macros for rgmii recognition
Date: Fri, 23 Feb 2024 22:00:33 +0100
Message-Id: <20240223210049.3197486-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
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



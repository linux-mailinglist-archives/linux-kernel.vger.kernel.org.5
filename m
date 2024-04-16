Return-Path: <linux-kernel+bounces-147439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C158A7426
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F111C21322
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32413775A;
	Tue, 16 Apr 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1cy2K07"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBC137C4F;
	Tue, 16 Apr 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294114; cv=none; b=szFCGaRfOxjAfKozZEtIgCza75C9DrjOolA6VYqcBR0V6r+XnfFZUdE4HdJGD7TkF5/9t53UM2uHqZTmcxPnqhgG43Qv0x7I3ChD5b2ZpAUacKYXHURj6aOFszfp9Ex3OwVJQrx61bNrn8WqFCk9DluloJ8vsRacBhT0mSmFpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294114; c=relaxed/simple;
	bh=eP76AH0to6uy37hdR0BpiHwMNRT3oXZ7/bfC04nZexc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIkUsRIm4RTgEv3VpE+p5Eby2o2Y6HH55LIwnS5iz+xuBBeCQK5pg8Sm6yczTixTe6KUNOEi4j5nQNOoGYVdjafkamRal7NsH+jsBH+C4ydCZ83u5VCmUZaw81Z2MoLgXXFLqZ0TsRxrGpNdaKDn9vezDLFvIhtzgB4V27OpzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1cy2K07; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44ad785a44so579924266b.3;
        Tue, 16 Apr 2024 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294111; x=1713898911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY+yGYsg6qN0h3E2Q9QI5zY4qFMN3uFTB/yfBOf/FWE=;
        b=g1cy2K077BpmWCSjLoc9h2W98TzgyZWoKJluQBdAL5xXQt1BDF/cr1KtyqDoLgyYqe
         25XHgKXo52Ov2LGehZj1DhkXTwRyULYso1cyvgHfXgzeXCsEYSSAkEunkOGJpNTm4Ror
         TwfePA+d8j58nfVNeIWBahLcmXoRwkSVMT/HyrR1MT7KYvU1opO85QESycPR7akU3vcO
         hsEGxyl3bQKXAAWIbGMzmFObm6U83u4ayYjkdM3U3rwaJFjg+SBl9lTpFgd7YEVPATfW
         jkyuJgvYo5psxc0r1rljnMskVxyzrEsIdF9VoYdwtgJrKviw+x4HD4vfkB0Ar0vB7OVy
         EhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294111; x=1713898911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uY+yGYsg6qN0h3E2Q9QI5zY4qFMN3uFTB/yfBOf/FWE=;
        b=EX3faaYSuL9baUwJ0pH9vONxjH+Bu9ihaBxmWR+DYGCseBsopPizk5h7gJvNLTA3n6
         PKCFXGDkKfUKHzXxZuSNU1Lg0xKnnPCTqFf20MWY1HAt/JpOSUBXyFrpj2KmCxapfaVA
         brfnEw4Y/rQxchAPAgAoMCR0lVE7fItMhWP8h9JqdClVgFNLjm/RdwPCFbQ6LLUYgHHW
         fuxSq9EABv8EwmzToQKNlO8tCSPLaMecZ0jhoRMn2YamsT5S/qgA9AJwdZZAQ90OaPzz
         lRD5wtU2V2SDbIJOWiDq75FutGyt6dUH5hHbFjz7TjocRS1h1zQ7SvJlkI4385mWJTZ7
         dtjA==
X-Forwarded-Encrypted: i=1; AJvYcCXj+LCsMhXdzmQMrcafwTSGkCJQ14V7mWKUouJP5SddTbrOyfQoEYSee3KIFd9WpUe02jJste6BZTEjL3yH4EaOPOK40l7euTWlPNI8
X-Gm-Message-State: AOJu0YxS8pAp+Y68NIHCZgaBlRU4onWQWCIKhPuU8BvUFYYxAVFT4x5a
	1Gm4i1k6emwVTBfQUQ3bAQu9kM21OCN2zuZE38Gz2vyVXJGrNW2g6MQdPgR5
X-Google-Smtp-Source: AGHT+IFEBH5z1ulSd1Fd+3attlK6nznzQ44bS3x84UkPsP4taaapzy6wG1fZEhW1di9CsUGisjbx0w==
X-Received: by 2002:a17:906:7145:b0:a52:8a8a:593a with SMTP id z5-20020a170906714500b00a528a8a593amr3393313ejj.2.1713294111183;
        Tue, 16 Apr 2024 12:01:51 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a524531a580sm5247981ejb.152.2024.04.16.12.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:01:50 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: dsa: vsc73xx: use macros for rgmii recognition
Date: Tue, 16 Apr 2024 21:00:53 +0200
Message-Id: <20240416190055.3277007-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416190055.3277007-1-paweldembicki@gmail.com>
References: <20240416190055.3277007-1-paweldembicki@gmail.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
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



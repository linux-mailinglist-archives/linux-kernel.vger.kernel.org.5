Return-Path: <linux-kernel+bounces-149220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64338A8D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4510F1F21A68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96E5F87B;
	Wed, 17 Apr 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3QHkhIN"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960114E1DC;
	Wed, 17 Apr 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387106; cv=none; b=Tpwsi2l0TW7KLzMMwOYeNPXqn5CjUy9+Q+gzMfoocDGPTWCkM81A1MBPK0xw8rH03HfResR/pVnY7HKTQHjWnWpDGYD+Rv7aDUPeACbbtXVsbYl2uw8CYXGDyFc34FjAQdzkwGplnzLu8Uok6MPLFzUOedmCfnohj7RKr8uuM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387106; c=relaxed/simple;
	bh=RtGkM6er8E+7VK+W97dxVdmk1hp8D8nlFJpFFKqNuEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akyxchrglbyBScwKQcRg/N/iy65HpPc0LcNy4gEjq759wkWSTGLu6lm6VTQlU01xXM/7KBzpisiPg/imDWfunJX3foi90AE3DqMgPvEsJVSw3evJ8/5O6v40G+eLa23YJvSqXFNrc2Dth1wWtmC4pe8CD/Mr/u7Wja+RYoB6kMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3QHkhIN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5700a9caee0so122267a12.2;
        Wed, 17 Apr 2024 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387102; x=1713991902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdMpU1RPD4eyTwSkVrScFCgXE5pA7FIMCk6GiLfnXZA=;
        b=H3QHkhINfesi/yIY9v+Gk3TfAtmXZaR4+K5kDOKSqu5HqRzrg2cCmu4Qeb1K+a81ql
         wawnhSugX3SQlJfkjqbNPLSrJeFqQwvC4ZOuddQd213MOsydhxkOzzQNZcGWQykVQAVH
         nJTcRTOV+AO5o6Qu0xZS2VT5Rthbw6W7O76qIN22B7BmZbGc4Jqa4ItfO24pEE49cpyC
         UFsLnBAFzvGTRVwBcgPkm1D4ZOwckuhN4KugwLVG2eq1VQtAJsdA/IXZkA+oQp6IyxM0
         qi3qxJ/ZK2NO3aXzF8OIGGCqqtAu5xnJwRo6vmkVOqEQDVYTg+/dd9BLuhHTD31/71Bj
         9LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387102; x=1713991902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdMpU1RPD4eyTwSkVrScFCgXE5pA7FIMCk6GiLfnXZA=;
        b=RiPF3WdXS3bx6WKEB4LwdCTLHqaTbFe14Pkf4AX+akQF3SpmtBZiBaG7g4w7VCHkjh
         b+WqdH2koIZqAORMeJ43fvp/olQRVuRf/zfEzEY8NfKOv3+Wfqad0GZp+MNTCt7tJykA
         zQGbSEOAuJ/HSee0NKmZneIGOQ9Y6rhdk1SyCgBE7nq894AKprQb2Ld/5+Gf6XRzitaq
         3eVojobc3r/ct2FvjENXmjPr7NwNlVSxC301LrvOFh6oyc4k2NoBJ+0ldeVsQYrvLs+I
         LMoo4K5X1ZaWoPIM+iWCRcvBKpR8co0kVRAeDDugbj+Qe2ZFHesRDz/DrgF4O35SCrNJ
         G5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKH2OuYFXCiJFJ3RqEHCNtdU2w21gTmpOHg0oad8L8oV9UQG/NLT8nVfzzrGLzVMaE0YPmk9qXeHAvrWKkYPHWgQtIB+zM2Od3qIfG
X-Gm-Message-State: AOJu0YyOmrwF5E56OkpqlB1lO249adlETZBYfLxhmGc1cHttoU82khaY
	QAIV79UsU2/kf0Ir1ax5g7QBi8/3dwf2UyrgI4lsxN3PBOo+fc1LWERw6Lfw
X-Google-Smtp-Source: AGHT+IGl6pMEzcVlyPQmZPD7vYjnsd7IUwGvNKz4Z4G6xV/AIeCjA777Gb6wI2RyZdS2UPDzepjGVQ==
X-Received: by 2002:a17:907:3f9f:b0:a52:42ce:7da6 with SMTP id hr31-20020a1709073f9f00b00a5242ce7da6mr429744ejc.10.1713387102601;
        Wed, 17 Apr 2024 13:51:42 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a554177a2cdsm31752ejc.85.2024.04.17.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:51:42 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] net: dsa: vsc73xx: use macros for rgmii recognition
Date: Wed, 17 Apr 2024 22:50:46 +0200
Message-Id: <20240417205048.3542839-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417205048.3542839-1-paweldembicki@gmail.com>
References: <20240417205048.3542839-1-paweldembicki@gmail.com>
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
v2:
  - resend only

 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 3f8edac9aa5c..09e80aac43e7 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -810,7 +810,7 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	else
 		val = VSC73XX_MAC_CFG_TX_IPG_100_10M;
 
-	if (interface == PHY_INTERFACE_MODE_RGMII)
+	if (phy_interface_mode_is_rgmii(interface))
 		val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
 	else
 		val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;
-- 
2.34.1



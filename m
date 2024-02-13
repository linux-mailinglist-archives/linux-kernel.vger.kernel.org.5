Return-Path: <linux-kernel+bounces-64424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007B853E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E725D1F21069
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EADA66B4C;
	Tue, 13 Feb 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j23q4WKU"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204B65BD4;
	Tue, 13 Feb 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861918; cv=none; b=bJ3tIVF+fdSPVPVGnlrm4RNdMNAnGCJkx/N+dFsijnFHYoOn/eimto7vo+sNyyiBxhJu34Ni4m+/uzvBwf5n8B2wf3E+1Betr3RhRN4pra29GsPzLtQGHZXi06jEtx329NDO0+gM6ev9/9ZeQB5AqY7NzYENZvnKNAOyjKKyQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861918; c=relaxed/simple;
	bh=FviLzxC93cNJ3wmxI/f91VZvhamslfx9I/NMWZYtlMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COa5Ss6g9CMuDqTkAM3wNZaAWKguJ1zPORnvN/QtA83CBR57LKzq2RWZbDobmvuVnmfRejhk30Sa3qob2ZcYgjgbg5IN+2gxEkvPzJ3/StWf9rNWLZVmhlN98Upgo1Z12uPYrjNYXtd5ihOH337oUw+S7UYERD+vPyXt/dT9oPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j23q4WKU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26f73732c5so684193266b.3;
        Tue, 13 Feb 2024 14:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861915; x=1708466715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uozxI0Ib0yVJTDnCXOq5igCfB80aUVjda0znERTIFFE=;
        b=j23q4WKUwqMmPV2QUR8RXJeQsuj3NiOBfqfsBSw+xnPo2V9WolfCyN3X7RyWhCoC5o
         hshCUHc3GFUtrAz2Wh9KMrh4QVDBhHm9HhBt8W3bB/GLotgiz8n4lY0nsUoFUhZSgo0r
         1Bgi8fy8wvHr4NQRvF6Jf2+Fx0KQHqtYt4wDbjT0riKkBut6TEM6hv6Omfs8InBmalmb
         m32c9rrwCmqnqmThu2c8M6DbuOAlrcvCSXb9B98/OuUeIPbczijSPK1CPxVNOlW0Cq9T
         9I90z/z5P5vbdYBYxpbMKnM3Ga5Em21TJZLm4y/gxFgSjDaMBiWRN17oA1W6odOQHc6u
         GPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861915; x=1708466715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uozxI0Ib0yVJTDnCXOq5igCfB80aUVjda0znERTIFFE=;
        b=g4LV/+W5VTIQWwRs7S2Z1hf2SO7BMXYmEnckuR74YygT4sQ7ATtiEqWTdTSkYU+ISq
         6nAL9lhMlgrmK+5vInqvpz2AQYfjQF9Zg9hFzU+j5c3clohv6/Edz3KPw8KU7JXJllEO
         iDsKPqqAWfEC8zamTZdbTdThy9IGuVk9ixs+x1eREQeBdMO3CqxxzOTC/z2bammJSJHD
         +RiyaIWXKFnKcKsfdWEcfNhXet6I8TtIRbLxM+d77bNWOpzjjXWT/Dsfy1FifsMXninY
         bNdej02bWBFuAs6IijW7jaaZ7/2N9qQ4tRHDtxJz6FILsoNZ0oflT+auh1WRUfSn0rPD
         4xiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1NzGl1ikVvhiLvsqu6VV5wBNAG1olWOF8OJLjMN7Ly1w/kxRBanMvqzrF2P8X11VrYpYAjuaqsxsADUQyysfdBJRZ2fG9c5zwcKB
X-Gm-Message-State: AOJu0YxFF8YQEElb82NspRH6FWeN3CbyepNrPDPp8FcPdYEG0GFn3LrT
	PAkUaC87Hm8NP18ZYC9CX6AMYJ0Fd4K+IX57En+VdnajPUJaAxQQqQWzYRTRJpg=
X-Google-Smtp-Source: AGHT+IEsLT5ZmumCphHvUsOMYimWlg1IWDWGmxreejX4jzAN24AE1UqfsPshz8iZ1nGpKnOMe43F6Q==
X-Received: by 2002:a17:906:3c53:b0:a3d:1f59:7410 with SMTP id i19-20020a1709063c5300b00a3d1f597410mr361105ejg.22.1707861914895;
        Tue, 13 Feb 2024 14:05:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcCp1Wq7upm9RDN2iKLObnLHXNsKYL/nEZ/usmgnU7yyegCtOARknmFzDEK6SbUX/A2DG/aT+hY0hSHKqCk5e/ZaDm2/r4O3andE+IoxSnxgMv0bGPH+PD2qzXbYCFXt5WqM7IA1TduCqYiNiqG58yFm01mP7ROLXVfXkX8EKaXHqtcdDejp4K5nISuZAu/18yMn1KcydiQvLJ+zPkyHRYp9wmBnT0I8P2pgUicieEimz8C6oPpIXuJIiX/7vDLjF3YSgZF7at1uI0LHX5QCotjR7TH3NY6Y+ztLYdvRCyiHXHBDpptWmz8jCzg/L9tR2IGCp7EuLBRdtF6hegwQfke2+010fYHxpeZ3UAu7leN0Rb3v2R2O3L3mOZwQS+g+aIIJ3V2+6Ta8rEHOrrrZ8GpUVR97WZ0vk4mLp/fSRKqvsw7hDkTKD9QXVmBaObDcPqjl8W0EoVZA==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:14 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 03/15] net: dsa: vsc73xx: use macros for rgmii recognition
Date: Tue, 13 Feb 2024 23:03:16 +0100
Message-Id: <20240213220331.239031-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
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
---
v4:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 70dd3f96dafb..5b54823b2caa 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -833,7 +833,7 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	else
 		val = VSC73XX_MAC_CFG_TX_IPG_100_10M;
 
-	if (interface == PHY_INTERFACE_MODE_RGMII)
+	if (phy_interface_mode_is_rgmii(interface))
 		val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
 	else
 		val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-65424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B4854CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C433E1F21DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F660884;
	Wed, 14 Feb 2024 15:29:24 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400C605BF;
	Wed, 14 Feb 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924564; cv=none; b=oCfn7DHXRkMiGRiSb0/1oOGUt9d2iZNOcujqpkDt/xyKItWzcxfVvMKda77PtKDT2YhlDBN2WxBFDnC3TnCU3U8Lc8j5vnVDkTqo9Jo755DQgiKwi9EWi3qalW+Lx3Mlt1nlSHYgNy73Fk9PER3Jog75Fhf7V5xFeOY8u0eAyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924564; c=relaxed/simple;
	bh=J1qozJbjljliIUUH7P9nffKFOzVQ9s9S1+Y5XwtdTJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzpTdjbBqG07oQwb5+uXiQxMK8NDViJhwkxQGXOWpi7/5IwHHyGIEZP6quY5nglF6e4T4DQy/agX7RyKwWZI+DCh4gu7L2cvbn5AgydTdzaCvgYQy0eoITuJo1LZU+ZqheF2S6IOAVjlmGd65n7sJeVYMYtOVyrMeRoOW5L3K4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso89753766b.0;
        Wed, 14 Feb 2024 07:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924560; x=1708529360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+ksWK+Br9KzW5rHgdi7bzfAa0HCCHf798sBvRaM120=;
        b=tZQglVGyKKaFTMIS5L990qsEa/PlhArIy+XgxmqTmm1c4G95DOCi8luqzYRHgyGsVJ
         42wMVXOLTKIg9nLE27qYM3iDPiRdPoodL3uJAsleWfjv/54H8A4Ee/LtIAd8RNvyevOK
         Qf0ejGRtpdWst7IGC78V+Hr1WezDM5gfaIq2NR/m0O/u3VUsI3TExFdpkslBEvc4o6FP
         57Kh1r/bI2pSGBqlSPeXGN+C4/jCzjqk9Xm5GLnuD8gGQgGNk+nwRG8kDacqmEr0gymi
         YkHjsS5Uxrm3uFcaDbo1Nmw9afEjHp7RN3/pAfR0j0RnexIolsAI1uvxWZeBYCAP5hO5
         +iug==
X-Forwarded-Encrypted: i=1; AJvYcCWqrTezAGvCNnRzVGVG86QUSi9e9/cMyi9btc1FiluBf8VsSnBTip6ZdV3lbySfRqrLaotuxsPNg9RIzbw4y2XNqJsR7ZYZkyv4CnGN
X-Gm-Message-State: AOJu0YyS80qFUWGrlcjwobKKZxPOKj37lKSuzWE6lZeLGgSmD0ujloKB
	Ro87J542gxrSrUPfx/vWOWHuF7O81lPPLAVtV/cJnxISOcMlx4S7
X-Google-Smtp-Source: AGHT+IHWiPJrTDbswGIX1JVkSYDYzEgO80DDv5x7aIhgmZ5oufSAqHNmIjvx6oljd+Ew9y9bjJjCzg==
X-Received: by 2002:a17:907:7243:b0:a38:567a:6574 with SMTP id ds3-20020a170907724300b00a38567a6574mr2376825ejc.5.1707924559888;
        Wed, 14 Feb 2024 07:29:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1iVUI9NqYX6G6IH8n/VElsCfBgElmf0z0+9Ieelm47NTOrgLqe9Ul3qA3d/HhFbVWDlRniht0hacfAsB5Pw1MjDb9Uvznh7Jcht2r7Zim7894cjWjgcNTf+GtXpL6GIsaPXJlDQ02OerlK5SD09SdOnatBPMWdevTLhRoePrpWEZdDi+Lpl0Wkog4+NhniCtSI7LNWUqrUrPFwNLvUjPFg1bwUvOPCvOC1uaLFoGRmYFoqAfgxU4zC3wVa4xOTkAtqXyZel2ubuefT30P/CFOEZZsUdY0Nm8=
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id gv24-20020a170906f11800b00a3bd8a34b1bsm2422806ejb.164.2024.02.14.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:29:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2 6/7] net: fill in MODULE_DESCRIPTION()s for mdio_devres
Date: Wed, 14 Feb 2024 07:27:40 -0800
Message-Id: <20240214152741.670178-7-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214152741.670178-1-leitao@debian.org>
References: <20240214152741.670178-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the PHY MDIO helpers.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/phy/mdio_devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
index 69b829e6ab35..7fd3377dbd79 100644
--- a/drivers/net/phy/mdio_devres.c
+++ b/drivers/net/phy/mdio_devres.c
@@ -131,4 +131,5 @@ int __devm_of_mdiobus_register(struct device *dev, struct mii_bus *mdio,
 EXPORT_SYMBOL(__devm_of_mdiobus_register);
 #endif /* CONFIG_OF_MDIO */
 
+MODULE_DESCRIPTION("Network MDIO bus devres helpers");
 MODULE_LICENSE("GPL");
-- 
2.39.3



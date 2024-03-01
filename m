Return-Path: <linux-kernel+bounces-89180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF9686EBAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081EE1C21601
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC505B5B8;
	Fri,  1 Mar 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D47/Hl6N"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2D5B210;
	Fri,  1 Mar 2024 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331470; cv=none; b=fFRM5QIx7X8GUodhDkTjBm59GAHKglibVLUxFHXsIrXlV7miGGMCFl0Ylud6zZmiwAreDyQIsk7oKHK+fmgUeXoQ4jh0cWpTsMtNYU26icHKQHwawCwFNdpNBQ1i+kADB01Jnc3LdJavb7SVE6fBoo9NHPaOLMUo2104eQny0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331470; c=relaxed/simple;
	bh=P+qM/C9/KxfJ6Z2vsMsL0FPnDbUOdsujMsbIp0BPgEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWOeBl0MZ/Cg6aNHG0JjXskp5tb43gne3VLeUwezujTHeIXYWnGUcsDjEylghMUwn0ImbQzOhENgqFoHH+63+EQ/yVKfHtv2Rt4kElWZvZIAUZeg1mZiyNltWTAsTXEh6MLMtQNY8PKub+2wo1iuixUF2YAe3oJ0ujlM6mDaR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D47/Hl6N; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so18225166b.2;
        Fri, 01 Mar 2024 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331466; x=1709936266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWAyEufici4LW1NGI1K5M7JMhAe9f13aH7DQNZOl3HA=;
        b=D47/Hl6Nzv/DEE/eIswemDscsIoG1WDfKNYKV+3HZABHhh3RPWhMxX0RFviYLbviT6
         ijCZkGqqkFBxNRb5LrECa0MbC7/YK5xwmzk9VcsF1xLyFDeHL5GWohS/xeOtdGBC79UI
         lU9779DtNy0f2E9o/cEW3Ki+D5uI8yGdCtRIOZj4APQ1UxscvQFuHouxmR43Pt+eWBK8
         XpJqh8r6u1aoKN8f8cjCN7U2KLpro9WJOWecRqlau8/WZj8oez/+MCAeUvEkCBFsgk0s
         t9nh9dXp/XAazO9TsiwJjyW6Umm7cdID8+Y2GNL2QmJq7TWs+zKew4u+36JB4uwDKUxx
         jwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331466; x=1709936266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWAyEufici4LW1NGI1K5M7JMhAe9f13aH7DQNZOl3HA=;
        b=fdqiqVACU1m+Suug8IMSkpLdI8mcPZjiFwruVGUx209YR5THp94e0mWxY9MbLq8ocs
         5shYDX51t8bifp8Laubx6wUBNl3Lx8i9KSxqP70Be4cfSg+0SYuHMi3Mt0Z+irhoxsk6
         3yKHbyRnblubvrxITwLt7V8Df5okJPnYMxTDHwZlzb0PXcDn5ACAA1ThqmR8wAeM8aWL
         E45pZ3kVMkO8Y2bL4eG/laF8kaBMAtjFyTrTAt8OwV70ywMwNKVP3xCpRYele8Nw9XIz
         fBO20vZ9DqvKdKlapTEzcgCyMAQGotz4ujofC5owfReoea43c4A41AaSQ0t60ojYVv2S
         HXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVewxw/f5fWV7AceEMO/NtbaAjQqMcdal3+CWaTAl8pnrkzboYN7ZVziB9UFLlIiUR5leb3nrkm4RRyiGq+rIVEOx2xzsAKzukNYdFf
X-Gm-Message-State: AOJu0YwyXPcJi5wtd55L1bzIbW7lpuMVQklWmB+dP9LRMjXhIPGWyOZD
	FjSqo9Ub3WDccrymvgh4bumKnha7jNbdmGvGwNJCenNgo9fH1FKqXN/KG/Xaoww=
X-Google-Smtp-Source: AGHT+IE0+YlcKIQnv3NTzJ7aRoTV2D1TlyXn7q4xakodhAVj0toEK9njB7TECt9/jo8ZEClxQK05Ew==
X-Received: by 2002:a17:906:a197:b0:a43:af0b:c1c0 with SMTP id s23-20020a170906a19700b00a43af0bc1c0mr2418087ejy.16.1709331466332;
        Fri, 01 Mar 2024 14:17:46 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:17:46 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 05/16] net: dsa: vsc73xx: add structure descriptions
Date: Fri,  1 Mar 2024 23:16:27 +0100
Message-Id: <20240301221641.159542-6-paweldembicki@gmail.com>
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

This commit adds updates to the documentation describing the structures
used in vsc73xx. This will help prevent kdoc-related issues in the future.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v6:
  - resend only
v5:
  - improved description and stick to 80 characters per line
v4:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index fee1378508b5..e7b08599a625 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -15,7 +15,16 @@
 #define VSC73XX_MAX_NUM_PORTS	8
 
 /**
- * struct vsc73xx - VSC73xx state container
+ * struct vsc73xx - VSC73xx state container: main data structure
+ * @dev: The device pointer
+ * @reset: The descriptor for the GPIO line tied to the reset pin
+ * @ds: Pointer to the DSA core structure
+ * @gc: Main structure of the GPIO controller
+ * @chipid: Storage for the Chip ID value read from the CHIPID register of the
+ *	sswitch
+ * @addr: MAC address used in flow control frames
+ * @ops: Structure with hardware-dependent operations
+ * @priv: Pointer to the configuration interface structure
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -28,6 +37,11 @@ struct vsc73xx {
 	void				*priv;
 };
 
+/**
+ * struct vsc73xx_ops - VSC73xx methods container
+ * @read: Method for register reading over the hardware-dependent interface
+ * @write: Method for register writing over the hardware-dependent interface
+ */
 struct vsc73xx_ops {
 	int (*read)(struct vsc73xx *vsc, u8 block, u8 subblock, u8 reg,
 		    u32 *val);
-- 
2.34.1



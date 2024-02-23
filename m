Return-Path: <linux-kernel+bounces-79164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED56861E62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A1B230A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A240914CAD4;
	Fri, 23 Feb 2024 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZekfT0l"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF4146E71;
	Fri, 23 Feb 2024 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722131; cv=none; b=qg2ddBM+X2KE1GhlceHpLWk5cUfuaAURoIQzloVJvQxet52Rabwb8Q95/iC/Oz3IpqWPIuNu1w5GYXKBiSTFHyfF37ziINsvLW0psMhue3If9ZjnbRoEAZitCdU5SE2G7crUfpWd/JACxpptjpS8iMQMPELLoTL9r8khr1Vf4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722131; c=relaxed/simple;
	bh=jDveqTSmY5Obwiw3CEMCB1M279nvlZqw4xJmx+i2XN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9aC5PG2GDY8jHx40OG7Wdxdq8/FP7qR5alTz5Pja4UvUDoZp3+tD0gU811pbH5Mq0v8OGlPS+Q9YmLUAodSvzoMZHJuZmcPjMhYNVic0ezEtqwZ7cyWvibvhTEBF0XEW1bLifv2w+42CkHO81K9mL4MyUKseDzqLvWpnTc/z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZekfT0l; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3122b70439so118108466b.3;
        Fri, 23 Feb 2024 13:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722127; x=1709326927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08NWjQnKcjY+6Ilk3BwFDKrpVp02goqIQe5ciPfYtik=;
        b=kZekfT0lNa7Csz+tGqbI+ABXCIpW9ZemNHrtbC/QYfisFAvftUC9gQXpUbGPxnSY1G
         JT3qZ1NRL7x+qYAN4Wu08hAzVxIs3lQnQdo3T2bqY4SKjmskjAtrzA8ri4OmZ3e9QgJS
         1mRlSFxX3CX9K3qEubIQXK/Ihh8pSjp/7EirWQS+5Dc4xMD2kBO9FWnOfJGmi/4XZzoA
         aWd3Gk5lHroN/73+OnlxMmvL9yWG34ZKZC2FT/R3EnIPB+d2UOJkXHvlh8RgsgNYXE9B
         v8ehK1VgotTk+BeH/214goQyCj/yiMIuFQP9MzzVhXEJUXCYkvKzx0xYqyTwor8XfUGG
         Qgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722127; x=1709326927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08NWjQnKcjY+6Ilk3BwFDKrpVp02goqIQe5ciPfYtik=;
        b=OWWoCW9QlY0h9sHIw9ftJpfum4sQ41nm118NfPEEcqtuJvF2+CQI/T8DUn7lPXq05s
         GBFHA3QGoEgmZFSFFy1SgoDLvX30j4OIIstGgQa7P2KYilLViFqirdMiXBFIG4B6v8iz
         x+04MA0VfvZFe47eeWPrdOwZFc4JNUELbIm/Szd+xmyQgHngbtdFNncVb94HR26LDSs8
         lHBoblei6Qolz0FpjbNBqKvURTSSq3FgMjJ8szR7wC+Xx7Lfanf0KSDXbB2+cupv8OYL
         Tws5SEJxP0Caxf/5CwelVMe4rfxlK3yiMVfRRMIR+n6nZRWlWXeBN2Q9IgPgizUz0YR9
         yxmA==
X-Forwarded-Encrypted: i=1; AJvYcCVBBb87hPv78OfIMyTKwTqKA858nvuhkovvT3Q4XbdmocnWi0BCWV/Tu/oBRcd/Ns+3HdgY8LZtSm+czppXo01gR8eM1643ti6Zc55Y
X-Gm-Message-State: AOJu0YwE+Z1hjbS/XCAk2N/nlfevnEKlaDRQjPWQRc8APKjX4zCsogAj
	syC8fTy+8Kwkic5TDJmnJyL9r4UJ7q82Wy7woXUjTfY2aOawXysbnZ6YT4lFY8s=
X-Google-Smtp-Source: AGHT+IGxIjNBhbVfPoTgLrTPefWGVY5hhMv8ribdIlbIMAZVU43JII72udqKYtJcRSOqc+p9tlHQTw==
X-Received: by 2002:a17:906:688a:b0:a3e:4093:89df with SMTP id n10-20020a170906688a00b00a3e409389dfmr675430ejr.74.1708722127288;
        Fri, 23 Feb 2024 13:02:07 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:06 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
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
Subject: [PATCH net-next v5 05/16] net: dsa: vsc73xx: add structure descriptions
Date: Fri, 23 Feb 2024 22:00:35 +0100
Message-Id: <20240223210049.3197486-6-paweldembicki@gmail.com>
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

This commit adds updates to the documentation describing the structures
used in vsc73xx. This will help prevent kdoc-related issues in the future.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
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



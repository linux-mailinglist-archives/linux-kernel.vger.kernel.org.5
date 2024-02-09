Return-Path: <linux-kernel+bounces-59007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E184EFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98821C2154D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DB5810E;
	Fri,  9 Feb 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAvoLxEL"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5C5788F;
	Fri,  9 Feb 2024 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455077; cv=none; b=MwZ04jVwNQv134cDmVR7TA0Fxcvh4GkUX2iC3frWHh3hqtobTMHDWjZP1JltK0Ahr/MTtz3fV+gicGN5nLRTn/JkWbcjDthSt3WyFBjUnm9/azTbve9YJTKiprVRViccj6x09/rtvNUIw6UK0lVb+a+aX6M3MWs6q0ezU9N/9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455077; c=relaxed/simple;
	bh=A/i5C+haAyk33PdSAUkRgcW9VpEkLWcEh+Fkl5NMbtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWF7RaWSD43D4aLivKNibUURCIDK4bEyIYLzaX1aUOSLN+hVIXz8Rol4oySfoIgaf/QZYt1cREm1KBUe/j91KDHtUKw5Hcn/dBePKQRZTHGitlqf/t5fS5VhzaCmHtTS5VZtBGL+BTENFFJzlaiQVfhNmoaKlOlWYZixzBYe920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAvoLxEL; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bff5e9ccdeso153046b6e.3;
        Thu, 08 Feb 2024 21:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455074; x=1708059874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjZFEhta82MOtciRGbl6T2FR/OOl48rGzrVvDiOd70Q=;
        b=cAvoLxELzt2Rr1Hs9EXguYd9lpOYqZYZxyzjE21vOWyPDOs/YqIaFq11WpWwLAsjFI
         KyObQBaAmGjOKLW2SN6Dfxjw+WaMJMrgBsrCtVvi2j4Of8oF5jMRhXsKBl2P0yX+7Xd3
         IT0UIpNjZSxxF6W53bE86cSa08de2FYuQ/Aq3HBdazcvK5BT7m2E4B4CRJEtN3MYmZMF
         SG2KfLCX1n18aviZSTXOpA4k2uy3YUo/MlyvjxBnFtUvaB2sA/monWaFg2/LwvjU5JrY
         TWFS+lmAFXdUUnJgy2f1SrSeVHFncXUjTPH6o3Y5CmugKulyIieV+1e/dwOlMlgLkE4Z
         rmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455074; x=1708059874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjZFEhta82MOtciRGbl6T2FR/OOl48rGzrVvDiOd70Q=;
        b=qTLx8EkO/SjgDxo5kI75MuGAeXVZNW/+Fc9MCWCW6y2rVErezqfhQ9xl+dX1S32Meu
         aOmlSDrqXwUxJ/jFvBkBa1qC+2LWEntWa0QUJXuNqHIu3u4mnDJ6++msumxjly642Aob
         PgBuKjrVejuMePs9bl4MygkCHzkwgirPN9Uc6oEPlf/UeCfeXSxaZVOr1/DWQN95B4OS
         fRXLKAJTYSMo6l+QwNysGGTJKbvubv4tRsd7FUfVApId4tKo5YtVwGOyjnMFFd5qRair
         JI7ew6eIBrYliYJnD6fFXT5P9AUxieITyVEhfeoJOTIcuIRBBpmwz6fO5LWXaycoDPUc
         Zf5w==
X-Forwarded-Encrypted: i=1; AJvYcCUBcPWYBw8r5pCKEBN/Vf+F1jMjYnIXyU+uRSOhE4rsUQl1O6z/lct1MMgudSyALqE4lpSlpfnrZNgnbyncxyNk+Js7VwqMvHvdXZme
X-Gm-Message-State: AOJu0YwVZfyTYEYvjdsd1mp3nm4X0TNWp0PrS0kU12D/etYgO0Eokm/K
	yyTJ6Pfn1bn43hLeRhpzyKX9k0fwqShIHXEvsbgzFUGUB72m/tyUYOScUyWwZ98=
X-Google-Smtp-Source: AGHT+IE4szqU4Ay1G6/JELxarp78mjVBi7FgzF4R7bKtGoDeFcwkmwDv8btXpIMCHmtZtTn1CYtILw==
X-Received: by 2002:a05:6808:1a22:b0:3bd:cd55:d320 with SMTP id bk34-20020a0568081a2200b003bdcd55d320mr645768oib.47.1707455074417;
        Thu, 08 Feb 2024 21:04:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSERD4SauKvBcEzPT69VFBN5d60cxzNYSDss+5B26n28GIXMZm6cEmZ4S8smV1qyLMGLOcp8PQE2+Hs4NtUe3ZgYvXRsxaEJd+HoGwXa9mhiUKVRf9gWZupzEj0f9XxwdGiJA0UQTq7zoq+sZtm8Oz5XK2fgViD1M7RvMR+uiXM1679AsuT2w9HMzYg1v1anJ5uhGeshqa2/fSg4xBlFpKav6XQD4IStSuolOe6ZaTkZFpm22SgVB5AqUL/BS29AxTTH4v5hHNAIDHWUiNPldMV+JRrpgL/J+GrroXZ3xqebine+GcVgB6Ow/O7s/XUBR/VIzy73ZEFjL1nMGDH6nxPHOBxHMErcwq9EO1yt8JAIRv6SaSxUKSi2prFSMsFE8uIuKsqIyA6bNRF+RTbpmyulA5
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:33 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:40 -0300
Subject: [PATCH net-next v6 04/11] net: dsa: realtek: keep variant
 reference in realtek_priv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-realtek_reverse-v6-4-0662f8cbc7b5@gmail.com>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=A/i5C+haAyk33PdSAUkRgcW9VpEkLWcEh+Fkl5NMbtk=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJLqGye92Vdwna3jCsp6pzE9QD0R25YKHWKm
 FV3NCQyDMyJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 VviEB/4vm6/Fdpi+O5IFH7QDkqjArSMhL3hYUJ3v4EB+Z1qDy2FVeg2mP3yAQM20DB1jY1KwvDm
 +CLhA7evVjOM5CUEz8sPidpv+9Z84jPLWqbf/4JDKX8s1TPwJxzPUw+hDqoBiCzqQ/dnaHch3ZX
 EBh1VQ0WN7nMOp7uOcwXQc3LPrZIAWsYC9wWtBVngZ5QsGElefNwe+5ekZXUaJjTR4nQ4MVltNq
 ZbZQQxQW8rX9X7lapQMwISdtMEGgV+1T+4SCJItACp2YobLWq3IaR00IYpIesYbx5PqRDEmhk9F
 ogwKif6Q5Qck3vYAmuSoPzRYURZU6xkqXzmaXdg6CdDiI6lj
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Instead of copying values from the variant, we can keep a reference in
realtek_priv.

This is a preliminary change for sharing code betwen interfaces. It will
allow to move most of the probe into a common module while still allow
code specific to each interface to read variant fields.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  4 +---
 drivers/net/dsa/realtek/realtek-smi.c  | 10 ++++------
 drivers/net/dsa/realtek/realtek.h      |  5 ++---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 7c5372561587..7be00aa2a9e7 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -196,9 +196,7 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->dev = &mdiodev->dev;
 	priv->chip_data = (void *)priv + sizeof(*priv);
 
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
+	priv->variant = var;
 	priv->ops = var->ops;
 
 	priv->write_reg_noack = realtek_mdio_write;
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 2a6a884bb45e..ad3b57311015 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -46,7 +46,7 @@
 
 static inline void realtek_smi_clk_delay(struct realtek_priv *priv)
 {
-	ndelay(priv->clk_delay);
+	ndelay(priv->variant->clk_delay);
 }
 
 static void realtek_smi_start(struct realtek_priv *priv)
@@ -209,7 +209,7 @@ static int realtek_smi_read_reg(struct realtek_priv *priv, u32 addr, u32 *data)
 	realtek_smi_start(priv);
 
 	/* Send READ command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_read);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_read);
 	if (ret)
 		goto out;
 
@@ -250,7 +250,7 @@ static int realtek_smi_write_reg(struct realtek_priv *priv,
 	realtek_smi_start(priv);
 
 	/* Send WRITE command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_write);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_write);
 	if (ret)
 		goto out;
 
@@ -459,9 +459,7 @@ int realtek_smi_probe(struct platform_device *pdev)
 
 	/* Link forward and backward */
 	priv->dev = dev;
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
+	priv->variant = var;
 	priv->ops = var->ops;
 
 	priv->setup_interface = realtek_smi_setup_mdio;
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index e9ee778665b2..c7d5ef99e9db 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -58,9 +58,8 @@ struct realtek_priv {
 	struct mii_bus		*bus;
 	int			mdio_addr;
 
-	unsigned int		clk_delay;
-	u8			cmd_read;
-	u8			cmd_write;
+	const struct realtek_variant *variant;
+
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
 	struct irq_domain	*irqdomain;

-- 
2.43.0



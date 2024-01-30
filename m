Return-Path: <linux-kernel+bounces-45454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 823518430F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD70BB24E67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B880BE0;
	Tue, 30 Jan 2024 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgRVLta2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F779959;
	Tue, 30 Jan 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656457; cv=none; b=Oa7bvYB5rr7/Let7jRndPqyQ3hjBLygY6fCX+JJXGPQu/6jOeVjRxm14imqOsLrm0MGjfa5a71gbTeLLAZ89z3f+4ZrO7JPT2kwwSbAyieqI0iWuR5+AN7djI59DB5PUKqHcuxDz2ka7KqioQzi6Iti2arO9rcK+ZaP1ry6qnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656457; c=relaxed/simple;
	bh=S5obDCnGvS5TS91erx2GSsdEW9PcBn5bVY35DeZVlyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n6TlSuExfaBWWm6iIYKRd2xxwmU/xmIuo7RJSn8RP11WDQnIRjAIAlMadvmeJLF10PGXqwyJj2Fvo6A3wckS1TBFUr2lBbfaHOSCv74qcxZ9K5e90pOTUI/kGKfrYRyoZcZrM/Db3kRoYI2zIlxkloHO/wXMC4RopwQC9COPZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgRVLta2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d911c9240dso8324015ad.2;
        Tue, 30 Jan 2024 15:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656455; x=1707261255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qeFL4aGiz4VFRECgb8oorsdrovpNi4/WsaBAAfE8/g=;
        b=fgRVLta2OfchmJGyRtjI/yFeHo8As+khBv3UPWxPHlDnu8eDUO8vWEgXwGQ+vpPW8z
         d0BOx7/QSq5JZiLt+hxal383QsHDPUNe+o3WNzd/HqS9pP4LzY/EtX3qDSh0qpq5Lf5M
         +UswaEqyldr3wszZbpC/LpFSeFPniIaTP5rK31CVc6Fn4WV+6pwNgJHrD8gsiPaXC4ha
         EO3Zyla/UWF2EWKqZwmePfUGRYhihm5JSJ5RdegEexfHtmxaz0rNyzahf31cNiGUeJJ/
         GT+eOTNf7IJWHeD05qp7WQvrAUdg0zM3jMW7mYsAVVQkYvm4Zz3S8IhNheIES5IoKRQw
         trhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656455; x=1707261255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qeFL4aGiz4VFRECgb8oorsdrovpNi4/WsaBAAfE8/g=;
        b=erHXknx0Y8mnGCuqsyNz/hXefp0n07wvr/I8S7ep9XBsbmC0eLwp2Awma+TSactV2S
         NfOQnYH/GqWNpSKgEkhkRMxgXB0CU3LDPE+ygyG3D6z6+r++PoIVv85VqmHXLXnppqDM
         w+aoWLwhqsBYLapVJ4uk0G20KDeLWXQVDDUwTte9gTjaXMJxEze/7zmlniVWuW26S9ib
         6V0FQlYROy/l5RY+KOOYeAyhoagiDWSLMiT//BCZ8ZrzD47VnifOh7aENIOlUu37iArX
         aY7TS8jVhJ6IIyB/vqTBDLrbVTQ6ud8flsJ9XXnw8tE+h1s8rmjPTGvk+YdP68ha86FG
         Keow==
X-Gm-Message-State: AOJu0YzrP+Xyz+uhEOfvopZ3JU8OK1aqGOiaSx9YtWyCmxdwhTzejJUX
	jXVfIefu0ajXcf2I8kudoASZWHCWHqBuP0JV4SbncEZ9HNOEngOf
X-Google-Smtp-Source: AGHT+IH4n8gxmKy4TPNVI4LX1Iwwep2aFLRq0seixRj+zXPE96s5K3ftBHuSLZ8B084QFQga3aJ0sw==
X-Received: by 2002:a17:902:6bcc:b0:1d9:21bc:c616 with SMTP id m12-20020a1709026bcc00b001d921bcc616mr50766plt.15.1706656454861;
        Tue, 30 Jan 2024 15:14:14 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:14 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:23 -0300
Subject: [PATCH net-next v5 04/11] net: dsa: realtek: keep variant
 reference in realtek_priv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-realtek_reverse-v5-4-ecafd9283a07@gmail.com>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
In-Reply-To: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
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
 h=from:subject:message-id; bh=S5obDCnGvS5TS91erx2GSsdEW9PcBn5bVY35DeZVlyI=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKwQqpcjOshsLZV0YcKCTVx++oFT8946t5bv
 8KcGNfrCQKJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsAAKCRC7Edu60Qc7
 VkIsCACdZ8sDZ+u0PxugFUdeC3M9qpdtZbAYrYtx9/jsTxOe0Ou0xsjPl37XC8wPLBeqkdZf9b1
 sE1HNf6WTyyCIQmU7tYG+hhf0ChU9ZxW/EWHol3Udr0WF60sLwItujnVkydZVDjcrBa6Mkqp1f7
 tJhh3EkFHwuGlb0cfOCrdHEUbdm2/NTAGkatR8mcoBXA+G239Nw4lT0eQnMsnZMSHmgN7K7acRi
 QcuU5HHEY8xdYW6IqH0XD/J/R7ZPqu4BugzWkfabZ2X34HQcLbXJjZ4YhbmTlGiggd1iqhfyOow
 LwS6tyHHoccbY0efOrpYBNROMb4VeCiLz+kkSCdCHO6lvY/0
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
index 3433f64fb0d7..5b78402b1683 100644
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
index d8a9a6a6b5bc..147260f77d2f 100644
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



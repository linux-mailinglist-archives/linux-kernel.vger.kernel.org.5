Return-Path: <linux-kernel+bounces-64425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F8853E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDE31C21B31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93448664D8;
	Tue, 13 Feb 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEwulULg"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9669977;
	Tue, 13 Feb 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861924; cv=none; b=GjM0MMfMObdtbVf6+cBzSRWyInXwEfXn7Tu4LHEwi+SCckCCLp/qRQ9FYYdvGBmZ5lT9tUP/IVC2s+bPR1QgLkzS6aJsvwpT+Y4feofgXT8MhHr4RadtOnfK7QbDSeKIaahMZcL8uOCBj7ATOLmrs2dL21XjgiceaD5Julf/Jck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861924; c=relaxed/simple;
	bh=3t1Kl6TYhkuyHwRDe3nM2rQAkK7+PieqY3Q/E3QLm3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGyXDfC5SrOLbYbu2l73e8w5I0guI3l5KtJVDyqdA4BwiHmL+B0e9k9k1eRx8wE6GjVThPjPW4ccCflYdaOqujzG2XZ87WmlXgVOlWvdK4K3BZqFxmf6lSVlOJYHFH60rrih7iLSpZI0v06g/qEbkf0x77av8/v6yHs6uI1+wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEwulULg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a30e445602cso39427566b.0;
        Tue, 13 Feb 2024 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861921; x=1708466721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvolxYsZq35+Fn0h+5+hh11SNg9vPDU7l0RYp5KmkEI=;
        b=CEwulULgXDZGZXyPrcWn8vs62xrrHidBLR0q3goP2XxxZGg6jUWzIkY4LH1+A20aON
         Gz/4/V0DUuJ7odnzvc7O+vbbukX2kfn8lcLEXvh5ftHLIyQGMCMde3HuMEsU8t4UiOpI
         dpQ/mIEKVM9Y6vdJIuDRxb9SBVnFY6dgiSgc+BRDygnczHGyJcPrcCUePPjUX3XHTI6Z
         y+Frgwsb1Pq9+BnnvMNyrItmfzetA/FBKahDuxLaiY0OSuFpLgTtgVfh7qDPagjwmlAS
         CDYEx+iy1bcTkF45eZIyR2GIvNTMqEk4Onv6GJ0oJzZF4VuetsRV12+jzwT5V8YwsOmE
         7dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861921; x=1708466721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvolxYsZq35+Fn0h+5+hh11SNg9vPDU7l0RYp5KmkEI=;
        b=R6BYY+ThJAYrIPO70FUsnrmx+dKaf4s3+u4RMMj3jdzboLzYeieHnFEKqUT48TA4He
         mZE/lConWYW24iA/MrajAc6lzyoSKo7RSZdiNcToy+kuWT1/cZHm15RlUsEhysNaVBUa
         UvZuD5cQmDyGTEv+McC9zmsZZzEm3HCNB2e22EuOxrvhXcj8x5so+gs5Xm4zdGNwSIaX
         c5IOSRcWn7UlPlJRhB7VLYDll5lNIfwwVaZDyFuPYedmWSGFOXPQRS0aukEaP8R/pJPr
         zfYuY/Wb0IeM9OFPGDc8TRKBhU3zegG8J86ZPhFeo417d8i+x1jj2iwq1JxCcOxlP2sm
         u3mw==
X-Forwarded-Encrypted: i=1; AJvYcCWTLiv+SKwF5JtiEJXxWw368fdUqJdrz7p2NXzBYCIt9dG2PBwo8XgLn+YhQjpW3y2sRH/2Yntt6lWjAIAVt5A/Q+/Et4VLR8jbo2IA
X-Gm-Message-State: AOJu0YzEP7FBMgBZAjPFouhmtvWXSCJt2aZSDcRD/s0VveeNTJselrR6
	ztkrhlMByjd6ks39B+DhcV2tBUdnEw14qdlwjMD1CI/u30hmGUjb3SiFOYPqfYs=
X-Google-Smtp-Source: AGHT+IGyDOecV6Z2nG34ilSgMgSfvDEstY46UiUC2WF10L5OzK+mysKeUMQuQxzaKOxFsOnDsFoKHA==
X-Received: by 2002:a17:907:b0a:b0:a3c:ce90:bf4 with SMTP id h10-20020a1709070b0a00b00a3cce900bf4mr106000ejl.14.1707861921264;
        Tue, 13 Feb 2024 14:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJ+xfKI6chSg1/+NaWuZbzmedeh2L/Nvbd4R6B/qMEO8UVHSk1VJa4HjP39iZqMZsiiOtMGwYrvy1HG05rQUnDQpSJbJpa1ckRJlEWreZlfsRRA02spfdrtR7z7YY0vEACjTUc6CCFa5QLJsPiL+1UD5ygLjwJPHvDzGmYYEcnLGoGKxfSZZ6G7pCEluO7GeJneq+rnf9ZCq2wa+QvYHwoFKLIzm/bv1k0EflEahhIQtulx9X4ADNbA0WWcRcNT/Dl0QpKw47bN4qr9S68OoZdi5M3HoKPx+fzw3qq13Ttnu5OsutomEGLJBjfxMHCfAESEdlzcvRZuXqx/pg8f/GuWcKR/wAO2krUdva3P56rrNi8s5UCEwFO44KhgLZAHyfVOijgmHM94FoPVBgUZPL/kS+WSVAJ8j/4HmaW0sXxq/EKgD63gfgrxs2T4aHEEoy/nJ0HGOQSIw==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:20 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
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
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 04/15] net: dsa: vsc73xx: Add define for max num of ports
Date: Tue, 13 Feb 2024 23:03:17 +0100
Message-Id: <20240213220331.239031-5-paweldembicki@gmail.com>
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

This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
used in the future instead of a hardcoded value.

Currently, the only hardcoded value is vsc->ds->num_ports. It is being
replaced with the new define.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - Resend patch
v3:
  - Introduce patch
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 13 +------------
 drivers/net/dsa/vitesse-vsc73xx.h      | 11 +++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 5b54823b2caa..75597daaad17 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1170,23 +1170,12 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		 vsc->addr[0], vsc->addr[1], vsc->addr[2],
 		 vsc->addr[3], vsc->addr[4], vsc->addr[5]);
 
-	/* The VSC7395 switch chips have 5+1 ports which means 5
-	 * ordinary ports and a sixth CPU port facing the processor
-	 * with an RGMII interface. These ports are numbered 0..4
-	 * and 6, so they leave a "hole" in the port map for port 5,
-	 * which is invalid.
-	 *
-	 * The VSC7398 has 8 ports, port 7 is again the CPU port.
-	 *
-	 * We allocate 8 ports and avoid access to the nonexistant
-	 * ports.
-	 */
 	vsc->ds = devm_kzalloc(dev, sizeof(*vsc->ds), GFP_KERNEL);
 	if (!vsc->ds)
 		return -ENOMEM;
 
 	vsc->ds->dev = dev;
-	vsc->ds->num_ports = 8;
+	vsc->ds->num_ports = VSC73XX_MAX_NUM_PORTS;
 	vsc->ds->priv = vsc;
 
 	vsc->ds->ops = &vsc73xx_ds_ops;
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 30b1f0a36566..fee1378508b5 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -3,6 +3,17 @@
 #include <linux/etherdevice.h>
 #include <linux/gpio/driver.h>
 
+/* The VSC7395 switch chips have 5+1 ports which means 5 ordinary ports and
+ * a sixth CPU port facing the processor with an RGMII interface. These ports
+ * are numbered 0..4 and 6, so they leave a "hole" in the port map for port 5,
+ * which is invalid.
+ *
+ * The VSC7398 has 8 ports, port 7 is again the CPU port.
+ *
+ * We allocate 8 ports and avoid access to the nonexistent ports.
+ */
+#define VSC73XX_MAX_NUM_PORTS	8
+
 /**
  * struct vsc73xx - VSC73xx state container
  */
-- 
2.34.1



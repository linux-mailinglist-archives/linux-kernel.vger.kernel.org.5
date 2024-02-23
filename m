Return-Path: <linux-kernel+bounces-79163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9E861E60
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79BB28470F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7C14CAB1;
	Fri, 23 Feb 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAG8jUKd"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E8149386;
	Fri, 23 Feb 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722125; cv=none; b=ro1cRrMgKqXGwJ8BFmuv5+pmC06r/NtBKpT9o/qpzTqzlmagrVOT1JI10A+1rlizxTcn7zrsRI/b1mluxlrQp61zsnBuOPZYwAlvJbl1uAJ69KeNzisqRVLrr+urxF4EfwA/InSSLKPm7WEekvY768g8tU/AsFJcVqh/LTOfFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722125; c=relaxed/simple;
	bh=jMIi9XpyjMKrSso2kjpj8ETvk29CWpBo/T3bKFftHjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sT38ZTgwnnzSFgYt2U3cc+L/lct19dcfuSyrxXINcJWPBDVzz3ivQvsaeNp0PcK95+F1LxTwWaH870Y8erV2pnjaUCfaM/Gikt5xRwzsAhpig00DjM6qxVxVqbZDgeyXOtXK8ffsqAvO38kc+x9IrPhR077Jcy2FCPA11QXsAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAG8jUKd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512e01b3da3so1658866e87.3;
        Fri, 23 Feb 2024 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722122; x=1709326922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPX4Iuw96szPAD6qjCqbSaeFiBzpVrcX4bId7fchfRc=;
        b=FAG8jUKd0oEmwhnH1Zr+LBWbrrqciEKLybwCgIoEy6VUIREIOEapvSAdNmHNcPYqg5
         p0bY6PPa/NrPOSVLv1ILFh/TSIXxAyAqe18NoifOG9aa9xR9vK/GjS8/jdLruGrrkZW7
         yZBY/LEXupyzUbZGTkgb+6gzoqUVIhjJsjVU2aKpf2rRPiRft7kwKGuhACsmgKc1wZ5w
         vWbkGJrsfA87f2itnUCrq8vZZVp9p+z4Fdom9tubh8HoXvsfDHXmGmnJ/pm4eF6wFcP6
         WNyS0LdjMqjPUBXi8HTz/7hWhcz7x1rXnEufS03smDt96ag6dnH0lvwS22JpEabQEwSt
         gYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722122; x=1709326922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPX4Iuw96szPAD6qjCqbSaeFiBzpVrcX4bId7fchfRc=;
        b=AtT0EN5+Gw+2ei0Jn9KUKpRAnipQypGW/rbT6//RgTVx7mgGKIdOBNxEmQhS7d9uGZ
         +FpYkYDoSxr/wrqRGOKxZRFmlAh6395g2Vi7LnDY0k5OBJ3Hc4BjGq287HZgIW1pulkK
         MXcZHX4LxU8qZHcOEyJKdDysmYqXChgN1M7HevNA/tgT2b1IxekXCl/MKbTh/bqWdWjX
         6AKHokHLt1o/VyYektzTNkkigmC1QSmaTh8DRw+PLQviGJUIZnOSwhPH7lJI2vdmKaFB
         cIBQuFz6dB6rUjMZJ9V0JF4FE8e/w6i4xj1DMwFp5ey2w1ESfkrSogbYTm/YBImV/Gid
         nApA==
X-Forwarded-Encrypted: i=1; AJvYcCW9YipJc95KPKzBisogpf01dZUbIpNch6E0dBLmd+SiflkaVj/2TKe4i8G3IHIWaBuxSYeCfoK1ae1tSp9PZR/Wdj6cAQoNii2KjTVx
X-Gm-Message-State: AOJu0YxbD/QMd2O2+q0Bl4JGneys7+kO0RdQn0gJPvhj66oY7SZcSeih
	XivjP7TBPKs23Sk11iiMXixhCYNfWxXPGsXN2lh0rZVjd0Z1CoKE9ehURavLhLs=
X-Google-Smtp-Source: AGHT+IEf3ZAws7M3wsQDv5v3oNMNgbSGTUF8TvKm7R9dAeuRwtY34qePH44k/hRqjBLRuJuZUTZ9Jw==
X-Received: by 2002:ac2:483a:0:b0:512:e711:d46a with SMTP id 26-20020ac2483a000000b00512e711d46amr542056lft.24.1708722121826;
        Fri, 23 Feb 2024 13:02:01 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:01 -0800 (PST)
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
Subject: [PATCH net-next v5 04/16] net: dsa: vsc73xx: Add define for max num of ports
Date: Fri, 23 Feb 2024 22:00:34 +0100
Message-Id: <20240223210049.3197486-5-paweldembicki@gmail.com>
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

This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
used in the future instead of a hardcoded value.

Currently, the only hardcoded value is vsc->ds->num_ports. It is being
replaced with the new define.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v5:
  - added 'Reviewed-by' only
v4:
  - Resend patch
v3:
  - Introduce patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 13 +------------
 drivers/net/dsa/vitesse-vsc73xx.h      | 11 +++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 8ed8fc997d6d..425999d7bf41 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1180,23 +1180,12 @@ int vsc73xx_probe(struct vsc73xx *vsc)
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



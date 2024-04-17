Return-Path: <linux-kernel+bounces-149221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB7D8A8D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E331F21241
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7A65189;
	Wed, 17 Apr 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNBhq5vc"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C54AEE1;
	Wed, 17 Apr 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387108; cv=none; b=rYFyX35KnI+0yNBImP3/5+uIcK55iGGd1DA8h8qE8Al/HDbHTDdrj1cGRhP0tAlPKCxrOekfDbEUyIjxBVFyvbnQQqX1bIdH91pTuYXMhYIg5emGhoV2LNWxtIBBthCBRdUioGNslO8fFMRyUopZbZDKTG+GLwNd/zzEoA5n8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387108; c=relaxed/simple;
	bh=ouVLEUZpWX2UCZN0EuGUEDMf7fMnkTJN0o5J9TEkr9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IORgzz4u8eXX+EZvrPawHakfFNrkmIkTJCiocrojJ2fjYMXXCppdD52kdHwCIoYkloeyR7TMiJK2D4rL8NU3C/vPMgZhYkjxi1hEL/2VXLFN6GPvu3D4IAhMYObKmS13bXlD5T/f7wNg+ye+yOSNrMwZpjKrnxiXOOiS8901pvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNBhq5vc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a526d381d2fso225873766b.0;
        Wed, 17 Apr 2024 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387105; x=1713991905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/IsHbN6lEzszWOCVj+rAi2aH3mP1bogQa/4bzTSAoU=;
        b=MNBhq5vc7d32+MVUgdmrPCNQZdPFcbWmfhVWrtjKmASz4Etao5ldDpT0QkkfM82wAF
         UbmjdBDBlp9lpTYg3PV9ZFpMTt535ASc7mGnkswOcE5NJEf24lI68bCI3NAKy7RjTy5+
         r1vo9pTBEYY5f/31HqbnJCQg4faNQ9NH07YF22WnoxF3yBah2KKvt3HAl1mf+Nf0lFdf
         D3Lst9beqETtdZLZQgDTlsa4KIxc4JEZIVmnVA+QYygaCBtC0uckZSdLBkCOXZlUZRAF
         zJEBcwjUHER0vzojLUBM7YLIIxPrsy16JHHt6cNnu5wQwAN5zOCNW/7Utt0H8mVFviwL
         mNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387105; x=1713991905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/IsHbN6lEzszWOCVj+rAi2aH3mP1bogQa/4bzTSAoU=;
        b=OYqoAPqI4cz1NqtvM7fjy7u8mDVFj9ImH56Ft/AR0JzIh3w1kMIAWRfjcU7iMjeMXA
         RXoPbuxFfgr00Uqw9T58bpnDMG8eUuNuLkotQdmww7pLzRGcfmNvNrN9KRpbbVK5DOjj
         en9bsZKI/XpIHX2FST/9h8VGKEV622UEzlv8JSs9vfsDsILQmGCVskWEkBGLyKeWbBMz
         RtMhUnyfSLGJYvlPyWO3RV1fy9QPOzlcg8P1h2anQIl4f6iP4OnW23bFAOZfA5iATyC2
         rt6m+/ajsvlK1S1TR/G8bgxXZ5mhW1EgQ7WFKRtVlYXbyX/cw1qUfiP/w8tTcPsB9s4D
         39aw==
X-Forwarded-Encrypted: i=1; AJvYcCWUk8+0Vddsjuu60uT4NxU8Sv/IrJRz4rqETpsFTGtDLK0ZvMyV1VbXdnoN6t5v4KXCyulKn2lPmwUdsQmt8PlNh/aOQtJaL0tKAFyE
X-Gm-Message-State: AOJu0YzRy+12qHV0gCzr+E4zJ2lCP21wj+3svzyOvDDXzK3UfxgNyUbt
	ZsDJ0G0lno5X2X27729rTk+Fht9XiuZJ9ZEppre/bXB1oaQQRf4dTJyTi7nb
X-Google-Smtp-Source: AGHT+IGGQM1Y4PKRjMQP0FfL+G8Z/F1T1TCYOtknbc5RXEOw8odBVmCWxkkpQCiQmT7bu6doXsjiRw==
X-Received: by 2002:a17:907:86ab:b0:a55:617a:e57f with SMTP id qa43-20020a17090786ab00b00a55617ae57fmr276091ejc.14.1713387104705;
        Wed, 17 Apr 2024 13:51:44 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a554177a2cdsm31752ejc.85.2024.04.17.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:51:44 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/5] net: dsa: vsc73xx: Add define for max num of ports
Date: Wed, 17 Apr 2024 22:50:47 +0200
Message-Id: <20240417205048.3542839-5-paweldembicki@gmail.com>
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

This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
used in the future instead of a hardcoded value.

Currently, the only hardcoded value is vsc->ds->num_ports. It is being
replaced with the new define.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v2:
  - resend only

 drivers/net/dsa/vitesse-vsc73xx-core.c | 13 +------------
 drivers/net/dsa/vitesse-vsc73xx.h      | 11 +++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 09e80aac43e7..f1cd7f988561 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1186,23 +1186,12 @@ int vsc73xx_probe(struct vsc73xx *vsc)
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



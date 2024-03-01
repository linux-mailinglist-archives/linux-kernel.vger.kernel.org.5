Return-Path: <linux-kernel+bounces-89179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C7B86EBAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A861F23626
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15959B48;
	Fri,  1 Mar 2024 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQLlIMnm"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A485A793;
	Fri,  1 Mar 2024 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331466; cv=none; b=XVXzy9XGogVJ7Vs3AomLlQ/0vgZ6nZifAD2ZMOWGi4iXLSbxQ/Bh2FP9vz6cOQZ1l2tUmu9yJUwzX0sOrscTprHW/zjKmIh2AYsN3mqxJm03ZnjZ85Q9bDN9aBfArJk/tp+6uG4fp7RRiK5ESDxWLhKA6x/5fHoKkyYyPT1KrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331466; c=relaxed/simple;
	bh=qrSILNVLjjjNKJyj1WGPEYiYZQSzoBxN9C17+GLublE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5lHwi46v+Nj0TmS6gKePmEEhlc6Jy+jXarcVqaTfqmrWeB5+PrIeTjx4NvWAoUfZICo1OSYVPiJi9HnJpOzrnSkhPY7jD451fYKlk+pPVAI8a/QHpUPTHJRmfr8UCWn6dIpNOVYhuz4VdF2FZ3J+Js03c6hNN0j5vjCVB5vqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQLlIMnm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28a6cef709so428866566b.1;
        Fri, 01 Mar 2024 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331462; x=1709936262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zngMc+/G2xBaVj+Hq+WsLXMEauJLoXOmUweXtku0rXE=;
        b=IQLlIMnmu33hfz6xNGt2rMVfPxwRnkEZC3yCzDEjTuTE0xpNtusjd3XwE3mDvq+n+1
         hrjaczGHpb5HHixNbnZrloWcsbHK14a0BHMd25uBBoDFlvvEpiQEOEq3EQ9GGvWh+fhM
         tBnv8Ct2xTXZ0nV1b3f6Q1RfxLugwU3PN8RYbhfTTw/uZLh6O420dSn8TQZKg9vJ+NTd
         5KuUzT8/+OISB6rbKZDcpIMaRdIpkMVfoyDEEi3y0RcZ1JKIgjiJQnywiXL+WTFDWsND
         3N+qJ660bSUOMfGhyc4iSVkAl0iLjv7RRSaXd513v2A8NeTrQG7PajSN5S2gIonH1Aq6
         KVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331462; x=1709936262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zngMc+/G2xBaVj+Hq+WsLXMEauJLoXOmUweXtku0rXE=;
        b=BX96A9E2YtpnzVBNQi6Yv4+vZK66IojsPSVrTBaIyq5SBKvWwz/gP9gu3aRrViqaR5
         LyvNwwYrE+wGWeC04T5GYEFlCSqIa7iu7z85JRtaxCpRlBNygwzMl0WeGBzRGngEGHGJ
         /la1alti79scrAvB1HdHGvvkS83KYG4ejyi94oNozDpkal2aR8OocUFJp9iD1CU77hfw
         clF2rfU4uHuF6rizk2nXeDfrBkZpQXVgkkDTLp2bvqMiMFg5A7YiPWJblL90zFdbjtXw
         j2th481QKKTecbO3+IXPSD5aelAzZn9zXgn7Q8YEwWId1Ebf0/0go0YbZzDNone1SABx
         cgDw==
X-Forwarded-Encrypted: i=1; AJvYcCXKfpdSvJ+ZfanneyqKIsNepL/qBL2T98+AemIoEyFE4c+kzXI6Hc8ImHrCU3fYTElA3JH1D326kc74MN+HM5HWkMXAqO8oiqUN9kuh
X-Gm-Message-State: AOJu0Yz3hN6KbmKJBBsp0wY79ltUEISAEXsUmMWlP/xsHjxXF3mrmGaD
	WDxSzqTcrR7k3fu9USd2euNaN+FCeNXaQbul6Jo5rGsv0T4MHDerhA/awzJaB08=
X-Google-Smtp-Source: AGHT+IG3QWPgBPHmemYcYC2JFholZxqXi3c2XdRe0iF5avfoEIbbFTCuKYI0l5yg9OPthqxAWUQanw==
X-Received: by 2002:a17:906:d92f:b0:a43:af0b:ec31 with SMTP id rn15-20020a170906d92f00b00a43af0bec31mr2342994ejb.53.1709331462405;
        Fri, 01 Mar 2024 14:17:42 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:17:41 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v6 04/16] net: dsa: vsc73xx: Add define for max num of ports
Date: Fri,  1 Mar 2024 23:16:26 +0100
Message-Id: <20240301221641.159542-5-paweldembicki@gmail.com>
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

This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
used in the future instead of a hardcoded value.

Currently, the only hardcoded value is vsc->ds->num_ports. It is being
replaced with the new define.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v6:
  - resend only
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



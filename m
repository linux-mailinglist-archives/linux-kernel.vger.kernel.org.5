Return-Path: <linux-kernel+bounces-147437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE58A741F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3531281C74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280D138493;
	Tue, 16 Apr 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdvyB2jj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F0137C20;
	Tue, 16 Apr 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294113; cv=none; b=aWKp0Mu7iCtP6EK5Ivqo2eu8QNXk4WsF5BPkKu0stViINKa0Uou0ZG+PDG6vkkpHkr6gAzsfnYsBStG2G8jWQQvYcZB404Q6qiKQxBqUe3BkrP7ivT/GS+VdudnVJlAGmfTnGWNyQelR9Ra0/oEezA9emENa+Rz0atn8g0sQ7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294113; c=relaxed/simple;
	bh=BePdJSykhshlcr2YLO3jLgL/BTM8kwYjCt0Yom6wGWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQ17tdVvoSZa0BwpBh7o0f9TtGAJhffWvPBcZm69qzZX1MyjCW9/WjTdslJ/cJTxNW0RPc1GPo71aQ6GuvS+KXax4QXIz6wccqtZQENKHLC4LsaqhzpU0GyYZAJ2kpnIIympQ76vyX/T7EpL33fyNg96nG5axzf6DFDr+Tueu90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdvyB2jj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5176f217b7bso8399335e87.0;
        Tue, 16 Apr 2024 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294108; x=1713898908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYEbbEojAMlE7H2adRDmr9HxTMtGNMen5CotsghfLJA=;
        b=YdvyB2jjZ9yeS+dCIds8cL4ivoLmYitGAPc03fajWJtCs6cagshFMIP+pYPD1IWjjD
         Us16XWl3jx6cIGs/4rtp6R6RULJ5xX1itALDg3waHtsJk5RQ2Drg2OPJzYEkRF0LfZBk
         IdaHAQyzzw3Dz6x0nwW1/D1mdu19fA0AGG8wBWBNbYSI8oyN2/icBxNlEMOUJ+Gc7VSt
         /o4TP5s/qcXTi9CpzQH9HjQMjlKGPdkx5tRG9NQI5d8oa9bmL1HAnoJKf7Re1HuWOZlb
         P6gmZkZZaCWPaFAED2Fri7+a3DyJ3GNqeYaOlzqtnRHZPTZyiQVsBw+6s2VAJwC3areA
         prLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294108; x=1713898908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYEbbEojAMlE7H2adRDmr9HxTMtGNMen5CotsghfLJA=;
        b=g8/19Y7wU08+xGgoeHiRFR2hO5Zv6p/v2KC3/vtWYTe56AlDkON0donnSkuhT2xuOb
         +R3VlY1lSe923QMugyWi7e6iSc5HQqc6dNdg5yhncBUmHcuh+hb9ERHBfGoEkwj3VK/e
         xkV5e6AwUwXtC8+4Ubw/G+4ft0wStCqyt/aZTGgYlqrD8wOSM2p/EOiqQOl1k2kmOI53
         i8bF6iJn2eInt5if7QclsktVojZNlgzaA4fB/3BRU0ekcYr8ga1NZoNewbPRI3+cpNao
         xltluWEx89h8xh3CaOdf38tVGI/KsipL5RsZ5AyWFifZsmWkeAeSu/Q5t4m4X7MBX6Ho
         TJpA==
X-Forwarded-Encrypted: i=1; AJvYcCXle3xKxJEUkqL73CHNA3+dKiwMfB36Incj5xKJEib0iWRjkRklt4Qd2w8VumDTP2bac/cj2XR/dtJu9oL1XTIuoUPd0o6nV/41AB2h
X-Gm-Message-State: AOJu0Yx/Vt7jxVg096ga4MVDSq7UVoHawddmQza/uxeFvIXwHzsEvavr
	voEGbH5xbPhxJjPA/V3S0QfBBQfWat9WMeyif3J62/w01EvZ3vnvymAFH2RA
X-Google-Smtp-Source: AGHT+IGgcI1149zan/0AxJ4+r+OgGOtsb9wBpusG6lDB5ojJ02bJheTzCFtVwqehxnLD/P9fJBdOsA==
X-Received: by 2002:a19:9151:0:b0:513:cfaa:e618 with SMTP id y17-20020a199151000000b00513cfaae618mr10958242lfj.0.1713294107999;
        Tue, 16 Apr 2024 12:01:47 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a524531a580sm5247981ejb.152.2024.04.16.12.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:01:47 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Tue, 16 Apr 2024 21:00:51 +0200
Message-Id: <20240416190055.3277007-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416190055.3277007-1-paweldembicki@gmail.com>
References: <20240416190055.3277007-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the delay loop during the Arbiter empty check from
vsc73xx_adjust_link() to use read_poll_timeout(). Functionally,
one msleep() call is eliminated at the end of the loop in the timeout
case.

As Russell King suggested:

"This [change] avoids the issue that on the last iteration, the code reads
the register, tests it, finds the condition that's being waiting for is
false, _then_ waits and end up printing the error message - that last
wait is rather useless, and as the arbiter state isn't checked after
waiting, it could be that we had success during the last wait."

Suggested-by: Russell King <linux@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ae70eac3be28..ab5771d4d828 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
@@ -268,6 +269,9 @@
 #define IS_7398(a) ((a)->chipid == VSC73XX_CHIPID_ID_7398)
 #define IS_739X(a) (IS_7395(a) || IS_7398(a))
 
+#define VSC73XX_POLL_SLEEP_US		1000
+#define VSC73XX_POLL_TIMEOUT_US		10000
+
 struct vsc73xx_counter {
 	u8 counter;
 	const char *name;
@@ -779,7 +783,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 	 * after a PHY or the CPU port comes up or down.
 	 */
 	if (!phydev->link) {
-		int maxloop = 10;
+		int ret, err;
 
 		dev_dbg(vsc->dev, "port %d: went down\n",
 			port);
@@ -794,19 +798,17 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 				    VSC73XX_ARBDISC, BIT(port), BIT(port));
 
 		/* Wait until queue is empty */
-		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			     VSC73XX_ARBEMPTY, &val);
-		while (!(val & BIT(port))) {
-			msleep(1);
-			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				     VSC73XX_ARBEMPTY, &val);
-			if (--maxloop == 0) {
-				dev_err(vsc->dev,
-					"timeout waiting for block arbiter\n");
-				/* Continue anyway */
-				break;
-			}
-		}
+		ret = read_poll_timeout(vsc73xx_read, err,
+					err < 0 || (val & BIT(port)),
+					VSC73XX_POLL_SLEEP_US,
+					VSC73XX_POLL_TIMEOUT_US, false,
+					vsc, VSC73XX_BLOCK_ARBITER, 0,
+					VSC73XX_ARBEMPTY, &val);
+		if (ret)
+			dev_err(vsc->dev,
+				"timeout waiting for block arbiter\n");
+		else if (err < 0)
+			dev_err(vsc->dev, "error reading arbiter\n");
 
 		/* Put this port into reset */
 		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
-- 
2.34.1



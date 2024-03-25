Return-Path: <linux-kernel+bounces-117961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6388B296
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7646CB3BA41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF25D8E8;
	Mon, 25 Mar 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdEggiPn"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489F5C901;
	Mon, 25 Mar 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399479; cv=none; b=F/ADb6NDFN1P45jX2qSDECaLXsOQBzh9T9zHS/8+aNWAY7b3NaBFEOXFc7D2HIsk/yEVGVWL5Y7tE3XJnLEeNqM4enyDehvGTE7zaKF1ccyjVW1k6RI2dIMutmx+mKlAYTWpcKR2VeentmDOkREwMa7snhGzQWbOeS0wNFNp7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399479; c=relaxed/simple;
	bh=GlSUQz1tJAfco/7YWHdhANQ0v28uxyKkDF7xpgAQN8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrN7nzhKk08SWEoTiRqASkXBQ/18s/ljkMP4JVETDQvH6uy0dDPqsZPoepW1dyR1ESBkZTKr0Kye9DfpE7V8Jj+NGUXXTAHxL48pu6hA3wpciJ21g3oWk3hksQ8skdf/LOGekiQqytrLVIKejefqO0xFMaYUEO8QGzsUnbZKpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdEggiPn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so1998145a12.0;
        Mon, 25 Mar 2024 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399476; x=1712004276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0F/8H7Tcr8axVcQTcIq59S1STUD5wziimqr+zfEnTo=;
        b=LdEggiPn9o7OWcWAVgupPuORmSLz5BJJQUOwb87LBDTf8r7n/xPA/TZGTPaLXADaiR
         PWUlxok1LWjkdamOcxzjzaNQ5OEowzoS3/V3L+CbhcuxYWElviLjHJQrKPjJxURFQsWq
         JUlCgIiK/MHLmoWx5usmMeCImiHa1hEo37wngsk44KeKskplt29NM4lPt/R7d6zr/OsS
         Gc0xDNCGnuiBM7Omu78JChkruMC2tz9TGPvTwfT2lxp8wol9NdHDvpTOwXSqibqmrd/j
         ASDnnl54HsYTA/H/kpUazbORffcooEFi0s0lWs5rZPohm74sIOlkac3j8Q6lvqD+F4q4
         0DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399476; x=1712004276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0F/8H7Tcr8axVcQTcIq59S1STUD5wziimqr+zfEnTo=;
        b=CAorOGcuFtSFusEu/UwlkemVxNBMbygHqdxLL5HVYTR+/zgVNoP+8TUzkDIC0tuvgi
         6JgRmi1pKIX4hXBM0anPWRUkJkCoFgwdhjv/hX+8r6oc/IB3kkydFCm8K0ghFwDB96eo
         QHMcPEC6xC7k7prLK26y4ebH+AVPFmWPpkeX6VVtXaA9K21O2h08UnQ675vRUHH0tGcL
         dP2p/kZpPNGbLE3Xdop8fu6O7r6tGa8QiuJ8VCeKl7+jsc6NQ49iqciqF+0ReFoiJgKp
         Y2aVE/rzPs5LOwkLc7ajLcYi2inW9fqu7ZeRz+E9g8ylHzXn6lcBynat0cBw1EuJENzN
         Xsow==
X-Forwarded-Encrypted: i=1; AJvYcCXMj9MLrfDigk9SxWpSQeVYUuZx9nOR4CWhClj8mwrMPGGyPlZH0TyZtHvjT96N3tuW5ZTmy9sHcdmMSKFzk4IYu0rsl39MQ5wTmiX5
X-Gm-Message-State: AOJu0YzQfAu/uiHw7j04fsO+dWJvE/y/tOw5NsoXFYDnPs/93ekRDo9Z
	eLtsFe2L5emfewW9HTE+nAM6hxr9Eh2GSEiR78YXP4sC9C0gL+1ivFo/57y5c5c=
X-Google-Smtp-Source: AGHT+IHb5+Qn0KLelSHb8PUgxEYczvwlI6xU3Y3Hw/P2M8dBYpBG9wNQG2avYKguJXaA39V4eMkPKg==
X-Received: by 2002:a50:8753:0:b0:568:aced:e5a0 with SMTP id 19-20020a508753000000b00568acede5a0mr7058709edv.14.1711399475594;
        Mon, 25 Mar 2024 13:44:35 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:34 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 01/16] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Mon, 25 Mar 2024 21:43:26 +0100
Message-Id: <20240325204344.2298241-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
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
v7,v6:
  - resend only
v5:
  - improved commit description
  - added two defines instead magic numbers
  - added include with iopoll.h
v4:
  - resend patch
v3:
  - added "Reviewed-by" to commit message only
v2:
  - introduced patch

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



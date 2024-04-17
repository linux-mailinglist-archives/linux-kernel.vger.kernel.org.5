Return-Path: <linux-kernel+bounces-149218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776128A8D49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525D528104C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DC3482CD;
	Wed, 17 Apr 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SprL8fam"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A547F62;
	Wed, 17 Apr 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387101; cv=none; b=uZ/HJj9JbNvL8EId5fUn7T2dVsy12zlowmWCoQKdXXXoZmkbQITdQq0QT8cIOY/GuOMFnR6bsC8ExIZ/0UiNa2reRJS/Ypd6frZs1VYE6+DpvxT26BafYBvkyQOHgBgh2iBQ82U9Ng/wjaOXYhpvG9S34dWRYFHOG5L15yvYQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387101; c=relaxed/simple;
	bh=LXXsEdLA5Zq6YNNUt/uYiZq4Vdw4X9I5cr9Mkn9kCGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NaHTfC49mVcCY8TMJWgBxgJnsVmcu+DbJIa8u1C/bTCoTiQy/YEgFvlhsCp3znndCL2CRyyEsk9RJzGdqxCZzsM3fTTphy5XsXl0LUR/nf/XEVG7CEt1CJtBXscuTTVUCcN8H7FWVAST4QqUmlhLpanM3WGGFynCrLC3BNUwLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SprL8fam; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so127073e87.1;
        Wed, 17 Apr 2024 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387098; x=1713991898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7p4soOdjEgY8AdNUYnjFSI1oGWCetbnE8kSZexjePU8=;
        b=SprL8fam+23ACLUg5V7kW/D9VDwVC6bp8imgwgwh8dzv4LzQevH/3qJgz4SrVa1rUa
         mlQiRED21zzPIxwd4k3Ygfu2uR+PFxWKiumlO7fKYR8DmmCfwnEqsnNXZDBrdPethj9Y
         x5TY0/9ovotYCeJnTWGZRVETyf2cIi7aXoWKhgrJ0Ah+FzUZH2xQ0jUUCQg7FwrimWaG
         iIhBzpMMNOMEn/Nh220pgAnmzPSyr65Z79XKdeLaEyD/DW3SUO7INU53OgvTMQa6Dpsi
         0IRVl4GH6h+TXqul2UpkXHaZ110lln5G0r45/tRg12tjSms+LeCNya+O3GaRyrEL4aFb
         WCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387098; x=1713991898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p4soOdjEgY8AdNUYnjFSI1oGWCetbnE8kSZexjePU8=;
        b=MVT/GZzJu4iEhzg9ZRVdmn2So1PJzQCGjFEDwDwRn6TX0gXzUI8EiBMAC8/WxEVGnC
         RfFqIu4mkiGsRj5bwSMnxiVUgD7+bVcTbSa0vD0SAZNS9svNFIIN+I++EOz8haX25owB
         D2jfZych3sPL+p5+5b4qSsXkeB7VJnDyoRRdjygJsyHoQeCg0UFQmqgQVImXrRfE19nq
         87vI+3UZNh7raaTN+6T8qzOBd+sqhMYyFTWexyjtoPY2Vlnz7koE858IONqIRtFErMfV
         T5BjqMO2OUxMbLhwIcB1mTlBM73ZfnH8iPyWTLWN0FzGrPgEjRIQr9vZc/Io5JNB2J7t
         DTnw==
X-Forwarded-Encrypted: i=1; AJvYcCVP4V6st7BiEj/X9e9yqnVi1zSW8jmaojQzB/xdorkdMrPhw+AepgHShaqOOvJ1d8W2yNMhxtMhseo1CjD3loUL71tAPoMLEq/BC09J
X-Gm-Message-State: AOJu0YxWbbX0JSIdEO0wwNfI7OGtnWE/Avf/MRQMp3Jo0GFKhqwWjo9w
	y8C12lN0KzQ5tcwTnW7DL+Rn2TGRXARvp87y4+cyqUw7WQqC3PHklnFYZ1vY
X-Google-Smtp-Source: AGHT+IHg93R07EBVWczpP3sS1rTp/cNe5g1XD26tAw2Nv5iFm85Ta75D4liGHJxJHBJF9STEHOInZA==
X-Received: by 2002:a05:6512:b96:b0:518:c6f0:5f22 with SMTP id b22-20020a0565120b9600b00518c6f05f22mr319628lfv.29.1713387097944;
        Wed, 17 Apr 2024 13:51:37 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a554177a2cdsm31752ejc.85.2024.04.17.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:51:37 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/5] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Wed, 17 Apr 2024 22:50:44 +0200
Message-Id: <20240417205048.3542839-2-paweldembicki@gmail.com>
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
v2:
  - resend only

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



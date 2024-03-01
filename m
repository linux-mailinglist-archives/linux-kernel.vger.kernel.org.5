Return-Path: <linux-kernel+bounces-89176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEC86EBA3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1089B1F23254
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4459B78;
	Fri,  1 Mar 2024 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYBkTV71"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F859B52;
	Fri,  1 Mar 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331454; cv=none; b=HZPZt4JvsYRyM1xX+/7YhiL0D/mTgMnVuTVgDSO9xv+oQrzUKnL3NSylNL+WzoaXHfP3/L+crUz0zwegDrUWMX04DiGh051phdI2YKDSoSSt+J02W5Zqx9yL8m8QvYZSLZHvOJ3W4W4TFeiE6X5j0zuF3XhJiwsJq7SAmEHEue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331454; c=relaxed/simple;
	bh=ZwzIRjxKo4W2uHrdDhdnCy++0skBBDr3Vzf96PWE78g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtrgSQMTuvSDK+xntLBrE27fat3sgdu0Iz6A5gVYnd1SzfLU1i4kTtQWhN02n3YDVesL/G98qeVjjhffynncx8ap2Wqa170T+YctKu1kpuDluffJcMNZ0tEvkWAWbTt0GzwYOQjB3FQvys0dF0c+2dFwDgeM/IhVWJ7uGvh5C2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYBkTV71; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso4331933a12.2;
        Fri, 01 Mar 2024 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331450; x=1709936250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqe39XKaGE46c6cFjGmEYyL944xkhI+5L3MWmcenajs=;
        b=nYBkTV71Q/xwc1U2RCt8IFi44aTLECFpL6F8AeGdjE75kD1YwPSQPlCC3wCsSVkgWn
         4jaAN1M2i8OhxwVTxDdqo6n8pkIvn7uJTW0DWxmPfOApZuJgbwDbb1A29PcUz3C6Wl08
         phJJjaQ9Y3zdpwy5CfdJIMUPxZ/GDCa+S2auHzmnYJOnMyETSZUNu+8YwYU0hWNxVjvZ
         BVJsRmnueK4WZpyq0c6xIWZxpbj+U7IcXbaPx2V6LKoPCsQdINp9ju7CNL/mUXZPNEPE
         d5Xm/VCFQrudKmwUcggOBBV1pq1lV2t87jzmMLG1LfgjuN+JLX2LZcWQGrBPNuS1QSt7
         2AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331450; x=1709936250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqe39XKaGE46c6cFjGmEYyL944xkhI+5L3MWmcenajs=;
        b=o0/bx6mphJw6Oybiv38U20DdSSfEBnbm/wgdMBCOGz9atYmhz+lp7De75IBvmdO2dI
         iYZKDFYmMgyWmRei91v6b+kWZXEuue7PbR4/wuAI+0NG7BAxCX/zw1M9MI9ROanpG9k0
         bJYn7+4uFpcLRkJ6kzzdjrhHcwrfm1pjGJ9pILTm/gvp/aC1TM9R8uuO8ZnSTGfWVYiX
         vjoiJUbN/v4VcjwX5GevWxskS/Htt9iOEVXzU336U8gApNVi66DbEWhjIEdC5jn8qGEY
         rJQFSbJXMqOaAoPa1A2Monr5+S+elNFjVDCNmg3wTbTEZ24sNxvB5YI/o7Iod0dHVl/z
         W25w==
X-Forwarded-Encrypted: i=1; AJvYcCWeRGS4zaqOzLkTO6tNDP7JGkDMqMEbeOgmLBpr2zzdX1j3B194IMBhNKYJvMuS5U2wsqW2SxMIwXrAS0SHCiA0DYYwjJSN2qEugxTg
X-Gm-Message-State: AOJu0YxDvQm9W3YV6f+/X8yqxBqvXEMcaRpNYJ3Ktno43w96tAlWHfIU
	gRHX5QqIJvq9JiokMed0QlelB2fhD/fXZG8zzfMLv0diSuTimO8C0SblIwddz1s=
X-Google-Smtp-Source: AGHT+IE+Q7dGBM1slngyWfvJD+frjlsWXk3LDZUtU0gg16O/Wmdw6u8A4Xw3ecI2ZVGTcIORyQ2wFQ==
X-Received: by 2002:a17:906:ad85:b0:a44:9a2f:dabb with SMTP id la5-20020a170906ad8500b00a449a2fdabbmr1799076ejb.20.1709331450464;
        Fri, 01 Mar 2024 14:17:30 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:17:30 -0800 (PST)
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
Subject: [PATCH net-next v6 01/16] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Fri,  1 Mar 2024 23:16:23 +0100
Message-Id: <20240301221641.159542-2-paweldembicki@gmail.com>
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
v6:
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



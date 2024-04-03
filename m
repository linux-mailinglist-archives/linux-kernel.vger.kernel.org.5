Return-Path: <linux-kernel+bounces-129584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB0896CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C321F2E69D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43681149C51;
	Wed,  3 Apr 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDZ2kblY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1241494D8;
	Wed,  3 Apr 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140720; cv=none; b=SBk1mzX5Y3Hx6LrwFfY/P4dBK/hzkFHmKyChM3yH2g9h3Fgrw8P89rgB+w5spWYc90e8uwWsp0ICo4x7BSiKavKw8SkQaU9lPekz85/h3UzdJRgGOsMBC4L7zTNJ1y0uiL1C15BxiDtHnLnN0lsSBhZ+mBSDiA4J2p1xpPFpIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140720; c=relaxed/simple;
	bh=AYF8IxFjmPRIZ2yHjvMO4zqR30IMbbwHmMsj12fvFdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM1shno7xsMVCRtiXGB7qOqABBq62gG3sMlxREf1ECivQl/RAaitBexvi3h32ny3uLtHXn6/NBCQnG8+DdynIRg2/uE7SBa28jXhbBrCdZS740avtf3ksEuo9C/oodbjatkCUtR6AYHMfX6qM+B4QDquoibVRhi5OwWqUU2UADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDZ2kblY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44ad785a44so710765366b.3;
        Wed, 03 Apr 2024 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140717; x=1712745517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvqfJFDT4uUbjd78hGNRHWQuDLmuXrnUhBRMXhjGdh0=;
        b=hDZ2kblYEC2/DmJsCztHQ19e95ISbecvfdoOyFcyshzcqhrzJlQSYu2d5PNGCmRxY4
         iD1NyvD/Z/rogZf9YLuxInojoHPUNlfiiHDX6CuaRDSRmI1d8e7ujqmDSfM5ATyfm7Om
         ftZlXm9YRDJMsnGTG8fnknISy+ANSvlzymoZI2ksJhpxDDM2Jj2p73YALR2G49moroMb
         XKGC1sQw6B8AwC1BGVfbVBoZ1+vh0urhDUt8oNOkZHD9zyWyFpsAIkWIK32V9XP5SL5Q
         BGyps7Cj4OQWp8ZGv0xR16pokOGzGFuW30bCUr1cvzHBFvbX/MfQAhfDX/RWZqQibncV
         JTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140717; x=1712745517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvqfJFDT4uUbjd78hGNRHWQuDLmuXrnUhBRMXhjGdh0=;
        b=HC2SePgUBbRks33sqpHutXRP88Bc+Kv1XyoS6LQ1tL0FFq9rHBFOfDAvhELg/wdoQ6
         FiVTuiWiKGh9x5K3gIuUNadnCg9RtGRgOirklchvJywC+DYrqq7JKg3QdNE3jkU0n5Ba
         A9XkE0ShAWDK+LArdDJrqF9M/BPGlDXqjO1IdAU7BS69SWrX16BejP6skIg75izagF0O
         Kh++biyPLjuA1o3nkkX1BBhAOtp6VSYkIYeXOa87XzfQB0LUFV1XkT7XKTl5ApFQuSUA
         rTpdycfLQ7BAgzN4AOyiaJrPLD+jae+ierole+HwSaxYGn8/PNMk0KfPjJ30pKVc5sGg
         YHnw==
X-Forwarded-Encrypted: i=1; AJvYcCWbWi5liIDOSh8uD7rO7Id2eu9vM9tL30LqxlMBYRkK0RnsWxDUe4MRT/CupXwuAcf1VqX7l6jeOR1GcCbYuM3LjJzBM5phcEZ9xARv
X-Gm-Message-State: AOJu0YxGPZIwEJnwxll4viVwU1ep/tKu/9I9WVaUQes8g8XtTeCQ3tAU
	dGGMdJKp0Inhi4mpEnAafqMkUEbEEBNlJlPZsJNamBMiok2+DLi4LgwGmYvFZ/s=
X-Google-Smtp-Source: AGHT+IF+NfSTumuGRLtaUAdmjV75XAJzwBcKdYE92R5EEpCj6ZgXY7dGfSHr9YD2CBDwofs6tAkhwg==
X-Received: by 2002:a17:907:7859:b0:a4e:2873:e94c with SMTP id lb25-20020a170907785900b00a4e2873e94cmr9333844ejc.1.1712140717065;
        Wed, 03 Apr 2024 03:38:37 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:36 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH net-next v8 15/16] net: dsa: vsc73xx: Add bridge support
Date: Wed,  3 Apr 2024 12:37:31 +0200
Message-Id: <20240403103734.3033398-16-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - remove forward configuration after stp patch refactoring
  - implement new define with max num of bridges for tag8021q devices
v3:
  - All vlan commits was reworked
  - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
  - drop vlan table upgrade
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d0442ea8a610..87922804d1c1 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -691,6 +691,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1585,6 +1588,22 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	*tx_fwd_offload = true;
+
+	return dsa_tag_8021q_bridge_join(ds, port, bridge);
+}
+
+static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge)
+{
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx_portinfo *portinfo;
@@ -1708,6 +1727,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = vsc73xx_port_bridge_join,
+	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1



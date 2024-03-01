Return-Path: <linux-kernel+bounces-89192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00586EBC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A33A28497A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6215E208;
	Fri,  1 Mar 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwFxwVWI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF425DF34;
	Fri,  1 Mar 2024 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331513; cv=none; b=Sj/+lOF3Bb/LZ6Lp9md7DM05XICJtc1ljmwTtxLLu1gAh4XAteCsQ6mXPFQJfFv03eb1BqHPo5JsccmWl0lotBGrm1WPMXf/KOA437X26LlnDQLHV8UK74dYGsg6egaagSbf9lYCKKBCnRICkt8rlEXw3a7wfBn3Ar8fqyhRf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331513; c=relaxed/simple;
	bh=uJkgC42m1qMww/b0wXn06Ev687zMv0/Cf6bbmF7HFew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hl0eFHR/HHMuCG3Ng4Yk5fuuGL0oam++nEvtxLMXuGwOx+42mN5m0X3kscx6h0jqc0pkYfy0JxP+M8EAxVdKgmka2IIz5KT3YoCcZY9J5SmMtBFnWv8XInULxDQDCyBoDmC5RkdItCwKOotzVgysSoPMl+7U9nbf/JlbUQBRuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwFxwVWI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44d084bfe1so12817866b.1;
        Fri, 01 Mar 2024 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331510; x=1709936310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPoUO3mVcNHxtl26Rvm1ySoc2LbVjIRYhcpdmG8Dp3g=;
        b=IwFxwVWI05XDukOFkluBHNnlE+qgsBzLrisZ1q2XJM90as/nZiGtS2BUqGWdUVJS65
         lZWJujNy9F0qe91+G09u0+mWgpSPXSNIORB9CqwnAwbUgk/MAaSSi4UK9cSbJtuXTZYi
         XjvKzZOKRaZB0MUgHA9tKFryMZuNHlHw7yKp9xE2CEmJMa8kWJaguSM9Q1ZKcWPsDzC5
         aKdGmXZfv6KyqRM5QYf9esFufmDAnR5fiOh2LLgGfJVN6ejsPMMMLVTdsT9G1L3QZ6eT
         JtIAtb5XU+lwElAsWDTt8hQ5mEtzVkA+Y2QJIeNQSfVdmTspcVa3fY36KPb7pnEIg0Vi
         arvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331510; x=1709936310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPoUO3mVcNHxtl26Rvm1ySoc2LbVjIRYhcpdmG8Dp3g=;
        b=MGg7Ll7JBcOxWhk+rbd+VunuOWQRhwsjWFIL0ZQ6YI0X4diRFkN6D5NIGhO1wEW8fQ
         Q2653VaTtCwMa3NzRnWcS2wvLwpGFTp2ndryY8scS7qTz7rfzOVkilL7B1dbbSHQWIhd
         L4mqwIASg0UnPgXV9HfkTuLkJKtCaDqwMBt9Z7or8okaSsjnMLnevGK2ScRxSfHPBfYu
         Ppqap+DvcSElJFAxsbdFqyebOs0tpn1OMQMCUKGswMm51YcTfgtMGOXwvFotZu6o4CGx
         47mMxOdjEjTX6266KgovUm/Dvu6O6bOzXgfsoTz5kKqS4s2vDn88wemlEkLnkAt22m+c
         cW9A==
X-Forwarded-Encrypted: i=1; AJvYcCVbpemLEwCWOJx3izbIgJ29gq9iFrdp4/BRueplhDpWckG9BqoJN0aAGRKvI7xQKYoluMoNkY0S/rY14p9QtZIX9ijlbyL/R34y8g+c
X-Gm-Message-State: AOJu0Yw5LiymbpLvNAFa8soOqpPYk3VtFfxuFStkmxhfjkyapyu94mqi
	y+fAemd/eCCz17FDlLpleVjiDy6NG5B1cccQJCM3EfKOUKSuVL6xpMvxliBSmw4=
X-Google-Smtp-Source: AGHT+IH2OJ2MhAj+02D7O0m7r+LXSnH3iMp/Oouu/4HQ8biRihfTg3Kso71GXSBExEDCx/wlqzKC6g==
X-Received: by 2002:a17:906:6d4e:b0:a44:19a9:7ef3 with SMTP id a14-20020a1709066d4e00b00a4419a97ef3mr2642965ejt.23.1709331510035;
        Fri, 01 Mar 2024 14:18:30 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:18:29 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 16/16] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Fri,  1 Mar 2024 23:16:38 +0100
Message-Id: <20240301221641.159542-17-paweldembicki@gmail.com>
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

This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
which are required for properly treating the BR_LEARNING flag. Also,
port_stp_state_set() is tweaked and now disables learning for standalone
ports.

Disabling learning for standalone ports is required to avoid situations
where one port sees traffic originating from another, which could cause
invalid operations.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v6:
  - fix arranging local variables in reverse xmas tree order
v5:
  - introduce patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index e7dea48672d7..05dbeec8eb63 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1590,6 +1590,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					 struct switchdev_brport_flags flags,
+					 struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsc73xx_port_bridge_flags(struct dsa_switch *ds, int port,
+				     struct switchdev_brport_flags flags,
+				     struct netlink_ext_ack *extack)
+{
+	if (flags.mask & BR_LEARNING) {
+		u32 val = flags.val & BR_LEARNING ? BIT(port) : 0;
+		struct vsc73xx *vsc = ds->priv;
+
+		return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					   VSC73XX_LEARNMASK, BIT(port), val);
+	}
+
+	return 0;
+}
+
 static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
 				    struct dsa_bridge bridge,
 				    bool *tx_fwd_offload,
@@ -1706,19 +1731,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 				       u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	u32 val = 0;
+
+	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
+		val = dp->learning ? BIT(port) : 0;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
 
 	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
 	      0 : BIT(port);
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), val);
 
-	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
-	      BIT(port) : 0;
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_LEARNMASK, BIT(port), val);
-
 	/* CPU Port should always forward packets when user ports are forwarding
 	 * so let's configure it from other ports only.
 	 */
@@ -1740,6 +1767,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_pre_bridge_flags = vsc73xx_port_pre_bridge_flags,
+	.port_bridge_flags = vsc73xx_port_bridge_flags,
 	.port_bridge_join = vsc73xx_port_bridge_join,
 	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
-- 
2.34.1



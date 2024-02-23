Return-Path: <linux-kernel+bounces-79174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFC861E76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5252843B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907F149388;
	Fri, 23 Feb 2024 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4DjGv+m"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859514939E;
	Fri, 23 Feb 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722188; cv=none; b=P447Cq64vuYL2agoJSGtqL9C/2485/Krv5qCUSTO22JnJSesHksusPQXGYmgd/PgY43OakvU62kXUxAPJId5ZeHxlLBDM3pJMjhbA+uSAWIfn56rL+aZ2rVfVq4ZJDDpEcr1X28UWripa3NhL0NahOwtI0UN2D0y8DLatlb+5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722188; c=relaxed/simple;
	bh=zxFuSdqwAGFS78xhXJ+6ExlfTO7DkUchW5bvMLNLJ+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RktHnUm2BH6hG8WasWpWJC1RA9DGzDOqlxaAdeLYsPil+Mm4bCbIPUbW0/E+5amRzEpjgaYD52P2I70iZMBCByphTf+PczoPPAUoa49VWSBeq5C9ctKZ501sVTPXKopp1Ax5nxPCkUef7Os/l0k5Np04nT5XX3VxVPAitn9ttV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4DjGv+m; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512ab55fde6so1070090e87.2;
        Fri, 23 Feb 2024 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722185; x=1709326985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsgqUU+5bw6FiOn7ZlwWk12GQwooTmRMzEUA6afssIg=;
        b=g4DjGv+mj114mgehuOiE327nRVIHyPZD12UNw5jv5s0l8nzPFfFmn71gceighoIMg8
         gJbTdUdzdLLMx7B9CQq0ZK8gU7rxVyqSybThf1d4yDPPiXzHTOSGSkfAFT2XPuZMPuR5
         xE1xlQMaM183O4O5c9c8hL7UjLOdUWCR0owKIR/RIXkUG1v33LaOmLlMHVPqVN+7iVOA
         UP1ngFKBjbvttHgiX/8NAevP4kmn+YcZc2OP3RwYd2zrD6regxutCZ5ABkA/aagtg3P9
         AsA2pBksVUEbSvv0etBjU74xui56BM1sIKP+4UTsXIi0WjI3//HA+Ac4R/s9aZlDxeJF
         WUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722185; x=1709326985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsgqUU+5bw6FiOn7ZlwWk12GQwooTmRMzEUA6afssIg=;
        b=SxHUkwVW9wUmsGubEd0xvEs5QX8dqf81apxcATpjtAm0s8p73bwI8+wca8+o22dYMV
         UdTyLIGtj1XAicUCBjm2PCp5bTmiXK9ziuGaG+V2wbZza3G8qwMWgwDtlFTNgMU8+wyx
         +Rm4UjpyhmiQrsyKi+yVTxEwwFc3nTbAXP9GYu70S+xyogoE72ka5cJaXAoeQ4oz1DRX
         dE9MceneSJ95ado1nO269I4WJZCKNRdQrQH53vgqeYopx7avTmtQYFvRaH6SYsmScINQ
         dhrE9I73Bfc+bdNZETnm5gYKCavRxNrwkymoCDd2aX2K9ErEv3Qjr0x9Ucz921Mrw01R
         OPBA==
X-Forwarded-Encrypted: i=1; AJvYcCVfYY+ZbX5vVc0iSibu/WFE82dJ4Uqrb7DD478Nnyqwm3GTvWTHIGoe/qC5Fn6TSRara5SoEsYKytVOdtvglZIXPj2OOwrD8E5IQI2B
X-Gm-Message-State: AOJu0Yx47WW5Dl/hALRZp69MQEToaw+oHjANbjPKS4oZnBb2NMOSrPfc
	c4V4V16EvIH86KjkUBL4ql5PT1mTwcGdKXwiFD3+sAx1fOrcHOtzBB2bCFr8x4w=
X-Google-Smtp-Source: AGHT+IHciUWkHuvKW6gqvHMyFt/BsBIpY8aPjK1rxBoMC8W8hzqSZGelz2JEyAK26UPhWhfOyhW4qQ==
X-Received: by 2002:a05:6512:324a:b0:512:d689:51cb with SMTP id c10-20020a056512324a00b00512d68951cbmr499841lfr.26.1708722184723;
        Fri, 23 Feb 2024 13:03:04 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:03:04 -0800 (PST)
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
Subject: [PATCH net-next v5 15/16] net: dsa: vsc73xx: Add bridge support
Date: Fri, 23 Feb 2024 22:00:45 +0100
Message-Id: <20240223210049.3197486-16-paweldembicki@gmail.com>
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

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
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
index 1132a86538a3..8dc366461b9c 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -687,6 +687,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1587,6 +1590,22 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
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
 	struct vsc73xx *vsc = ds->priv;
@@ -1721,6 +1740,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
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



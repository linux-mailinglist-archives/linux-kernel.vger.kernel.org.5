Return-Path: <linux-kernel+bounces-45461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B5843104
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF7C1C23DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CAC84A40;
	Tue, 30 Jan 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTq83wgH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9384A29;
	Tue, 30 Jan 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656487; cv=none; b=qEU9fhPcL40J82aX2eUxT+vh+11irFf7Kvv5TePbQlHBelvVUauB3JumLqQyh64fgVDqAg7oe+C9NW05wwEnsgUTfsX+R+oEyPrDxEp/N2OVeNLO6m/VmID4gToV9Mv/LlJg2H8ZpoPvsyi96vt4Amko8fVd+I4Opt+d+42BKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656487; c=relaxed/simple;
	bh=BG5ESZ6S3xcp89l1N+mS5Clo2oqsEkk72iSZeToz9kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sewm4FsRPmP7i2mxhCNjt85stdigPecgKrFgSkRPrX51wipW1eRMuocflhtQViZdkvXVROVB76SaSdW6TXPXtf1es61pz5lhNhJ9Y3/tl17ekVulKodyP/4a3e6B3Sdd7FV6ptaNm5Nd5p3PVh1f7CqfDnO71FmKpKrq1gFiCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTq83wgH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d731314e67so21933725ad.1;
        Tue, 30 Jan 2024 15:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656485; x=1707261285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cmf6IXAOX4sOtXhjJ9bPGawS7c4pqgm3fjtDF1AA0Pw=;
        b=hTq83wgHCQC4CmXVm9hxyZNKqilf49H52VEHD7dQOT5QqZ7oA/mWv2VpUQLZWcS/SM
         86/2HZbEfwoZUCYCbsBh6+KqWu0w0w9U7wGOmZ8jJVUURRD3P9ZGo2WWY7dV9YUUDcFY
         k/F1ye6oZ//fB2ux9NhLhH3n095g+u5Q2HgxjRnDKI1WWU1yTQHGbax/susytkxAXgwl
         S1QO1O/BvDbiTXrl7Xcx5qk/80Wk4ssacUs+EkC5mYpZEkjSNh2UNSUZU+0qeU5LBB12
         wM0bfdDrMQ8+UC1DNC+XToiPK+54wwDb6bsEq/bB/T/vd18f2dX+lYVtQMSxQHLEBPGy
         GfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656485; x=1707261285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmf6IXAOX4sOtXhjJ9bPGawS7c4pqgm3fjtDF1AA0Pw=;
        b=U9Xkswov4NC18cgH718huhNHJ6FBPKS4rvK7sLCX6s+ne5J2izlfTTcHL6h6mLrKOm
         uV42fqt5504v8NuzWuFyoMFNdhFHRierAs2x5pTtpqb5OMCilruK1VWPkcH5hW5rWjfM
         wdaPObDTaC6yysR2cM27sbT1rHBuTkCx8kOOvMnQlGFiZ932HZFnKpUNvWZQeZIePGzm
         A0vgpBk+P3v6lzL7374A9HjTkmyQzoOHwad5bjcsdrVEyBiCgfFaQFPK/SOrkybx0SwL
         Ns5D+fnjYswTClJu9gpyb80aiGLZgueKC3ypFLZFW70uQCRtU93V3x5WRzVigS9/Ir6F
         rzFw==
X-Gm-Message-State: AOJu0YzF02ZU3jDnZIZxZLVlqp+i4eJwo4KD+1XwgoNUpnSCuXSwjLxD
	9CgkuCVv/Qe/LcXCFWvglOhnBFh/MC9mUvD+91VwuQ17YuZ2xXvo
X-Google-Smtp-Source: AGHT+IETa/DK+9clg/Rps8jjioDdeA0JzTZORNLfXKPzaPO9J8iEAI/4IP93u05DsELbwccSdN/qhw==
X-Received: by 2002:a17:903:11cf:b0:1d8:ac08:3cb7 with SMTP id q15-20020a17090311cf00b001d8ac083cb7mr52810plh.33.1706656484948;
        Tue, 30 Jan 2024 15:14:44 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:44 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:30 -0300
Subject: [PATCH net-next v5 11/11] net: dsa: realtek: embed dsa_switch into
 realtek_priv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240130-realtek_reverse-v5-11-ecafd9283a07@gmail.com>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
In-Reply-To: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5204; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=BG5ESZ6S3xcp89l1N+mS5Clo2oqsEkk72iSZeToz9kM=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKxnBF4fse//mhC/q5GitrBp5Vnid95kwo0N
 dDwY2RkwciJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsQAKCRC7Edu60Qc7
 Vi+nB/4zPlKfX2EjMeiuYd9mmY1iicYxLG5bzkJLKDPKw9NyqSnlouwY2KGAUk24+jWjtnT2mvf
 /gO+5+bk0kfBuifuYDXgULj0YiBRp2xAohla4ccECAxrdGrR0qKd/cPyLZtFeY9ULcxcbI6SnTd
 CcavS3u2F3ypfcDzAd27DQqxKtPyPlKVVgeqL7KUGjaZPPsnmeqwGjNVyDv8se5IHKoS8m/IGii
 +KvV8+ld1JAvgApXrlL9G8UU9ohuShnOd7nzDMb2KjCMjYAWKKEZPAlf3bz5bFJcQc7K1UVxH86
 ogcqtJ9MHcOcq6UemIUaCu9JMPUyZi6P1ipJAI759lXe6K3b
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

To eliminate the need for a second memory allocation for dsa_switch, it
has been embedded within realtek_priv.

Suggested-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h   |  2 +-
 drivers/net/dsa/realtek/rtl8365mb.c | 12 ++++++------
 drivers/net/dsa/realtek/rtl8366rb.c |  2 +-
 drivers/net/dsa/realtek/rtl83xx.c   | 18 +++++++-----------
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 864bb9a88f14..b80bfde1ad04 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -61,7 +61,7 @@ struct realtek_priv {
 	const struct realtek_variant *variant;
 
 	spinlock_t		lock; /* Locks around command writes */
-	struct dsa_switch	*ds;
+	struct dsa_switch	ds;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 778a962727ab..9066e34e9ace 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -880,7 +880,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (!extint)
 		return -ENODEV;
 
-	dp = dsa_to_port(priv->ds, port);
+	dp = dsa_to_port(&priv->ds, port);
 	dn = dp->dn;
 
 	/* Set the RGMII TX/RX delay
@@ -1543,7 +1543,7 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(&priv->ds, i))
 			continue;
 
 		/* Per-port spinlock to protect the stats64 data */
@@ -1564,7 +1564,7 @@ static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(&priv->ds, i))
 			continue;
 
 		cancel_delayed_work_sync(&p->mib_work);
@@ -1963,7 +1963,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		dev_info(priv->dev, "no interrupt support\n");
 
 	/* Configure CPU tagging */
-	dsa_switch_for_each_cpu_port(cpu_dp, priv->ds) {
+	dsa_switch_for_each_cpu_port(cpu_dp, &priv->ds) {
 		cpu->mask |= BIT(cpu_dp->index);
 
 		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
@@ -1978,7 +1978,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(&priv->ds, i))
 			continue;
 
 		/* Forward only to the CPU */
@@ -1995,7 +1995,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		 * ports will still forward frames to the CPU despite being
 		 * administratively down by default.
 		 */
-		rtl8365mb_port_stp_state_set(priv->ds, i, BR_STATE_DISABLED);
+		rtl8365mb_port_stp_state_set(&priv->ds, i, BR_STATE_DISABLED);
 
 		/* Set up per-port private data */
 		p->priv = priv;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 54eff9cd0c03..cdc37be1ed2c 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1675,7 +1675,7 @@ static int rtl8366rb_set_mc_index(struct realtek_priv *priv, int port, int index
 	 * not drop any untagged or C-tagged frames. Make sure to update the
 	 * filtering setting.
 	 */
-	if (dsa_port_is_vlan_filtering(dsa_to_port(priv->ds, port)))
+	if (dsa_port_is_vlan_filtering(dsa_to_port(&priv->ds, port)))
 		ret = rtl8366rb_drop_untagged(priv, port, !pvid_enabled);
 
 	return ret;
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index aa998e15c42b..f65e47339d5b 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -226,16 +226,12 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
 		return ret;
 	}
 
-	priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
+	priv->ds.priv = priv;
+	priv->ds.dev = priv->dev;
+	priv->ds.ops = priv->variant->ds_ops;
+	priv->ds.num_ports = priv->num_ports;
 
-	priv->ds->priv = priv;
-	priv->ds->dev = priv->dev;
-	priv->ds->ops = priv->variant->ds_ops;
-	priv->ds->num_ports = priv->num_ports;
-
-	ret = dsa_register_switch(priv->ds);
+	ret = dsa_register_switch(&priv->ds);
 	if (ret) {
 		dev_err_probe(priv->dev, ret, "unable to register switch\n");
 		return ret;
@@ -256,7 +252,7 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_register_switch, REALTEK_DSA);
  */
 void rtl83xx_unregister_switch(struct realtek_priv *priv)
 {
-	dsa_unregister_switch(priv->ds);
+	dsa_unregister_switch(&priv->ds);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_unregister_switch, REALTEK_DSA);
 
@@ -273,7 +269,7 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_unregister_switch, REALTEK_DSA);
  */
 void rtl83xx_shutdown(struct realtek_priv *priv)
 {
-	dsa_switch_shutdown(priv->ds);
+	dsa_switch_shutdown(&priv->ds);
 
 	dev_set_drvdata(priv->dev, NULL);
 }

-- 
2.43.0



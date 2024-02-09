Return-Path: <linux-kernel+bounces-59014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5784EFD2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577651F216ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B085A787;
	Fri,  9 Feb 2024 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AveZqPAY"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FA5A110;
	Fri,  9 Feb 2024 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455107; cv=none; b=T5wNK2/mEwfGy5I4NndMBJxww9DeVwvi3Y0sdewcVVNaxuSSfGJagR/hfCwes9ah3oJddDfEDO2xgDle3RpRBUgm62tIXNosTAwUXgdguJwgPlP8BB+IBSLijrtpBQ4ZiGVwofmt7MB1e+65WDHCpNPK22GjOctNoL4uEPyPxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455107; c=relaxed/simple;
	bh=6WfbnARrC7IV5PUO40jgepRv0kdAsJzb6hqNXDQ8scU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9UDHUlOJYeHG21BfNEEcMiWAzkKrWBwAMeqok+kc615hkIKm3COXLV3KyX+d6GcVMOBrz8yGXUBUALsN24RQOcmPrj10BaaijdgKKgeH5juhDB0GPFcAmxtlhHBKK5zsKvOntoCbg29j4oYpIgZmL69+qGvuKA6MhdM25QTVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AveZqPAY; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bba50cd318so376285b6e.0;
        Thu, 08 Feb 2024 21:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455105; x=1708059905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLEgodVgVEHEmGYZZGHP4vAVOUCZMRMnWvIbZqBEda0=;
        b=AveZqPAYTy5dR+NPRMYPa1b29/OTfkIm/Kfr6SbsZwW5DDa25BjKwMzGrHpfzudkv6
         Ajwx0osOGFZnaEXOJdesyy2sJMN59XmZtgbTBvipEuR6cqecSG//wi89ozC76CJhhMX4
         sXpWIc+UkwUv+h8uSL/e3qaAZkzfdLDKF8W9WsJGnp4grZTFeBoPcLaj+hdloW0xXpkP
         2+9t/qmOtIJcVsGl3/BsFNYv9m571waq2aO6gI1kCbbK2RseKruaPwKBDLbn8Y4Wc9Qn
         P1yX08R5//j3zslKt8U1d4r4iAdLBB6KmLbzhWFnrmBLFvHtJJtiEf3qqCQaSwX2Nbih
         YCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455105; x=1708059905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLEgodVgVEHEmGYZZGHP4vAVOUCZMRMnWvIbZqBEda0=;
        b=hYwvaAx24azA7y72ovgtFg+sJg6/8F0lmMrKFWYy4H/VfOx4O6kGFPWfcgiKCZFjTr
         a6b68f3wLwPrKDXUQXdmgEnuKQdsMM52CteOJkrFUzfAMHViOhPv+5cnoUt4VL+UZTus
         jeCZAofo0N2UbXwT5YCc761ND6fUnvGzEEZuL5G39O+5F9G1MNEND7jgYZOVFrRtZCZc
         Rvz+bPElwyULIlEuxekQItV4bZP3VwnvPVm5lR+TOwKPAtD6yJO3RRhjbfbNxR/8AGCl
         HheXxyWQeGiS+RaB60MR9FdNJDtHuUbjXd9ngX9okwEZV98AGjt3mjYrG8M7RwhBsm+X
         e03Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPtku42GATJZVgVRDp3SbG+//Pc0C95o8xo+VVgvyQGqHAD0UTp5nBcKlo1uwLTfbksHMDHbKBZGI6FOD8Bmqsj+GEASKRAwKn5tF8
X-Gm-Message-State: AOJu0Yy9FUqhyMn90IjuAYJTxdX7xnFayacUfpCalnMFl5BJjhtsojxV
	megdXBzNilt/iODC/FEh0mq3VuEjmbJ59mGe+YNHuydNBQyTcFxm
X-Google-Smtp-Source: AGHT+IFqiSu1p4/lQFCGW75hf57wj5MH4jvYif6oYxniVGQg67d2RHQAIf4XU/PtHU11IQik1u9yug==
X-Received: by 2002:a05:6808:38c8:b0:3bf:e035:db58 with SMTP id el8-20020a05680838c800b003bfe035db58mr986971oib.21.1707455104885;
        Thu, 08 Feb 2024 21:05:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp90meHD6T3JeZHV9wTEn+Ev6aV+qtT5j6WBfXLl8FHiP5k8hE3DBi4FLvab9wA4HdkehZ7GpCBnsHSTHHmutHZtvVQHjC9CFTEFGBPzad+ndI9cMECoDrTnNbwjEA7hI8Nydus+hEQ4K7GAb/DhlsYuUvKTyzSfUKHv3thmZEL1NC+JqG3V+SrfFe2//Ps7GLXFok1O08rOx4RgwYs8Uz/unhTPmNE0n45hkuWelMtPo14bbRYAbfOyO18Oh6U19VxvXjzMDQGwUundqmjuTpW9l24Mo2iWoOHaPbUSq4P0+5YOXW+5z7ZPNpfK4CvP2llFW1Z4XRVl14aIz5bF9wNTUTi1psZe1Ydp2bnZXWoKMtwhw=
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:05:04 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:47 -0300
Subject: [PATCH net-next v6 11/11] net: dsa: realtek: embed dsa_switch into
 realtek_priv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-realtek_reverse-v6-11-0662f8cbc7b5@gmail.com>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6289; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=6WfbnARrC7IV5PUO40jgepRv0kdAsJzb6hqNXDQ8scU=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJMZoIJ4ZBc9ikZISEHiqb3dIJgALj/aZRGq
 /P0cy6DeJyJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWyTAAKCRC7Edu60Qc7
 VoRDB/0Xcsx+e+naa4CukK12XlsjibXx8lEY0e0aiTmvA/zv6ap6radNgDPIfBTIkoDTpNciYv3
 RIkh4/cIpLLBZVIbXE5q30r6Czvr/xUf4wMgfT2gP0AIe0Fkiq2KMyc9ce3gfE/R8RkgbR0CDep
 P6pemPRD3eB2l6SEvt/wb17asXIY/91PJTWJwl3i2WneU/3FBB3eBOvbpjjcCoi/8Bwz0NT/CZ6
 xl13/t8a0VMrBdh9GbYMpIvc+4AaY68ItcxUCTK594+JwL6VrE6CLKguoDNTu5osSaZ5bntDyH+
 msjPJDRpJRjJ8NohFq17i3l26aHIAym1kE8CaOBBWD8qgqb+
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Embed dsa_switch within realtek_priv to eliminate the need for a second
memory allocation.

Suggested-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h   |  2 +-
 drivers/net/dsa/realtek/rtl8365mb.c | 15 +++++++++------
 drivers/net/dsa/realtek/rtl8366rb.c |  3 ++-
 drivers/net/dsa/realtek/rtl83xx.c   | 15 +++++++--------
 4 files changed, 19 insertions(+), 16 deletions(-)

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
index 778a962727ab..be56373e9473 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -870,6 +870,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 {
 	const struct rtl8365mb_extint *extint =
 		rtl8365mb_get_port_extint(priv, port);
+	struct dsa_switch *ds = &priv->ds;
 	struct device_node *dn;
 	struct dsa_port *dp;
 	int tx_delay = 0;
@@ -880,7 +881,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (!extint)
 		return -ENODEV;
 
-	dp = dsa_to_port(priv->ds, port);
+	dp = dsa_to_port(ds, port);
 	dn = dp->dn;
 
 	/* Set the RGMII TX/RX delay
@@ -1533,6 +1534,7 @@ static void rtl8365mb_get_stats64(struct dsa_switch *ds, int port,
 static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
+	struct dsa_switch *ds = &priv->ds;
 	int i;
 
 	/* Per-chip global mutex to protect MIB counter access, since doing
@@ -1543,7 +1545,7 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(ds, i))
 			continue;
 
 		/* Per-port spinlock to protect the stats64 data */
@@ -1559,12 +1561,13 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
+	struct dsa_switch *ds = &priv->ds;
 	int i;
 
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(ds, i))
 			continue;
 
 		cancel_delayed_work_sync(&p->mib_work);
@@ -1963,7 +1966,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		dev_info(priv->dev, "no interrupt support\n");
 
 	/* Configure CPU tagging */
-	dsa_switch_for_each_cpu_port(cpu_dp, priv->ds) {
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
 		cpu->mask |= BIT(cpu_dp->index);
 
 		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
@@ -1978,7 +1981,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(ds, i))
 			continue;
 
 		/* Forward only to the CPU */
@@ -1995,7 +1998,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		 * ports will still forward frames to the CPU despite being
 		 * administratively down by default.
 		 */
-		rtl8365mb_port_stp_state_set(priv->ds, i, BR_STATE_DISABLED);
+		rtl8365mb_port_stp_state_set(ds, i, BR_STATE_DISABLED);
 
 		/* Set up per-port private data */
 		p->priv = priv;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 54eff9cd0c03..e10ae94cf771 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1651,6 +1651,7 @@ static int rtl8366rb_get_mc_index(struct realtek_priv *priv, int port, int *val)
 
 static int rtl8366rb_set_mc_index(struct realtek_priv *priv, int port, int index)
 {
+	struct dsa_switch *ds = &priv->ds;
 	struct rtl8366rb *rb;
 	bool pvid_enabled;
 	int ret;
@@ -1675,7 +1676,7 @@ static int rtl8366rb_set_mc_index(struct realtek_priv *priv, int port, int index
 	 * not drop any untagged or C-tagged frames. Make sure to update the
 	 * filtering setting.
 	 */
-	if (dsa_port_is_vlan_filtering(dsa_to_port(priv->ds, port)))
+	if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
 		ret = rtl8366rb_drop_untagged(priv, port, !pvid_enabled);
 
 	return ret;
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 80f2c38ae55a..801873754df2 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -217,7 +217,7 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_probe, REALTEK_DSA);
  */
 int rtl83xx_register_switch(struct realtek_priv *priv)
 {
-	struct dsa_switch *ds;
+	struct dsa_switch *ds = &priv->ds;
 	int ret;
 
 	ret = priv->ops->detect(priv);
@@ -226,15 +226,10 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
 		return ret;
 	}
 
-	ds = devm_kzalloc(priv->dev, sizeof(*ds), GFP_KERNEL);
-	if (!ds)
-		return -ENOMEM;
-
 	ds->priv = priv;
 	ds->dev = priv->dev;
 	ds->ops = priv->variant->ds_ops;
 	ds->num_ports = priv->num_ports;
-	priv->ds = ds;
 
 	ret = dsa_register_switch(ds);
 	if (ret) {
@@ -257,7 +252,9 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_register_switch, REALTEK_DSA);
  */
 void rtl83xx_unregister_switch(struct realtek_priv *priv)
 {
-	dsa_unregister_switch(priv->ds);
+	struct dsa_switch *ds = &priv->ds;
+
+	dsa_unregister_switch(ds);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_unregister_switch, REALTEK_DSA);
 
@@ -274,7 +271,9 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_unregister_switch, REALTEK_DSA);
  */
 void rtl83xx_shutdown(struct realtek_priv *priv)
 {
-	dsa_switch_shutdown(priv->ds);
+	struct dsa_switch *ds = &priv->ds;
+
+	dsa_switch_shutdown(ds);
 
 	dev_set_drvdata(priv->dev, NULL);
 }

-- 
2.43.0



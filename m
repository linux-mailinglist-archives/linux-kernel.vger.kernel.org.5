Return-Path: <linux-kernel+bounces-45452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144B8430EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDAA286959
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD67F467;
	Tue, 30 Jan 2024 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQPns0AK"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CD7D41F;
	Tue, 30 Jan 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656448; cv=none; b=Zr5eShLDL6AyWK3xYYvlE8KVlQlqpJh/veSWl8kx7H2eBHWFgT/KnokST8c4iFQv7ebb4hPdkjyEeyPEQFuxgow6IaClrm7fuNcPmLuJ6bA8N03DC9hOZ/4ROc+yVIySuSX6R9QQak4yhof9iXimS2+iVm1dXmleHVSjo8Q3dmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656448; c=relaxed/simple;
	bh=nhxEsQ4kP9am+iHjOX0gRwocvhLSYlIe7d8qonzPVKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hi7FqHVDweJQtsCXCrqolR9tKcGeQM14AzbBu0Vebyg6R+s2X/9DlAAKb1QVCGRbEM+CSpJoqC4299HQx9d503qFElO05Fn3ZE+G9ms5vY90jBC4ebZ5I+WgU89O5Xx46+pfMy3popDiTQ9d1ck/cL2+pyoxiXQDSvbMYSsnE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQPns0AK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8ef977f1eso14996445ad.0;
        Tue, 30 Jan 2024 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656446; x=1707261246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf1TfNPEAVg2+sm+zOsODiJx7A0P5Vk/5MG78DTQkas=;
        b=nQPns0AKCfu327lAZnNqgSPLszIo0BF7Qc2LQaHEad8VecaMXqJspYNYRP+zh9cwSz
         7OaWmCbL+gHxDWQvhcS9IPkfDN+PgO8prQM9pW1AshTOq6TbnklXBnDGhViH7RreKo4U
         TPi/mH2HYl77hXINUXjFaRF0jQvh9/UzyxowxkRNlSffIix8YQKiiwb5a0Hwk/BpXbEJ
         Agjb8zTcBpSD9e7cAvCD7i1cbdnKIXge0OjALKn5yMBSpGnwJhZQpxmh2TggL0MgPPMt
         1vwedmlKzq1ms9KOTwdR39oAEEO1aEssHLjYYUclQu2VyO07uqoX5eOrDnSPEyu7cz04
         bteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656446; x=1707261246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf1TfNPEAVg2+sm+zOsODiJx7A0P5Vk/5MG78DTQkas=;
        b=U+7qmdzhM1KyfKZ/ta3vRfZXR68/+FlhcPoqwWBRorEW+PEZ1S4GXVSf3Cp3tAKqgO
         i8iOlpzOrvLDBMcKQVY2sUHk2SaKcDiqmks46wkeoeSCUVbT/SQMyqv3sfxKIxvVbLz0
         Mq9LFZKiQ4q4AC1qt5TsfrL8cp58KpBX/nLQjAzNH5nPKOlzcJAAvP7m8WK886HAuuGj
         aznSmkboCHlRPjgM+982LutmNjcT8RCT/ygJjZp4bFL0r/7kohMnuUUzP/iiv3hPsyck
         qD47YZqjcqWium/gi80MfnkPUKNDTaa4c+7N6Q3VToTXrH7bnRs9A7bN8kbcQDxSVkZd
         IQPw==
X-Gm-Message-State: AOJu0Yzfdg3YN4MnbkAMY4CL/+GOx4vP6VokJ0qiXkwYua4OOmXf2mYk
	vPLgHH17/Zyc2e5JZlp+3+GFpXCf3rDGGeGWxzNqkTWxTwpoB2GN
X-Google-Smtp-Source: AGHT+IHm8+4LGtkrOnLsVhDQyK8X4Y2UloSBy6BxqMwfjEL4CeF8WjRbRwL7etNT74GNTk5HUwJMSQ==
X-Received: by 2002:a17:902:7086:b0:1d7:72b9:b114 with SMTP id z6-20020a170902708600b001d772b9b114mr27314plk.60.1706656446368;
        Tue, 30 Jan 2024 15:14:06 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:05 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:21 -0300
Subject: [PATCH net-next v5 02/11] net: dsa: realtek: introduce REALTEK_DSA
 namespace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240130-realtek_reverse-v5-2-ecafd9283a07@gmail.com>
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
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6005; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=nhxEsQ4kP9am+iHjOX0gRwocvhLSYlIe7d8qonzPVKI=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKwjoa6w6zX073GSamHTiGgKs90pZ4omyPhr
 03MxiIDvYKJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsAAKCRC7Edu60Qc7
 VgagB/9oIGlqnQSfhR4ZrnB4wQ0DsBl4N69LfXkXRIsN96ccnk9/gMKPPapEjUBMeGmU7l98QPo
 LKNPPomiYKgVSaAnTgdWbSz+7xYDKkGTKLH0BSQpzKfsFcZYLq/U6G+1hfQoClnCNPSrl09+8iV
 bSV6KWzd49O8NqNgnzH/zQJpaEKJxWmYHtNtacxFO+sF7yvBOxF1IqKQB3kB+3jWWzZaFDssaHa
 mlj9NwtE45D2gEAtPtLb3le94yd+aZadhemcC+9AAj54vcJyQur705n8SzL2rYTkHlWBw5MPXSV
 IM4s1HyMUlv3M1SeT27ak1NXuLYU+0F5k9YC7eNo3LbTMDkW
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Create a namespace to group the exported symbols.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  1 +
 drivers/net/dsa/realtek/realtek-smi.c  |  1 +
 drivers/net/dsa/realtek/rtl8365mb.c    |  1 +
 drivers/net/dsa/realtek/rtl8366-core.c | 22 +++++++++++-----------
 drivers/net/dsa/realtek/rtl8366rb.c    |  1 +
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..c2572463679f 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -288,3 +288,4 @@ mdio_module_driver(realtek_mdio_driver);
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 755546ed8db6..668336515119 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -565,3 +565,4 @@ module_platform_driver(realtek_smi_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index b072045eb154..c42ee8241ca2 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2177,3 +2177,4 @@ EXPORT_SYMBOL_GPL(rtl8365mb_variant);
 MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
 MODULE_DESCRIPTION("Driver for RTL8365MB-VC ethernet switch");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/rtl8366-core.c b/drivers/net/dsa/realtek/rtl8366-core.c
index 59f98d2c8769..7c6520ba3a26 100644
--- a/drivers/net/dsa/realtek/rtl8366-core.c
+++ b/drivers/net/dsa/realtek/rtl8366-core.c
@@ -34,7 +34,7 @@ int rtl8366_mc_is_used(struct realtek_priv *priv, int mc_index, int *used)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_mc_is_used);
+EXPORT_SYMBOL_NS_GPL(rtl8366_mc_is_used, REALTEK_DSA);
 
 /**
  * rtl8366_obtain_mc() - retrieve or allocate a VLAN member configuration
@@ -187,7 +187,7 @@ int rtl8366_set_vlan(struct realtek_priv *priv, int vid, u32 member,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rtl8366_set_vlan);
+EXPORT_SYMBOL_NS_GPL(rtl8366_set_vlan, REALTEK_DSA);
 
 int rtl8366_set_pvid(struct realtek_priv *priv, unsigned int port,
 		     unsigned int vid)
@@ -217,7 +217,7 @@ int rtl8366_set_pvid(struct realtek_priv *priv, unsigned int port,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_set_pvid);
+EXPORT_SYMBOL_NS_GPL(rtl8366_set_pvid, REALTEK_DSA);
 
 int rtl8366_enable_vlan4k(struct realtek_priv *priv, bool enable)
 {
@@ -243,7 +243,7 @@ int rtl8366_enable_vlan4k(struct realtek_priv *priv, bool enable)
 	priv->vlan4k_enabled = enable;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_enable_vlan4k);
+EXPORT_SYMBOL_NS_GPL(rtl8366_enable_vlan4k, REALTEK_DSA);
 
 int rtl8366_enable_vlan(struct realtek_priv *priv, bool enable)
 {
@@ -265,7 +265,7 @@ int rtl8366_enable_vlan(struct realtek_priv *priv, bool enable)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rtl8366_enable_vlan);
+EXPORT_SYMBOL_NS_GPL(rtl8366_enable_vlan, REALTEK_DSA);
 
 int rtl8366_reset_vlan(struct realtek_priv *priv)
 {
@@ -290,7 +290,7 @@ int rtl8366_reset_vlan(struct realtek_priv *priv)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_reset_vlan);
+EXPORT_SYMBOL_NS_GPL(rtl8366_reset_vlan, REALTEK_DSA);
 
 int rtl8366_vlan_add(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan,
@@ -345,7 +345,7 @@ int rtl8366_vlan_add(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_vlan_add);
+EXPORT_SYMBOL_NS_GPL(rtl8366_vlan_add, REALTEK_DSA);
 
 int rtl8366_vlan_del(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan)
@@ -389,7 +389,7 @@ int rtl8366_vlan_del(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_vlan_del);
+EXPORT_SYMBOL_NS_GPL(rtl8366_vlan_del, REALTEK_DSA);
 
 void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 			 uint8_t *data)
@@ -403,7 +403,7 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	for (i = 0; i < priv->num_mib_counters; i++)
 		ethtool_puts(&data, priv->mib_counters[i].name);
 }
-EXPORT_SYMBOL_GPL(rtl8366_get_strings);
+EXPORT_SYMBOL_NS_GPL(rtl8366_get_strings, REALTEK_DSA);
 
 int rtl8366_get_sset_count(struct dsa_switch *ds, int port, int sset)
 {
@@ -417,7 +417,7 @@ int rtl8366_get_sset_count(struct dsa_switch *ds, int port, int sset)
 
 	return priv->num_mib_counters;
 }
-EXPORT_SYMBOL_GPL(rtl8366_get_sset_count);
+EXPORT_SYMBOL_NS_GPL(rtl8366_get_sset_count, REALTEK_DSA);
 
 void rtl8366_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
@@ -441,4 +441,4 @@ void rtl8366_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		data[i] = mibvalue;
 	}
 }
-EXPORT_SYMBOL_GPL(rtl8366_get_ethtool_stats);
+EXPORT_SYMBOL_NS_GPL(rtl8366_get_ethtool_stats, REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index e3b6a470ca67..6661d4ba6882 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1938,3 +1938,4 @@ EXPORT_SYMBOL_GPL(rtl8366rb_variant);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for RTL8366RB ethernet switch");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);

-- 
2.43.0



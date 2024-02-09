Return-Path: <linux-kernel+bounces-59005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BB484EFBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4B528D2C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001455732B;
	Fri,  9 Feb 2024 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMWRO+e+"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE557337;
	Fri,  9 Feb 2024 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455068; cv=none; b=GHDbENuz1Y7SjzGSoOJpqAev0qlKqMpNltr63/iewc12ITS0BQ+OXEndbB2MDS9pl3pAEMIRls/+FGSyaqEeoVs2QUGC+1hJ1MVDdlpXQYgt/tjvmugbaikatnlndKZUfoNC5vGQEczK2WVzHH9TVbRLf2NvrOJaC2XeMMPRZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455068; c=relaxed/simple;
	bh=nhxEsQ4kP9am+iHjOX0gRwocvhLSYlIe7d8qonzPVKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egQihLM5YHQarMf+UUNeV29T/lCr//ImaG8lZeV2TX0t2MY63TDz7Jjq6w9Gvjvb/WD0uq+vSF7Q00u73Ptxi+oOzx+k+Ar60CVzKBq9EOTVR/1AGEgFi7H/01UCYQnsz6RsrKCSKxVjz45ElHq+dT/KLNA9BMvncYJ7v5yqTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMWRO+e+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e12d0af927so365015a34.0;
        Thu, 08 Feb 2024 21:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455065; x=1708059865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf1TfNPEAVg2+sm+zOsODiJx7A0P5Vk/5MG78DTQkas=;
        b=kMWRO+e+tHCuxkgbKg0WjkjUSNkzv+gMreegQ3RnNlQsfw9yKNfCCZAL9tR5Vu6vKn
         2zfBcrv8CXy2U1XUM0501miH18Pjh/hIt5Lc/w1v4RhpjKLrB+1fj9+3vBzjm3LJj+i7
         jzM5wuVaC/W3QgBrRHxeWvWn3UgYIFAvAuIB0DaavT0kr2AOJ3Fb57DLxyfNmKiuWvcI
         CVyghcKXSm65qAiYvhXYMFj+eSIwCI+6GkTbcRmrAJ7RMoc2ZRuEiYOitJVm2cEe9SeE
         Fs3acNeEq3bfFfx571ukTc4GTAAZXBBArIEMCQl5Tq5h5r1iCkEDi8EkWNrL23Gj5TcQ
         JkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455065; x=1708059865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf1TfNPEAVg2+sm+zOsODiJx7A0P5Vk/5MG78DTQkas=;
        b=wSj+6zLw5uGEMDWwLOH5+zi3qCzoYkanzgv2yN2XSX7mEymhYEU3InaNGDmG8+wVkc
         YseOMRXxsFevMABpkEbJa6IE4PABukSrPNWzfr4zrzRfA3zz+nLSAZbSFtxpeB2EKMZS
         2ebrMIfb8VPJabPn7RA8hsa6Cd1Ypjl+opT82iaXMLnFLZ7tM/nee89/c78zepB8bTr7
         ylrzVTEcGadURma3XpM4QNL2G6Vseabw3jrswo7lJCiqvFiS3KuUI/zBZujzotHTK/Yn
         tkwgSraGMjee9LhH0HxR58wjDfvkbpEwCqaCPMHBvTDTCTihjw5orYg7OK2Li4H3mUCJ
         ZoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLfYCkzAFJ/axk4N65g3NcBkbKJfFSnHVZ1LXKdruvkVeCEzWdDpyFcsrOMO8XnR5uTYSqk35Gs0UBLGmsvKeP0Egxjz6LION9xdbO
X-Gm-Message-State: AOJu0Yy1WwxPJNlxFW3t3AGhlQxJCxB0BgMS5ZNsDXORppXXqIz+aB/f
	om1UqRWHmBuht+dqIlVI1cqD0Mw0N94kc2odGCR7u0Y2P9DywTge
X-Google-Smtp-Source: AGHT+IHbnx9gBIAACUlzlfHj0Bg0CqKLO0Ygg7gzJfjFVD23xQwZIjDcOp2taGWb3byuxiqgaO0mHQ==
X-Received: by 2002:a9d:6a05:0:b0:6dc:97:186 with SMTP id g5-20020a9d6a05000000b006dc00970186mr545492otn.26.1707455065551;
        Thu, 08 Feb 2024 21:04:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7LWkhuD00MTEXh2xo10yFEOtCclfvCW2UDU/l85u0JihoUzHIZYG/cSkqJs4viASmkTucZjtRA/EsRweT8PoGZBhywgGJ1palazb3Z1uF9jgKS47MVWAujOa76oCSjMDLMG5pzO4YlYIUgisDi0B4+Q55bBBELKJt8kr+yuYNThGz1QblYDjVrvFgS5qIUKf/6I/n6RQD9spX6UjRvFnErZsi1f6qWQ6qPAyaGRieAC77eTKaBDnJB8gDSA8RiuYAZwJG+HMt076FkLOnQ91UkOekfVCorBj8KwwL9GKhEkGvduN7xwJ4FAP6BjlFoqFMQYYzTeHmtg67NkcuFEm59hzGT9GjYKq/7X073sIW01G3WRAjN+7+aIbG0X7jgTPdmrNY128XpCpFBQf7qcLN5aiC
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:24 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:38 -0300
Subject: [PATCH net-next v6 02/11] net: dsa: realtek: introduce REALTEK_DSA
 namespace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-realtek_reverse-v6-2-0662f8cbc7b5@gmail.com>
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
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6005; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=nhxEsQ4kP9am+iHjOX0gRwocvhLSYlIe7d8qonzPVKI=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJLTIGQQVmVLjdCkFUVLzZs4h+LgDwYqT127
 DjyEu0H04+JATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 Vqb8B/92mQCVxt9RXRfZLLes2E+HGxTEW0ILRUiCuCOx8OocrVxE4ycOXloRmTxbNLvHaP5OsNf
 9qZwe5yQ1HGgeRjo4y2q0whAlRi6QYgsUy5cTlzB7nyr8U592ZfXALmz99NQtjs16xQf+aCQLBA
 CNzkBryLkm51+nkOWGa3lDE505q91LydAWe90gz7FT1BPgpSLSWWhCHOsDq5Z+eILi2rlXcRDgl
 sAf19NkdM2U7P3tmjwaZlFix7SYT55geOC5QSS2Z7ZWCa8klE8qoH8sKEP/gV4zW+r4pShiG5QD
 ACRpCuaSE79V44nDfEefaQShkqNSJnVEsGSTsYkVASKSPv7l
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



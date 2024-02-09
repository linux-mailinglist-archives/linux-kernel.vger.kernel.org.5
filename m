Return-Path: <linux-kernel+bounces-59009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA884EFC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450812831BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BBD5822E;
	Fri,  9 Feb 2024 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht2oTvQU"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660858212;
	Fri,  9 Feb 2024 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455086; cv=none; b=kVkqOw9+lrmcY5JxFE8e7ryJK9qjbyaDMxl7EYJ0iKx3qzJr7UxGfNmPqA01o6aPVqk8OJVSiDel2hGo/sk/0Vf5K6OimFmU8tgFVk0qwtkQY1FBLhekW0d+uXJ1t0MiskQdOUzyH8y7kpBgiHrCiFCVMo5nSHPDW0XmTwXnpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455086; c=relaxed/simple;
	bh=uRB/16DuLtBh34jZnH2UtKHsz61uXCD8IYiY4hjgO44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lie21E32nhQP7qe+9JNl0lpmkAMeNEIjfe78mBXTrV+K1qOPfNXuvukU+DByq4ESb0DmvqNW8OEs703LtAo4JIfJyNhKADp5PLKdQ2bl30h+ojaZVsJEc4OEhgUy59CAchb4WJX6x3WRNThxtiShoL0BaLT2pp2k1j+oVVF8rsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht2oTvQU; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bfdd9fa13eso264217b6e.1;
        Thu, 08 Feb 2024 21:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455083; x=1708059883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U20uA94KDzmtdzL0Pvmh3qCzwQnio/F6nNOPO+lS/4s=;
        b=ht2oTvQUFoSEJQyQR6N9ZhQZmfPJzZLo+KFmmqAb3Phen6fVScGC9KdbAxkQGZljyY
         yFr7F4P+u2mqm5PRfi4UxjTfMkbGQW72bj+Bt02omcBYnziwME9y23cBN/k5PNtHMhPY
         xCY+qbWzqYhoeDcLzpL9E9pRkrkgWUv6tf5mxBUGEhACOr1Gv6UQlgImFLW/+OXmxcLg
         w0khRd1fb5sNxTVIlIdY5GGu7kGIpWUbA3LYHKCLabOe3eiFb7+ikn5wFQQpG/EJlwBN
         SQSxQUCplLPW/tSuayg7L+Q99eHxT1bVuGUaeeiK+m6aUvhIRsIyrqCYsdTOcmOEDwy/
         0qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455083; x=1708059883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U20uA94KDzmtdzL0Pvmh3qCzwQnio/F6nNOPO+lS/4s=;
        b=pQl8dM7IQ0FUqhG1TixxmHIXwWvU8YZm0UT9fb87NkMudbA0rPu+vu49vh1c0oeQWA
         unTiHhDQIKvvtM17ZkjoW3DVwEt5KjzwTZcVVXxYQfzIdgnobrUpF3W1hh5SlDHC1wla
         2mPH6QhHF8DW+56Re07h7+oQIyuZIugHNf/ObbAUxOOaMwJ7/CQ3Ixt5ugHXOzf9YK86
         BFAuR3yq8fbFEQVdpyTPLVsoR+ZdbUUxaB/hdwS2RI1SC+YAak54iEa0sCfjryknAp57
         FqX5ahCfFD20ZagJYAe11n/vCwGlVz7TTWrc1+J/HuYdH9f5AprcbsU/mCvDpSO5RUZ1
         MN4A==
X-Forwarded-Encrypted: i=1; AJvYcCUiVw6T7ejxr2o8L/KWLNPzdjZub6xaD9tC6pbPZ6jjr42dg1m2qSLTKpctX+QKvWXUYTnhtGXuZGCCse0ISqQipk7hxjk1YqNBrDku
X-Gm-Message-State: AOJu0Yz8rCaXLZYjbaHi4yE8YCjSDeonC1y3f+bvDofpyfgBnfxlr8Rj
	sMeOz8WBJIAdgQ35h9lVRhASwh26WAjm7EFdh+fuFqGV5grv0q0i
X-Google-Smtp-Source: AGHT+IHi/1n8sp2AdN3bcPgu3svCEfeSM19ragIjZgN5cLehhFDmA87zAgZNotRSCNmGpiW4AI1IwQ==
X-Received: by 2002:a05:6808:1a22:b0:3bd:cd55:d320 with SMTP id bk34-20020a0568081a2200b003bdcd55d320mr646205oib.47.1707455083351;
        Thu, 08 Feb 2024 21:04:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9V0ObKvp4vvxaA/6YbtSgME2bhbZbr4d8uU9XeesGpPY6yGlMx8TG1pM9djELdNxN1b7a0FnbdqrRcXEu7ru57p+PEwonUb1ZcOOORZebwMI4R0UX9JxG1HgQdfwJQduaYfzSvZMPjSCqTh+9yOPCdom2f/vv4P3cSCucR4Jou6ePXDY/H5TGB1P2MdW64hLEUoRbgpPHY/ktfXO2VImXYUMvrOpjTRs5u2BKXYl2RYlvojHcv0KCIXXy7vboV97wT0iKmDWHtuX/unvQDm2APeDpaQC1U31tUA8AkHFKuoOLM96yWx6tP97X4xuyO6xWV9J7ykBPLTf1AAOYqcsT4q7Pc+y147uoSeorL5L5FY20NuX9h1XyGDns2dRZBe/6eXjaaTVrJHBC/eAGWWzfSkfO
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:42 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:42 -0300
Subject: [PATCH net-next v6 06/11] net: dsa: realtek: merge rtl83xx and
 interface modules into realtek_dsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-realtek_reverse-v6-6-0662f8cbc7b5@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3898; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=uRB/16DuLtBh34jZnH2UtKHsz61uXCD8IYiY4hjgO44=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJL8xND5+rbHpTQwP/NWYbwjiZZTGb8top8/
 FVieABAxHWJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 VpK/B/9W93jJ0I+CQVtAzBPMkz0wo77tEQxrUjXWRVVxJnuoOJOGI6Ne5AlXJedPwsLdIU120/O
 uba6Ou2btVRsItynY7pTrlRAO8v822/8rlgk7YQPcMQCV4cdZzkopT/n9eBWKqSZPyRulC/s5Sa
 sLDgOTFAEOA3LFMz1PE9/AC6ZUpwkj8MYfEtm5fpVhzPs+i28arkLa/OwDZm9zN2cfKP3QkEgcs
 FkhPa/tQJ9PjM3o0GodqLo4tnAExEZYzY5A+afUDofAEsVZuitttSh/GlVRV/rKhZ0tRtHm5D3W
 QMWKGevQfK9wt7LrvEZPlP5P66kPV/8qZKaJQtkQioiag0TL
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Since rtl83xx and realtek-{smi,mdio} are always loaded together,
we can optimize resource usage by consolidating them into a single
module.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/realtek/Kconfig        |  4 ++--
 drivers/net/dsa/realtek/Makefile       | 11 +++++++++--
 drivers/net/dsa/realtek/realtek-mdio.c |  5 -----
 drivers/net/dsa/realtek/realtek-smi.c  |  5 -----
 drivers/net/dsa/realtek/rtl83xx.c      |  1 +
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 9d182fde11b4..6989972eebc3 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -16,14 +16,14 @@ menuconfig NET_DSA_REALTEK
 if NET_DSA_REALTEK
 
 config NET_DSA_REALTEK_MDIO
-	tristate "Realtek MDIO interface support"
+	bool "Realtek MDIO interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
 
 config NET_DSA_REALTEK_SMI
-	tristate "Realtek SMI interface support"
+	bool "Realtek SMI interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches connected
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index d579127f05f7..35491dc20d6d 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,8 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek_dsa.o
 realtek_dsa-objs			:= rtl83xx.o
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
+
+ifdef CONFIG_NET_DSA_REALTEK_MDIO
+realtek_dsa-objs += realtek-mdio.o
+endif
+
+ifdef CONFIG_NET_DSA_REALTEK_SMI
+realtek_dsa-objs += realtek-smi.o
+endif
+
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 90a017cbe168..04c65452da0d 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -186,8 +186,3 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	rtl83xx_shutdown(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
-
-MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index d676cc44d517..10de30d3e044 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -470,8 +470,3 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 	rtl83xx_shutdown(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
-
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 0f628065f456..e42139f6e685 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -231,5 +231,6 @@ void rtl83xx_remove(struct realtek_priv *priv)
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
 MODULE_LICENSE("GPL");

-- 
2.43.0



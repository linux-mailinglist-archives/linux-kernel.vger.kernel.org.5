Return-Path: <linux-kernel+bounces-41222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA983ED99
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6627DB22424
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB428E34;
	Sat, 27 Jan 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cILTJDni"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB625779;
	Sat, 27 Jan 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366587; cv=none; b=uRVORgfdlmYsDvo3V1rpgFGNTK8rGYVu/LCDsYsuATM3wUekDsCg+0nuh7TdFfo3fX/a7hTLUjEfEEnEbLBhwp3ZmXpfvMZK4zWNOb2HULDFM0LdpKUFjuXA5Tc1MGENH1vMF8lHny760wieUfty+/tvuzolhxJhMxgrPoVBhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366587; c=relaxed/simple;
	bh=08bKj4k6Nq1I8YpZDSCe/MeC7FBaqQkRVsTVQefgswM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbdQ3hEskQTyutR1FGXabWBUrhIPnmehec7nRuPOYozYhNOqHx7fki2LFbioCkCyVELwGcciqXXvl2DdHewScrfHsPm0ZsjI/zE07tqJv1iUN5J8qLBtPY9GOraTnFYcqz3c2Jhukx4LluvsRTq773eiz/xLbbMTVV/OKM/sYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cILTJDni; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ee9e21f89so13644875e9.0;
        Sat, 27 Jan 2024 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706366584; x=1706971384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qErZgVbIpW2hhNOx9D4TD62wOg8Av2z8ODUtyRaOH5c=;
        b=cILTJDninBSNM9hNNGf86y5yT1nb3PhZirOCcb5njSqt7V6axYEvMvXaophxIANY+9
         P/HsgH504WeA/KotpIwENlH3OOfyIUNxJbUp+DyB2yTxKM0hOO7GdlB3kQ84+HudXEJt
         FcLij7KG3Omb5yovIRNoucx6v5uwKfrEr48AdUR0UaJLwdRQpuKd8pfwwqZuvqNsgDTI
         EZGTxDv5a2EfdvrGXilCD96cwn5LmhwIIHpanw6K98YwHibuiTr3QjwtaAWYFI+bm2zA
         q2mf9cBA+zMx6C262E7rNWTqTlN5ph1udV5Zj0pkMczKHj8aPnjUnDBv17gJnKdNPkeD
         5Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706366584; x=1706971384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qErZgVbIpW2hhNOx9D4TD62wOg8Av2z8ODUtyRaOH5c=;
        b=A3b4hudtsx297RpjU3LccV+IB+U/KN7jAXxeSE7H7gu8HkYBl6mGg/EhY0mCneQR5n
         uaAlr5iLsbS5e/weWbsgkqF/EK3BQ65NwTBTheLGypTAA2SB9DneqJo8qfCfcwyl/A0c
         oIocc+tQdzEkg7tuDNL/muEoeX1F1xnhlIVrr+vzg3y3k1PExePhtBfXLwzRAaZQi7xF
         T/gZ/NvXoX7LF5DgpeLgnIS7VQPtQihg8V2g79tMhP46ICCTVZ//1hhOyCP2QalrpE3k
         /NZiFyYPpANUHqB12ZJuBhatJv7s9mhLHg4fEnXQz21ELN+tCbv33t8Pn0D3gjPUwxEN
         rerQ==
X-Gm-Message-State: AOJu0YwachyhAy9z9HBK4FuLMbR2oTG52Ysin0imuMYHaNbye0+Oobs+
	/KQAGJRWvBIYmUK3kZeDWLpGOBzECWBcbVxtIoczFiT1AUB+uaWk
X-Google-Smtp-Source: AGHT+IH0X1HWosUqAWmZCT6tfP1nxGeW4QUXZrdhouSm5LPjwf4MudVJLirb5tYZeuj9VWX1jBtX8A==
X-Received: by 2002:a05:6000:156e:b0:33a:de9b:5ee8 with SMTP id 14-20020a056000156e00b0033ade9b5ee8mr954824wrz.170.1706366583614;
        Sat, 27 Jan 2024 06:43:03 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05600c348b00b0040eef2aed28sm1412590wmq.23.2024.01.27.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 06:43:03 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 1/5] net: phy: move at803x PHY driver to dedicated directory
Date: Sat, 27 Jan 2024 15:42:41 +0100
Message-ID: <20240127144252.24767-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127144252.24767-1-ansuelsmth@gmail.com>
References: <20240127144252.24767-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for addition of other Qcom PHY and to tidy things up,
move the at803x PHY driver to dedicated directory.

The same order in the Kconfig selection is saved.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/Kconfig             | 7 +------
 drivers/net/phy/Makefile            | 2 +-
 drivers/net/phy/qcom/Kconfig        | 7 +++++++
 drivers/net/phy/qcom/Makefile       | 2 ++
 drivers/net/phy/{ => qcom}/at803x.c | 0
 5 files changed, 11 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/phy/qcom/Kconfig
 create mode 100644 drivers/net/phy/qcom/Makefile
 rename drivers/net/phy/{ => qcom}/at803x.c (100%)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 9e2672800f0b..e261e58bf158 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -335,12 +335,7 @@ config NCN26000_PHY
 	  Currently supports the NCN26000 10BASE-T1S Industrial PHY
 	  with MII interface.
 
-config AT803X_PHY
-	tristate "Qualcomm Atheros AR803X PHYs and QCA833x PHYs"
-	depends on REGULATOR
-	help
-	  Currently supports the AR8030, AR8031, AR8033, AR8035 and internal
-	  QCA8337(Internal qca8k PHY) model
+source "drivers/net/phy/qcom/Kconfig"
 
 config QSEMI_PHY
 	tristate "Quality Semiconductor PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 6097afd44392..59b1cb5b14fa 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
-obj-$(CONFIG_AT803X_PHY)	+= at803x.o
+obj-y				+= qcom/
 ifdef CONFIG_AX88796B_RUST_PHY
   obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
 else
diff --git a/drivers/net/phy/qcom/Kconfig b/drivers/net/phy/qcom/Kconfig
new file mode 100644
index 000000000000..2c274fbbe410
--- /dev/null
+++ b/drivers/net/phy/qcom/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AT803X_PHY
+	tristate "Qualcomm Atheros AR803X PHYs and QCA833x PHYs"
+	depends on REGULATOR
+	help
+	  Currently supports the AR8030, AR8031, AR8033, AR8035 and internal
+	  QCA8337(Internal qca8k PHY) model
diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
new file mode 100644
index 000000000000..6a68da8aaa7b
--- /dev/null
+++ b/drivers/net/phy/qcom/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_AT803X_PHY)	+= at803x.o
diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/qcom/at803x.c
similarity index 100%
rename from drivers/net/phy/at803x.c
rename to drivers/net/phy/qcom/at803x.c
-- 
2.43.0



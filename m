Return-Path: <linux-kernel+bounces-41610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F883F557
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E4D1F21CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE523769;
	Sun, 28 Jan 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2Hom2s5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203A23745;
	Sun, 28 Jan 2024 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443504; cv=none; b=rnjqFoLVrRzytIU+gXvKCoA4dvRouhWZXHBJay5GQEUJ6FCtMaX2mCORQe337fRLeH6NSvy96SmL5T8kJL9J5qi/8KkKywfoSJftnIP5/Zrcil/9uOXSxFaK79VnX1sEdghmOrAnOfgRulSgkRhzukuunk+hOMrk5BqRBf3Ydk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443504; c=relaxed/simple;
	bh=08bKj4k6Nq1I8YpZDSCe/MeC7FBaqQkRVsTVQefgswM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6uLEaWWRa7lzHObDU8aN8pk8NvO5pVIcbKEXQppsTo0G2AkI0k47xu18FGZwM84ADYxb4UdC9ERj2Lz+fY1jKiQEJeCpGGMkbDlmBE3iM++htSMxS67PYxCa88F1JV/8bH7XQFiKK/t7JyoGTETkxod6wgrsiEiLgUVJfOmKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2Hom2s5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so26596345e9.3;
        Sun, 28 Jan 2024 04:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706443500; x=1707048300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qErZgVbIpW2hhNOx9D4TD62wOg8Av2z8ODUtyRaOH5c=;
        b=V2Hom2s5Fc22k+jdnChmkjJCS70AckyhsgVP4fOZpv1xZNSkGe8iP1AjcdSmGWKgo7
         Mal9WFnxrPfqXwqeIfizTXrtlMQAGNYmG+GoUP/ZMI65sEh/eNwZ+Ea29Lji19K+0M0t
         jkB4SBAKtKW4kPUye16xGtjxFFDTLAmlib6yjBEkatZZSlf8vWuPKC6v9CtM0aU5v8bY
         YV3y2A/gPCDdpV92/gts2iD+yJi9SMlGDr6/a3qQvtrQW7codI0x8Bzny8pS7ykE4XRP
         ZOMYBwAkjxaZQl4UBipfldrW03ZUDBCvszsi90VsaBS+6V7Wv0J06Lmr8prNmkiY2wph
         XPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443500; x=1707048300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qErZgVbIpW2hhNOx9D4TD62wOg8Av2z8ODUtyRaOH5c=;
        b=LvJ6Nw86CQq1tacp/EUPVcmcRzWVyQJpbixqC9ZwEN+zQNi0EHbXLNg8B3Y4Q/QMhk
         zbmjb5dELWdtDkqvta8APsQ2Liv1d+g52TC66WnFKkA1oNh6chyR9/qdqazOSjajpGc7
         SwoOuM5bSjiL1lds3qetWmE18WMR4t/m19H+zs5qcYpMC8nDUHL/OgfBf1SqRAF2iZai
         4cUnmGPsL8NXDMw6AqLTqQoq9MRNvZVY+/RgH0c1hH9sgJrBLi2RzlH2PkL18ZiOIjDJ
         WLKgi4qMnA0fbfkuIOccAdsNz3Q5Ky5jzUsna++yW9fyDC9906UChQDaSVw9kMWl3Qp8
         qDUg==
X-Gm-Message-State: AOJu0YwZbMNowtglNbpScHxjlBIL9t2gzdyiDdnfBYrjaGZ85MtimOGX
	kHgiVzxrwf+5KBjx+mmrhY4VzIhKOcZJuOtPTj14zFYTV+qgHG+C
X-Google-Smtp-Source: AGHT+IGja/ZwAFwxfGDYbc2XmCzDDmYgDYCdNd5L8LlCl+xSkkUV18YeVJh10ur08HhrlSU6YKZK8A==
X-Received: by 2002:a5d:47a4:0:b0:337:bd80:c104 with SMTP id 4-20020a5d47a4000000b00337bd80c104mr2647795wrb.71.1706443500233;
        Sun, 28 Jan 2024 04:05:00 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v1-20020a5d59c1000000b0033aeab6f75fsm1110034wry.79.2024.01.28.04.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:04:59 -0800 (PST)
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
Subject: [net-next PATCH v3 1/5] net: phy: move at803x PHY driver to dedicated directory
Date: Sun, 28 Jan 2024 13:04:22 +0100
Message-ID: <20240128120451.31219-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128120451.31219-1-ansuelsmth@gmail.com>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
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



Return-Path: <linux-kernel+bounces-22147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37ED8299FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67006288F02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BF487A1;
	Wed, 10 Jan 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKnZ5pgb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAE482FE;
	Wed, 10 Jan 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so11460465e9.3;
        Wed, 10 Jan 2024 03:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704887876; x=1705492676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qErZgVbIpW2hhNOx9D4TD62wOg8Av2z8ODUtyRaOH5c=;
        b=RKnZ5pgbw6/9vd/gUJzR7+7mHNQBW8dA3rnz84Ywok7KMlbzJIVhOWmUeR7rrCoKKr
         /p5hl1gKw+K94MJ6a3EJ76Eu9tR/bEgQZDttL+GWv29RehVCL3GnH7R/uwaDxDG2y3LY
         a45gY+zEru8bo6CorS8pcGvnEb2IuTFBQ1k2IkgLqZYas7q5V8GOmrtrgR6yFA6JrfP0
         J8D0zxVqST9SSR/+XAbX3MLl7c0sfUcy0oiswiqxkgYtB8Chh6WxRliN3lTzMhdBlkCL
         4XxgtZQA5q7l0OTfXglzszPRt6R0w693HtIy3nv3wKkve5nuNmjZwgqxZXeYoNEduEqt
         07jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704887876; x=1705492676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qErZgVbIpW2hhNOx9D4TD62wOg8Av2z8ODUtyRaOH5c=;
        b=a+qn/4/g8sdOKMdyBlZe0v9NsaqNrrH0X0csKS6qOL0qVSdpStGEe+2s+oUCh0v7V3
         fs7ktwq46leslQBNceAgn/XKrO7CTRSDWwijQDnfCqcy4snxfZjzIN1xbuMjVbtMDRzR
         whstAhcnUzUqCi0UIOQbhk3HIk3Y4BOWNKKb4eb3bwloqWaNq0hd7uU8wZqT3TYlj5Ny
         YmzS4NJMumFEoosHzBLUR/j9WDjD69+dq+JrIrrPUzMy7yqgm+6zLuMsYrp2NNV4tU1H
         hCawyOPY8Fp37rldj3S8zwjAH4Ln06Y0OEpMeBt3YS1drQkY82Ym8wcQBwkTjuuOVD2U
         gLew==
X-Gm-Message-State: AOJu0YwjO1EcxsMgXEf/OXkii9JaiURr1fI8MmgH6ja/IGKwH8Uv6UQg
	yBo11KbOuuy7Z98hphYoc0HGCbU6LvU=
X-Google-Smtp-Source: AGHT+IFBagyMUgmcjYPROlsGW7dxCgghG1yPsigLhqLcFzshOyXf933BB/9ZjseKjoc1GZyUqwZZRw==
X-Received: by 2002:a7b:c8d0:0:b0:40d:56a1:2538 with SMTP id f16-20020a7bc8d0000000b0040d56a12538mr532122wml.62.1704887876240;
        Wed, 10 Jan 2024 03:57:56 -0800 (PST)
Received: from localhost.localdomain ([78.209.40.150])
        by smtp.googlemail.com with ESMTPSA id f17-20020a05600c155100b0040d62f89381sm1962136wmg.35.2024.01.10.03.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:57:55 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next RFC PATCH 1/5] net: phy: move at803x PHY driver to dedicated directory
Date: Wed, 10 Jan 2024 12:57:31 +0100
Message-ID: <20240110115741.17300-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110115741.17300-1-ansuelsmth@gmail.com>
References: <20240110115741.17300-1-ansuelsmth@gmail.com>
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



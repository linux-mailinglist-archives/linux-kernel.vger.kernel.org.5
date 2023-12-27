Return-Path: <linux-kernel+bounces-11929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE5F81EDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5061C223C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19332D623;
	Wed, 27 Dec 2023 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz4kV9yN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26BA24B2A;
	Wed, 27 Dec 2023 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d5ab2f9f1so11430585e9.3;
        Wed, 27 Dec 2023 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703668801; x=1704273601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Unh7AvAJhOG23vCAC0eq7TJOfT6O1MnHdkMG11zksUI=;
        b=Bz4kV9yNYkmPoDJnD+BDNtyO6dbgKopH9JYaOmf7QqrNlTXN6cApf1MxZ1GdBDrIOI
         hySf6sx+CNON8582wuQVRHnu080uoN6jYbNibUZC8fCzXDucOex2wcy1rYSJei6DwAPz
         Lp9sjnIyoeLr2hVAMHIGRd62XJsvaaaaX/XusHmQnVJHB698N7Lf8N4QXd9yXGPpEQYr
         Jj05QqjwlXI4PgA+twUIFvEdOojsgJDi0b66vEInqirMf1IRW7K+3k30Zkf45Mi/f6xY
         i1nX0vsmzxqTqP7nQZbAvM9TWq+v0ieYQ7ujO4x/JrBBvMUYdpAGZaJBMoS0LJWf2aAv
         KGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703668801; x=1704273601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Unh7AvAJhOG23vCAC0eq7TJOfT6O1MnHdkMG11zksUI=;
        b=d3ZXlANSxLUTr2DWr007MAuumUkIYddC/n35JFgcJdyt2oIX2DkJ/J4X/COYtEMyJb
         OrEFoBuvgBrUoZgIdqoqHyxjM4LWAVifVsKlXLoT9BqL2I1QMUGVGdO+u1OgyiZ3iliP
         MIuap0QGUOgi2Lloa28ddUz8dlYg3aFy6u7dJZ2pAMCHzyrHrP3ol9+1wbSkXQK6G9S6
         AcOSSdDYBtft5oHBqMDA3iwkPUCm7jmCZ4IP7pwNCVDLq5+afkUwzAAPk2UGYJ/1E5hW
         id5ECtYO5OY/LtaEX1rGvMOfGZxVgN6DvuzBihuWu8TEPi2LFgVbbvxu+kDcM5tQvZj7
         7u7g==
X-Gm-Message-State: AOJu0YxWXRq7VjzhEAUfQwH6t934jTh4cAd5vo5+2Humn5GdzyapFpfl
	xFlnD8PIhpBVE2zEMj6cHfU=
X-Google-Smtp-Source: AGHT+IFQPxRR3UCUVcUgcgDV45gX6+uDi8r6buIZOQn3uDiZdi8BeGNAMd07eTJOEnjpws/ru7iwXg==
X-Received: by 2002:a05:600c:1d88:b0:40d:5b89:71a5 with SMTP id p8-20020a05600c1d8800b0040d5b8971a5mr607275wms.214.1703668800689;
        Wed, 27 Dec 2023 01:20:00 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05600c354200b0040d5ac00dc6sm4539749wmq.8.2023.12.27.01.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:20:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/3] net: phy: at803x: generalize cdt fault length function
Date: Wed, 27 Dec 2023 10:19:44 +0100
Message-Id: <20231227091946.12937-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227091946.12937-1-ansuelsmth@gmail.com>
References: <20231227091946.12937-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize cable test fault length function since they all base on the
same magic values (already reverse engineered to understand the meaning
of it) to have consistenct values on every PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 0db653b57494..072bcd670ef0 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1259,10 +1259,8 @@ static bool at803x_cdt_fault_length_valid(u16 status)
 	return false;
 }
 
-static int at803x_cdt_fault_length(u16 status)
+static int at803x_cdt_fault_length(int dt)
 {
-	int dt;
-
 	/* According to the datasheet the distance to the fault is
 	 * DELTA_TIME * 0.824 meters.
 	 *
@@ -1278,8 +1276,6 @@ static int at803x_cdt_fault_length(u16 status)
 	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
 	 * datasheet.
 	 */
-	dt = FIELD_GET(AT803X_CDT_STATUS_DELTA_TIME_MASK, status);
-
 	return (dt * 824) / 10;
 }
 
@@ -1332,9 +1328,11 @@ static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 	ethnl_cable_test_result(phydev, ethtool_pair[pair],
 				at803x_cable_test_result_trans(val));
 
-	if (at803x_cdt_fault_length_valid(val))
+	if (at803x_cdt_fault_length_valid(val)) {
+		val = FIELD_GET(AT803X_CDT_STATUS_DELTA_TIME_MASK, val);
 		ethnl_cable_test_fault_length(phydev, ethtool_pair[pair],
 					      at803x_cdt_fault_length(val));
+	}
 
 	return 1;
 }
@@ -2059,7 +2057,8 @@ static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair)
 	if (val < 0)
 		return val;
 
-	return (FIELD_GET(QCA808X_CDT_DIAG_LENGTH, val) * 824) / 10;
+	val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH, val);
+	return at803x_cdt_fault_length(val);
 }
 
 static int qca808x_cable_test_start(struct phy_device *phydev)
-- 
2.40.1



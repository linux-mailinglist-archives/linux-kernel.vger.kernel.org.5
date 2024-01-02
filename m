Return-Path: <linux-kernel+bounces-14456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0959C821D43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CCFB221C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E012E5B;
	Tue,  2 Jan 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS7uY0GR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643A10961;
	Tue,  2 Jan 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso88502835e9.1;
        Tue, 02 Jan 2024 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704204217; x=1704809017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jgtefRyhyrs3KbL6OkxtQpjnArsTGVLXR9LSgz6WQg=;
        b=ZS7uY0GRaybditMsCXYaw3+7xG+3LZHBcUnz9PbpOIuGrnPDf+j77TV80JwLyjFh7f
         rHLzMie/2DSog+CeQydm+USPHRdm3wgFDx7iurlW+BdDnR6xe5JVLgg40YqS+AnttYG/
         WAixcMlL/dj5xZnrpZxawq20Ht/vETs2ZrFWO8kug9FJrcsSkGzwqVnWFhd+lVMyGbpC
         hBp0LZFyR0ieOzKNvR+VxyQEVROmHHkM4RbucVP6GfixuiIIoieqa9JoC1p2WHKPSdZw
         VJgZ8zWprlkjCRCYO2x71+sthkLROh0CJ/iVbTlJt1NlmT3n99nBCcnABoncUfPE3d29
         UFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204217; x=1704809017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jgtefRyhyrs3KbL6OkxtQpjnArsTGVLXR9LSgz6WQg=;
        b=Ewb88ueYTMwCzXWjtnmfYpiVlfWVEa/FFkEVCtGz5IJ1dSFXsA0rnxp8NQEy7S1KSS
         Yvqzg5RdP8estQMNDg1+5OIrFq8U+5vfE/8evvnDHzCvMzPRDMM8e5Hdkp+ZRCoPUf71
         MO673r+fDR9F6xOxjp3aA2cZU//Vj42pgpRRe0xwCQjvg11vdJ1ic2FIHR6xPcaElYuy
         MUB8CFFvY1MzPj8lKzkopML+2MvCXJybRrMUuki5OITlpui8GHgSDGElzUIMAzf1m5Sg
         wbO6lFpoOhaxMa4Ael2bSzNCx4Rpd/ZtS4zZBF39sgeOgp351/RXKpMUGmryoXDDM/PN
         xnvg==
X-Gm-Message-State: AOJu0Yzf5+hHoT+Peb+u94qZjOIEgRI0KFN+CAjqIMioRi79qpy8Okjf
	MLyMOd7OIKvBoEHrN/mIYb4=
X-Google-Smtp-Source: AGHT+IFgEHn+YKNGuGRYr4RqqwtVew/Krk7GA3QnVxoEUpBFgwrc+AUtwFKu8rcbQqnZ6ha8I0KSKA==
X-Received: by 2002:a05:600c:19cb:b0:40d:8638:bf5 with SMTP id u11-20020a05600c19cb00b0040d86380bf5mr1924814wmq.22.1704204216844;
        Tue, 02 Jan 2024 06:03:36 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm28427527wrv.89.2024.01.02.06.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:36 -0800 (PST)
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
Subject: [net-next PATCH v2 1/4] net: phy: at803x: generalize cdt fault length function
Date: Tue,  2 Jan 2024 15:03:25 +0100
Message-ID: <20240102140330.7371-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102140330.7371-1-ansuelsmth@gmail.com>
References: <20240102140330.7371-1-ansuelsmth@gmail.com>
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
2.43.0



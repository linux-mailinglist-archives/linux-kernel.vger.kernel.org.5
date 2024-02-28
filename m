Return-Path: <linux-kernel+bounces-85434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D673E86B5E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8726F282584
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877E15DBA8;
	Wed, 28 Feb 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhZDjZE5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C493FBB8;
	Wed, 28 Feb 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141102; cv=none; b=Lc96hPzwqpKeP51jMI/iXIUBFBX1yneEB43eO0qwKmd+D4PRZit0i9WuozlEsUj/qcWwWTyEiWrisYXc2gSnEAjz/GF+g0//EEHtfqy/2u8vf3TTFRwMgpaWWulA4g2gXvqbKKRZfjf7alL+U9xC79MO4oXYXnWdo7t2sXu0aXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141102; c=relaxed/simple;
	bh=SerkEEOhFHgQhL6B5KOfbJy7Xh/5sx5fpYi4n8/GJlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjCZWulMun5CDX07qFfrkFw3A2sxSNj+4NtaL9tOyX/N4JsTrLNCS5MqmTC9pBOzk7tT6WKkhiJHDo2c7y6PNEkbamHAfc6G2HKPFbKh7SgBzMOHg2lfOgscC7+9g4TwzK8wbItquRW+4tdF79johZf90sEGiyQ+93+AgP+O15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhZDjZE5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1900156a12.1;
        Wed, 28 Feb 2024 09:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141098; x=1709745898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWoavvnvgfbtqyMWs0zbwswYMb/yIFlUZfju4MgDQEE=;
        b=fhZDjZE5mZD1pZ2w994xTSmV5XG3RVbuVNKIiHpbUrAM7RG1sCyg3qjADT50buVWW1
         b4sI2w2juJVKoMFeHYb1QZXcFwNw5JNOXJf9mkKJvM71SWLSDZkOVTAa9zt2BcmnLqLb
         4n1fD04TFAGrAjyTe8dUaGvwI1LzmhOwvE9wkaqqU9HSXaOcsn5m3ZNB018NfbDYkjJV
         3lL9JA3AT32+ZcvNql3qgQxUjVAHTWJnye6I6tjXOEvENQXYooxkE1+aHClZ47mjxsBn
         yl+9x2jY1Jne09isjnUDLcbpJEhHoZiYlgxXrIW5LiO543ttDqk4HMDWTNUCGVhZN/I4
         z0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141098; x=1709745898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWoavvnvgfbtqyMWs0zbwswYMb/yIFlUZfju4MgDQEE=;
        b=qtUlVZRWibP2mIEBR2BDb1xnMwemKng1aGSJiHDEbLpytsJUYdaHBLcRmOeMI2t1S4
         GGi+FUpg2hsTOYK1ZLD0C9hNoT7Q1WRjZy8qDDzR0ziBaPdm+BGJ3heGkRznco3suf2X
         FlXtQbMNsVUIYvxt1LMgtBYQBgKC28d4ttgJUSloZkE8Feff8kXGaqeXeiBhFbGqR+rd
         +dO/2pQqwJp4w7E1PFNyxrgZN2tmMKmX+MyjXzdCsvBJG5dE+rhg6dSoqLAK4VUyrIeO
         nzv1G9Ekz6cY1z7qO+Ok9BNUr4YgBNnm+DojvtRO4v8UEYwwESDE6qbVMMsxs/KcBREA
         3E7g==
X-Forwarded-Encrypted: i=1; AJvYcCUodvC5a0d+UAJrRftQPR4XId7TY0ObZB/F7BEq02ZTM4nViAHXvtgdhskcH+LT185SG5962P/zy2HnsgjIoHCd+cohV3Pmz/obTYMuQMvSDdenIZI9zn1GKg/4TBYpxzxqkJ4B+xxMVRrM02VMJ/4M+zc9fuN0ONidX5UiBCa5yefilA==
X-Gm-Message-State: AOJu0YxgL9xUXux59ifYpqJfvJsmiZvc3mvESG561AhAKpvZTzMwldJj
	28Uz7EW5/Mhc+M1g19KpEWRDaa5+Fio4YiUGxNZSnfHxQdXeQcI6
X-Google-Smtp-Source: AGHT+IEq7Wxav5ms2BNiPKOwcqLL+WWMSE8KJimvmHmiIXpNg7qfmHKAweNyacmj26BjhMDiV+t3Iw==
X-Received: by 2002:a17:906:a399:b0:a3e:5ebf:345c with SMTP id k25-20020a170906a39900b00a3e5ebf345cmr76475ejz.21.1709141098459;
        Wed, 28 Feb 2024 09:24:58 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id ts7-20020a170907c5c700b00a43f4722eaesm926910ejc.103.2024.02.28.09.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:24:57 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next v2 1/2] net: phy: qcom: qca808x: add helper for checking for 1G only model
Date: Wed, 28 Feb 2024 18:24:09 +0100
Message-ID: <20240228172452.2456842-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240228172452.2456842-1-robimarko@gmail.com>
References: <20240228172452.2456842-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 versions of QCA808x, one 2.5G capable and one 1G capable.
Currently, this matter only in the .get_features call however, it will
be required for filling supported interface modes so lets add a helper
that can be reused.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Get rid of the if/else by Russels suggestion

 drivers/net/phy/qcom/qca808x.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 2acf852fb4de..a4c61a8e07c3 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -156,6 +156,17 @@ static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
 	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
 }
 
+static bool qca808x_is_1g_only(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
+	if (ret < 0)
+		return true;
+
+	return !!(QCA808X_PHY_CHIP_TYPE_1G & ret);
+}
+
 static int qca808x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -350,11 +361,7 @@ static int qca808x_get_features(struct phy_device *phydev)
 	 * existed in the bit0 of MMD1.21, we need to remove it manually if
 	 * it is the qca8081 1G chip according to the bit0 of MMD7.0x901d.
 	 */
-	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
-	if (ret < 0)
-		return ret;
-
-	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
+	if (qca808x_is_1g_only(phydev))
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
 
 	return 0;
-- 
2.44.0



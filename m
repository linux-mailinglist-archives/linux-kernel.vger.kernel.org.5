Return-Path: <linux-kernel+bounces-2865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8144816356
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EACE1F21933
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE584AF67;
	Sun, 17 Dec 2023 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kthW37U9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272F49F96;
	Sun, 17 Dec 2023 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so12453675e9.0;
        Sun, 17 Dec 2023 15:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702855522; x=1703460322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRBTxZTtANtJ9sB0koycTxqbtIoU/uRCl3pXfs/ZlB8=;
        b=kthW37U9vBOnQlXbcLTYqKB2QG8mGCNWCEDV2mESYyo0SrSnf5m7cQfKvmRk0Y/Te8
         SIuw43UpfZKCDxn8bgG9XtkpyxR9MIocM3rxANNwq5hfrGge5TIK6MKgiKsa2GnyL1zW
         VoJoyklzqTIHQkvcq1pJi7JDLnlP0UK3cU+91IewfIG6uN93bMYItXqy3vn6S/5Oj8aq
         wOldByANiM//g07Kv+GJ3vVwQbqi0mXKmPFugSmraJM5Du6VAxonMNSE0lJ66aSsHDkt
         3YenE3xyPy1urOAQu0GZ0uDAP4gJasYntjZdAwCuPTYGsq1y1qH/PSg+ku9lNa7CJJHW
         JxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702855522; x=1703460322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRBTxZTtANtJ9sB0koycTxqbtIoU/uRCl3pXfs/ZlB8=;
        b=sElRtguasdv5tjv0GtI2frHPHnd5adBeQncSH83yKFIsR5xW3smkquTF5hz0wFpXth
         CeZhBLSnMgDAzBsP38/AyTvv+aXXjmMDy8M+6qUr44ry1+vf9lGXBnfi3j/y+dvPAhsF
         XI0V79tsSB2/+rtQ8qfIumGwStZ+cMFLuEcH7Hy4bW6FdhHfoPGd4enr4yfjAZkckQLv
         ZVOPKQFja9P/6OmDLxnYYdWDdrWDEKDLJ/v0PRtA/v5czlLfLp8y/ca78xBUyQt91IZP
         k2o0RP6N2wzqEoY0rMDY6uIOfxym9T3C8LC4bG3SW7hUCSbj3kV/2Zv7zkFUPBqDGyy3
         3zkw==
X-Gm-Message-State: AOJu0Yx50VbSoxHOm5bmj7OlEy/XfG9KkDB5NkKNaiJEVD2skn9Qfzy8
	IGu/0Axbn5JHY8JPxH2lF/M=
X-Google-Smtp-Source: AGHT+IFCOgvIxkxEiAqinYd76eGJ+ggDFNgJ+NHiEJlJE75zz11dobDBkfNYlRgWni0fwA2gjOI19w==
X-Received: by 2002:a05:600c:8607:b0:40c:2a2b:4ea with SMTP id ha7-20020a05600c860700b0040c2a2b04eamr7099260wmb.155.1702855521851;
        Sun, 17 Dec 2023 15:25:21 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o16-20020a5d6850000000b0033332df65absm25058949wrw.50.2023.12.17.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:25:21 -0800 (PST)
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
Subject: [net-next PATCH] net: phy: at803x: replace msleep(1) with usleep_range
Date: Mon, 18 Dec 2023 00:25:08 +0100
Message-Id: <20231217232508.26470-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace msleep(1) with usleep_range as suggested by timers-howto guide.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index a7d28848ee93..2b2f0fadaf84 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -916,9 +916,9 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 		at803x_context_save(phydev, &context);
 
 		phy_device_reset(phydev, 1);
-		msleep(1);
+		usleep_range(1000, 2000);
 		phy_device_reset(phydev, 0);
-		msleep(1);
+		usleep_range(1000, 2000);
 
 		at803x_context_restore(phydev, &context);
 
@@ -1733,7 +1733,7 @@ static int qca83xx_resume(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	msleep(1);
+	usleep_range(1000, 2000);
 
 	return 0;
 }
-- 
2.40.1



Return-Path: <linux-kernel+bounces-19286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C86826AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C91C21DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA61427A;
	Mon,  8 Jan 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC6seQ8d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177EC12B98;
	Mon,  8 Jan 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55745901085so1909601a12.0;
        Mon, 08 Jan 2024 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704706729; x=1705311529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twJ7d4uD5NUV+Z7PbyEFQ4ONw+b0/btr7P4BkLMwn+8=;
        b=NC6seQ8dgtbOi/wNnvVIWWAITKqeSla+3XkR3R3wUesSs815+n7Qp+NKWKBR+u87Ud
         m7d85KctBgJyK5mZvn0iM/ugq8b/rpQwg30Jf0+u4o0XLbiKPLJZpEIbZfS3lo6lgUqL
         IgfnD0//Fb/te8oTLxCZ3zhBxPe7AdB86a+uN1bfm7xcqU3ppDYjtWBP9DhY+Z5ZUuCh
         1fcdz5NFXLAyAVaZLdq6jYAF1OmMLSVeJs8bVRjC0bpjkLq2aI+5wGXA1odSMwpG3tko
         P26g1PnffPpAqap6AXi5S2RNdeoxp4nnenx5fk8Uum0DeAyVX+BcFr5btDFmqwNbNI/+
         UJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706729; x=1705311529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twJ7d4uD5NUV+Z7PbyEFQ4ONw+b0/btr7P4BkLMwn+8=;
        b=uQyaSfug6nIROA/HrwvZu7wZV4WDcilmrrFlN/HKlD0l9LDDKWUJXPaOEhYvV9D9Gg
         1AE3qSndMhD2tIY0ro4oaStaPmST9CGT0Z8mRuOSmBVZ5+yCD8Mvw7DABGPI/K+LwrBe
         KUbpHVTCkNHuivdNLG9I1oKPLZipn6CGmTTeB9l8/HHWBJDdijobEylLD4pgxZ9Ulb7E
         7p77u8OAgrw17ny6oxPFK7tBTlyFF0JTrlwFzk7knPWDVKEsb8o9FOKHtF/cOKZ2LV8d
         pNFtz1khRBKbx2aiOlovVM32s/M8Rv0t6ma3bqO+DTmEIRP79xYC3KltP4mdx245meiy
         13uA==
X-Gm-Message-State: AOJu0YwLC+TcvfNdqm4dqHBq1/bVEMEzYS6xVoRstOWbDC9f3gGrDULd
	IszJqoeQHHMxLRcga1UBQuY=
X-Google-Smtp-Source: AGHT+IGty6bxts11L4BflPKbvRLKr8SA0sRUXZWzjcehALNT5ay1IESrxGgUl7Cd9BzleunXta4/5w==
X-Received: by 2002:a17:907:c82:b0:a2a:da74:dd38 with SMTP id gi2-20020a1709070c8200b00a2ada74dd38mr266499ejc.117.1704706729257;
        Mon, 08 Jan 2024 01:38:49 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b00a2ae71cee2asm326851eja.177.2024.01.08.01.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:38:48 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 3/5] net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
Date: Mon,  8 Jan 2024 10:36:58 +0100
Message-Id: <20240108093702.13476-4-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108093702.13476-1-dima.fedrau@gmail.com>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set 100BT1 and 1000BT1 linkmode advertisement bits to adv_l_mask to
enable detection.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy-c45.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 747d14bf152c..de8f5dc8be12 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -208,7 +208,8 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
 
 	adv_l_mask = MDIO_AN_T1_ADV_L_FORCE_MS | MDIO_AN_T1_ADV_L_PAUSE_CAP |
 		MDIO_AN_T1_ADV_L_PAUSE_ASYM;
-	adv_m_mask = MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
+	adv_m_mask = MDIO_AN_T1_ADV_M_1000BT1 | MDIO_AN_T1_ADV_M_100BT1 |
+		MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
 
 	switch (phydev->master_slave_set) {
 	case MASTER_SLAVE_CFG_MASTER_FORCE:
-- 
2.39.2



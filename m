Return-Path: <linux-kernel+bounces-15532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B8822D70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05CE1C23476
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E3199A2;
	Wed,  3 Jan 2024 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QekCfjTI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A619442;
	Wed,  3 Jan 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d894764e7so22499105e9.1;
        Wed, 03 Jan 2024 04:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286010; x=1704890810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mndGvtpI2oeo6GQDcXQC8VQnYdadwT7o6axDFA5/9kY=;
        b=QekCfjTIL8QQj5Qe+8uR6eAWOlRqBAcLned5f27TgXvSPU32Qo6lLGnCtOUK94vYJH
         d6ZlCDduT6KD+TxB6ZQNQSLxDxHy3vCYKvGdtwF6T6hY5l8qfO56QBluN6VHDhktGt6b
         /E0aEGL9lq0RvyJPZr6N2N1wX4x2Y8GYU99Ls/Bn+qNTCpj0SYS3BoUbSPEtJGMukjMV
         j97s83+cSQALXLTEi/bfvf0Fl+NAfGqYvm/Jk6F6AeKcY8QoT26lWQLF8DSVZXzOURsu
         wE28t5Q4amt8Uj2m6icv05dYBC7jX6mhDwp/jC3ydF1YPf9IM59mVtHMhR+0dUh/22mK
         oZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286010; x=1704890810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mndGvtpI2oeo6GQDcXQC8VQnYdadwT7o6axDFA5/9kY=;
        b=dAO+moEnP2fHxB0OJLWnGKqwJ2wJaQkuMJmUfxMp1IigxAUnc01wGDlOs9RWNhW4GX
         5z726PqhtBIOyC0TP7cy7aQovD55RupynsnlCVBh5nlntEg+TnDAWqwxo/svRK0bLU2R
         sDYy0Hzb7SUUkcVYJRVcMihllht0qB0PZTccNPLUMFqqCWHLZm9ieLHjf5Y1e4t2QsZI
         UYueXs96o3AlzzRfKZ6OBeDbdE/MODQnSikgaflxpBBxQUlIN1NaE2/j4TiGb9f7YfTU
         KyKlxWgtv2ZrK2NtU8bsCkqLgkP6pil1+JEjVNpM/dVWn8FO1+Jce92JGkAJ1K0huLR8
         v7qg==
X-Gm-Message-State: AOJu0YzYsHHg6HU/wS2Q0rIxlTvT1fIqploikDZoCQEPidZDYC/Lw+Hu
	P5x6mouY33taXQn0hPZxX0g=
X-Google-Smtp-Source: AGHT+IGp2MrNzRY01sihvbJWIm3HjemQ8W8vu82Brf0FhPLaENaKlgHggNj427GoV3Ybg3qDuDgqzQ==
X-Received: by 2002:a05:600c:1c11:b0:40d:88fd:e1 with SMTP id j17-20020a05600c1c1100b0040d88fd00e1mr1453451wms.24.1704286010370;
        Wed, 03 Jan 2024 04:46:50 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id fc16-20020a05600c525000b0040d5c58c41dsm2219676wmb.24.2024.01.03.04.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:46:49 -0800 (PST)
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
Subject: [net-next PATCH v3 1/4] net: phy: at803x: generalize cdt fault length function
Date: Wed,  3 Jan 2024 13:46:32 +0100
Message-ID: <20240103124637.3078-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103124637.3078-1-ansuelsmth@gmail.com>
References: <20240103124637.3078-1-ansuelsmth@gmail.com>
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
index aaf6c654aaed..acf483fa0887 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1192,10 +1192,8 @@ static bool at803x_cdt_fault_length_valid(u16 status)
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
@@ -1211,8 +1209,6 @@ static int at803x_cdt_fault_length(u16 status)
 	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
 	 * datasheet.
 	 */
-	dt = FIELD_GET(AT803X_CDT_STATUS_DELTA_TIME_MASK, status);
-
 	return (dt * 824) / 10;
 }
 
@@ -1265,9 +1261,11 @@ static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
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
@@ -1994,7 +1992,8 @@ static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair)
 	if (val < 0)
 		return val;
 
-	return (FIELD_GET(QCA808X_CDT_DIAG_LENGTH, val) * 824) / 10;
+	val = FIELD_GET(QCA808X_CDT_DIAG_LENGTH, val);
+	return at803x_cdt_fault_length(val);
 }
 
 static int qca808x_cable_test_start(struct phy_device *phydev)
-- 
2.43.0



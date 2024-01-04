Return-Path: <linux-kernel+bounces-17243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34B824A56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD20B1F2311E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A92C86C;
	Thu,  4 Jan 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU48WKG9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455772C69C;
	Thu,  4 Jan 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d60ad5f0bso10522015e9.0;
        Thu, 04 Jan 2024 13:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704403866; x=1705008666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FUG0RjbzXaQnEDKhMBI3aguQZ4xhkiJthc0BKthtiw=;
        b=lU48WKG9tmhG8ib74GNaWRRkUIrcaXLKfKy8E3qLtBF3nEpmVROt7gbjG/nggozL5n
         KQo6utlgo+56UxjD7j6taYbKxdZZuOZ4CS+oqS6Zsiup5VhuluFdDOTAQBJjyY8CIKAC
         F/PC9s4B/HeI78geA/v4gfrg33X8EUX/LApRplMFF8cPx9AfqRYz7OYB2oyov2GlbGwD
         Wy1ynu1F3aqcYWcBhg6KH+u0Sz+8yAq7f9NEjG9iD8KlOsRhaCo7/KFmIlcXFubFQhqf
         L/0t4JE71HtPf5bXMPpxQRe7/Gn9Ws8AX+2Qbm6GTij6LbT4AY+rlJ+NbjmV4Tf4YKYE
         L+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403866; x=1705008666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FUG0RjbzXaQnEDKhMBI3aguQZ4xhkiJthc0BKthtiw=;
        b=dU21GsIgGeolJeu+8EZ3w7+aYtauHQnteIpSPMZMQsIJp9KfonRXUDab4lMcVJLqnM
         0KCQaUX7SqME1t0uNODXqXIIxjHmkh4+k9E2yvS8gXk7ARe53fztKIiXHMO0JVbb8OqK
         JhJya8vmmNP+It4rYEg2dyCGBC1r6fkIl4RXtP9qnsII1uCcYfhE1zQlK/4PG6bcBJ8X
         uniAxrpz61yNVEpzlGLb6SUUtRmHEwkd9qsVpGeQ+kryub9WG1H1rDjLQ2mqzJAlToRj
         IEurBD/+HgPz/4TRIjcN1wbib4eiEy23QVtAvmAdXb/dp7TvZd/keTqwJCNM7LA/2/XK
         aZgg==
X-Gm-Message-State: AOJu0Yz5r/4grmjsCH8n33+oJF3SXEMg2pgRduu0kLUoJIB1A6bdfdm0
	nPr24AEX4yZHaAGW4g3JiPo=
X-Google-Smtp-Source: AGHT+IHdkLhGfVdMmD5nIOhDmg4/JTgNzYrwAegOCmLzY7Tc3NRUdfUXwSxAe48Evbz5vDSQgKHwDg==
X-Received: by 2002:a05:600c:1c09:b0:40e:353c:8a1b with SMTP id j9-20020a05600c1c0900b0040e353c8a1bmr596255wms.91.1704403866102;
        Thu, 04 Jan 2024 13:31:06 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id f14-20020a05600c4e8e00b0040d3dc78003sm407291wmq.17.2024.01.04.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:31:05 -0800 (PST)
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
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [net-next PATCH v4 1/4] net: phy: at803x: generalize cdt fault length function
Date: Thu,  4 Jan 2024 22:30:38 +0100
Message-ID: <20240104213044.4653-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104213044.4653-1-ansuelsmth@gmail.com>
References: <20240104213044.4653-1-ansuelsmth@gmail.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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



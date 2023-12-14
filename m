Return-Path: <linux-kernel+bounces-200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF29813D64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795A1B21AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9E6DD1B;
	Thu, 14 Dec 2023 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC43kL+R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F05697B1;
	Thu, 14 Dec 2023 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so452265e9.3;
        Thu, 14 Dec 2023 14:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702593514; x=1703198314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PysnZlgIi6LjarqurpvkD4iKyhD/xp2NGOBU17rT3Ak=;
        b=mC43kL+R6/vOPT2+r3M1kYbBsmolENg9LKxhrlVoDjkD2lSAyYjs+e2W8Uz6/6mSg4
         X2tzOGUKENoqO88cQyrF3YamzVddHpgAwC3chAdzAB9+KBkUrOmgorZApj/zJk21c10F
         MTk4dPkPSdv5ROWd9/KNjm9bGFyLQox8MeHhg4BWCMsszhXPEHta0RyTlOawumOqmF8g
         kfjEdE94yIV2VOXxFyhFJTkG7QGxPFNCGwyg7s/LPv/2sMuMo3FGzGdZrf2yHqu4TE0d
         1hkKfONvLevHe1Qy804euegk3RC1x9/Njm8mYk69hJoVrP5jJ8j0kP9NNi8x9JpOSigO
         GJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593514; x=1703198314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PysnZlgIi6LjarqurpvkD4iKyhD/xp2NGOBU17rT3Ak=;
        b=OOSUIa2JplBU2xETzN97Slgf13e9UtH+Y08Kt+7p0EkYYbRloN743vSCgVLXFH/X2L
         LrRFi+LGQZvVBW6IWSrC8eBQ8qrrXrJGvoQtlEFM/4f/0191kfvJmFt+TCZQ5t1jCsNG
         NrQUwHtqTUVjAeKThdk7/wqDKSAv8GiGmPm3nSMhe4/xMadOgctdgrt42HXtXP0TGQ6u
         9vV4yC7t5GiuV1hhHrM1uRj9TdwyGvJmvxz6zTJmJaYO8hiutyPjmJdtNHieR9LzxxzK
         knGGsgE2PmRq0Oe/BFz2DzYqox03x4lz3+7anCQm8hgX4sStINYF8rvI09pIuiZK6v4C
         EW+A==
X-Gm-Message-State: AOJu0YzQcvxGMlqcXsj+EV7hqL3FLG5QvWgER2cGoYc5Th98PZXBblqN
	NrCWbmzq3TkEubtz0rvSznA=
X-Google-Smtp-Source: AGHT+IFV2KaagGU1wW7ISYptzkLofZaljoiSAiIvtj99QDgqaxvKjZKYXi3Jl8j1bIqqqGijl6cvGw==
X-Received: by 2002:a05:600c:2113:b0:40b:26f1:57a2 with SMTP id u19-20020a05600c211300b0040b26f157a2mr5276018wml.27.1702593513815;
        Thu, 14 Dec 2023 14:38:33 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id n41-20020a05600c3ba900b0040c61ee0816sm54746wms.0.2023.12.14.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:38:33 -0800 (PST)
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
Subject: [net-next PATCH v2 1/3] net: phy: refactor and better document phy_speeds function
Date: Thu, 14 Dec 2023 16:49:04 +0100
Message-Id: <20231214154906.29436-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214154906.29436-1-ansuelsmth@gmail.com>
References: <20231214154906.29436-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the phy_speeds function to be more readable and understandable
and add some documentation on it.

While on it extend it to take NULL speeds values to make it return only
the count of speed modes in the passed mask.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy-core.c | 50 ++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..9618d89458d1 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -317,17 +317,57 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
 }
 EXPORT_SYMBOL_GPL(phy_lookup_setting);
 
+/**
+ * phy_speeds - return all speeds in mask
+ * @speeds: pointer to array where to put the speed modes
+ * @size: size of array where to put the speed modes
+ * @mask: mask of speed modes to compare with
+ *
+ * Take mask, test bit in mask with the settings table and compose the
+ * speeds array based on that as many as size permits.
+ *
+ * With speeds NULL, only the number of detected modes is returned and
+ * no array is composed. (size value is ignored)
+ *
+ * Return the number of detected modes in mask.
+ */
 size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask)
 {
+	unsigned int curr_speed;
 	size_t count;
 	int i;
 
-	for (i = 0, count = 0; i < ARRAY_SIZE(settings) && count < size; i++)
-		if (settings[i].bit < __ETHTOOL_LINK_MODE_MASK_NBITS &&
-		    test_bit(settings[i].bit, mask) &&
-		    (count == 0 || speeds[count - 1] != settings[i].speed))
-			speeds[count++] = settings[i].speed;
+	for (i = 0, count = 0; i < ARRAY_SIZE(settings); i++) {
+		/* Inconsistent mapping with ethtool modes? */
+		if (unlikely(settings[i].bit >= __ETHTOOL_LINK_MODE_MASK_NBITS))
+			return count;
+
+		/* Skip. Speed not in provided mask */
+		if (!test_bit(settings[i].bit, mask))
+			continue;
+
+		/* settings struct is set in descending order with
+		 * ordered speed modes. Detect a new speed mode by
+		 * checking if it's different than the current one.
+		 */
+		if (count == 0 || curr_speed != settings[i].speed) {
+			curr_speed = settings[i].speed;
+
+			/* With speeds not declared, we return only
+			 * the number of detected speed mode in the mask.
+			 */
+			if (speeds) {
+				/* No more space to put new modes */
+				if (count > size)
+					return count;
+
+				speeds[count] = curr_speed;
+			}
+
+			count++;
+		}
+	}
 
 	return count;
 }
-- 
2.40.1



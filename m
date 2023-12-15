Return-Path: <linux-kernel+bounces-1016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C9C814940
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8D31C228F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AB2F86C;
	Fri, 15 Dec 2023 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+XyXPKE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06912DB6F;
	Fri, 15 Dec 2023 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so6341655e9.1;
        Fri, 15 Dec 2023 05:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646979; x=1703251779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PysnZlgIi6LjarqurpvkD4iKyhD/xp2NGOBU17rT3Ak=;
        b=f+XyXPKEHed92YcUkw7rdBKvMZQjwTFLD+uLy3V81/9sByL4hsZA4M3RxzbtduEqMw
         XKwB2S8PxYPgcwnHLfA+ACm5MfPoSBFGqdTCaD1dn9TuH/XG+aDNp/G0oGZLUP091k0X
         QpjPHH97pZ0LBHIOD6iiI14RXGzUpbKSfzYzAf72AVeWW3CpEahXuIouCT0jToXPIQzE
         AaRGkAtwzxXTvl4ptzqiSUXKiuxftnrx2ancCnasJTOqVqIHUC9NwoKXblKCjO2LO13A
         m+2saBF3f2pPT4kuUZowq16zC2jqZSMMgLcWbF1VYfSBzYBlnI5T/G52PduMGMqj/1SP
         tQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646979; x=1703251779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PysnZlgIi6LjarqurpvkD4iKyhD/xp2NGOBU17rT3Ak=;
        b=jWSx+aWyXXfNnpvx0AZpngqC2yhHPc83gVygJ3fLH5YBgjw4Z/SHUrHGCslCeRk6P1
         rYUh3wH6DksUv0cRskl7+Z9/XGAYN37Uf84LA/yDu3BcV6imOa+cYKcxvINomGb4H2l7
         UMZuvyL5yFA4d1+760Wdm4g9B2tsJyj0K/QDuntv5IRUwSvGqGTL4XvwXh9ibf8upVA0
         zSnr6t52XbmRL8MB4dCWRF8w7oKMlst5XcRsTfK98bUK/oCoY6c3Bayskmzq4czJf1Hc
         ntg17AxoL2hCFsfhigJsq3AfJ0qCgxXy+zr+ksAK3Dw7L23anYtDGWxZW3+9DoszZZ4h
         MmPA==
X-Gm-Message-State: AOJu0YxlmEb258lyd3QxyGur5sHRJ1yI1DmtADMx53JentGp3dihhuyl
	dqY1Qn7nDlZNH7cI1gHK/cY=
X-Google-Smtp-Source: AGHT+IHwzMQhP+p6yheC8TD57MyNbOkMYmEIJs3Yc9nCVHsem6o6YIG11zan7g/+s2kpVNEBx75ANw==
X-Received: by 2002:a05:600c:3b9f:b0:40c:2878:35ec with SMTP id n31-20020a05600c3b9f00b0040c287835ecmr6193489wms.131.1702646978947;
        Fri, 15 Dec 2023 05:29:38 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o3-20020a05600c4fc300b004042dbb8925sm31434543wmq.38.2023.12.15.05.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:29:38 -0800 (PST)
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
Subject: [net-next PATCH v3 1/3] net: phy: refactor and better document phy_speeds function
Date: Fri, 15 Dec 2023 14:29:19 +0100
Message-Id: <20231215132921.16808-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215132921.16808-1-ansuelsmth@gmail.com>
References: <20231215132921.16808-1-ansuelsmth@gmail.com>
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



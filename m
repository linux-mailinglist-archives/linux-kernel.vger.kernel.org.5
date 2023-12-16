Return-Path: <linux-kernel+bounces-2243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD7815A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E4EB21890
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252431580;
	Sat, 16 Dec 2023 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNJH/GEd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF330646;
	Sat, 16 Dec 2023 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so18813905e9.1;
        Sat, 16 Dec 2023 08:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702743134; x=1703347934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCjqm7RfhFeKXkonYo6dSLfvs7PV8vamdp/VJ5ZVACE=;
        b=TNJH/GEd2VoRbgEdcgG1OZYsvDyq+Pw74SZaorSLxpXww4hqBAHO7UagdEOFEdXZY2
         L9krvocd6yxJGx0EqCYem5Q2ZP7EiFooDZ8m8HqkFTBstgAk+DPZ9PaGtV2NcvW+0CvF
         0DKdyUlaChUTcF3cvqfu2Wdo//nwFFfJcg2Ot9kEyvNRxhpU2RL2uMjoQ7Cpb6w5M6Np
         6Df0wtel8eUHZxeXq/EqS6wes1kcmkE1PGEgIyI2UPnerQq0a00EPJDupCOtkEphTfmg
         l7cI8JDbQGaHuBn1sCEx6uktFlylIctaTXO+os43C9uVRfBVah/ZpaFKJqZRykkI/G45
         qatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702743134; x=1703347934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCjqm7RfhFeKXkonYo6dSLfvs7PV8vamdp/VJ5ZVACE=;
        b=Iqo0iDUllqhHez9fIRBpxVLTA04xFNr4dL2Pql+tC6HfQ/Ta1LIyW6eNHIxOYkC3V4
         HSvd1LpwtbK37WJvhrdY3AjzRDBFmWYCFl7ow3r/2ZyKy8h1+Oy7r4vGBL9tff9JgXs5
         NVryJnXxKrMfIsFP5YYTUYdzhe8zHY/gNN3y909h9FHSvq41Nfwo00KkvvwgASs7qiuU
         TxrI+hQYoH9x4zXTkwlBGoR2YyXlbG8KcuhLrk0/VBxwgazpW9G1WSpfb9q5BMHwoSYd
         0DDIG5cWmkaARJd38H7rgmikxm9te0FEUgSXWECcHxc1D6p38v6bYRu+1KC26gP3gP/n
         XCCA==
X-Gm-Message-State: AOJu0Yz/pIJwkdBIqqhn1eLbT77IhhucdhyWfI6suZmEcagmWrLxwMJP
	dvEa/o7PeFQuwc+xvFaylDo=
X-Google-Smtp-Source: AGHT+IFbKzoSnlr83q8OVyknj1B3OnTkB3mec+uQYFrlXhfwIVZ7oX0oP0tiA/66h2gLbabFWEWLRA==
X-Received: by 2002:a7b:ca54:0:b0:40c:2db0:c803 with SMTP id m20-20020a7bca54000000b0040c2db0c803mr3467156wml.92.1702743134091;
        Sat, 16 Dec 2023 08:12:14 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0040c3953cda5sm30818925wmo.45.2023.12.16.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:12:13 -0800 (PST)
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
Subject: [net-next PATCH v4 2/3] net: phy: add simple helper to return count of supported speeds
Date: Sat, 16 Dec 2023 17:12:05 +0100
Message-Id: <20231216161206.1729-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231216161206.1729-1-ansuelsmth@gmail.com>
References: <20231216161206.1729-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple helper to return count of supported speeds for the passed PHY
device.

This can be useful to know the number of speed modes to dynamically
allocate a speed array for it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy.c | 12 ++++++++++++
 include/linux/phy.h   |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a5fa077650e8..3e579dd8a5e7 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -229,6 +229,18 @@ phy_find_valid(int speed, int duplex, unsigned long *supported)
 	return phy_lookup_setting(speed, duplex, supported, false);
 }
 
+/**
+ * phy_supported_speeds_num - return the number of all speeds currently
+ *			      supported by a phy device
+ * @phy: The phy device to return supported speeds of.
+ *
+ * Returns: the number of supported speeds.
+ */
+unsigned int phy_supported_speeds_num(struct phy_device *phy)
+{
+	return phy_speeds(NULL, 0, phy->supported);
+}
+
 /**
  * phy_supported_speeds - return all speeds currently supported by a phy device
  * @phy: The phy device to return supported speeds of.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3cc52826f18e..52aa415fab0f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -202,6 +202,8 @@ static inline void phy_interface_set_rgmii(unsigned long *intf)
 	__set_bit(PHY_INTERFACE_MODE_RGMII_TXID, intf);
 }
 
+unsigned int phy_supported_speeds_num(struct phy_device *phy);
+
 /*
  * phy_supported_speeds - return all speeds currently supported by a PHY device
  */
-- 
2.40.1



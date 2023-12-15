Return-Path: <linux-kernel+bounces-1017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7991D814942
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AF61F23887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB7A30359;
	Fri, 15 Dec 2023 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irkew6or"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF902DF96;
	Fri, 15 Dec 2023 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso6202995e9.3;
        Fri, 15 Dec 2023 05:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646980; x=1703251780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YCHaxtRcxT8du8yPrhEwLJqy0r1nUHAjMwSdxshw+8=;
        b=Irkew6oravPVZnWKaGdknrLuBoeKehAeHPkABS8iUurJCwwcC28CNzf62OZrg1lR6a
         BcLIO2fP2VfEV7v8P6cKsd+FoJT9TqHyEbT/XOLIxbKkrWDoabU9uUkONqZZMRm6UOir
         vPQ/qQJS3+QJSp9M+erTBzDoVGzcaqNaYg6qaU5H4oneTrE4NsnvBkGOTBOmiYwRV5YZ
         Q3rlGUDNRzeA86LEIR4PKg+WHfPPBrLo6DwJguozy9rFy96PIBH3FWlWEfHx21dqeKQ/
         mM3wT9s4km6VZWoM9Pky46JsYtzaz2aoI8rWOwwTCsBhKYSitupJVicIr59kJKPfs9q1
         sq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646980; x=1703251780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YCHaxtRcxT8du8yPrhEwLJqy0r1nUHAjMwSdxshw+8=;
        b=YQpr5VXe88WQ3p2GDvEJEwzjsBWrZWEkJ8SPxAjYSy9YbdrnTjkYIJ6oobecV+VLMa
         w7gAf8h/N1MoLmoaT5FeCZeP8IE3OcN6Ocw/aB6FIt1Z126VKBNgkOCZhuADA1IJZ5aP
         AY4Fan74Sk+MWPfufavUr4kj9MFIy7HYwf52LJXCY1zfJYx4sR1fJIVWk07vAnT7yLzx
         h9vGqfgYi6aITGwAonKJVFJPucEMrJhcviu6KjDSatLkCNXOGcWud+GS3mQzX8vGRaA1
         bYFlAf1fFG2MEpqjbORNMqJrOZSsikVvUoZKmhrr2FboMIBdc3FggIkMn42zAayWnE5G
         Ejvw==
X-Gm-Message-State: AOJu0Ywg44beQoa8zPqjKK4ejRf9n7dVhFOa9AaKyv40i5lwzgc457oV
	SKTeg6QyhbKQWWrKMiYhAEA=
X-Google-Smtp-Source: AGHT+IFdLMlbkblDWfGCsJsyUGD30aw5/6gZXrrQgfEphl2iTaK028grB+SV0+plGdoNz83cNyCahw==
X-Received: by 2002:a05:600c:4981:b0:402:f55c:faee with SMTP id h1-20020a05600c498100b00402f55cfaeemr6380105wmp.26.1702646980096;
        Fri, 15 Dec 2023 05:29:40 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o3-20020a05600c4fc300b004042dbb8925sm31434543wmq.38.2023.12.15.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:29:39 -0800 (PST)
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
Subject: [net-next PATCH v3 2/3] net: phy: add simple helper to return count of supported speeds
Date: Fri, 15 Dec 2023 14:29:20 +0100
Message-Id: <20231215132921.16808-3-ansuelsmth@gmail.com>
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
index a5fa077650e8..311560e72126 100644
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
+ * Description: Returns the number of supported speeds.
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



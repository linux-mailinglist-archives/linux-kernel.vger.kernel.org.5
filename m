Return-Path: <linux-kernel+bounces-201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2327D813D65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558461C21DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FEE6E2C5;
	Thu, 14 Dec 2023 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw+DbNAB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C36ABBE;
	Thu, 14 Dec 2023 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c4846847eso628875e9.1;
        Thu, 14 Dec 2023 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702593515; x=1703198315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAtxuDG+IL4Il9JbZckuESTLJk29St8uyddTrttAR4I=;
        b=Zw+DbNABx8tUDhlvJpomxoamS1mGVUIcJBj6vD0+Y96eMfFml5U8Zc/JMYInK9Am+Z
         uzTI+8RNEagCrGS8Hu75yRhyFgi5ykTHuDHpqob3FrVlKlvcaLaIhWZWLVm6ytdt0LkN
         pLceZxKRHp0Etjo5NKMbgcwmdttx1cqZkL6aDnE9e+Re29+2QAMa5ebdWDxAiQxKrAxZ
         HZJnUTRADL+9q63Wzt5ltxuwu5j+w2afy9KTc6qBDTcQM1MQOvkUAR8VGxoRcYq9OMDs
         d7n/mgZzRviiQYO7xbuTTxuQMnR0cwiPni9K2rR4wVG5clCgQeq8SBUpJOLsCnsKL0B8
         lzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593515; x=1703198315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAtxuDG+IL4Il9JbZckuESTLJk29St8uyddTrttAR4I=;
        b=ut5SwidPbSzZV7a5xbN5uQKGZ1aLYn4+rAa5f8/IJS8l9MRGP537wmkCuxMf41xibp
         gHQ7AH2/4VcCwCDW3ZaMbXLQ5FrPGyGZUy4U0MHb+vve9O2uak68KlzaAjFa0GUDaFmx
         xrzXxjbh5euXnL10ePjTnoQQPbmPjEccV5rpxKdZWpuP5BdFQspkqpU4fbV+8qLSTiBf
         9UWAFK/cby+7geT3NCAtDeUF/gC1VeUJPOpWkehEV22gjp2Z5UrKH/GkuENINKob+e7U
         9PlDj6rRKepSMUSlpdwStAE3FBuxmrEuzAMf7V5Mh4xsiMRhdY7LBL9IRxiSOf4v9HdS
         PjaA==
X-Gm-Message-State: AOJu0YxwCiWGTkuxVINA8hpiAW3/UOYmEfMsQwAf/NV/STM9qegfdzpo
	st9epVjbFuU9G3UgyEKqNDk=
X-Google-Smtp-Source: AGHT+IHQl3pxHevUmfp6kHEmhaZRbuXMDgjbkh4bUsDdS50zDxRkmuH368J9uW+vW2HuJIb3LzmVAg==
X-Received: by 2002:a05:600c:1705:b0:40c:315e:9ec3 with SMTP id c5-20020a05600c170500b0040c315e9ec3mr5030141wmn.65.1702593515012;
        Thu, 14 Dec 2023 14:38:35 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id n41-20020a05600c3ba900b0040c61ee0816sm54746wms.0.2023.12.14.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:38:34 -0800 (PST)
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
Subject: [net-next PATCH v2 2/3] net: phy: add simple helper to return count of supported speeds
Date: Thu, 14 Dec 2023 16:49:05 +0100
Message-Id: <20231214154906.29436-3-ansuelsmth@gmail.com>
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

Add simple helper to return count of supported speeds for the passed PHY
device.

This can be useful to know the number of speed modes to dynamically
allocate a speed array for it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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
-- 
2.40.1



Return-Path: <linux-kernel+bounces-2866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBE8816359
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857211F21AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAB74AF67;
	Sun, 17 Dec 2023 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1X4Cfu+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B71E4BD;
	Sun, 17 Dec 2023 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso30343545e9.0;
        Sun, 17 Dec 2023 15:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702855676; x=1703460476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkbI6A9Sqf7H+P/UxJunivUOk5IL5BsTR21DLeW7YFU=;
        b=O1X4Cfu+XR/6icYAXJhfDOP/OEnO4erm+/bbSPj3eM30HkAOxERU+tRaff+Bry7i9q
         tXhZ3ugp/blYcOI9IVWTt0lF5gANKEQ5+js+w2QtmSotY0WfTdnA+Z4TYSXYtdUurChV
         ZAjlqS8aTf2grB4nWxHmscoKuWyQa3X5Xrzk4v8Kwi+UuGy5NDuNFb0Qt6mNJ9RKRiMq
         g2i9LU7iOfP3QthTZ/8RmMRtbl7GcQ073j4aoITauyWeA5ipVk9EeIbrVAhWmLg2t/VG
         KKhKNO2FHhPfoiNKQoBZvitXIba3Jm/UFfjfZU12gA89pr5suo4Ru/JTfkkrRfyHIqqR
         NE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702855676; x=1703460476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkbI6A9Sqf7H+P/UxJunivUOk5IL5BsTR21DLeW7YFU=;
        b=eJI7E/NCqwKN3tl6WiNDBU/8UOLu9osNhYaYYI+HvfiLy4ehr8gRxSOxa4EzF4jsY1
         ClTyThO2zasnqjGRloS8UmzAss3xfXCIqgciI2n9mfoV1YBg/kMKw5CNQOsPoqHk8mGb
         YTPpFEe0937QhvrhS+xsPB2DV2ZJ87Ly2AcgQ1wubaPz6NO9klSHrHUdmPXz9/Vo/n6z
         nghSc0YC3FpcPLnsfPn6bUjzpn0geD1BUGKwsgfA7J+grVuR48TQwWFHB3U4OBCMBBMN
         mAZgMLxLqRCPMVfkkaPr3AyAot3XWDGq50AqWoQSjxgvmfru0F2ndJU8XGR08KwyQzje
         9Q3w==
X-Gm-Message-State: AOJu0Yw1mRS0kreow1lUOkjqliZUO42aLbyCkoO2OWMyxLIxricoalDS
	uZgtm8txTZ5QJICMZcUvE+g=
X-Google-Smtp-Source: AGHT+IH3Y2UcHX7ritpWtTbdsAUuLDYO8Xs6sPH3ARET+harWvq/j1U0shK9i7wir3U0v2jndbfRbA==
X-Received: by 2002:a05:600c:ad5:b0:40c:6593:627e with SMTP id c21-20020a05600c0ad500b0040c6593627emr3285935wmr.161.1702855676509;
        Sun, 17 Dec 2023 15:27:56 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q7-20020a7bce87000000b0040b2ab2b352sm4103706wmj.1.2023.12.17.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:27:56 -0800 (PST)
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
Subject: [net-next PATCH] net: phy: at803x: remove extra space after cast
Date: Mon, 18 Dec 2023 00:27:39 +0100
Message-Id: <20231217232739.27065-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove extra space after cast as reported by checkpatch to keep code
clean.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 2b2f0fadaf84..d5dc927618ab 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -462,7 +462,7 @@ static int at803x_set_wol(struct phy_device *phydev,
 		if (!ndev)
 			return -ENODEV;
 
-		mac = (const u8 *) ndev->dev_addr;
+		mac = (const u8 *)ndev->dev_addr;
 
 		if (!is_valid_ether_addr(mac))
 			return -EINVAL;
-- 
2.40.1



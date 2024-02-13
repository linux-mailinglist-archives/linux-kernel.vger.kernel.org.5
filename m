Return-Path: <linux-kernel+bounces-63433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D4852F26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B021F22149
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690A853810;
	Tue, 13 Feb 2024 11:21:59 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1675338F;
	Tue, 13 Feb 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823318; cv=none; b=NHRrMY3Wxu/36HKr7iozGwqW4pgxNcdQw0M6EkG4BK0io5Qy4gFrFBWIxmb32C7WbEMFbybBDU/VE1ECd0JTUaHM0sUo8ZEeMtKptrI7BfUSnAyAMPn79d3Z7l0vtgiK16ckMx+kxbU3Ktn/FPxlw4P6TaphsxbF6QilWlAjwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823318; c=relaxed/simple;
	bh=j3qKprD+fMsQhXp7tEeiTdybA6mXfyPsjc+jB0nL/M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kO4qJIT17sakWutguvo4WTabwyoAKNvsFtlxa/dfHPBj4IZoeaacp+oblxKpYSsUX/yvWMFiYht0OHM7QhDR87sEfVEkhkVKd/PYgkYCWRuftxF7avA6Yus5GMHEbMUcnEqu7mMq+qjvDunQ+rPmS5hq0ocx41EDsXjBLRe+/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1163829a12.3;
        Tue, 13 Feb 2024 03:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823315; x=1708428115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yhx/bVRufzZxSAFHgLOiIo43Fsj0F9aHAkrryCfBPhk=;
        b=UJzKSVov75XwvDMMKgkO+9M0hkVY0e5u1+395N/GPrfVAnFq/pL3MpYUvjV0Qpt/Vx
         JyBlIxq3q9o+ieknxXQe81tRM3A7AFPXRHXMXsHP8urE4u2AJEh1p87VrHeLChlLffwg
         EHxvNaxPYgyQTlaTE1d5N3FcmL9pHGqib8DqWj/rxRzV4kv3A8XHzgJWNpUgRqulFU0s
         EoT8X6wdnO6KhWNII6ArL1l7AMDvD032SvKptsTlV8S+CanZGbXafXrVtz2oSAdrpUvB
         p1F1ATAVaCeu29ruqFeBIECYrcmqe5kIHFl3og+wYj0XH/WvblAqyuFBfkMqWXAn8ukd
         fabQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlgZMOJGW7s2h4frh7aKcUtobVoidhIhYlobnqC8l6FMWEzHywWQUllthNTCOpKooRWHk2S8x9I22tc7++r2AZLwhWVe9iAue1VNrN
X-Gm-Message-State: AOJu0YxLgbUuzte8gSDzAtdIltXt2QIZLT/wZz79wV5Apjuo3QRuLlyB
	9CfBc7PBcHRoZ1jwWHAdUt7IWEO8ffDcMP5hBUixqU5mW6KzwnZv
X-Google-Smtp-Source: AGHT+IFyUrAvg4MoDBC4vcKMopdUBwINIvx8BKpiwRLyiww9G2xWN0p5Iwx52RZDvke46SOf4bSzGQ==
X-Received: by 2002:a17:906:d144:b0:a3c:ffbb:b47c with SMTP id br4-20020a170906d14400b00a3cffbbb47cmr1027385ejb.72.1707823315623;
        Tue, 13 Feb 2024 03:21:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdGlNzat68BukqqwTNj9Ugva7hGZR0R7AYxNyraA/87qVSVeeLRoR0Kr64QHvNE8uLePDgsel1hioQjeTboSMHMJK3c5utyh8PxdT47hAdLYD8UvvEvf+Sbm123ZzT920vhypL4kjgLNSEHbUCSsYu1XqU4OIbbZbhspztIDWdNHUUmlXVBv9iHdl7TyuAK+NpRekU7qDCB4G/thW6pK7B2Lyii6dIZv25AyQEX24Qk91QGA4DjiDsJlkiMjZ74U93NpDZDyudtuIIceKGNIkmZ25wOq5UEBo=
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3c7fb8cc74sm1176585ejb.154.2024.02.13.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net 6/7] net: fill in MODULE_DESCRIPTION()s for mdio_devres
Date: Tue, 13 Feb 2024 03:21:21 -0800
Message-Id: <20240213112122.404045-7-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240213112122.404045-1-leitao@debian.org>
References: <20240213112122.404045-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the PHY MDIO helpers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/phy/mdio_devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
index 69b829e6ab35..8921fa22bdbd 100644
--- a/drivers/net/phy/mdio_devres.c
+++ b/drivers/net/phy/mdio_devres.c
@@ -131,4 +131,5 @@ int __devm_of_mdiobus_register(struct device *dev, struct mii_bus *mdio,
 EXPORT_SYMBOL(__devm_of_mdiobus_register);
 #endif /* CONFIG_OF_MDIO */
 
+MODULE_DESCRIPTION("Network PHY MDIO devres helpers");
 MODULE_LICENSE("GPL");
-- 
2.39.3



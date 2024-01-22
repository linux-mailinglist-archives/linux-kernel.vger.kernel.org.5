Return-Path: <linux-kernel+bounces-34183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5083754E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B95E1F2829D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE45548CC4;
	Mon, 22 Jan 2024 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajPUvRGF"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2E482ED;
	Mon, 22 Jan 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958979; cv=none; b=N735qamUdcGFotAflY9dHzkCIo/+8ToYTg9Tu6bdyBuwNKfkC3vOPFESpUJNBVs9uDeoAQQQIKvLTmPwaaOam/ZTLMbkAGAZGcImKiCWhW/+20DvpWaWAnrNy5pn61j+YnQVVyrEQnVbM9lEEFwu+PWU4tcg2UC7WWaEv2yF8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958979; c=relaxed/simple;
	bh=Xlt6sMMKAUm7IbZRBGhxEDcRLpN3TDT3XNkJuoLuK4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKdDbPcBaGvLrwpgetFS17Tpiv5WDTb8g7hba98NXyHUCKLBqRnapPxHPXxrbxSuKlpf9gggSK9Ghf4TFYVmN3AwWF2BPD4nSRzjbrPTuYgZ/JDcKRUlBLZtLCCsZ47Fz4QyoLL7RVLfhQ+uNICEHTjjaOgG9KkimN/4P4wzLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajPUvRGF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso806602066b.0;
        Mon, 22 Jan 2024 13:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958976; x=1706563776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABA/+6oxHumH7163VNUvqNT1eTr+ehROcpiaVQm4GRM=;
        b=ajPUvRGF5ssv6lRWYhlfo41cptvxfBEnyzUnhIS7cZJEDj16sn03lxLF0CT2KT/kQo
         3DecZ3Fu6GT6+xtp5k9k+YX+knRCc1OPJqSkKgK4E+B3+J6jRSbEg5E/5bFMQF58mtxO
         aSbonJmdlgyphofX6ZcF7H4TwkX2CB14C7xuDlsOXofsyYNz2STLnknG/nCzpAuATNm2
         zeHN0tC5CZXokNOzqDWWHgkZ1VuwsnjSaoyDpjhYEvskerLfNWk7wLkQJrSHe2ihdiXi
         eeWTi3o/ZNINiW6MBO8smYx1FV++cZgT056gf5hVapxh8HLia0qti0DgD6EQkCpPKDbO
         OG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958976; x=1706563776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABA/+6oxHumH7163VNUvqNT1eTr+ehROcpiaVQm4GRM=;
        b=GJFpEB5pMSEx55yoqsZc+GXER4yDkGEJTrH/a+NmRWGCAE40gw5EMduX+T8VJI+LhC
         Ncial9yc7MMpNU9LIeEWQOrBN8AUx5ORSrgcSQiek+30cju80c9LEJjeXsYsiZr2xF8W
         z0ag0moLb7DPv41LvnsyMfJX1lY1pDjSQIcP11QUx/dFNOJYHMg2YMSjZHCMABVne33T
         SohvJYs2K/7Mdyxxz3u3/6CAU/y1YOps/QulYiqxD/+8yeMaEaEnj4b2RcvXi52TPT4o
         4C4jK0IKUMJ8f9enr5Td7PohEXfRe9LOWeYbT+jMyV8Qczrxdt5d/eqhp6itnzm+NoSO
         3DYA==
X-Gm-Message-State: AOJu0YxeVbKSqYYfS00wvlDgSpZehmB7t2squxceluyOgvx6NOnixf0Q
	Ffn2FAXag1AgdD1G3oKHW15kXLq6bde5WKi7nN5eK8vGHUYZ9wFX
X-Google-Smtp-Source: AGHT+IEZ7u0Y1M9h4MrNvyig0ANPhkjW21ElfCa295jmdxao1CQmsoJQ2e//T1v7E7hHEXQ7JldxPw==
X-Received: by 2002:a17:906:bc45:b0:a28:9546:f92a with SMTP id s5-20020a170906bc4500b00a289546f92amr5044730ejv.67.1705958975603;
        Mon, 22 Jan 2024 13:29:35 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:35 -0800 (PST)
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
Subject: [PATCH v5 net-next 02/13] net: phy: Support 100/1000BT1 linkmode advertisements
Date: Mon, 22 Jan 2024 22:28:35 +0100
Message-Id: <20240122212848.3645785-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend helper functions mii_t1_adv_m_mod_linkmode_t and
linkmode_adv_to_mii_t1_adv_m_t to support 100BT1 and 1000BT1 linkmode
advertisements.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/linux/mdio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 79ceee3c8673..ecd21acc7eed 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -373,6 +373,10 @@ static inline void mii_t1_adv_m_mod_linkmode_t(unsigned long *advertising, u32 l
 {
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			 advertising, lpa & MDIO_AN_T1_ADV_M_B10L);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+			 advertising, lpa & MDIO_AN_T1_ADV_M_100BT1);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+			 advertising, lpa & MDIO_AN_T1_ADV_M_1000BT1);
 }
 
 /**
@@ -409,6 +413,10 @@ static inline u32 linkmode_adv_to_mii_t1_adv_m_t(unsigned long *advertising)
 
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT, advertising))
 		result |= MDIO_AN_T1_ADV_M_B10L;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_100BT1;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_1000BT1;
 
 	return result;
 }
-- 
2.39.2



Return-Path: <linux-kernel+bounces-70260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF085955B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88BE1F219DC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CA168BE;
	Sun, 18 Feb 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqP9sTZy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222912B91;
	Sun, 18 Feb 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243087; cv=none; b=Ne27pKJWvPFY7gWpRNoMnmHMe6tADYcvkodIH3EY1ZMsl5wHMLUSDDVXJtw4fn1sb6ZrFoCGT8stPo+19mo68d++a+vMtzQpIyDoCA/4Fx/P2AaH1fS3ggaAH3HdgG+GQ8Hge+dpOBGH2GI9awkbjsD1M5tadwVTYruxMaEkaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243087; c=relaxed/simple;
	bh=Xlt6sMMKAUm7IbZRBGhxEDcRLpN3TDT3XNkJuoLuK4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uM2RFIOBk437nqNXOOZtvzusJIdwXRfWQaV8kVnnrC3k9RygBRANnw3oRYhiITi1QepLXUy1W3zwgO64EIVTiFCkzW61xGmODUj9wj0VidPmWfxzz6URdVHVWQIAIJEG5GGgljaLZ1z2uXNI5+HxfqxPkLlrWkwJdb0x4D36T4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqP9sTZy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e72ec566aso13741166b.2;
        Sat, 17 Feb 2024 23:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243084; x=1708847884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABA/+6oxHumH7163VNUvqNT1eTr+ehROcpiaVQm4GRM=;
        b=CqP9sTZyzryAs7iLXK7/LFAjYkvJflQ058VXI3J9RVoGL2tgn5FxdZY2h1RujvURd3
         QCFQSp3WAwrMR2ruEekqHsF22hLM8kZgOcW7bbpyf9ASKOqBJto64EDMWVIKeisbWaLL
         +EFBuDUk6oPMwHThw0uzjCDhihAuHpyEoc1uHUoyQSTQ/mIbJ/nhegU4ZaY1A2NudSpo
         ITstTCkYlxo5jK8qk/FvOnlPkgfFFXH9eLit99xnpVZGrFZDD+/EXUHemIFTQ2mHtx4W
         5Tn9a+9bIapNll6cOSRFgMHHKvv3Tli9aHymokKqoU+99fPJrzFlD/1CEsAF9feA3fbl
         X57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243084; x=1708847884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABA/+6oxHumH7163VNUvqNT1eTr+ehROcpiaVQm4GRM=;
        b=GrQHOY0BCjdq25+V+xTgnWFhAx23Wg3BSB5eJt+bHjr6dH4KS3N1dSPphazuCAQyAn
         mJ9FE58wkxrvc97nYWM/MyBTCtVccSsdFZS4Y60q3hcxCN9nEgG2PUpdKMZP08VVf1X0
         8XqQiPjlI8qp/V0lQDUN3IVjb04qlVBpMTjRt+sRaXdrHaAEjjbfhtjrpvLoqDZzvQ8o
         Ve5/WEjJR4BRR44nNHi1Y0s2g/C4OCCLDdd618vUbTA05a+eyLUcTA5chFWKNGZrHCRQ
         vHsybrSREh1ZfDPTu/2izo7XGm/CWM6GeVOMGcs+jQ32FnP6VAiv9HC2guKqNyTtJ5jh
         B69A==
X-Forwarded-Encrypted: i=1; AJvYcCVYmrd9YmIAVeVxAaVayIa6dDWD+ivxuSX6rEzrQSmOTzCvHMaVbazdYXlBqIoaJ4El//QSVht6ZVgN/gOZkM/EatqmagAIZ3pe/YG0JLSRZooJjAGO9S9ivvuRrsX7yDQFlI1M
X-Gm-Message-State: AOJu0YwEzs1pqymyrWgkFP9L4OiOrsT9HN+kXrvM/c/Nd+JVM9v3LLdw
	OMzNhO5F98Vq5Qtbo0/SJ2WWYPzpp7qZMqJTIUS2i0Vs0T9Tc92p
X-Google-Smtp-Source: AGHT+IGwNcnr0R5tb8Mt1y0aO3rr6jdQwKrX+eS6QNQEfrKvWFGN1zKKTKMU5cWihtKHla0t9toeGQ==
X-Received: by 2002:a17:906:3492:b0:a3e:6d75:61df with SMTP id g18-20020a170906349200b00a3e6d7561dfmr501895ejb.45.1708243083483;
        Sat, 17 Feb 2024 23:58:03 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:03 -0800 (PST)
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
Subject: [PATCH v7 net-next 02/14] net: phy: Support 100/1000BT1 linkmode advertisements
Date: Sun, 18 Feb 2024 08:57:39 +0100
Message-Id: <20240218075753.18067-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
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



Return-Path: <linux-kernel+bounces-19285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2F826ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C52282941
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD11400A;
	Mon,  8 Jan 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfcpsLB3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86A13FF6;
	Mon,  8 Jan 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eac018059so1809410e87.0;
        Mon, 08 Jan 2024 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704706726; x=1705311526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXPtrc41fsYsH4qrRymYuoMKNwwt0FQDNNg3m4pWnyE=;
        b=mfcpsLB34S15dP5D9ja8CG4gkQsAexwrXskq9XKtpftaMp13MZtB5vW2lzIuNkV7nF
         i/KBj70gSMTdJtLkVChN+WyTeUjBY49pc9d+ErXI8TVHzmP3D375OnydM+o7nYndxibI
         SNQ/yZK8UNOKszNdK9tlX/600FfaIuAjsPBbZ+3thIHzQwNNt39ObRaSTzqB006qLSUV
         utkB0QxGTfjBo2uav9lbweDjbX0DMs6ZpuNWC5VyAB27r1Ynn6n6RiQxQucfhu+ENfb4
         HwbTlN5v2EqhKUVxkLeDfSwoATSsl2zWv2UUWrDNDjLk7/6mApMY4iHKY0l0LqGzOCVT
         tEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706726; x=1705311526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXPtrc41fsYsH4qrRymYuoMKNwwt0FQDNNg3m4pWnyE=;
        b=mV3uGi2Y43/Ah4KMx2z6RA0aVTeYiiX31WQe90CzWUzdybFktlntwbKaQ6xFLpLWyC
         BjHzFpHETL/4U3flnWlhz7iovgzrFFPZI6RYgfyb725WwkETN8jwt8i8hG8mKkQG1fh9
         +WNFoRj3vjyqt+KZG4Na/1lZHN/TlHg+FO8nVxca8ioA+J+cJucAE2RlmOuPMbeZ31n2
         hK5WFRWMXzAcEv05xjNU35nzrLVXjMpl+NMKunUqwLldFMIo8AiahAnJUj7LWemPrYPC
         Ff47M6YBUakZxy7jA9h+xrKo5+3426Bf0p7p2LB7fB4GDl2wg9XimTQlQu5nR2HMyRJb
         yckg==
X-Gm-Message-State: AOJu0YzWO/HDo5chZazEayPG0vhppKdlneXCgfm0hY8UQU1i/7WJg/Gk
	fmNaiDyvEcXQqnJczy1y70ajHfvkc/wj5w==
X-Google-Smtp-Source: AGHT+IHC3wPb+Q7obmNmg1TOA4Uld8yrZGtvfJ6ZthdpVYnERVwZAYnBFJrRy2sVw2Gv+Ev2/Srpqg==
X-Received: by 2002:a05:6512:2252:b0:50e:bb4d:e502 with SMTP id i18-20020a056512225200b0050ebb4de502mr1791143lfu.122.1704706726408;
        Mon, 08 Jan 2024 01:38:46 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b00a2ae71cee2asm326851eja.177.2024.01.08.01.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:38:45 -0800 (PST)
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
Subject: [PATCH v4 net-next 2/5] net: phy: Support 100/1000BT1 linkmode advertisements
Date: Mon,  8 Jan 2024 10:36:57 +0100
Message-Id: <20240108093702.13476-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108093702.13476-1-dima.fedrau@gmail.com>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
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

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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



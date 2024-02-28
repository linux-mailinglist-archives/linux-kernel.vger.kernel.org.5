Return-Path: <linux-kernel+bounces-85435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13D86B5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAE41C212C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0EA15E5BB;
	Wed, 28 Feb 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYh4+uVL"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73B15D5B7;
	Wed, 28 Feb 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141103; cv=none; b=cpNaA5XJl2yuFni1jFjKCxEDJQhAur0DBrhIeLR3rS4SSDVa0pkCbqvOhXycRF1khuEbEdN+oP13jPeXc6U5rR9qX1l8cTL98BpJkgjW2JEml+ONYZOlnwMCGw4KeF3qEXfCTGPvEaamTJ0RYC5o8i4Q3FiGQ5SqD0nlw1hAYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141103; c=relaxed/simple;
	bh=frA2gI+sHqG83yObCUgFM4FLAm6X5cpJvaIjmG41mD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HljeB/rX871J5/tWloa5cMdtzFXWuHk2PvuW2gKSEJ9/mHlb+iQ48LdcVg4ARYXmRn0/PSe/afAgwt2ohJDNPA+1MdhkGo2942ueqw58nklmR2sMJuZZYAGD3lx5yfxxLG7BeBdEOYWb3R+rLDbfa7OIs3yzVAH1O/dJgO+kCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYh4+uVL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a43fc42e697so2519366b.1;
        Wed, 28 Feb 2024 09:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141100; x=1709745900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jytqVH/5UszT5WvJsP0t7KjpRUDElZgmVoiNlcchCAc=;
        b=DYh4+uVLktIjWyG03M4FRlULwFcJUf+ZRTPu0L3d7LPcfBzRjjg432VlK//hRSIZec
         Rbg+z+CuOMKDIxLyFm6VJAhx2QYOJQC6e3bpKRGHiWPU8atSGiWJDPoW39mxSbk6c1eD
         D/maVzTIzF1MsX17QCVzQyqm7nulq6UWY/LVZjf9u4p9GDfYS3I/JfCqVqEZsdtlFcdr
         CpiKj0YLzP//obAPnXazSzCAZJfayfPYRthUKNvUZQImlWCJnXdj4HBAdG60K2msIZIV
         myXaBH8XAoH8xuI8MMOCIwe6HpzEzqIDZvjcsW+ni7BVv+gCrsF5tF2qq3FzCUCOoGps
         GTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141100; x=1709745900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jytqVH/5UszT5WvJsP0t7KjpRUDElZgmVoiNlcchCAc=;
        b=AqJoiB4sYfCupu/1/xLLKcywSYC88sgkJIEgONBtUkTXNJu2wczG3T2jtVseCljqsW
         MnAXaxw+R8ext68ZnG1jD+xvxvutTJkrtmy7aAw4IWPjF51ocs6uc7gq6CnU2xub549X
         RfQpaE6hHcjd50a5v+JVDKRZDU5a+Befk8tp2uwnvi8ExkhObtN+U9stDzmhwF1cSLT6
         xc0HeU7q+IT++0Ck/Tm37EWKAcMBlNWujSVci1IhMt/kvmjQ8Hi8+NlVAHOD8ycNzWjo
         SrGFJZxtn+uZgQ8kOCv1DVJetVjZT24SneqFHTKWULmbBlxZFs9lFEORXaLkXSxa1/bm
         1l/A==
X-Forwarded-Encrypted: i=1; AJvYcCUjgD0NYYv6OF/i6EIgva6p7Lob1Sw1vwN8HjXLCD3nRzfI0RD4Cx3MXJlfggZqfIZD++g6/Aoku4jY+jwQ7vmZHVCAAOwJc080jhXZ4ZAYzs5z3dUkDAZJZUgIhlIluD342SWXRKJAsAkbd4rEcwP2lU6Zm1UPd2XNcjQHZWskS5BmGg==
X-Gm-Message-State: AOJu0YybdR5991fpWFs2M3Atl81kCxXsyFauYoa2rNTvfWCTryS1+kEw
	wchhJ0Vu2IXFQ/XlFNszUxP3G7BftGXFfgI6wsK6qVjYHmdsuCyX
X-Google-Smtp-Source: AGHT+IE5JAVvgs3wHTJZhdBZ0opcREvYGp1AZHXShSxilwcqKyKeDIl5NYsElhQw6IEBhgyQYrxRAg==
X-Received: by 2002:a17:906:454:b0:a3f:6466:bbcd with SMTP id e20-20020a170906045400b00a3f6466bbcdmr212959eja.69.1709141100124;
        Wed, 28 Feb 2024 09:25:00 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id ts7-20020a170907c5c700b00a43f4722eaesm926910ejc.103.2024.02.28.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:24:59 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: fill in possible_interfaces
Date: Wed, 28 Feb 2024 18:24:10 +0100
Message-ID: <20240228172452.2456842-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240228172452.2456842-1-robimarko@gmail.com>
References: <20240228172452.2456842-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently QCA808x driver does not fill the possible_interfaces.
2.5G QCA808x support SGMII and 2500Base-X while 1G model only supports
SGMII, so fill the possible_interfaces accordingly.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index a4c61a8e07c3..5048304ccc9e 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -167,6 +167,16 @@ static bool qca808x_is_1g_only(struct phy_device *phydev)
 	return !!(QCA808X_PHY_CHIP_TYPE_1G & ret);
 }
 
+static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
+
+	if (!qca808x_is_1g_only(phydev))
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
+}
+
 static int qca808x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -231,6 +241,8 @@ static int qca808x_config_init(struct phy_device *phydev)
 		}
 	}
 
+	qca808x_fill_possible_interfaces(phydev);
+
 	/* Configure adc threshold as 100mv for the link 10M */
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
 				     QCA808X_ADC_THRESHOLD_MASK,
-- 
2.44.0



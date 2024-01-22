Return-Path: <linux-kernel+bounces-34184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A52837550
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7AA2877D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30DD48CF3;
	Mon, 22 Jan 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwER8uCQ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEED48CDC;
	Mon, 22 Jan 2024 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958982; cv=none; b=ZUeCuig4YQa0F7O0Gv/y+zgEr70etUU3VsoIVzS4e8p/JIzRi/or+80lWRFZdsRK72E4OPehWyfO1GSEEnBj/kGtIqTpti/fsepacyOL6ombDGpLhhskgCzyTZelgDQYhsl88WitTSPCXgIU5z9M5aNbNkixkDYjkd/a67C+ICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958982; c=relaxed/simple;
	bh=cFyzorVyt7pR+oxl9oSqdJVk3CnfNL+zpcN7YvtmWuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHhhzpbRvvCYlwB4wNkCtlYIbPQ/wOzm2X8RuJ+6gA2I/p9xCfgdH+QKVPAaK8HhUQXzKT3mHKTSfqm0yKOWarFAAsctUmvqw0rvcT1rCPQaaPWc7m+lrJ4Y9sU1OYMg3i86BHh8i3FbMRwdNUxCQN8tahcst+JCsLbgt0MpM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwER8uCQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26f73732c5so398553266b.3;
        Mon, 22 Jan 2024 13:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958979; x=1706563779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH7FjojSelKl6RFjaMdeJGd9WEI2qrfj4ii5ApRFD+M=;
        b=NwER8uCQJyrgHizCginY483OO2gol/pYjjezu9IqP/bFQGVUld8W+WDNQ5o/gmPz9b
         BpVUYrPGmg68xJDTbLV+euOcX7vDPe5H86jJZlzQy3jO6+1f2YVMA+95vjMy1LlqJsnk
         rACm7fB6fbV6tO5Se2pc0UWJiOzA1lZ+syL+O1jzsjhd5YvfRM02/EvZu0Iav0K0kbPD
         Bl3cE0c8lWYXLjt+6hF5MAveWaNt8e5Ej3nRoqhUTCNtLNuikwpnpOnX4/pSKdddElO0
         fnmkuLeTzhLgwBSVkvFqVF47v026h20Xf126IBQWjHBwrTmlMICRJDLz8ncdJsBtmHGd
         ijog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958979; x=1706563779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AH7FjojSelKl6RFjaMdeJGd9WEI2qrfj4ii5ApRFD+M=;
        b=NnukYoOFgt+Gbassw5YnSk+r6Pfp67TfVRSaNsPd0ybvqM4mW0MhlCB9Hc5iBWBCV0
         6i06Czh2S8jWwvlZccJEV/qbYjvArcSuF8U37OL0cyCQs9npXMRee7jxd5KtTNdBqwZA
         8jijm7MjWw91j1VHzkdNAreYnDHHFXdGd7koBV9i0aZ7AT4eLRAwd18JdpKRlkgR749v
         IWhZPahCc6e3ZZYBwm0vvDpHD9eHqcX+/eSZoMJFzLUE0ITR0UQnjyMQd5gz5F3QAjyh
         pn5/01zzbfVYfdZjwxjsBY+p7GWOPnGr4Q3hnAEQKfoYkpRgctIzLCqsInFPWl5f3Dcr
         ofew==
X-Gm-Message-State: AOJu0YxPA1ml4OHEgJ8SSbsjVbvBPUBxnfciW2iBWXOTJiJnuNsEZ/DI
	iyN+i0hzYrkowdxVcV/+2ehTozcjFENtdmQaRZgVbrbXxuePnDtk
X-Google-Smtp-Source: AGHT+IHoowVuZ3NxgUNU4DZXVso3pbogoFHMUeLHEkKLashaB1EnTnHPglH4ZSr04QbpVfmyp2xgRA==
X-Received: by 2002:a17:907:a78c:b0:a23:4dc0:97eb with SMTP id vx12-20020a170907a78c00b00a234dc097ebmr2871161ejc.14.1705958978613;
        Mon, 22 Jan 2024 13:29:38 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:38 -0800 (PST)
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
Subject: [PATCH v5 net-next 03/13] net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
Date: Mon, 22 Jan 2024 22:28:36 +0100
Message-Id: <20240122212848.3645785-4-dima.fedrau@gmail.com>
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

Set 100BT1 and 1000BT1 linkmode advertisement bits to adv_l_mask to
enable detection.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/phy-c45.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 747d14bf152c..de8f5dc8be12 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -208,7 +208,8 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
 
 	adv_l_mask = MDIO_AN_T1_ADV_L_FORCE_MS | MDIO_AN_T1_ADV_L_PAUSE_CAP |
 		MDIO_AN_T1_ADV_L_PAUSE_ASYM;
-	adv_m_mask = MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
+	adv_m_mask = MDIO_AN_T1_ADV_M_1000BT1 | MDIO_AN_T1_ADV_M_100BT1 |
+		MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
 
 	switch (phydev->master_slave_set) {
 	case MASTER_SLAVE_CFG_MASTER_FORCE:
-- 
2.39.2



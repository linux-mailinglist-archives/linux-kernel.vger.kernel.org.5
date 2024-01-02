Return-Path: <linux-kernel+bounces-14124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A1821814
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3BA281036
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137F5382;
	Tue,  2 Jan 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOiPInFm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1C2116;
	Tue,  2 Jan 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2335d81693so1565281966b.0;
        Mon, 01 Jan 2024 23:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704181475; x=1704786275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDvW3sjoSZAfuwAm/hbpL/iSvJJ8dkyAFEfhRbq1dGY=;
        b=gOiPInFmibmNreiv+vl0+ovVwyvsAAeA2MyzoXoZFSnATekKSE153MeJepoGB09f3Q
         hk+JSDv7OqWuXgQEpVxF6icsyIGYFmFiFbP6BbkZ82C/gA1PUbIJ3hLwUg7qcyxhegL4
         TZpGuGRJzDUohZLrzcbYKgSLxfDZIxwZeNmY9aT+UEMc84CSN535fZW7eCNtb32AUT6W
         qbv03Im/WfO5VK+YQ1Yjwb6axJ59XLp3c+L8X1rTo/kSgnf5QiOdj80XJBuv+5cl5UsS
         27SfF83m9CODEmOwOrR2sPC8GQfHwwal0q2ZXn/toqWK35dEhtiCrzWBrsc43ndwCFq5
         JOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704181475; x=1704786275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDvW3sjoSZAfuwAm/hbpL/iSvJJ8dkyAFEfhRbq1dGY=;
        b=X0G+KMUul4tLUQ6gIThFUDz/dmRjLj1uNqozW3BNU6hTBwGklGsrhEsr+gzc9OIdJJ
         lKLdaFEDntbrj0z/xaPh3WlkmYG9wh54LmYas2BDXVYgjHhFltNt8IG7gUc5/hrVBA73
         2cQR6X6V2pPXKGtWZfNmjMVdT8Hsdbjcmv9uCi0gc7xhaabNLIEMr65RrI4oDLliBFpr
         vvvShSj98d8X+3/ECxNqUSjvgGFs2rElSzVf3m2DKAoEtSBtGc1VLsXqNcCniD9EdcOr
         5PAvZtLFJ0cAL3nskT+fCTFRr4n1m8rZfSx5n3J3fwFFM2eDQR5nDM3BZVn5lU3cH9pk
         pE3Q==
X-Gm-Message-State: AOJu0Yz6zsUL5Cyee+JMIx7Kc50zw/sf9nWw8S7dnpQ9QEJfFVC9g09F
	gmUy3iRuX+NcPUvVtGlawqw=
X-Google-Smtp-Source: AGHT+IFrNratpgXrVJ41/63gbNL2DtrJxYnkligcXJH/H+RePQqwbz2GDOycmpYVEmhbrqbh1f2mjw==
X-Received: by 2002:a17:906:c181:b0:a1e:3a14:e84b with SMTP id g1-20020a170906c18100b00a1e3a14e84bmr16246013ejz.44.1704181475049;
        Mon, 01 Jan 2024 23:44:35 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063da200b00a26e4986df8sm8362638ejh.58.2024.01.01.23.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 23:44:34 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC net-next] net: pcs: pcs-mtk-lynxi fix mtk_pcs_lynxi_get_state() for 2500base-x
Date: Tue,  2 Jan 2024 08:44:08 +0100
Message-ID: <20240102074408.1049203-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Golle <daniel@makrotopia.org>

Need to fix mtk_pcs_lynxi_get_state() in order for the pcs to function
correctly when the interface is set to 2500base-x, even when
PHYLINK_PCS_NEG_INBAND_DISABLED is set.

When the pcs is set to 2500base-x, the register values are not compatible
with phylink_mii_c22_pcs_decode_state(). It results in parameters such as
speed unknown and such. Then the mac/pcs are setup incorrectly and do not
function.

This is part of preveously rejected: net: pcs: pcs-mtk-lynxi:
use 2500Base-X without AN. But I believe this is not the part why it was
rejected.

fixes: net: pcs: add driver for MediaTek SGMII PCS

Changes to be committed:
	modified:   drivers/net/pcs/pcs-mtk-lynxi.c

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 8501dd365279..dd0a1e0dbbc7 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -92,14 +92,23 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 				    struct phylink_link_state *state)
 {
 	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
-	unsigned int bm, adv;
+	unsigned int bm, bmsr, adv;
 
 	/* Read the BMSR and LPA */
 	regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm);
-	regmap_read(mpcs->regmap, SGMSYS_PCS_ADVERTISE, &adv);
+	bmsr = FIELD_GET(SGMII_BMSR, bm);
+
+	if (state->interface == PHY_INTERFACE_MODE_2500BASEX) {
+		state->link = !!(bmsr & BMSR_LSTATUS);
+		state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
+		state->speed = SPEED_2500;
+		state->duplex = DUPLEX_FULL;
+
+		return;
+	}
 
-	phylink_mii_c22_pcs_decode_state(state, FIELD_GET(SGMII_BMSR, bm),
-					 FIELD_GET(SGMII_LPA, adv));
+	regmap_read(mpcs->regmap, SGMSYS_PCS_ADVERTISE, &adv);
+	phylink_mii_c22_pcs_decode_state(state, bmsr, FIELD_GET(SGMII_LPA, adv));
 }
 
 static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
-- 
2.42.1



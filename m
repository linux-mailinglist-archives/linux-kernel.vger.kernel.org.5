Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE576C56A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHBGlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjHBGlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:41:37 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2FA272E;
        Tue,  1 Aug 2023 23:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5XWZeeUg1oe8GQ0hDJmj24ZEpykFmHOVaqDYCSpBHDTwbTfpXiS6OAi08Ga5GhYS7W+tbpZ5fws0v5sy/1f71DDbnLWWfyifX+Qi5Ka3Jak4TGCFyhJEoABedNHZn0gi6yFXi3NYVGSpVo2PvaZ4jKSd2MiNrctLA8ZDOFUbseEEaD6qjqpGCqTxXuaURH6Bmi2RTjR0ppraeBFFbyIoEN9oHzPgyxvmZELlBZRZfcwvTj2f3uEzZQscqbqHITulTalq8Uq0Tgciach0oenmJ18kYHSFtgAEOHEJbimkSkYbMqJwkBQHiduLiwscK1qg2R6hLlELau7P5RMt5S2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co7+Dz3AuUEofB16svfU2XU+AoW/iZrolpp4aKKuxdI=;
 b=h4KL9tlPYcJyob1USuglXezB24TWRJ7rDMjMMkv2Qu7bXORYqdVctMvZKX2hWDpantz3IdFOwUFLQTyM4TTLPyPr+nQgMLdClXhjH6XWnChQa7ESZnZmoCBGz9urJP2RwO0FVp+3ipdJumCis7UHbDhdgVT/Z4vHPPF9rvosVhPFNG9zVFJlwAhC/ccZUo2sLof3Sz312xRhH9elOayS8u3uwobcLQnlro6XiUhGbUto4Rr4OEzCj1dtqfVvusKK04TThtYknsc6+E88z7cvGuKZNWR3suPOvc9BI/LPgiqwlAKHyPYtBQqaB42QWbIFaoALKB/u8m3CrXhpwF8NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Co7+Dz3AuUEofB16svfU2XU+AoW/iZrolpp4aKKuxdI=;
 b=rVsX4zS/rrIcXTDM5D3ErQvfVgJorsQ40xiUQG41oQ8EW3LO9LC/A0L8N3V1qD7Hp+elnc/4Y63mWA4g8EWw9yqPffTIcKW2FGfSPjtoBWxmRQBi/lHKDyRY3TR8HZphsA47mFpAZ2iyYZHlHCt8JNf4o/JYsLIFYPJx1bgSk5ljiI9m546hqHZ/qscmwCjH87e5aF3DMjftyZh4JsbJgmiVRLfMn5l+tgzp3uOi/msSjVpl2CwNj4KNpRtkAl5QYS7RhZs/Kp2ZNYFImxWoprE7d+RSkrQF3SgWwCT8OJcBkiBQc8BRz5Wo4JDlyJlIGGQzCnO6kMsTYMcvXZ9Lnw==
Received: from AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::23)
 by AS8PR04MB8964.eurprd04.prod.outlook.com (2603:10a6:20b:42f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:41:22 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:208:15:cafe::a8) by AM0PR10CA0070.outlook.office365.com
 (2603:10a6:208:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 06:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.0 via Frontend Transport; Wed, 2 Aug 2023 06:41:21 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.241) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 02 Aug 2023 06:41:21 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:41:16 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:41:16 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 2/3] clk: lmk04832: Don't disable vco clock on probe fail
Date:   Wed, 2 Aug 2023 08:40:59 +0200
Message-ID: <20230802064100.15793-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802064100.15793-1-mike.looijmans@topic.nl>
References: <20230802064100.15793-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37b21939-e4ca-460d-8656-25f90de74f6b@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0079.eurprd03.prod.outlook.com
 (2603:10a6:208:69::20) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|GV1PR04MB9216:EE_|AM4PEPF00025F96:EE_|AS8PR04MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 7271b36f-8f5c-46c9-b58b-08db93237c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8l0WLtYGylHEftnhJNLnIJwCv22hpP6t7ogJwrI4Z+iQ2QY2cDa7Sklc33UY6CZFw6KIvJxBQAIAatgTffZqiRtKwNyM6fCNbghJ2CTS90wbImxZUfpv8y7bZI5IrDU9JokBx+YyPQvDoz472XIFdyOypiLaV1uMKj3OWeYg8jkucxh/9+eUHXlza0AC5Sg6eqTaw5VRozQYapTrpXjrOwFM+sjVeTOnuMWhix+KzKPzePdfKyfJ8UNASI9NqVQgA1pmMj/65peAumsj+bsVBy2eSZL/4II89jsz5J+HyoC9l+1TiMvRFGE6oD0eE0/JiWr+AlkEC4XIfwYvE6NKs1ZHcMymEIzPYZypasTgmc4jFdQsWjULqzuwDwwFHfacmrUTcmKDhctzDPHxnDscFWmCN4iCphXv8kYJP2i177dSaxGQjsOKTrjfOSqQzo5yVfHxNnJCH4Fo/TgTDXpR6tM2rwSeMGqDklMyCh07kKoiuxZimHPfi2DK1YHxAosIu2HgGOnTMuV3pkI4aCDPYpL6vAEK5o4VDW2vQX+M2zVZAoWXuq7ElOOzCCWMbKZjHszt8HaWcSvvQdLkut7T1PPMsmwOylb2KAt5eLHY3c1qfzNJC2+ILZiqFAHJhMnD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39840400004)(396003)(451199021)(66946007)(2906002)(66476007)(4326008)(66556008)(6916009)(6486002)(52116002)(478600001)(6666004)(6512007)(83380400001)(36756003)(186003)(42882007)(38350700002)(107886003)(26005)(6506007)(1076003)(38100700002)(2616005)(83170400001)(41300700001)(8936002)(8676002)(5660300002)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-CodeTwo-MessageID: b368a614-0601-4c25-939a-24650e48cf6d.20230802064121@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3276887b-4a15-41a1-3cb3-08db9323787b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgEuR+UHXQTasqVHbTHaiyc+02mSm7dTYKigQTikWLl8TKA9V6ujYPxfk6YphWXTQSj0Z71sri8FOjSoVZDvmwrq02srLDNO8FX7ghA713+IJUbbqSc632aEITDLVx0tl0JsDLotXXOYVFUTBcFb01gUegritN08GEoP17tu4Miark9jldhYE9Rtw2nFiFQXPuHulBQvmLKnsHvdf0JKe4hzb60bLN6csGEEiFPVZWbme0vcDuWsYyNjZO1dBMyzCygybMggIAA4mTdZ8MKKgeRmnszwI+7EulgaG0fr81VClslIHbizozCtUEGbRze5J+pLTOe905BuC3xCoWnI6pcjVM/Oyo2fdPNY6SgueMVGhBVMfH2WpbQ5Zv1JGIPhcBt5B1xr8LRvyAd7er+mkZPR8mH0RzLeikRYihEPuqqxTdbY63DQYEA/2nMY0WIqmAA18RB3LroYvvUXRlnVJPJHFkshPAtv3UHcMNGCNtW3plfLLM4bvcUtV0LBiXM3rHE9mnHUrH/xIlSv2l4ux89wwGd5me/pqr2Rmtp/de5z9q4Ab2/hpe+HxhfLj1I9m7y0/4JAa7/uOoMvjE36nHBZfIAUx0Dn1YzZJt4XUiYhKgO/QaP29FYDNUvXnnkbPmzAg6uUIFizcEcaqkhraY0rkc+PfVh7dlxJGUQ6rpET3bkjoHeI5+FMZsVYlOmKlDT4x7ugRpxl0uB7Ztk8aA==
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(346002)(396003)(376002)(451199021)(82310400008)(36840700001)(46966006)(2616005)(5660300002)(8936002)(6506007)(186003)(336012)(42882007)(36860700001)(8676002)(47076005)(83380400001)(478600001)(44832011)(26005)(70586007)(70206006)(4326008)(6916009)(316002)(107886003)(6666004)(41300700001)(6486002)(6512007)(1076003)(40480700001)(15974865002)(36756003)(83170400001)(2906002)(356005)(7636003)(7596003);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:41:21.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7271b36f-8f5c-46c9-b58b-08db93237c0c
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8964
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe() method never calls clk_prepare_enable(), so it should not
call clk_disable_unprepare() for the vco.clk in the error path. Fixes
a "lmk-vco already disabled" BUG when probe fails.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-lmk04832.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 188085e7a30b..dd1f0c59ee71 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -1505,21 +1505,21 @@ static int lmk04832_probe(struct spi_device *spi)
 		ret =3D clk_set_rate(lmk->vco.clk, lmk->vco_rate);
 		if (ret) {
 			dev_err(lmk->dev, "failed to set VCO rate\n");
-			goto err_disable_vco;
+			goto err_disable_oscin;
 		}
 	}
=20
 	ret =3D lmk04832_register_sclk(lmk);
 	if (ret) {
 		dev_err(lmk->dev, "failed to init SYNC/SYSREF clock path\n");
-		goto err_disable_vco;
+		goto err_disable_oscin;
 	}
=20
 	for (i =3D 0; i < info->num_channels; i++) {
 		ret =3D lmk04832_register_clkout(lmk, i);
 		if (ret) {
 			dev_err(lmk->dev, "failed to register clk %d\n", i);
-			goto err_disable_vco;
+			goto err_disable_oscin;
 		}
 	}
=20
@@ -1528,16 +1528,13 @@ static int lmk04832_probe(struct spi_device *spi)
 					  lmk->clk_data);
 	if (ret) {
 		dev_err(lmk->dev, "failed to add provider (%d)\n", ret);
-		goto err_disable_vco;
+		goto err_disable_oscin;
 	}
=20
 	spi_set_drvdata(spi, lmk);
=20
 	return 0;
=20
-err_disable_vco:
-	clk_disable_unprepare(lmk->vco.clk);
-
 err_disable_oscin:
 	clk_disable_unprepare(lmk->oscin);
=20
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

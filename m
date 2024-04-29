Return-Path: <linux-kernel+bounces-161790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A588B514E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D71282338
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277314AB4;
	Mon, 29 Apr 2024 06:22:47 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1512E7F;
	Mon, 29 Apr 2024 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371766; cv=fail; b=aijH22b9w6H75XPW6E34pjcKzE7YTjytpDypC86Ap/CzWM9DHR0bTC5/rieyu736LHy05HDt8ANZy02SQqkGacoqFLAg9zs8mX4h9Mxz6YFUgtA/jH/pIEa+paL5iyw4TR/5Qdx+RStPyBk/U2/i968nehE5QKgw6hBTetlU98s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371766; c=relaxed/simple;
	bh=zufFHnhH5XeDX1xkJvhyRJw0GDJeJq3EOxLdjGCFjug=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQHiS5WXXI6mOB/Rtu5mO5G+IAHlLjatnj+LAQ8JVeWaD/D7CmdAUfpEce/j/uTOID/ULedEVQl8+MTw33o9heNuXEC8I2o+0j1XZrS6xy9K87+IyflQ3kzgZxwa/emNbrmRgBrV8kfNF5GR8MVSwxwc7k48bBMeKQynMLcEKoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV/5tzZhWgN+28aHb2xCAX8XkFY8kC9dqbyMWYyDBg1KPYYih5b0sXE4B/JESAon8lq5+p3eUHUb5qmpG+maiPI6oEtXWCuwvOqX5LFhmGVrY8EpdkytGiDZ54VscoQlmwNsoDTmdVUNf7uiEfRPRZSmY0OfHiraq8tAhz3Rvb9UvkMMf4FVtUeVB0ISJGKnQqCJRSss9uqZKpa07gGXjyXgW7YL8MyCHodrmTCG4AsuaLjaOYuMWeKpyXvzbJS5UCjdX9XDBAit5qSMCxP5TDceMpg+vRb4Y6c6U4uPrxVtBT1OFFIY9dsgp7Wpod0QeYD21hSm6kDiIw2YDUlFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2CrA8HwvGDCPolvpYiZEw8jeVztb4IcpTumyGyYZY0=;
 b=hMp2esLbbgdJvrwygQi8AXy4X8WOppd84F6ucs03u0oQywxMEpJLf4+WrhdOwgCnk3k9vYXNUjz9HJojsvIuQz3YSZiUWu+iT1FgYx0yXyjZes5P4sUrrnqS/97A1wK+sKZ3aaha+dzNm+Mfiz89+ruGCFqdHjcMsdyoPcVIkH5VoMVM8a3RcqMVTHRabK5JenaVtS3mKJO+4abhkdYxhzF7nn7jscd7SI6yiQ0fh5SiNvobA182VQJ+/sE5XhRr9I0FCvgRxqQN5wMde7Lo6/1BGQbgSEuJPjiq7TLwNqqbEQQEi3LeDnsykZ4wUhX9xe5IP/eC3NF0So7k97OaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 29 Apr
 2024 06:07:57 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::3dc9:e0c9:9a09:3bb7]) by
 NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn ([fe80::3dc9:e0c9:9a09:3bb7%4])
 with mapi id 15.20.7472.044; Mon, 29 Apr 2024 06:07:57 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next 2/4] crypto: starfive: Skip unneeded fallback allocation
Date: Mon, 29 Apr 2024 14:06:38 +0800
Message-Id: <20240429060640.2451685-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240429060640.2451685-1-jiajie.ho@starfivetech.com>
References: <20240429060640.2451685-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::12) To NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1182:EE_|NT0PR01MB1278:EE_
X-MS-Office365-Filtering-Correlation-Id: 9320845a-a264-4d73-61de-08dc6812b70b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EWcWVrMaSG+Ndp46oPkAo43E/hvz3b0ieGs6seSLQY2B2wUKkk1kATUqHShgI2DQ+oQont1YLCrCmMbNuFzjDvbImTRLGvlaqYbyO/DvURtTjAU6fI67aezd/RGw3RJ2RXuQLoRug0eZbA/FK0xtu6Zu4qA6bWlttT+x5XqhzibKE4/Be5Ldcqf8+LMlmxq3kUh/vBSVXwqS+q38nEUpwJ85f/ve4X2sSrqDUOjq5oBw7Mt15ynsg7FGh0qNU63G+WX8lWHQR4JL19crk/BnviXYi0H+mWQ3wLWCPu9vU/Y30/7HA3JV0QPiHR0+j3ex6X3pGo47FqZbfJfjrBEcaR5cGOMYd9DmaCqdcbgecsSgOyr8IzeUdmNVZ5LD3RCdeXaljqIxFMUELyizP1o/vZNTr+2I1Dws92ZVbAkbWtI7lkO5okjgDJ0C6EjAzNj4N7/jWEz/NHeK/3I2XzliexnKWCt45rui2vrgpeGBdgOgS3axoRjqahCsCijzrTXzDhqe1XDlYTHDeker2iVumZOOBcU3Xb3YuxnjRG8tluXRrMdBVvefiuy/UQuKTw0mYAOOO13YFYnwJ+r2XQ8P97YOQt9euZWydaWZWmwJ5/KPug7ReFyEGFRH0G00yd8o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSnluGdoPgc6KGtgPcuO8kbvOYrx5X9IW1X57dbW9D//ZEfavR+Fkv5gdB9T?=
 =?us-ascii?Q?ndRXbRDIeaMO3Nats6vlNGQeYEa5aieVeHaU9QGE61w650Z0Q7pSwjpoFG4V?=
 =?us-ascii?Q?W2+pTELK5S1a/0/vXjTIYDo3RQ/3kgnwsSdG4u3jlRPJBwys82HrKLB/PFqR?=
 =?us-ascii?Q?sC2ynPd1FKNVhwJ37v3u27SXCKGn38kdQ5PJFutfbEvP/Yt4C1WU5VAkwyaG?=
 =?us-ascii?Q?sgfo3INzswrX3p3IgAwWvemQdv0jhv3K4qr3exOrctq0ELtMrQnAGR+x9A6e?=
 =?us-ascii?Q?eBhFK1c+rN7x3CTZC8+BbJLo2xrniou4pN948fdteULCgMpNZ02i3k7RGUPm?=
 =?us-ascii?Q?5smFbhIOihIOHuX998LK4TFCqtTzzpMKCqgm6SSxtZXWVlnxPEWMR7mM8g72?=
 =?us-ascii?Q?BrOYZh3RBbcSXqbVb+xrScy8ILF/YnxstMPxkHsiJnxnLxE6cjyci6U32pMS?=
 =?us-ascii?Q?HtWV63rQFqjeh1P2fGWdxaswgRMDQ92SDnEBHfvjIlJBqIN1g9yInDDEpoKt?=
 =?us-ascii?Q?42W3E1CWhimaY+3bTJlOb48UpAgBLXFUcP8XvUxqmlRXHBuEcHXDa5mzz+ya?=
 =?us-ascii?Q?jJloLrTScoT1UbqOUdDwBz/i7xhLI/yo8KbcpEIZGdcPmv8iX75A8Oo0wFqd?=
 =?us-ascii?Q?sQUwsH3dRLbSS09Ec5c0dg2PIxsX/axAemla4s0Zr4z+22R9yT4RVA+bXeII?=
 =?us-ascii?Q?JjzC7fHnq/fZM3Dg7WzJs/IItsdp/fhMQoDAc3XXwFu9POmxo4fg+6dWJ1MS?=
 =?us-ascii?Q?9Uh+vBuU3t5ehKgZZVhzmFZeGGDAcRUbByc9BqtYsHuIlDEDjE9FKjBbgahl?=
 =?us-ascii?Q?E/HIrK4bz4ayxzQ/hl3rAHB09C62eG/jMSr6QzyajVD8Wdjw7bEX22esqw2H?=
 =?us-ascii?Q?LoNyeip5KBAoxpoosJzM0Y6X2yrlTVe+e6uzpuxf5YpZHJYshOFXgftGnd5k?=
 =?us-ascii?Q?kXIDHhH70EWu6N+aX/KJ3bvB+tGTFun942MHtkl29eRk6IlTf/uV9yl5cLDd?=
 =?us-ascii?Q?QkjBRk8p87Ql95ZVoPJ7lUZBGfwmNXhgR/4JykmQ3gkSisLa/cuk7AdyiOmx?=
 =?us-ascii?Q?oizU+UuUl7gX2fDxQP5Q/GsNVhg4moBz9J6kQM77eoaLywT5sQvH3y5c6b00?=
 =?us-ascii?Q?yuKVtYbpgiONneylBzTknWI4YXreDzHMI5Fe6PLdi05WMXsYO8DRbRDiQPcR?=
 =?us-ascii?Q?9B0rd349aPKAnGo+nL/4IxXQbCesfFr/ibcuo1tpDKQHxgwiiba36ISacJ47?=
 =?us-ascii?Q?THqQd+cUAw0Jk3L5zgna8FUwGJWhd7QYv123vHh5o3YyI1LMBe5V4UgEct6/?=
 =?us-ascii?Q?WKGmph9r95ApgbGcma72XJ5iKEnCmUkXIg4LORH4n2XvY6RCEJA7Hk8xmqH/?=
 =?us-ascii?Q?rD0e3tI2ABMdlFCEzvYYB1a/cwjwnMQ+PQzgH1mS1j9xW3Ey0C0h+ywPeYYu?=
 =?us-ascii?Q?1TZt/GWiDlnytJ3/BUUHc5X1JpbEvuqK3RXN1ardU58bK0BkA0sYGk3vjQfa?=
 =?us-ascii?Q?h0wg60ZSVVK3euw/kT9Rue3MpIuxO3sNDqk3zAyXBY5JYAN/KfSUjgOiyvnT?=
 =?us-ascii?Q?A2TpQEH+H7Yfmx/4LI6VSVsFahAF5scay7ssOpDhjqCo6a3u2eOhtjhr/0bO?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9320845a-a264-4d73-61de-08dc6812b70b
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:07:57.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOypm/fFQ6gHL4Xz8W6p7MTYi5156gkbi2gJ7grPJm5PZEYZDT6ZzyrbpD1lQRazR4xdFg+joNh85yyav8XZImKHZie+mQEubZFXKPJttkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1278

Skip sw fallback allocation if RSA module failed to get device handle.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-rsa.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/starfive/jh7110-rsa.c b/drivers/crypto/starfive/jh7110-rsa.c
index e642e948d747..4d7eb3d1e764 100644
--- a/drivers/crypto/starfive/jh7110-rsa.c
+++ b/drivers/crypto/starfive/jh7110-rsa.c
@@ -537,16 +537,14 @@ static int starfive_rsa_init_tfm(struct crypto_akcipher *tfm)
 {
 	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
 
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
 	ctx->akcipher_fbk = crypto_alloc_akcipher("rsa-generic", 0, 0);
 	if (IS_ERR(ctx->akcipher_fbk))
 		return PTR_ERR(ctx->akcipher_fbk);
 
-	ctx->cryp = starfive_cryp_find_dev(ctx);
-	if (!ctx->cryp) {
-		crypto_free_akcipher(ctx->akcipher_fbk);
-		return -ENODEV;
-	}
-
 	akcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ctx) +
 			     sizeof(struct crypto_akcipher) + 32);
 
-- 
2.40.1



Return-Path: <linux-kernel+bounces-64807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65485430B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138A8B24189
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D0111B0;
	Wed, 14 Feb 2024 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="RAqzv1t9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="ZDcSfglE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69FB677;
	Wed, 14 Feb 2024 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.126
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893331; cv=fail; b=ljXK2DeS5BwtJxOPrE0XG4FZmAsX2uRKq8wfkBjHQ35WqyKM0h+ahCVc00GXFBsMgE+3LsD138JMpZAeNyCddnsZKyFM1JvWzSessqZ2O0KPY2C949DyCEIvs+euTw8C9HxdCiKuKyuM7rT1qi1aRBEhDsaTPnLJo6FWKcdwyyU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893331; c=relaxed/simple;
	bh=XUQ2ou4NqPwOSTDpB+dmjzVjOrnKxYjM4BG9Fu/kdDk=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jCQtBvBU12D0eKj0kPiFI6CqiiDQcxlPkP490t2z8UjIsjUivEaTLG70kx9INTTjQ2sZUhqZ8WVFTGrf/2oTFtOqJertobKoR/0cnniB4e0OGG4dK6SKaHGlrlp6OBYcrBJgdRWQnTU7g3wrXbxEn0QipE5/WQ4vPh6/IXVsPWk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=RAqzv1t9; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=ZDcSfglE reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=QKVFi6d21auqfEu1EdTNa0TlFT1Va3D6nczD/JyQEH20fz8tNpF6ykpaKrN69vzzY7OHmuMdkdppBudvVIHEEXbyIDZ2plajkgRjMbY4H/6ZrLwFWTQZlj12lnydruZa7ht5KoTHmlwUeIpRpNkzxBVqg2dq0h3ePeDcv2J6iL/1BRlf6Uq0cDIXkoBgski+gJPkS9nUZ+vDtOy2X5gKZZexjLRO+3/ZgUJ8S5ts7rE5XUNqE4ajnEEeZEnfjpZCvuuSzDRBHf5QRHugsI0fEprz1YDCCfbbmppV56nyMYUD1/ZLOMWdtytXV9WP0hk8gAA5O095W/kFlwLYMSxMEg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DASjtvYeXXbLCsNZ+T1qlqgL4sNHe9UNo3IscbxMRDE=;
 b=LrpUafJ7w0jHWMSSKwoOape/VsgjUvS/LaFnS7+UuZwVbIa2+1xaRrmE95jqTolkWO4BTA8Va0NqqPHJPkSj0lIW0ltb0n1U1BX9XPq/DgdWZ7wm2m4X7VG/tK1ctoHeX5rwRv1tNqjbbN6IQ/4KLPEN/ulkP0pFvGaT5cYNBRU8N7rM5ScoEXVXq4JhPnQ/fVYffz+lhTKaJb6QA7YlaBgFf9nPQ99ZVNXwj5RIM57Od4jYuHBgA9vj4uKWj9Ry0jpViROKLEINTieWkFca94YqPWcBXJ7888/nnu5r410jhv/ybAnVzGHa9r5Z5DrUlYepfHUDL9RzfETfQW7VJQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DASjtvYeXXbLCsNZ+T1qlqgL4sNHe9UNo3IscbxMRDE=;
 b=RAqzv1t9KQCsxEqklIRB/6htYDxjy2v41a8QKCb1hMpU8KkiRaQHvEEVU/8EVSA9mYKjqOX0uVwrK+U+WaxTbEIbsH2er+8I3wNov2ivZ9rRe3BshGaUAoMVqZVk6wSIvCTybU69kYRZYwQpyICev2I6XunP9HwUCMhaJO9oqOpDNZQn9ilOrC8Me3ap4KX9DfVpn3zvx5UbEJ0on4A1SWhXLByUYedWWX29LgHM24erEPCY7vBHoW5OhNZ8DtL1Fi3u9iwdJ/GRDYZiSYHuXD5SKbzSRSQiSBN1nCuTXtWRy7ISblazo7UB8g/F3lgD9HPT1J6AHbsDWgp+mWMzJQ==
Received: from AS9PR05CA0055.eurprd05.prod.outlook.com (2603:10a6:20b:489::6)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26; Wed, 14 Feb
 2024 06:48:45 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:489:cafe::bf) by AS9PR05CA0055.outlook.office365.com
 (2603:10a6:20b:489::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 06:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 06:48:45 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 14 Feb 2024 06:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5XzDlIiAp3wOtTioKOEHCf6RHtC5slS1crJGybErKMEX94ujiDcEAlcVDT/zx1xHA+Xjejf1yxA1/Ueu3zgwh1abwdVpWQ/rXugCiG8gazmORpSt4WuB1qNSkPWnVPFq1TOShUkxLcRPDAhK47ptcx4fafMRpxfQW82C2a3635DY3heg2DX1I617w1t49LkfjbRcd2N4ka/TGjDDJstN95jn7u7c/KbCa5MlG8s4Vy0TVpbq3bhpZceE4EUMJ+102UxnPrapDM2A/wuwElwqLcm3ZSBOpgBZ9G4IT4iTq3Br5Q3FyrJd5/olCq1AprvkEGNDZAt7yyydqPQVxBbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4ULB+uPtoVZBhTLxpMcb1JkQDm7RvXhfsQCcK2sgHM=;
 b=MYXs0KpQpEMgn2O+W8IM/T0x2GqNqMOsBHcAhCwZCSmgxcf4jTUhQVa4nveg6Inc3TMCvH/ABxdu6yW9T3fCS5yPtyY2T0f76GBcL6vg7uqzMRHsi23yCVqjWZ+1kJ5ZpWfVY1JTS9z3X7AWS4wEoa5hKu1+6gt7ywkxhnIWA6cUnXr+53VuY1dn0dpk/c/hZrAOmnMJqVHQyJ8mRr6LpfSDjZDDwDal0y4u6sHPovprVYUJcrpEtW3lUVhIFEp52225rr04rr9NNWZlN0g1vESedFDeTg6QGxH7DVeNmq4VDrGGeZQJUve5iKGEjAzkv0OjkVt/g1ByK8nBleyFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4ULB+uPtoVZBhTLxpMcb1JkQDm7RvXhfsQCcK2sgHM=;
 b=ZDcSfglETPqEzwv1MpmAgfNHPVfXpjXkwe4cUVWItaNpLPbDx2hwC0Ur1LwM0GcJRC/6LCac31ajsIHbOecXikolsGwk3RSg60TWHaN9sbts68oDu+BM9kTrDp5ks5G8MKiS4x5uO0xURmMqg93zyoRns8JjjkAuYbwROoGi+TL+B+sY+Gapgc2+hLfl2nZvB/l14SNeTFKFj2liIHdqT7fEYgwQdH4YcRF6C/B6SuZSPENW8QK8HR5jnXvHN5gQ1EXAK/yl7z+W1KMcPgFhnYOaurz0TLPOzxEPBOIIQ/qyE/SLgFR6SJEM0Cvrb7WqdbiQ4nbwPJmbVey7p+YCqw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Wed, 14 Feb
 2024 06:48:42 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 06:48:42 +0000
Message-ID: <44d0a115-1a8b-496e-bfa9-89caccbee5bc@topic.nl>
Date: Wed, 14 Feb 2024 07:48:40 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
To: Jonathan Cameron <jic23@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Beguin <liambeguin@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
 <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
 <40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
 <ZcJLnOiFoaABami1@smile.fi.intel.com>
 <e04ca010-289c-4216-95ea-2f2418613378@topic.nl>
 <ZcJfOgDMmLBpEho2@smile.fi.intel.com>
 <11613ba7-fc14-46bd-84ba-a0b5d966cbfc@topic.nl>
 <20240210162704.5126478c@jic23-huawei>
Content-Language: en-US
Organization: TOPIC
In-Reply-To: <20240210162704.5126478c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM8P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::30) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS8PR04MB8546:EE_|AM3PEPF00009BA2:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eecb051-4600-4463-6812-08dc2d28fd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 nhU57gFkD8qqcmpnnNlg9sgxR6AsHdGQOun0X2K+H+S3/Ok165iTeNoC54UDG3zfh8oRoDOvo2k92VMxwbFRWRkZsd91xPuCA5n95RbgJ72W5I4ywviCEKK1gJG2ngteidtqv+9vSx2q53hSQBYlL/FRXH842W1X7jzrZcwCOgcJoBId8o9Swd/yrU7/sl+aCrsxTW4FMRP7ZBlqmXurWOGfaASSqLfWrRN8tMV8yvvhM0wrYCNcYeyyYfMZ41tKDtAWhbZSIXZf4LW+jM+bbmYAbUpbpYUeuak166H5twiYJ9avYDbb4+XL7Cxw63BAkk3pK9V4D4amhRr1rBjFx0XMskdSi5fLd/RJo0h2leerAFb0tlNaYFmhiceUl9PYN7sUfwsHSd5CC4wlT1N10gia8Kf3NMMOZnPBADDknmJOeppCztIxkT6n56GiWkL9cQU9/ZwOTcecLzZr+/fK6WIENUA0aRau7Xg4sDfyXUKFg+ANa1LLtMgv/NuLrXSw6jCatkRLvPKeVIYx5Rg88QTGKNXydcA9szBee+kmeXw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39840400004)(366004)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(6512007)(6486002)(478600001)(41300700001)(2906002)(8676002)(8936002)(44832011)(4326008)(7416002)(5660300002)(53546011)(36916002)(6506007)(54906003)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(83380400001)(31696002)(86362001)(15974865002)(26005)(38100700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
X-CodeTwo-MessageID: 0c8796cb-c4ca-48dd-969d-de62a8130f03.20240214064844@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fd1eba66-f8d6-481a-7f07-08dc2d28fb69
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9mRoyoVvYXTktEb0KDCsWNLxo2t5f2iBZEa1JpbfbqcOWvmBMBxmLeANfd3o3B8SVG/xkEVMFx1bi/w3tJ9MazpO0jF8njsoZapeFpIc472MvP5QcjOUIymUUD1fWKvmUbBLnNOlNYVlEm3gwQekd5dWTDpCXbkigDLRxa9UNUvBTSEPyZGhw0XEI0IzIRLvUZyWH6EbgmEY+xhl5NvXnyN3mf2pkgMJHUrqO98ScXOm2aHCFdWUrp19y8gkDq0MaZWD8rmWo1WQ96/x4XIwAU2WM9xuOZ2Fi0hfx/YT/4eTvP/+k6nezPtaDk/mhs4ohrMBgvbC2fQ4Sfri+C/8zXvDZpaU0pfXtS1W5zMv8UpeeP9bISKH2wLI8NSt99eit481bfqoncAzgIxcc3YkIJII/jBQUjaCjDrbrqijUonuscxE/wcNDBFGqlpvOp7VwEtawK+kWoDiwjW1RCqx7YrHlLjoZJ1a4slR4/zF3R77rQdX+oXo53kHR7mpPBfskndRWev4QEaYXoFdxRV7ZWKfNvwEruydW2Mr9uOJDNV56MRYKvoqOzHg+UikDwQx68KRPBp1kY1EYhq1aY9b2Q==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39840400004)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(44832011)(6486002)(6506007)(53546011)(478600001)(6512007)(54906003)(36916002)(316002)(31686004)(7636003)(2906002)(8676002)(6916009)(5660300002)(7416002)(70206006)(70586007)(4326008)(8936002)(31696002)(356005)(86362001)(36756003)(83380400001)(26005)(2616005)(41300700001)(7596003)(336012)(15974865002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:48:45.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eecb051-4600-4463-6812-08dc2d28fd58
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924

On 10-02-2024 17:27, Jonathan Cameron wrote:
> On Tue, 6 Feb 2024 18:38:29 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>=20
>> On 06-02-2024 17:32, Andy Shevchenko wrote:
>>> On Tue, Feb 06, 2024 at 04:44:03PM +0100, Mike Looijmans wrote:
>>>> On 06-02-2024 16:09, Andy Shevchenko wrote:
>>>>> On Tue, Feb 06, 2024 at 03:47:45PM +0100, Mike Looijmans wrote:
>>> ...
>>>  =20
>>>>> But it's up to you what to do with that.
>>>>> Maybe Jonathan can advice something different.
>>>>>  =20
>>>> The spinlock also protects the call to spi_async().
>>> I don't get this. Locks usually protect the data and not the code.
>>> Can you elaborate?
>>>  =20
>> Either the DRDY or SPI completion handler will call spi_async(), the
>> lock assures that it's only called by one.
>=20
> Arguably it's protecting the destination buffer of the spi_async()
> call.  We don't really care if we issue two reads (it's a waste
> of time and we would store two sets of readings but meh), but we do
> care about being sure that don't issue a second read into a buffer
> that we are potentially simultaneously getting data back from.

Indeed, that.

>=20
> There are comments where the release is to describe when it can
> be safely unlocked.
>=20
> I'm not super keen on this whole structure but I don't really have a bett=
er
> idea.  Who builds a device where you have no latched way of seeing
> if there is new data? (some) Hardware folk love to assume they have a RTO=
S only
> talking to their device and that no pulse signals will ever be missed.
>=20
> We get to educate them when ever the opportunity arises :)

Even on RTOS this chip was a pain - to get it to work reliably I had to set=
 up=20
a DMA controller to run the SPI transactions, which took some smart=20
daisy-chaining (I recall having the DMA controller write to its own control=
=20
registers to avoid involving the CPU).

It's probably possible to trick audio hardware (I2S controller) into grabbi=
ng=20
the data (my chip doesn't have that) without involving the CPU.

As the code is now, I can grab data and display it with the IIO oscilloscop=
e=20
over network at 4kHz without losing samples on an A9 at 600Mhz.


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




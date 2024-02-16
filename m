Return-Path: <linux-kernel+bounces-68778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A310185801D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A48B28357A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587F12F38F;
	Fri, 16 Feb 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="VdxryVev";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="P9VsyFTI"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2136.outbound.protection.outlook.com [40.107.21.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9412C7F3;
	Fri, 16 Feb 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.136
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095899; cv=fail; b=Oxp36u/kxZ+mNG0A5zeVb3hbgNWNeMA45qE30OngVJGkj3Hba8mny3OT+AvSHTBKnUGWAXDsUPHn0BDxHbJrqd1AFbTjYwRg0o6Zk/oONHPB7PaqGibCRTuxWY0AJCSSTj79uvGoGKVcb5WIvR7BblWtrLqCsCmE+o5uSIFlnYE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095899; c=relaxed/simple;
	bh=nBCHD6x/BjUEO/eBLo3RKmZIj2PshOQd+HsW0V7WZyw=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qdJGkcrPJqNh2/q0MCnDtEcSRHpZ9E0z7auNaXx/GdoYyw9WbdIXtor9JsFjZE99ERYHpUE9cHlc77eBQjSxqBo/R+tG57rkrZB6PMDXL4ifTgH+Xx2b8a4h0BHWu8KMf7j0dkxTSfs3tUkVU0GME9iRTkc8eVbydBBaFbSnIGM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=VdxryVev; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=P9VsyFTI reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=bvRMOA7XzGjcPCDu0tUGpJPFKTioVI9xjATpiwM6v81eWvy9OK6cZiobay3iNdHTZPtraiFbbSv+J5xeU1SeJQyeFpfZH1bTsu7Mia/jWipNq4RokADivq1tG4u+HsLU7vlVk6rqXaO3cvqZbjx1Wi+yiKtRZEvH8oi6/NUB6tI6DjTHzzCoUCDM80XZ4Y43UScuu8KyUDmeCxjLJzRHOb+klXW0ketnJxPnl8WSEv9j7ho4J2k8xUPkk7vbY8xOgiGwfD43AnLGnUMJldYUg2CYw4ru4yLBwv2+VErJoMWwy2gf3ZaCnu8W4XaH0eCIq5JQzZkgZtGWSd4E0ag98w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBCHD6x/BjUEO/eBLo3RKmZIj2PshOQd+HsW0V7WZyw=;
 b=YF5EBtCE0P5pixy4TBjb1WLqFZOT4M+jZGiLza/FHS8pt57JYvW/uCxjAzqTMNHOEwOHCMDHR2qE0j8+Y8eHJWUUcMkvL2WO2eGVFY+AuPJhsepbAWPb3daqStnPDEl81smOm1aVJTpDNeoZbFTHMCW++Zn4RJSsqisOdKMkHKMznVVIke7OiIAjbcvvIH+Mwljb+nBEALr3DUyyUULhDIE5LZ/ov8h1OFUm7BJStfNGZjVE1jTMyy9WnQ/CHihPyv8+gkE67lfXuwR0n7+tGDm2ODp5dAtHEcLcLY7VkECzLbaFO09LdihOCWvwxJTqne3mOcjJBJxQnOTKqo3KHQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBCHD6x/BjUEO/eBLo3RKmZIj2PshOQd+HsW0V7WZyw=;
 b=VdxryVevC03ztoVKF2PMWrUDbWvDnOzot+0xCeC3ADMV7CnwrGv7ZJ4FlmAzrV6OdpxQjdyj6CV8Zrvd4nlLT67yS5wwDLEmP/SBSZ0p94iPBm+CbR+dkH8zDA0NfGgZuis1+KN0Q4nVe5meQy+mGc/VWimjDw6zSJeV3MkO5WmE22Ncwi/vX0bSw1IAQCMUqpCQbteubVAtcC7/4Y2kinbDV8Yf6y11lUUe1HXyr1y8fxyIQfdn5/MOx6yErMZRRww4Is2q/g6uImDjqtJtc5MESKsfIWznzEz1zHoiiPAMq67TEJ1qKNkIAJlwBysrX9yQE0qFS0lQgJXtvNSREA==
Received: from AM6PR10CA0080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::21)
 by DB8PR04MB7033.eurprd04.prod.outlook.com (2603:10a6:10:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 15:04:51 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:209:8c:cafe::a5) by AM6PR10CA0080.outlook.office365.com
 (2603:10a6:209:8c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Fri, 16 Feb 2024 15:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:04:50 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.233) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 16 Feb 2024 15:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWdtrm5opDozj4BRLcxbJF4/58QYzsR5vsZEEJ9KP43uoiPUBw7ZQOzWeoHZr+nJeMW38jx25eJavUNAZG7TuQMz5LgnJDf7DYewXUW3dXN+etjBf3HivGbVywFByouMq6k6ScdRXXHzZqE3CX7plFYUou8sJkrDgJVEhctNkJPKu7Gw94RFdYs/Ddzk9RwqbyjElZgXCe7cKZ+pKBbWCATqwN7W9is1b1ebzQipGnB3cUpaJ8RjtX6Pj8ihei2yliPYR3CZYyjeWfzfmhhiMzVQOdY1in1cjFXK6tVor8vqG0c5n7SbXadOkvQ2+dInp9Bl2ZC9BV1xbQLg23vr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHeiOTQ3viiI7aVgjEVoppLR4GQhFFpFIhFgAF9/lZo=;
 b=buZfmKLJYTxsCEpfHm0/Xp60qAS5KqjfLEf6lV4K/US/JcxRjtqfAsVwCgQowVUXouwXq8vUAsSX/xsk3AZQPxgPR3Znrz0Oy04bjVpPYuNKNGOdPjXrNgQIxZnOLpUUVUsiiKBxAtyPvQeK0028IX7kwf+vxd9Uh2YKFnr2suLANehuJH2CQrKQTzCeLTb/y5DUSzCEngVcGsEhuFeI4JzoIRyOurQYGTWoLmQlaj5MMqNkR0ZcV7AKHM7NYr02lo9zfju4Sad62svjbJQKnYawkeGi5AQBx6rguHooVVRXMUlvthkpipoY0EFsn3aPkKYEiPnCAyFz+VlAozmTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHeiOTQ3viiI7aVgjEVoppLR4GQhFFpFIhFgAF9/lZo=;
 b=P9VsyFTINo/nhLjhcCp9UJWMJwqHAZLGfrjpRK1uQ8fINzJK/pfeUoN4VPDdigGwEWvdo9H4cRVYXPoAnLuad3RqyhKun6bwtpmXxW23x60IGpN5u2wHFdSj4Ie9uP73n/Fqot4qnQmt3gjPkw9vE9axNqXa6wTRadGvdGzXAwlbqUtCHZMOCZ86skTj1QOqxtRE/XdjLFVXjkUjOpC3GPVtU8K/Y5EudpzLXumV6i464qZXQBSF0NQ0m0jnyJxnvQpaxiJFPW0DD5+bw4j1GptVWwNLYoGfcNJTLfLDIHbgbpyXrNOzDUjZ5DUTvaP+SagmZKPr//VlrlNhARScqw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 15:04:45 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 15:04:45 +0000
Message-ID: <14f92c6d-7c26-437c-aaa7-9b6691cb3042@topic.nl>
Date: Fri, 16 Feb 2024 16:04:45 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads1298: Add driver
Content-Language: en-US, nl
To: Jonathan Cameron <jic23@kernel.org>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Beguin <liambeguin@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240214063736.88283-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.da2f422c-5c6b-41b4-8916-d1a90f0f0973@emailsignatures365.codetwo.com>
 <20240214063736.88283-2-mike.looijmans@topic.nl>
 <20240216133816.18c42c99@jic23-huawei>
Organization: Topic
In-Reply-To: <20240216133816.18c42c99@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::10) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VI1PR04MB9859:EE_|AMS0EPF000001A2:EE_|DB8PR04MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f00a8e0-2caf-4421-a825-08dc2f009fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 kQHywVQczUJlMz0evUsH0z+rU214MydckbRky9kQXu4SE2kCDfwWxYQ57wmu9RBBvgk7X8vl5CeTLbN/MRNY1juJg7pCI3cXqmqu0Uas7LLZwqFA/oRY15Ce+PPIkDDAQJmuhQIFFj+DluxP7QoIGhla938RYtP6yLtsIZKoeC2OQoqQIYLDzlNjw4WJ0W1GxG2Pc+QfaF5iUKFQvBfrYfCbF6XImWe1GpYCFplaJwc4jlX7rnTFDynWfmWgbL/tyvoBF4JQhU13pzFefLA/FipR+yIBoDYRuKPGOdq+sheq06ws7VGKFBnQvt2gU2YwqKb/RmdFskL30Ky9/WGuDoqUdr2//hZqSGHjLgxZwJhpAuR5+VqDbQTq77cpjxwEQE55hkWdDCZZ0j5frHnYB1a0mtkHqJ51FOijQaH1wIHpjG0fdThNJKPzY7/F4pYcLVDpgr9J8NPL54nK4/AZwqQJfd5NGkDVz4EfdLVr7TbAGL6c/gcxZGPxy36K26ga+bban3/ljOLQynCvp2xL9kUgk52Ugk3pe9338GrbKYjP5sU/MGoR1ORzh+/l/9QYjFnfI+P/ibavhgcgrCdb/8lO0c3t04JIqawKv93TTHE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39830400003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(478600001)(6512007)(41300700001)(6486002)(7416002)(44832011)(8676002)(8936002)(4326008)(5660300002)(2906002)(36916002)(6506007)(38350700005)(316002)(52116002)(53546011)(66556008)(66476007)(54906003)(66946007)(6916009)(83380400001)(15974865002)(31696002)(2616005)(26005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859
X-CodeTwo-MessageID: a8ff0e3e-4cef-41c9-b468-216565b5e2d9.20240216150449@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2939d137-ec93-4c7c-dd35-08dc2f009cb4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yijI5kSD7L5otLWHgo6IyI38JHSCihYr+Io+S+2hC3B354L2hwOwbfFJE+v2Y5MZjMxoAMihOqFCOVcgHPtt2ZMAndpZCbMt+det8rBsLwHsBdlBwBmBRy9rBbN+qCV+j1Qh6RkCxcrbqzii98w85dKFyo3qW4f8Dr91ClzyMpuvemh2i1+xN26zNG6WwDl2FhTx6tcn22qfMgscs/B7k+QNcJmD24aMtAaQ8J+zKrD2GrZJGMPDk9XwSXaIqfhId5q1utUI5aj/bzPq9nuiPyYSWORxTMOu9lWqVt9BGF/wx9Kh7q7l6yMiil/SbQHUrZRVkFyc6NTDr1frpduIgGYxOb85UI0ZChbV331XTkFMcNW5J6WByfObizVhEiC/1UPK5Xl7PNjlLEAzdyNvyHZrJA3LF17JiZwNg3LkPRUlhQbRdCCBVM8Vd00zLYYRS5PnZu5y7uG1C8tirAOmqo0MSfX7SgO5BuxCTPUAULDFln24p3Wj0CaARypsGxfX1VoXAyopBRKyDdQlYhcRBgbwxqbIEdawztGPLjymAlrXekAFNSEEIw8/HjxAOOaWy631cV7lujYOR9PNIP1invpfXl9CaM2tjyzJ8XSvpR9UVO9DOLsa2pgXS+h7aglyZoGJwieKT42rAN95j3ybOQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39840400004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36860700004)(46966006)(31696002)(7636003)(86362001)(356005)(15974865002)(7596003)(36756003)(6486002)(36916002)(6512007)(6506007)(316002)(478600001)(54906003)(41300700001)(83380400001)(336012)(2616005)(53546011)(26005)(2906002)(7416002)(70586007)(70206006)(31686004)(4326008)(8936002)(8676002)(6916009)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:04:50.6401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00a8e0-2caf-4421-a825-08dc2f009fc6
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7033

On 16-02-2024 14:38, Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 07:37:36 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>> typically used for ECG and similar measurements. Supports data
>> acquisition at configurable scale and sampling frequency.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
> Hi Mike,
>
> One final thing noticed on a (hopefully) last read through.
>
> /sys/bus/iio:device0/name is going to read ads1298 whichever
> chip is detected.
>
> Would be more useful to users if it identified the actual
> part given that is easily read from the ID register.

Implemented it like that, the "name" now reflects the chip's information.

While at it, I also made the probe fail on invalid ID (tested by probing=20
an empty SPI bus)

And also pass the channel count into the "num_channels" member, and=20
adapted the SPI transaction, which should support the devices with 4 or=20
6 channels better.

I'll post a v5 soon, bit of testing first...

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl





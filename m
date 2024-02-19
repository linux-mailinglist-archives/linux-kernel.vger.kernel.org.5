Return-Path: <linux-kernel+bounces-70791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC048859C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD22B21011
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF2200C4;
	Mon, 19 Feb 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="juqULdzo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="bauEqhdz"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2117.outbound.protection.outlook.com [40.107.7.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44F200D9;
	Mon, 19 Feb 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325819; cv=fail; b=ED4yRpn/9RtO0DaOOeaYb2pZhItF5nNh6nlMoips8A4RQw4edACciFEWE7UhoVtE6cA1E+7z5UenIlOK+3OsNWDcT/yXg1Gg7nbuSlv+FycT4S+ofTRMncFDLDJ6umHxJSDirrdplSUKTqMXqNc1wLv4riN/at04QytE8hS3A7Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325819; c=relaxed/simple;
	bh=AoTIQNGNLTGgmyNdlCE1+cRVqz8nUzISvVeXbCU8Nl8=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fPgiLzO3X6obwSx/hzSjF96MN5b8yCnYFaDPckPv3cGE3hiabqsjrf3IPcWI3DBcHgKZapk829yQWqflNM4CkwUMBFaXkONE3DDfTo3Mnb1FHXXjHvyRoYXfqun1EQOKlVLG2klajOI7Okvm+6LWe2qZT04E6g5kgFL8zayf4J4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=juqULdzo; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=bauEqhdz reason="signature verification failed"; arc=fail smtp.client-ip=40.107.7.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=jj9KFZ9squpIOYm8k9GtmKWztl3vkj/afeCojCVCrVSFQqA3/dUT2nXONRSDQapnqoArw/gmzX4R9562fP8ADJvQJqKwMBGR+exZIYKmNB/lYE0SEUf1bUFSYMtC5AU4Dz5DfFZTG6InatQ3ZTMAmV/aUEA8a2rZER+2oNhuM4JGuv2qkUi0PoFluUBe4mNbyjYmzhAWam9xJjb61RAhUGD/w7JaIgXbTOSR8BSS0En89Gq6J4cUJbIo1mQde5h4Yrw74EuoTIp9p7yz3Vf+I+RftAykdZsU8WAkWZdW3YxP8qby0ygDeGMQoj8IzZnECLTPcoqKGebK/Zh8enW0Eg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydg5MJug81uFPZaeIVvmARZbAr9QhLpyjURZWYsKwcA=;
 b=Ja3QoR/z3jN8bGip3fvsGRGaCyKuYI34de4lNICOj3veOqmFaS8E0+AVnpl/Zyhnjxpqfo44N10bfWFlM13wTmdyGIJaoTPapL88Bo39Jo1hwoVT6+vj00VH92kKxQOmtDKdoAh8w2lBEvazdqOOiguUkzY+nr8xDagVRH49C+taoBtM5tABehcTHkaoQrs8/VE+BymWZ5ZPftzHTsN2J6iJGuB27vMiLVDRAe1UzZnNDJDiTga3Uqh4a2f09Va0UKDbLvJW+q7vs7qP48Mo4jspYh8ufhuzNPWd5tN7fbLNZ8ttrOSdcs1KicRWnpWHslE8mZ0Y9gdAU9JT57Xw4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydg5MJug81uFPZaeIVvmARZbAr9QhLpyjURZWYsKwcA=;
 b=juqULdzoRKuEFMs0ms8ZcX4AexZKoi02Gz//AbOQvkUZRcRaOrzQ130MvaJ31adbW9fcOSZRyyviZB262AZz4w0ofV7jvpGOg3M86f1OT13cGYraHSK97SZmhHE80pOAVWCX6Xgw6EAc0r19mrZEfGjgzLQ/ZLwmfjCO1/gFx2zyhtPRhBYn+ioFiwvW4qIvHQjCK/4ZmHKSD1c0ePeda73fYABqOaCTEwduKqWRspNEPExPsF4vrYBAF2EGX2aMqjkeWS2Ijf/xon1Pb4nLa43YJ6GgW3bB8dMo3C0dml2xCHYu/7IMySxDEHiON+G4oWHc3HBR6Anrm63M8Lj4Mw==
Received: from AM6PR04CA0050.eurprd04.prod.outlook.com (2603:10a6:20b:f0::27)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 19 Feb
 2024 06:56:53 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:f0:cafe::9e) by AM6PR04CA0050.outlook.office365.com
 (2603:10a6:20b:f0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Mon, 19 Feb 2024 06:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 06:56:53 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 19 Feb 2024 06:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uyu3KLCjmiQv2tpOF6myB36nBcb6/Oaumw0TXEvlVMzByskthPLRCxxE3ArxtcoF1vxce7VHNx0uMny/6PzvCu190sQVlsgrYWYZTSUpBW1A4Q7v+SVDKd7DhWOoK3MX3ujyFR1FT0feo9aU/UMOPoOBboEjPjxMAr/3SCooOY8Tq61HlDnzfgIX3ad1TKvos8Q8ya4sF6BKShD/zOgoBWF/+fpid1NuyDbNdpZp025kO/nDECwXLlAfb2TTsxup/+/rxZVIRXN5Xqq8xHPh6awgDBDn+UQ3i5lXc9WTx7HCjRxUsvQASGGJjjfgAW4R3M+zMBVn98ThYyg/5Ofcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCgGcBdN1jvIxFWtUONt7cyZW8tqNpJEs9ff7GH5uiE=;
 b=fDdCu4M0pLJ6wc8THeQduyt99i7sEtxEVQ5/wHBH6XWMbub/x7TPYUeoEGgBK/nd4mngv85RzJLhm9Oet96TPFVFQ94zjnlqp3P7z/wQNEKqocVacGi489acwl2Q2ewO4leBJs+2RHSCwHiNATgQESBB8lP7r+pSElPniaHEcVS6G8FIfXsnWxgdoDZvikxBTbCOk3SatcwK+iYQZbHyrXwIFNB4LSIn6iFtGDy2epZRpw3mh4hDFZpxfYAGXAMAF7heTiWE6cbBBraCOh3DaYdU3/undsO7OOQ5voi8sgzjYJRx1Cd8Un10La/eHZauSAI6tMRk+BPILprlKXA4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCgGcBdN1jvIxFWtUONt7cyZW8tqNpJEs9ff7GH5uiE=;
 b=bauEqhdzJ1LNJeeLGGxZQyfsvTdCjNktOOsFRp684GzeuAst1EQH8cjn2vx4X/Yew8K/Z2V5Lbw9iuaMUsqsIYx3HSTCLwmJSi6lSw4KFs+cFlgOtSUp2WUq2q/jaR2dYY+vBhqMZNVjG/UffzxrljnNZ39adlCEkanSyn26FBLgmGuXODxa64Dn/gTlpQmXyUpEAwd3kogqZF58Iqm8KryhubBVWzmkP7s/q7wzXIXRzdIARBevEHy8WyxT3e69SAOr4S3vFfSE0N+TV4yH1XHGoB+w03rXfFNCnDd2clrZ5HgByXUhiWXxW1m/nP/Jp/z5x+tU7gGTxGfqvTy5Tg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DBBPR04MB7769.eurprd04.prod.outlook.com (2603:10a6:10:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 06:56:50 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Mon, 19 Feb 2024
 06:56:50 +0000
Message-ID: <c386a274-fae3-42ea-a2ab-a1c194ca2449@topic.nl>
Date: Mon, 19 Feb 2024 07:56:49 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v5 2/2] iio: adc: ti-ads1298: Add driver
To: Jonathan Cameron <jic23@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Arnd Bergmann <arnd@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Beguin <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <Zc-E3-MNe9dG9tdW@smile.fi.intel.com>
 <fb7d41fc-328a-4ce1-88ad-5ce22ee158e4@topic.nl>
 <20240216171921.5a6b6b20@jic23-huawei>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20240216171921.5a6b6b20@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0142.eurprd04.prod.outlook.com
 (2603:10a6:208:55::47) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DBBPR04MB7769:EE_|AMS0EPF0000019D:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 491e2fc3-1cd0-482c-e9b7-08dc3117f474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 bUU7U5tw7l6kQ0qvLshGZxgBsOFNvDt/yK49IXtBwg0RvVpQx8ZQ/+vJcLzo9Bv7V86CufwIv/FgZbgqsKwEig7hPlu61ewZB9FyOroBiFM8u8uBjx3xrmeG6alFF8ZHCPawSzNutAhEgXxPRwVDxRh5pA1js7uYXDx6R6neTds5QXb9uXNdFOkEkJTffGB3cr7zI1fKVR+N8saMZvkvMO0aYkLb+BqDywrf06UWaDjkt8TWVPnP+jxGN/oH1Ud+8Rjv0uY5dbNDtp0oNvxI2F4+3fGN7PMuq7cucNa8y6EACncYP/CRihMTIdatybUkzR4dKxqS6yyDGhKB1CQbxHNUAyCbMojaJhYP1AkEFdHect32Dq7FbFWxx9pQQUH4lfth+oehA2HYU4mg57LNR1Ub5mXEE33Xtuh8e7iiaVU9k02/U4q4AYziPY96dihR49Hp4mTVbAl4c+xBMtpEA3uFs0Qk6KJ7SBQrwxpyML5ANnaLgVdzvCwDcrBLAwAjbEmCbLxkZjWWo33wkX3lv1/FKbb9p3QpGw20kEFMKs9yiXkaKYbI69r8ylNsi8xbMzCZVlDL2Q1H4QTD0FbsCGS7w3MkMM5NmOkO9oQnwHc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39830400003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(54906003)(316002)(5660300002)(7416002)(44832011)(2906002)(4326008)(6916009)(8676002)(8936002)(31696002)(86362001)(66946007)(41300700001)(66476007)(66556008)(6506007)(53546011)(52116002)(6486002)(478600001)(36916002)(6512007)(38350700005)(36756003)(2616005)(26005)(83380400001)(15974865002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7769
X-CodeTwo-MessageID: ac9f4b86-d101-4816-adb7-94b073a112ab.20240219065652@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dee7e3e3-f022-449c-1d6f-08dc3117f2b7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rkgPznuWSbfH1csF9iRdlCacaWaJuCoJFQ1byTZ+rFaFeRqFRw1j7ErRpe7Z8eDyAoTdqF6OZc+P8FNRm/05hnIHtEkQzKDkOiwu/Sf5eSfcDeLKnXXpeB4n3a7z3hLHv0unJLRT10jTZStAA1DB/brpz68tZ0w2pvLIyLNUutVYAv8DIyh7D+OQltvnajkR0TOJBxgTHUtAP2PL9UchPvnbKRjQWuN+uA5yuOk4ctZfdMyH2Timnb4YTwoZ4QIktDgRhEj9xhdSFpenvyebn7VWRm8jZ8Ldd0lXdvYyHtDKK1VcNzBgmxiKvfB+tDiACQhGRdB0VEyK8qvje6E4SvJqj5rYn8OWzldGKJ9ZikIbN2a1eBov6VcMjziKkGikzml9LeEjuisrH1RKs3MuU2jLs8lP+I1H16qmWRJikxeiUOsf30shKBPK5Nkk7tpX7mroQ61CeA+yUEzucynGKGr6J/Dj6m9LdP64dacDaqSQgSXLL/tJRUXl1+Q/umoN6N9lkyOoqCFmdt44UWRHjWOr4FkXL3dwJ8JBFCwyMXB2gjfKybsISYUHuYeQMkz/fry2SB/Sf6c9g4ebYgol5a+FYxrNys5e1BX+b79f+J6GreyZkem7w2ztfdE+gA0rKi2hPK9mKHubukAKoLMgfw==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39830400003)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(36860700004)(82310400011)(46966006)(2906002)(6512007)(6506007)(6486002)(44832011)(15974865002)(36756003)(7416002)(26005)(70206006)(31696002)(70586007)(53546011)(54906003)(36916002)(336012)(478600001)(5660300002)(83380400001)(316002)(4326008)(8936002)(41300700001)(356005)(86362001)(7596003)(2616005)(8676002)(6916009)(7636003)(31686004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 06:56:53.4610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491e2fc3-1cd0-482c-e9b7-08dc3117f474
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

On 16-02-2024 18:19, Jonathan Cameron wrote:
> On Fri, 16 Feb 2024 17:07:49 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> On 16-02-2024 16:53, Andy Shevchenko wrote:
>>
>> ...
>>
>> +       if (reset_gpio) {
>> +               /*
>> +                * Deassert reset now that clock and power are active.
>> +                * Minimum reset pulsewidth is 2 clock cycles.
>> +                */
>> +               udelay(ADS1298_CLOCKS_TO_USECS(2));
>>
>> This is sleeping context and you are calling unsleeping function. I have=
n't
>> checked the macro implementation and I have no idea what is the maximum =
it may
>> give, but making code robust just use fsleep() call.
>>
>> It'll actually delay for 1 us (the "clock" is ~2MHz). So fsleep will com=
pile to udelay anyway, which is fine, fsleep might get smarter in future an=
d this would then profit.
>>
>>
>>
>> +               gpiod_set_value_cansleep(reset_gpio, 0);
>> +       } else {
>> +               ret =3D ads1298_write_cmd(priv, ADS1298_CMD_RESET);
>> +               if (ret)
>> +                       return dev_err_probe(dev, ret, "RESET failed\n")=
;
>> +       }
>> +       /* Wait 18 clock cycles for reset command to complete */
>> +       udelay(ADS1298_CLOCKS_TO_USECS(18));
>>
>> Ditto.
>>
>> ...
>>
>>
>> If it's the only issue I think Jonathan can modify when applying
>> (no new patch version would be needed).
>>
>> That'd be nice.
> ok.  As this is still the top of my tree I'll just tweak it.
>
> Does anyone else read fsleep as femtosecond sleep every time? :)
> Maybe computers will go that fast one day.
>
> Jonathan

Noticed this triggered a kernel test robot report. Sent a v6 that fixes=20
the bug.

Can also make it a separate patch if you prefer, in that case ignore v6.


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl





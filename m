Return-Path: <linux-kernel+bounces-59872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DE084FCCB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE81F23294
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4508289B;
	Fri,  9 Feb 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="L8odw7Pp";
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="L8odw7Pp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2093.outbound.protection.outlook.com [40.107.93.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEC54F86;
	Fri,  9 Feb 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.93
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506762; cv=fail; b=nFDBpA6wLklU7QFN1lGlp/sUm8rX1B8PCBuIvobpjZ1AJBFSs9jJKf+F1aQNoa31qd9N9otxlnOeiBMw3uATXu41fZYGm6qvmAOcbdrJezciQlKO0E9BEA6z5uJyw0S//rTZ30O1Ymk5XgoyInEPiqeUqeSU8y32GJx2Qd5WxJ0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506762; c=relaxed/simple;
	bh=9jXD86X7/zfk2ClTLMdomEoipwQf0wqORmrBQT3NpAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gXT5tY/IfJVYcM0xS81hCmxQxUQvatozAexfyML4M/N2ILXLBqg1Fjh9BlZW3HpxE5bzrFnx/KkWj+nMNiHAWf0rGg7sXrbA/O7XpCPS2XCaRXpPJ6SovG+r/IHFSAjglnwUlTWXmUPry2w8XhWxGucu6e4OERIYJEGQrcj0lls=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elektrobit.com; spf=pass smtp.mailfrom=elektrobit.com; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=L8odw7Pp; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=L8odw7Pp; arc=fail smtp.client-ip=40.107.93.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elektrobit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elektrobit.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=OWdbBWUfzSRFJryS9zVPXJxpra/GZCT22k+6yT8Wtsm8Pe9VC6k+vEtRwM0SlzGuHzYAoFTtWANjHT4E6p1EHRw4SPB6zhUYDNPbo76/MstUCmEFLRKwmzuN5Rdfzwl8CrjUc7v02HUNLHs+03egvxBaYDAO/YJ3elcLfpXECHdDDwrwbufI+ZMoqtgfkDYXMFmxDXEtPsSyff0msE2OlNhs8gOo0Bios1HgpTbxzrFwFY44MxAQo060yYw8OGyi+k/Zwo7ToQx4fCEfQWLg3BFI6zrBqBbM5ch2nQwA7r9sC6bhPMpqR3EB16ORXiDgxzoPttr9T/KeMioOW7tx0w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwOE2p4z3KzL1M+HnYefvC9KBA8ss61PH8JVv8abnXs=;
 b=SwmxRt3CaRkfXdW1HHJdtWJsUBQicR/iBeMJgZ6MEho3IK+KriQ+bChosK61IDUrP8m9CSOG3dBgmcvPBQ39Ufugz2vzV35E+506TJ5OHXCGwjwVnUDgcfczC+Ev7ywPRkOUzApwWv/TiKmoG7US03NLn+06Yaj7vLC59kRr0aUa6oh/FbAoXFa489r0fTLyRpeGHS1voeY21wpgJ30BuGH7aXw+w1N/qmE9B/0F0wzktL5ql51qD80Q5U2SnwBi/K2KICLuWoAHYfdsknz3Ue1Xb8766cshaSnkTYTPUumuTWK7P554frS0n9xbp62FlDRreQLuRsAsHOcUVpjM/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.79.107.243) smtp.rcpttodomain=gmail.com smtp.mailfrom=elektrobit.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=elektrobit.com;
 dkim=pass (signature was verified) header.d=elektrobit.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwOE2p4z3KzL1M+HnYefvC9KBA8ss61PH8JVv8abnXs=;
 b=L8odw7Ppsyw3w/UQ4yfLqVgMHpSH6h1X4dDKTrhlzrHKSGDmT+BY4QugG0ERkSPnr7pxWzboS4hqDvImR0yr/m5ojzfpL1laATYpS2BfqFx0fp4OLqhxXHB+IdWAou/AjPoTGOfU+yqIAyDIWUY0f30NSBSd4gS8T1yQN5Nr+TI=
Received: from BN9PR03CA0517.namprd03.prod.outlook.com (2603:10b6:408:131::12)
 by SN4PR0801MB7807.namprd08.prod.outlook.com (2603:10b6:806:207::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Fri, 9 Feb
 2024 19:25:54 +0000
Received: from BN8NAM12FT105.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a6) by BN9PR03CA0517.outlook.office365.com
 (2603:10b6:408:131::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27 via Frontend
 Transport; Fri, 9 Feb 2024 19:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.com;dmarc=pass action=none header.from=elektrobit.com;
Received-SPF: Pass (protection.outlook.com: domain of elektrobit.com
 designates 4.79.107.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.79.107.243; helo=usbth1es003.ebgroup.elektrobit.com; pr=C
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 BN8NAM12FT105.mail.protection.outlook.com (10.13.182.158) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7292.12 via
 Frontend Transport; Fri, 9 Feb 2024 19:25:54 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 11:25:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htMOHOQ0AWSw/MnzGwrcKtfdw71WSmvMJjdDA5LAHLiZujWP2ilnOQ4Ut7jKu/KqL8w/sLp7OKKreKVH1M0z+p17ONfawKziJTlyN750fnBqix/1Hm7hxp+APs0gCjEXfv5Be6upLrK6HkOjWE0YaHK1RZ1RqhqtCt/1kK0zyPLviXHi2+eOOj1h9UlniWfGSDFYz36IwPoE9Zd7PkWEKN2of1Nna3joAr3SEcyGF/ZIps6vgb3etevl6ycZTI3JsECjdoJnTovFJ5CAJJud6yZhpKQH3pta1zz8D6OwE9jj4MOFT0QpPgq8rs1BSzqBlw37KSVN0wwMvbLHypLSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwOE2p4z3KzL1M+HnYefvC9KBA8ss61PH8JVv8abnXs=;
 b=NPHqT3k95opKftwS2a7BxPcd0YhDNg24c/3FaxM1Yhyp347PPI3RFVwvUlMtF+hesULlTHaR4/kQAtSoijRtR1G4/Z3xcVSZKffEADJT1fvauy+E66czYZhNRm6mg6VzddJJoymT6S3vDpn5gNhNN6NKgoVerEnB1L04daHkojgTrqtNHFVRmrswMcYLIni4OfDF3I7Ao7AzmkLJx5mwa0vapVcSA4OCd0vQdMk0/Wr50Cu7m0uZOCnK2L4U0QVpriZU7D3B/NWp4KJnWqYci5/NyufCclRoYMNFqMwfqR+6Urybt92XpM7O2XQlXgcmkx6Ot8TPQ3BpnSAcOuoLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 213.95.148.172) smtp.rcpttodomain=gmail.com smtp.mailfrom=elektrobit.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=elektrobit.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwOE2p4z3KzL1M+HnYefvC9KBA8ss61PH8JVv8abnXs=;
 b=L8odw7Ppsyw3w/UQ4yfLqVgMHpSH6h1X4dDKTrhlzrHKSGDmT+BY4QugG0ERkSPnr7pxWzboS4hqDvImR0yr/m5ojzfpL1laATYpS2BfqFx0fp4OLqhxXHB+IdWAou/AjPoTGOfU+yqIAyDIWUY0f30NSBSd4gS8T1yQN5Nr+TI=
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 CH0PR08MB8708.namprd08.prod.outlook.com (2603:10b6:610:192::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 19:25:46 +0000
Received: from DM6NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::b7) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 19:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 213.95.148.172) smtp.mailfrom=elektrobit.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 213.95.148.172 as permitted sender)
Received: from denue6es012.ebgroup.elektrobit.com (213.95.148.172) by
 DM6NAM12FT007.mail.protection.outlook.com (10.13.178.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.13 via Frontend Transport; Fri, 9 Feb 2024 19:25:45 +0000
Received: from denue6es013.ebgroup.elektrobit.com (10.243.160.141) by
 denue6es012.ebgroup.elektrobit.com (10.243.160.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.23; Fri, 9 Feb 2024 20:25:44 +0100
Received: from del01439.ebgroup.elektrobit.com (10.243.10.20) by
 denue6es013.ebgroup.elektrobit.com (10.243.160.141) with Microsoft SMTP
 Server id 15.2.1258.23 via Frontend Transport; Fri, 9 Feb 2024 20:25:44 +0100
From: =?UTF-8?q?Simone=20Wei=C3=9F?= <simone.weiss@elektrobit.com>
To:
CC: <lukas.bulwahn@gmail.com>, <simone.p.weiss@posteo.net>,
	=?UTF-8?q?Simone=20Wei=C3=9F?= <simone.weiss@elektrobit.com>, Kai Tomerius
	<kai.tomerius@elektrobit.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, Song Liu <song@kernel.org>, Yu Kuai
	<yukuai3@huawei.com>, <linux-raid@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
Date: Fri, 9 Feb 2024 20:25:41 +0100
Message-ID: <20240209192542.449367-1-simone.weiss@elektrobit.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DM6NAM12FT007:EE_|CH0PR08MB8708:EE_|BN8NAM12FT105:EE_|SN4PR0801MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: cb41d91a-41fd-48ba-94db-08dc29a4ef38
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 NEesPfNV9XyGpPXpX3T+m8qm/ofaOUmpsTtf3VGQeU6h1tLw77jWV5c1nxDpGOm7J8y6OGaomk00GdtT8zsNYdLtSBckVEiuFd3WN7XCuFT8dttsgnAzhsqTLCktCqMxA5HBgdKyRHmRlAwhMkAZkBXmnmv2oj7+A3EnHgS8B8NhRHHScaO3BNuIzDKL1UYvejn6T+lf+pvq7nW6utcfKH/QWb1RaPr0Wd0sUMc489AsJ6xsIzrgxOEGs/uJwtbTMfuklPmSabevdo1lCC/Jb/fV3qF/hUPEBaluiYc3gSmOjlirpZl3LqTdYkaDXrhQutJ2hD2I8eB3dJ32WGOIHm482BdSJy53IT0zKRDOWTk+4s7H0XpwRCuaBTvKlx4IiPM6lstPAgTS5vHK+Wgzm7rO4oCIkh9bnf/5EZuQW5SEUFrU0TKpj/JYo7gox5h9AXLMWpStXEyFDeOZgZPZlhljiXfU9wP8f5uSsdni96dfwHko+p7TIssbsTe7qk/lR9bTlV3x4hZ9ZX9DxuxfqOSidQBNunc/XBRGRQ6HcqPq5W6/WTAxOr3QMH2/Tk7YsQ2ItO8EolX16KthUnbMrqcEfQSVJbiEtQLXswlrW20=
X-Forefront-Antispam-Report-Untrusted:
 CIP:213.95.148.172;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:denue6es012.ebgroup.elektrobit.com;PTR:eth1-fw1-nbg6.eb.noris.de;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(109986022)(186009)(451199024)(1800799012)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(4326008)(41300700001)(70586007)(70206006)(36756003)(30864003)(8676002)(5660300002)(7416002)(8936002)(54906003)(83380400001)(356005)(316002)(81166007)(82740400003)(336012)(7696005)(2906002)(26005)(6666004)(478600001)(86362001)(426003)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB8708
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 BN8NAM12FT105.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5ca1676c-5d7e-49a2-efb2-08dc29a4ea2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qSkgJWulkg7jr17gcvBMc+yNByUC3vXYMCTfJDP67oSRLY6M4kuirkcQBlIUZ0T7kl6k9zuZBwC6TcilsIUfDwHmnqjNDElNsnmzKaiMmyc8+HKc7zmci9rI8n4Xz0Eso56RgZXvjQSOZsT52fydIMf1wcVvsW550TJirWBjaiQZto/gpuqtb4vQvgwy0CgDID76OGjNM+W2spNey1PT6QEcNnIzEyezQ2xQ7VKP2RQ9cBC/4RCEx/BYzlKu4S0s/3fKBONAO+0rDbljL4zNDqvqV2EiKvNc9qoIH2V+73WIDTA00DtHYCKjCmg9LEhgciTPAvDE1Blq+EfwGt0zDI67ojivb04gw3z4I9zOGdtStbqZluVQQ+kMZewn/FrY+ES5u9ilQUhKlTkxT/GVLuLijMma5NQiCrgm3VRKtjPR70K26ISbktiI0xS2gYciX1ed7x8/URAMmdhkYwIG87yu5OWl19aEf4OW8qU0EB9h52wl2YASkyxc5io76V00CUxuxbvwiF1r/fV7KGiraueaNW31R0egJyDn2UCCadME8WqnrMMYKahahUACzxfpqiz6RcBLEoq1ef0vw09ujmtKP8VcpgBRkdYdLbgQXvU=
X-Forefront-Antispam-Report:
	CIP:4.79.107.243;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(109986022)(40470700004)(36840700001)(46966006)(336012)(1076003)(316002)(81166007)(7696005)(7416002)(8936002)(8676002)(4326008)(5660300002)(82740400003)(36756003)(30864003)(2906002)(2616005)(26005)(478600001)(86362001)(426003)(70206006)(70586007)(6666004)(83380400001)(41300700001)(54906003);DIR:OUT;SFP:1102;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:25:54.1168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb41d91a-41fd-48ba-94db-08dc29a4ef38
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM12FT105.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7807

Extend the dm-integrity driver to omit writing unused journal data sectors.
Instead of filling up the whole journal section, mark the last used
sector with a special commit ID. The commit ID still uses the same base value,
but section number and sector number are inverted. At replay when commit IDs
are analyzed this special commit ID is detected as end of valid data for this
section. The main goal is to prolong the live times of e.g. eMMCs by avoiding
to write the whole journal data sectors.

The change is right now to be seen as experimental and gets applied if
CONFIG_DMINT_LAZY_COMMIT is set to y. Note please that this is NOT
planned for a final version of the changes. I would make it configurable
via flags passed e.g. via dmsetup and stored in the superblock.

Architectural Limitations:
- A dm-integrity partition, that was previously used with lazy commit,
 can't be replayed with a dm-integrity driver not using lazy commit.
- A dm-integrity driver that uses lazy commit is expected
 to be able to cope with a partition that was created and used without
 lazy commit.
- With dm-integrity lazy commit, a partially written journal (e.g. due to a
 power cut) can cause a tag mismatch during replay if the journal entry marking
 the end of the journal section is missing. Due to lazy commit, older journal
 entries are not erased and might be processed if they have the same commit ID
 as adjacent newer journal entries. If dm-integrity detects bad sections while
 replaying the journal, keep track about those sections and try to at least
 replay older, good sections.
 This is based on the assumption that most likely the newest
 section(s) will be damaged, which might have been only partially written
 due to a sudden reset. Previously, the whole journal would be cleared in
 such a case.

Signed-off-by: Simone Weiß <simone.weiss@elektrobit.com>
Signed-off-by: Kai Tomerius <kai.tomerius@elektrobit.com>

---
This is just a very initial version. Bear that in mind please. I would like to
get feedback about the general idea and am aware that further work is needed.

Tests done so far:
- Tests where executed on qemu.
- Test scripts can be found under:
  git@github.com:simone-weiss/dm-integrity-lazy-commit.git
- Suggestions on how to test this further, what testscases to run this against
  are appreciated.

Further work:
- The superblock should carry information about lazy-commit. Should the
  version be increased for this?
- Add handling/logging if a partition that was created with lazy commits,
  but gets replayed with a "normal" journal mode.
- Allow configuration if you want to use lazy commits or normal commits in the
  journal if lazy commits are enabled
- userspace setup tooling like dmsetup should be adapted accordingly

 drivers/md/Kconfig        |  10 ++
 drivers/md/dm-integrity.c | 250 ++++++++++++++++++++++++++++++++------
 2 files changed, 222 insertions(+), 38 deletions(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 68ce56fc61d0..d28a65dd54ad 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -604,6 +604,16 @@ config DM_INTEGRITY
 	  To compile this code as a module, choose M here: the module will
 	  be called dm-integrity.
 
+config DMINT_LAZY_COMMIT
+	tristate "Lazy commit for dm-integrity target"
+	depends on DM_INTEGRITY
+	default n
+	help
+	  Extend the dm-integrity driver to omit writing unused journal data.
+	  Instead use a special lazy commit id that marks the end of the data
+	  in the journal.
+	  To be seen as experimental.
+
 config DM_ZONED
 	tristate "Drive-managed zoned block device target support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index ed45411eb68d..d521b5d4d2d5 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1083,18 +1083,19 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, blk_opf_t opf,
 }
 
 static void rw_journal(struct dm_integrity_c *ic, blk_opf_t opf,
-		       unsigned int section, unsigned int n_sections,
-		       struct journal_completion *comp)
+		      unsigned int section, unsigned int n_sections,
+		      unsigned int omit_sectors, struct journal_completion *comp)
 {
 	unsigned int sector, n_sectors;
 
 	sector = section * ic->journal_section_sectors;
-	n_sectors = n_sections * ic->journal_section_sectors;
+	n_sectors = n_sections * ic->journal_section_sectors - omit_sectors;
 
 	rw_journal_sectors(ic, opf, sector, n_sectors, comp);
 }
 
-static void write_journal(struct dm_integrity_c *ic, unsigned int commit_start, unsigned int commit_sections)
+static void write_journal(struct dm_integrity_c *ic, unsigned int commit_start,
+			  unsigned int commit_sections, unsigned int omit_sectors)
 {
 	struct journal_completion io_comp;
 	struct journal_completion crypt_comp_1;
@@ -1117,7 +1118,7 @@ static void write_journal(struct dm_integrity_c *ic, unsigned int commit_start,
 				rw_section_mac(ic, commit_start + i, true);
 		}
 		rw_journal(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, commit_start,
-			   commit_sections, &io_comp);
+			   commit_sections, omit_sectors, &io_comp);
 	} else {
 		unsigned int to_end;
 
@@ -1130,7 +1131,7 @@ static void write_journal(struct dm_integrity_c *ic, unsigned int commit_start,
 			encrypt_journal(ic, true, commit_start, to_end, &crypt_comp_1);
 			if (try_wait_for_completion(&crypt_comp_1.comp)) {
 				rw_journal(ic, REQ_OP_WRITE | REQ_FUA,
-					   commit_start, to_end, &io_comp);
+					   commit_start, to_end, 0, &io_comp);
 				reinit_completion(&crypt_comp_1.comp);
 				crypt_comp_1.in_flight = (atomic_t)ATOMIC_INIT(0);
 				encrypt_journal(ic, true, 0, commit_sections - to_end, &crypt_comp_1);
@@ -1141,17 +1142,19 @@ static void write_journal(struct dm_integrity_c *ic, unsigned int commit_start,
 				crypt_comp_2.in_flight = (atomic_t)ATOMIC_INIT(0);
 				encrypt_journal(ic, true, 0, commit_sections - to_end, &crypt_comp_2);
 				wait_for_completion_io(&crypt_comp_1.comp);
-				rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, &io_comp);
+				rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, 0,
+					   &io_comp);
 				wait_for_completion_io(&crypt_comp_2.comp);
 			}
 		} else {
 			for (i = 0; i < to_end; i++)
 				rw_section_mac(ic, commit_start + i, true);
-			rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, &io_comp);
+			rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, 0, &io_comp);
 			for (i = 0; i < commit_sections - to_end; i++)
 				rw_section_mac(ic, i, true);
 		}
-		rw_journal(ic, REQ_OP_WRITE | REQ_FUA, 0, commit_sections - to_end, &io_comp);
+		rw_journal(ic, REQ_OP_WRITE | REQ_FUA, 0, commit_sections - to_end,
+			   omit_sectors, &io_comp);
 	}
 
 	wait_for_completion_io(&io_comp.comp);
@@ -1777,7 +1780,6 @@ static void integrity_metadata(struct work_struct *w)
 			if (unlikely(r)) {
 				if (r > 0) {
 					sector_t s;
-
 					s = sector - ((r + ic->tag_size - 1) / ic->tag_size);
 					DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
 						    bio->bi_bdev, s);
@@ -2355,6 +2357,9 @@ static void integrity_commit(struct work_struct *w)
 	unsigned int commit_start, commit_sections;
 	unsigned int i, j, n;
 	struct bio *flushes;
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+	unsigned int used_sectors;
+#endif
 
 	del_timer(&ic->autocommit_timer);
 
@@ -2366,6 +2371,15 @@ static void integrity_commit(struct work_struct *w)
 		goto release_flush_bios;
 	}
 
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+	if (ic->free_section_entry)
+		used_sectors = (ic->free_section_entry <<
+				ic->sb->log2_sectors_per_block) +
+			JOURNAL_BLOCK_SECTORS;
+	else
+		used_sectors = ic->journal_section_sectors;
+#endif
+
 	pad_uncommitted(ic);
 	commit_start = ic->uncommitted_section;
 	commit_sections = ic->n_uncommitted_sections;
@@ -2388,6 +2402,16 @@ static void integrity_commit(struct work_struct *w)
 			struct journal_sector *js;
 
 			js = access_journal(ic, i, j);
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+			if (n == commit_sections-1 && j == used_sectors-1) {
+				js->commit_id = dm_integrity_commit_id(ic, ~i,
+								       ~j, ic->commit_seq);
+				DEBUG_print("Lazy commit id=0x%llx: Sections %u.%u. Last section with %u sectors\n",
+					    js->commit_id, commit_start, i,
+					    used_sectors);
+				break;
+			}
+#endif
 			js->commit_id = dm_integrity_commit_id(ic, i, j, ic->commit_seq);
 		}
 		i++;
@@ -2397,7 +2421,12 @@ static void integrity_commit(struct work_struct *w)
 	}
 	smp_rmb();
 
-	write_journal(ic, commit_start, commit_sections);
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+	write_journal(ic, commit_start, commit_sections,
+		      ic->journal_section_sectors-used_sectors);
+#else
+	write_journal(ic, commit_start, commit_sections, 0);
+#endif
 
 	spin_lock_irq(&ic->endio_wait.lock);
 	ic->uncommitted_section += commit_sections;
@@ -2443,12 +2472,13 @@ static void restore_last_bytes(struct dm_integrity_c *ic, struct journal_sector
 	} while (++s < ic->sectors_per_block);
 }
 
-static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start,
-			     unsigned int write_sections, bool from_replay)
+static int do_journal_write(struct dm_integrity_c *ic, unsigned int write_start,
+			    unsigned int write_sections, bool from_replay)
 {
 	unsigned int i, j, n;
 	struct journal_completion comp;
 	struct blk_plug plug;
+	unsigned int rc = 0;
 
 	blk_start_plug(&plug);
 
@@ -2465,7 +2495,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 		for (j = 0; j < ic->journal_section_entries; j++) {
 			struct journal_entry *je = access_journal_entry(ic, i, j);
 			sector_t sec, area, offset;
-			unsigned int k, l, next_loop;
+			unsigned int k, l, next_loop, end;
 			sector_t metadata_block;
 			unsigned int metadata_offset;
 			struct journal_io *io;
@@ -2543,6 +2573,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 			spin_unlock_irq(&ic->endio_wait.lock);
 
 			metadata_block = get_metadata_sector_and_offset(ic, area, offset, &metadata_offset);
+			end = k;
 			for (l = j; l < k; l++) {
 				int r;
 				struct journal_entry *je2 = access_journal_entry(ic, i, l);
@@ -2557,8 +2588,24 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
 								  (char *)access_journal_data(ic, i, l), test_tag);
 					if (unlikely(memcmp(test_tag, journal_entry_tag(ic, je2), ic->tag_size))) {
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+						if (!from_replay)
+							dm_integrity_io_error(ic, "tag mismatch when writing journal",
+									      -EILSEQ);
+
+						/*
+						 * during replay, continue processing and discard
+						 * data with a tag mismatch
+						 */
+						rc = -1;
+						if (end > l)
+							end = l;
+
+						DEBUG_print("tag mismatch at section %u entry %u\n", n, l);
+#else
 						dm_integrity_io_error(ic, "tag mismatch when replaying journal", -EILSEQ);
 						dm_audit_log_target(DM_MSG_PREFIX, "integrity-replay-journal", ic->ti, 0);
+#endif
 					}
 				}
 
@@ -2569,11 +2616,15 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 					dm_integrity_io_error(ic, "reading tags", r);
 			}
 
-			atomic_inc(&comp.in_flight);
-			copy_from_journal(ic, i, j << ic->sb->log2_sectors_per_block,
-					  (k - j) << ic->sb->log2_sectors_per_block,
-					  get_data_sector(ic, area, offset),
-					  complete_copy_from_journal, io);
+			// copy data that has not been discarded
+			if (end > j) {
+				atomic_inc(&comp.in_flight);
+				copy_from_journal(ic, i, j << ic->sb->log2_sectors_per_block,
+						  (end - j) << ic->sb->log2_sectors_per_block,
+						  get_data_sector(ic, area, offset),
+						  complete_copy_from_journal, io);
+			}
+
 skip_io:
 			j = next_loop;
 		}
@@ -2587,6 +2638,8 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 	wait_for_completion_io(&comp.comp);
 
 	dm_integrity_flush_buffers(ic, true);
+
+	return rc;
 }
 
 static void integrity_writer(struct work_struct *w)
@@ -2603,7 +2656,8 @@ static void integrity_writer(struct work_struct *w)
 	if (!write_sections)
 		return;
 
-	do_journal_write(ic, write_start, write_sections, false);
+	if (do_journal_write(ic, write_start, write_sections, false) < 0)
+		write_sections = ~0;
 
 	spin_lock_irq(&ic->endio_wait.lock);
 
@@ -2914,7 +2968,7 @@ static void init_journal(struct dm_integrity_c *ic, unsigned int start_section,
 		}
 	}
 
-	write_journal(ic, start_section, n_sections);
+	write_journal(ic, start_section, n_sections, 0);
 }
 
 static int find_commit_seq(struct dm_integrity_c *ic, unsigned int i, unsigned int j, commit_id_t id)
@@ -2929,6 +2983,50 @@ static int find_commit_seq(struct dm_integrity_c *ic, unsigned int i, unsigned i
 	return -EIO;
 }
 
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+static int find_commit_seq_lazy(struct dm_integrity_c *ic, unsigned int i,
+	unsigned int j, commit_id_t id, bool *lazy)
+{
+	unsigned char k;
+	*lazy = false;
+	for (k = 0; k < N_COMMIT_IDS; k++) {
+		if (dm_integrity_commit_id(ic, i, j, k) == id)
+			return k;
+	}
+	for (k = 0; k < N_COMMIT_IDS; k++) {
+		if (dm_integrity_commit_id(ic, ~i, ~j, k) == id) {
+			DEBUG_print("Found a lazy commit id at %d:%d\n", i, j);
+			*lazy = true;
+			return k;
+		}
+	}
+	dm_integrity_io_error(ic, "journal commit id", -EIO);
+	return -EIO;
+}
+
+static bool journal_check_lazy_commit(struct dm_integrity_c *ic,
+	unsigned int i, unsigned int sector)
+{
+	unsigned int j;
+
+	if (sector%ic->sectors_per_block) {
+		DEBUG_print("The lazy commit id is not aligned to the block size. Not replaying section\n");
+		return false;
+	}
+
+	for (j = sector>>ic->sb->log2_sectors_per_block;
+		j < ic->journal_section_entries; j++) {
+		struct journal_entry *je = access_journal_entry(ic, i, j);
+
+		if (!journal_entry_is_unused(je)) {
+			DEBUG_print("Found used journal entry after lazy commit. Not replaying section\n");
+			return false;
+		}
+	}
+	return true;
+}
+#endif
+
 static void replay_journal(struct dm_integrity_c *ic)
 {
 	unsigned int i, j;
@@ -2938,6 +3036,7 @@ static void replay_journal(struct dm_integrity_c *ic)
 	unsigned int continue_section;
 	bool journal_empty;
 	unsigned char unused, last_used, want_commit_seq;
+	unsigned int first_bad, last_bad, dead;
 
 	if (ic->mode == 'R')
 		return;
@@ -2947,10 +3046,13 @@ static void replay_journal(struct dm_integrity_c *ic)
 
 	last_used = 0;
 	write_start = 0;
+	first_bad = 0;
+	last_bad = 0;
+	dead = 0;
 
 	if (!ic->just_formatted) {
 		DEBUG_print("reading journal\n");
-		rw_journal(ic, REQ_OP_READ, 0, ic->journal_sections, NULL);
+		rw_journal(ic, REQ_OP_READ, 0, ic->journal_sections, 0, NULL);
 		if (ic->journal_io)
 			DEBUG_bytes(lowmem_page_address(ic->journal_io[0].page), 64, "read journal");
 		if (ic->journal_io) {
@@ -2972,17 +3074,32 @@ static void replay_journal(struct dm_integrity_c *ic)
 	memset(used_commit_ids, 0, sizeof(used_commit_ids));
 	memset(max_commit_id_sections, 0, sizeof(max_commit_id_sections));
 	for (i = 0; i < ic->journal_sections; i++) {
+		bool bad = false;
 		for (j = 0; j < ic->journal_section_sectors; j++) {
 			int k;
 			struct journal_sector *js = access_journal(ic, i, j);
-
+#ifndef CONFIG_DMINT_LAZY_COMMIT
 			k = find_commit_seq(ic, i, j, js->commit_id);
-			if (k < 0)
-				goto clear_journal;
+#else
+			bool lazy;
+
+			k = find_commit_seq_lazy(ic, i, j, js->commit_id,
+						 &lazy);
+			if (lazy)
+				j = ic->journal_section_sectors;
+#endif
+			if (k < 0) {
+				/* remember the first and last bad section */
+				bad = true;
+				if (!first_bad)
+					first_bad = i + 1;
+				last_bad = i + 1;
+				break;
+			}
 			used_commit_ids[k] = true;
 			max_commit_id_sections[k] = i;
 		}
-		if (journal_empty) {
+		if (!bad && journal_empty) {
 			for (j = 0; j < ic->journal_section_entries; j++) {
 				struct journal_entry *je = access_journal_entry(ic, i, j);
 
@@ -3022,21 +3139,75 @@ static void replay_journal(struct dm_integrity_c *ic)
 		want_commit_seq = next_commit_seq(want_commit_seq);
 	wraparound_section(ic, &write_start);
 
+	if (unlikely(first_bad)) {
+		DEBUG_print("dm-integrity: write_start=%u first_bad=%u last_bad=%u\n",
+			    write_start, first_bad, last_bad);
+
+		if (last_bad <= write_start)
+			/*
+			 * section     0   1   2   3  | 4   5   6   7
+			 * id          2   2   2   2  | 2   1   1   1
+			 * first_bad=3         ^
+			 * last_bad=4              ^
+			 * start=4                      ^
+			 * dead=2              X   X
+			 */
+			dead = write_start - first_bad + 1;
+		else if (first_bad > write_start)
+			/*
+			 * section     0   1   2   3  | 4   5   6   7
+			 * id          2   2   2   2  | 2   1   1   1
+			 * first_bad=7                          ^
+			 * last_bad=8                               ^
+			 * start=4                      ^
+			 * dead=6      X   X   X   X            X   X
+			 */
+			dead = ic->journal_sections + write_start - first_bad + 1;
+		else
+			/*
+			 * section     0   1   2   3  | 4   5   6   7
+			 * id          2   2   2   2  | 2   1   1   1
+			 * first_bad=4             ^
+			 * last_bad=7                           ^
+			 * start=4                      ^
+			 * dead=0      X   X   X   X    X   X   X   X
+			 */
+			dead = 0;
+
+		DEBUG_print("dm-integrity: sections=%u, empty=%s, dead=%u\n",
+			    ic->journal_sections, journal_empty ? "true" : "false", dead);
+
+		if (journal_empty || dead == 0)
+			goto clear_journal;
+	}
+
 	i = write_start;
-	for (write_sections = 0; write_sections < ic->journal_sections; write_sections++) {
+	for (write_sections = 0; write_sections < ic->journal_sections - dead;
+	     write_sections++) {
 		for (j = 0; j < ic->journal_section_sectors; j++) {
 			struct journal_sector *js = access_journal(ic, i, j);
-
-			if (js->commit_id != dm_integrity_commit_id(ic, i, j, want_commit_seq)) {
-				/*
-				 * This could be caused by crash during writing.
-				 * We won't replay the inconsistent part of the
-				 * journal.
-				 */
-				DEBUG_print("commit id mismatch at position (%u, %u): %d != %d\n",
-					    i, j, find_commit_seq(ic, i, j, js->commit_id), want_commit_seq);
-				goto brk;
+			if (js->commit_id == dm_integrity_commit_id(ic, i, j,
+				want_commit_seq))
+				continue; /* regular commit */
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+			if (js->commit_id == dm_integrity_commit_id(ic, ~i, ~j,
+				want_commit_seq)) {
+				/* Lazy commit */
+				DEBUG_print("Found lazy commit in replay: %u, %u\n",
+					i, j);
+				if (journal_check_lazy_commit(ic, i, j + 1))
+					break;
 			}
+#endif
+			/*
+			 * This could be caused by crash during writing.
+			 * We won't replay the inconsistent part of the
+			 * journal.
+			 */
+			DEBUG_print("commit id mismatch at position (%u, %u): %d != %d\n",
+				i, j, find_commit_seq(ic, i, j,
+				js->commit_id), want_commit_seq);
+			goto brk;
 		}
 		i++;
 		if (unlikely(i >= ic->journal_sections))
@@ -3785,7 +3956,10 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 	if (ic->journal_crypt_alg.alg_string) {
 		unsigned int ivsize, blocksize;
 		struct journal_completion comp;
-
+#ifdef CONFIG_DMINT_LAZY_COMMIT
+		*error = "Lazy commit with journal encryption is currently not supported";
+		goto bad;
+#endif
 		comp.ic = ic;
 		ic->journal_crypt = crypto_alloc_skcipher(ic->journal_crypt_alg.alg_string, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
 		if (IS_ERR(ic->journal_crypt)) {
-- 
2.34.1



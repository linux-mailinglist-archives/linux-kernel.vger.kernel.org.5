Return-Path: <linux-kernel+bounces-146848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC58A6BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F32E1C21B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033028E6;
	Tue, 16 Apr 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eF3WiR7E";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="W0m+vee8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43212BE90;
	Tue, 16 Apr 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272767; cv=fail; b=Wy6AdN0cBdS1flGYA/nEiaSSoSq9quJdzB4VgyZgKQJehzLCcHS+9JjvkaPu/OknyB2UtL+CiIC3ZSouR5JDpfdyNcwDD3nBX1cJfJF28OiZylRU58s63p9g7Y8Koas9oWfdreKYvXRJqvW6dgmKQBN/gGTh215rRkKbwk/Pb7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272767; c=relaxed/simple;
	bh=bm6ZGHdHsI7/cvHQMT02QgVyt1ctj4+4Gjo/ubv7R80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F5D7wDfbX9jqo9VHirgBXRHLC9AhHoG71RsExMwxlTWDOWXTaML3bG2RO0u6r/QtLN83BFok4XIhK14P/lVbQgTBZ7JRBQeSTYN1mBr5eCooPVwuTgm/KRF98pEYiu2aI1mfibgh472s0ecXSUWls3uJqqD61t6B9c/B8DXeyQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eF3WiR7E; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=W0m+vee8; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1070f58cfbf211eeb8927bc1f75efef4-20240416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bm6ZGHdHsI7/cvHQMT02QgVyt1ctj4+4Gjo/ubv7R80=;
	b=eF3WiR7En+fhMac13zEbmE8t7feGta3z3EpmICD3gOfQ4gfCIiLkW3Y2ieG1h0bWKsUORSqFpW130+7mNX/rrXRLw+lnRpfK2FEPWh1n5jXB2kFdFYuhQ0ds9gOf8GDaD5WgQd56kgr+gaqv1FU/++Wlj1kWP2HmJjYdAUTkfs4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d1bf358a-ac51-47cd-b26b-e3f7467b2878,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:19dafafa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1070f58cfbf211eeb8927bc1f75efef4-20240416
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 684311629; Tue, 16 Apr 2024 21:05:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Apr 2024 06:05:55 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Apr 2024 21:05:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktbvu9xoQBKVhq/cPz9Duo0AP5YpC+YQSWFjUrG/trnwLBgADV8pLzrIRKbJon0RT8kxqnJQcu/ICzpFHPsxrAzKyCkMVKKBoIF0zbn25Fehovbp9Bn1ZASNzREbhFyUQfzXtO5UpsKXTNKArW7r8p3oEAs8zceLKlSz2e/W/TiyA7AwuHhL6KoO/yk/6a3piM7ijDdkqRIfwatskW0JUJhtGFxYV2ySjXCb93dUY0HQOna1Z4MrOJ211ZNAdmzG4R9kL9jW1x2Rdy4zDpZWXrWy4aKgq0/4ONMHm5V5iCjd+kLWD9MBcYibCDEoQH65+qmlDmN0cdMaTrnZvpuxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm6ZGHdHsI7/cvHQMT02QgVyt1ctj4+4Gjo/ubv7R80=;
 b=acfDGLd6XQYHiz7GqXWpZ2WzKd3Ns/mLRQK5VtAtc3noYCo5VZtpG/i7JtUCS5drYgI8wPeINSgpMocxGi1IZkjp5YgW7pH/bMVru7E755iFDh0J9TkqFpiql85yubLD8jQA9bBcrvwwCJJ3V5UW80wXpADqB/CaO2HeCaCufvTXIrF9Tmxo6Ou0xBZYVbiS+qcRSJUnSI0+43SqxhbcXVFAEziInf9KTpJMFzaAcF22nKsKDKY37b5suHctwr/FE2/adCV7IgwGVm+76vta9TM7gdRPcbETFNiyRk2S1X0DkDF5hSeULqPEriP8KHINTyah8Umdb0NdCFs2dzWnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm6ZGHdHsI7/cvHQMT02QgVyt1ctj4+4Gjo/ubv7R80=;
 b=W0m+vee8z2fOcfmZ+FUhCawXs5dfOp8U202fNq5kMBduD+mMP7/pX2nH9AHZTQxGAqycC/K9hAG0e+7YZi2srNy66EF3pXs+yjnVOPmV21bwECasI2XfpGp+Wzc8LOX3vXvsMdogVklEoemSgogTL7kb5tx7j3kGvzE/ix8WHT4=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by TY0PR03MB7238.apcprd03.prod.outlook.com (2603:1096:400:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 13:05:54 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 13:05:53 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Topic: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Index: AQHajyQsFRoxXt1vlE2SkQwxcZAltLFqegCAgAAOj4CAACueAIAAAfoAgAApLgA=
Date: Tue, 16 Apr 2024 13:05:53 +0000
Message-ID: <d11e174d85c7f5a9b4ffe5fb2bb15dfd5823f83e.camel@mediatek.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
	 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
	 <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
	 <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
	 <93db93aa7eb24a255f97a1a1e8e8d936dc908258.camel@mediatek.com>
	 <f3920433-b0fa-4a64-9653-e385bf1eb5c7@collabora.com>
In-Reply-To: <f3920433-b0fa-4a64-9653-e385bf1eb5c7@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|TY0PR03MB7238:EE_
x-ms-office365-filtering-correlation-id: 1ad2a659-ac9c-4c5f-5b19-08dc5e15f28d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?YkhjME91QVNSSFp4NFFqenU2VGJwRDRaRHR6OUQxazZjL3VCeGVqblc0S3ZS?=
 =?utf-8?B?S1BsblU0byttSHd4a29KeWxkTzZoSVlXcGpWUDg0bmZ1a3ZEMk5qMHFnbUo4?=
 =?utf-8?B?MyswWDF6bW9GREdBbjRJcVFScWtML29nWkRRTC82UGFqVTNiREhGYUxXZFpG?=
 =?utf-8?B?eWxtbEFNc2FTZUE2QzZhMDhyUG9Ibm9aVHJvVW1aRHV2U2RZUXU4YThOS2NI?=
 =?utf-8?B?bXNpUk5pNlBWT1plL0xKVk5pRHhCVXJzelFUVHZSbXE5d08xMDE4VDU3STVX?=
 =?utf-8?B?RFBhRFVycFZybTlrMlFaVm83dmwvcjBYTktmcjR2ZW1hUjJVUUFPWEliNGxU?=
 =?utf-8?B?M0xMZEVHQk1GOUVDYitYVjI0QVQ2Q3gwM09IN2wzeW9Gb21naGN2SFVKbUts?=
 =?utf-8?B?WjY1dEh3ZG0xL2NFeUQrY0JMaVNKNjQxZUFrcW9XR1BOZS9NZWd4VTFOa0pz?=
 =?utf-8?B?MGx1V2hDUDVIYnlVaUUzTGcxa1JacXl5Wm5qS0xOTDBUaTFHU0p2NldHcmJP?=
 =?utf-8?B?cVlNcHZ4UTVualFTa2VadmFmU3gzRy9PUXBBdDNnMS9lV0JmUkdBZkhPWnJF?=
 =?utf-8?B?OTdMejBYM2xKTm42K2pOckQxM3lNYTJaZndvT1FHL0dKcmV4c0F0c0xUdnpu?=
 =?utf-8?B?eC9SWFk5R25TNVYvTXJjOElIcDRlRjRXOUFHZGUxU0VFaFMwOVo4QmFXbHZr?=
 =?utf-8?B?Z2p1ZUxmUEtjZVBnMkpXcVkvYzVJNURYK3lTdFBOYk9Ib3lSRzBhcGVVUUsv?=
 =?utf-8?B?QjJzeGh1VnpaeXNURWZja1ZycmZ6c2R4cDNuOVBRWlgvYmRNWTdyeHJCYnFC?=
 =?utf-8?B?T21hR2h5TUt1dTR6a3dFTmhLRmU2eVlITVVEeVVYSmRmUzM1emF5WDRQUk9y?=
 =?utf-8?B?K3hvaFZzdmZaUnNUVjdRZUhtVUZsSm40SFNkSmVyY3JCcEc2TnN5a0h6cHRR?=
 =?utf-8?B?MjRvOGQ5MitHbmEzbTlxd1NzYnhDVWNkN0VVb2xERVVuVFpsbVEzdVpkYU1T?=
 =?utf-8?B?dUxCZ3MvWWNadDAxaExvOHR1elRDbms2bWlQdnNodHJlYTV4K2pVMHVka1dI?=
 =?utf-8?B?MURmcWdnNDMydkExOWhzUFJMUWRka0drNE96Y3JRSER4MmxwR045K0ErbVF1?=
 =?utf-8?B?SHJVVEI5WU9PZ2NPTjFPczFCc0FGT2luclNlSmFTWm8xUldGYk54VlQyZjFv?=
 =?utf-8?B?QzZEd1FsM3BGbXNrUjVxN3lGTTU1c2tldUpWaUtwSHFrUE5aTWRWWGFTQm53?=
 =?utf-8?B?dUNBd1JrZEEyOWszWEJUbndzQklkUldreGw0VXJLclRoL2ZtWHdTeVhxa3M1?=
 =?utf-8?B?bUQwa3dCV0JFcU9hT1o5R1pXVkNrUjYwdFBHWE1TckFuZjNSWC9mb1FmYUlz?=
 =?utf-8?B?ckZobDJpVDVyV2hHMkVWQVNTbGJMWjNpWitMaFFoU0NweHF2Qy9kRjlTMGpS?=
 =?utf-8?B?UWhGNDJ5bW9NTnlZUmUvRmgvbllHMS9uYXJ0cW8zUHdYYTFnSUlGZzRTN2U2?=
 =?utf-8?B?WUdiVFlta2N1ei90c0JQcGJHM05KdFlHbTlaOGplYWtoekp4ZXNQU2RkZ2dt?=
 =?utf-8?B?OGhObVZ0blh1Z2VlaGVMR2pCZUVxZWdKQzNaWW91QXd5dmxHMXJFWGkyYnJQ?=
 =?utf-8?B?NkpiL0xZTXhEbXlwNzFxMVc1V1ZoZE51VjFENzQ2YlR6SnFhQmpxbFhIY3RX?=
 =?utf-8?B?ZE5IcjA3RkhsNHpQeHBWcG1veGhRaEhxRkU5aG0xL29JQlhhMGxPak4wdnJC?=
 =?utf-8?B?dzRkMnRya3YzNHlneEJQNjJlVkNVYU9OanVYZ0JKSUlzcy9DY1VVYlU2OEFR?=
 =?utf-8?B?a3RXVHNUV0RLTHhLZHFyQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERVWGZzWDZyaUFiYXkrMlVGbXhGMWh0QVRHZW9OQi9MVGdxQVRSTGFlM3I4?=
 =?utf-8?B?TVBaNGVmYkFPSjQ5ai9PN0tvNmdqNTl6QWdqcDBjSWpJdzNqcERLUzEvcERU?=
 =?utf-8?B?NWd4RmlSZFZ1YkZRQnM4ZlR5UFNXbGVBakVCbzUxV3U0YmVyemxENWhySld6?=
 =?utf-8?B?bjl1aXZac2wzK21yK2oxT0Q3OXNlU1dKUDg3S0RaUTNUbzZVMjQ0Z2xwUWQy?=
 =?utf-8?B?KzIwZ3N2RmZjck9RUndMUlJLaDhsaVRldnNYV3lhNHRKMkM4WExBQnJLaVhs?=
 =?utf-8?B?QzgwUFVMQmhjY01IbDhQem41UUpYTjFxOTRqRkZQbVBNb2pCQ3BuRVhCQldB?=
 =?utf-8?B?aHNBOGpiNVBvVXZBUG81dzE4VmZtZ3ljRFZJd0dTRUJlSm1keEpoSThwdCtx?=
 =?utf-8?B?dXZRRmhzUjRMaUtTM096SENFZU1Qc0hpb1Y4ZkVLRXUvVkQyM0Y4UlJJbk1Q?=
 =?utf-8?B?QUpmL1dtT2puNGdicjU0VFJQZk1ndklEOTV5WVhWakNsY3dEeStsNFRoSTB3?=
 =?utf-8?B?dGVFUFVpTHVVQk5Eb1krM0Fjbnk4S0NqWHNNL1FUdHFsOTNGZ1kyQkN0Zi9X?=
 =?utf-8?B?VUdCV0o5RzhFeVV0QjducFpZVUlMZzlXVTVMSGhWY0FXS0R0Y1BVTyt2ZHdC?=
 =?utf-8?B?R3pZUmZqUUpEelNwWU9VTHhNazlpZVNOUkc5Q2NneFNjWi95a1JLdnBsVkZm?=
 =?utf-8?B?clgyaExtdFZtU3pnZ1NjRGJyZ1dsNjBGZ3UyQ1ljQXRqRy8wUTMwaXdGbFNP?=
 =?utf-8?B?cFdxMjhXVVdjbkdROXFpV05NcVFqMmVOMTA5enlZeDYzaGRMTFdGN1VRcXA5?=
 =?utf-8?B?YU9QMnN6RS9GU1JBWWtEZXFSVHhOZkRzbjJpV1BudVN6b3RCVmsvNnpTRFd4?=
 =?utf-8?B?ZGU5SUNuM3J1MDk4VnJqeSt0enhiT083cmdJbjZySDlVYkNOMTV5SUVROUsr?=
 =?utf-8?B?NkQ0RnZHY1NSdGJYYkFnS2JNVTQ2cW1PVTdJdkVPbHlWSTJxRWVwcnBpR2V0?=
 =?utf-8?B?aWd3N2JZOTBydEJWb1ZKd094YVhsR04xaGNOKzNabFBhV0FHV0IwMm01MTdI?=
 =?utf-8?B?RlIyY2ZiMVlMQ1JUVXpqU0hoakZ0YWk2M3dpbzh6YnhkZ3kxT25VbXU1ZzI3?=
 =?utf-8?B?MnVaU1J2Slg0RDFza2FmVnpCVm9EcmNiQzdxZ2diS2lVL3JMbjBhWEE3V0VG?=
 =?utf-8?B?NzNnQllvZlpzS01INHhDMVdXWFY1MGVuVnIwd0UveFZWQ05ENlJJNU1TeU1h?=
 =?utf-8?B?ZUpCRllITUNMMXBzbEljK09LU2VMVzYxU0IxaUFORU5qSThlQzJadXdNeUFO?=
 =?utf-8?B?NXBob2xlc1pndWV3eVg1VmJrTEovNmZYRWdCb2g5KzRyWDJoY1RXb0VLZmdm?=
 =?utf-8?B?am9ZTFk5Vko4VWJzNEFJYUFGdU1pcXMyQTVOUWcyTHBneWRnRWJWMTV3ZEsv?=
 =?utf-8?B?WkpxVFBqSytoUjY2aHdCMlZBWms2bU5ZSjgySS9LbytWTnFRZXFKS3gvNDJ2?=
 =?utf-8?B?Z3FBVUFzM3QzdnMwVytrUjFTN292eWt0NXNLRm42S0daWFR3UUFMN0FkWElM?=
 =?utf-8?B?R0ZPZzBDN3gybGN2bUptbGJYc0RIUG1XN3hRazJTMEQyMml1MkFMNHJablZB?=
 =?utf-8?B?VmozNnRYTkV0UTQyV0dZcElLdVlRNXRQd0xnVUMrYmVTZlpCTHJCSlJQZFJS?=
 =?utf-8?B?and5cG8wcWlvbFA2VnkzNGRMbElYYlFNZmpvYTJOeTVwMDE5bzk4QWx0cWlj?=
 =?utf-8?B?a0xidzNsN3BhLy83UWFIZUxobmltRGVKMFFEaXBETjkzeVE3R1MxVU94UDlF?=
 =?utf-8?B?djRFSjlMcmw0ajBzK29nZG9PalQ4Wmk4cEhibVJwbnpKZzNQSmNYZ0ZOcXZv?=
 =?utf-8?B?Zkp0cXp3aGMrWXlBV1QyN2gxYzdjUmh5Ynh0K3Y3cEg4ZEVsMUJjakxkRW5i?=
 =?utf-8?B?R0F5TGMrN2tzUFczR3BkV3dsa3B6Njd1NHVGZ0REVEFyVkxvM3JmMGFHRE1r?=
 =?utf-8?B?eGJuNm1lLzFSQm1QN09LZERlYVlXS2tFLzRxdWZSSEFMUURBaU41UUtad1Vw?=
 =?utf-8?B?dFVsWnNmczZ6TFVuMm1sTmlidVMwNzRDUG9MUEtRRklaNXZUclY5cWdnRWFX?=
 =?utf-8?B?VjVZZTFEQmx4dUtJK3Y5bU1vL0RydzF5Z25yR29mTklmcmdJUGhJWWlDUlRV?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7A164F25A2C2A4A8DD022F086F0FECB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad2a659-ac9c-4c5f-5b19-08dc5e15f28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 13:05:53.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqwiIxJAexjP6yrBdGhD4KOKm8mDLc3PDT20G4DetbP01upyLLHdwDDq7ehKjbFj8MYZuocqqZN/zREnRprMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB7238
X-MTK: N

T24gVHVlLCAyMDI0LTA0LTE2IGF0IDEyOjM4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTYvMDQvMjQgMTI6MzEsIFBldGVyIFdhbmcgKOeOi+S/oeWPiykg
aGEgc2NyaXR0bzoNCj4gPiANCj4gPiA+IFllcyB0aGlzIGNhdXNlcyAtPiBsZXNzIHRoYW4gaGFs
ZiBvZiBhIG1pbGxpc2Vjb25kIDwtIG9mDQo+ID4gPiBhZGRpdGlvbmFsDQo+ID4gPiBib290IHRp
bWUNCj4gPiA+IGlmIHRoZSBkdmZzcmMtc3VwcGx5IGlzIHByZXNlbnQgYnV0IGJvb3N0LW1pY3Jv
dm9sdCBpcyBub3QuDQo+ID4gPiANCj4gPiA+IEkgcmVhbGx5IGRvbid0IHNlZSB0aGUgcHJvYmxl
bSB3aXRoIHRoYXQgOi0pDQo+ID4gPiANCj4gPiANCj4gPiBBZGRpbmcgYSBsaXR0bGUgYml0IG9m
IGJvb3QgdGltZSB0byBvbmUgc21hcnRwaG9uZSBtaWdodCBub3QgYmUgYQ0KPiA+IHByb2JsZW0s
IGJ1dCB3aGVuIHlvdSBjb25zaWRlciBhIGJpbGxpb24gc21hcnRwaG9uZXMgZWFjaCBhZGRpbmcg
YQ0KPiA+IGxpdHRsZSBiaXQsIHRoZSBjdW11bGF0aXZlIGVmZmVjdCBiZWNvbWVzIHNpZ25pZmlj
YW50LiBUaGUgcG93ZXINCj4gPiBjb25zdW1wdGlvbiBvZiB0aGVzZSBhY2N1bXVsYXRlZCB0aW1l
cyB3aWxsIGNvbnRpbnVlIHRvIGluY3JlYXNlLA0KPiA+IGNvbnRyaWJ1dGluZyB0byB0aGUgRWFy
dGgncyBjYXJib24gZW1pc3Npb25zLiBNb3Jlb3ZlciwgcmVtb3ZpbmcNCj4gPiB0aGUNCj4gPiBt
YXN0ZXIgc3dpdGNoIGZvciB0aGlzIGZlYXR1cmUgZG9lc24ndCBzZWVtIHRvIGhhdmUgYW55IGJl
bmVmaXRzDQo+ID4gb3RoZXINCj4gPiB0aGFuIG5vdCBoYXZpbmcgdG8gc2V0IGl0IGluIHRoZSBE
VFMuIFNpbWlsYXJseSwgdGhlIG1hc3RlciBzd2l0Y2gNCj4gPiBmb3INCj4gPiBWQTA5IHNlZW1z
IHRvIGhhdmUgbW9yZSBkaXNhZHZhbnRhZ2UuDQo+ID4gDQo+IA0KPiBTb3JyeSwgYnV0IEkgc3Rp
bGwgZG9uJ3Qgc2VlIGhvdyBhIGZldyAqbWljcm9zZWNvbmRzKiBtb3JlIG9mIGJvb3QNCj4gdGlt
ZSBjYW4NCj4gYmUgc2lnbmlmaWNhbnQsIGV2ZW4gcmVsYXRlZCB0byBwb3dlciBjb25zdW1wdGlv
biBkdXJpbmcgYm9vdC4NCj4gDQo+IElmIHRoYXQgd2FzIGEgZmV3IG1pbGxpc2Vjb25kcywgdGhl
biBJJ2QgYWdyZWUgd2l0aCB5b3UsIGJ1dCB0aGF0J3MNCj4gbm90IHRoZSBjYXNlLg0KPiANCj4g
UmVtb3ZpbmcgdGhlIG1hc3RlciBzd2l0Y2ggaGFzIGEgYmVuZWZpdDogeW91ICpsb3NlKiBhIGZl
dw0KPiBtaWNyb3NlY29uZHMgb2YgYm9vdA0KPiB0aW1lIChzbywgYm9vdHMgaW4gKmZldyBtaWNy
b3NlY29uZHMgTEVTUyopIG9uIHBsYXRmb3JtcyB0aGF0IHdvdWxkDQo+IGhhdmUgdGhpcyBzZXQN
Cj4gaW4gZGV2aWNldHJlZSwgYXMgdGhpcyBwcm9wZXJ0eSBpcyByZWR1bmRhbnQgd2l0aCB0aGUg
b3RoZXINCj4gYWN0aXZhdGlvbiBjaGVja3MNCj4gZm9yIHRob3NlIGZlYXR1cmVzLg0KPiANCj4g
U28sIHRoZXJlIHlvdSBnbzogaWYgdGhlIG1ham9yaXR5IG9mIE1lZGlhVGVrIHBsYXRmb3JtcyBh
cmUgYWxyZWFkeQ0KPiB1c2luZyB0aGlzDQo+IGNyeXB0IGJvb3N0IGZlYXR1cmUsIHRoZW4gdGhp
cyBjb21taXQgcmVkdWNlcyBjYXJib24gZW1pc3Npb25zLCBhcw0KPiB0aG9zZSB3b3VsZA0KPiBi
b290IGluIGEgZmV3IGxlc3MgbWljcm9zZWNvbmRzLg0KPiANCg0KQnV0IHRoZSBtYWpvcml0eSBw
bGF0Zm9tcnMgZG9zZW4ndCBuZWVkIHRoaXMgZmVhdHVyZS4NClRoaXMgZmVhdHVyZSBpcyBvbmx5
IGZvciBsZWdhY3kgY2hpcCB3aGljaCBhdCBsZWFzdCA0IHllYXJzIGFnby4NCg0KVGhhbmtzDQpQ
ZXRlcg0KDQoNCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KPiA+IA0KPiA+ID4gUmVnYXJkcywN
Cj4gPiA+IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gPiA+IFRoYW5rcy4NCj4gPiA+ID4gUGV0ZXINCj4g
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiAgICAJcmV0ID0gdWZzX210a19p
bml0X3ZhMDlfcHdyX2N0cmwoaGJhKTsNCj4gPiA+ID4gPiAgICAJaWYgKHJldCkNCj4gPiA+IA0K
PiA+ID4gDQo+IA0KPiANCg==


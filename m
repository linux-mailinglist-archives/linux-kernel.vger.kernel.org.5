Return-Path: <linux-kernel+bounces-165960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AEC8B93D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526BC1C21124
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4137A1BF3B;
	Thu,  2 May 2024 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oFSMgaP1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="d2SBZ75c"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C22171AA;
	Thu,  2 May 2024 04:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623797; cv=fail; b=EeZk2aWFA4FEmnuSqg1kxNov1b4iHoY02epTHxbtbUJT9RNeQgDUawk5qpeOKBYFgdUg5E3+2gfagc2H3KkLP1XW4LfemWmm3EpGYkAF5r5MRjQUusOmWs87BwvYlx9vKP7/bXtd1qwznAxog3B2phfiO7mC5DBTWrdl5pbuq5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623797; c=relaxed/simple;
	bh=swxhv+BmmQBRZy2ZE15cVMpJcZC/iUXfGkl6rvwkzcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=quae/ivt+P5Zbg1IcdbpSSf8AkfLqbiWi66oXYtK/kW2EGOMbJbJ/RsIpDotkCq1MPuMUE3c7AAATZal8rAU3utiSXUnZkCksGqrWV/Zxn+eGoQslEiSyCpZ9l/lTrz/GKai2vzXIYMSiB27ZpemgTfP7wma4Ucgz4jwJZDu99M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oFSMgaP1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=d2SBZ75c; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ac070770083b11ef8065b7b53f7091ad-20240502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=swxhv+BmmQBRZy2ZE15cVMpJcZC/iUXfGkl6rvwkzcY=;
	b=oFSMgaP1X1fh+jXJyMR5AJCkTG0VhvYerMRXPbEQ8fycLl11VS/nyoY+N9nSSiCPDB1lviQ9i2NtKp+Eb7ebvq/YR02Dilsm+QMm+2CdUqsJPKxMFS9TZnT6FAI2PjWyg0g81yWGsrHTtmAlrw/1xYPb9XvQ/18KB3Z2kB6JhPE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:8f954a97-d0d7-42ca-8c14-a1a228a5a866,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a6364192-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac070770083b11ef8065b7b53f7091ad-20240502
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 667929636; Thu, 02 May 2024 12:23:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 May 2024 12:23:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 May 2024 12:23:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/xfJWuzQfgAh7v95lrW8B3fV7/fGw0hlN7Cxr0qFbzhOCqlgcR2CI76x1Y/NTqGilcAu85fKBYDH46Okzh0WdYnyWwG2KeT4W5MfqfMM/Py724fn71bDpY1WI41xt7HepbkUeDQyBczXJsdMAYYIKXvE1Fxpw2FGTCB/Uz35QyQvp8AVpv+T5bVXNbpI8INCAw0Aj/1kzMCsU0mUi4PohKHTl6Gsy7DrDjeJga8g8dJ1QmkO/IrNbNOJdbmEhkalpYlhyE9wuZI6haHLL9p/PilAgV+QRLufb/Qhkwz0pLaWRCgTgCx8/CmLjiWGYzBua6k6X89OMqO9HMPtxhAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swxhv+BmmQBRZy2ZE15cVMpJcZC/iUXfGkl6rvwkzcY=;
 b=B6km1BT16YaCh7fkkyZnC+gQYTwv1pTDEk+aZHhX/YPyu1yCeXySZQnRnDBxYU05qMPONGE3xGpWz4qXq7BtVdpz2WVJ7R/jvrz2wKI859pe3z7T9pyxmD2GUhwyWMsb/66N1pn5ByZygUoWeObFVI2pB2/tRXbZm2/HubbTjnyzD6v5qowqAFZuWQQdLE5py5p+n8mpYnnTyIk7HyW6KenuxQDyWarQr7ZxlS6kRj3ZXntPfsyoM1dIf4FLgEX1Epiy31lHvYfb5Lyi1YZb+V7zQPPKXfSQKvLtBWUpyYF0Z4DRg9yM/KZvs5M7CBn1qaEYqcg+KThTa//s84eA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swxhv+BmmQBRZy2ZE15cVMpJcZC/iUXfGkl6rvwkzcY=;
 b=d2SBZ75ccXReUKAQBvpjxKEsoJaGYg3nMdtVoxnqUr83nrIMLXDRkkseUw4LzT32ywmV4JDuHXcU/E5MEdh5IPWzFswswQy1/WUvcncHd6GtTHZib2VrdE3JdmglVQGkXM0uhKmRxYNIQasd85Go446mH/U9GDJ0VVxpJi9x7Io=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by SG2PR03MB6825.apcprd03.prod.outlook.com (2603:1096:4:1d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Thu, 2 May
 2024 04:23:01 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::343a:d17a:5383:4b1a]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::343a:d17a:5383:4b1a%7]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 04:23:01 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Fix uaf issue in tracing_open_file_tr
Thread-Topic: [PATCH] tracing: Fix uaf issue in tracing_open_file_tr
Thread-Index: AQHal6xCZTDOyK83d0m4QJA7T219GbF+aQGAgAEyugCAA7F4AIAAC0UAgAAJBAA=
Date: Thu, 2 May 2024 04:23:01 +0000
Message-ID: <b07fb8786f8f466e3e27405be079db849c960b8f.camel@mediatek.com>
References: <20240426073410.17154-1-Tze-nan.Wu@mediatek.com>
	 <20240428202837.0cabca17@rorschach.local.home>
	 <20240429144626.7d868ad3@gandalf.local.home>
	 <661f101456506db945ccbd94700a0f47b95f91e5.camel@mediatek.com>
	 <20240501235044.12fa3297@gandalf.local.home>
In-Reply-To: <20240501235044.12fa3297@gandalf.local.home>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|SG2PR03MB6825:EE_
x-ms-office365-filtering-correlation-id: e7eb7575-ed94-42ab-fa4f-08dc6a5f8dc8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZS9Sek96c1g1ZmxXWEZhRHZVdnZiMXFTREJPbGpWSWhLaGdoelRFNDFnc0ho?=
 =?utf-8?B?c1VaZDVBRzVncjY0QmZ0cTExakJFeXFCZU8rRWlHNmdKdHhGRXVNNStXRmMy?=
 =?utf-8?B?UjF3eDAxbCtPTGtZNWxZMjhyNXNnT1RCN3EvRU5PeUJuMDkwRE92UGszcGpL?=
 =?utf-8?B?Vk9SbHpRLzBTZklWcjVkYk5FckdoU2sxdWFzZDhKQlZJOUQ4RHZGS3FmMVRs?=
 =?utf-8?B?QVBadjVnYmtYNWNHQU5Ob0JabEN3aEljUXNGTUU1VlB0SHFQRDcwalJEOFgx?=
 =?utf-8?B?OHZKNG50Zk9uMnJqSlhjZit2WW1IK0lyV2ZINUo0K3FZOW9icWxRWXNPUW1S?=
 =?utf-8?B?dGdvQ3doY2ljKzB3TDB0ZWl2Rzd0OHFHdjY0UkNOSXpsZmxOeXRWRkFKWDJz?=
 =?utf-8?B?LzhHWG85bnJhVGgxektKMDRyd29mTzRweWJVM2pUZzdJV1d5Tyt5cmN4bDlx?=
 =?utf-8?B?VlpBc1loM0dUVTJKZXdSRGhnbFNxeVdwSVIxaFZFUHdCelgzS2l2ckV4bU4v?=
 =?utf-8?B?VSs4bk8ySkd3UUdWVUN3ZXlLWUVhZmk5VWJIOHVaN0doRHBqdU5mdXo5TDkv?=
 =?utf-8?B?Y0VDbFJUbUgzMDBBdkFiSC9yNjdDN3VnTzNyamN1YjBxcU02WG12ckZBYjFS?=
 =?utf-8?B?TTZZeVc5RzVMZHl1dk9yVk5lY3ZEUkZleEthRlUyUjRzUm5CSXBKYUl5S3Yx?=
 =?utf-8?B?dTZzZXZJcHpoTnJ4OWJDVWd2UFI2amRRRkdjSk9hWGZzTWhyZ25MeUw4ZUhT?=
 =?utf-8?B?ZjdVVUMyUUxuT0NRdVZJdU13SVNzYm1wQjh4S0EvSjRVTGpmeksyUjNkMDRo?=
 =?utf-8?B?UWR4bVA1bStxOWNTWndOSFRQejVLS09yLzNFM2JDZnZsaFE4ZFNpeTJBcUdi?=
 =?utf-8?B?OHZsbC81Q1FLZGNKTXBYODNuU2cwY3pmVjZaMXdvNVQ1SWl3aVR1Qkp4bk54?=
 =?utf-8?B?OGdpQnVoUWk0bjBBeHFxYU5SZ3pHSy81OU0wcnRQcXdJazRLZ09SSENZSzJm?=
 =?utf-8?B?aHY5WG1ZTWxrdkFZOTJtTXdqQmY3empLTFFVRDRPNjJ2MEV6czNyTTJBUzJZ?=
 =?utf-8?B?ZUhMUlZLTk9LZ0hFVGZrTnBwVTRBbHpnamxFem9Sbkh0RGI1QVZEdXhsdnY2?=
 =?utf-8?B?SzNKdVJKRVFnTTJtYzlFaTNmYk52aDFjWTJONHFiL2dJU2U1RWdnd0phY044?=
 =?utf-8?B?Ujhia05jQ21Vc3k5dUZ3Nlc1R04rRkFQTlVXSFJmb1hoTGtjdWVDSFNqdFNP?=
 =?utf-8?B?ZmtHTk9jZjRDUmpaNDQrcERKQ0RvYktlNEUxdmtoUURPNDVrMEdqdDNVTnhI?=
 =?utf-8?B?dDRWQlljb0hla3h6RzB1RjVDYmw0eWt3ek15WElPYTNQbjUxaGg0RXloSkE0?=
 =?utf-8?B?ZWZ2UC9Cc2RrU3o1UnlpQUFOc1RMSVJscS9DaTVMSGhTUWh1V2Z3MmZtWGRK?=
 =?utf-8?B?dVdRenRPRzVxY0F5TWNrME9uSzBURE5OMkEwMnUzVUhuSGhNaFJRQVFIN0Vv?=
 =?utf-8?B?aFN1VEFsakVEeFczQlgvWTV1N0d6Mk5KTE1PZlZkUG0zcEVCRGZVamZMaEIr?=
 =?utf-8?B?Q04wU2R1V3RZcG03N1JZekp6SDdFZ1BNcGdxTi9MR3N6K3RWNjk5ZzlTY2lx?=
 =?utf-8?B?QXQ0UkN1YlRnVXFNaE1IR0tET25NUzVybVdBUUR6ZGtxNzJ5S2dma2g4SHNE?=
 =?utf-8?B?YjZxUVk4OE5ZL05JT0tTUFVKOXdaYW1BY1lTajNNaFBoSkwrYTlacno3eVZw?=
 =?utf-8?B?NTkzQ2tudGpzSjZBTmR0bDNVVFY0UmprdGhOMVA1NkwyOExBL1p2cnc0d2pZ?=
 =?utf-8?B?RFJObmFTckdHOUt2c3lRQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3FRbDdiZFlhK3VXTEE1L3MxdVBIVWJzRHFjbTV2dUg2emc4UFQ4Yjc4anRo?=
 =?utf-8?B?T0p5OGpUOGJCZ2ZUckV2MVBuVEJpa3RGVndabktHbDd5SHZOY0RzZElSQjN0?=
 =?utf-8?B?Qi85dUxMNmRabm4xMnpNUFk1WWpwM2hXVGt4cnZ4OUJVUWJIVEUzS0oxVXh5?=
 =?utf-8?B?a2RhWEkvZlZQVEZrN2lOZGEyWjA5RHl3OTRzeEhSbmhZa1c2ZnFQbmppcVpF?=
 =?utf-8?B?RU4rL2VnR2k1UFZnTG5NcWUzZ3QwVWx1YlJnd1BlSU96Sjhia1J1bGNjaEV6?=
 =?utf-8?B?eVJGbEwrWVUxUlVrT3cxYlhyRzAzcmVlSzM4UWNCT2pqT2IxS0dTMjFOQlFL?=
 =?utf-8?B?ekppQ3h0UVNJbURsR2ZTZTJsN2hmdjQ5ZGhWNmc5eUpBZUt0VjlKcmx4Y0dR?=
 =?utf-8?B?N2dOMzlydVZQNzAvUWloUkFIL1hSdTl4WG9BckpWVEFUV2F2YkZvZFFnQkxS?=
 =?utf-8?B?dkUzdFFVZ2VNTElBWXp2RlRxOHZoQ0RzOUZRTThHVlJkbmh1SWNKa0hicXc1?=
 =?utf-8?B?K1dWNDdWY3dxSC9VYzVUMVdmOGVaTVBuYmhyL3Q1S282WFhwRWdvTWwwWE55?=
 =?utf-8?B?ZFZBWmZ0cGNseC9RbUVldXpReDNuV081YURTRFBud3gwWEFnWDB6UkJaZlVk?=
 =?utf-8?B?Y2pBeTNJUGowWjJpTTBjT0ZBMndPSTFCanNndlRaWXVhRHZIMWdKL29ya1Mx?=
 =?utf-8?B?cWNVYXp6aEF4MWhrZEpRSmlpbytNeVNDWUtQMFRSejJDTW9ma0JHTGIyYi9Y?=
 =?utf-8?B?K0Y3KzlZOFlLa2dJU29YcmZlVXNkVkFVMFZKMUNqUG45a3MzQ05PQmdqdmdu?=
 =?utf-8?B?OElrL0tEU2M0ckE0NkZ0eFJBWHJRMnljVHhQcC9PUjcwQVZJN2tTeHg0VjNt?=
 =?utf-8?B?M2ErZTJNdS8yeW5RMUJwRGdGMUJlY0ZmT24rQTBZMzJDOXVXZU5PWTFMZ2Nr?=
 =?utf-8?B?MU9ZU2xxVDRCcFFtc01sbHpadi9qNWxDUUliKzhUbnJTMUppeDNwUWhkTDJF?=
 =?utf-8?B?ZjFBOGNGUEF3c1VEa3dRaVhGZEsyWHBWb1lhbWFWdzZJVlhXM0lpTFhoR3Zi?=
 =?utf-8?B?QkhVcHkwVEVMUnoyaUVFOVRCT2NxTkZhaTgxZ0szWHBOZGFJTVhTV3F4eDl5?=
 =?utf-8?B?WEx2UlJsTXNkVFVmM09oem9OSGczMnZaV053Um5rbklxVWRQelNNbWUxZ2RT?=
 =?utf-8?B?T0F0N01MRzJjMmNyYkYyZWhwbXJ5MGNNNVVydkNXbXVEeGlCMnN6ZVdVbGZL?=
 =?utf-8?B?VTRpTWJna0c1T3BCWHM5V09kenZhRHRGYnE0c2VTb25lQmcwV3NHKzNmME5F?=
 =?utf-8?B?K2RnM1NDTlIremxjclhINWY2dXpnRkgxdlcwUFRBazhhREY0QTBzQXpJSks3?=
 =?utf-8?B?K291azBzckRIdFltdWZZZldORkNWTzFyakRmVjdlODMzQnNaaWJJZ2x5dnVi?=
 =?utf-8?B?Wk52VlI3RzVXTC9zZjBhTSt2RllqUXl1bUs5ajhrZS92UXFQSS84eGZvbUx6?=
 =?utf-8?B?Y3hTU3kybDZSSHdkdUxFZENTOG1aaG5wUSt1RHVtbzNBQ2x3UFRlSU51SS9S?=
 =?utf-8?B?RmRiTzVOUzlwZlFteWppcjlzbk9yaWtmS2VPTEk4YmhDQmo4dVpNbVppV2lC?=
 =?utf-8?B?Y3BLSlYrZHlzOHF6dXRMNFRiNW5IV2pkWk42ODhQa2UvZHhkWWNzU3JUZGs0?=
 =?utf-8?B?TEpHRUxOTDBFbFZGSHNzelNFcEpQeTVmME9WSTFRckZRNm5FY3FIb28zYXVo?=
 =?utf-8?B?QlB5aklYSzRZWThoUUVuZjZRVFhENEE1RU53UzVXMXR5QVVSM0tiOGF5VzBz?=
 =?utf-8?B?SExZQ2xoQUNzdFkxNDJCUUZSYnFVY0JHbk9zaVZoMHRiVkpRNUNwaEw4WUt6?=
 =?utf-8?B?Qy9PemlHNjB2SEFwczZGNSszbjhqblcxYWx0RUNPaDVVdjlsRzZZWXdORW41?=
 =?utf-8?B?cDgwbENkUnpPT3daY3RnTnRyU3ZIc2pxSTVRZHBjY3QwWHgrYmJidHJTUmRO?=
 =?utf-8?B?UFNXK1BocVFqUTcyVW1TNGxSU3NxZWVISnNMYmpOdGFGTTVneVllVmtFc044?=
 =?utf-8?B?V0N3MSsraXZnWXcybWwwUHlCUEZxeFpyb3ZRdDc0MUx5aVVBeHhXOU14Vitq?=
 =?utf-8?B?dzJ4VVptS3BGM0RkSTNGRkhCdjNWdlkzUmhEdjRvNWpmeGN1OHB2ZlZXUlRa?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B6BE1910872D34484C63CB83FF90F75@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eb7575-ed94-42ab-fa4f-08dc6a5f8dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 04:23:01.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDL/0FSXNFQzaQaLwQRLTf6LYq0b6WOhY4x/bl4ZySof7SAH5ioMGvtRSE8rE3+1ADmSViGa3UCeYCfU7aG+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6825

T24gV2VkLCAyMDI0LTA1LTAxIGF0IDIzOjUwIC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBUaHUsIDIgTWF5IDIwMjQgMDM6MTA6MjQgKzAwMDANCj4gVHpl
LW5hbiBXdSAo5ZCz5r6k5Y2XKSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiAN
Cj4gPiA+ICAgDQo+ID4gU29ycnkgZm9yIG15IGxhdGUgcmVwbHksIEknbSB0ZXN0aW5nIHRoZSBw
YXRjaCBvbiBteSBtYWNoaW5lIG5vdy4gDQo+ID4gVGVzdCB3aWxsIGJlIGRvbmUgaW4gZm91ciBo
b3Vycy4NCj4gPiANCj4gPiBUaGVyZSdzIHNvbWV0aGluZyBJJ20gd29ycnlpbmcgYWJvdXQgaW4g
dGhlIHBhdGNoLA0KPiA+IHdoYXQgSSdtIHdvcnJ5aW5nIGFib3V0IGlzIGNvbW1lbnRlZCBpbiB0
aGUgY29kZSBiZWxvdy4NCj4gPiANCj4gPiAva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jOg0K
PiA+ICAgc3RhdGljIGludA0KPiA+ICAgZXZlbnRfY3JlYXRlX2RpcihzdHJ1Y3QgZXZlbnRmc19p
bm9kZSAqcGFyZW50LCANCj4gPiAgIHN0cnVjdCB0cmFjZV9ldmVudF9maWxlICpmaWxlKSANCj4g
PiAgIHsNCj4gPiAgICAgICAgIC4uLg0KPiA+ICAgICAgICAgLi4uDQo+ID4gICAgICAgICAuLi4N
Cj4gPiAgICAgICAgIG5yX2VudHJpZXMgPSBBUlJBWV9TSVpFKGV2ZW50X2VudHJpZXMpOw0KPiA+
IA0KPiA+ICAgICAgICAgbmFtZSA9IHRyYWNlX2V2ZW50X25hbWUoY2FsbCk7DQo+ID4gDQo+ID4g
ICAgICAgICArZXZlbnRfZmlsZV9nZXQoZmlsZSk7ICAgICAgICAvLyBMaW5lIEENCj4gPiAgICAg
ICAgICAgICBeXl5eXl5eXl5eXl5eDQo+ID4gICAgICAgICAvLyBTaG91bGQgd2UgbW92ZSB0aGUg
ImV2ZW50X2ZpbGVfZ2V0IiB0byBoZXJlLCBpbnN0ZWFkICANCj4gPiAgICAgICAgIC8vIG9mIGNh
bGxpbmcgaXQgYXQgbGluZSBDPw0KPiA+ICAgICAgICAgLy8gRHVlIHRvIExpbmUgQiBjb3VsZCBl
dmVudHVhbGx5IGludm9rZSAiZXZlbnRfZmlsZV9wdXQiLg0KPiA+ICAgICAgICAgLy8gICBldmVu
dGZzX2NyZWF0ZV9kaXIgLT4gZnJlZV9laSAtPnB1dF9laSAtPiBrcmVmX3B1dCANCj4gPiAgICAg
ICAgIC8vICAtPiByZWxlYXNlX2VpIC0+IGV2ZW50X3JlbGVhc2UgLT4gZXZlbnRfZmlsZV9wdXQN
Cj4gPiAgICAgICAgIC8vIE5vdCBzdXJlIGlmIHRoaXMgaXMgYSBwb3RlbnRpYWwgcmlzaz8gSWYg
TGluZSBCIGRvDQo+IGNhbGwgICANCj4gPiAgICAgICAgIC8vIGV2ZW50X2ZpbGVfcHV0LCJldmVu
dF9maWxlX3B1dCIgd2lsbCBiZSBjYWxsZWQgcHJpb3IgdG8NCj4gPiAgICAgICAgIC8vICJldmVu
dF9maWxlX2dldCIsIGNvdWxkIGNvcnJ1cHQgdGhlIHJlZmVyZW5jZSBvZiB0aGUNCj4gZmlsZS4N
Cj4gDQo+IE5vLCBidXQgeW91IGRvIGJyaW5nIHVwIGEgZ29vZCBwb2ludC4gVGhlIHJlbGVhc2Ug
c2hvdWxkIG5vdCBiZQ0KPiBjYWxsZWQgb24NCj4gZXJyb3IsIGJ1dCBpdCBsb29rcyBsaWtlIGl0
IHBvc3NpYmx5IGNhbiBiZS4NCj4gDQo+ID4gDQo+ID4gICAgICAgICBlaSA9IGV2ZW50ZnNfY3Jl
YXRlX2RpcihuYW1lLCBlX2V2ZW50cywgICAgLy8gTGluZSBCIA0KPiA+ICAgICAgICAgICAgICBl
dmVudF9lbnRyaWVzLCBucl9lbnRyaWVzLCBmaWxlKTsNCj4gPiAgICAgICAgIGlmIChJU19FUlIo
ZWkpKSB7DQo+ID4gICAgICAgICAgICAgICAgIHByX3dhcm4oIkNvdWxkIG5vdCBjcmVhdGUgdHJh
Y2VmcyAnJXMnDQo+IGRpcmVjdG9yeVxuIiwgDQo+ID4gICAgICAgICAgICAgICAgIG5hbWUpOw0K
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAg
ICBmaWxlLT5laSA9IGVpOw0KPiA+IA0KPiA+ICAgICAgICAgcmV0ID0gZXZlbnRfZGVmaW5lX2Zp
ZWxkcyhjYWxsKTsNCj4gPiAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gICAgICAgICAgICAg
ICAgIHByX3dhcm4oIkNvdWxkIG5vdCBpbml0aWFsaXplIHRyYWNlIHBvaW50DQo+IGV2ZW50cy8l
c1xuIiwNCj4gPiBuYW1lKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eICAgICAgICAgIA0KPiA+ICAgICAgICAvLyBNYXli
ZSB3ZSBjaG91bGQgaGF2ZSBzaW1pbGFyIGNvbmNlcm4gaWYgd2UgcmV0dXJuIGhlcmUuDQo+ID4g
ICAgICAgIC8vIER1ZSB0byB0aGUgZXZlbnRfaW5vZGUgaGFkIGJlZW4gY3JlYXRlZCwgYnV0IHdl
IGRpZCBub3QNCj4gY2FsbCANCj4gPiAgICAgICAgLy8gZXZlbnRfZmlsZV9nZXQuIA0KPiA+ICAg
ICAgICAvLyBDb3VsZCBpdCBsZWFkIHRvIHNvbWUgaXNzdWVzIGluIHRoZSBmdXR1cmUgd2hpbGUg
ZnJlZWluZyANCj4gPiAgICAgICAgLy8gZXZlbnRfaW5kb2U/DQo+ID4gICAgICAgICB9DQo+ID4g
DQo+ID4gDQo+ID4gICAgICAgICAtZXZlbnRfZmlsZV9nZXQoZmlsZSk7ICAgICAgIC8vTGluZSBD
DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgIH0NCj4gDQo+IFRoaXMgcHJldmVudHMgdGhl
IHJlbGVhc2UoKSBmdW5jdGlvbiBmcm9tIGJlaW5nIGNhbGxlZCBvbiBmYWlsdXJlIG9mDQo+IGNy
ZWF0aW5nIHRoZSBlaS4NCj4gDQo+IENhbiB5b3UgdHJ5IHRoaXMgcGF0Y2ggaW5zdGVhZD8NCj4g
LS0gU3RldmUNCj4gDQpTdXJlLCB3aWxsIHJlcGx5IHRoZSBtYWlsIGFnYWluIGFmdGVyIHRoZSB0
ZXN0IGZpbmlzaCBBU0FQLg0KLS0gVHplLW5hbg0KDQo+IGRpZmYgLS1naXQgYS9mcy90cmFjZWZz
L2V2ZW50X2lub2RlLmMgYi9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMNCj4gaW5kZXggODk0YzZj
YTFlNTAwLi5mNTUxMGUyNmYwZjYgMTAwNjQ0DQo+IC0tLSBhL2ZzL3RyYWNlZnMvZXZlbnRfaW5v
ZGUuYw0KPiArKysgYi9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMNCj4gQEAgLTg0LDEwICs4NCwx
NyBAQCBlbnVtIHsNCj4gIHN0YXRpYyB2b2lkIHJlbGVhc2VfZWkoc3RydWN0IGtyZWYgKnJlZikN
Cj4gIHsNCj4gIHN0cnVjdCBldmVudGZzX2lub2RlICplaSA9IGNvbnRhaW5lcl9vZihyZWYsIHN0
cnVjdCBldmVudGZzX2lub2RlLA0KPiBrcmVmKTsNCj4gK2NvbnN0IHN0cnVjdCBldmVudGZzX2Vu
dHJ5ICplbnRyeTsNCj4gIHN0cnVjdCBldmVudGZzX3Jvb3RfaW5vZGUgKnJlaTsNCj4gIA0KPiAg
V0FSTl9PTl9PTkNFKCFlaS0+aXNfZnJlZWQpOw0KPiAgDQo+ICtmb3IgKGludCBpID0gMDsgaSA8
IGVpLT5ucl9lbnRyaWVzOyBpKyspIHsNCj4gK2VudHJ5ID0gJmVpLT5lbnRyaWVzW2ldOw0KPiAr
aWYgKGVudHJ5LT5yZWxlYXNlKQ0KPiArZW50cnktPnJlbGVhc2UoZW50cnktPm5hbWUsIGVpLT5k
YXRhKTsNCj4gK30NCj4gKw0KPiAga2ZyZWUoZWktPmVudHJ5X2F0dHJzKTsNCj4gIGtmcmVlX2Nv
bnN0KGVpLT5uYW1lKTsNCj4gIGlmIChlaS0+aXNfZXZlbnRzKSB7DQo+IEBAIC0xMTIsNiArMTE5
LDE4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX2VpKHN0cnVjdCBldmVudGZzX2lub2RlDQo+
ICplaSkNCj4gIH0NCj4gIH0NCj4gIA0KPiArLyoNCj4gKyAqIENhbGxlZCB3aGVuIGNyZWF0aW9u
IG9mIGFuIGVpIGZhaWxzLCBkbyBub3QgY2FsbCByZWxlYXNlKCkNCj4gZnVuY3Rpb25zLg0KPiAr
ICovDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgY2xlYW51cF9laShzdHJ1Y3QgZXZlbnRmc19pbm9k
ZSAqZWkpDQo+ICt7DQo+ICtpZiAoZWkpIHsNCj4gKy8qIFNldCBucl9lbnRyaWVzIHRvIDAgdG8g
cHJldmVudCByZWxlYXNlKCkgZnVuY3Rpb24gYmVpbmcgY2FsbGVkICovDQo+ICtlaS0+bnJfZW50
cmllcyA9IDA7DQo+ICtmcmVlX2VpKGVpKTsNCj4gK30NCj4gK30NCj4gKw0KPiAgc3RhdGljIGlu
bGluZSBzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZ2V0X2VpKHN0cnVjdCBldmVudGZzX2lub2RlICpl
aSkNCj4gIHsNCj4gIGlmIChlaSkNCj4gQEAgLTczNCw3ICs3NTMsNyBAQCBzdHJ1Y3QgZXZlbnRm
c19pbm9kZSAqZXZlbnRmc19jcmVhdGVfZGlyKGNvbnN0DQo+IGNoYXIgKm5hbWUsIHN0cnVjdCBl
dmVudGZzX2lub2RlDQo+ICANCj4gIC8qIFdhcyB0aGUgcGFyZW50IGZyZWVkPyAqLw0KPiAgaWYg
KGxpc3RfZW1wdHkoJmVpLT5saXN0KSkgew0KPiAtZnJlZV9laShlaSk7DQo+ICtjbGVhbnVwX2Vp
KGVpKTsNCj4gIGVpID0gTlVMTDsNCj4gIH0NCj4gIHJldHVybiBlaTsNCj4gQEAgLTgzNSw3ICs4
NTQsNyBAQCBzdHJ1Y3QgZXZlbnRmc19pbm9kZQ0KPiAqZXZlbnRmc19jcmVhdGVfZXZlbnRzX2Rp
cihjb25zdCBjaGFyICpuYW1lLCBzdHJ1Y3QgZGVudHJ5DQo+ICByZXR1cm4gZWk7DQo+ICANCj4g
ICBmYWlsOg0KPiAtZnJlZV9laShlaSk7DQo+ICtjbGVhbnVwX2VpKGVpKTsNCj4gIHRyYWNlZnNf
ZmFpbGVkX2NyZWF0aW5nKGRlbnRyeSk7DQo+ICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4g
IH0NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdHJhY2Vmcy5oIGIvaW5jbHVkZS9saW51
eC90cmFjZWZzLmgNCj4gaW5kZXggN2E1ZmUxN2I2YmY5Li5kMDNmNzQ2NTg3MTYgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvdHJhY2Vmcy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdHJh
Y2Vmcy5oDQo+IEBAIC02Miw2ICs2Miw4IEBAIHN0cnVjdCBldmVudGZzX2ZpbGU7DQo+ICB0eXBl
ZGVmIGludCAoKmV2ZW50ZnNfY2FsbGJhY2spKGNvbnN0IGNoYXIgKm5hbWUsIHVtb2RlX3QgKm1v
ZGUsDQo+IHZvaWQgKipkYXRhLA0KPiAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyAqKmZv
cHMpOw0KPiAgDQo+ICt0eXBlZGVmIHZvaWQgKCpldmVudGZzX3JlbGVhc2UpKGNvbnN0IGNoYXIg
Km5hbWUsIHZvaWQgKmRhdGEpOw0KPiArDQo+ICAvKioNCj4gICAqIHN0cnVjdCBldmVudGZzX2Vu
dHJ5IC0gZHluYW1pY2FsbHkgY3JlYXRlZCBldmVudGZzIGZpbGUgY2FsbCBiYWNrDQo+IGhhbmRs
ZXINCj4gICAqIEBuYW1lOlRoZW4gbmFtZSBvZiB0aGUgZHluYW1pYyBmaWxlIGluIGFuIGV2ZW50
ZnMgZGlyZWN0b3J5DQo+IEBAIC03Miw2ICs3NCw3IEBAIHR5cGVkZWYgaW50ICgqZXZlbnRmc19j
YWxsYmFjaykoY29uc3QgY2hhciAqbmFtZSwNCj4gdW1vZGVfdCAqbW9kZSwgdm9pZCAqKmRhdGEs
DQo+ICBzdHJ1Y3QgZXZlbnRmc19lbnRyeSB7DQo+ICBjb25zdCBjaGFyKm5hbWU7DQo+ICBldmVu
dGZzX2NhbGxiYWNrY2FsbGJhY2s7DQo+ICtldmVudGZzX3JlbGVhc2VyZWxlYXNlOw0KPiAgfTsN
Cj4gIA0KPiAgc3RydWN0IGV2ZW50ZnNfaW5vZGU7DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJh
Y2UvdHJhY2VfZXZlbnRzLmMNCj4gYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCj4gaW5k
ZXggNTJmNzVjMzZiYmNhLi42ZWYyOWViYTkwY2UgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC90cmFj
ZS90cmFjZV9ldmVudHMuYw0KPiArKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCj4g
QEAgLTI1NTIsNiArMjU1MiwxNCBAQCBzdGF0aWMgaW50IGV2ZW50X2NhbGxiYWNrKGNvbnN0IGNo
YXIgKm5hbWUsDQo+IHVtb2RlX3QgKm1vZGUsIHZvaWQgKipkYXRhLA0KPiAgcmV0dXJuIDA7DQo+
ICB9DQo+ICANCj4gKy8qIFRoZSBmaWxlIGlzIGluY3JlbWVudGVkIG9uIGNyZWF0aW9uIGFuZCBm
cmVlaW5nIHRoZSBlbmFibGUgZmlsZQ0KPiBkZWNyZW1lbnRzIGl0ICovDQo+ICtzdGF0aWMgdm9p
ZCBldmVudF9yZWxlYXNlKGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKmRhdGEpDQo+ICt7DQo+ICtz
dHJ1Y3QgdHJhY2VfZXZlbnRfZmlsZSAqZmlsZSA9IGRhdGE7DQo+ICsNCj4gK2V2ZW50X2ZpbGVf
cHV0KGZpbGUpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50DQo+ICBldmVudF9jcmVhdGVfZGly
KHN0cnVjdCBldmVudGZzX2lub2RlICpwYXJlbnQsIHN0cnVjdA0KPiB0cmFjZV9ldmVudF9maWxl
ICpmaWxlKQ0KPiAgew0KPiBAQCAtMjU2Niw2ICsyNTc0LDcgQEAgZXZlbnRfY3JlYXRlX2Rpcihz
dHJ1Y3QgZXZlbnRmc19pbm9kZSAqcGFyZW50LA0KPiBzdHJ1Y3QgdHJhY2VfZXZlbnRfZmlsZSAq
ZmlsZSkNCj4gIHsNCj4gIC5uYW1lPSAiZW5hYmxlIiwNCj4gIC5jYWxsYmFjaz0gZXZlbnRfY2Fs
bGJhY2ssDQo+ICsucmVsZWFzZT0gZXZlbnRfcmVsZWFzZSwNCj4gIH0sDQo+ICB7DQo+ICAubmFt
ZT0gImZpbHRlciIsDQo+IEBAIC0yNjM0LDYgKzI2NDMsOSBAQCBldmVudF9jcmVhdGVfZGlyKHN0
cnVjdCBldmVudGZzX2lub2RlICpwYXJlbnQsDQo+IHN0cnVjdCB0cmFjZV9ldmVudF9maWxlICpm
aWxlKQ0KPiAgcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiArLyogR2V0cyBkZWNyZW1lbnRlZCBv
biBmcmVlaW5nIG9mIHRoZSAiZW5hYmxlIiBmaWxlICovDQo+ICtldmVudF9maWxlX2dldChmaWxl
KTsNCj4gKw0KPiAgcmV0dXJuIDA7DQo+ICB9DQo+ICANCg==


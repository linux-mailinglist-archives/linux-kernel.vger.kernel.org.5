Return-Path: <linux-kernel+bounces-63136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36B852B64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEB01C215D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5A24B29;
	Tue, 13 Feb 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W2S1R0NC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lgMUy9t+"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2024A00;
	Tue, 13 Feb 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813742; cv=fail; b=fXgLHhicKG5LMkFE/pkUOAVpznMZm0BDC6lnBigNTgQiYPOPpwIlEpEMqr5V0O6vY5tZljl4gIhOfiy7jN1NL/4gFW1D7yYXP8S2AYDXYQPHYESa7WInxB8PVR5fHmDiweR0gUZNm6ELD1gM4SOmcg06/YYO5NICLI9az/iiNNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813742; c=relaxed/simple;
	bh=PB4THjoz7CU8aEN2vIfb10ubgTlgqe5kzbz/3oe9TRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ezSvah+3XPP9Q/gRpds9KzMQuF8VN7Av6LGbPlGGy76R56X4mHnM3S9ntE4F0MBsy+P1rB4i3RXFoKDHZ2g4M7MFisFYgqwiT3LVxQoKBebQE4n5F5eYsP0W2BTQOQlrrwmYR1HLz3gfYTuvR4AyLBGliEVfSKfdSaLdRPcWIK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=W2S1R0NC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lgMUy9t+; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707813740; x=1739349740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PB4THjoz7CU8aEN2vIfb10ubgTlgqe5kzbz/3oe9TRE=;
  b=W2S1R0NCXC5Xv6Ay5C8t9YtkVzah5dwJFJxlj+Bojamb7MHbeRugOh6J
   IG6wCfEQuK8B8kOO/ZItcaqZPf6BGWqw3fkquQkqFighhE922aIEOpsHC
   akk1FeuNxDd7EX+n3oY7rdKD0jNe/ItJE2seWKwHTmvArbkEey4hmApid
   KDdVMQ5UEC81BwfpasyoWAP2pkhqjDKojlCAMMGGOusoKfSIOUlzoOCfK
   swE9/Da+qdxa3pZV+1TI07Pqc7pBa7iniy32oJZlRvZ07Z63DeE+tgCtV
   k/fxC2vzEYdTA/MpZFhl8rARqyeBwqtgRHflLsu279llroAzOjJDNiaTt
   w==;
X-CSE-ConnectionGUID: Ks9f6ZbwRjGgj+I5d6KWXQ==
X-CSE-MsgGUID: C9iHRFaPRJSaTWXqCul4OQ==
X-IronPort-AV: E=Sophos;i="6.06,156,1705334400"; 
   d="scan'208";a="9118069"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2024 16:42:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkNtW6hjZKc5O4pGRPRWrfDyZXl041JNXOo41p5ipR1oM2oX5a2qXVHNRHvbDX6wTnKUQhdH7/vUMaU/u8ZzQnSOJqG1B3CpaELH4FSHWOWKqE+G6tfx2MrQtXv0yix+ujdId56B+EmPKrTtJJHPH6+fg2zfgss7fRTEnwsmLvuWKPmDIj9NpGWlmKe+VxYAnFCBgYq44ZZZ7VtsF/JJ/nQ1Szqb8WVB7+Hl09OLlkqJKKH5jaIdnMO1QSNGociCro5zmG+4Qk7WJouP9ThBKPsNx5D16YOEw12FpEAWLgieii2vO74h5afq1I8FG41ThEQEMMAFzTI4s+e5mS6Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB4THjoz7CU8aEN2vIfb10ubgTlgqe5kzbz/3oe9TRE=;
 b=Y7pcqfCP82suwf2ojAIgqWhTNnod2YyWiGv+uR4szvcTDyCa+pAdoNM2w6hy8B08NV+5rPhAl49rjdnFE8Gc1bC58RzXbuLfRNxk8umSI5A2mCdbtNu0djopB/4krKr3HFvRRW0d7orJ2qxC1clN3i98YsvwkZ6GBy0h2AqA4S0PiV9McbFewWCovy+VPpAn925S9Qv2pTWZhBL/tcvr9VplpHbddaxPvZI8z5g/thZUBErm/cQotW0jwGWMuLbf8vo3eLqAliIwE8R9/Lg4hT4R65F5nUBnRd8rXsp/lkpPE04SzqyATYeOfIb0TC5IO/pPB1YL/gJ1VOf+9U7Fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB4THjoz7CU8aEN2vIfb10ubgTlgqe5kzbz/3oe9TRE=;
 b=lgMUy9t+rz1rr2tJf2ym6MownC5L5wRg1Z1fce+A7AIhggBG9JEhn4LyFp5OjI03yAPhcQTseGE2s+GKRWuFlN4RmmK5lgwR7PjHXz6wLJZUjgWeFEGt6NVl/f3WN3aWhNU6BfTQ5NWS4rrVymynF7i5IE39CTPWZQjnX6rH1iE=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by BY5PR04MB6883.namprd04.prod.outlook.com (2603:10b6:a03:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Tue, 13 Feb
 2024 08:42:10 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::f5df:e79b:b64d:79]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::f5df:e79b:b64d:79%5]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:42:10 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Seunghui Lee <sh043.lee@samsung.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "grant.jung@samsung.com" <grant.jung@samsung.com>, "jt77.jang@samsung.com"
	<jt77.jang@samsung.com>, "dh0421.hwang@samsung.com"
	<dh0421.hwang@samsung.com>, "junwoo80.lee@samsung.com"
	<junwoo80.lee@samsung.com>, "jangsub.yi@samsung.com"
	<jangsub.yi@samsung.com>, "cw9316.lee@samsung.com" <cw9316.lee@samsung.com>,
	"sh8267.baek@samsung.com" <sh8267.baek@samsung.com>, "wkon.kim@samsung.com"
	<wkon.kim@samsung.com>
Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
Thread-Topic: [PATCH] mmc: sd: Add a variable to check a faulty device
Thread-Index: AQHaXjtoegCDJcQ20UGr6vqYWDGJtrEH8TzA
Date: Tue, 13 Feb 2024 08:42:09 +0000
Message-ID:
 <BL0PR04MB65642D0389544F022A1D2222FC4F2@BL0PR04MB6564.namprd04.prod.outlook.com>
References:
 <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com>
In-Reply-To: <20240213051716.6596-1-sh043.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|BY5PR04MB6883:EE_
x-ms-office365-filtering-correlation-id: 67d2d8ac-3267-45c0-bd08-08dc2c6faae5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /M0AerAaQ6y0qDkgDWNMvZdJO6VOtosk4fONtgABqHZ4dFOaAWO/8J1OpgUKlsGDl+IdhfuGNqEoXzed+updYdhlRR4AbRs18WVn1Uhl1zjKNBAITa0kw7E52ae4MWWg2HNdr4wuzEvI54TwJPxADZQleMnKmgwkX7H9js6aP53rFsma/sgTH9aZZ1y5NCHZbrDVdoTBrWfQvQXsr0KkhXQD+3rX1QYLbNgKQnNYt7Ci6RDnok70RiMl1DiXxGilxTYh9Tm1JD0hkxKZfJOX2pqvuuIrQn2aUu4EA23Q9YDMko8cqQGAAtq1gaz3JXkBu/c5/9JbPu0LZHm7Wv3h5hpYJKLRRvSgcaph7XwC+A5eW2rmEORAE4HUjoVxliPeqeFSW2yjCq9CjNcdvH5HFej8Potnt9vjBESmA7/wKOjHfoC2QLG+dx77YqtDLIo0IHYNqPDDp08HHTRe6h7/1sHTdrRqa2HL+8NqHDi724iQknlHyRGtsg97/MzPdhD6y0TyIiqTSt9N25rojHvn9KdQhOtH9WuOpz1zPLrgl557sdrTaGOTPVP+bCvItPHTO77BhjRRMI4k5FaBRIs82WAFPYKP/zD1hjk5ByFOhBVw5AFLR659o9HSiSFvlaKy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(478600001)(6506007)(83380400001)(9686003)(41300700001)(2906002)(5660300002)(7416002)(33656002)(54906003)(66446008)(52536014)(64756008)(110136005)(66476007)(76116006)(66556008)(316002)(66946007)(4326008)(71200400001)(38070700009)(8936002)(8676002)(38100700002)(82960400001)(86362001)(7696005)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTNZUVd4U1NlbVRzOUQ2SC9VZHREcWduejFBOFBReSs3OG42eE5pM3htbDZ6?=
 =?utf-8?B?d0duV3JIbDMvMFV1amxkWEFCL3FQcmdtM09hV3ZHUy83UFlWZjExRFNYV015?=
 =?utf-8?B?MGpBWGsvQU1XZEtRTFRIMnhkdzhyUHQ5b0p3cnB3bmtONEpsNVBTRVpqVDJu?=
 =?utf-8?B?SGZzaysva0JubmVhNUFINW9ua1B4R0Z3SktGSmlWWlYwcTZTMFRVZ3EyNnFh?=
 =?utf-8?B?N1JCYXN1dWhTUHMwdzZlbVlqenIyU2F3VDF3MHNVVUI3TVMxaUxDZFNTajNt?=
 =?utf-8?B?Y3B3QVVRU2dsdE40anphWmRxSnB5Wi90ellSb1QxVzhtKzNyNHlPTVhPckhF?=
 =?utf-8?B?RElIN2NBazhMSU9NVUVJMDI3SmFxZmVSRHNxWlpYNzg5V1B1YXZDSDYrN0VY?=
 =?utf-8?B?K1YvYk8rOWRzazF2ODN4enZmZUxmdWpJb09qTExncDFLYUpCU2dnU2lyREdt?=
 =?utf-8?B?eS85bHJBamdOVWRhWDlPS3ZOSGp5S3dESzJpRVAreTJJMGllaWMyTmpxa0hy?=
 =?utf-8?B?WUR0OE54WFR0WGtiRWVCZ05kRlo3VnN6MllSM1o3WkVIZWtKa2JlazVJL2dK?=
 =?utf-8?B?VWJRUGRLdG9LZGpLYmRqOWYrUW1rTDBTVkZmU0wxNW53OVRZK2o5d0RidHpJ?=
 =?utf-8?B?M2FqOVdDd1YvdkhKR2VmUnFEaFM3RG5Qak1SbDlidjQ4RjhxUkh3ZkpPSTlQ?=
 =?utf-8?B?WjNJamN4YUhVcDhXU1h3d05yeFZsOGR0R2NlRnRIbUFESStOd2pxQzltM3RW?=
 =?utf-8?B?ZkUwR1kyUUJmREswdE5zM2hXUXl5TXVNVHlVWnpoWU42dXI2QlE1Q3Q1U01F?=
 =?utf-8?B?WkVGaUR5cWdKdTk2NmN6Z0RFVkRqenRWRVFrYVU0NjlMMWtSeTlPay8vRHdk?=
 =?utf-8?B?WWxKOUJJT1Fmbm5nSG0zTGpOWlN6U0cxVnhidWNtakJpL0VlR0NnOWhXVkZK?=
 =?utf-8?B?UXJGWVhVMHlaZjRPSGtWendwY0ZuWVdpZU90Nm9OVXN2MUovTUZML0x4Y0Zo?=
 =?utf-8?B?dStzNEFlcXJLMjQ0ZTM4Njdqbzg0MDBRVE5GL0F0TFZ6WUFqSUwvL0E3VEVo?=
 =?utf-8?B?NWdyV2dqV3ZjVjhOMTVHZ1FLR0hBQ2NBUE5NUVM5Z2MvdG9KQ2R0SDNnd2xB?=
 =?utf-8?B?YkhDNFlnNWxMcTlLVzNGNjZJTUlkMy9KZEFlck9qdFBHNUNvZlZNSGhZcm9X?=
 =?utf-8?B?T2pjVmJOeTdCekpzWDM2djhKakdPTEYvMUFoQkZVbS9jSmp0R0EwRHNzajYx?=
 =?utf-8?B?RlFFekw0aU5FSm5jL25xWTRCQkVRUkhKTTVWQzIwNyttbDErUHMySm5wVmZs?=
 =?utf-8?B?TTl5VVUycTd3L0tUVDFBV1ZNS0w5K0tkdktNb01KK2puMkVSSUtGL3FVbnNm?=
 =?utf-8?B?RnNpNFpzYWpoTHJJeHpBVEhTUUE3UmNUMWhaK2JnY0VsUVZmQzVvbnJGV1pp?=
 =?utf-8?B?bS9YT1ZmM2xqdTJBeGJDaFNxcVNwb01MU05oUnFQZzI5ek9TSENsbW1IMnFJ?=
 =?utf-8?B?SEhmTTREeUp4TEdwV3RoU3phQUdxSDY4a011K2tQeWZZUlNIQncwazJ5UDBC?=
 =?utf-8?B?bHhrQ3U4elBPYzZCWlpHVnVyWm1XOTRkZkxWejRQeVloQ3RqVndTY3djS2xz?=
 =?utf-8?B?Vk9PMStrN1grcU51ZVRVNlpqdTNEcmhuR3dNMFEvWVltZTdxVEtWOFlxaWpW?=
 =?utf-8?B?bzM1ZmpyeFhTQksxNHZGODZyM0Y2TEF0MWhCakpXU1hod1JDY0FoK3ZqQTdl?=
 =?utf-8?B?TjRUdjkyVzdsc2lxak9Vb2E2a0RDZ3k4Wll3bCtjZDlFeVE1K0Y2K0s1R3Uy?=
 =?utf-8?B?a0FPRnlBSFJ4Mm44azVSQVIxbnFVQXlGZDFHSTJYaGlYUTkra3hEYWZjNUUz?=
 =?utf-8?B?K3JIODBuNHZNS21nTXBYSzVtc1hTRDlwbUVweXFSTll5VmZKRnFsSDFtMzJJ?=
 =?utf-8?B?NUdPRHdpUWloa05PeFZpZkNzSEplVTlKUVAxdkxJMWhzaHRRN29qSUFmQmU4?=
 =?utf-8?B?NERsMDlXQjFxVHJMQnU1TlBWanEzL1pTK2xTSVBvRlg4NzEvSUY5aWNaNkVZ?=
 =?utf-8?B?VkdWNUcyQlh0MVIwSGNRTlozTDNuR05qTnp2RWVUTkUvUTFkeTZQelZ4YU5l?=
 =?utf-8?Q?1jCt1DC5KitOm0rv9nwvzlLZN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YEqngSbHkn9x4PgFEy+EJWt4slL4wNRslcdzg0M6MfBQdhlekLm2hibbTiq+PaN3QtDMf72NJLxGXQspoKxhQIqVmxfsv3JTdVzY7l31LOYboPRQgLmFvaGfIhsIo1SlOT0G24hk7uBCPIDTxloT8QULc+y+RTghuvN7io3Ktd6lzmZStCk0yoU5cRt4GCa+ILL1U3azVB1n/h+GuX9ayvzyKkT5yk6S4//pAyR0oGqwPnJebQyYiDpwy1kJ7FtGA+2UOcZp7SAP+TfJ1Qh6Ue3Quh5UBNeyi3p3LxrCP2Y2VbzzlDQ9TyUHzWmAWUatOMwaOXvNJTty40un3h/+amlXXVT46d89YguA7jC1HhNG8ZzdSZJMO2HtZGvsO+lfmvnM09jGtcHrfoWWlOUhkq/05MEkvg7IRPH9cLq0FgCRzNVG6u3juNf/j2l2nkSmKaQiULGLTbuFiniMipQDKq5BbMAZCGLEaFzwQ9N0sVU02zuoU4Oxu4nTItz72uW2cn0x2qSDFb3isBjrL9UomDaa03ios/7WLnTbZlGUYdsm1mu2tQzydyotrKWNNEIbvqdceU3C0BrWH/GyaOjLC7NQwvBHWg/TH76bkJ8RBH05q/co96ra4bbUBgMLObYd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d2d8ac-3267-45c0-bd08-08dc2c6faae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 08:42:09.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2qjnly1uUthgAMj1FR+P+aoJ7eKGSoWfpcFUiB8JyvtRmKqweEfYsCifY/cLZlVUGgXUkLup8b2vXEr9KV+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6883

PiBJbiBtb2JpbGUgZGV2aWNlcywgc3VzcGVuZC9yZXN1bWUgc2l0dWF0aW9ucyBhcmUgZnJlcXVl
bnQuDQo+IEluIHRoZSBjYXNlIG9mIGEgZGVmZWN0aXZlIFNEIGNhcmQgaW4gd2hpY2ggaW5pdGlh
bGl6YXRpb24gZmFpbHMsIHVubmVjZXNzYXJ5DQo+IGluaXRpYWxpemF0aW9uIHRpbWUgaXMgY29u
c3VtZWQgZm9yIGVhY2ggcmVzdW1lLg0KPiBBIGZpZWxkIGlzIG5lZWRlZCB0byBjaGVjayB0aGF0
IFNEIGNhcmQgaW5pdGlhbGl6YXRpb24gaGFzIGZhaWxlZCBvbiB0aGUgaG9zdC4gSXQNCj4gY291
bGQgYmUgdXNlZCB0byByZW1vdmUgdW5uZWNlc3NhcnkgaW5pdGlhbGl6YXRpb24uDQpJIGRvbid0
IHNlZSB3aGVyZSB5b3UgYXJlIHVzaW5nIHRoaXMgbmV3IGluaXRfZmFpbGVkIGZpZWxkPw0KTWF5
YmUgaW5zdGVhZCwgZWxhYm9yYXRlIHRoZSBsb2dpYyB0byBmcmVlX2NhcmQ6IHRvIGRldGVjdCBh
IGJyb2tlbiBzZC4NCmUuZy4gaW5zdGVhZCBvZiBqdXN0IGlmICghb2xkY2FyZCksIGlmICghb2xk
Y2FyZCB8fCAhIG1tY19zZF9hbGl2ZShob3N0KSkgb3Igc29tZXRoaW5nLg0KDQpUaGFua3MsDQpB
dnJpDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNldW5naHVpIExlZSA8c2gwNDMubGVlQHNhbXN1
bmcuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2NvcmUvc2QuYyAgICAgICAgfCAxMiArKysr
KysrKysrKy0NCj4gIGRyaXZlcnMvbW1jL2NvcmUvc2xvdC1ncGlvLmMgfCAgMSArDQo+ICBpbmNs
dWRlL2xpbnV4L21tYy9ob3N0LmggICAgIHwgIDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvY29yZS9zZC5jIGIvZHJpdmVycy9tbWMvY29yZS9zZC5jIGluZGV4DQo+IGMzZTU1NDM0NGM5
OS4uZjBlYjM4NjRkYzI0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3NkLmMNCj4g
KysrIGIvZHJpdmVycy9tbWMvY29yZS9zZC5jDQo+IEBAIC0xNDEwLDYgKzE0MTAsNyBAQCBzdGF0
aWMgaW50IG1tY19zZF9pbml0X2NhcmQoc3RydWN0IG1tY19ob3N0ICpob3N0LA0KPiB1MzIgb2Ny
LA0KPiAgICAgICAgIGJvb2wgdjE4X2ZpeHVwX2ZhaWxlZCA9IGZhbHNlOw0KPiANCj4gICAgICAg
ICBXQVJOX09OKCFob3N0LT5jbGFpbWVkKTsNCj4gKyAgICAgICBob3N0LT5pbml0X2ZhaWxlZCA9
IGZhbHNlOw0KPiAgcmV0cnk6DQo+ICAgICAgICAgZXJyID0gbW1jX3NkX2dldF9jaWQoaG9zdCwg
b2NyLCBjaWQsICZyb2NyKTsNCj4gICAgICAgICBpZiAoZXJyKQ0KPiBAQCAtMTc1Miw2ICsxNzUz
LDggQEAgc3RhdGljIGludCBfbW1jX3NkX3Jlc3VtZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+
IA0KPiAgICAgICAgIG1tY19wb3dlcl91cChob3N0LCBob3N0LT5jYXJkLT5vY3IpOw0KPiAgICAg
ICAgIGVyciA9IG1tY19zZF9pbml0X2NhcmQoaG9zdCwgaG9zdC0+Y2FyZC0+b2NyLCBob3N0LT5j
YXJkKTsNCj4gKyAgICAgICBpZiAoZXJyKQ0KPiArICAgICAgICAgICAgICAgaG9zdC0+aW5pdF9m
YWlsZWQgPSB0cnVlOw0KPiAgICAgICAgIG1tY19jYXJkX2Nscl9zdXNwZW5kZWQoaG9zdC0+Y2Fy
ZCk7DQo+IA0KPiAgb3V0Og0KPiBAQCAtMTgwMyw4ICsxODA2LDEyIEBAIHN0YXRpYyBpbnQgbW1j
X3NkX3J1bnRpbWVfcmVzdW1lKHN0cnVjdA0KPiBtbWNfaG9zdCAqaG9zdCkNCj4gDQo+ICBzdGF0
aWMgaW50IG1tY19zZF9od19yZXNldChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpICB7DQo+ICsgICAg
ICAgaW50IGVycjsNCj4gICAgICAgICBtbWNfcG93ZXJfY3ljbGUoaG9zdCwgaG9zdC0+Y2FyZC0+
b2NyKTsNCj4gLSAgICAgICByZXR1cm4gbW1jX3NkX2luaXRfY2FyZChob3N0LCBob3N0LT5jYXJk
LT5vY3IsIGhvc3QtPmNhcmQpOw0KPiArICAgICAgIGVyciA9IG1tY19zZF9pbml0X2NhcmQoaG9z
dCwgaG9zdC0+Y2FyZC0+b2NyLCBob3N0LT5jYXJkKTsNCj4gKyAgICAgICBpZiAoZXJyKQ0KPiAr
ICAgICAgICAgICAgICAgaG9zdC0+aW5pdF9mYWlsZWQgPSB0cnVlOw0KPiArICAgICAgIHJldHVy
biBlcnI7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtbWNfYnVzX29wcyBtbWNf
c2Rfb3BzID0geyBAQCAtMTg5MSw1ICsxODk4LDggQEAgaW50DQo+IG1tY19hdHRhY2hfc2Qoc3Ry
dWN0IG1tY19ob3N0ICpob3N0KQ0KPiAgICAgICAgIHByX2VycigiJXM6IGVycm9yICVkIHdoaWxz
dCBpbml0aWFsaXNpbmcgU0QgY2FyZFxuIiwNCj4gICAgICAgICAgICAgICAgIG1tY19ob3N0bmFt
ZShob3N0KSwgZXJyKTsNCj4gDQo+ICsgICAgICAgaWYgKGVycikNCj4gKyAgICAgICAgICAgICAg
IGhvc3QtPmluaXRfZmFpbGVkID0gdHJ1ZTsNCj4gKw0KPiAgICAgICAgIHJldHVybiBlcnI7DQo+
ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3Nsb3QtZ3Bpby5jIGIvZHJpdmVy
cy9tbWMvY29yZS9zbG90LWdwaW8uYyBpbmRleA0KPiAyYTJkOTQ5YTkzNDQuLjkzZDA4MWM3ZGQ1
MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9zbG90LWdwaW8uYw0KPiArKysgYi9k
cml2ZXJzL21tYy9jb3JlL3Nsb3QtZ3Bpby5jDQo+IEBAIC0zMyw2ICszMyw3IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBtbWNfZ3Bpb19jZF9pcnF0KGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gICAg
ICAgICBzdHJ1Y3QgbW1jX2dwaW8gKmN0eCA9IGhvc3QtPnNsb3QuaGFuZGxlcl9wcml2Ow0KPiAN
Cj4gICAgICAgICBob3N0LT50cmlnZ2VyX2NhcmRfZXZlbnQgPSB0cnVlOw0KPiArICAgICAgIGhv
c3QtPmluaXRfZmFpbGVkID0gZmFsc2U7DQo+ICAgICAgICAgbW1jX2RldGVjdF9jaGFuZ2UoaG9z
dCwgbXNlY3NfdG9famlmZmllcyhjdHgtPmNkX2RlYm91bmNlX2RlbGF5X21zKSk7DQo+IA0KPiAg
ICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bW1jL2hvc3QuaCBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaCBpbmRleA0KPiAyZjQ0NWM2NTE3
NDIuLjFkNzVjZmRiZjk4MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaA0KPiBAQCAtNDY3LDYgKzQ2Nyw3IEBA
IHN0cnVjdCBtbWNfaG9zdCB7DQo+ICAgICAgICAgc3RydWN0IHRpbWVyX2xpc3QgICAgICAgcmV0
dW5lX3RpbWVyOyAgIC8qIGZvciBwZXJpb2RpYyByZS10dW5pbmcgKi8NCj4gDQo+ICAgICAgICAg
Ym9vbCAgICAgICAgICAgICAgICAgICAgdHJpZ2dlcl9jYXJkX2V2ZW50OyAvKiBjYXJkX2V2ZW50
IG5lY2Vzc2FyeSAqLw0KPiArICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIGluaXRfZmFp
bGVkOyAgICAvKiBjaGVjayBpZiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSAqLw0KPiANCj4gICAgICAg
ICBzdHJ1Y3QgbW1jX2NhcmQgICAgICAgICAqY2FyZDsgICAgICAgICAgLyogZGV2aWNlIGF0dGFj
aGVkIHRvIHRoaXMgaG9zdCAqLw0KPiANCj4gLS0NCj4gMi4yOS4wDQoNCg==


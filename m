Return-Path: <linux-kernel+bounces-11438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8F81E643
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7134282E26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D954D12B;
	Tue, 26 Dec 2023 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GWnjhH8e";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OQFH58Lo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C64CE0B;
	Tue, 26 Dec 2023 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c14237dea3cf11eeba30773df0976c77-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r4I9NiD04yBJNxsosRGMichJPNJvfdf0U172FYh2niM=;
	b=GWnjhH8e4enWLmdpyggYNpOA1iaK8MG3J22nwwamkdgyiNC/dPPn2aZuxZrs7YPYVa9qArBKkBCdt4mV+foYKTMzBzfiz7BtpNPksb/G5ZvHk2QeIUP9qBRGSBp1YxLIOxEWuOZYnFDwwQLj/3VYTaIS1KYJeAcX8rRoo9g48EM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:188339fd-89d4-4b1b-9076-b10abbd33a96,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:20492e82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c14237dea3cf11eeba30773df0976c77-20231226
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 472051755; Tue, 26 Dec 2023 17:18:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 17:18:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 17:18:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlxwiZnfXe2hUOl8UsPJnSpO3jSgBCBRUYbjAjTpAwarAYJpXeYFKRDdsr6i0oTXHv9mzPuE25OBPo4JZGsj8zmtIIsytNPetKD2mHlXs4F2mZ3g4OhgIvPesQZv4bewbYjbvYOhOLyrJlLAFtQgRr+6mCv1fComBpHL7g+7k0tQ9zJ0BFuuwz4o0u4uKldkyJgYwkgYwzosrTeuKjgsLTMcvdlQS/UZkMwHqZGjq1hS+ggHrZSNQsi7hFrRf4C4Kqj5oJkzeo5zMZ8zFbk4X/xJ0IrA5+abcjW2pDHeJTaWw5+5W6QWfE3szW5eKqMeno31vIQviGGkgiVZvddaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4I9NiD04yBJNxsosRGMichJPNJvfdf0U172FYh2niM=;
 b=PLvP8L6Qxx4XyNlCuqO9UgYYQzR99tTUI1/1dEsfv63TxIR7o6JspRdX8XC5IhF3SglYmI6Nhaon3SoI74e4nbmr8gJ8t6LkMP0Fw7G2QYM/roUry6SLTxEKF3fcs1JXPW4iNJDapl2SOeuk09moPOkTnK2II8mQiricfF5JDKRv4vzkXxcnTFDoyTj0KLu6a0IJFCFezJ7UiJlfp9AqIcDGKa3NPdKwM60dg5949jS30w7aiI+3io3k9plv7Uhj+RkSIfHSKHhMTNHAZ+jpMTNG8qeal1yvNpDvGm2GfiU6MwiWduRgjtUv8rN2G+cH3muPahWgNLm7zbZsKQnBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4I9NiD04yBJNxsosRGMichJPNJvfdf0U172FYh2niM=;
 b=OQFH58Lok4HF4/deythoIkm9Fb0QYBVCHo/2zQWTvGdwwTJyt4KWtQlCkvdw+C+9JwfDdSjU1vx2bmqAB5xRTkLyhMjgt0Or+f+lnnRp4XxdJyFZhQhl1pOS0ZcPACECOiki4LBtSO32h3IWZX63rY9BJXTNcSlCEf2lu9IdUPQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI6PR03MB9011.apcprd03.prod.outlook.com (2603:1096:4:235::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 09:18:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 09:18:34 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7T9kA
Date: Tue, 26 Dec 2023 09:18:34 +0000
Message-ID: <c179d1ab68298efd314ffbe39fc67c5bb2dc5764.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231222045228.27826-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI6PR03MB9011:EE_
x-ms-office365-filtering-correlation-id: 0d2aa78b-e2af-4577-62d1-08dc05f3a2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UC28C1rY6STEF4OUdU7LEufyJdjGF7z6bEsC67unjiNGc+SqzR/7fYojefc6RxftwUOZ94b6C5A4dOgU6ITMalOSsJ84G57ZfehRxd86RnDnsdZK3KgbYfMMZYmjG/KKSMe0YS6vLHXfYqnLGgqENG4oIxIU8wJ9nidvKv8QTjzCmB5EKwe3MNfpm3ousq5I49Y9oULr1N2k7iGztVh6x4O7sauvJ0xkPtudDM9G/T7FL+e5q3SfCWo8AFQxYP9nHKHE930qtcuByrAhaTm1SgLBUTMoTQwVfcvrK22avFdfEOPBOo30yiELFAUG73UjysfpH+A8qKq/B+CQu9FHdIp4qS/0fnEC3p7p51qrKo2mBPjNoD2xE+LBhNjYBinzRnDpQEy8NglP7H3cB16QEtBZTCOpHVco56TBtTniehqZV8ctIx7tU+qi92eWx7lL5hO0to0zxJLUJycvYLl5rJPUXLeUSB3E4v1uDZY6d3dy4aNu1tI10GwWnARI1t8U2isCtZe3QK2GsqF/fcW1FN82+mddBS7Cph9KhhNpipArSEW+XCFFr89PwN6QkGzHUy2PyllYKcF21wO5nv5P3pw8oIS3ykL3oXFpEOpZFaGg4sySSwz/Bp82mOOQlw4TWE9auKErkGhcvF2PbK3jFoud6QzgZ454ichONLYLBaE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(83380400001)(41300700001)(66476007)(8676002)(478600001)(6486002)(8936002)(5660300002)(4326008)(54906003)(110136005)(66946007)(86362001)(66556008)(64756008)(66446008)(76116006)(15650500001)(26005)(6512007)(36756003)(85182001)(2616005)(2906002)(7416002)(6506007)(4001150100001)(316002)(71200400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHpRY1lXaHQzc0Q2NkNDNnhKWHpHemJNRlBXcGE1WjNKU1dXMGloZFV1dXIy?=
 =?utf-8?B?M25jYkF5ZnNTaVYwem0vVHd2ekt0WXZHZUY0Y1J3b3FkL0NWRDYwQWpqdzhM?=
 =?utf-8?B?d01TTVFETWxLOVg5MDAyWGpIVytwZGlOakl1cjA0M3J6c2tHZzBCYjgvM08w?=
 =?utf-8?B?SVlSUUFWTDNsRUQzcUhsVElhUWZJNXNNVisvb3RHMndTZVAwSWxFSy9iNnc4?=
 =?utf-8?B?NithaWFvYVBhNjdDMUpmMXZZbzduS3dWSnIvR0dXSlRub3d1L2VOb1ZqVU5O?=
 =?utf-8?B?RllOTTFCVFpweStic2JBYkNzTHNsZDFYems1RVFoNWxTcGJTMVJiVW80VFgz?=
 =?utf-8?B?bWx0eC81VmZvcTFJRWw0VGlLRUhZY29qYW8wMXFqRU1DTkpOTmJaYlZBZ25Q?=
 =?utf-8?B?amg1Rkx0OGtPWkRpQnNNTWdaSTFrYkVnNXJKWnpRdHdtS1NnU2NrODY0YXRy?=
 =?utf-8?B?YXNYSXlUZENraWpYRGhRZ3pSSDVxSmM2Q2dnb29vYndWQjExSHRnVVJFemNF?=
 =?utf-8?B?ek5ENTQzZlhYNkRmZVFMZ2hmUmo4MEs3ZHFtTHJuWUpNNU5DdEJpdFA2bnZE?=
 =?utf-8?B?N3krWVJCQngyZkY4dER0c29IOXhBT0xBSm4xT0tpUkZQb3hWcGtFT2NuU2Jn?=
 =?utf-8?B?V1hJY1Q4eGpObGcyakJnUHorb3hWS0ZReFJTdFNxVGVWNnkxSCt5OUZ0RDN2?=
 =?utf-8?B?b2o0REwyeFVQdGwzcnFPMWdROUcwU01ybGhvM0NOREcvLzdmdUR6U3ZyeXhM?=
 =?utf-8?B?bE5WNEJ5SytacTVrRVhIbGR5ek5rSmRoQW5zNHkxdnNlUGdOS0gyWEdNRFBT?=
 =?utf-8?B?aVlFRmtQekt4eGZGclQvTmRNaTJCcGViTE9YaEVCbEl1RVJjYlNLQ1B1UWZF?=
 =?utf-8?B?eG1RUXVKR01DZ0hxTTRZQWhaSm1WOHFQeWk5Q3VzeXU0alY1VzRseXBrWGJa?=
 =?utf-8?B?ZEd0Zk1CQUJhMXpKVDVnMmhnbm1Hang5RisrZjh3eHVMZk9YL1JGTTAzaUVP?=
 =?utf-8?B?ZzZmWU5SMHBRTVoxNldWeVh1Uk5vRVZ6dlltb2VCbnFvb3RNTElvN1JkYytw?=
 =?utf-8?B?WXFtaDRZVTN0TENiblliTHprS25JY3AxT04zMzhUcWhXTjhuekdWTDB0TnBj?=
 =?utf-8?B?YXVwc0tyN1VQV25BbkJTdDlVd2FiRUdpbGZYdHc3c0dFQ21zS0dRRVRCZjRY?=
 =?utf-8?B?RE11d0JMNGNId3pTL2wvSlNhU05Eam5ZNWJyVldpMWxWUXZYY3BhRVFBNFJu?=
 =?utf-8?B?OHBQNHpEb2wycmlzLytOS3I2dUkxMjV1cDZpbzA2U0tXTUEybEhnTWliMFAy?=
 =?utf-8?B?Ync1Z3p2ZVNSNWdobnB5MGIrbHZyWnMvVEZDTGt4VlZyZEdCQXB0TU1vdFY5?=
 =?utf-8?B?WG9pTHdnZGlwbXRoU25na1YxRzR1dWdoejNRT1RhK3dhTmE1TzlHYnczNXJm?=
 =?utf-8?B?M0ttQmFCTjNSOUxEU3pYS04yMjNJeGJKZUpIZ0s4ZTBkSHlUWnh0RWpZYjhS?=
 =?utf-8?B?bytNR3BISHM3eXN2cmRBdW5jMEQrNVNaVlAwdDZrUGRRcC9MVEJ6TGg2L3Jw?=
 =?utf-8?B?V3ErajJNMm50YVlLbTZuZGJVVE81S2xaN28zdkYxSkpRbGllNlRucTh2ZjBk?=
 =?utf-8?B?RnA0cDdjYjZIa0xWa2J1bHFGdmYvdlp6dE1oTk00NnlrWkM1Nzlmb3QvaFBU?=
 =?utf-8?B?TlBBYXY1TDVYTDE4UG0xdHNOd1BxYjlUWi9mWENBV1FiUE1IcHpydjlweDRa?=
 =?utf-8?B?V2dBcWRSU1ZLcFYvQVZOMWF4ODBwaldYdVRWMkdwVGNaSzUxUmM3dmFTeVRt?=
 =?utf-8?B?MWJVbityeEZyOGI0UUZuU2pVdkZ6Qjg2TjQyWlEyS2VwYXZsYURiK1BHUUM2?=
 =?utf-8?B?U1pIUFVhTzBPVVZLbGtyb3ltUHBWbWVoUkZEekRTT0ZoL2lBZ0UvOGtqN2pY?=
 =?utf-8?B?dERncnNWSE5kZkFsb1cwVVg1aTg0TDV4emQxQkRHbDVrTVRNT2NVbXpjMmg0?=
 =?utf-8?B?NVhRaUQ2Nk1vT3Jsc0oxZExkOHNtS2x0LzZMc0xva2hrWStuRUx6S1cxT1dE?=
 =?utf-8?B?andmZGpJaXdvWTFJcllmTFZhTWI4QmMyK2JPaWFTRU5jRTc3eDdZS2tMbHM5?=
 =?utf-8?Q?Y4iBCB0VMIETEFI1K9bQ9nxNP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF93DCCA12525D4D91DC2C272B9147F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2aa78b-e2af-4577-62d1-08dc05f3a2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 09:18:34.8423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nMD394abNOwWKfb6h683xkeyI8m7NQP9rFfF/zqhbnCWV5j/vJWv++JDt7awhTTe685mlfBaWahIYIRXmCbpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB9011
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.074600-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaYOwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUTjXf
	1FOduVPBffzU9brcHlGtIiYQW28JqFpOPyWRFZsAXKqR+w9a7UGjdirk8LAsCW7yqKgCWhbi8Kb
	Vax4fgHa8x8ZgUfY74LDw+qthV+qgtsPcvrlEqVp4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnE
	QCUU+jzjoczmuoPCq2yqHjSTRsFb3ltQObc4o44WD9c0QMsUY+1fQbyQYU64noqCzqThiN7
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.074600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	66526BA5E77FB92EB99317DF8D28F93DB231F58096ECB89836282873FEB66FAC2000:8

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjMtMTItMjIgYXQgMTI6NTIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0Ug
aGF2ZSB0byByZWFkL3dyaXRlDQo+IHJlZ2lzdGdlcnMNCj4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzIHBlcm1pc3Npb24gdG8NCj4gdGhlDQo+
IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gDQo+
IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIg
aXMgYWJsZSB0bw0KPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiBleGVjdXRlDQo+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29u
ZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0K
PiArDQo+ICsvKioNCj4gKyAqIHN0cnVjdCBpd2NfY21kcV9jb21tYW5kX3QgLSBzdHJ1Y3R1cmUg
Zm9yIGV4Y3V0aW5nIGNtZHEgdGFzayBpbg0KPiBzZWN1cmUgd29ybGQuDQo+ICsgKiBAdGhyZWFk
OiBHQ0Ugc2VjdXJlIHRocmVhZCBpbmRleCB0byBleGVjdXRlIGNvbW1hbmQuDQo+ICsgKiBAc2Nl
bmFyaW86IHNjZW5hcmlvIHRvIGV4ZWN1dGUgY29tbWFuZC4NCj4gKyAqIEBwcmlvcml0eTogcHJp
b3JpdHkgb2YgR0NFIHNlY3VyZSB0aHJlYWQuDQo+ICsgKiBAY21kX3NpemU6IGNvbW1hbmQgc2l6
ZSB1c2VkIGluIGNvbW1hbmQgYnVmZmVyLg0KPiArICogQGVuZ19mbGFnOiBIVyBlbmdpbmUgZmxh
ZyBuZWVkIHRvIGVuYWJsZSBwcm90ZWN0aW9uDQo+IGNvbmZpZ3VyYXRpb24uDQo+ICsgKiBAdmFf
YmFzZTogY29tbWFuZCBidWZmZXINCj4gKyAqIEB3YWl0X2Nvb2tpZTogaW5kZXggaW4gdGhyZWFk
J3MgdGFzayBsaXN0LCBpdCBzaG91bGQgYmUNCj4gKG5leHRDb29raWUgLSAxKS4NCj4gKyAqIEBy
ZXNldF9leGVjOiByZXNldCBIVyB0aHJlYWQuDQo+ICsgKiBAY2FsbGVyX3BpZDogcGlkIG9mIGNs
aWVudCBtb2R1bGUuDQo+ICsgKiBAY2FsbGVyX25hbWU6IG5hbWUgb2YgY2xpZW50IG1vZHVsZS4N
Cj4gKyAqIEBtZXRhZGF0YTogbWV0YWRhdGEgc3RydWN0dXJlIGZvciBjb252ZXJ0aW5nIGEgbGlz
dCBvZiBzZWN1cmUNCj4gYnVmZmVyIGFkZHJlc3MuDQo+ICsgKiBAZXh0ZW5zaW9uOiBleHRlbnNp
b24gSFcgZW5naW5lIGZsYWcgdG8gYmUgcHJvdGN0ZWQgaW4gc2VjdXJlDQo+IHdvcmxkLg0KPiAr
ICogQHJlYWRiYWNrX3BhOiByZWFkYmFjayBidWZmZXIgcGEuDQo+ICsgKiBAbm9ybWFsX3Rhc2tf
aGFuZGxlOiBoYW5kbGUgdG8gcmVmZXJlbmNlIHRhc2sgaW4gbm9ybWFsIHdvcmxkLg0KPiArICog
QG1kcF9leHRlbnNpb246IGV4dGVuc2lvbiBNRFAgSFcgZW5naW5lIGZsYWcgdG8gYmUgcHJvdGN0
ZWQgaW4NCj4gc2VjdXJlIHdvcmxkLg0KPiArICogQHJlYWRiYWNrX2VuZ3M6IGFycmF5IG9mIHJl
YWRiYWNrIGVuZ2luZXMgcGFyYW1ldGVycy4NCj4gKyAqIEByZWFkYmFja19jbnQ6IGNvdW50IG9m
IHJlYWRiYWNrX2VuZ3MgYXJyYXkuDQo+ICsgKi8NCj4gK3N0cnVjdCBpd2NfY21kcV9jb21tYW5k
X3Qgew0KPiArCS8qIGJhc2ljIGV4ZWN1dGlvbiBkYXRhICovDQo+ICsJdTMyIHRocmVhZDsNCj4g
Kwl1MzIgc2NlbmFyaW87DQo+ICsJdTMyIHByaW9yaXR5Ow0KPiArCXUzMiBjbWRfc2l6ZTsNCj4g
Kwl1NjQgZW5nX2ZsYWc7DQo+ICsJdTMyIHZhX2Jhc2VbQ01EUV9JV0NfTUFYX0NNRF9MRU5HVEhd
Ow0KPiArDQo+ICsJLyogZXhlYyBvcmRlciBkYXRhICovDQo+ICsJdTMyIHdhaXRfY29va2llOw0K
PiArCWJvb2wgcmVzZXRfZXhlYzsNCj4gKw0KPiArCS8qIGNsaWVudCBpbmZvICovDQo+ICsJczMy
IGNhbGxlcl9waWQ7DQoNClVzZWxlc3MsIGRyb3AgaXQuDQoNCj4gKwljaGFyIGNhbGxlcl9uYW1l
W0NNRFFfSVdDX0NMSUVOVF9OQU1FXTsNCg0KRGl0dG8uDQoNCj4gKw0KPiArCS8qIG1ldGFkYXRh
ICovDQo+ICsJc3RydWN0IGl3Y19jbWRxX21ldGFkYXRhX3QgbWV0YWRhdGE7DQo+ICsNCj4gKwkv
KiBjbGllbnQgZXh0ZW5zaW9uIGJpdHMgKi8NCj4gKwl1NjQgZXh0ZW5zaW9uOw0KDQpEaXR0by4N
Cg0KPiArCXU2NCByZWFkYmFja19wYTsNCg0KRGl0dG8uDQoNCj4gKw0KPiArCS8qIGRlYnVnICov
DQo+ICsJdTY0IG5vcm1hbF90YXNrX2hhbmRsZTsNCj4gKw0KPiArCS8qIFNWUCBIRFIgKi8NCj4g
Kwl1MzIgbWRwX2V4dGVuc2lvbjsNCg0KRGl0dG8uDQoNCj4gKwlzdHJ1Y3QgcmVhZGJhY2tfZW5n
aW5lIHJlYWRiYWNrX2VuZ3NbQ01EUV9NQVhfUkVBREJBQ0tfRU5HXTsNCg0KRGl0dG8uDQoNCj4g
Kwl1MzIgcmVhZGJhY2tfY250Ow0KDQpEaXR0by4NCg0KUmVnYXJkcywNCkNLDQoNCj4gK307DQo+
ICsNCg==


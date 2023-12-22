Return-Path: <linux-kernel+bounces-9410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74EB81C520
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E6AB20E83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31188F74;
	Fri, 22 Dec 2023 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NjmYjRZx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X28/ZQGh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DD8F40;
	Fri, 22 Dec 2023 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bccea050a09311eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lGcx0nF5EcTssi6dd0NFl8IpvXOB60J5CeSyQwwAlEs=;
	b=NjmYjRZxV2GYn+nGknxsz0fMSm772UgM20J9TZs4zcguFyyIy4ykkO5PrUm0FR6gJgl/R5oIsMeNGlWs7zGOBmtbM53A1MFx93N+ZZPpggXDWLzCSpmhJpOgX9UkPipcbSZ2VETouIxWE+DVlRtd0nelUg30m/7BgVVE7QXcRsA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7c58a5a4-cac7-4aa1-a588-9cd5ae11e780,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ebc80d82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: bccea050a09311eeba30773df0976c77-20231222
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 32842447; Fri, 22 Dec 2023 14:31:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 14:31:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 14:31:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhFbwUk074u3WukIusMZlRVH/zEdCpyrh3xYruc3m/isn2YZI0g5Yt1olfqjOaWqd/9l4sAJQlpoaYO7EaRLGhl+uYPJyMqlLqr5C/FOIhgkMWjOdTQ/aaiC5bXvKOR5c3xOEow67PNxGZ1Ro4ZvFbSSGu02yDh0nO+nRaHyWb6qa25Rsd3h7J+5bgtGLNi2baYR+4apH0anGMmg4bT4vZ7Xz23cxlXdcyLtXZ3Y99zC3RNNSwFlJtxJt6r2++tipiFEe/kEjD5vVNjIu7/HOF8y6LNK+mJ9GZA5/Da82QMfNM1Sya7t6qXNWgn/u9e0J5Ql9yZmoTZ5rGphiD3xug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGcx0nF5EcTssi6dd0NFl8IpvXOB60J5CeSyQwwAlEs=;
 b=S3rShQuGUy4DpXABUDABq+6tlTH1/AJzXZ+Q8uQid1uYmu40BPNPAj3rimhctzw2ERqRYHccT7V5ntR9JkaV2wHGLEYScvck+ZHIc6VacAIeQG4iS6MS9lpocKu/pNF/LNFO/7V4Mc4QkHKVhZmb2r6SxKq0GxPs0dBWRpYI+Zs3bZflmP1Jo4qwZcqptKuxjah0JG1NhVANjncl7GYJZNNbO9x1kODj7o5UNHcfUb2TLQLes1V9vuiWiKzVdxy9+OFOoFeGM5GC0pGD9C/7PiDT+T8T6kjBngcQEa/n17XC/bDgZvQ+7e6emu5MxPHOqvGgjiBOdE3w7Ix5ELS10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGcx0nF5EcTssi6dd0NFl8IpvXOB60J5CeSyQwwAlEs=;
 b=X28/ZQGhv6N7uDiJYfnoFwEWu1PGes25NGVbwihsJHyBTnBkRrz/bR+1xlOpZvtoCAPWiRmmVum4Yq8VxYjsGSbNR6poeyPU6KdxkjiHmcAp0/5X2tstvW66Xznc+W5tTSOqU0aNoOQgQfGlHVipYqofmVw8vzy2EQm+lgJPvi0=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by KL1PR03MB5555.apcprd03.prod.outlook.com (2603:1096:820:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 06:31:19 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 06:31:19 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "ebiggers@google.com" <ebiggers@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>, "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>, "beanhuo@micron.com" <beanhuo@micron.com>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "cw9316.lee@samsung.com" <cw9316.lee@samsung.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "chu.stanley@gmail.com"
	<chu.stanley@gmail.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?=
	<Powen.Kao@mediatek.com>, "Arthur.Simchaev@wdc.com"
	<Arthur.Simchaev@wdc.com>, "mani@kernel.org" <mani@kernel.org>,
	=?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= <stanley.chu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "quic_cang@quicinc.com"
	<quic_cang@quicinc.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "yang.lee@linux.alibaba.com"
	<yang.lee@linux.alibaba.com>
CC: "jt77.jang@samsung.com" <jt77.jang@samsung.com>, "sh043.lee@samsung.com"
	<sh043.lee@samsung.com>, "grant.jung@samsung.com" <grant.jung@samsung.com>,
	"dh0421.hwang@samsung.com" <dh0421.hwang@samsung.com>
Subject: Re: [PATCH v2] ufs: mcq: Adding a function for MCQ enable
Thread-Topic: [PATCH v2] ufs: mcq: Adding a function for MCQ enable
Thread-Index: AQHaM9rgXTCAEDHueUKBeyipsfxR2rC02TmA
Date: Fri, 22 Dec 2023 06:31:18 +0000
Message-ID: <534326e6da3b692648eb0be2be6f88e7957d3d89.camel@mediatek.com>
References: <CGME20231221065637epcas1p203dcd5cfb1d4a3964fff9543a041d78d@epcas1p2.samsung.com>
	 <20231221065608.9899-1-cw9316.lee@samsung.com>
In-Reply-To: <20231221065608.9899-1-cw9316.lee@samsung.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|KL1PR03MB5555:EE_
x-ms-office365-filtering-correlation-id: e22e561c-dcc1-4286-1523-08dc02b79bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+bHhY4rj6b2FFjWIRq1O2h/ss2nV6NoDBAvsCGCy2WVD0RvKIQTCLGYbfm7K127wKnuLp590UcU+73waY7N9v6si1H17k/RE3pZ2+cQQ8JOKSeQBpHz6Ob7fmKEp3n5K9nFskJnaYlVG/F3qzBDS1jvDL4YpkdfIcnvgD7EjbLouoI210YQnxDa1b4nc/LF92gjL0w3VNSg10DLOIGs3DuCfbQWXgUo2TlMZ2ngsi9+TeHOrhJi5zE9p0KqjPda+JXXAFMXJ3dMCiAfAQp22+TCqVpDXAhAPchbgje0yU4wSJzkV7zcvyFh1AK/umdZ2MHaCnWo+2LZ2GtWQBXGAtzhNFiKlcgJCpuf4BdrZKvU+s9CbXLbutCjxDqyB95F16uqrzYZlUUkrdYOH863nRNdIG7BLRICb7fhGYaCyTwdPlj6vkHVJCFQnUVJtfhiiZ57BGppHjUZdnF5rVzuxtUcCie4/PG+RjoMtsSaTZYYslbmPAnwzmLbmsVhgZ5BXFyl+dPHlq6UCWm+T8ppolrfOYjFSeTlWcYfv9adQNHsQUnpIo09JiSaKwf/cidB/q1H3Hhc29V8cS6/nXd5/dYZwohq5qDYXgKPYY6pJfAiHhBJJ1T/cjt7w3sZ5e4s5cnMMq3FtiDLx/pjvVBJOq7mC+V+TWXkpn7ZaIUUku6wqh2vmjf38x0jPJIRxNwd5fRATGJZmGpTQ3F3axLpFhLehiXzT32ldt4EtDzefS3rYpIiW/FBU2tJlIkM4A1m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(122000001)(921008)(41300700001)(86362001)(36756003)(71200400001)(38100700002)(26005)(83380400001)(85182001)(2616005)(38070700009)(478600001)(66556008)(76116006)(66946007)(66476007)(6486002)(8936002)(8676002)(4326008)(6512007)(6506007)(5660300002)(7416002)(4744005)(2906002)(4001150100001)(66446008)(91956017)(64756008)(54906003)(110136005)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UElyd1B5SGtzTFYyUEF4UjM2TFVORjR4cVZVdVV1WVBBU0swUlVFa3ZwUmd2?=
 =?utf-8?B?QUx4d1VwQ0tiN0U2OFNXYWtxZG1LV2g2VGNtQWpjR1BsUzlST0NBcVU2aEhl?=
 =?utf-8?B?b1FvazF2Ky9XRFdTV0g2L0RHM1pielJNRm5wcDBwSjBJOUhYL2JIOHFNaHcy?=
 =?utf-8?B?M1ZQYzlMaGhXSC9SY3V1V2k0enFLQ2ZjT3VzbUdVU1E1eUtSdysxRXJGQWg3?=
 =?utf-8?B?Zmo2UFJ0bzVLeE45Sy9OWGpnRWZHY2g4UkRIcnd6cmlCQjRlTlVybGtFUnow?=
 =?utf-8?B?QzFEaFlJZ0k3NzV4eG92MDk1d0d0R0M4TkU2ZHZBRktKWjhEeitRVTI3dDdp?=
 =?utf-8?B?NFl6Y1RBaC9pM3hVckh0cUF4NWowU0g0V21RSzk1dTNJVTIvVmZmWmFxL2ZS?=
 =?utf-8?B?SFJieWwxZm11Z0RBRGRPN2dWVEJTcXFBQzZxQ1JGQ3JFenRNVmI1VE82cGVT?=
 =?utf-8?B?ZEhnQnVrd3JLSEltTGgzZXU4YU1IM3Y5QlZndkJGbXdWSmQvTkFoOHQ5WHFN?=
 =?utf-8?B?YlNsNDBkLzE5TEo4bGxLWGd6ellEd0U3OFNUM3c0NWdrNnRBNXRqNC9aVGgr?=
 =?utf-8?B?VEsvMDQvT1VuVnpOdWJteFVpcTJkUDh0R0V1SDJDQXZSWlYxSk5xZnFQeU9h?=
 =?utf-8?B?a0puUHNXZldvTWNaNTc3alA4eFBvcG92VkdncVN4VnhKTHVZUmorRGRtYWVv?=
 =?utf-8?B?UStLdnYrVndZamxZaktyamFIdTIzTGxReVowUTRrWmNTVTVyaGNDR2dRTzRC?=
 =?utf-8?B?L3UxTHhsb2ZNZTVzeFJZcEt2YXQ5NXo4Sjh6bis5QjNzU0tKOXhOQkVuUnVx?=
 =?utf-8?B?Y2wveFhpRDFDZE1xZWs4dGhBV0ltcEY3RDhVUXU5VUhLL3ZkUXVQa05GRTA5?=
 =?utf-8?B?OGduRkg4VHc1TkdSekFwcitYay9BL1NkS0ZMUnN0Z3ZvdFJtQ3ZLMnNJOVgy?=
 =?utf-8?B?VHRLU3BoU290Vk80RC82UTRPclIzTm9RWVByY0k0dGdYZGJTYWdsVjVhR0ta?=
 =?utf-8?B?QzYwOUhnZ3lON3ovaDlWbFdkVGZPYjNRWHFwK2pUbFMrVXdKM211b2ZFdHIz?=
 =?utf-8?B?SkQ4THNPMkM0cytMMnI0R3JKVXhyWmVyelNRV3B4TUlPRlB1MEVKTklhaTFa?=
 =?utf-8?B?alI4dzh2aXJ5ZnJiUU4rdlZNMlRlZDg3WW4zbm1YYXlVNEdBMnRpRlFKYlc1?=
 =?utf-8?B?SVVJS2NXc1k2ejUxdDk2ZVR6UzUzZHU3NzltWmtsV1ZBNXNMWkU1WU9pYU9j?=
 =?utf-8?B?UEdNOHRLTXhCQTlOeDFITHlPMFlINGp0aVQzaFF4KzVWVXR5ZnY5V1NiRWdv?=
 =?utf-8?B?S3kyREJ1OHQ5ODFkdHI4alJBRTdNZXQzSGhRd05SOHNZdStuM0xjNGVxT25t?=
 =?utf-8?B?cm5RWG95Zm1nYVh1MDBJL1FmMHN5dEdlUWRYWkNZVUk5NnU1b0IybW5aeTRN?=
 =?utf-8?B?bS9zWXdtbkpVOStsZmYva05GeThrMk1BdEtYaDdjajJ1aHdUKzlYcTUvT0VZ?=
 =?utf-8?B?UFhSZDlZTDMyOFVXOSt5dkYrWWh3eE1WbHovdlowNGpvM2MzS3hvSWlTWTNJ?=
 =?utf-8?B?YzViTXNDSCtlcE90QlFLR09BYkhWWGc1STlwdWhJbjYwSk1RcVZ5Q2w3Yncv?=
 =?utf-8?B?cXBNTCtNdDA2Q2lENUdYRjczTXQxdUZBNWZDM1Jmd2FvSGM0bldLY01FeFph?=
 =?utf-8?B?RkkzVnZ5OFppYTQ3blR5RWpvaXVtWlRxbVB5N2RSQmxIc2w1azZINzdQYU5t?=
 =?utf-8?B?Rmp2bjlYNjB4YmpVOGZ5N3RuZEJmemhoZG5rNUJoMFJ1VVRIMEQ3bDZvaS93?=
 =?utf-8?B?VHFTNFM2YVF4Q1BlckY4aThIeHFOVE1oSmtpYzJkOEsrYnJQOGpSMU5xK0tw?=
 =?utf-8?B?ZDVXdUxqQWlqTHhLYzRtZFgyV0g3YTcvYk5uSExuUnVncTdDZXdTakgwemRG?=
 =?utf-8?B?UFM3WDB5d2s4ZEtZMHRhM3lVeW1qeU1FMDFCWGFjZncyZng3MkNOTllqc0ha?=
 =?utf-8?B?RjJ3UWVHZ2xWeXJmL3ZMalRaNWN5ZTM1MS9tOEdJNGVuNnZUUkhlUzFhREhj?=
 =?utf-8?B?bUxBZVlDSHhUSE9PRStEbi9aYjdrNVlkMEZxMzZhTGxLNmRSTHZTd1lJdGlP?=
 =?utf-8?B?Nkt0b3hvR0FaYmNVZEsrRWZWWHZaY3dLMDAyVDBYditoL0VwTTMwZ3E3a3Js?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <005813D464D64247AB80391D9DF19C07@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22e561c-dcc1-4286-1523-08dc02b79bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 06:31:19.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RHD4E7hU9uZPNFbc1/w1DpU96tP0VULYwBBoBV5ukP5/QlIOjyVv92/IIg7WG14Q+FU10YB0EROlk12aPDnsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5555
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.274500-8.000000
X-TMASE-MatchedRID: dwNgap4H9hjUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCuXZr+YoPx3I5O5PclyYqqr54F/2i/DwjVVgGGTe6VdAwWQ
	yn4dEXhy1nD2VM2DtOkD8qutfZX9Jz5ey3IkHnU5jVtAwIy+afs6j/8n8QDVBOmC93eKossajxY
	yRBa/qJRVHsNBZf9aRIC0OoeD/hCbu2nB9KtyYQNmzcdRxL+xwKrauXd3MZDWwcNd8n+0bARLar
	W80S9bQKCYYPO9aCswUzd3oaK4cpNbwCpghpL4y
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.274500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EB6E104F14E0E1740C8DF296D0894C48981936731F12C91150B556B17FABE5912000:8
X-MTK: N

T24gVGh1LCAyMDIzLTEyLTIxIGF0IDE1OjU2ICswOTAwLCBDaGFud29vIExlZSB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBGcm9tOiBDaGFuV29vIExlZSA8Y3c5MzE2LmxlZUBzYW1zdW5nLmNvbT4N
Cj4gDQo+IFRoZSBSRUdfVUZTX01FTV9DRkcgcmVnaXN0ZXIgaXMgdG9vIGdlbmVyYWwoYnJvYWQp
DQo+IGFuZCBpdCBpcyBkaWZmaWN1bHQgdG8ga25vdyB0aGUgbWVhbmluZyBvbmx5IHdpdGggYSB2
YWx1ZSBvZiAweDEuDQo+IFNvIGZhciwgY29tbWVudHMgd2VyZSByZXF1aXJlZC4NCj4gDQo+IFRo
ZXJlZm9yZSwgSSBoYXZlIGFkZGVkIG5ldyBmdW5jdGlvbnMgYW5kIGRlZmluZXMNCj4gdG8gaW1w
cm92ZSBjb2RlIHJlYWRhYmlsaXR5L3JldXNhYmlsaXR5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Q2hhbldvbyBMZWUgPGN3OTMxNi5sZWVAc2Ftc3VuZy5jb20+DQo+IA0KPiAqIHYxLT52MjoNCj4g
ICAgMSkgRXhjbHVkaW5nIEVTSV9FTkFCTEUNCj4gICAgMikgUmVwbGFjZSB3aXRoIHVmc2hjZF9y
bXdsLCBCSVQoKQ0KPiAgICAzKSBTZXBhcmF0aW5nIGhiYS0+bWNxX2VuYWJsZWQNCj4gLS0tDQo+
IA0KDQpSZXZpZXdlZC1ieTogUGV0ZXIgV2FuZyA8cGV0ZXIud2FuZ0BtZWRpYXRlay5jb20+DQo=


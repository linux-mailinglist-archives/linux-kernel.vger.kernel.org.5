Return-Path: <linux-kernel+bounces-17500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E061D824E71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CAB1C21BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7A6ABB;
	Fri,  5 Jan 2024 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KwRWg9Wp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LRtZ5/hj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAEC6121
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d1cf7c4ab9111eea2298b7352fd921d-20240105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5PuAyi/PtCzlSqrDQX2XkxR53mSkYjD+miCs2RFos+A=;
	b=KwRWg9WpXzFNX04Bpz9fnGEUohRCwHviZpKcHKGgQfaBXW0sltOmyjP7IrJQNXAl7BpGyxq1v3i6lZTheKPnhQL+cpV8lpI6KO2smycg7yuFGDLM2l5ZKL50WFsNg6RhSDlYOUFkoIkkD/Fa4FPBgkMMiet7Ak3HDk14O+3puhA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:0364d733-5b98-43c5-aff0-52221a02f16b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:d848eb8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1d1cf7c4ab9111eea2298b7352fd921d-20240105
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1274895769; Fri, 05 Jan 2024 14:10:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jan 2024 14:10:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jan 2024 14:10:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6vGvchDdpTeAR8e/6fwDMSRr8RmPpRRn9U+KFeuiD5+ikEqrnaJXAD7CnJVIITKYVKVBY8AzXrET9Zu0cdKb0TWInMi7FobdEq4Ria5JQlS4AWJBVBO5SHtNBo27iXk7Il7FgITL7g6de5DOk7F8UENNq4iVhB+P7t3tTquQdB4J7/R9XwVIagzWgcB/1bQMl4JYn87v0Cf4azyiMBONsrO/AGEstym7sanl31/gVX3ggSmXZGcL1I8pUkiSux1iFvlJZd/0qXLR5Cd1dDGyB5HyKGr90x+2r+qygRNH7KVe1pGW17zRv/sWeIaOECcC3zu/jW9mx7OvHY88NWZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PuAyi/PtCzlSqrDQX2XkxR53mSkYjD+miCs2RFos+A=;
 b=XtSZcp5dLN+uSRqQiqirj8x1tspYsx8lG8zJiygDdcJNck5eli9P1Bmp8LQBcSxh6difnkjdX/1BKkYfemuA0z6z7SteL9TCGzvHTeOdykVJGTyhIxq8ZgK5CYP4vy/X4HtkfY0Qj6vofbpW15iZ2CAM8Y8gz6XcT7i7qDJcP43YC8Dru+17GtctCLoI1Fcxj1Plkpyg9nEh2cpX3i2+oOugQJ8VCkl/mo4d/secDB4rHTKqAfn6Y4XEjU7g0FhnSSUgpEwKk6gRPmugIcaDQbBy6aWjEl5eUBkbJeu4iaGTCNEdvaBbgL6PN1EDQ4BRSNugtOjofAqQtqjpxZfeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PuAyi/PtCzlSqrDQX2XkxR53mSkYjD+miCs2RFos+A=;
 b=LRtZ5/hjDCdZrj6tUkcL+TWF+NOQ65RdHjkOPWIn+QbCk5ymMVU7v1f7P4ZaqxlnTOdcSsDwG7i/XPQmS2pD9a334AOAUSlQRgNckOiTkXNPcgvXv2TGiBvPP32lHlUvz8yn0Z4x7+V/xTdXVRM+qVw9+HxJqiG1N22fEFC0FiA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7242.apcprd03.prod.outlook.com (2603:1096:400:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 06:10:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 06:10:20 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Topic: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Index: AQHaHrPjdunoffcOCEGmErF8vNrJIrDK/lAA
Date: Fri, 5 Jan 2024 06:10:20 +0000
Message-ID: <8b38cd45634bb37e8e652060d920b3ad74680918.camel@mediatek.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7242:EE_
x-ms-office365-filtering-correlation-id: f97d94ce-0430-4822-007c-08dc0db4ff42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p85CiNQRkOTHy8Hvm+yeIuLZGqR7gpJETSROBBdSp0gQNCcVxkSA2FN6z36Chm14A/wlOcx+1Ft7Gr0SE0u9DPH+v2QhKzxdAnZeZ4CVjtfGLnVSUTTkOG4Z8pcjVq0YJ+tGAL0Kdvkx5tuwWCZQdclRrfopthCNgXU6bfmArFr5rpcEzlHPwlJp3YvPB6ru1ML5Tz3DiYh5vy2nw2ffx0KvyWBFTC7dnYcdKOh0UCTp9qQXV8NBTVIxRKyvbKW8SfsaUWk5gp6i3CLX+LlqQEAXVrydGim153KJAxbTarfkQOUOUEmS7SfgBIvScIk9N9ksjl1UAkmLbFcl0enjEY24nWaLTRuhUfJ5fWidIB4mtcrn7uI9sPyT0tBRS5/fTdLfqtYSsmsAD0IcAmIzuY8XAoS7x/ToNJuQcE1ySYaDTmYHI09o2LxDOTicSWRslge23bHknskGUQNlVm52Qn6yA3okCtffXnO5cNDNEUyh4cX8oybflOwm4x3BACdUyIkzx/tqF0V3TJLyASnTzZfKuqSwWUoJoxIbTQVCzAfky1wtavd5mLuKXNX3SEGrHi3dAlYC7Q9IMeteCY6ROB1gEOoPeBTlFlLW63d8lEf+3O9qAerPU4unF5RdEmEbdLDZhFi6wNcY9u1DEce09w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(76116006)(66556008)(64756008)(66446008)(66946007)(66476007)(316002)(8936002)(8676002)(54906003)(110136005)(7416002)(4744005)(5660300002)(86362001)(2906002)(85182001)(41300700001)(4001150100001)(38070700009)(36756003)(4326008)(107886003)(2616005)(26005)(6506007)(6512007)(83380400001)(38100700002)(6486002)(122000001)(478600001)(966005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVlCMjNDemhZRnNVbHZDSGhpQWtEdGJpZ2djZTlFbjJYbmpWaXVVclphNmFq?=
 =?utf-8?B?NmJxQnpDdTVtcDFLWnBReFplSXNadGRhOFovVm9CL1VWTjlpR0w2OUJXOURx?=
 =?utf-8?B?UXpoWnMvb3d2L1lud2wyM2cxc3NhQ1d0V3BJZWJYd0IySXQ1eUVMeTJwVk90?=
 =?utf-8?B?NXJxWG9hSS9LYm5IeGwrZGhtNDZqVnFqSDFlY24rVTVaNDFFSTh2N2VHZy9z?=
 =?utf-8?B?K09EZGQzVUxLd0I3TEJmanljVWhBMkQwbE1pQ1AyekgzbjFUcmlwQ1dtdUFN?=
 =?utf-8?B?dTF6TXp2bXJUNkJmc1ltYS9JQWlmQk5WdU5nK1ptVkJ2Ni9yYlVGRGFWV3ZJ?=
 =?utf-8?B?emRKeVhqQkRYejI5ekVtdWZIOGFMa3FDSUZ2WEtDVVphOFl3T05PZ05SK1pr?=
 =?utf-8?B?a1NjNFd5b0ZKMFhNLzZkV0NhU1dQcmlFa1NWc3lSaHVGMHVjMFBYVENabzVp?=
 =?utf-8?B?M1A2VHQ0d0s1WHY1MC9SWW1ZaXJRQXFmVmZQYnFoU0J4VHFaamVaNU0rK1Vh?=
 =?utf-8?B?dENkNkZUSTIzczlZWGhmVWxOZlVDOS9ZNjR3OFQ2Q1pzV0FLN0E5d3dYYWla?=
 =?utf-8?B?TW5zUUs2M0ZpOUlvWkk3cG9FWUduUTlpNjRFa1NkZWZNZkJnYXNyeFVUUTE0?=
 =?utf-8?B?d3RZaEZBekpLQ0ZicTlScU14TGt6VndPMmNKV0NPRmdPb3BCMEpSUXVjQnVJ?=
 =?utf-8?B?Rll4Vlg4Y1Vjd2hYTFMzWE4zeG9QZDhYMlkwOHdSRGJlZEl2QU1ueEdGejha?=
 =?utf-8?B?WG9RNTEybVBuczRsazNhUEhzZHZWckxFekpEeVpScUtOL3dMYmZYaWMwWXVS?=
 =?utf-8?B?TVIvMHlWRDBoOVRzUFpia2NqeHZ2WEgzWFhsV0xRWDl4V3VFTkJSaHBtbC9F?=
 =?utf-8?B?NS84R1kvZUx1NEs4Z2hudS9lZWVlWUZ6Zk5BU283UmNWK1V0dnNBMHc0VDAr?=
 =?utf-8?B?TXN1aWoyK0lKT3B1bXJEZzYwMHNMQUFtbmh0QXFGYVNzS2hYbVJ4UHp2SVl3?=
 =?utf-8?B?bDRYN0t3R0xDMzlDdUE2MitFZTBEWHV0Q0JHazhndlc2RjhGRmZtamtOTm94?=
 =?utf-8?B?N28vbGRPNVlBc3V6TldpSTBvWVZzVCtWbUNEcSsvdUR3ZEVtYVFTVzdlTzV1?=
 =?utf-8?B?SlkxR2gwYUIwR3NiOVhXcFpaUis5Z1hwVG1TaHA2R3BCam12TldwWGJhZmYv?=
 =?utf-8?B?Y2k1Nnp1L201NVhEUlZBRndhODFVSngwMVlhLytxYjh1M1FmdUl3TFczanpm?=
 =?utf-8?B?RTBHam9wamRuYnFhdWh4Yzcrc3ZuSXFrNWtNL0ZWVzVJREhGb0VHaVh1dXMw?=
 =?utf-8?B?THdrRUZqZnZHVk9pNVpNNkx0b1BLRTlDcWdwR3Bmb1JrazBJR21Hdlk2MUJ0?=
 =?utf-8?B?eHh3bStKZFdSUTFOMjU3cGFFSEh2R05TbVRPYTQ2azJGTHg3aXZPTzlVM09Q?=
 =?utf-8?B?TUR1WnBOTEVabWk2R1RORm1GSEtmSWM1WlZDVFd6K3U1NnlQNEJyRk13NTcy?=
 =?utf-8?B?NitWZGNpT3V1S20wcWVjQkY2UVVuZ2MxTXZTUUllc0pFclJpRkYwanlORlIv?=
 =?utf-8?B?eFBRdmo4T2FlTUlqd1NvNmNDandaSnNMZFVteGJUemI2RnF6QVFhcmZIbFB3?=
 =?utf-8?B?alpHVlB6T1F1YStNY3NEQTk5RE00ZzVHSE56ZVJzSEVEYktVZTV0Vm1FZTF3?=
 =?utf-8?B?M0JYa2tGL3IyTzVHYVZEMFZ6VytpS3VCVXNTRFBYaUR4NFN4ZTVhVWc0QWMw?=
 =?utf-8?B?UFE2dUlaazg4eDE0blpWSnZRSXBrZGQ3RVJOaFkzYjhTRlBtNWtvZTVoazNa?=
 =?utf-8?B?c1Yvd3BrcXBKN0ZYNEc0UnprQVZ3MTZYQ0RCOXdUWktTSFJNWklEVnh2SlhH?=
 =?utf-8?B?Rm9yS1FKcHlVWkI3bnJqTmlRMDRLeExveGI4TTdoSzZiYXNkUmxLVklVU0p0?=
 =?utf-8?B?Z0IrM0VUQ3dmT01nWkRqbDVNTkZrZUYxZmRQc2czVDlSempkTzZOaUJLbkU4?=
 =?utf-8?B?ZjdmZVZJRGxXMmpMd1RpZE9ObnFZMDdwSldkY2p5dWw4eGV0WVVneHVUS2FI?=
 =?utf-8?B?dlJFMWE1VjV0TFJVc3g0L1RLUStEZ1puUTdjOTBrQkV5ai9tZXpTa0I2cTBx?=
 =?utf-8?Q?kt3IUeb7V2UDPSZdx8KeBK3Ip?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AA9BDB66EEC224696A6BD38012F99C2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97d94ce-0430-4822-007c-08dc0db4ff42
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 06:10:20.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygxZS1+0omxUqPG/dB6CkGsBWyBSmIIWLvn5ORAyxS35tK9WpWkGYK2BrOa9hOdhhkQqIrwUYn4G3Tc6LPTEAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7242

SGksIE1hYzoNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDE2OjUzICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24sIEhEQ1AgMS54IGFuZCAyLnggYXV0
aGVudGljYXRpb24gZm9yDQo+IERpc3BsYXlQb3J0DQo+IHRvIHN1cHBvcnQgdGhlIEhEQ1AgZmVh
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiAgDQo+IEBAIC0yMjcxLDcgKzIzMjQsNyBAQCBzdGF0
aWMgdm9pZCBtdGtfZHBfYnJpZGdlX2F0b21pY19lbmFibGUoc3RydWN0DQo+IGRybV9icmlkZ2Ug
KmJyaWRnZSwNCj4gIA0KPiAgCW10a19kcC0+ZW5hYmxlZCA9IHRydWU7DQo+ICAJbXRrX2RwX3Vw
ZGF0ZV9wbHVnZ2VkX3N0YXR1cyhtdGtfZHApOw0KPiAtDQo+ICsJbXRrX2RwX3JlX2F1dGhlbnRp
Y2F0aW9uKCZtdGtfZHAtPmhkY3BfaW5mbyk7DQoNCkFjY29yZGluZyB0byBpbnRlbCBIRENQIGZs
b3cgWzFdLCBJIHRoaW5rIHlvdSBzaG91bGQgZW5hYmxlIEhEQ1ANCmFjY29yZGluZyB0byB0aGUg
Y29ubmVjdG9yIHN0YXR1cyBzZXQgYnkgdXNlciBzcGFjZS4NCg0KWzFdIA0KaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC90
cmVlL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfaGRjcC5jP2g9bmV4dC0yMDI0
MDEwNCNuMjQxMw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgCXJldHVybjsNCj4gIHBvd2VyX29mZl9h
dXg6DQo+ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RPUF9QV1JfU1RBVEUs
DQo+IA0K


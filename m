Return-Path: <linux-kernel+bounces-12387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB081F40A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59AAB21832
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89350136F;
	Thu, 28 Dec 2023 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O7Sqk+GA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iYvQ5/KN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD03C07;
	Thu, 28 Dec 2023 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 31e30c1aa52511ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UCPqc/i+Nw/6R+scoFFHCW1t8MaZ8uJWdXG34gjOljw=;
	b=O7Sqk+GAaiuPRE19RIouAIv3vlg1Rzo/a04BbxSkbXkhgVs0+wTB/oWF3G4x/3MGUvpDK5jPiRzh01BnNiirt9cRwL9Ft0cd3KW6V9ybZ/XIP5Zuhs7IYJ7bxVhEQ9JH4B0NbpJ97oqJgDLdoT4ZB2DmGcTuCkxIQL3OwIPcb6k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5aafe2a5-f630-49f1-80e1-37cee3059540,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:700aa58d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 31e30c1aa52511ee9e680517dc993faa-20231228
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 717939402; Thu, 28 Dec 2023 10:02:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 10:02:45 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 10:02:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdB8QbXYWq63gFA14eC4/Qj/I9pnNFS292M3qzwLXWmwX3o+82omEnM4qjyp+Z1S/mIzvXL0LEnhO4aTzwpOz9O17eB0XNz+98uy9eNugLKh4W9CnaSIogf+vrFHndxmQxBoqc0D82RJ2jp5IevTmo4i2qDZ2+n5XHz/HnkTs66X6YzQddrmjwgmD+qZH5Iu/rlpgMJcnUabbPVkMqZKUJ3W93EhPOLE836pytvy1Z3WUhgPdimef+70ljammXron94njfp3nsrZMnYbk+0iur6sM+w90e87RjD2j20+d79p7DzkNvwvpzlvA/fVt7ZQ0a97lSIgbL+dl4DiMYkQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCPqc/i+Nw/6R+scoFFHCW1t8MaZ8uJWdXG34gjOljw=;
 b=ShijtfM/DkcOHHGMoxhhlCSl5EDW78DWgwLuVYZo0T1tnWtjDQdapu25czIrV0D3wmFPYV3e+3qCBBSOa7rsmVkkJBGuLwvmpdz2gpmrHz9eGDuFqqCAYnatq+jxzfjSfp0nwPMt00XLWN6I24bOxAe2qGY17ExjT1mNy0mjoMksnBDyayhF/0Ma+7G/5dCDRY/EKEKC1VGJ/twFw+2CMl5zO8WmV3F+xSCjjzugMt6jYA7lq+TvnxxkzkmYPShjRTKVS2b4xjqhXjT37V3fiVDPzbbOs7z/4yTtcVOYkjJ/N980sWPGoKb42ArMImkcU4l5nHzKshquIoeLdNtvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCPqc/i+Nw/6R+scoFFHCW1t8MaZ8uJWdXG34gjOljw=;
 b=iYvQ5/KNSaBTrgqSGhMvFbYKvZ+grcmCCk/p131BWo5ofUzkZKpeADzxfhtSEujgLpK9EVtozQ4kuaPrp/VCYOE5VWLtXmh5QEF9WFBbOXK4GHS0q9Y6r7UZ9gJIwmNnwJo1TNRmwUfQXXnLFle5lYRkVC/Cjekvfj6SOhiSARE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7113.apcprd03.prod.outlook.com (2603:1096:301:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 02:02:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 02:02:03 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7JTqAgAGJHYCAAUw1AA==
Date: Thu, 28 Dec 2023 02:02:03 +0000
Message-ID: <ae7dba29db2591ca3d09020e1cebbbbbc24b1f18.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <957c5ec4fe3a1ad6eb44df37bd68cfedfcb0b926.camel@mediatek.com>
	 <db1591bdf52f3cd02335155c45cb7841da9fcbc1.camel@mediatek.com>
In-Reply-To: <db1591bdf52f3cd02335155c45cb7841da9fcbc1.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7113:EE_
x-ms-office365-filtering-correlation-id: a0925c1d-8f85-4547-f9ab-08dc0748fc74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jQ9rVW0Gcz6JUjHRJIbdZ8/4X6bXVv0apaFSNrkltkkDcojcLeRFYRhWVQF1WUU8vx/FY+XGu6xcQ0smqNcCJEUnSu1quCP+XpjIJGtpRo2PY7Q50UaS2RSAeAkuRDecnJogqm8J2bfBJ6LmSvWQP3oTJ91ZKhDqfX4k6VJ2v3XlR2ir9b7xfJSV+yAmTC4T30cMB+k09s4JvtV2DfgOiqB1hNlm4nlzMkzQg5FNP7wx9LemIQ8PMATYtpczYQuGuDHAzv4nkFdZ5+LqLheBf2l1vj4rtEie2UWCneWRkNe64Anm9tDm1lJwJSpDQ0UO17eBuHIpmiL5drvuOnrCNlyx03ZvOznSPMx7Eh5TFjCtkA6mheUNBmKpRUDT4a91G0gMSIVFykYgPMTPCwhhbtOaaH2B/rMY4E080BYRkCCLMeQT7I1zXAax+8wUgQc1OraKLwWNkPu2opEDH19Jq6ssQGYjPi6xQvcGWmvayJ9T6rMp8M3B46/VuKYD+scs5D/ZnDetC6XNHQWNU9YsDLzyw0bCRDBV03/5lnFimXjnF/uzi6PEsSJaWQvsa1ZxIBKh6pmpO1G1cYq61L6aJd/kjYMPT9JtlEHckoqFcsNoWxLEuehkd766wXKk+SJ3i2SgPVeIJzrX7KWdcacFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(2616005)(41300700001)(83380400001)(122000001)(26005)(38100700002)(478600001)(54906003)(110136005)(4326008)(316002)(7416002)(8676002)(4001150100001)(5660300002)(8936002)(15650500001)(64756008)(6512007)(6506007)(71200400001)(66446008)(66476007)(66556008)(86362001)(76116006)(6486002)(66946007)(966005)(38070700009)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akpJRmpXNkFrNExsS3U5Q1dIOHBSZEFqTWd6NlBrWm52OVhIcEtLVTBzR2RW?=
 =?utf-8?B?ck5WZlhKMGx6YVhrWkZxYStXRFpvM3E5TWlRMzNmd0lqMkNpWEFNd2ZHZjU3?=
 =?utf-8?B?RVNNazdtSW9iNDlmWGNGWjRwS2QvaDJuOHF2dmI3VXNyUnlieHNiTlNVaXcx?=
 =?utf-8?B?cWx0bHFUWlF0REhCelZkUDFHM0VUcElydDE5bmVvRWV3TTRiYTQyYXYxSCtK?=
 =?utf-8?B?YStYNWpqU1BiM1hiUTZuU2JWSTJSVER4TklqU2Yzd0RrVHZpSW4wTzdkTWFp?=
 =?utf-8?B?TFZ5Z0QxNm1zbVJrZVBncHNQOU9FTll0Y1dNVitQMzFlcnNXUFNHaXVQQThv?=
 =?utf-8?B?NnB2d29yWEdESE5waUoxU1hLdEQ0dW1jcFRCMnFEM1NWUTJISjNDZXVwVEta?=
 =?utf-8?B?dkZubG5BMVdVcytvNHY0bEZqODgxOTAzdzhqak1OdHZoWmhrT243bE5XOWUv?=
 =?utf-8?B?S250dkg2VHV5NXVtMkx3Y1RLT0ZvY1l2bzdpeHJISSt5ZlNCQktLYjhLSXFt?=
 =?utf-8?B?NGRKaC9uaEtVbnNsdFluMVh1ZzYwRXJNVllMeVpKdVBuMTF2Q2FNbDI2UlZZ?=
 =?utf-8?B?RzlEWnM5QXM1N25OUVVxQmNMdzhqc1hyR2RDYTZYZkRQQVM2SVo0MkJMckRt?=
 =?utf-8?B?M0tVdTY3MkVXUlZQbnBuU1I5a1pFZ09wNmdDQ3g0UEtpUm5oNlZPYXR5eE4x?=
 =?utf-8?B?N0NpbGhCNlNqZmlUQ2d3SlE4d0dQSWdVeFoyeXVhMjhZVTh0RHJjR2twbllT?=
 =?utf-8?B?RnhpNUw0YU9nWmpyRm5WTG5Gd081ZEQxRVdBVXNhR2VJdUVqTDFiSDA2VFlI?=
 =?utf-8?B?cUtEV3BFRTJMaU5Fb3cxeXlhTkJIVmdOeUVDY0tQOUkwdVE3WUxPRGxYZVVM?=
 =?utf-8?B?ZUk0VlVNNHJFcXhYcVArOHBpbnNDSkp4b2o0cE5NV0RwVzBWamF2RGhVSDJF?=
 =?utf-8?B?TzFKNkRLVlJMZjhxQWZVY3Z5czVVMHZQbFdHRWFPeEM4Zlcxa1BpcXNZcjRs?=
 =?utf-8?B?M2ZTMU1COVRUN1lyakZZTWcwU3ZxRzFCZ1pDYy8xWEUrbEZDT3EyalAzQzlu?=
 =?utf-8?B?TDV0YkJNZHJXbWxTY3ZGb2tycWZmSkZ2VUlFNHRucDd4SFEzZTBCbWxpY1FW?=
 =?utf-8?B?NWJ0NWtCWkREVkdSaUQ3M1NCdmZjZFNxTEZ5Z0RJSnJpQiswK0RNV3o0V3dS?=
 =?utf-8?B?UVYxRnVFRjR5WXRQdmdrVXF5OXUrMG42SitTNmRRdHM3LzJVR1VvUE9hTVRr?=
 =?utf-8?B?VlYxRzR4eFFnbEJCbFhaOXNpYmhvNm4vQVRxSUxRR1JiNGlPYksyS05wc253?=
 =?utf-8?B?cFlyVWIxM3hmTjNJdDAzUC84Q1ZrUFJ2TU5BT2Y1NEgyZlQyUndBQzlqZGVI?=
 =?utf-8?B?emdITGZGVzRrUmtnZXhTa29UaVpOTG9CTys2OUIyUzdPV1AwRUMyTmhJck1x?=
 =?utf-8?B?eCs5LzZnUCtabkJuNzFIb052TEFWWWdZWmJsZ0xETWtSYzg3d3MxcHJmNFRB?=
 =?utf-8?B?Qklab0lpVk1ERjN0VEppVEdjekJzLzJoVnVnVk5iL0QrS1lxYWVZaTBHNWRH?=
 =?utf-8?B?S3RhMFhmSDc1VkkyUEpjVUtTRTA0Z3FYRW1IamdXQ1F4b3Qrekg2NEQ5UEVV?=
 =?utf-8?B?elNiMGl0d0MwMENvbEd1NjFISzBkOUFreW9iNlI2c0xMRUJhVVZVUVc3OVNY?=
 =?utf-8?B?OVZSTkJPQzBZUndBNnB0ZlZvYkFkRVE5eE5BRUFJamI5WGdTbHRkL1BMVmJY?=
 =?utf-8?B?Y3NubUNoMUlGdjRFTGg5SzVMdzdoMlA2N2JicU5JZVQ1d1FTV0VmVS9vK29r?=
 =?utf-8?B?Vk0vOXhZSUFkcnRQUzlmaDVFL1JMOEhFeGovY0VYcW1qZGlnZE10UjZONnFS?=
 =?utf-8?B?dCtuYm4xbGUydlltd2EzUVFpT0lVbTl5NktIU25IcmRORDBBNExIYVA0R1VK?=
 =?utf-8?B?WnBnWThpd0plY1o2dEdvSFZnNEVlQ0hmcE96M2taMTZzVEdqOUFiZGkyS3NG?=
 =?utf-8?B?d3A5cnZuMnhzQWh1NUZhbTlMOFFsNXJYaVlIZXh6Z2Y1dC9aQzd2QzZ3eERo?=
 =?utf-8?B?WWtpUXVkY04vU09xd09nbFkrWFFadk53RWxHaEhmTThZZklKWjNLbXBCSHVI?=
 =?utf-8?Q?FGUSWzS91XCoshNFBQAN9tqPo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACA47F658B246149BC29F9C7905A6FC7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0925c1d-8f85-4547-f9ab-08dc0748fc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 02:02:03.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEmdwozDfR2Ocjz+t5bg2AhgNN2ld7wMFXomSf7AWEiAdZAAjgsnqdxijZL8EYa3FeTRYlVzoiebMeauqlzgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7113
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.056300-8.000000
X-TMASE-MatchedRID: QfHZjzml1E8OwH4pD14DsPHkpkyUphL9EtdrY/Wb3fPdywP+TFB0zypf
	0VJZhlxP3gb7k6xpVN4a/3L93pcprQTsy5Ctk/ajdAg4yd14qAQxmbT6wQT2a/t592eq2xoTHye
	T8VIiNb6ykaH8ZceX1bWrjxGHjCv1oqIp1AUZB5rRfDQgu+j+5SlayzmQ9QV0TUobVis5Bb8+UX
	k3m3aAvzVpERgfokBAy3HscmUQ3XzU4D7YCSb+lLU+IyHhkXf1KFFZAe4nyZ6bKbiOQazMl1AoI
	N0YpQaH4vM1YF6AJbY9l7H+TFQgdY2j49Ftap9EkGUtrowrXLg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.056300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4B93FA8AE5CE3B80C517FEA12D9163395811A23E9432483534D42004C62FA0AD2000:8

T24gV2VkLCAyMDIzLTEyLTI3IGF0IDA2OjEzICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+el
pSkgd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCj4gDQo+
IE9uIFR1ZSwgMjAyMy0xMi0yNiBhdCAwNjo0NiArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3Jv
dGU6DQo+ID4gSGksIEphc29uOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMy0xMi0yMiBhdCAxMjo1
MiArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gVG8gc3VwcG9ydCBzZWN1cmUgdmlk
ZW8gcGF0aCBmZWF0dXJlLCBHQ0UgaGF2ZSB0byByZWFkL3dyaXRlDQo+ID4gPiByZWdpc3RnZXJz
DQo+ID4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ugd2lsbCBlbmFibGUgdGhlIHNlY3VyZSBh
Y2Nlc3MgcGVybWlzc2lvbg0KPiA+ID4gdG8NCj4gPiA+IHRoZQ0KPiA+ID4gSFcgd2hvIHdhbnRz
IHRvIGFjY2VzcyB0aGUgc2VjdXJlIGNvbnRlbnQgYnVmZmVyLg0KPiA+ID4gDQo+ID4gPiBBZGQg
Q01EUSBzZWN1cmUgbWFpbGJveCBkcml2ZXIgdG8gbWFrZSBDTURRIGNsaWVudCB1c2VyIGlzIGFi
bGUNCj4gPiA+IHRvDQo+ID4gPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1
cmUgd29ybGQuIFNvIHRoYXQgR0NFIGNhbg0KPiA+ID4gZXhlY3V0ZQ0KPiA+ID4gYWxsIGluc3Ry
dWN0aW9ucyB0byBjb25maWd1cmUgSFcgaW4gdGhlIHNlY3VyZSB3b3JsZC4NCj4gPiA+IA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gDQo+ID4gW3NuaXBdDQo+ID4gDQo+ID4gPiArDQo+ID4gPiArc3Rh
dGljIGludCBjbWRxX3NlY19zZXNzaW9uX2luaXQoc3RydWN0IGNtZHFfc2VjX2NvbnRleHQNCj4g
PiA+ICpjb250ZXh0KQ0KPiA+ID4gK3sNCj4gPiA+ICsJaW50IGVyciA9IDA7DQo+ID4gPiArDQo+
ID4gPiArCWlmIChjb250ZXh0LT5zdGF0ZSA+PSBJV0NfU0VTX09QRU5FRCkgew0KPiA+ID4gKwkJ
cHJfZGVidWcoInNlc3Npb24gb3BlbmVkOiV1IiwgY29udGV4dC0+c3RhdGUpOw0KPiA+ID4gKwkJ
cmV0dXJuIDA7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJc3dpdGNoIChjb250ZXh0LT5z
dGF0ZSkgew0KPiA+ID4gKwljYXNlIElXQ19JTklUOg0KPiA+ID4gKwkJZXJyID0gY21kcV9zZWNf
aW5pdF9jb250ZXh0KCZjb250ZXh0LT50ZWVfY3R4KTsNCj4gPiA+ICsJCWlmIChlcnIpDQo+ID4g
PiArCQkJcmV0dXJuIGVycjsNCj4gPiA+ICsJCWNvbnRleHQtPnN0YXRlID0gSVdDX0NPTlRFWFRf
SU5JVEVEOw0KPiA+ID4gKwlmYWxsdGhyb3VnaDsNCj4gPiA+ICsJY2FzZSBJV0NfQ09OVEVYVF9J
TklURUQ6DQo+ID4gPiArCQlpZiAoY29udGV4dC0+aXdjX21zZykgew0KPiA+ID4gKwkJCXByX2Vy
cigiaXdjTWVzc2FnZSBub3QgTlVMTDolcCIsIGNvbnRleHQtDQo+ID4gPiA+IGl3Y19tc2cpOw0K
PiA+ID4gDQo+ID4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArCQl9DQo+ID4gPiArDQo+
ID4gPiArCQllcnIgPSBjbWRxX3NlY19hbGxvY2F0ZV93c20oJmNvbnRleHQtPnRlZV9jdHgsDQo+
ID4gPiAmY29udGV4dC0+aXdjX21zZywNCj4gPiA+ICsJCQkJCSAgICBzaXplb2Yoc3RydWN0DQo+
ID4gPiBpd2NfY21kcV9tZXNzYWdlX3QpKTsNCj4gPiA+ICsJCWlmIChlcnIpDQo+ID4gPiArCQkJ
cmV0dXJuIGVycjsNCj4gPiA+ICsNCj4gPiA+ICsJCWNvbnRleHQtPnN0YXRlID0gSVdDX1dTTV9B
TExPQ0FURUQ7DQo+ID4gPiArCWZhbGx0aHJvdWdoOw0KPiA+IA0KPiA+IFNxdWFzaCBjbWRxX3Nl
Y19zZXNzaW9uX2luaXQoKSBpbnRvIGNtZHFfc2VjX21ib3hfb2ZfeGxhdGUoKSBhbmQNCj4gPiBk
cm9wDQo+ID4gdGhlIGNvbnRleHQtPnN0YXRlLg0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sN
Cj4gPiANCj4gDQo+IGNtZHFfc2VjX3Nlc3Npb25faW5pdCgpIGlzIGNhbGxlZCBpbiB0aGUgZmly
c3QNCj4gY21kcV9zZWNfdGFza19zdWJtaXQoKS4NCj4gSXQgbWVhbnMgd2UgZG9uJ3QgbmVlZCB0
byBjb25uZWN0IGEgc2Vzc2lvbiB0byBURUUgb3IgYWxsb2NhdGUgc2hhcmUNCj4gbWVtb3J5IGlm
IG5vIG9uZSBzdWJtaXQgc2VjdXJlIHRhc2suDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgb3B0
ZWUgbWF5IGxvYWQgc2xvd2VyIHRoYW4gY21kcSBzZWN1cmUgZHJpdmVyLiBJZg0KPiB3ZQ0KPiBt
b3ZlIGl0IHRvIHhsYXRlIHNlY3VyZSBzZXNzaW9uIG1heSBpbml0IGZhaWwuDQoNCkZvciBkcml2
ZXIgcHJvYmUgZGVwZW5kZW5jeSwgeW91IGNvdWxkIHJlZmVyIHRvIFsxXS4gSSB3b3VsZCBsaWtl
DQpyZXNvdXJjZSBhbGxvY2F0aW9uIGFuZCBmcmVlIHRvIGJlIHN5bW1ldHJpYy4gU28gbWF5YmUg
YWxsb2NhdGUvZnJlZSBpbg0KcHJvYmUvcmVtb3ZlIG9yIHN0YXJ1cC9zaHV0ZG93bi4gSWYgdGhl
IHNlY3VyZSBkcml2ZXIgaXMgcHJvYmVkLCBJDQp0aGluayBpdCB3b3VsZCBmaW5hbGx5IGFsbG9j
YXRlIHNlY3VyZSByZXNvdXJjZS4gU28gbGF0ZXIgYWxsb2NhdGlvbg0KaGFzIG5vIG11Y2ggYmVu
ZWZpdCBhbmQgbWFrZSBjb2RlIG1vcmUgY29tcGxpY2F0ZWQuIA0KDQpbMV0gDQpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0
L2NvbW1pdC9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWs/aD1uZXh0LTIwMjMxMjIyJmlkPWM4MDQ4
ZGQwYjA3ZGY2ODcyNDgwNTI1NGI5ZTk5NGQ5OWU5YTdhZjQNCg0KUmVnYXJkcywNCkNLDQoNCg0K
PiANCj4gUmVnYXJkcywNCj4gSmFzb24tSkguTGluDQo=


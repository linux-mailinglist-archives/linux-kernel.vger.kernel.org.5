Return-Path: <linux-kernel+bounces-4064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3697817779
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58286B233E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED585A84C;
	Mon, 18 Dec 2023 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NLHVMSQn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="e2wIlmkm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844F3D57F;
	Mon, 18 Dec 2023 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 54afa57e9dc211eeba30773df0976c77-20231219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lQ0aG9wRhiyr4Oicec/5c7bCXb/LExGjpCuewZxh8d4=;
	b=NLHVMSQndMi+ZweNPuTraKaEoRYHDKAcOrdh8P1Ka/T6AFMOXj+umDc6baW0cEdhTTDMDoEoXYffwkjsTKxRuOWoGQYJrHywBBeZe4I8/eFPOsaqJasjOijDCdJH8lalNGJgx1QOl2Ex0eyN47vVan3RLqrk0i7AmdRyjjwZe+8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:870d5c9f-7004-431f-96f1-2782b41c805c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:7079ed73-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 54afa57e9dc211eeba30773df0976c77-20231219
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <bo.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1713169256; Tue, 19 Dec 2023 00:27:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Dec 2023 00:27:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Dec 2023 00:27:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etY9UkQ19hmbuRurEhpUkSYV1K4SFvCg18BssekCc5T+W11zk7QXas6JsU4dn+D1rx3H23lIIjL8nWLiDGuqVkjTXqx2qefPnUbzMW8nMXhtS27j0ynH69+HllfeZ+TjV55PprZjGCM1zweiqpG5PKYMsWPy4vunZRMDY5GjIM696K1W4jrIQ+5mBaNfoDFDtOV6lXiVrzgDo5DzVsBQc4LZ5Bc7hBpXRyhz/h+gpcBCNyy6ew5NQB6p+6DoTMfgSxZZHwzNfoXvESQhJIVHV4V+osWqAKcwpRLHyjsjXCzHy3mSEO7s1t2cS+j29P099WzlLa92fvPUimtCahr8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ0aG9wRhiyr4Oicec/5c7bCXb/LExGjpCuewZxh8d4=;
 b=Yj3qgFUZbKHSEaJT1eJ9LerO7xiMbcPYRIMsmNG8EGyE/c86U76VRGhuy2OMwxzhJhQ1t2UwKvLfU/CSOpSZBqildduPfmfb5ffAuGPmYIAXMzaNNNX3yCBafV3ThYPbLbrvQhv6pACpwTswfRh74fYJokp2tHXKpFdW0Vq23C+F6TIYckBTGCHKr4G3mh34GsrHAq/APKOyRnnlsapn7a1ICIchJmxHP20ZP2TW/TOm5XtIlL5nDhatP4bL38N21TLPu8GAxI2EPM6Eae32IlGndP4WPXlfMUvoqTO8Gk5xoxre0NruZGsLQGqaMCrHjaoVmShnnNXEwNBJYxO1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ0aG9wRhiyr4Oicec/5c7bCXb/LExGjpCuewZxh8d4=;
 b=e2wIlmkmEYsBQHtE2jWpR7BqkpBvkxZC7jmUZKuG73qP6i51ms632zJ0VhSWzfgk5jgrm9VkajrGTfcLQDaVUf4ky5zcjdoLaRQAh9KA9dTCobyzzdeWodniaTBCRYdDbkcqFsCJ/Iob3GB0CW4B66IfMMOiyOE4KgEy6EAKsOM=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by SEZPR03MB7486.apcprd03.prod.outlook.com (2603:1096:101:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 16:27:23 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::66c6:e98b:f23d:2d84]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::66c6:e98b:f23d:2d84%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:27:23 +0000
From: =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To: =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?=
	<Yongdong.Zhang@mediatek.com>, =?utf-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?=
	<Yugang.Wang@mediatek.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v4] thermal: fix race condition in suspend/resume
Thread-Topic: [PATCH v4] thermal: fix race condition in suspend/resume
Thread-Index: AQHaMc8UDpbiGtamyEO2ZwwtOh6UUQ==
Date: Mon, 18 Dec 2023 16:27:22 +0000
Message-ID: <TYZPR03MB5199B14364633FD7A09A13719490A@TYZPR03MB5199.apcprd03.prod.outlook.com>
References: <20231218162348.69101-1-bo.ye@mediatek.com>
In-Reply-To: <20231218162348.69101-1-bo.ye@mediatek.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|SEZPR03MB7486:EE_
x-ms-office365-filtering-correlation-id: 50ef3899-c6f5-45c5-81fd-08dbffe636cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HAB78KMCV0Qy0KmCylxV88a8gZAZAER6fkWNoI6j1BLgRU7UV9OEc1jxzN+BgnTeH+lUT5KCPyt3QnqMgHbXoKLNsd5PQxI8FyWZE8mvwUwdE9KdJT0NSPyfPXFK8KTtO2vyoJK+i6Gu3HQ5SlY9hueeS8uPf+67x7lh7RWWOTop69j222wVd1PeYV9g10eC0mdY/WlYv1pwUi3aRNnfMJ5QTMRyPBpavDs6J+pe4arrN8+D9gpyNmMpu6bGvFto9FMjCT9+5JXffbRn/AFYcF+gLS57zjrWlses5IgE2RJQCCBxblK8az8S7tb43x+f5h2IC+UMRclxwUsn+n2yqdIr4szP8uw4Vm7c5FgknA1XmtGnrObBW+0g0QEIwfOMp7ndWdZHarLqmbc33k/2emDnm1m+W3fpTFPLH5/NBB+ArUty121PRuR4KqBlsiUeku/FNlzvr9rCkq4TAxzeUsGpek42gwKmiXpAQ2uy0yzpZfM+pz5BabzNmu3OBO4DTH4yBQb0Vq85v3DdBt6bzXCRZjoxHEwSAC4/lYWOywU1MLZKuiAvAAXbAfEQivtW/ErvU3wwBpA8jHNDGihchkLJYNbx5Ic3W6Gk36qPTT3wMs3fTMH6cPjJRkVmyjVXdzZUI8naOF5U51H7nBwkt1oLSU+FMblnNIWGx1uc+50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(38070700009)(76116006)(110136005)(86362001)(85182001)(33656002)(38100700002)(122000001)(26005)(83380400001)(71200400001)(316002)(478600001)(2906002)(4001150100001)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(7696005)(6506007)(9686003)(4326008)(5660300002)(15650500001)(8676002)(8936002)(7416002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1FOZFNvejhBSWNIMVlnRnM1QnhvUllmRDYzTHdCRjhnR1RNRVF6eFVSY1hv?=
 =?utf-8?B?WXovRjBES2JrWUEzWE5uUm9vYjIrM2IvTnptTEVYR01NY2t0QytOSUg2Q0tI?=
 =?utf-8?B?VzN6Q3kwNzZxb1dJMTE3cFdsNnZvb2xiMDZFRzJYRHdyb2drWTJHalVGVGVq?=
 =?utf-8?B?c3FwMDl5M2lHaWRxcnlXT0lsUzJ0V0w5VkhCR3hmZEJVNnlSRTQvWWdtNGMy?=
 =?utf-8?B?MGJlQ245emoySEZRL2J5RHZJRFVzdkZsSnRMVVNROURUTTRDN3RlWm1hRllu?=
 =?utf-8?B?WVg1YnB2d2lQMmNHbVRzNDlPc240VnN6QUQ0ZVBBV2tYbnV2UFBEamFIU3N1?=
 =?utf-8?B?OXVuT2hBZkpKMDlKQS9aSFBWdmp3cFpOQXJsN2l4MGJwaGxsUUZUdHRpaXJC?=
 =?utf-8?B?bGIyeEd6WEZ0OVZOdW9odWs5ZVZxcEJrL0xZQTZjR3RKSVhUN1dobHZBVTd3?=
 =?utf-8?B?QU5YUW9EVUZpdm9iWWNCT1F1RkVHRmQxUW1ESXo4S05sWnZRZFg2WGFWeHpO?=
 =?utf-8?B?cTNLNk9oeDlxRTJsRmxicTRIc3pTNENiU2hNaFc2YnRoNEpWMmc0UkwwZmFa?=
 =?utf-8?B?d3UzbzZDY01OR095K2lYOFhxZDE0djRmakl2czNSWk4rMkIxbk1TRk8wWmto?=
 =?utf-8?B?OEZ0RjJtUTBIR2JhRG9JUjhIa2w3UlgyOWdCa2dhbUhYanlXUFFCdWxuQ2lt?=
 =?utf-8?B?RHdabnIyaHdHYlo5cUtKcnhQQmNINzdxTjlNUnp2c1ZZbjU3VEhxUkRsc2Z6?=
 =?utf-8?B?aTc2TGNlWEhWdkp3Q1MzaERCZ3NnQ1E0WGxYUXZRS3kzeDB3SHkvbDJoSXU4?=
 =?utf-8?B?NDA4RkNBOVcxejZZKzNKcXNMVXZuczIwaUt0Y3RxRlNlUWRzZWU3b2dWL2wz?=
 =?utf-8?B?SkhPL0psOXE3L0I1bVlnVUlQTDUvK1V2ajR4TnlvcjFNenRsdkpBd2FxN00y?=
 =?utf-8?B?aFV5VE5qYzVGSk5PVE9uOWxyYk1rRnZIVkh0NmJicXptSFZNL1lReHQ5bkJj?=
 =?utf-8?B?NE42WURsbGMxN2xGcXJvdDdEZCtNcVRSMXp2WEU5SnpzcllIUVF0NU5aNnNL?=
 =?utf-8?B?QWdQREl2STZmVkhPSUZGYzVkNFRSTG8weXRHY2hhVXdrSld0ODlpbkFEN1kx?=
 =?utf-8?B?cDg2T2loT3QrTnoxcFY1bVNRSzQ1bTU5amFFTDJkTnBPc3pmTldTRE9nMHpW?=
 =?utf-8?B?UDVSOWs3ZHErZ2hUNXJpTmY0cFpHSkpiWE9pREFmQWdKMEY2WTFHaG1qWFhD?=
 =?utf-8?B?Q0NucUVHY3dzT3JyeG5kZTJxSm1kendwNGxrMnBEenBjV3VQQ1NUbmJmNUZz?=
 =?utf-8?B?TzZJVTRML0ozbWF5SlI1UEViYnVwV21zUk81bWpDd0k5alNlMDdnYlpOajlp?=
 =?utf-8?B?SUF4OVhKdWxFMjRXMEljWXNSTDFVdDNPb0JGL0VGWnZCdzFjS2Z5cDhtelhj?=
 =?utf-8?B?SEo4Slo4OG1jVStYN25mK0xSNVRtQlA1clpYaEloZW16cVpEN1NQZ21kL2F4?=
 =?utf-8?B?V2ZiT2dLS1NsdFJYTmhFd0JGZnMyUHRKTHNNdEpRSmJxNmd0U3hJMVdDdW9I?=
 =?utf-8?B?YmREWHpYUnY3SzdJZ25EUFJiWGwrZ2RnL0x4bkU4Rk1vK1F6VElQbFc1aDFp?=
 =?utf-8?B?UXlJaVZ3T0JwRmVFeFFvM1ViYk5UVTQ2cG0vNnAwa0JVWHJRSnVPWURUQUVE?=
 =?utf-8?B?N3BsMDFXaU9TK0pVM0JBcHlUV2Nkb1VHUXMvQWppZXFHcm1DNGV4TEtSQjZt?=
 =?utf-8?B?dkxSbVRTb0R4T0JxbEtkMWN5dmRYVnUzUzRQZkc2eVIzdllmZHdGRXRFQWRT?=
 =?utf-8?B?YVpKM1Z6ZmpiQVlxOUJ3dzA2NkJuOTBVRTk4d1dyTUk4NkhONnlBK1JtRW1M?=
 =?utf-8?B?NTJsWjhCRkV5STdFaC9pMTlKYnRqTlRzUFA1U2pGa1dFYXFXSFFPenJWT0VH?=
 =?utf-8?B?Uzg1QThaNmxmYzg5YzB5dktkN3greVZ1c04zSkwvdUtvNVhoVDNJRlNiclZP?=
 =?utf-8?B?aWdZWFVSSkY1bTMxWlpLbGJOV0E0UFRIdDlobjNvc0c3d3B1elFWQnBTZmdz?=
 =?utf-8?B?OTJGWVd6L09EcjJBemxvZHlnRXp6MC9KcWtBS2dvNnhxNSt4MjhlZk1MV3Vu?=
 =?utf-8?Q?FkZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ef3899-c6f5-45c5-81fd-08dbffe636cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 16:27:22.9531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtcKvdy8+4Qs7jbQ5O7SVTmriUbbpOd5zHrSV7u/JZ3w+6cM5Fj4QHOMbPZ2SNhOaaJNvEmATjMdL195GV3hDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7486

RnJvbTogInl1Z2FuZy53YW5nIiA8eXVnYW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KDQogIEZpcnN0
bHksIGl0IG5lZWRzIHRvIGJlIGNsYXJpZmllZCB0aGF0IHRoaXMgaXNzdWUgb2NjdXJzIGluIGEg
cmVhbC0gd29ybGQgZW52aXJvbm1lbnQuIEJ5IGFuYWx5emluZyB0aGUgbG9ncywgd2UgaW5mZXJy
ZWQgdGhhdCB0aGUgaXNzdWUgb2NjdXJyZWQganVzdCBhcyB0aGUgc3lzdGVtIHdhcyBlbnRlcmlu
ZyBzdXNwZW5kIG1vZGUsIGFuZCB0aGUgdXNlciB3YXMgc3dpdGNoaW5nIHRoZSB0aGVybWFsIHBv
bGljeSAodGhpcyBhY3Rpb24gY2F1c2VzIGFsbCB0aGVybWFsIHpvbmVzIHRvIHVucmVnaXN0ZXIv
cmVnaXN0ZXIpLiBJbiBhZGRpdGlvbiwgd2UgY29uZHVjdGVkIGRlZ3JhZGF0aW9uIHRlc3RzIGFu
ZCBhbHNvIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZS4gVGhlIHNwZWNpZmljIG1ldGhvZCBpcyB0byBm
aXJzdCBzd2l0Y2ggdGhlIHRoZXJtYWwgcG9saWN5IHRocm91Z2ggYSBjb21tYW5kLCBhbmQgdGhl
biBpbW1lZGlhdGVseSBwdXQgdGhlIHN5c3RlbSBpbnRvIHN1c3BlbmQgc3RhdGUgdGhyb3VnaCBh
bm90aGVyIGNvbW1hbmQuIFRoaXMgbWV0aG9kIGNhbiBhbHNvIHJlcHJvZHVjZSB0aGUgaXNzdWUu
DQoNCkJvZHk6DQogIFRoaXMgcGF0Y2ggZml4ZXMgYSByYWNlIGNvbmRpdGlvbiBkdXJpbmcgc3lz
dGVtIHJlc3VtZS4gSXQgb2NjdXJzDQogIGlmIHRoZSBzeXN0ZW0gaXMgZXhpdGluZyBhIHN1c3Bl
bmQgc3RhdGUgYW5kIGEgdXNlciBpcyB0cnlpbmcgdG8NCiAgcmVnaXN0ZXIvdW5yZWdpc3RlciBh
IHRoZXJtYWwgem9uZSBjb25jdXJyZW50bHkuIFRoZSByb290IGNhdXNlIGlzDQogIHRoYXQgYm90
aCBhY3Rpb25zIGFjY2VzcyB0aGUgYHRoZXJtYWxfdHpfbGlzdGAuDQoNCkluIGRldGFpbDoNCg0K
ICAxLiBBdCBQTV9QT1NUX1NVU1BFTkQgZHVyaW5nIHRoZSByZXN1bWUsIHRoZSBzeXN0ZW0gcmVh
ZHMgYWxsDQogIHRoZXJtYWwNCiAgICAgem9uZXMgaW4gYHRoZXJtYWxfdHpfbGlzdGAsIHRoZW4g
cmVzZXRzIGFuZCB1cGRhdGVzIHRoZWlyDQogICAgIHRlbXBlcmF0dXJlcy4NCiAgMi4gV2hlbiBy
ZWdpc3RlcmluZy91bnJlZ2lzdGVyaW5nIGEgdGhlcm1hbCB6b25lLCB0aGUNCiAgICAgYHRoZXJt
YWxfdHpfbGlzdGAgZ2V0cyBtYW5pcHVsYXRlZC4NCg0KICBUaGVzZSB0d28gYWN0aW9ucyBtaWdo
dCBvY2N1ciBjb25jdXJyZW50bHksIGNhdXNpbmcgYSByYWNlIGNvbmRpdGlvbi4NCiAgVG8gc29s
dmUgdGhpcyBpc3N1ZSwgd2UgaW50cm9kdWNlIGEgbXV0ZXggbG9jayB0byBwcm90ZWN0DQogIGB0
aGVybWFsX3R6X2xpc3RgIGZyb20gYmVpbmcgbW9kaWZpZWQgd2hpbGUgaXQncyBiZWluZyByZWFk
IGFuZA0KICB1cGRhdGVkIGR1cmluZyB0aGUgcmVzdW1lIGZyb20gc3VzcGVuZC4NCg0KICBLZXJu
ZWwgb29wcyBleGNlcnB0IHJlbGF0ZWQgdG8gdGhpcyBmaXg6DQoNCiAgWyA1MjAxLjg2OTg0NV0g
W1QzMTY4MjJdIHBjOiBbMHhmZmZmZmZlYjdkNDg3NmYwXQ0KICBtdXRleF9sb2NrKzB4MzQvMHgx
NzANCiAgWyA1MjAxLjg2OTg1Nl0gW1QzMTY4MjJdIGxyOiBbMHhmZmZmZmZlYjdjYTk4YTg0XQ0K
ICB0aGVybWFsX3BtX25vdGlmeSsweGQ0LzB4MjZjDQogIFsuLi4gY3V0IGZvciBicmV2aXR5IC4u
Ll0NCiAgWyA1MjAxLjg3MTA2MV0gW1QzMTY4MjJdICBzdXNwZW5kX3ByZXBhcmUrMHgxNTAvMHg0
NzANCiAgWyA1MjAxLjg3MTA2N10gW1QzMTY4MjJdICBlbnRlcl9zdGF0ZSsweDg0LzB4NmY0DQog
IFsgNTIwMS44NzEwNzZdIFtUMzE2ODIyXSAgc3RhdGVfc3RvcmUrMHgxNWMvMHgxZTgNCg0KICAz
LkVuYWJsZSB0aGVybWFsIHBvbGljeSBvcGVyYXRpb24gd2lsbCB1bnJlZ2lzdGVyL3JlZ2lzdGVy
IGFsbCB0aGVybWFsIHpvbmVzDQogICAgIDEwLTIxIDA2OjEzOjU5LjI4MCAgIDg1NCAgIDkyMiBJ
IGxpYk10Y0xvYWRlcjogZW5hYmxlIHRoZXJtYWwgcG9saWN5IHRoZXJtYWxfcG9saWN5XzA5Lg0K
DQogIDQuU3lzdGVtIHN1c3BlbmQgZW50cnkgdGltZSBpcyAyMDIzLTEwLTIwIDIyOjEzOjU5LjI0
Mg0KICAgICBbIDQxMDYuMzY0MTc1XVtUNjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1lOnNwbSZd
W1NQTV0gUE06IHN1c3BlbmQgZW50cnkgMjAyMy0xMC0yMCAyMjoxMzo1OS4yNDI4OTgyNDMgVVRD
DQogICAgIFsgNDEwNi4zNjYxODVdW1Q2MDkzODddIGJpbmRlcjo1MzRfMjogUE06IFtuYW1lOndh
a2V1cCZdUE06IFBlbmRpbmcgV2FrZXVwIFNvdXJjZXM6IE5FVExJTksNCg0KICA1LiBJdCBjYW4g
YmUgcHJvdmVuIHRoYXQgdGhlIGFic2VuY2Ugb2YgYSBzd2l0Y2ggc3RyYXRlZ3kgd2lsbCBwZXJm
b3JtDQogICAgIHVucmVnaXN0ZXIvcmVnaXN0ZXIgb3BlcmF0aW9ucyBvbiB0aGVybWFsIHpvbmVz
IChhbmRyb2lkIHRpbWUgaXMgMjAyMy0xMC0yMCAyMjoxMzo1OS4yODIp77yMDQogICAgIEJlY2F1
c2UgdGhlIGxvZ3MgZm9yIG90aGVyIHRoZXJtYWwgem9uZXMgc3dpdGNoaW5nIGFyZSBub3QgZW5h
YmxlZCBieQ0KICAgICBkZWZhdWx0LCB3ZSBjYW5ub3Qgc2VlIHRoZSBsb2dzIHJlbGF0ZWQgdG8g
b3RoZXIgdGhlcm1hbCB6b25lcy4NCiAgICAgWyA0MTA2LjQwNDE2N11bVDYwMDkyMl0gbXRrUG93
ZXJNc2dIZGw6W25hbWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVddHNjcHVfdW5i
aW5kIHVuYmluZGluZyBPSw0KICAgICBbIDQxMDYuNDA0MjE1XVtUNjAwOTIyXSBtdGtQb3dlck1z
Z0hkbDpbbmFtZTp0aGVybWFsX21vbml0b3ImXVtUaGVybWFsL1RaL0NQVV10c2NwdV91bmJpbmQg
dW5iaW5kaW5nIE9LDQogICAgIFsgNDEwNi40MDQyMjVdW1Q2MDA5MjJdIG10a1Bvd2VyTXNnSGRs
OltuYW1lOnRoZXJtYWxfbW9uaXRvciZdW1RoZXJtYWwvVFovQ1BVXXRzY3B1X3VuYmluZCB1bmJp
bmRpbmcgT0sNCiAgICAgWyA0MTA2LjQwNDUwNF1bVDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6W25h
bWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVddHNjcHVfYmluZCBiaW5kaW5nIE9L
LCAwDQogICAgIFsgNDEwNi40MDQ1NDVdW1Q2MDA5MjJdIG10a1Bvd2VyTXNnSGRsOltuYW1lOnRo
ZXJtYWxfbW9uaXRvciZdW1RoZXJtYWwvVFovQ1BVXXRzY3B1X2JpbmQgYmluZGluZyBPSywgMg0K
ICAgICBbIDQxMDYuNDA0NTY2XVtUNjAwOTIyXSBtdGtQb3dlck1zZ0hkbDpbbmFtZTp0aGVybWFs
X21vbml0b3ImXVtUaGVybWFsL1RaL0NQVV10c2NwdV9iaW5kIGJpbmRpbmcgT0ssIDENCg0KICA2
LiB0aGVybWFsX3BtX25vdGlmeSB0cmlnZ2VyIEtFKGFuZHJvaWQgdGltZTogIDIwMjMtMTAtMjAg
MjI6MTM6NTkuMzE1ODk0KQ0KICAgICBbIDQxMDYuNDM3MTcxXVtUMjA5Mzg3XSBiaW5kZXI6NTM0
XzI6IFtuYW1lOm1yZHVtcCZdS2VybmVsIE9mZnNldDoweDI4OWNjODAwMDAgZnJvbSAweGZmZmZm
ZmMwMDgwMDAwMDANCiAgICAgWyA0MTA2LjQzNzE4Ml1bVDIwOTM4N10gYmluZGVyOjUzNF8yOiBb
bmFtZTptcmR1bXAmXVBIWVNfT0ZGU0VUOjB4NDAwMDAwMDANCiAgICAgWyA0MTA2LjQzNzE5MV1b
VDIwOTM4N10gYmluZGVyOjUzNF8yOiBbbmFtZTptcmR1bXAmXXBzdGF0ZTogODA0MDAwMDUoTnpj
diBkYWlmICtQQU4gLVVBTykNCiAgICAgWyA0MTA2LjQzNzIwNF1bVDIwOTM4N10gYmluZGVyOjUz
NF8yOiBbbmFtZTptcmR1bXAmXXBjIDpbMHhmZmZmZmZlOGE2Njg4MjAwXSBtdXRleF9sb2NrKzB4
MzQvMHgxODQNCiAgICAgWyA0MTA2LjQzNzIxNF1bVDIwOTM4N10gYmluZGVyOjUzNF8yOiBbbmFt
ZTptcmR1bXAmXWxyIDpbMHhmZmZmZmZlOGE1Y2U2NmJjXSB0aGVybWFsX3BtX25vdGlmeSsweGQ0
LzB4MjZjDQogICAgIFsgNDEwNi40MzcyMjBdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6
bXJkdW1wJl1zcCA6ZmZmZmZmYzAxYmFiM2FlMA0KICAgICBbIDQxMDYuNDM3MjI2XVtUMjA5Mzg3
XSBiaW5kZXI6NTM0XzI6IFtuYW1lOm1yZHVtcCZdeDI5OmZmZmZmZmMwMWJhYjNhZjAgeDI4OiAw
MDAwMDAwMDAwMDAwMDAxDQoNClNpZ25lZC1vZmYtYnk6IFl1Z2FuZyBXYW5nIDx5dWdhbmcud2Fu
Z0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBCbyBZZSA8Ym8ueWVAbWVkaWF0ZWsuY29t
Pg0KLS0tDQpDaGFuZ2UgaW4gdjI6DQotcmVtb3ZlIFN1YmplY3QgZnJvbSB0aXRsZQ0KLWFkZCBt
ZXNzYWdlIGZvciByZXZpZXdlcnMnIGNvbW1lbnQNCg0KQ2hhbmdlIGluIHYzOg0KLXJlbW92ZSAi
cG90ZW50aWFsIiB3b3JkIGZyb20gdGl0bGUNCi1hZGQgbW9yZSBkZXRhaWwgb24gaXNzdWUNCg0K
Q2hhbmdlIGluIHY0Og0KLXJlbW92ZSBDaGFuZ2UtSWQNCi0tLQ0KIGRyaXZlcnMvdGhlcm1hbC90
aGVybWFsX2NvcmUuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgYi9kcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9jb3JlLmMgaW5kZXggOWMxN2QzNWNjYmJkLi43M2Q2YjgyMGM4YjUgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCisrKyBiL2RyaXZlcnMv
dGhlcm1hbC90aGVybWFsX2NvcmUuYw0KQEAgLTE1MjAsMTIgKzE1MjAsMTQgQEAgc3RhdGljIGlu
dCB0aGVybWFsX3BtX25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KIAljYXNlIFBN
X1BPU1RfSElCRVJOQVRJT046DQogCWNhc2UgUE1fUE9TVF9SRVNUT1JFOg0KIAljYXNlIFBNX1BP
U1RfU1VTUEVORDoNCisJCW11dGV4X2xvY2soJnRoZXJtYWxfbGlzdF9sb2NrKTsNCiAJCWF0b21p
Y19zZXQoJmluX3N1c3BlbmQsIDApOw0KIAkJbGlzdF9mb3JfZWFjaF9lbnRyeSh0eiwgJnRoZXJt
YWxfdHpfbGlzdCwgbm9kZSkgew0KIAkJCXRoZXJtYWxfem9uZV9kZXZpY2VfaW5pdCh0eik7DQog
CQkJdGhlcm1hbF96b25lX2RldmljZV91cGRhdGUodHosDQogCQkJCQkJICAgVEhFUk1BTF9FVkVO
VF9VTlNQRUNJRklFRCk7DQogCQl9DQorCQltdXRleF91bmxvY2soJnRoZXJtYWxfbGlzdF9sb2Nr
KTsNCiAJCWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJYnJlYWs7DQotLQ0KMi4xNy4wDQoNCg==


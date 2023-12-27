Return-Path: <linux-kernel+bounces-11884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87581ECEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3806B1F22E00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01963D7;
	Wed, 27 Dec 2023 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mh0cCOYL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SsTVt904"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E453AC;
	Wed, 27 Dec 2023 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0fafb1e4a48911ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tg0RvvQxOKJpYJJSi7zHXcg8Bz3cxelAKxWWJBEWxRY=;
	b=mh0cCOYLgxpDLSwhvrwVcyMXmckL73ef+nApoOmxPJ2CUA43I7nrlZmcdtBxNZhk5TFWxqpnDecbUKUqIP87ysQ1d4bEEobHBKOebo6V1UFZrFd4wtJYxYO3AJo7mcDM5M8Y8igg8BuHQW0iXmwimZbaR2OlM7DdlEtWTRnpNmU=;
X-CID-CACHE: Type:Local,Time:202312271520+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c3533c9a-30e3-47f9-a1c4-ea80ba3e52da,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:df279e8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0fafb1e4a48911ee9e680517dc993faa-20231227
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 173899309; Wed, 27 Dec 2023 15:25:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 15:25:06 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 15:25:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv0B1batxpM2WKS5qKjAAbqpzgkQckBDWJAZvMzTOyG7TK6krMhGQzV1huVzN7L9/f42hB5oLWR+ODjIdkxQd/5ucAPY54Pk0Y6O7Tnkbpp9NSxiUaaqBVQSq8FPMg4Fcs4Moe5RrG1BLs+pmUIXjHTrzbHIXHegZ5o7R0435TOqBgEwQrOsE4VjiTjXiEcodrz35uRC9T5KoAkFn6JKYhnUnplieFKbmo77qOm6UR9KXM939P9jmQgj89msJZSGMwZnFirFsr6eRW17CYYcEnFMoyZnKAvX54bqTVc2Lva2MxRzsxmD6/+akOuwtJcwQRT4vXoHsOyc6eKJ/JVU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg0RvvQxOKJpYJJSi7zHXcg8Bz3cxelAKxWWJBEWxRY=;
 b=EdrWrdi0v5MUOKyMEfVY9j33z5Cn5b2PBfYguQYYN3VQsg94+Z++1iLUy2BMeuZEIcL7n3vSpLc15Y0eBvagM9OKYymYoHd5iO+DCgcxXrDi20SpS7KXcXoUI9WKfwPB2yinRwBgp5rcZbf+PXEjTE4yjfI4LRxlcoWP1Lk7Gn9Sj9FmjnmVfQ3Nw92QIjfRyTzgf/PUho7T3POGLZT7Bce+czFLdCc9bXstjGVKRDtSgNiU4WH+aAAb0v5lTup7GIG+gQFd6Kap/bQVVHSXCQOfrX3fETCYj5wLNDyRhvl1L44FbwcD/6gcXnhPVXabTcnZy4uLmcyAsXTb0Y/VSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg0RvvQxOKJpYJJSi7zHXcg8Bz3cxelAKxWWJBEWxRY=;
 b=SsTVt904QAlCPwOCSu5/FRTPEYTv7BNLKkEC7ZU7gejI21w67fcQ+vNYBUahXKKHi7JSn16QWW7I8WjJIRnnjWJvdbhL934AxDdlIL25VQoZIqKpEHOMYvRolr//fcqfSQpxYRJMdAcAzuRMIKlCA/ZZkJmOiHty1vMCSWYNfXI=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5325.apcprd03.prod.outlook.com (2603:1096:400:8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 07:25:03 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 07:25:03 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7SlCAgAF4JgA=
Date: Wed, 27 Dec 2023 07:25:02 +0000
Message-ID: <83db5f669a6404ba3bf65ecd7b024af2509c19dc.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <f338215fb8f7ff1e0ebeb0f1e21a8b4dec5f0c61.camel@mediatek.com>
In-Reply-To: <f338215fb8f7ff1e0ebeb0f1e21a8b4dec5f0c61.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5325:EE_
x-ms-office365-filtering-correlation-id: f03103cb-613d-4337-8097-08dc06acf12e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3JxYbEYltvAN89J80OHT3J6Bgjo3b+rN/09xVE0B0wg1lEvRvv3lmSfCFw2TE6Ulksu+HOTeyPoEqUXuqqyMwC46y5axNNhwwNIeEwcPhziLR5nBwKZ2fLaBKjG0P3DI645FauWuQMhU7qwkA8A4K7sFow4KjED88KPfXA4m3BJ0AePOcOaH/5gU/I0aXf4Rr3kVuctyIDFvHAUNizGMQr1d0574bJBt08573VfSVm05Lxee5RmnvA1ZOt+UeGnIqfebE829EzDA3x9AXhvTYYEMTVSwt1kfpBWZSFG5wzQBNVjSksAZB6emQF/ZfXJb3svUN6tfDOK9E1GDpZAhkkXYpRSAA/yfxUKsxk1relzGXXskBqerzSfoOKTMrzQxJS0d6gz/QYsUDDbcRCeQBxgO6u2FHVM3euZA0MJHJws28B14YQ7Y6aMXKAffYN0dbeNUCRWeZY3EazGdKOWqharx957sU7nG5IEH9bOpDB7Blk7pro7OiNNTW9qqr1et6NhYmIeUitygS+1YvrERjKKceu+WTTBmbfs5I1HgSgeTgrmvsA86CCi6BQEA5p/wKEQ8hhPRX3qb76spBP9DTJc0tzJTfgz9OMzEgC58yxWDuJfMLQxuB0jM/aZAQdEtxddxl4gESp6rsJN1q6l/GyYR/QXpMbUDUp4XRycdDSA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(6486002)(7416002)(478600001)(71200400001)(15650500001)(110136005)(91956017)(4001150100001)(6512007)(6506007)(2616005)(2906002)(316002)(64756008)(76116006)(66446008)(66946007)(54906003)(66476007)(66556008)(8936002)(8676002)(4326008)(26005)(41300700001)(83380400001)(38100700002)(122000001)(85182001)(36756003)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGMzbUwvN2w5NGhyZ1ZzMVVuNDdBMzFqWVFlT3A0TzRqVndrMHFnMUpVZEE2?=
 =?utf-8?B?S3FzK1FqZHdtN09NaGJmRG5BaUV2OVVkWkE1WUVieDBGdzhyQnAySHlqYVFj?=
 =?utf-8?B?RXc2aVpPNFZKNzIwa2tJTXlZbWJxVVp0ZGEyeUNjd2hISlZKQll3UVJsTmZt?=
 =?utf-8?B?VlVwZzBkTCtvR21MNmx4Q29PRUtVblVIZ01GWFpRWXAxbjZOOG1vZ2EyZEg2?=
 =?utf-8?B?MzZ2cjIvT203V0U1R09PWjBUM1hVYjJZUmRyb1FsbElkRHluTFpiV2plejdl?=
 =?utf-8?B?Mk5IZC9tbXRaQmt5UExhb1YwZWh1TG9XUG5pOFJRNDZ3M28xWERPNmFnVW5v?=
 =?utf-8?B?Z2M0bmNCaHZoTUFSTE5SRjR1aWRRbm9xc0hqR3BRV1BOODNlUHBRUUxxVmNW?=
 =?utf-8?B?RjdmdVBlV0lLV0xoTGtUYitPUDNGRkM3OGx6V2VWQ1Jmd0VZZWNUM3M1QmtQ?=
 =?utf-8?B?YnJBa2ZiaG9VM2pnWUt4Slhwd1VtalIxYmxkaWpFaEVxeC9pMXZmU29UdTA5?=
 =?utf-8?B?NkRiUUQ1aW83VU9MM28zbHdQYjdnWFVmdFpCTFRmV0Q5dCt6S1ljMjNBNTJJ?=
 =?utf-8?B?YUQ4enNMbGxoZWlVSldNb0FFU1h0YmFyNTUyMHRVVlh1QXhIcFFac2xKZ25E?=
 =?utf-8?B?RE1zNnVLWGlKd0JEWWl5MUNVVGVVKzJKejVDMHg2aFpzVFJlWmJXYVNHVnZs?=
 =?utf-8?B?SkNNL0NxMmxxdXhxMzkxSy9hUkJ0ZnhWbHdjMDQ3c0hzLzExODhoK2N3cTFV?=
 =?utf-8?B?aHFCMHA2TDMzM1BsSjlvakpUQmozNU9qOXV0WFRLWHdaZUNJMS9TN0NoMlpV?=
 =?utf-8?B?Y2EvNEtKSkl0S1RnUlBaeCtVeWFOcUI3L0RSQmlkUDVUMjBiQi93WVBBVE9t?=
 =?utf-8?B?RGVoVVk3ekdYQWU2RGR2aTJRTVc4bFI5QlFkN0dRVHdyTDFIc0tkV25vN1c2?=
 =?utf-8?B?d3l1RTkxQ3VidUE5MmZlSTBmZzYwTW1IVTk3S1EyNHBRc29oVXJHT0tNSHh5?=
 =?utf-8?B?WEl6ZnM3MFFOaFpKVU1jMHI2bzkrM1ljdHpMTk9aUEZmV1ZmWWJTT2ZBMHNP?=
 =?utf-8?B?Y043RTF2ZnhzWU44b1YzWmd1aVBvWnNOSGI5UXZOaFRJL1pRNDY1YVY4K1p6?=
 =?utf-8?B?eldueFV1RTlzYWJVTFE0a3pSNWkxUjUvQnVuMExXeXFmdnBQV2xSVEcxRmRK?=
 =?utf-8?B?WXFHcDlrSzZxRGc0eVZSWWh5VllPRG1YWTZHQXFvcDNZY0wwYzJFcmVsTzc5?=
 =?utf-8?B?Q29Fbm9yYlJqaGRxUzc4UXl4VGVBck5KVlRRdDE5ZkFnR1VvV1N2YUZuY2x5?=
 =?utf-8?B?dGRqd0dBNDRPeThXRmVCc20rdyt0cHBCZW1MM0txWVBCRVE5UzFBaS9QcEdZ?=
 =?utf-8?B?aWhUSXpFblZRbzZ3MThRVTNINFFWcHJrMDhzRzhuOG1WbGh6ZGIrSE1RQ1hN?=
 =?utf-8?B?elBpZDhxdFFPaTM3N2V5UVdPNTREU3BadENKRjJFZ241cWJlMzAyYk1HdzlP?=
 =?utf-8?B?MW1SZWxiQTl0NVIyUXBKZzR2M1FuNFhWZmNPb1RjSHhxVWcreHltSmdzZ25n?=
 =?utf-8?B?SlFLbWgvdFk0OFZiR2ZhSVdZdDVVN0VJWFdQQW15N05zMmI1OU9UdDgxNUVh?=
 =?utf-8?B?MXNTL0hSVDNTbERGTWdEcTkwWjYydTc0aW9iNDc5MFVveTJjM3hucHAyQkdK?=
 =?utf-8?B?elB2eE52TjlyZ01BK0c5VGV5S0RxbmkwQks5MHFQTGxkc1dmaWpjNzB2NnpS?=
 =?utf-8?B?dUNCRnM5NFZORWNmMG85ZFMvaUp0WmxIY0dLZTJDMDRqUEpKR1drallkVDVp?=
 =?utf-8?B?d20zUURXRjVBRVMvSlVvbzRtTnhuWXNXN0JlWXN4Q0tYbHFGZTZMTHdFM2gw?=
 =?utf-8?B?MEEvYzMyUVUraHMyU3BWZWR3em1URHBLQlU4TVc0UVhqUkZjdlgrRnlMQlBk?=
 =?utf-8?B?M3pXVTBVR3NvTkNwZzh4RlhjMXRuSWkwMjJobWJlVEJUd3Z0dzl3RUkwaW0y?=
 =?utf-8?B?NDJteFA5MjVRb1dYRlZ4N1lDbDNoR1lHTlpGY1I2VzllbGdvUVlFZk9zeGxw?=
 =?utf-8?B?c2s4cXAzK1RpNUNTaDZzYmVsNVhsMGdKZHpLVHlFTFVTdDFvTnJOWmRHaC81?=
 =?utf-8?B?bnI3Yy8yck8zNjFnTWoxdmtWeFlma3c3eGpUN3VrZ2xhcWttM0hNbnZvc2hE?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38BBBCC35A2D5E458F77C61DD6757CDB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03103cb-613d-4337-8097-08dc06acf12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 07:25:02.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yc5vn62KjbEr2chmru21HjwiZfJpeoeevrxmu/P8Csl0cKJ+Fdz76JoZuxgQRPfRPiGKySDm5FRHJJq3/+q2Z97GK0ftwjdw6lbNHjMLYKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5325
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.451500-8.000000
X-TMASE-MatchedRID: csPTYAMX1+GnykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinvypf
	0VJZhlxP3gb7k6xpVN4a/3L93pcprQTsy5Ctk/ajdAg4yd14qAQxmbT6wQT2a/t592eq2xoTHye
	T8VIiNb6ykaH8ZceX1bWrjxGHjCv1l7ynh5jrXh9PuMJi/ZAk8eWNJG9IamrcFLXUWU5hGiEzvr
	CMQwONioyAiJOwVYBgkZOl7WKIImrS77Co4bNJXVZ0V5tYhzdWxEHRux+uk8jpP8tMOyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.451500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6E09E7492B00447B4CF8611DF26F4A980F6231857BCA2E6620624935A7DDECE72000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwODo1OCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0xMi0yMiBhdCAxMjo1MiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZpZGVvIHBhdGggZmVhdHVyZSwgR0NFIGhhdmUgdG8g
cmVhZC93cml0ZQ0KPiA+IHJlZ2lzdGdlcnMNCj4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ug
d2lsbCBlbmFibGUgdGhlIHNlY3VyZSBhY2Nlc3MgcGVybWlzc2lvbg0KPiA+IHRvDQo+ID4gdGhl
DQo+ID4gSFcgd2hvIHdhbnRzIHRvIGFjY2VzcyB0aGUgc2VjdXJlIGNvbnRlbnQgYnVmZmVyLg0K
PiA+IA0KPiA+IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xp
ZW50IHVzZXIgaXMgYWJsZSB0bw0KPiA+IHNlbmRpbmcgdGhlaXIgSFcgc2V0dGluZ3MgdG8gdGhl
IHNlY3VyZSB3b3JsZC4gU28gdGhhdCBHQ0UgY2FuDQo+ID4gZXhlY3V0ZQ0KPiA+IGFsbCBpbnN0
cnVjdGlvbnMgdG8gY29uZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIGludCBjbWRxX3Nl
Y19maWxsX2l3Y19tc2coc3RydWN0IGNtZHFfc2VjX2NvbnRleHQgKmNvbnRleHQsDQo+ID4gKwkJ
CQkgc3RydWN0IGNtZHFfc2VjX3Rhc2sgKnNlY190YXNrLCB1MzINCj4gPiB0aHJkX2lkeCkNCj4g
PiArew0KPiA+ICsJc3RydWN0IGl3Y19jbWRxX21lc3NhZ2VfdCAqaXdjX21zZyA9IE5VTEw7DQo+
ID4gKwlzdHJ1Y3QgY21kcV9zZWNfZGF0YSAqZGF0YSA9IChzdHJ1Y3QgY21kcV9zZWNfZGF0YSAq
KXNlY190YXNrLQ0KPiA+ID4gdGFzay5wa3QtPnNlY19kYXRhOw0KPiA+IA0KPiA+ICsJdTMyIHNp
emUgPSAwLCBvZmZzZXQgPSAwLCAqaW5zdHI7DQo+ID4gKw0KPiA+ICsJaXdjX21zZyA9IChzdHJ1
Y3QgaXdjX2NtZHFfbWVzc2FnZV90ICopY29udGV4dC0+aXdjX21zZzsNCj4gPiArDQo+ID4gKwlp
ZiAoc2VjX3Rhc2stPnRhc2sucGt0LT5jbWRfYnVmX3NpemUgKyA0ICogQ01EUV9JTlNUX1NJWkUg
Pg0KPiA+IENNRFFfVFpfQ01EX0JMT0NLX1NJWkUpIHsNCj4gPiArCQlwcl9lcnIoInNlY190YXNr
OiVwIHNpemU6JXp1ID4gJXUiLA0KPiA+ICsJCSAgICAgICBzZWNfdGFzaywgc2VjX3Rhc2stPnRh
c2sucGt0LT5jbWRfYnVmX3NpemUsDQo+ID4gQ01EUV9UWl9DTURfQkxPQ0tfU0laRSk7DQo+ID4g
KwkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHRocmRfaWR4ID09
IENNRFFfSU5WQUxJRF9USFJFQUQpIHsNCj4gPiArCQlpd2NfbXNnLT5jb21tYW5kLmNtZF9zaXpl
ID0gMDsNCj4gPiArCQlpd2NfbXNnLT5jb21tYW5kLm1ldGFkYXRhLmFkZHJfbGlzdF9sZW5ndGgg
PSAwOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWl3Y19t
c2ctPmNvbW1hbmQudGhyZWFkID0gdGhyZF9pZHg7DQo+ID4gKwlpd2NfbXNnLT5jb21tYW5kLnNj
ZW5hcmlvID0gc2VjX3Rhc2stPnNjZW5hcmlvOw0KPiA+ICsJaXdjX21zZy0+Y29tbWFuZC5lbmdf
ZmxhZyA9IHNlY190YXNrLT5lbmdpbmVfZmxhZzsNCj4gPiArCXNpemUgPSBzZWNfdGFzay0+dGFz
ay5wa3QtPmNtZF9idWZfc2l6ZTsNCj4gPiArCW1lbWNweShpd2NfbXNnLT5jb21tYW5kLnZhX2Jh
c2UgKyBvZmZzZXQsIHNlY190YXNrLT50YXNrLnBrdC0NCj4gPiA+IHZhX2Jhc2UsIHNpemUpOw0K
PiANCj4gSSB0aGluayBpdCdzIG5vdCBuZWNlc3NhcnkgdG8gY29weSBmcm9tIG5vcm1hbCBjb21t
YW5kIGJ1ZmZlciB0bw0KPiBub3JtYWwNCj4gY29tbWFuZCBidWZmZXIuIEp1c3QNCj4gDQo+IGl3
Y19tc2ctPmNvbW1hbmQudmFfYmFzZSA9IHNlY190YXNrLT50YXNrLnBrdC0+dmFfYmFzZTsNCj4g
DQo+IFlvdSBoYXZlIGEgc2VjdXJlIGNvbW1hbmQgYnVmZmVyIGZvciBzZWN1cmUgZ2NlIHRvIGV4
ZWN1dGUgY29tbWFuZC4NCj4gSWYNCj4geW91IHdhbnQgdG8gbW9kaWZ5IGNvbW1hbmQgYnVmZmVy
LCBjb3B5IGZyb20gbm9ybWFsIGNvbW1hbmQgYnVmZmVyIHRvDQo+IHNlY3VyZSBjb21tYW5kIGJ1
ZmZlciwgYW5kIG1vZGlmeSB0aGUgc2VjdXJlIGNvbW1hbmQgYnVmZmVyLg0KPiANCj4gUmVnYXJk
cywNCj4gQ0sNCj4gDQo+IA0KDQpJIHRoaW5rIHNlY3VyZSB3b3JsZCB3b24ndCByZWNvZ25pemUg
bm9ybWFsIHdvcmxkJ3MgdmEsIHNvIHdlIG5lZSB0bw0KY29weSB0byBpd2NfbXNnLT5jb21tYW5k
LnZhX2Jhc2UsIHdoaWNoIGlzIGEgd29ybGQgc2hhcmUgbWVtb3J5IGZpcnN0Lg0KDQpSZWdhcmRz
LA0KSmFzb24tSkguTGluDQo=


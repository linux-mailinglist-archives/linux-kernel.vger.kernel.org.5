Return-Path: <linux-kernel+bounces-501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68293814209
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB86283059
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38DD2E2;
	Fri, 15 Dec 2023 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HG84wADK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="M6rblDiW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374AD27A;
	Fri, 15 Dec 2023 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6a396a409b1711eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n99wWz7aw1Y7WRb3Pr9HA9O9FsSNnMR468RCxOw7ndI=;
	b=HG84wADKPz2bQzEKD7F6lvHfVyxDt5w8D/beDWvdwH6Xer8qYSxfza/aM7x+YyaxwWnugOkjBWCyH+ZgJT2TC5BnhMuymoRtZtdxfvUC3lgmNOoF3eTLnXuGXlwUs+UDQE/7d1JqffVR1xiTw8kDe0JvXoNtNPdjGEJ82czz6os=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1dc2adb7-2443-47d8-9c9c-4257ba62987a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:acb0d273-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6a396a409b1711eea5db2bebc7c28f94-20231215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1703063808; Fri, 15 Dec 2023 14:58:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 14:58:55 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 14:58:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSA6u9ZUTS0xKrjMeG8rWKUMd6MBQZYP2zeTDJwJbZaI0Q4c82aNoOMYFvh9pWMDkTBox4A18BoT+VwJ/gefarxeLmJLUvzVgBPDdTvZbgRDIvL7cx0V289HJ7JYZyrheyqbnn8eIUzLgyOA+9agL82Xr4IlJiT6XRsPoDO5EwHXdcCyCmb1FKjFdGx/qg10LW4VI0j+6Iocia+lldzWR5Q4QsozPqNYplQbOtm0vBp5yc+2fHZvvIRu3tgyOAxBO+QHj1NftrT/TT07+y6ybO6NO7vabUIrTraUuybTi+t5X6K7KazGl5NX9lQcH9x8uCLF8XgyclFBDGeGmIxkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n99wWz7aw1Y7WRb3Pr9HA9O9FsSNnMR468RCxOw7ndI=;
 b=A/zM4BepJSdnDcpqhStJ3fPsFbzIkicdwUw2ze45ln9n3ITtvKoJIht8emAk3ZRMJoxAmR/UhYfDJxmg2yEwh8SrAXluEbz835xz6qzhWG/vpITwCaKZyTgHTLSSbOwVihpYC5Wp0z0Xy13uwIIbhDVERjaE1Jw8WSvJa9zd1LpdFc26k4YrA98X9aCvxgyj2wz9QzOu2OWX/V2HCX5T7qxkr0OZtLzcnfaMHdz+8b9x4Q2rtIZh4QpXICs28b+ke8f61s6VE/30xj/L9812uPhB3s6kIyPv2j7jeE/GNNCiemobWrt9o/yskwDph55Lw+9vXx1v7cq1qF8nENUY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n99wWz7aw1Y7WRb3Pr9HA9O9FsSNnMR468RCxOw7ndI=;
 b=M6rblDiWTFZCPqDK8jX3+VOQJ51NZ4smxq7tvJkGsshEu3+sVtn/jqKlmC8WyqsqUqzOjRaOEHBkpVkpojodyzRY66cQRk7j7TySPOTGCI57nfzYVKYbLj4V31p2D8aQeMP4GxmT4MRJrVpp5P6jzOFhdaMkyn7qULMpmpGCMA8=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by KL1PR03MB8494.apcprd03.prod.outlook.com (2603:1096:820:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 06:58:53 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 06:58:52 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "quic_mnaresh@quicinc.com"
	<quic_mnaresh@quicinc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>, "avri.altman@wdc.com"
	<avri.altman@wdc.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "chu.stanley@gmail.com"
	<chu.stanley@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "quic_cang@quicinc.com"
	<quic_cang@quicinc.com>
Subject: Re: [PATCH V5 1/2] ufs: core: Add CPU latency QoS support for ufs
 driver
Thread-Topic: [PATCH V5 1/2] ufs: core: Add CPU latency QoS support for ufs
 driver
Thread-Index: AQHaLcI1w8G7jkYAwUG7iV1bQdiC47Cp7M2A
Date: Fri, 15 Dec 2023 06:58:52 +0000
Message-ID: <c00aeb47c67599d632cced1017696cf1295d83ea.camel@mediatek.com>
References: <20231213124353.16407-1-quic_mnaresh@quicinc.com>
	 <20231213124353.16407-2-quic_mnaresh@quicinc.com>
In-Reply-To: <20231213124353.16407-2-quic_mnaresh@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|KL1PR03MB8494:EE_
x-ms-office365-filtering-correlation-id: 63f87ed9-1424-447e-400a-08dbfd3b4c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8kKTvyI6RJyNEwBPtgKLAwqtTOwo1qJC6IXHn0gKsJiHGFbn0dxyh8gIC6WnnSuoVGuwjrgWD/c3l3SlOIcx2iltUV0qRlWJh5BjmNeiuH/zqrwSZZ7x9fhWwb222iIvW/F1M7kMdZ3YO1yWPM/7Q1D6v2Q/MnMqPCcN4t9E0XfW1WeAePEuthWSSijFOXDNjNIpjpzDv0sWZBgjumRHYw3ZBbpBJGrUblvhzcfOi7chT/gJd8gFIFTHG+msFVx09Lafvf3mftKckT3IREvAuNhK4+/Sg54JOriqrj+Orb6oPuUIVybP7EqXfAIOCTlTGqQeylUXoSS8qT80qWOTwjdWQnshcb1SgZINF0KcbNSI9zuSnog2U0OeBmzibRljcxksUoJysQ0zZzJEpX8s4gZQx8TFPHIMLjfi3cUiTZUjKBsaFHVF25DvSI5FFkc1siarYKhZQXNOq2PhqewasYPsvnrX2uFunJssUxa/2ttmC/SO5MgBEtz1uD5O3mYVc+UzsZZOurZghU0FP7T2G4Y40rIMdn3Xy1MrjuT2P1rwUkx+ITjhb9iQQDzgqBwVKOpDE0KE1dU6UitBELCKnSn7u1kan0zTg9P3kzFBmunAemCCmXzpmToHxCQVlGq0Cw4TNEoEyUz80AgFpYZx79nrxsdUluymXrMs4rvitwASqCcQO9OuXwIS7kbhfc4wKAjsCet9mIKaPy7q5cs4Li9BE/luNUh34YdsSYUpEY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(2616005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(7416002)(4326008)(41300700001)(4001150100001)(2906002)(478600001)(6486002)(8676002)(8936002)(76116006)(110136005)(91956017)(66946007)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(85182001)(36756003)(86362001)(122000001)(38100700002)(38070700009)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STBGM2xVdGw4TERvMzE2YVZWUkhaTjU1OGNRdHMxOE42dVZMSnhTWDRiTXdn?=
 =?utf-8?B?cjBoK2g0M3dITG5NSk84c3pCdDhqSHBITmpuaC9sNUhxbE5xWlNIWkZhVlhj?=
 =?utf-8?B?ZE04d0VUM3Q2WGhNLy9MU1llTVY2TENabnRrLzRoZzk3cmdXTXpKcm5XbGh5?=
 =?utf-8?B?czc5VGo4UlgvVkhaVFJRZ1cxNXFMMXF1ZkpEYjVTNHJjbWJyeHM1WjBiMmJx?=
 =?utf-8?B?MFgrMnNFaEFBa2lPN25jRkJYNUpYL3IwcHRhSTV4eDhRRFlEa25BVUo1Vk1q?=
 =?utf-8?B?S1RyQVdya2lGY1RuRytqaFB1VzFUMlFHWXJSb1pxK2FGcGlKdDNiMXhKaUEr?=
 =?utf-8?B?RHgzRTVFaWZBNzdpSFFYWFFESHVqL3ZBWXFjTmozZDZUc2ZMZHJWdncvTWRC?=
 =?utf-8?B?RTJ1RUdIWHFjYUZhK3VrSmVTdUFaa0VhemhSNFh4TWJZZzZ0bHF1T3JubjR3?=
 =?utf-8?B?aVh2TWV5bWdiT3Yxb3l1NlhDNmplbnpoY2ZBOVYzZkFFVWp5NzlYRzJEdGNa?=
 =?utf-8?B?d242Z3l1UE91RDJLQW1KYzlFNDZYTGFvUENwTTJWcUdrK1p0RHNjRGQxSklV?=
 =?utf-8?B?NWIrZURFZUJpWG80aUJwWnFab2pSeVk5bHRuQW1IVEVqWE1wVFd6cWt5Z3Q2?=
 =?utf-8?B?bDkzUUFjckl1RkxNSWNKdGhQOSsxTCthWlQ3ZWNkb0szU0ZGWU1aNUxuQ1p6?=
 =?utf-8?B?UkZ3WUdWV0ZkRW1VMUxOODlUcHRWRWo0SWVmcE9zd01xQWl3U21FMEpKUC93?=
 =?utf-8?B?eENhdzJ2eHBuVkUzVU5mVnVaeVRTdUF5ckhBeTdKak9ZUzNGbzFtaXZrNVJD?=
 =?utf-8?B?T3ZTNnhlQVczSXp4dmxqS29TYkJ6TE9JMVVCMEVwNThrMDlMRDNtcDR2SEpW?=
 =?utf-8?B?bHU0bmVJbVNMczZCQTdFeXN4VUNoWTlhM2YrNHdWQTRlNE01ZzNwT3RSZ1Qy?=
 =?utf-8?B?Sk5sL3FUbHlybkh4Z0REQnByV0g2ckphamErU2RpMnNLNnQzMUlUWTdqTVhy?=
 =?utf-8?B?QmMvM2ROaDZxWDdOblV6Zk8xelpOSXJqVUhzSzdiZUhkZlExNFczR1A4bDZz?=
 =?utf-8?B?WEpTMmJ0U2lXZjJwMWlNdzRjT3B3SVJHVlBUazE1eDE4aWFNM2VMYWtIaUpU?=
 =?utf-8?B?aHdQRS9WVUgrWkg0RVE3YVl0L0dycytWTUhpT0VHS1NBSGZvajBQcHlmcC9p?=
 =?utf-8?B?QmpiN3F6cG9iUGc3QkFvQXFvbU51TDBRTjE2aVl1ejk3QVpEWS9CRmZZT2cv?=
 =?utf-8?B?THRhbHVHZWhGSXpFc0NWZE8vTzNKRWdwQ0c3QURnb1VSYjJqTFhlY0JBZ0NT?=
 =?utf-8?B?Z3RKZVBRY0pLM0EvOUlzSTJvdlF6anBzc1ZMeUhPMk1Gb2k0NE50M3pWZHho?=
 =?utf-8?B?bkFMWG10djNVS04xZk4rUS8rK21XSFN1dW9Fd2dQWDk0dWNQL3d2d3VUemp0?=
 =?utf-8?B?TDU0T0tsVG02SzBrMnZHcG9JVW1tQmdqZ2VxZCtBek1McjhMdGZ6eTV2bmhq?=
 =?utf-8?B?cDhWRHNSNXBlUHJ0VXhTWUJUWGdIMC8vY2pFMmpaOURwOUhabGVyZWxPVjdn?=
 =?utf-8?B?STRJVG5zaDFaNXR1Ry9neVMzZ1h1K2hjZkg0TVpIRmUyN1ZZTlFHb1MzRjlY?=
 =?utf-8?B?Rm5rTEJENlBDWlRySDByQlNBSXoydVhqUFFvVHg3TGk1RkoxbFBUZWZYNk1h?=
 =?utf-8?B?azNNQjNKM24wOFRnUXR6UXNiN0t1TlV3cUZWR3BreWx1ckpNTlVrRUd2THM5?=
 =?utf-8?B?Z056ZFU0S0h6K2RMb3VkdUROM2hNRlZwL1dUbEw5c0g0dHZqZWhvT2FKS0k3?=
 =?utf-8?B?a20xQnBaQ05TRXQyekNyV0VYeHVUYVgyQzNUSFNvRlcxR0VNdm1ycmk5STRB?=
 =?utf-8?B?Zy9iY3J6MkNsWHZ6NUFIaE5ycUJaWXY0SFpnbk1vR0VFdVZaMzViQURRWnRG?=
 =?utf-8?B?bStQekduVjRxR1pTaElqTUx5MFNhQ1hOQ1Jrb0JNdld3RlYrQ2dQNXNCRldJ?=
 =?utf-8?B?c0duNUFnVDhIYzBvbFFKQnJWYUR2VlJVL1hkbklEcWpZSmxVMGwrc2xqaEtD?=
 =?utf-8?B?dXZ5akgvYUJObnY5VFVzenN3TDAvSXArUm9FNVFYbkFMMGt6MVBtWEFXVm1R?=
 =?utf-8?B?TUU5M0FpY1p1NTB1VDVSd2lJV3B6Z1V5MGdMZmVHRDMzRG1jMzJyd2tkbWVG?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FDC239484B9684AA67A98116E5984C0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f87ed9-1424-447e-400a-08dbfd3b4c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:58:52.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sde06PEABPFGq2VaBy5KDw37/vlov5qnw3S8mG0TapckXKJXrXhFm1k8bvngchUl5IxtKYU4k+QXkY2YzOUX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8494
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDE4OjEzICswNTMwLCBNYXJhbWFpbmEgTmFyZXNoIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIFJlZ2lzdGVyIHVmcyBkcml2ZXIgdG8gQ1BVIGxhdGVuY3kgUE0g
UW9TIGZyYW1ld29yayB0byBpbXByb3ZlDQo+IHVmcyBkZXZpY2UgcmFuZG9tIGlvIHBlcmZvcm1h
bmNlLg0KPiANCj4gUE0gUW9TIGluaXRpYWxpemF0aW9uIHdpbGwgaW5zZXJ0IG5ldyBRb1MgcmVx
dWVzdCBpbnRvIHRoZSBDUFUNCj4gbGF0ZW5jeSBRb1MgbGlzdCB3aXRoIHRoZSBtYXhpbXVtIGxh
dGVuY3kgUE1fUU9TX0RFRkFVTFRfVkFMVUUNCj4gdmFsdWUuDQo+IA0KPiBVRlMgZHJpdmVyIHdp
bGwgdm90ZSBmb3IgcGVyZm9ybWFuY2UgbW9kZSBvbiBzY2FsZSB1cCBhbmQgcG93ZXINCj4gc2F2
ZSBtb2RlIGZvciBzY2FsZSBkb3duLg0KPiANCj4gSWYgY2xvY2sgc2NhbGluZyBmZWF0dXJlIGlz
IG5vdCBlbmFibGVkIHRoZW4gdm90aW5nIHdpbGwgYmUgYmFzZWQNCj4gb24gY2xvY2sgb24gb3Ig
b2ZmIGNvbmRpdGlvbi4NCj4gDQo+IFByb3ZpZGVkIHN5c2ZzIGludGVyZmFjZSB0byBlbmFibGUv
ZGlzYWJsZSBQTSBRb1MgZmVhdHVyZS4NCj4gDQo+IHRpb3Rlc3QgYmVuY2htYXJrIHRvb2wgaW8g
cGVyZm9ybWFuY2UgcmVzdWx0cyBvbiBzbTg1NTAgcGxhdGZvcm06DQo+IA0KPiAxLiBXaXRob3V0
IFBNIFFvUyBzdXBwb3J0DQo+IAlUeXBlIChTcGVlZCBpbikgICAgfCBBdmVyYWdlIG9mIDE4IGl0
ZXJhdGlvbnMNCj4gCVJhbmRvbSBXcml0ZShJUE9TKSB8IDQxMDY1LjEzDQo+IAlSYW5kb20gUmVh
ZChJUE9TKSAgfCAzNzEwMS4zDQo+IA0KPiAyLiBXaXRoIFBNIFFvUyBzdXBwb3J0DQo+IAlUeXBl
IChTcGVlZCBpbikgICAgfCBBdmVyYWdlIG9mIDE4IGl0ZXJhdGlvbnMNCj4gCVJhbmRvbSBXcml0
ZShJUE9TKSB8IDQ2Nzg0LjkNCj4gCVJhbmRvbSBSZWFkKElQT1MpICB8IDQyOTQzLjQNCj4gKElt
cHJvdmVtZW50IHdpdGggUE0gUW9TID0gfjE1JSkuDQo+IA0KDQpSZXZpZXdlZC1ieTogUGV0ZXIg
V2FuZyA8cGV0ZXIud2FuZ0BtZWRpYXRlay5jb20+DQoNCg==


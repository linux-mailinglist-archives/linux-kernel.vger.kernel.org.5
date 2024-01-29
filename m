Return-Path: <linux-kernel+bounces-42146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745383FD04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4B1C230FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102BA125C1;
	Mon, 29 Jan 2024 03:51:21 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2042.outbound.protection.partner.outlook.cn [139.219.146.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD37410A20;
	Mon, 29 Jan 2024 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500280; cv=fail; b=E+7s/7tQzEn/qqyIg9nOrYNt/jzyLggm21pF5NKqIOiNpiGsFH6L8XJDc07X6Q0xLKX3m2I8a9RQjXj4LZvpFIUGgGkUqNFI42dZar/97XvdfcZVkgo/DRj0U4Heieikq056eQNHfmcm91W1810pUUWWpBDfsv8GKxEawvzV7Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500280; c=relaxed/simple;
	bh=TTRxjBNZ2ZoSz+jj8yd1bACt8KrvoOw10cq8GAqESl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfohlYtLYBDt+Iu2ZQQeGHN00CD2yNGhP9DsbF05rCk8Pz3hGv9ic7WhLcRKMpLHBRA9leEeN1e6vwaUPJ8CTFXuwwTPZeiGlYUuXenSH7gxweb3vYlG0q9LdMxDYizLbsWHVEFuKPEWZ2SERJgbzhoQjqUU8dA/Wfbi3NCud94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud5FYK2wUMPHBDhZJ1C77CrPdQbHYs8VLXX7PuE6NPl8dKsUyQHMcX6w0aNOXe4izkCSlvJhMleW5plvu8IcK9wxGu4C2SFaL46MSTsvy+InDq32g4+WzvZof7Vvk9Unbs+mNBs+8ajQEJH+b84QjYEIkrnG952Ni1J0jZGA4eHOEkASJC7SovL0JCVqZq/Hsv2ARgNNLWL/OYjHxOgBbULJI70iDNRCZXSZH4/DD7H6iWvVCvu+JnqEB1KwZ89VcI01arjOUSqtYC8Ct4Gu60t2pg/U/A2DTDmLUobrztJdV6oKZdNVXh58m+znmefiiHWXRfV+AxSjT0U/pfAAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTRxjBNZ2ZoSz+jj8yd1bACt8KrvoOw10cq8GAqESl0=;
 b=KiKZM5+yfILp8YaBGPKQ15EfWIE0kp5FF+NyojxYEPoUoThMY8b8WV4cVRq9YB9A9PGOcR2G67uMWNP2iuRMws68eUCX/hXuwyH4d67cBRJjNX8mX+KjMx53d8JMLA5MyQkJkQUE3MnWoqozeXpiwJqboiI0EYfRLz2MR5LV+chMGTp+xFlCGR4p+lJSNFWK/NB7SJN3TJn00+FM40/A6o7vmlrSGbCGc+USWnG5mgqC41JiZoVjpXyY9ffXJ1S83V1YnQ/lu2afT0DCBnPXXTrAX2jgN5myfZ/Mr97z0iXqWtygOdoJfN+8e3pk+DfGEwmgDWd+lPkD8Ls+fTpTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0880.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 02:16:51 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7228.022; Mon, 29 Jan 2024 02:16:51 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Hans
 Verkuil <hverkuil-cisco@xs4all.nl>, Ming Qian <ming.qian@nxp.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne
	<nicolas.dufresne@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Tomi Valkeinen
	<tomi.valkeinen+renesas@ideasonboard.com>, Mingjia Zhang
	<mingjia.zhang@mediatek.com>
CC: Jack Zhu <jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDAwLzEzXSBBZGQgSVNQIDNBIGZvciBTdGFyRml2?=
 =?gb2312?Q?e?=
Thread-Topic: [PATCH v2 00/13] Add ISP 3A for StarFive
Thread-Index: AQHaRGn3nKUoa4JX0UecuS3FZFrWRrDwKOUw
Date: Mon, 29 Jan 2024 02:16:51 +0000
Message-ID:
 <SHXPR01MB0671D25402B3C9E5CA07786DF27EA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0880:EE_
x-ms-office365-filtering-correlation-id: 395ca5c0-908e-4211-8da9-08dc20705b26
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0ShELuQ6iRpW6/9rVrKSJbGZYOY32nfPtTpf9y9X4WGhONZpPWF3oo30FQo7HXqWLKpXqTKtwpV8f/OGnHJn5PHYDgULnG/KFOkVpH9ad5jhISOSp9Wf9Ck44NA5V+estU5QKtF1ozLHSLh8YXZa0inZTzZP8i/pEYHlk2etpDtpjmhwgLFxmRnjpfsvlp+IBJMJFOK78yXLxnCT1mG5BMJoMcX+Wrmp8pJaeCWSOrs4oa2ouzZa9NzzDA3mCnx0+qpphRbP2bfeFfNOKvOTihBk9VSzOsEE2vTjDYsh24ybAMrc12oKzbCbVtv/AtmnQ/oFPr4qu9g0EGaSnzZtP4sKH/gXQ5i53TqhjhtAUp5vi5G3repr9upR7qzoabmRtDhWE1DK42RA1uyEAPCaSjV0oFRXWKq1HBUsvYHcxgBdLWc3MJsdbKOiTh1F2Q5rhyUjIMzoTnPfGcaauCebhtfCk9FWwCu1SEXMh0jQRKjwQfCoPl6q5edgvuLjCa1ILetgDrO1rbhQijoM4MGfD41Ns43CcfDg0EEcK9AvB8zs6rbAzXvizV50jCFVjUIRWeJsoBSYWemPUREfWyQeqw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39830400003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(921011)(41300700001)(26005)(55016003)(41320700001)(40160700002)(224303003)(64756008)(40180700001)(38070700009)(54906003)(9686003)(508600001)(7696005)(71200400001)(38100700002)(122000001)(66476007)(66446008)(5660300002)(66556008)(4744005)(7416002)(66946007)(76116006)(110136005)(86362001)(2906002)(8936002)(33656002)(44832011)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dnpuUnUwdXVkU1Z2VDVKOURZOEcwSzhFZmZMclJPNW1ncDNuMmthVE1iQyty?=
 =?gb2312?B?NWNMK0JVQTFhR2h6bVNMRjUyaFhreXJHUGxRNWF6ODQxYmpsYkw3OGFCZXZ5?=
 =?gb2312?B?cE1pd3ZFRU1Qc0t4U0lTUmJIQW8yUDNqajZUREpRYTVrTERzZktWTGxYb2xN?=
 =?gb2312?B?djA0Q3dTc3RweHpsc2c2MlNsVkFBYW1TQkRRajNUV0JaTDlFdmZMNlBUYlF6?=
 =?gb2312?B?T3ZTUlIwaUd6L2tXZ2NHVEtSTEs5VlFJNVpjSVp1VFhPMk9xc1FDR0ZlaE1E?=
 =?gb2312?B?M215YmRVeXVaWDRFVEVNazh3TlF4alN6L2NEUStRN1BUaHJKNzNIN3piaXNl?=
 =?gb2312?B?bkdZVVVGRWtyb0xrNFc0NXN2TEVnNEREVXNMM3I4YmdubEZqTFJjT2JCOWww?=
 =?gb2312?B?WWRJOHN5YmJkR01QWlhuZFpUUFlmaWhvdlNnQ2JoZXo0Z29pbWFNVU5OdmEv?=
 =?gb2312?B?YzBxTmxnRnpUOUtrTXdGOHdOSGlhNE9JbDdpZlFJYVBDaFE0TXdSL21LQzd5?=
 =?gb2312?B?VnI1L05hOWNYUTQvNk5NMThobUZQZ3FOdXQyTW05OTloWTRtSW4xZ1I3dURG?=
 =?gb2312?B?OUF5YngvdittUzRsSEhDOStabkI4Z1BSMG5lN1ZrL1J2cXk0UlNiRWpiS2Fz?=
 =?gb2312?B?OTBTR2VwUW9xRG1QOFFBMWFRZUZkRXQ0UGhSU1BUMHUvOGw4V3VWTWVKb1N0?=
 =?gb2312?B?YTNraGhKUTdDK0Fjb3IrVmxKMDI4bDdPRHZXRGpCbjlOM1pmcjdhdldNZVZl?=
 =?gb2312?B?QllsSFBiOEhqNFlzZXBnZ3drdmgxR1NSN2N5TXVlR3p0amowdU9SQTcvbjVk?=
 =?gb2312?B?cVNoelkxUUp0VWNyaUkrdUIremtoQk9lN3d5SEtBcXF4K3Bpcnd3QXd3TXZp?=
 =?gb2312?B?dlFtWmx0SWxkUWozc1pVZEFvbWZEdEtOQUllZnY2OFAwV2RoVG5pNVpOWXBo?=
 =?gb2312?B?aFplcVlEWUcxMk5oSHhxZ1JGV3NjVG1FVjh6TnRWTUIrL3c5eldid24yOCtq?=
 =?gb2312?B?UjlWNEJka2RyQWZOZjFDaGwxUWhXNnlwT3gwN3ZlUXNDeWlNNlhWb2s4N1pi?=
 =?gb2312?B?VGhacFAzTTB0Ykp5WVVxYStjSlAya1Q1Y0hjZk1Wd0xNMXdaeld2OGF5ZVpu?=
 =?gb2312?B?OVJIQkx6MW5aZ2RHc05BcG5hbjY0aUU4VXhJN2craVQxWmtqdXdkSDNBbGFK?=
 =?gb2312?B?eGdrVUdlVCs1SVM4cXhDZDlkSXVkQ090TjZ0dlp0VXNxdlhYNTBRVUQxcjlo?=
 =?gb2312?B?K3BYOVRNV0VHeFAxNks2bW9yUVJwaEMzTEd6ZGEzNFJJK0lDWkNiRHlXdlk3?=
 =?gb2312?B?SG5xWmFieXV6RjdLMTU0c2M5ZjcwQjJzeVIwTmgwWTc2ZU5PWDBOdEd6YnBU?=
 =?gb2312?B?eGxhL09hbVhzRTQ2Rmd3QW9VM2RtcnJuMjA3dzgxczdWelVlalhUOE43Q3lr?=
 =?gb2312?B?V3NuT1Yya1ZpYkxncjBQUlBGdFI2aHgyNTU2ZEFLb284eE5tQnl0bis4QmtY?=
 =?gb2312?B?U2RaQW9wSkY1d29sVFhXY0pma1lRTEs4Y1JManZsZjRJeDIxaTFNL1MzcVFH?=
 =?gb2312?B?ZE9lczRFUXdIdmNmSnh1V2FmaC9ySC9wbUprTElaSnpHTXdGdm43VXBlZWNG?=
 =?gb2312?B?dDlWQ3VkZlNteGdjZnBhTHJvZVU4eXlQVE1QTDFYanVpTldDYTNoMC8yNjYz?=
 =?gb2312?B?Z2ZwWDlTUEF0L2tTSHQ1RGZINzhvSjF6RWs3ZHcvbm5qZHIrOHNkbTBRdHdJ?=
 =?gb2312?B?RlZhakRWVU5tbTN2S0cxYWhJTFBreWUvRWNkNng0Qzk0OFJzcVlwUEtkclZx?=
 =?gb2312?B?NTdiRTZra2hrYXBwM2pqQlRGcUs2T2ZZUGxWUi83cVRnbGVHUzcvZ3hiOWhB?=
 =?gb2312?B?VGliTnZGK0h2U2EvMS9yZElEajgzM3kySXpvcnFXRFYrNTV5bEM5cWI2eEhR?=
 =?gb2312?B?NlFVeUd2bXNQWEd4eE05NzVnSi9OUUVMdXpKZkRVeGw5YmlHenVVb0h6dzVK?=
 =?gb2312?B?SllvdmhZbFlWRlFvN053TlRzVUFTbzQ1YWVXbnFYajlwKzl6d3RibWY0cTB2?=
 =?gb2312?B?ZDViMVBweTdRbWEzRk1rMDFNTE5nVFVsREo3MEZ5S09TbHpzdVRGdGVZWkZC?=
 =?gb2312?B?dUJDejBCWXB4YkZiYlExWkxvbVhzYlJrRGRvbUtGTjVYcUp1R0xETSt6QnhP?=
 =?gb2312?B?U2c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 395ca5c0-908e-4211-8da9-08dc20705b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 02:16:51.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2ICmgYWeZuocMDCgo+J2W4WzPkwaPS2MkSslT+9Inx8KAak0oNdA9Dm8L+zNkFn4HaHUaBLBRHy/7kwkTC/DiETjBn0Pzkhl4iJKT2ci/fNUN1aY+IQrOW2UIrOVOC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0880

DQo+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgdGhlIElTUCAzQSBmdW5jdGlvbiB0byB0aGUgQ2Ft
ZXJhIFN1YnN5c3RlbSBvbg0KPiBTdGFyRml2ZQ0KPiBKSDcxMTAgU29DLiBUaGUgc2VyaWVzIGhh
cyBiZWVuIHRlc3RlZCBvbiB0aGUgVmlzaW9uRml2ZSAyIGJvYXJkLg0KPiANCj4gVGhpcyBzZXJp
ZXMgaXMgYmFzZWQgb24gdG9wIG9mIHRoZSBtYXN0ZXIgYnJhbmNoIG9mIG1lZGlhX3N0YWdlIHJl
cG9zaXRvcnksDQo+IHdoaWNoIGlzIHRlc3RlZCB3aXRoIGEgdjRsMi1jb21wbGlhbmNlIGNvbXBp
bGVkIGZyb20gdGhlIGdpdCByZXBvDQo+IChnaXQ6Ly9saW51eHR2Lm9yZy92NGwtdXRpbHMuZ2l0
KS4NCj4gDQoNCkhpIExhdXJlbnQsDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcg
YW5kIGdpdmUgeW91ciBjb21tZW50cz8gDQpUaGFua3MgYSBsb3QhDQoNCkJlc3QgcmVnYXJkcywN
CkNoYW5naHVuYWcNCg==


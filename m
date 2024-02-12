Return-Path: <linux-kernel+bounces-61998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469C8519CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ABD1F231FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95863F9DA;
	Mon, 12 Feb 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Xy2Z9ZRF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74803F9C4;
	Mon, 12 Feb 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755980; cv=fail; b=sEfCkDk9y1vw5SFo36LtRa+qLRkv+1+AIxYcrZ8oE46IDrKsBsm68jnF181vrPi2Vw7jfCcUd70KwGI/NExlmGvCUAnF657YCmSpCVRlefviwPFaDR+y7xRm/irH/GQq01+uZWcswE/oxPyiSJz9l8EVjxLAWBn/RBqDB/HS/OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755980; c=relaxed/simple;
	bh=z4tWAm+cdnOOXxTSIZDNsDJROHc2IvzKiOmO8vgeaqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QguKoIKwneDAxGIa1upLBUi44rXG9kug4ybrlOX+737kkLJnAtjT68qIWdg8jN3vS3h4vZfR/uav2kSC7DCGwnc9sD6ATlwyyL8sdTmPknPWj16NT8CwQBiUK2wZXdE77zYsN/O1qH/0orq1xB6pbZtvodRNpLqvuBdG92twis4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Xy2Z9ZRF; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzEpLzEbK8JTtCP0KqGlfXIrVphapDByeStHN0j99LkZb+VG86JHQoU4tKpV6S125RhQCtvXhnWxt5ifhc/u9E4bdIRbi3yJbLGVkw3d3LmqcvGBuXLnHR5UNmDHElJwDKoNlvINI8gF8TL7Hy3pGW4JUpixAQI2ree8QQtJqyxdYRBSxZfLzqaaSepPwI7ZgSTZD1hyovRVKAmvfgg3/eWE/zR2rNEaH2QQIhnG6o1+l/oPN/5dlE/nBSe3Rxnq9mwjkG5zoMil/QBY0JnXTMjetd/SVof9xG8URjDniX9u6WzqN7jXSG9aa5PzcwXtFLkB4Tc1P3NOCWfIqI3FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4tWAm+cdnOOXxTSIZDNsDJROHc2IvzKiOmO8vgeaqg=;
 b=fU9vHUPal9DawlEtYuTtPcVn1TtpIYqWUZeCtJYOUx1odV5FrQpFHUY/PH+L/xDvgJUOzoA1eU4JxUULzmWwh0ndjbw6kNb5nkzMJUeoxWj7lyIfPBMtsU3053mDCAlZjTlOmxdBnvJRfHp55vcdt0K5J5gPXPY7fXeTk05pXAeOMqf28VXccFRXjsR4+aHXmZJ1Hr/futbkBljLfeHht4gqzmxi89sCXa08lus4pSEPT//qIBGVOgvqlSa3Hu5Q8uA2hR2pTqeEGZnHRqz58m8pXQ1FW1WD6fjJnyNzDJtMJlFx5FhF+PukGmegmkyCWmrSjoIp4cDOdXJeMZgXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4tWAm+cdnOOXxTSIZDNsDJROHc2IvzKiOmO8vgeaqg=;
 b=Xy2Z9ZRF+4nW5lS3uGfQXadQfWxBT8ssWpz4yf/v98SHz1HB0fnob5DPHrs5k7xobe3d0Og3PMniKOX22+6EDh/35f9RIbnUiPSiKQViqLrvAKpAUVHblQkRDHGiU6Hz9ra3W0C7FolymHcLZ3SwpoH3jQf4usBP+V9km61tBLg=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8137.eurprd04.prod.outlook.com (2603:10a6:10:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 16:39:35 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 16:39:35 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Suman Anna <s-anna@ti.com>, Grygorii
 Strashko <grygorii.strashko@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v5 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Thread-Topic: [PATCH v5 0/5] arm64: dts: add description for solidrun am642
 som and hummingboard evb
Thread-Index: AQHaXPwYhEcJ4dlchkWOTKleM2ykyLEGGM2AgADRWQA=
Date: Mon, 12 Feb 2024 16:39:35 +0000
Message-ID: <b918364e-cfca-4342-acc2-2b51bad75596@solid-run.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
 <359993c5-3387-443c-8cef-30ee7ad1f521@ti.com>
In-Reply-To: <359993c5-3387-443c-8cef-30ee7ad1f521@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB9PR04MB8137:EE_
x-ms-office365-filtering-correlation-id: f27882e8-5abb-42fe-40d7-08dc2be9325e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dQR8WWTYfE5IrT2dsdq7iedGhQ5rnqT78cvS/emEa7fuopSVSf62eR7vTexX+XcFFOqyLUjbJ08+9KF2dtDqISoMFSyGaZoFJUlUt/I5zNIv+g+IwLBG7WYLkbbKxWprrUdnP78tmtOYDpqxSXAgA7HX+aVHGMN3Twa0tEATz2mpYOxfXPjXUBujvlNhI7ZY/zHPsHBfh1PwL5t3j/cEZYVVztiwzmpGeRuY6eX6Dwyf8wuxZj+O8J2rljJFNZxHjO/jAFnSXGQWJNMSkTMQ7iQfWGfkz50/xHA1SrEwvg6N/2bBKYh6VCcYZOi3wsjyCAZET+L8g9MG2hDr1XhavztZOiEMwniL78aGTAxYls3mso9kQpdWe7uLeyjJxw0kz96S1R+YdG+JdWvpSxn+bLny0QUksCte0/603BFkRCSp16V0JapOBIcv8XHYPFH5x3hEVzHNWfOYgpTvBxC5rriaSAXw1+peeDbN/oRoyHuAXK44+DcQLwQXpl44ZSZVGW3aJcDpLHvrxbCGxk0+jCx6basWbEZX474bjfo2QfpaqVQwioo05Bx4ih79aZtM1ZpfoetXzITv3HJ2ZyMR2chDlhZcYE6oefVoAOv0coY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(396003)(136003)(376002)(346002)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(8676002)(4326008)(8936002)(91956017)(76116006)(64756008)(66446008)(66946007)(110136005)(316002)(66556008)(36756003)(66476007)(54906003)(5660300002)(2906002)(7416002)(71200400001)(122000001)(6512007)(2616005)(38100700002)(31696002)(53546011)(6506007)(83380400001)(26005)(86362001)(478600001)(6486002)(966005)(31686004)(41300700001)(84970400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2dyMk9vNE1XS3VTc3I0T0ZtYTdpemdvQk9hMndKZTBRekR6Nnh0UE9qU1Nl?=
 =?utf-8?B?QmtRS2RvUHFYQzRmaERLa1BoVjhuNUhKVDRhN2ZCQ0RuWG9tSWlqOUFxZlJw?=
 =?utf-8?B?bGQ1V2FWaFRUbDkvYy9tWlBmVjlDbExzRm5hMXp6aUlmVjhlSHozYWo4eGFJ?=
 =?utf-8?B?c1VzbmwyTzdEeWFmZ2U5MVFObTU4c2diYi9PWmhEdVpkSVlIellUMzl2RXRT?=
 =?utf-8?B?eTNtSTFGZ1BwaWRla0FsdjMwNGFHZk1BbmdZSDZLalRLOUpqOXRlTmV1aXdX?=
 =?utf-8?B?OVNoSmRoY202ejFWaXAzQ0tvM0pHUDVkUmYxVmMvK1B2Y2ZOZEllNXBvNVlK?=
 =?utf-8?B?VXdiUWRxdjFjaitWV1phYzRlNitxVkg1NmgrTmZhNC9LWFFVRnJCZ3N4bFIy?=
 =?utf-8?B?WWtnd3BjM0JJbUYyNUdUSE9lUGg3OWxzVlNPVDI3R0pHYnA0WVVQZ2Z2Qmwz?=
 =?utf-8?B?eWtBOTl5a1VUS0Y5eUw5WXNPWWtFc0QwbnduUTRuUGRZWFdVaWJCUjlPaEsr?=
 =?utf-8?B?bHA2bUdNV0tsNE1selFYWko0Qk80UzBhcGMxR1NCck1nSUdZMDBzM1p2Vk12?=
 =?utf-8?B?WmtqYXNQWmFFM0tVcktGcnhKREtCckEybE40Rm82R3gyWjBLQ0dnV0RpdHZV?=
 =?utf-8?B?RjFXL1Jkc09qa04xdHFPNlJiN0RNSEw2VU9wd1hLWmlvcVEwS2Q3Mm5Qak00?=
 =?utf-8?B?OEc3YWRUUlNBZURkRUo1RFdXR0dHZjY0T09nUVJ4bk9iWTErTU43OHpoYnlq?=
 =?utf-8?B?N0xBZ1BtYTduVUFJYXlOOVpPaXRQNTRvQlduMXdyV05rbHdKcE1vUmVraEVQ?=
 =?utf-8?B?Y2tZTW9zOUtsdFBtTFFZYUdaQ3FXRXdxT2w3SjFpRHB0YmhWcDY1WGZiK0tS?=
 =?utf-8?B?T3k2UjVNdDk3TU1PZ1dtRTVWOTNPUU1RLzF4MzhWQWJZZ0xVQTFkU2tEYnRl?=
 =?utf-8?B?djBUNURBc3FtNGdkeDBiT2RDeUQxT05ITTNjcitBRXhNQllrTllZeURqKzRR?=
 =?utf-8?B?NzArSjMvZjkxYVdrVkx0Y0lxb2R6QkRFdHNZQnRxc1BJVE53bjdjVmVWUjFU?=
 =?utf-8?B?dXl0Lzhna2JTRUl0TlBMOHNDOW5FTEtLMWlPUjRvdW1YMGdlMkRqWU1sdit0?=
 =?utf-8?B?SVR0TUJhVXU4Y2NwZkdEM1pzVXMwc2NvRWZYQjFoc2RUelplalhIdHhYSEtJ?=
 =?utf-8?B?TUFBVHhWT21CTmN6T2doNDRrR0pIVVNldlpVVXJxLzYwQ015SGFsSTlBMVc3?=
 =?utf-8?B?UTR0RTUyZ0hGbTVNUFdkbldFVDhDWnBKVkllMUZDblVPU1RkYkRHZ1dGTkVq?=
 =?utf-8?B?NkJ0UmcxMWRxZ1lnZEVZUGdxYmJtbGtSSU9VZXFySmlGZVdsTzJQY2tCTElB?=
 =?utf-8?B?ZS9hZDc4Z29LOTFrODQrMDFMM2hzMnBlcDBqWlhqVnFtZXZUYXVDayt6bGlH?=
 =?utf-8?B?dkE0TkUxcm5jVFR0UkxsSzZVOTZPUFNOYkpHamdPalFBNVhpU2Mwdk1NRHJm?=
 =?utf-8?B?N3JaY05mQ1B1cEZwMFl2SVVObnRmb0dFNTB1NXFwc2FUR09VU3B1U250U1ZU?=
 =?utf-8?B?OWNHTGxwSTVNS3RoZk5DYTk0M2ZXTE14ZUVGVFNHdXJWRTdoNThBM0RQakxh?=
 =?utf-8?B?VWR3R3pFSllHU01QZVdjY0dFcmdUTlI5TGN2azlITGx5eGg5WVhlZUlDVTI0?=
 =?utf-8?B?eHEzN1ViMEZGUmwxZW5oamJJdk1BN1djNTlZcS9NZ2VTSjdoSVVTbkc3NC9E?=
 =?utf-8?B?UG5XLzRhQVh2aXQ0YkRua3ByQUlrWVgza09BdDRtVG9qc0hyYTVRTjlvNXRj?=
 =?utf-8?B?Skl5dENBa3ZkcU03NnBuMzVhazU3djlpZ3Qzb3l6NUFLQ1V4dUZteXlBa2dP?=
 =?utf-8?B?TXRwSyt4anNvSlpaYm1URExkRjlhREZhSE8vam5WVGpWb1ZxZjEvcWdveXBG?=
 =?utf-8?B?V0lteFBBaHBvSFdIWEdnZE81OExtZy9XQmpHSWZPaEJMem9lMk50a25qL0xp?=
 =?utf-8?B?S2Z4NmJ5Szh0Tlg5YmxsdmFFUTg0SmU5aE50ZEdQSDExUEdXclgxRWxGbS9B?=
 =?utf-8?B?K0pjcVovUGNJc2JRaCtlRG8wODNIc2NQelpFcEp2VzR1REt3WFZvTEFGdGFa?=
 =?utf-8?Q?ckzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8EB59866873649AFB5CEC3A4819C1A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27882e8-5abb-42fe-40d7-08dc2be9325e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 16:39:35.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQg9I6ghNN0HR1Yw/4bDaXGNMtrkS+UUZc4MA+H246LE8m9WTwy4J+ByMxGmXBG4SFW93crfILbLUyt86m0UyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8137

SGkgVmlnbmVzaCwNCg0KQW0gMTIuMDIuMjQgdW0gMDU6MTAgc2NocmllYiBWaWduZXNoIFJhZ2hh
dmVuZHJhOg0KPiBIaSBKb3N1YSwNCj4NCj4gT24gMTEvMDIvMjQgMjA6MzcsIEpvc3VhIE1heWVy
IHdyb3RlOg0KPj4gVGhpcyBzZXJpZXMgYWRkcyBEVCBiaW5kaW5ncyBhbmQgZHRzIGRlc2NyaXB0
aW9ucyBmb3IgU29saWRSdW4gQU02NDINCj4+IGJhc2VkIFNvTSBhbmQgSHVtbWluZ2JvYXJkIEVW
Qi4NCj4+DQo+PiBBZGRpdGlvbmFsbHkgYSBjb21taXQgZnJvbSBkb3duc3RyZWFtIHZlbmRvciBr
ZXJuZWwgYXJlIGluY2x1ZGVkLA0KPj4gZW5oYW5jaW5nIHN1cHBvcnQgZm9yIHBydSBiYXNlZCBl
dGhlcm5ldC4NCj4+IEkgd2Fzbid0IHN1cmUgaG93IHRvIHByb3Blcmx5IGFubm90YXRlIGl0IGlu
IGNvbW1pdCBkZXNjcmlwdGlvbiAvDQo+PiBzaWduZWQtb2ZmIGFyZWEgLi4uOg0KPj4NCj4+IDEu
IGFkZCBkZXNjcmlwdGlvbiBmb3IgIkluZHVzdHJpYWwgRXRoZXJuZXQgUGVyaXBoZXJhbHMiIChJ
RVApIHRvIGFtNjQNCj4+ICAgIGh0dHBzOi8vZ2l0LnRpLmNvbS9jZ2l0L3RpLWxpbnV4LWtlcm5l
bC90aS1saW51eC1rZXJuZWwvY29tbWl0L2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NC1t
YWluLmR0c2k/aD10aS1saW51eC02LjEueS1jaWNkJmlkPTVhZmI3M2Q4MmEwMTRiNTk0NjIxNjJk
OTYwYjM1MGI4YzU4ZTVhZTYNCj4+ICAgIElFUCBpcyBhbHJlYWR5IHN1cHBvcnRlZCBpbi10cmVl
IGJ5IGEgZHJpdmVyLCBhbmQgdXNlZCBpbg0KPj4gICAgazMtYW02NS1tYWluLmR0c2kuDQo+Pg0K
Pj4gVW5mb3J0dW5hdGVseSBkdGJzX2NoZWNrIHJlcG9ydGVkIG1hbnkgcHJvYmxlbXMsIEkgcHV0
IHNvbWUgcmVtYXJrczoNCj4+DQo+PiAtICdtdXgtY29udHJvbGxlcicgZG9lcyBub3QgbWF0Y2gg
YW55IG9mIHRoZSByZWdleGVzDQo+PiAgIFRoZSBleHBlY3RhdGlvbiBzZWVtcyB0byBiZSB0aGF0
IGEgbXV4LWNvbnRyb2xsZXIgYXQgbWluaW11bSBoYXMgYW4NCj4+ICAgYWRkcmVzcywgc29tZXRo
aW5nIHRvIHB1dCBiZWhpbmQgYW4gQC4gSG93ZXZlciB0aGlzIGlzIGEgZ3BpbyBtdXgsIG5vdA0K
Pj4gICBzdXJlIGhvdyB0byBuYW1lIGl0IGJldHRlci4NCj4+DQo+IEkgZG9uJ3Qgc2VlIHRoaXMg
d2FybmluZyBsb2NhbGx5LiBBcmUgeW91IHVzaW5nIHVwZGF0ZWQgZHQtc2NoZW1hPw0KcGlwMyBp
bnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KRGVmYXVsdGluZyB0byB1c2VyIGluc3RhbGxhdGlv
biBiZWNhdXNlIG5vcm1hbCBzaXRlLXBhY2thZ2VzIGlzIG5vdCB3cml0ZWFibGUNClJlcXVpcmVt
ZW50IGFscmVhZHkgc2F0aXNmaWVkOiBkdHNjaGVtYSBpbiB+Ly5sb2NhbC9saWIvcHl0aG9uMy4x
MS9zaXRlLXBhY2thZ2VzICgyMDIzLjExKQ0KDQpSZS1UZXN0ZWQgb24gNi44LXJjMQ0KDQo+IHJl
Zw0KPiBpcyBub3QgbmVjZXNzYXJ5IGdwaW8tbXV4IGFzIHBlciBncGlvLW11eC55YW1sDQpUaGUg
ZXJyb3IgaXMgbm90IGFib3V0IHJlZyBwcm9wZXJ0eSwgaXQgaXMgYWJvdXQgdGhlIG5vZGUgbmFt
ZToNCg0KbXV4LWNvbnRyb2xsZXIgew0KwqDCoMKgIGNvbXBhdGlibGUgPSAiZ3Bpby1tdXgiOw0K
wqDCoMKgIC4uLg0KfTsNCg0KwqAgRFRDX0NISyBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFt
NjQyLWh1bW1pbmdib2FyZC10LmR0Yg0KLi4uL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02
NDItaHVtbWluZ2JvYXJkLXQuZHRiOiBzeXNjb25ANDMwMDAwMDA6ICdtdXgtY29udHJvbGxlcicg
ZG9lcyBub3QgbWF0Y2ggYW55IG9mIHRoZSByZWdleGVzOiAnXmNoaXBpZEBbMC05YS1mXSskJywg
J15jbG9jay1jb250cm9sbGVyQFswLTlhLWZdKyQnLCAnXm11eC1jb250cm9sbGVyQFswLTlhLWZd
KyQnLCAncGh5QFswLTlhLWZdKyQnLCAncGluY3RybC1bMC05XSsnDQrCoMKgwqDCoMKgwqAgZnJv
bSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZmQvdGksajcyMWUt
c3lzdGVtLWNvbnRyb2xsZXIueWFtbCMNCj4NCj4+IC0gdW5ldmFsdWF0ZWQgcHJvcGVydGllczog
aW50ZXJydXB0cywgaW50ZXJydXB0LXBhcmVudA0KPj4gICBzZW5zb3JzIGFuZCBmbGFzaCB5YW1s
IGFyZSBtaXNzaW5nIGludGVycnVwdCBkZXNjcmlwdGlvbnMsIGJ1dCB0aGVzZQ0KPj4gICBwYXJ0
cyBkZWZpbml0ZWx5IGhhdmUgYW4gaW50ZXJydXB0IHNpZ25hbCBpbiB0aGlzIHNvbGlkcnVuIGJv
YXJkLg0KPj4NCj4gUGxlYXNlIGFkZCB0aGVtIHRvIGFwcHJvcHJpYXRlIHNjaGVtYSBhcyBuZWNl
c3NhcnkNCk9rYXkuDQpMb29rcyBsaWtlIGl0IGlzIG9ubHkgdHdvOg0KLi4uL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvdGkvazMtYW02NDItaHVtbWluZ2JvYXJkLXQuZHRiOiBodW1pZGl0eS1zZW5zb3JA
NDE6ICdpbnRlcnJ1cHQtcGFyZW50JywgJ2ludGVycnVwdHMnIGRvIG5vdCBtYXRjaCBhbnkgb2Yg
dGhlIHJlZ2V4ZXM6ICdwaW5jdHJsLVswLTldKycNCsKgwqDCoMKgwqDCoMKgZnJvbSBzY2hlbWEg
JGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vaHVtaWRpdHkvdGksaGRjMjAx
MC55YW1sIw0KLi4uL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItaHVtbWluZ2JvYXJk
LXQuZHRiOiBmbGFzaEAwOiBVbmV2YWx1YXRlZCBwcm9wZXJ0aWVzIGFyZSBub3QgYWxsb3dlZCAo
J2ludGVycnVwdC1wYXJlbnQnLCAnaW50ZXJydXB0cycgd2VyZSB1bmV4cGVjdGVkKQ0KwqDCoMKg
wqDCoMKgwqBmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL210
ZC9qZWRlYyxzcGktbm9yLnlhbWwjDQo+DQo+PiAtIHdyb25nIG5hbWVzIGZvciBwaW5jdHJsIG5v
ZGVzDQo+PiAgIE90aGVyIFRJIERUU3MgY29uc2lzdGVudGx5IGVuZCB3aXRoICotcGlucy1kZWZh
dWx0LiBTaG91bGQgYSBkaWZmZXJlbnQNCj4+ICAgbmFtaW5nIGNvbnZlbnRpb24gYmUgdXNlZD8N
Cj4+DQo+IE5vLCBwaW5jdHJsIG5vZGVzIG5lZWQgdG8gZW5kIGluIC1waW5zLiBBbGwgVEkgYm9h
cmRzIGhhdmUgYmVlbiB1cGRhdGVkDQo+IHRvIG5ldyBzY2hlbWEgWzBdIGFuZCBzeXNjb25maWcg
dG9vbCBvbiBkZXYudGkuY29tL3N5c2NvbmZpZyBnZW5lcmF0ZXMNCj4gYXBwcm9wcmlhdGVseS4g
UGxlYXNlIGZpeA0KT2theSwgd2lsbCBkbyAuLi4NCj4NCj4NCj4+IC0gY2RucyxwaHktdHlwZSBy
ZXF1aXJlZCBwcm9wZXJ0eQ0KPj4gICBpbmhlcml0ZWQgZnJvbSBrMy1hbTY0LW1haW4uZHRzaQ0K
Pj4gICB0aGVyZSBpcyBhIFBIWV9OT05FIHZhbHVlIGluIGR0LWJpbmRpbmdzL3BoeS9waHkuaCwN
Cj4+ICAgYnV0IG5vdCBhbGxvd2VkIGluIHBoeS1jYWRlbmNlLXRvcnJlbnQueWFtbA0KPj4NCj4g
U29ycnksIEkgZGlkbnQgZ2V0IHdoYXQncyB0aGUgaXNzdWUgd3J0IGNkbnMscGh5LXR5cGUgPw0K
VGhlcmUgd2VyZSB0d28gaXNzdWVzLCBidXQgdGhleSBib3RoIGRpc2FwcGVhcmVkIGFzIHBlciA2
LjgtcmMxIDopDQo+DQo+DQo+IE5vdGUsIEkgcmVhbGx5IGRvbid0IHdhbnQgdG8gYWNjZXB0IHBh
dGNoZXMgdGhhdCBhZGQgbmV3IGR0YnNfY2hlY2sNCj4gaXNzdWVzIGVzcGVjaWFsbHkgZm9yIG5v
ZGVzIHRoYXQgYWxyZWFkeSBoYXZlIFlBTUwgYmluZGluZ3MuIFBsZWFzZQ0KPiB1cGRhdGUgdGhl
IC55YW1sIGZpbGVzIGFzIG5lY2Vzc2FyeS4NCkkgaGF2ZSBzdWNjZWVkZWQgbG9jYWxseSBnZXR0
aW5nIHJpZCBvZiBhbGwgYnV0IG9uZSwgdGhlIG5vZGUgbmFtZSBvZiBtdXgtY29udHJvbGxlciBt
ZW50aW9uZWQgYWJvdmUuDQpXaWxsIGluY2x1ZGUgeWFtbCBwYXRjaGVzIGluIG5leHQgdmVyc2lv
bi4NCj4NCj4gWzBdDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWE0OTU2ODExNTE0MzQzNTM5MGYy
MDk2NTkwMjgwOTQ3MWI2ZjgzMGMNCj4NCj4NCg==


Return-Path: <linux-kernel+bounces-35417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3CA8390B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B6A281EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534F5F847;
	Tue, 23 Jan 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQmoMJbA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6C5F565;
	Tue, 23 Jan 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018392; cv=fail; b=ndSyKfS5gUfsUmtp5o4NKRr+46veU8rFVO4ZkXLWvAF6XxsoVfrN7kYqS7TbLfKoBhcalXFnUd1sHB6VFFrY7jODlaQhq3hLvNdRPASb7p/AQCTR4PkqC5bNi5iZ5DkcXkvhq58k9Zlqr0hOOzSk1Zvc2i9Z9Rfog+pAA/h3bU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018392; c=relaxed/simple;
	bh=buWegNqA7sC+ZWR5eiqU1b4NbCmUPQpDgbr4prN3QOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nyncTxpgEcbHG/tCTtREQREHp+yi04VwjrMfUWMW+WX8ZKZT1gYzukHkyCdPr5QRlyJNis6DcNy7Ps/rU5tVVe9yEMd11ZpB6tuC1s46qKTr/eEyMfxxbzUu2FkNofdmlDKNuSRNVww4vVb+h7778F+bAnVGNUNyepxgCjmPJSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQmoMJbA; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvZLV5e0YbjrEEsh3R3soqNkMgY0d+sS6afAaVGmO08bohgdEdupgKBXM8tUwZ8Ymm5HxMjeDyCom/VPfOitOEn3PyDsV2ex5Q8sVC9IJ3Q52lIW7lob8qA6Twa2iyj2gJ4zTQQvqfX+Ung2rd14EaAKFU9UAmuXN6d/PmGI1xP0AHSTnwGA3sFEi32cKBwAIfsm+qADrU5M+aEcMjPSsEqdc4oNUvCSf94jm011aTHLwv/r+/YVX8J5NOCXN+JntQEwKHSixh5lryXB8cmITp3tBpqxVrdmw3Ll/g6ZGuePBkRu5G535O8MKubX/EB7eYAcaP9h7rSctmnucKvgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buWegNqA7sC+ZWR5eiqU1b4NbCmUPQpDgbr4prN3QOw=;
 b=CwZF41CSNB6Xv8+4d/UvoP5ueEZUQR+U4XGJgD8DQ2ZzvXNXoT+why+tdPm7XZD/Sam76AsflW/IlqqjoXM4ICel2z3InqeKALuLARAKrHoqYdpOEHNPtXjE0D5L6TYWIdTzPAvkHKBAJAlZLlceJTS8UfhBQ3rWGoXteA/BFPSkcHYGpFXkksCxR+cXhr3o2Rf7Yr03J5S6xkRCf4imBnsuJFSrwxlAoP83Ok/Js3I/dqijwVMeAx2eecifN3LoGlJV3Sxm+QIfPlljVdPnp6EisDNJLrGAE7GzT18HGxYHM3mZRkVX1n4AHvT8epF+7A7YhPhJ5bXZmEjzaN06+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buWegNqA7sC+ZWR5eiqU1b4NbCmUPQpDgbr4prN3QOw=;
 b=WQmoMJbA+jy7tphSgrkrFWZesF8xYDj0R7LIJNVPV19NGzMJF/QsPtkjxMx3Yx9nSvEmWAlpj51FTp6aR+JC1NnQdklQPifKcX4X6iEbnp0X6mnL1h3OmlZkWDogSRNMgIsqpeGH04e7+6mJ0ewGQO/j8kgl3IxTXDi2fcpncAQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 13:59:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 13:59:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: clock: support NXP i.MX95
Thread-Topic: [PATCH] dt-bindings: clock: support NXP i.MX95
Thread-Index: AQHaTF7dbf3fZzQpTkKKhWtWHavxlrDlm5UAgAHFORCAAA4YAIAAANsw
Date: Tue, 23 Jan 2024 13:59:46 +0000
Message-ID:
 <DU0PR04MB94173B34D426181D285B995088742@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121114623.1418597-1-peng.fan@oss.nxp.com>
 <273a80a7-2a60-4490-9c3c-c33dc14be9e7@linaro.org>
 <DU0PR04MB9417A8F4230D2C7C76D1550988742@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <78e296fb-a3dc-4e00-94bc-91dab7294887@linaro.org>
In-Reply-To: <78e296fb-a3dc-4e00-94bc-91dab7294887@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS1PR04MB9360:EE_
x-ms-office365-filtering-correlation-id: 815630d9-d159-4b4c-710b-08dc1c1b8ef2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q+mQz9UxQvLtVikjdzOB/bRbRDxVH12kQ0guXa5MESVEGcJ5VCM4FurQMge3f5bps7ZZEyutPylsOAJIoVvyzhebVrd4wp+ebGwEVcyKJVw04sbmpgpnJmd6z/NwrDIgLCZq98uoMxlRjQ4aLj/J6oL8KR8J+Rk2esvHqiGvisyAe86ONegaLt9FZwSiFwhMP+zb4uLwmnWtM3da1JKLqKL33m9nftYDQDTgDVUO+qNlFkbJWur1yHwu3ohLYRkyQyeM1SMWX0nIlKzj+L5G7YDL72NY/+m3ThJJxcpg2+EFDWfGESOcOMmpepE8e9X5Zw6/m0ebkPE25c0YgnqEUChSh82Iv7sOnn1XTOFf6UkoV+oSuXr87IqMRK6DALNTmgeZ9uTMDBlfXzmPa1tPE9X72Dv3tOn3fkiIcpKnAKMZY3IoRfmrShB/I/X8vnFllgfeCVxDnruvZgysaLIFs65qcV48IOX2TlyvP5Z8vEKMJitxT6x1ai1G6gn4yFxjUOVJUCWJ0EQkwA7v8Y+ftoci/2tv4z0GrSCmjbf4+9OzMNp+qMRPVB+rCD1cCoy9jJ2oFSubChBvMqgNoJBPQCe01ccNKIMMc4Hlp4GzRRVcRbln+GUL7gVyBI8GoSbiGfrNq7C/DbN2nXmvg15u4A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(55016003)(71200400001)(6506007)(53546011)(9686003)(7696005)(26005)(86362001)(38100700002)(33656002)(921011)(122000001)(41300700001)(38070700009)(478600001)(44832011)(5660300002)(83380400001)(7416002)(2906002)(54906003)(52536014)(8936002)(110136005)(66476007)(8676002)(64756008)(66446008)(76116006)(66556008)(4326008)(66946007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkI5MmxOWGovZGN1VENOeHJYdDlFSlBIaUpUWVE2MG4zeiszS2VCcXlva1lM?=
 =?utf-8?B?VHBvZ0NsN2V4SDNTbFZRa2RNbGhZRmpKTzRzVEpGS0NhRHl2OHdkV1VFNWMz?=
 =?utf-8?B?QXRPUTZrSzNtTzFtNUZJWVZISmJLdXhRL211YjJoejd0a2FzbmpXK01HRWlD?=
 =?utf-8?B?QWhLRzJUTjllYVNoL2c1UzZORklwQ2pRVGJzOTA5VzhEbDlxTHdhWmdSeExZ?=
 =?utf-8?B?dmI4cFV4Mk9FbFgxZm9RakkrMEtZdnR6b0NpK0cydFcyMnRHd3NOdk8vTU1H?=
 =?utf-8?B?V2ZrOHNTM1RqUFJvSGxMU25MUmh1aWpHbGxUeDNGdzFXNFU2S0QyQ3dNMWpR?=
 =?utf-8?B?U2gxRXRrMFF1UmxLOEpwV0JZMTEwNTUzakFJU2RJYkU5QVVJOEQ5UUh4Sm1P?=
 =?utf-8?B?T1I2VE1aUnRlZlpGYnJodWpsNmphRkZVNFowWHhiSVdBQXNFQWhoaGl2MUpT?=
 =?utf-8?B?NVdkZXRucnJmd1AxNEY3RWFvWnFVVGRPQWZINmJYQzg5eG5uNFJEeHVYQlpN?=
 =?utf-8?B?L2QvS1hibXMrMFZmSW1WcXcwaWw1QjFkaEJDRVVuRG12TVVET3c3V205a2lW?=
 =?utf-8?B?eEVhWlFBMUt5c3dCRXpKSGgxb1IxMWxveThuTVlGM3VzbnllTFVlbTd5ZWo3?=
 =?utf-8?B?UWlteEF0Q2kreTFzZWJ0NS9XcTFmYmxvelZ6WnF3QWVpSWNGZ2tBZk8wQkRa?=
 =?utf-8?B?RnUrRGdmRFNiaTlnMkRWMDMzTm95RURXcmt0aVo3UG9rVnJJVmt6TGJNZnBM?=
 =?utf-8?B?RGNNUXRkR3RxTkJaczQ1cmJrdVZmMWZlSU5jZkFmTmkrS2JqQ3FnKzJLallN?=
 =?utf-8?B?aXdVN0hmSHR5dklnODRMNUtvS1JteENDbHFqK0R5eWxCeWl3RVgza2ZYT2JR?=
 =?utf-8?B?aU1KOENDSW91ZWxGdTkxcERjZHZUUEZiTVk1Yzd2YU9hMmtnOGNNMGxoTVNK?=
 =?utf-8?B?UnBSemlJVFB3cUdqVHhHcEo3VEtSb1ZLb0l3VVJuWGRQWUdkVVpWZVZFTTRM?=
 =?utf-8?B?d0RIdUJYZU41d2ExZTFQU0JmZVlWVFQvL2NJeG1YQllrK1AxZEpmb25qTTV1?=
 =?utf-8?B?UW84U3hkdFFuZEsrK2ZJZG9tSmFzbnF1djA2cUc4RTh1VVdRTHhvWk1pRloz?=
 =?utf-8?B?dkdwOEFpRVdaM0NxRG1ZdTI2ZDNhS0t1SjA5NU9SeXptaGIwUVdmUy9hRjhi?=
 =?utf-8?B?Z2JIZjdTTkQrQ201eXJNUHJDSkoyM0c5TjNuRGZnTTQ5NXFTanNXb05PdE0v?=
 =?utf-8?B?MUVCcUc1anpMa2hvTVBtZmc0OXRRREs2dUhtTXFXS1RpTklnTE9EVzlLUnVq?=
 =?utf-8?B?cEhOeTBwblQyaHJLUTRzOGVzZW1iU0VNOUljcXlZUVhhbnVjeCsybVNvOXQ3?=
 =?utf-8?B?aU9KNUpiZ2RYakl2TVMzbEZtbzBpK2dNU0lsWTEvREZGOVZCWktIdTdua2RE?=
 =?utf-8?B?NHhtTmxjUy9qQ3FQamJaRVdML2FUMXFGK0RLSGRMN2xyYVNIbzRQYmZGZkxt?=
 =?utf-8?B?ZEk4elFjV2x2cmdGbVlCV1RYNVE4U0JFbU9uOVdFb3p6cXpqVENLcTlhVU1U?=
 =?utf-8?B?UnVWUUNpVkFlMXd0TzdJWGhsampzL21wVkkvNm9VVFZDOVNadE5BL3RXOWVC?=
 =?utf-8?B?U2JhN2lMTjE2L1luZm5JY3VFTnFFbUo1Unk2SURPa3FES2h5cGR0WTdDdmlh?=
 =?utf-8?B?cXFLTlpkRlE4S25NVkdwSVl2NCtDMnVPRnlCTGFKMGNHSy9ETnU4OE9rc2dS?=
 =?utf-8?B?RHNtWk5HS2lwQnNNcUI0YmRIcHhYVE1FcXFaQnZSR1BNTUhJZnBFdFFyTEJE?=
 =?utf-8?B?N0FoRmFPZXBBWUN1YTM1bUJhaHg2emkvVWVqQ3FpUXdvcG9uMy9IL1VldkFF?=
 =?utf-8?B?MjFyQm0yclVmZ1JBWHYvYlVybmxUQklvMEtQTk9xbnJCWnp0SENsK3JVYjZl?=
 =?utf-8?B?Zkd0NHNha0k3eHhzNkxBek9CdDVBTXM0UHBBQmUvRmFRSGc5VEY4Ynd0dSto?=
 =?utf-8?B?em13SVZNbTN5UUpqeTA4MFVSTkJsVllYVXdSVTRlTi9VNzJJRWEvT293Zklm?=
 =?utf-8?B?ZitzanBrckVlYXoyR2F6OWxWT2JxTzVqSnR0YmQwU3RaV1d6TjczWnRIQU84?=
 =?utf-8?Q?Msm8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815630d9-d159-4b4c-710b-08dc1c1b8ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 13:59:46.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flYFuJGfJHh2C2v7isXtRJKeIyuETFxg0z8IszBEtsgft+01/K21OXBSgJ/MX5FiHxOIv5IbA9bWzA8IgrTRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogY2xvY2s6IHN1cHBvcnQgTlhQIGku
TVg5NQ0KPiANCj4gT24gMjMvMDEvMjAyNCAxNDowOCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gSGkg
Q29ub3IsIEtyenlzenRvZg0KPiA+DQo+ID4gSSByZXBsaWVkIHlvdSBib3RoIGhlcmUuDQo+ID4N
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IGNsb2NrOiBzdXBwb3J0IE5Y
UCBpLk1YOTUNCj4gPj4NCj4gPj4gT24gMjEvMDEvMjAyNCAxMjo0NiwgUGVuZyBGYW4gKE9TUykg
d3JvdGU6DQo+ID4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+DQo+
ID4+PiBBZGQgaS5NWDk1IGNsb2NrIGR0LWJpbmRpbmcgaGVhZGVyIGZpbGUNCj4gPj4+DQo+ID4+
PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4NCj4gPj4g
VGhpcyBzaG91bGQgYmUgc3F1YXNoZWQgd2l0aCByZXNwZWN0aXZlIGJpbmRpbmcgcGF0Y2guDQo+
ID4NCj4gPiBpLk1YOTUgdXNlIFNDTUkgZmlybXdhcmUsIHRoZSBTQ1AgcHJvY2Vzc29yIGhhbmRs
ZXMNCj4gPiBjbG9jay9wb3dlci9waW5tdXgvcmVzZXQvcGVyZm9ybWFuY2UgYW5kIGV0Yy4NCj4g
Pg0KPiA+IEkganVzdCBhZGQgdGhlIGluZGV4IHRoYXQgU0NNSSBleHBvcnRzLCBhbmQgTGludXgv
VUJvb3Qgd2lsbCB1c2UgdGhlDQo+ID4gaW5kZXggYW5kIGdvIHRocm91Z2ggU0NNSSB0byBkbyBy
ZWFsIEhXIGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiBJbiBzdWNoIGNhc2UsIHNob3VsZCBJIHN0
aWxsIGFkZCBIVyBpbmZvcm1hdGlvbiBpbiBhIHlhbWwgYmluZGluZyBkb2M/DQo+ID4gSSBhbSBu
b3Qgc3VyZSB3aGF0IHNob3VsZCBiZSBhZGRlZCBpZiB5ZXMuDQo+IA0KPiBUaGVuIHdoeSBkbyB5
b3UgbmVlZCBpdCBpbiB0aGUgYmluZGluZz8gSSBkb24ndCBzZWUgYW55IHVzZSBvZiB0aGlzLg0K
DQpvaywgc2hvdWxkIEkganVzdCBhZGQgdGhlIGNsayBpbmRleCBoZWFkZXIgaW4gc2FtZSBmb2xk
ZXIgYXMgc29jIGR0c2k/DQoNClRoYW5rcywNClBlbmcuDQoNCg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg0K


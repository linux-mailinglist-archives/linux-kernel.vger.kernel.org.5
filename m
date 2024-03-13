Return-Path: <linux-kernel+bounces-101358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E122287A5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118641C21A88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C823D3A0;
	Wed, 13 Mar 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CES7Z6i0"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF63219F;
	Wed, 13 Mar 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325873; cv=fail; b=tuzGT6Hhu9V/fd9yJQ1w0GKvkB4ZJRvP4ic8l9P5JCn/wVjUzBgu4AM1lDReuzEaCPimAV02nAKY371aPKWts99gzSzNAzyx5HbmSmvzq5RUZsHB2jQICa14vTwjce2KciAcyrr8qd5MtCB3XQbnsbOW1TcluWmqwwcN+ePIJ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325873; c=relaxed/simple;
	bh=IYvQgzNB+iXJ/eaNFB3D535CzHtPLeHeI2pGXr+MLlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQ2fzQWuIWyBLqZy7qfahf1G+BjGIS1vo+k3KGmg0fimDqP95cgA1yima8wf/KHTFvFTDrOvKB7Lzuxaov2ZI72Rdyvh50mSbweaI/+knJb+LLLiAKIqmaI29QZRPAAb/msgNaLBUpSte9EUnFR9iTv/mLYeZeZAQA4hVCIqFNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CES7Z6i0; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVnJOSGbq2HlQj7Xnaw0B86liUqWSi4gGFihT+vDDAmhOf1M7e7Trpi01Ty/fQdCyZ5oGT8v7ZI+Xj+p1yTvaAZFodngK0IAQQcA6AZ4TZ3JdiTBXAGSrhVbOeCUn6XllmQIaiDl+pMhCD33xU8fJP0gz5MOSbdcKh5djVzweTzZHFaaQu/fbwq0XuNKfMh65fNwEotyAxMNRuKNngu+8acHIsUTqdrl/4T4/3gXohObwxYEgTjJRGabVaH/+Zm8ziHIHw6ME5m7BeYHpQzgnBh7NQHSVUryCK5UIoO7fXACHVf8LtP2IsJQUF967UwqH9imcnRRc+ZbXjMI+m/hSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYvQgzNB+iXJ/eaNFB3D535CzHtPLeHeI2pGXr+MLlY=;
 b=ZNkVK+mkgKNerMG7dJMvnX9T546r0hQylkb8/NcE0K0LpklENOLhxIYSEAd40XSbYfrzACCjgC2TO0CYZDNOCjj4F9fKrnmGs9OEXElOh6HB2fDxnbvoFVEBwRIeVI1RFYsYrQuqyzQb7AIr6kRARSFmNmnMNPsCyoLnwIx9ZBg2JXRVeRXOXKnuhGMBHhZHTrAv2T78ou8DCf3q07F5e64bf2yQFuera705PQ03R/ANtE5q1HZgz2rc/h/gltS1791c2LNnCcW/uV3E5MYKeKX1laTkcZEbzrOxc9JAa7kOcja0CTJWUtSPqxVEvRywpgCNUrpNFhIRiUf0G03etg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYvQgzNB+iXJ/eaNFB3D535CzHtPLeHeI2pGXr+MLlY=;
 b=CES7Z6i0Nw/sQ39dns5AwqnNoA8pZM1QR6S/GILMXpVt7cP9skmAbKUPlovwqWUV7Qb2sHlp2rEseA1DUSaZ/X6grsCnspmQCGKj1xj1ZjXNskgf0cyNzPtSPE9+oyUJP9nBtc40SyEsNMUA2ZKT+F6qMNgj6Yow33+eCiFn+Lc=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Wed, 13 Mar
 2024 10:31:08 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 10:31:08 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"peter.chen@kernel.org" <peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Topic: [EXT] Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Index: AQHadF4T9fa4/JJRF0KTO2HRURFsjLE0MIuAgAC6gbCAAFuNgIAAM6Gw
Date: Wed, 13 Mar 2024 10:31:08 +0000
Message-ID:
 <DU2PR04MB88223A3AE090F4208288F9F98C2A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
 <20240312091703.1220649-5-xu.yang_2@nxp.com>
 <20240312145035.GA2204647-robh@kernel.org>
 <DU2PR04MB8822976F9F052E18D7951FA48C2A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
 <fa0ae368-7383-4d50-b924-67f10af75ffd@linaro.org>
In-Reply-To: <fa0ae368-7383-4d50-b924-67f10af75ffd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS8PR04MB8150:EE_
x-ms-office365-filtering-correlation-id: 5a5df677-ae71-4ccd-54ae-08dc4348b20f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TOVRyUQkPTJyeecRpWxrzKZnsRrko2k3rnp5pnAJgdwMdcFx/M53SrCqsBT86pTlGy9dg0YJy6/8pu1sRIONAot+iRow0D88KT8Ejsrc8Cs3AFWqp3MaCR8OMaI60dZoOdi1Z41Eq5zqrY9g9V6RgVMnYUXpi9yU3/EogODfFVzb9OgsY4HXp3Cn5g6vVrrf+ceH8tGUQqenL0Msce6jaarJdmcXcim7O4w0JlP+LYO4iQVXBt0PTW9oXTVeV86iFSpc9gDX+WFS3BoW6+Wv2uaDhaRDipECY6qaB/a4GzVNeQDwVr3Q+o8+YYDTOsLQdQmVBqaX6HZ3yVSuKhs/sJ3kDhY+VxIi3H5GIPjCJMj6SV9G9LMDcrz/Td/Ho9nXWi9x/2DcfcrHxRCdpAQuKomJTzGksTGSsJUNKe0hRCoRyiO5lc9iUISylZttvb0gOg7qNkcRzig7+awlusnj7q2TYb42nwSPGFMvsSJklQ8X5o/4/sYHWnFNw+vU+YrsVzIeNud/rkkr6x5UrdpSILMALtNIKV4LuItniQ0ZOyj2EaUMrEEXVnyn7754NGKh7XV7pHBIXIdBwh8DYhR9lPF5USgKVfE58YpWGBZ7m6ATMU4Jl9U5nWB52bPTbQo/WOKG5eoVhK/Th1+GGhf9P0g93kYU6ebc+AY5X4EEXbm8M14KQWjtCFKYV3nQ/PuPumIp9i8mtI6YrFzVRw6nurCLbiUvNm2AYDy6my9ALyE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajlrVWUzVkNjeGdaTHlhVGFHdEJ2YUxUUlA3QXp1aThnUXVycURCU3AvNXk3?=
 =?utf-8?B?U3RpN1RNNGhHRFR5MnVwY3UzT2w5SnhTMXRmU2dTcWhsSWRvTEJwMVdVb2RG?=
 =?utf-8?B?YTNCeEhIbVFmc0VWSVZkVFIwcVk5QStpdkZTV2lvZTYxRDZKQUV3M0R1d0M0?=
 =?utf-8?B?Y3lYWmRralRITHFrN0FOczY2bjlNQXFIa3FvYzkvNzRpdldLZExnTnFDRlpa?=
 =?utf-8?B?V2p3ZjBYTzlmcnAvYVJNN29UTVFkeEthR2QzYkxzTmVGN3ZiaUJxOXJib1Vs?=
 =?utf-8?B?WTVTWFBwTHRYQUVyYWRtUWZZWTEvMEd1MmxrODlkYXpSSkVVczNzR2xCT0xU?=
 =?utf-8?B?alE1RXBYV2UrOEhjVC8xckFzbjZYeEpKTldPZ016ZGZ2L1dJcks2M0UzalZL?=
 =?utf-8?B?MmZPa2tJb3hndit4VkRyUHZnSE5sUis3WWZITDExRVF4VEpNYXBxSEMzVVU4?=
 =?utf-8?B?NkMyY1VIbEpHc0Mva1cxaW40L0oyUDFXaVVyTzZlZXpKTlpzRUxKNElyQTUw?=
 =?utf-8?B?aTd3MWoyaXA3QnVrK04xUXJod2lZekNMTkN6TlJ2bGMraGtyOVBFUFRhc3hR?=
 =?utf-8?B?Sko1LzBna0M0bDU3Q3NSdlIvUUhmQ0FNMmx5UTg0VWJCOWgxN09VYm1BaVM2?=
 =?utf-8?B?VVl3Q3RtZlRwSDlBclcxbmhLZFNEMzNWV0MxS0pPQXE0K2JMUm5QTDRYYmFQ?=
 =?utf-8?B?cTFrQlF0SWhjWE9VN3luSVo5Q25pampWTnorN3krTlU2MC9teXYrVWpUeVoz?=
 =?utf-8?B?YlFLSUdWM3VjUmdnYTFSZlNvaytBdTdZekV0ZUtRRDdhRDBwTWpTSnhqdHUz?=
 =?utf-8?B?am1NdHY2WDkyeEUwb1RUeWtvcERKQUluSDdrTUhSV3FUOUFSY3ltY3phL2tt?=
 =?utf-8?B?bmE4Q3hqR25ja2VDNzJaaVhvVHlOLy8wcWhvSkQ3VjlFWmFoMW1DcFpDTmNn?=
 =?utf-8?B?RXhjSXAxUUxEUXZzTml6TG5EZGdiTEhpM3QxQXBUelRzREYxOVZYM1VEWjNN?=
 =?utf-8?B?c0lUalNxSUdzRldHRDUvcENyV3VMK3dlSWZISmhoQ3hMOGJLdVF4MCtQVHh6?=
 =?utf-8?B?cnFWVGp3VEhhWTN0NHpkMmhBOGRETmJwOXNYZWRzRXlaeEFQejIyTTcwNkZ5?=
 =?utf-8?B?T1RZOEhKYWdiVzZseW1MOU1hc3Y0RUh2VVNHZjdRVnRXT1pGNWhXenhOcVI4?=
 =?utf-8?B?eXV3TWZaYWdoK2lrcVBydytiTC9tcW1hRSs1eXVkVTQrSHNLY2J6WEIzYjVv?=
 =?utf-8?B?Wm5HRkdHcThtV1diR2ppbXlxNG83YW5lMVJIdnJVYUJrTjRERkZLeXhJa3dk?=
 =?utf-8?B?UERpbVBxVU12T1FCV21tRmNZcTVyQW5RdEZ2bEQxUUEwWUJqTlVZMDV0T0JN?=
 =?utf-8?B?VklHcWV2Y25kZVNoUGsvekhSMWFIYTFZMjZJbGRoNU5IajVXMGlIZG9xSmk1?=
 =?utf-8?B?ZmN1L0loWWZSSHZZZ1hBTHZ2eThrR0U3dmRSR0xHd0xyWVc2Y25Ta09DR1VG?=
 =?utf-8?B?aDBDOExhbGtzaVY5K0UvRU9oZkxKWVRLSktHcGcwRzlkbWpDSEJVN0pUZ2lm?=
 =?utf-8?B?ZyswbjNnYWRRWUxaZEtGaVV3bGUvY0NwcWpiWE9IcUc1VzNMbWNtWG5qQmJE?=
 =?utf-8?B?QXExalRLOHlyR1JTNG80VzB0RmFNVFozQnlGQW11TmNuT0Nva1hPdmdhUXk4?=
 =?utf-8?B?M1Fqa0I5WEZ6cEdWUkloT0lGd1RWOVhKNkVPRkZGQlBBcCtwbjI0VGFqd0Uw?=
 =?utf-8?B?SGpBSEtVVXVhRWJycWcxd2c4ZjVVNDhKekY4dnh3WVBsOXhnVUlqYWZJazJ5?=
 =?utf-8?B?am9DUll0eXNHZU9ETDN2cjBTRytZVS9jY0Z0ODNzOXdHc1U2MmhtZFJTU29F?=
 =?utf-8?B?VHBaRWlnUkxhVU5HQWE5K29HbXo4eS9vcC9iZzk4SjNITEpLV0pQMldVdG0y?=
 =?utf-8?B?MllxSHRxcCt2SndaaWcvdHZCbHYvd3lhVG4zMVZIWHdyTEJqcmFKYjVXWUVK?=
 =?utf-8?B?ODh3RXN0dXlDM3d5bWdzaUVCcmxyQXdJZzBTSDNYKzJadUZVMmF2OEhxbXZk?=
 =?utf-8?B?blB3MVNUQ1MrMGprNTg3QlNjcE1lQXhCVmdSR1ZEZ1RvdzJNRzZQeHZYSTM3?=
 =?utf-8?Q?4B9k=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5df677-ae71-4ccd-54ae-08dc4348b20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 10:31:08.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypg7jp3Z/l7z/XvXQ2M7+sOv8ygrF1KUnCTB5W36d85dpNa6rlk42MQGJKUf8cB+HP2qRPvX5qqyuSLkAohv+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

DQo+IA0KPiBPbiAxMy8wMy8yMDI0IDAzOjQ4LCBYdSBZYW5nIHdyb3RlOg0KPiA+Pj4gKw0KPiA+
Pj4gKyAgIyBpbXg3ZCBTb2MgbmVlZCBvbmUgY2xvY2sNCj4gPj4+ICsgIC0gaWY6DQo+ID4+PiAr
ICAgICAgcHJvcGVydGllczoNCj4gPj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4+PiArICAg
ICAgICAgIGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXg3ZC11c2IN
Cj4gPj4+ICsgICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14MjctdXNiDQo+ID4+PiArICAgIHRo
ZW46DQo+ID4+PiArICAgICAgcHJvcGVydGllczoNCj4gPj4+ICsgICAgICAgIGNsb2NrczoNCj4g
Pj4+ICsgICAgICAgICAgbWF4SXRlbXM6IDENCj4gPj4+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0K
PiA+Pj4gKyAgICAgICAgICBtYXhJdGVtczogMQ0KPiA+Pg0KPiA+PiBXaGF0J3MgdGhlIG5hbWU/
DQo+ID4NCj4gPiBDYW4gSSBub3Qgc3BlY2lmeSB0aGUgbmFtZSBzaW5jZSB0aGUgbWFjcm8gZGVm
aW5pdGlvbiBmb3IgVVNCDQo+IA0KPiBCdXQgeW91IG11c3Qgc3BlY2lmeSBuYW1lIG9yIGRpc2Fs
bG93IG5hbWVzICg6IGZhbHNlKS4NCj4gDQo+ID4gY29udHJvbGxlciBjbG9jayBpbiBjbG9jay5o
IGlzIHJlY29nbml6YWJsZSBhbmQgdGhlIGRyaXZlciBkb2Vzbid0DQo+IA0KPiBoZWFkZXIgaGFz
IG5vdGhpbmcgdG8gZG8gd2l0aCBpdA0KPiANCj4gPiBnZXQgdGhpcyBjbG9jayBieSBuYW1lIHJh
dGhlciBpbmRleD8NCj4gDQo+IERyaXZlciBkb2VzIG5vdCBoYXZlIHRvIHRha2UgY2xvY2tzIGJ5
IG5hbWVzLCBpdCBkb2VzIG5vdCByZWFsbHkgbWF0dGVyDQo+IHRvIHN1Y2ggZGlzY3Vzc2lvbi4g
SWYgeW91IHByb3ZpZGUgY2xvY2stbmFtZXMsIHRoZW4gdGhlIG5hbWUgc2hvdWxkIGJlDQo+IGRl
ZmluZWQvZml4ZWQuDQoNCk9rYXkuIEkgZ2V0IGl0Lg0KDQpUaGFua3MsIA0KWHUgWWFuZw0KDQo+
IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


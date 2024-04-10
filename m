Return-Path: <linux-kernel+bounces-138039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9A89EB64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9AF285538
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61113C90C;
	Wed, 10 Apr 2024 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TnBJtjRf"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C120E3;
	Wed, 10 Apr 2024 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732747; cv=fail; b=o2GBpKqz9TqZQleSMe1f89Q8d2DyBAy9/ccuq5yoUkNTkk6vrh3MUc0l67+JLYGxEWoNPyAs7iOTKUhPJArwmHpJPJjzqLNuRyIegO8vd4XfZqYmSOWk/y3xB+RVakN9EVsS2ndYtTRFUS1Jx7ewIOuUfAqyWMLEXWo3eWZ04Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732747; c=relaxed/simple;
	bh=V4kCBdl8SswnLrxcgJhjPB1EsJQhmLKryc6Vkf74lXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iW/e3eb4waC9dQg5h/3cJTpi4CSg54yrMKfvAZ5RIowY+XAnfB+z/KgmDyFfMGNqnzTdQyR08h4qYFNVENuCdNd8ePiwEf/KQrxhv0Ab1GGQ3+e71tpjfDw/b+Qrm93RB72uDP/k29UqWCAYFPln5KbusSBKvndw+vhHeydhvI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TnBJtjRf; arc=fail smtp.client-ip=40.107.20.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKVkZu3krXnrgXM0P3DDc1aOjxoKHjUJe4r+kQpws1eO11w/qn9I7VPzycgk4mZy3IKnqffhoHJ4QLwdSu37WGveA6tVfk8joBqWHfngVQecvpvul0lJnkvBUNWqb2KgCk01O5mlXmbuXx0o3PAAAMWuojqftT8k9TCj+G6U53pI636gung+KmoTzWTb9uN1rhq8cvLccePlE9Wc4nuKy3kPBrDQhx1xLXkMAZpShcvr+clE5PLjYEbLch2NVAWF9JxsCurAaWra3nv2oSo3yJCfQSBfLlrRfO1bKuJsTAhs+h1/y6LaFrPKj+7sEoj7tg3n8r9JZeNnbzB07GRZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4kCBdl8SswnLrxcgJhjPB1EsJQhmLKryc6Vkf74lXQ=;
 b=HyybzMYq/5ALl3peoqIdyuReXo+HJS4pXV5gZb7dAFWzWlq0mD6QcPWDFE+TTdoW2xjHXOUQ2UleEtneb9uXL37L52nskFjwACmsf7i+qqgqHujsiS6e+EB3u2yjakkyN+N3HCknXw4lfHefbSFcbiZUBEGVh3iHoUMh8WXYmA8p4OI1VRnjzBeU1Eoj5LLze2/EtRVQzo8kRKFqUH0uukZxQV2y54uwfrd+UK30n6d9U6MUwBf+Kae9hS8lkTrDP+qf1E7zVOaUE2ZZHs46W/CqGDOtAZaHHQTchez+CGzkRUtpjmhKDRoB3LPQZzCWSMbS3Bybi3cV1xD1otQDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4kCBdl8SswnLrxcgJhjPB1EsJQhmLKryc6Vkf74lXQ=;
 b=TnBJtjRfofL+aLI0f9RhJBIa+04vO+ZX12HH8bgOTgBXLH9sZ1q83HwC8tDRecEVpSPtCcFfqAdQW9Ns4BnZJSnyQG8WEyw7+SFwOzSzoAFU/eUi1xdvhV7NxV84hhckni3Ut2ELjbctvkx9tsBBGKxxnq7IvVYSJ3cRjvJj9aQ=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI2PR04MB10266.eurprd04.prod.outlook.com (2603:10a6:800:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:05:43 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:05:42 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Gaurav Jain <gaurav.jain@nxp.com>, Horia Geanta <horia.geanta@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, 'Herbert Xu' <herbert@gondor.apana.org.au>,
	"'David S . Miller'" <davem@davemloft.net>, Iuliana Prodan
	<iuliana.prodan@nxp.com>
CC: "'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: RE: [PATCH] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH] caam: init-clk based on caam-page0-access
Thread-Index: AQHZsvA+WWrJieH4YkOWcmdVA0ACEa++PL0AgADTpXCBoiCZwIABkloAgAABquA=
Date: Wed, 10 Apr 2024 07:05:42 +0000
Message-ID:
 <AM9PR04MB8604A7E92C450BFE20ADF1A595062@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
 <06bbe95c-118a-0e19-3480-49fc42f3dcb0@nxp.com>
 <DU2PR04MB863006A155869F804AB624439501A@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <AM9PR04MB8604DB56777FE12C7C3BFBFB95072@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <AM0PR04MB6004E4E4430B7CDEA6FAAF30E7062@AM0PR04MB6004.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM0PR04MB6004E4E4430B7CDEA6FAAF30E7062@AM0PR04MB6004.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VI2PR04MB10266:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J+rN5hrPmbr9aOtnyZHK1eElC3dLyj8MUxqh88c58g4NXw6vK7AjBCKpHaERNZQ9rNc8E46l2wL9uN9I+d69AwBIMEgAv7te/vnqtPszZVsRhgh57fT8INtWghUv9/g+awDkjKQN6YRzwo85DLUj+pOiK1CQm/5mAt0aGKss9s/CTw5e/NQpqpDQ/78bgLqpW9zCb63MX+HX9UlLlXunVAuhoKt0bc1SQLEkOfnXuZrlf4uQZ29b+XvJT6aS0JOeGwoXi/3z1jlqjNA/Hu/UvqDQ3hcnKhy2AVn4AOCLbD/AGCKQlw8O7mS//rB1zm2sIFQSB63/kzF55lG04GYoDWakJOIG/Fiv3c3ZjWFIrUECAX3z8sRaB42PMOMwbO8ItiMI+3Gi4EtNDT+sQ+IhY6IVc0EpL6bzAbI6dhIkQhZaEKfLTig1W2BVB1VzcASyD8ugswyn4ONm9qfoXDFmy04PB1umsu87Qr6pkUpcCryTDQpKVwFT8hZzNHvLmSZIzApV4KyC2ZuP5kJvDNTLWVzP/TFOk/bGBZRpXLEMV1pOXN6Dy4hv/qBFq0fHj505f54uhBKQ1jBABMoZNVM80fcSxLMPY4PsbRzDHwwYniARGRJ5x/XGSczbCE6f8qpdlIhDX6tnxz4AOewmGDkP7/+kIlhEmElwdE05TMs3xRg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkxHUUwrcHVKR3JteHZSb2N4eGRPV1VSeWF4N05hNUJlSmtRUldsbG03MGJP?=
 =?utf-8?B?SzRRV1FpdmtLbkJaUlRSMWhPVEJFak84b213SEhMTDhiT3BrODFUbmZGbkxl?=
 =?utf-8?B?OEsvWWNzd1o5U0gyVDdpaWFMRE9Ocno5VnplMlUvRmZ4MlRDbXBxZUUyNVgr?=
 =?utf-8?B?R0xETXVQYTFBNTcrS2pXaFJNekhwdDlzOEhWNTBEU0VJWnZ4Y2c4VFdkeHNR?=
 =?utf-8?B?amd2cTl4bHVhWXdoWWN0dlAya0x5dmJKeGxBdzhJSWZ1OGlUVVRXYjBnTjQ4?=
 =?utf-8?B?V3RIbERyNEp5Mm9ZdzVpVjIwcXR3a05kUmdNclV4dUhNTXJZNFVRQVVCcFlI?=
 =?utf-8?B?SDIvN25uaHJMcGJ4dkhUUGdlMDFrTTdwVGI5ZzFaSWZGeUpDRXNrS2Q5Rmgv?=
 =?utf-8?B?bXU1QU13MXdMQ1huK0NqNUlZRFZ4MzNLdEpHeUVpc3lVN2NmTi96NUFTZ1Ez?=
 =?utf-8?B?TVYvY09qdXJHYmttQ0pocURCQmdlTm9ZUUR6RmJCZ2wrY3ZDQXBjV2tsTHp0?=
 =?utf-8?B?UEhYUmZXY2ptOUVLMWc1U3NpVXNzKzVlMDZ6YTh2azRqVVd0czBYRUFzR0NW?=
 =?utf-8?B?UGNCMUZDRFJucUZabC9iOVdVaWNubnlUVUZaR1gwakhsaWhOUk9tSGhYMVVL?=
 =?utf-8?B?elMzeDViS3hhck4yQS9HVUs3MEhjUW02b2s1aTMyaDRnMW5iMDdINlhiQWZa?=
 =?utf-8?B?Q2RFRkN6TEJWL095L3NCR3NuSFhyeVJLVFNTcSt6emNaaytuTk5HM250ZGNK?=
 =?utf-8?B?U09sbTliOTZudGUrWmJrUkxUc3U1WmdsMlZPMnZiY2Q3RS91Q09RZk1CbWlH?=
 =?utf-8?B?Rncrdm85NHVEb3RxUUVJZ2JsemVhUGtGMDkwejBhdHpHVnBMSCs3NDdXVkhJ?=
 =?utf-8?B?eElVWjVZTGtWdzhMWUErbEl4ajdFVWFSUTN4RXNPRndxZzVJVlNVNDVEd2o5?=
 =?utf-8?B?VUpuMnU1S1JnMTJ2MUx5TWpqT3dZSW5takVoNXZZM2h6WERyQ1MvY1J5MC85?=
 =?utf-8?B?UnBzRXpGSTVYQ1dKazlDUTNlb1pUZ2piMGtUTGJ1M0hVS2EzY3VOV2hnT1Np?=
 =?utf-8?B?SkkrUlduZllNbDRkZ0w3YzYwWmVybEdnd1llZDV0UXJwVmtTaFpKU09nbytt?=
 =?utf-8?B?b1grSitGZnpvbHBKd2laUDg3bmgwNkdjSm5CWnRISDRFK2F5UDdsRXJ1Z283?=
 =?utf-8?B?a2Z4T0R0KytpWUZydUR1cFhzRnhEUHVlQ2FFRXBTNTBSWi9uM1AzWEk4clNi?=
 =?utf-8?B?RlF3WUZCbTNNWjY4bHdLbDdieXZuODIwU25IUldMeCtwcjE5YTR5Sm5jVGpj?=
 =?utf-8?B?ZkVWV2F6YUV4TkNxazRlRVV6Qk9QaGZCc3Noa1NRcERtbDhEbGtZZ1VyeXdv?=
 =?utf-8?B?WmFUaForWEUzQ3BYTmhZMkJFTFluOU9RNEJUcURvTWdmZDlVR1MvSWw2aXpl?=
 =?utf-8?B?N2RtR3RmSVkrTFJuUEtQZnlQekFKRVJFa3ZPSVdpWWlEeS9KV0FNTldaU0pm?=
 =?utf-8?B?Rld0MkdzSUdUb1d0YmxPcjZJV3JVeUJIL2EwM0dxT01HOGl3VHcyb1duRXdP?=
 =?utf-8?B?WDlzWHpJdG5Oa0tOMzFsNk1jNnp2bVFUVTQ3ektBeFA2cElkQmhzNXRCWisz?=
 =?utf-8?B?N3VKaHlVVEpEVmtxUW5PSHcrWFpLTGIyWW1HZklzVWVJWmNyQ2JlaU5rZnFr?=
 =?utf-8?B?VldEcE5CUHVaZGh6Uk1UK2IvdDJtakhGTmRaaFFqSnVrSk9KaW9pZEp0bTFX?=
 =?utf-8?B?YUFvYWYzcEVOZ2s5aGRLVzU5Vm96Kys0dy9LckVRSkRWcVNESW1FcXliUjk2?=
 =?utf-8?B?UCtIbWlqM1NNMi9LVW41WUgvVm94VkVLQUhueWZtSFh0MXdhbU96MTBWbm9Y?=
 =?utf-8?B?RU01TmRIMEZCcGZUQ0l0ZDdhNFBabUwwT0xiUWlWdVVQL1hoVVA3MEoycDc2?=
 =?utf-8?B?QXFyL243ZXVuVXRHL2NDOHY0NXNRTUN2VEszdTN3c1l4eTdJUXN3QU5SOE9r?=
 =?utf-8?B?MGs3M2JKaDBoVTVBalZyVWdGWjFpNW9tTjFDUjV3MFY1bkhXeU40ZkNzNUJt?=
 =?utf-8?B?WHk5UHQ3UHJ6Z0NsSWMvTS9EeEUyMkhDNGtNbjNVV2lOU0lsS28yN0JVRG9h?=
 =?utf-8?Q?qzIgvM+qWtSPrgYzYPgBF5vzQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792e7cd4-1ea0-41a3-25d7-08dc592ca317
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:05:42.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtwLpgnhKXAyimcS+DFMl9XFU0eQM675xL9tu7k6R7j6bPx90iUfbMP4LT9wmWu9k/IwoOhLu18wRqRd9a2X0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10266

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2F1cmF2IEphaW4gPGdh
dXJhdi5qYWluQG54cC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTAsIDIwMjQgMTI6
MjkgUE0NCj4gVG86IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+OyBIb3JpYSBH
ZWFudGENCj4gPGhvcmlhLmdlYW50YUBueHAuY29tPjsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhw
LmNvbT47ICdIZXJiZXJ0IFh1Jw0KPiA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgJ0Rh
dmlkIFMgLiBNaWxsZXInIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gSXVsaWFuYSBQcm9kYW4g
PGl1bGlhbmEucHJvZGFuQG54cC5jb20+DQo+IENjOiAnbGludXgtY3J5cHRvQHZnZXIua2VybmVs
Lm9yZycgPGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc+OyAnbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwtbGludXgt
aW14IDxsaW51eC0NCj4gaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGNhYW06
IGluaXQtY2xrIGJhc2VkIG9uIGNhYW0tcGFnZTAtYWNjZXNzDQo+IA0KPiBIaSBQYW5rYWoNCj4g
DQo+IFBsZWFzZSBjaGVjayB0aGUgYmVsb3cgY29tbWVudHMuDQo+IA0KPiBSZWdhcmRzDQo+IEdh
dXJhdiBKYWluDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
UGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIEp1
bHkgMTAsIDIwMjMgMTE6MDMgQU0NCj4gPiBUbzogSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFA
bnhwLmNvbT47IEdhdXJhdiBKYWluDQo+ID4gPGdhdXJhdi5qYWluQG54cC5jb20+DQo+ID4gQ2M6
IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4gU3ViamVjdDogW1BBVENI
XSBjYWFtOiBpbml0LWNsayBiYXNlZCBvbiBjYWFtLXBhZ2UwLWFjY2Vzcw0KPiA+DQo+ID4gQ0FB
TSBjbG9jayBpbml0aWFsaXphdGlvbiB0byBiZSBkb25lIGJhc2VkIG9uLCBzb2Mgc3BlY2lmaWMg
aW5mbw0KPiA+IHN0b3JlZCBpbiBzdHJ1Y3QNCj4gPiBjYWFtX2lteF9kYXRhOg0KPiA+IC0gY2Fh
bS1wYWdlMC1hY2Nlc3MgZmxhZw0KPiA+IC0gbnVtX2Nsa3MNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvY3J5cHRvL2NhYW0vY3RybC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMgYi9kcml2ZXJz
L2NyeXB0by9jYWFtL2N0cmwuYw0KPiA+IGluZGV4DQo+ID4gZmY5ZGRiYmNhMzc3Li43NGQwYjc1
NDFkNTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2NyeXB0by9jYWFtL2N0cmwuYw0KPiA+IEBAIC01MTEsNiArNTExLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY2FhbV9tYXRjaFtdID0gew0KPiA+IE1P
RFVMRV9ERVZJQ0VfVEFCTEUob2YsIGNhYW1fbWF0Y2gpOw0KPiA+DQo+ID4gIHN0cnVjdCBjYWFt
X2lteF9kYXRhIHsNCj4gPiArCWJvb2wgcGFnZTBfYWNjZXNzOw0KPiA+ICAJY29uc3Qgc3RydWN0
IGNsa19idWxrX2RhdGEgKmNsa3M7DQo+ID4gIAlpbnQgbnVtX2Nsa3M7DQo+ID4gIH07DQo+ID4g
QEAgLTUyMyw2ICs1MjQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19idWxrX2RhdGEgY2Fh
bV9pbXg2X2Nsa3NbXQ0KPiA+ID0geyAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IGNhYW1faW14X2RhdGEgY2FhbV9pbXg2X2RhdGEgPSB7DQo+ID4gKwkucGFnZTBfYWNjZXNzID0g
dHJ1ZSwNCj4gPiAgCS5jbGtzID0gY2FhbV9pbXg2X2Nsa3MsDQo+ID4gIAkubnVtX2Nsa3MgPSBB
UlJBWV9TSVpFKGNhYW1faW14Nl9jbGtzKSwgIH07IEBAIC01MzMsNiArNTM1LDcgQEANCj4gPiBz
dGF0aWMgY29uc3Qgc3RydWN0IGNsa19idWxrX2RhdGEgY2FhbV9pbXg3X2Nsa3NbXSA9IHsgIH07
DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBjYWFtX2lteF9kYXRhIGNhYW1faW14N19k
YXRhID0gew0KPiA+ICsJLnBhZ2UwX2FjY2VzcyA9IHRydWUsDQo+ID4gIAkuY2xrcyA9IGNhYW1f
aW14N19jbGtzLA0KPiA+ICAJLm51bV9jbGtzID0gQVJSQVlfU0laRShjYWFtX2lteDdfY2xrcyks
ICB9OyBAQCAtNTQ0LDYgKzU0Nyw3IEBADQo+ID4gc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfYnVs
a19kYXRhIGNhYW1faW14NnVsX2Nsa3NbXSA9IHsgIH07DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBjYWFtX2lteF9kYXRhIGNhYW1faW14NnVsX2RhdGEgPSB7DQo+ID4gKwkucGFnZTBf
YWNjZXNzID0gdHJ1ZSwNCj4gPiAgCS5jbGtzID0gY2FhbV9pbXg2dWxfY2xrcywNCj4gPiAgCS5u
dW1fY2xrcyA9IEFSUkFZX1NJWkUoY2FhbV9pbXg2dWxfY2xrcyksICB9OyBAQCAtNTUzLDE1ICs1
NTcsMjMNCj4gQEANCj4gPiBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19idWxrX2RhdGEgY2FhbV92
ZjYxMF9jbGtzW10gPSB7ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2FhbV9p
bXhfZGF0YSBjYWFtX3ZmNjEwX2RhdGEgPSB7DQo+ID4gKwkucGFnZTBfYWNjZXNzID0gdHJ1ZSwN
Cj4gPiAgCS5jbGtzID0gY2FhbV92ZjYxMF9jbGtzLA0KPiA+ICAJLm51bV9jbGtzID0gQVJSQVlf
U0laRShjYWFtX3ZmNjEwX2Nsa3MpLCAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGNhYW1faW14X2RhdGEgY2FhbV9pbXg4dWxwX2RhdGEgPSB7DQo+ID4gKwkucGFnZTBfYWNjZXNz
ID0gZmFsc2UsDQo+ID4gKwkuY2xrcyA9IE5VTEwsDQo+ID4gKwkubnVtX2Nsa3MgPSAwLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0
ZSBjYWFtX2lteF9zb2NfdGFibGVbXSA9IHsNCj4gPiAgCXsgLnNvY19pZCA9ICJpLk1YNlVMIiwg
LmRhdGEgPSAmY2FhbV9pbXg2dWxfZGF0YSB9LA0KPiA+ICAJeyAuc29jX2lkID0gImkuTVg2KiIs
ICAuZGF0YSA9ICZjYWFtX2lteDZfZGF0YSB9LA0KPiA+ICAJeyAuc29jX2lkID0gImkuTVg3KiIs
ICAuZGF0YSA9ICZjYWFtX2lteDdfZGF0YSB9LA0KPiA+ICAJeyAuc29jX2lkID0gImkuTVg4TSoi
LCAuZGF0YSA9ICZjYWFtX2lteDdfZGF0YSB9LA0KPiA+ICsJeyAuc29jX2lkID0gImkuTVg4VUxQ
IiwgLmRhdGEgPSAmY2FhbV9pbXg4dWxwX2RhdGEgfSwNCj4gPiAgCXsgLnNvY19pZCA9ICJWRioi
LCAgICAgLmRhdGEgPSAmY2FhbV92ZjYxMF9kYXRhIH0sDQo+ID4gIAl7IC5mYW1pbHkgPSAiRnJl
ZXNjYWxlIGkuTVgiIH0sDQo+ID4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gPiBAQCAtNzU2LDYg
Kzc2OCw3IEBAIHN0YXRpYyBpbnQgY2FhbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAJaW50IHBnX3NpemU7DQo+ID4gIAlpbnQgQkxPQ0tfT0ZGU0VUID0gMDsNCj4g
PiAgCWJvb2wgcmVnX2FjY2VzcyA9IHRydWU7DQo+ID4gKwljb25zdCBzdHJ1Y3QgY2FhbV9pbXhf
ZGF0YSAqaW14X3NvY19kYXRhOw0KPiA+DQo+ID4gIAljdHJscHJpdiA9IGRldm1fa3phbGxvYygm
cGRldi0+ZGV2LCBzaXplb2YoKmN0cmxwcml2KSwgR0ZQX0tFUk5FTCk7DQo+ID4gIAlpZiAoIWN0
cmxwcml2KQ0KPiA+IEBAIC03NzIsNiArNzg1LDE1IEBAIHN0YXRpYyBpbnQgY2FhbV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJY2FhbV9pbXggPSAoYm9vbClp
bXhfc29jX21hdGNoOw0KPiA+DQo+ID4gIAlpZiAoaW14X3NvY19tYXRjaCkgew0KPiA+ICsJCWlm
IChpbXhfc29jX21hdGNoLT5kYXRhKSB7DQo+ID4gKwkJCWlteF9zb2NfZGF0YSA9IGlteF9zb2Nf
bWF0Y2gtPmRhdGE7DQo+ID4gKwkJCXJlZ19hY2Nlc3MgPSBpbXhfc29jX2RhdGEtPnBhZ2UwX2Fj
Y2VzczsNCj4gPiArCQkJLyoNCj4gPiArCQkJICogQ0FBTSBjbG9ja3MgY2Fubm90IGJlIGNvbnRy
b2xsZWQgZnJvbSBrZXJuZWwuDQo+ID4gKwkJCSAqLw0KPiA+ICsJCQlpZiAoIWlteF9zb2NfZGF0
YS0+bnVtX2Nsa3MpDQo+ID4gKwkJCQlnb3RvIGlvbWFwX2N0cmw7DQo+IA0KPiBPUFRFRSBlbmFi
bGVtZW50IGNoZWNrIGlzIGlnbm9yZWQgYmVjYXVzZSBvZiB0aGlzIGdvdG8gc3RhdGVtZW50Lg0K
PiBSZWdhcmRzDQo+IEdhdXJhdiBKYWluDQoNCltBY2NlcHRlZF0gV2lsbCBiZSBjb3JyZWN0ZWQg
aW4gVjIuDQo+IA0KPiA+ICsJCX0NCj4gPiAgCQkvKg0KPiA+ICAJCSAqIFVudGlsIExheWVyc2Nh
cGUgYW5kIGkuTVggT1AtVEVFIGdldCBpbiBzeW5jLA0KPiA+ICAJCSAqIG9ubHkgaS5NWCBPUC1U
RUUgdXNlIGNhc2VzIGRpc2FsbG93IGFjY2VzcyB0byBAQCAtNzgxLDcNCj4gPiArODAzLDcgQEAg
c3RhdGljIGludCBjYWFtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
IAkJY3RybHByaXYtPm9wdGVlX2VuID0gISFucDsNCj4gPiAgCQlvZl9ub2RlX3B1dChucCk7DQo+
ID4NCj4gPiAtCQlyZWdfYWNjZXNzID0gIWN0cmxwcml2LT5vcHRlZV9lbjsNCj4gPiArCQlyZWdf
YWNjZXNzID0gcmVnX2FjY2VzcyAmJiAhY3RybHByaXYtPm9wdGVlX2VuOw0KPiA+DQo+ID4gIAkJ
aWYgKCFpbXhfc29jX21hdGNoLT5kYXRhKSB7DQo+ID4gIAkJCWRldl9lcnIoZGV2LCAiTm8gY2xv
Y2sgZGF0YSBwcm92aWRlZCBmb3IgaS5NWCBTb0MiKTsNCj4gQEAgLTc5Myw3DQo+ID4gKzgxNSw3
IEBAIHN0YXRpYyBpbnQgY2FhbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gLQ0KPiA+ICtpb21hcF9jdHJs
Og0KPiA+ICAJLyogR2V0IGNvbmZpZ3VyYXRpb24gcHJvcGVydGllcyBmcm9tIGRldmljZSB0cmVl
ICovDQo+ID4gIAkvKiBGaXJzdCwgZ2V0IHJlZ2lzdGVyIHBhZ2UgKi8NCj4gPiAgCWN0cmwgPSBk
ZXZtX29mX2lvbWFwKGRldiwgbnByb3AsIDAsIE5VTEwpOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo=


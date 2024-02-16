Return-Path: <linux-kernel+bounces-68161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780038576A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0531A1F252AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F8168DA;
	Fri, 16 Feb 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="WZ3xhvbx"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2103.outbound.protection.outlook.com [40.107.128.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53317BB4;
	Fri, 16 Feb 2024 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067568; cv=fail; b=Mpd3eq8is+RY+yAfDlfSBiKkvWb/6a1HqNhT3Ng4vPLtbU8r4GpBgXl4qcwISiCBswpDAlXw9kogEMpxt8zbT88aC2HSTWVkazuzLiMPpR2rkC31udpbExdA86G7GchjfGAuEOZcjVmg6GmJPb19f8+IoJCaDgA/OwqYky2agd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067568; c=relaxed/simple;
	bh=zLdRWnQrPlCTJwDvuB0O0k6i0Rw+LG74/fVIgFrTwQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FPW27+A+H2/1arWMmXVu50KUtW7mK0O+7P2/AE/iuS4HLtjAvo8QRDlBVJ5toiSMMd8bpApaKH2MKq2xzcnhVyBaGjG0EsF/LQTChj8Gqu7Ycbpz6sslGqiM/6hQuX3ONeyGiqhq1mvRbZrNdsDZc+dcG2NBv+y2knlnjwQQy1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=WZ3xhvbx; arc=fail smtp.client-ip=40.107.128.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImbHpRoHmMqxRcurix63Y+5NZF5n7MAhHS9w2/ALXZWKduNKlsI6PFzdAWgzpjA/EHnKQZEGA+eCrvmjjy2neT91dsBjuPzOkFOVP+t8zm5EljzLjKNWHjETeim7GlkeeafdbK1jT/S9u9R+nXvFU/cp1Sd9318gQEVkjxiQiWsV3f34kNd2g6nL0MU7sYfBOTmtAU+pdwoG9DvQiGclJoEyYiRM1sYKd56Fm5OwzuwG4GmvuuCihAoi+k72tcQsiZIh1VKIR9LJ+4CguR/nemrM0/DCC86b/H1ziZDF4vWVJD1j7uFwiS3i5KtKB2Uo5Ck8Gs1hVCTsZwBCZldrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLdRWnQrPlCTJwDvuB0O0k6i0Rw+LG74/fVIgFrTwQQ=;
 b=OfxQ4lTcJJBE9rvwsjaLQQtHEVcoejNyg9F7mtS0fZyONNDUfX2zCuo6nN1ZXUOLi+mttducZziFOXY+uTcS6ex7HULVFpfYEFeO4p67Hrgyqyw2Yhwfpz8K3vCII13yn8YBbJYZa67cIYO4Ti0jyWoaRkBpNJdI9MM+7EpkznmGVP02Q0X8mblpXwl+HeNYdFpLoSAEO+qhhJt/7CHWtZAv0ZTD58uJqZYxgSv8UTKwlvkywt5ovdFq8mLIxCU9e3rRyOAi6my879RXpQgIh8BxX3DnU/klcqsbERVqozR+eklOVW7Jdj6aZDm4mnH4fMwHgtXB7J+txD2AKHAlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLdRWnQrPlCTJwDvuB0O0k6i0Rw+LG74/fVIgFrTwQQ=;
 b=WZ3xhvbxAfH7r9fRGSIN5vY5KMg25VxSu2ACu9ExyB+sq/oI/KnnF8mESkz9yuqCAk5FLGdtxF1PfzySpFzZ/1WDFSzSwKSPb4f1qVT/GJV9tAUjcPXOs7+gG9a2FH4lxMOqHjcGlsyeaZlazt8nyb/65KZTrTKwvFdOfbYNVds=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SL2P216MB2737.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.31; Fri, 16 Feb 2024 07:12:42 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 07:12:42 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Sebastian Fricke <sebastian.fricke@collabora.com>, Nicolas Dufresne
	<nicolas@ndufresne.ca>
CC: "mchehab@kernel.org" <mchehab@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>,
	lafley.kim <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com" <b-brnich@ti.com>
Subject: RE: [RESEND PATCH v0 2/5] wave5: Support to prepend sps/pps to IDR
 frame.
Thread-Topic: [RESEND PATCH v0 2/5] wave5: Support to prepend sps/pps to IDR
 frame.
Thread-Index: AQHaU+UiSgifophJT0eN4CNCANmihLD/NywAgAEMs4CADFzZ8A==
Date: Fri, 16 Feb 2024 07:12:42 +0000
Message-ID:
 <SE1P216MB1303D6BCD2EBB51B169D79D7ED4C2@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
 <20240131013046.15687-3-jackson.lee@chipsnmedia.com>
 <cdcf594ecaefaac748655bdcb7dcc1c4f9ad1a68.camel@ndufresne.ca>
 <20240208100149.pet6em5tnunv2ome@basti-XPS-13-9310>
In-Reply-To: <20240208100149.pet6em5tnunv2ome@basti-XPS-13-9310>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SL2P216MB2737:EE_
x-ms-office365-filtering-correlation-id: b267e1c9-6849-4999-7b95-08dc2ebeab0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 53gUZwlhyoHOhM5qkUs4rud1LqxQFHjWHwjLyskM15eOFINDrJNgZ4wEDeNCyg8gMZ0LuJSi3h/OIDXuGoMKV11sL82MamieK/agCy5knm2bw0WnbWItl7MhoP1w14ec2Xd5le/vvDJPxgl8/alZntz+uo4RZLafRdEq5qKkYjY97Qy0eMY3XkVXJGcvfraseQKyqLSdyAL8Z4Qe1AssKVjezQdPvldYVB2+I1gtGG4bVocw6LOffm+Tra4ra1cS3r+nGzKs3jAEi61TND5gVw9bOvmbGGYDU7H+2aPXcwwenaICKofBDiwKiFBwJ4c6cyZv+vN6otQDm+smtTroreRkboX+cw85AXi7cGjQjydzEwjflcYuPxYdh9lIFy3YgJacJl1wt1PSOJ1IF2Tskppi9FdTdvGVtzE1PTf8VEZT5+ez6vy25DCQVp7cWmEwX3RpyFn1XZxhmG/qQKKaTymaLT6pOq/678nrN5bzYEJTJ9iv/Yw9YS/A1i2gGN6/v7fYvrEOxG5/xGENFplv+F3MbzKGAR0ymm6z6ovdvSpLGnbEQju5U+CQoBlYkHPZUpM4K6vHO0ysx3JtmYw+EJNdeIRXzZ+qGVC/YC9pDaMCT5tweVGtqeqid69Pwhfo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38070700009)(33656002)(86362001)(122000001)(38100700002)(9686003)(478600001)(316002)(6506007)(53546011)(41300700001)(54906003)(66574015)(110136005)(83380400001)(7696005)(71200400001)(26005)(4326008)(55016003)(66476007)(76116006)(5660300002)(2906002)(66556008)(52536014)(66946007)(66446008)(8936002)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnBuSytocGthcGZYK3BJQ2xaUnRXczc3cEFvREw0YTFkZldNWU9JM3R4ektT?=
 =?utf-8?B?RDRRdHZUS3FpL3FQcXFmZzByeFNlemo4TUQrQUE1QTQ1VW9mNkpBNVEzc2pC?=
 =?utf-8?B?WmhXb3lQM05sb3ZQTUhaRm93RDlhbEJhLzg2M3kyWlpqc2NQY3YveTBpemZp?=
 =?utf-8?B?VlBBTnFNbnRDMk5zS054WXBIRVhtckRrSVhNMVhsVkxiK1BEUHFBSE1GS0hB?=
 =?utf-8?B?c2ZhYXdLcyttRWZnVDBjSmZtTVZRcyt6WDlEckVpcXNUWk14UFlGeFRZS1pZ?=
 =?utf-8?B?akozSzZTcjkrZU1PSGJkeENFS01YR0VYOVpST0F6cU81bFd4NVQyS1BaKzZj?=
 =?utf-8?B?R3FtenhpbC92UUlJbk96cktFTmlQRXpDcmYrSTBOaE8zZDVrYXNzakZwVW9Y?=
 =?utf-8?B?Vm03SmlFM2hCa1dzQUNjaUl3WEJ1NkRQOXR0WFlnOU9qeTdrWExpRzArSDVn?=
 =?utf-8?B?L0pqVE1XMitCa0hTWVg5NHRIQTI1SVdDT1ZvM0tKWlUveThsV1dCckJ5UUZz?=
 =?utf-8?B?UEtGM3BZMkN1NWlaaGVUUGxWcnAxVlZWSW5rSC93TUZsL0xqaDJaQWxoRVlX?=
 =?utf-8?B?WFFPSVV2MW04UFFuT21OSFNpK2l0QjRyWEllY3d4K3FQK2ljTmU5bGRMTzRa?=
 =?utf-8?B?QkRXK3Bid3BkLzBQbms4d3ZqeXZGQlpQY1lacGtDZlJ5bXQ3VmtobVB4dy95?=
 =?utf-8?B?NTdmK0t5RncvaE9aYUFaYi9OWllGcDR5VlozTEgxTVJBcVduMTI0a2dVYTdO?=
 =?utf-8?B?b1pDS1Q2QytLcEZ5ZjJ1M2tXVmZsa3MybVpZQ3l6RjBtWkYvVmsyNXVGZ0RJ?=
 =?utf-8?B?TGt2WlkrVTNHUFVaWXZubUsvVmZDQ05kV2ZMaUdRV2MvMzZMVW5CTXZOK1FN?=
 =?utf-8?B?cEtidHNJM2FmYnRzK1JIYXIvN05oWkdCOUtpNm91c3Y3aGdrM2JGK3p4STIr?=
 =?utf-8?B?UGlEZmtPNjBuYnJDMkZheTd6TzY4Wi9KV1pvVXJiRXBkNEI5WjlkdVFUb1c5?=
 =?utf-8?B?RG5WT0xJWk1HL2JYRVFiNXdOYk95SVBFVExKVFBwNWxWbDU4R0ZNM2pBKzQ1?=
 =?utf-8?B?ZmNoZUNjOHVYZDZDeWtROHBleXZFVjlSMnRoVko1MElsYXdMdWN6dVViQXNT?=
 =?utf-8?B?UjFHc09IeTg1TFBnc0JrNU1kc21ra0pqRTRzYWh3OHE3QTFRZ3pWWE5BdkZ2?=
 =?utf-8?B?K3BLb3hCL2FRQ0E5Nndtd2ZrMU56azV2M3gvdWpZT1lOWFM3cnhacCtmK1FU?=
 =?utf-8?B?c2dTMjBpSmhhOVY3M1lSK0ZhRWJvWlhCeWRWZGhVa0g3S2hmaU9abW0rblFs?=
 =?utf-8?B?dEQxdjVhK3k2V0xMSmxGVmdXSEQzdTlJWjI2Smp1eEprUThEZ0JudlVYMHVi?=
 =?utf-8?B?VktzUUJaQXo3N08yRUVnREp1SXNiaTRDSU1jbVZZUnFaNjNFNFgrNytpeDFZ?=
 =?utf-8?B?QUdKeURJWGlyamMxWkFDUHNGK1ZrcXl2UHVPSUg5UEpZQVVkMkRBaW92ZkZo?=
 =?utf-8?B?T3Fwdjhydkd5ZEt0YmFJT3dpd1YxQjFLT3Nja3pwL3dOa3QrWDYrbldHY016?=
 =?utf-8?B?dThidEJtVGNrMlBVRnBuMEVDQU5rTW8rWGU1cURnaUh0amN0RjZ3QmZFWEkw?=
 =?utf-8?B?QTFaNTl6bzNOeTRnUjR0Vy9LSGRMb1FvcXdhUHB6bG5mdTVRWEV3ZmcrMkg0?=
 =?utf-8?B?VXFVZmk1SEpFRFU2b1dXMXZFQm0wMXdlbmZ3c0c3NHVvaVhlVDdoQzFDd2Fs?=
 =?utf-8?B?aGZmd2I3c3ptbFhheWJCdDJXZG82Y2syNTU4dlU2RDRaTVNKN0o0SFhmekQv?=
 =?utf-8?B?aVYyNzVkOXJnemM2WTI3N1l2UlRBcmZFZ3pwS1kxSFpQZ24wMncxYnJwZHl2?=
 =?utf-8?B?VjRCRWRjZ094cVVJbHVvNSs1SlE5UEl6bWxWRWxhQU93OHRYOWZSdGdoc3h3?=
 =?utf-8?B?aUxEMzl4QVVpckJxQzl0dU0rU2IzYU1wVkxOQnRXSXBXQldHVDAvMEtZOXJi?=
 =?utf-8?B?QmRPQ1RvNkNRQkpBSGV4MmVlbGF3VVJLeWJmYmQva0xqakVSQnVGcE9zZ2hF?=
 =?utf-8?B?L0l2U2loVUIyUkpvWmkzYll2dERraFdtTWpqcXZUdWZObE9DZExweldHY0Vp?=
 =?utf-8?B?TGNtcW41NytrTVdMUWVUbnlhcUYwdTV4NmU2TEN2ZXRZUVQ4UUxhajRtUEZT?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b267e1c9-6849-4999-7b95-08dc2ebeab0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 07:12:42.7826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 558x+dqZZ9+dyQ8L4E8L0PYLr9h/HvhNQgAjldGyTE16ubb1dghKifRTlYADuLc3VMwCrI74DMjZV/WXdH1MktCm8Mu5u/XzaLDlkYAV1fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2737

SGVsbG8gU2ViYXN0aWFuDQoNClRoYW5rcyB5b3VyIHJldmlldywgd2Ugd2lsbCByZXZpZXcgeW91
ciBhZHZpY2UuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ViYXN0
aWFuIEZyaWNrZSA8c2ViYXN0aWFuLmZyaWNrZUBjb2xsYWJvcmEuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgRmVicnVhcnkgOCwgMjAyNCA3OjAyIFBNDQo+IFRvOiBOaWNvbGFzIER1ZnJlc25lIDxu
aWNvbGFzQG5kdWZyZXNuZS5jYT4NCj4gQ2M6IGphY2tzb24ubGVlIDxqYWNrc29uLmxlZUBjaGlw
c25tZWRpYS5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE5hcyBDaHVuZw0KPiA8bmFz
LmNodW5nQGNoaXBzbm1lZGlhLmNvbT47IGxhZmxleS5raW0gPGxhZmxleS5raW1AY2hpcHNubWVk
aWEuY29tPjsgYi0NCj4gYnJuaWNoQHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JFU0VORCBQQVRD
SCB2MCAyLzVdIHdhdmU1OiBTdXBwb3J0IHRvIHByZXBlbmQgc3BzL3BwcyB0bw0KPiBJRFIgZnJh
bWUuDQo+IA0KPiBIZXkgSmFja3NvbiwNCj4gDQo+IGFzIHdpdGggdGhlIHByZXZpb3VzIHJldmll
dywgdGhlIHRpdGxlIG5lZWRzIHRvIGJlIGFkanVzdGVkICd3YXZlNTonIGlzDQo+IG5vdCBlbm91
Z2guDQo+IEFsc28gJ1N1cHBvcnQgdG8gcHJlcGVuZCBzcHMvcHBzIHRvIElEUicgc291bmRzIGEg
Yml0IHdlaXJkIGFuZCBkb2Vzbid0DQo+IHF1aXRlIG1hdGNoIHdoYXQgeW91IGRlc2NyaWJlIGJl
bG93Lg0KPiBIb3cgYWJvdXQ6DQo+ICdTdXBwb3J0IFNQUy9QUFMgZ2VuZXJhdGlvbiBmb3IgZWFj
aCBJRFInDQo+IA0KPiBPbiAwNy4wMi4yMDI0IDEzOjAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3Rl
Og0KPiA+SGkgSmFja3NvbiwNCj4gPg0KPiA+TGUgbWVyY3JlZGkgMzEgamFudmllciAyMDI0IMOg
IDEwOjMwICswOTAwLCBqYWNrc29uLmxlZSBhIMOpY3JpdMKgOg0KPiA+PiBJbmRpY2F0ZXMgd2hl
dGhlciB0byBnZW5lcmF0ZSBTUFMgYW5kIFBQUyBhdCBldmVyeSBJRFIuIFNldHRpbmcgaXQgdG8g
MA0KPiBkaXNhYmxlcyBnZW5lcmF0aW5nIFNQUyBhbmQgUFBTIGF0IGV2ZXJ5IElEUi4NCj4gPj4g
U2V0dGluZyBpdCB0byBvbmUgZW5hYmxlcyBnZW5lcmF0aW5nIFNQUyBhbmQgUFBTIGF0IGV2ZXJ5
IElEUi4NCj4gDQo+IE15IHN1Z2dlc3Rpb246DQo+IA0KPiBQcm92aWRlIGEgY29udHJvbCB0byB0
b2dnbGUgKDAgPSBvZmYgLyAxID0gb24pLCB3aGV0aGVyIHRoZSBTUFMgYW5kIFBQUw0KPiBhcmUg
Z2VuZXJhdGVkIGZvciBldmVyeSBJRFIuDQo+IA0KPiBHcmVldGluZ3MsDQo+IFNlYmFzdGlhbg0K
PiANCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSmFja3NvbiBMZWUgPGphY2tzb24ubGVlQGNo
aXBzbm1lZGlhLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTmFzIENodW5nIDxuYXMuY2h1bmdA
Y2hpcHNubWVkaWEuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
Y2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtaHcuYyAgICAgIHwgNiArKysrLS0NCj4gPj4gIGRyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1LWVuYy5jIHwgNyAr
KysrKysrDQo+ID4+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2
ZTUtdnB1YXBpLmggIHwgMSArDQo+ID4+ICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LWh3LmMNCj4gPj4gYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LWh3LmMNCj4gPj4gaW5kZXggZjFl
MDIyZmIxNDhlLi44YWQ3ZjNhMjhhZTEgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtaHcuYw0KPiA+PiArKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LWh3LmMNCj4gPj4gQEAgLTE2
MDIsMTEgKzE2MDIsMTMgQEAgaW50IHdhdmU1X3ZwdV9lbmNfaW5pdF9zZXEoc3RydWN0IHZwdV9p
bnN0YW5jZQ0KPiAqaW5zdCkNCj4gPj4gIAlpZiAoaW5zdC0+c3RkID09IFdfQVZDX0VOQykNCj4g
Pj4gIAkJdnB1X3dyaXRlX3JlZyhpbnN0LT5kZXYsIFc1X0NNRF9FTkNfU0VRX0lOVFJBX1BBUkFN
LA0KPiBwX3BhcmFtLT5pbnRyYV9xcCB8DQo+ID4+ICAJCQkJKChwX3BhcmFtLT5pbnRyYV9wZXJp
b2QgJiAweDdmZikgPDwgNikgfA0KPiA+PiAtCQkJCSgocF9wYXJhbS0+YXZjX2lkcl9wZXJpb2Qg
JiAweDdmZikgPDwgMTcpKTsNCj4gPj4gKwkJCQkoKHBfcGFyYW0tPmF2Y19pZHJfcGVyaW9kICYg
MHg3ZmYpIDw8IDE3KSB8DQo+ID4+ICsJCQkJKHBfcGFyYW0tPmZvcmNlZF9pZHJfaGVhZGVyX2Vu
YWJsZSA8PCAyOCkpOw0KPiA+DQo+ID5JIGNhbiBzcG90IGV2aWRlbnQgaGFyZC1jb2Rpbmcgb2Yg
bWFzayBhbmQgYml0IHNoaWZ0cyBpbiBoZXJlLiBJbiBvcmRlcg0KPiA+dG8gY29udGludW91c2x5
IGltcHJvdmUgdGhpcyBkcml2ZXIgY29kZSwgSSB3b3VsZCBsaWtlIHRvIHNlZSB0aGlzIChhbmQN
Cj4gPnRoZQ0KPiA+Zm9sbG93aW5nKSBtYWdpYyBudW1iZXIgYmVpbmcgZGVmaW5lZCB3aXRoIHdl
bGwgbmFtZWQgbWFjcm9zIGFzIGENCj4gPnByZXBhcmF0aW9uIHBhdGNoIHRvIHRoaXMgZmVhdHVy
ZSBjaGFuZ2UuDQo+ID4NCj4gPnJlZ2FyZHMsDQo+ID5OaWNvbGFzDQo+ID4NCj4gPj4gIAllbHNl
IGlmIChpbnN0LT5zdGQgPT0gV19IRVZDX0VOQykNCj4gPj4gIAkJdnB1X3dyaXRlX3JlZyhpbnN0
LT5kZXYsIFc1X0NNRF9FTkNfU0VRX0lOVFJBX1BBUkFNLA0KPiA+PiAgCQkJICAgICAgcF9wYXJh
bS0+ZGVjb2RpbmdfcmVmcmVzaF90eXBlIHwgKHBfcGFyYW0tDQo+ID5pbnRyYV9xcCA8PCAzKSB8
DQo+ID4+IC0JCQkJKHBfcGFyYW0tPmludHJhX3BlcmlvZCA8PCAxNikpOw0KPiA+PiArCQkJICAg
ICAgKHBfcGFyYW0tPmZvcmNlZF9pZHJfaGVhZGVyX2VuYWJsZSA8PCA5KSB8DQo+ID4+ICsJCQkg
ICAgICAocF9wYXJhbS0+aW50cmFfcGVyaW9kIDw8IDE2KSk7DQo+ID4+DQo+ID4+ICAJcmVnX3Zh
bCA9IChwX3BhcmFtLT5yZG9fc2tpcCA8PCAyKSB8DQo+ID4+ICAJCShwX3BhcmFtLT5sYW1iZGFf
c2NhbGluZ19lbmFibGUgPDwgMykgfCBkaWZmIC0tZ2l0DQo+ID4+IGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12cHUtZW5jLmMNCj4gPj4gYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYw0KPiA+PiBp
bmRleCAwY2I1YmZiNjcyNTguLjc2MTc3NTIxNmNkNCAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12cHUtZW5jLmMNCj4gPj4g
KysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12cHUt
ZW5jLmMNCj4gPj4gQEAgLTExMjUsNiArMTEyNSw5IEBAIHN0YXRpYyBpbnQgd2F2ZTVfdnB1X2Vu
Y19zX2N0cmwoc3RydWN0IHY0bDJfY3RybA0KPiAqY3RybCkNCj4gPj4gIAljYXNlIFY0TDJfQ0lE
X01QRUdfVklERU9fSDI2NF9FTlRST1BZX01PREU6DQo+ID4+ICAJCWluc3QtPmVuY19wYXJhbS5l
bnRyb3B5X2NvZGluZ19tb2RlID0gY3RybC0+dmFsOw0KPiA+PiAgCQlicmVhazsNCj4gPj4gKwlj
YXNlIFY0TDJfQ0lEX01QRUdfVklERU9fUFJFUEVORF9TUFNQUFNfVE9fSURSOg0KPiA+PiArCQlp
bnN0LT5lbmNfcGFyYW0uZm9yY2VkX2lkcl9oZWFkZXJfZW5hYmxlID0gY3RybC0+dmFsOw0KPiA+
PiArCQlicmVhazsNCj4gPj4gIAljYXNlIFY0TDJfQ0lEX01JTl9CVUZGRVJTX0ZPUl9PVVRQVVQ6
DQo+ID4+ICAJCWJyZWFrOw0KPiA+PiAgCWRlZmF1bHQ6DQo+ID4+IEBAIC0xMjkyLDYgKzEyOTUs
NyBAQCBzdGF0aWMgdm9pZCB3YXZlNV9zZXRfZW5jX29wZW5wYXJhbShzdHJ1Y3QNCj4gZW5jX29w
ZW5fcGFyYW0gKm9wZW5fcGFyYW0sDQo+ID4+ICAJCWVsc2UNCj4gPj4gIAkJCW9wZW5fcGFyYW0t
PndhdmVfcGFyYW0uaW50cmFfcmVmcmVzaF9hcmcgPSBudW1fY3R1X3JvdzsNCj4gPj4gIAl9DQo+
ID4+ICsJb3Blbl9wYXJhbS0+d2F2ZV9wYXJhbS5mb3JjZWRfaWRyX2hlYWRlcl9lbmFibGUgPQ0K
PiA+PiAraW5wdXQuZm9yY2VkX2lkcl9oZWFkZXJfZW5hYmxlOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+
PiAgc3RhdGljIGludCBpbml0aWFsaXplX3NlcXVlbmNlKHN0cnVjdCB2cHVfaW5zdGFuY2UgKmlu
c3QpIEBAIC0xNzc1LDYNCj4gPj4gKzE3NzksOSBAQCBzdGF0aWMgaW50IHdhdmU1X3ZwdV9vcGVu
X2VuYyhzdHJ1Y3QgZmlsZSAqZmlscCkNCj4gPj4gIAkJCSAgMCwgMSwgMSwgMCk7DQo+ID4+ICAJ
djRsMl9jdHJsX25ld19zdGQodjRsMl9jdHJsX2hkbCwgJndhdmU1X3ZwdV9lbmNfY3RybF9vcHMs
DQo+ID4+ICAJCQkgIFY0TDJfQ0lEX01JTl9CVUZGRVJTX0ZPUl9PVVRQVVQsIDEsIDMyLCAxLCAx
KTsNCj4gPj4gKwl2NGwyX2N0cmxfbmV3X3N0ZCh2NGwyX2N0cmxfaGRsLCAmd2F2ZTVfdnB1X2Vu
Y19jdHJsX29wcywNCj4gPj4gKwkJCSAgVjRMMl9DSURfTVBFR19WSURFT19QUkVQRU5EX1NQU1BQ
U19UT19JRFIsDQo+ID4+ICsJCQkgIDAsIDEsIDEsIDApOw0KPiA+Pg0KPiA+PiAgCWlmICh2NGwy
X2N0cmxfaGRsLT5lcnJvcikgew0KPiA+PiAgCQlyZXQgPSAtRU5PREVWOw0KPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12cHVh
cGkuaA0KPiA+PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2
ZTUtdnB1YXBpLmgNCj4gPj4gaW5kZXggMzUyZjZlOTA0ZTUwLi4zYWQ2MTE4NTUwYWMgMTAwNjQ0
DQo+ID4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2
ZTUtdnB1YXBpLmgNCj4gPj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRp
YS93YXZlNS93YXZlNS12cHVhcGkuaA0KPiA+PiBAQCAtNTY2LDYgKzU2Niw3IEBAIHN0cnVjdCBl
bmNfd2F2ZV9wYXJhbSB7DQo+ID4+ICAJdTMyIGxhbWJkYV9zY2FsaW5nX2VuYWJsZTogMTsgLyog
ZW5hYmxlIGxhbWJkYSBzY2FsaW5nIHVzaW5nIGN1c3RvbQ0KPiBHT1AgKi8NCj4gPj4gIAl1MzIg
dHJhbnNmb3JtOHg4X2VuYWJsZTogMTsgLyogZW5hYmxlIDh4OCBpbnRyYSBwcmVkaWN0aW9uIGFu
ZCA4eDgNCj4gdHJhbnNmb3JtICovDQo+ID4+ICAJdTMyIG1iX2xldmVsX3JjX2VuYWJsZTogMTsg
LyogZW5hYmxlIE1CLWxldmVsIHJhdGUgY29udHJvbCAqLw0KPiA+PiArCXUzMiBmb3JjZWRfaWRy
X2hlYWRlcl9lbmFibGU6IDE7IC8qIGVuYWJsZSBoZWFkZXIgZW5jb2RpbmcgYmVmb3JlDQo+ID4+
ICtJRFIgZnJhbWUgKi8NCj4gPj4gIH07DQo+ID4+DQo+ID4+ICBzdHJ1Y3QgZW5jX29wZW5fcGFy
YW0gew0KPiA+DQo+ID4NCg==


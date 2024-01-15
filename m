Return-Path: <linux-kernel+bounces-25997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641F82D98C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EE91F22341
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9E168C4;
	Mon, 15 Jan 2024 13:09:27 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2052.outbound.protection.outlook.com [40.107.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B4168AF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=USbIZinfodata.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=USbIZinfodata.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM9QncEsQvdtouU6A3pfF+laScGrxeWPNNxYKKedvEMGwHnxMQgqsf0tCpX+cbxCCGb9/KrAOglD5r+z932s3Y9GTkYPY05lqpnE0dmN+YWVcTUtZ2Rsuom+vAUhW/DtT0/fz108fBZB86J3pTJwdf+OVD4+IDD2XaZXY0b38wpL45cmX16eXP+g86Q9m/Mwc1nqoF0JbmJo3W/eUi6p10Ou7O8YdYzN4lAAzEttu+5umtqvs3GPk/8AiRT95kW5TgDV89Qc1+vcGDDGDNj6TaSZSxwgpovo/5FLIA6XCu963gdz5Xe2tIKlyzduhWowrxRdQUfhm0dRapuvbrDxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYbiwBwZJTZJHEd0EjKCSCeNzfYoJoZk7uvn4Mpv7BI=;
 b=n49qMf7pyAXBYxWhoclempNJzhRqkECXaSpdt3Jwkuk4VnpzhLPczAWsR7B+0YWeEX6UEVq+K+jhc1Tw1nT4u2v9SxR3Hz2JnQp6ujKb/PCqvsuNUxrShgiryQO0CLd7RaXOmraZNqmuD+kmgSVhZl+IvUFRP7mfaqmJ5PsIR4FQxyseAgTWM3B8dow6/Rd8ub9vEq1bQjrJtMLhWrl1/Fd7Fged+cn9+9UantZ+si+Wznl2CbjWLBP+T8vb31+uSqC55swgaZsN6U8GrjSbdr/cGppNoVgzif/lJWi+tNtA2xJwcG7TKLVJvuk23+hnAWcwnTaNTfHNCb7wXEjnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=usbizinfodata.onmicrosoft.com; dmarc=pass action=none
 header.from=usbizinfodata.onmicrosoft.com; dkim=pass
 header.d=usbizinfodata.onmicrosoft.com; arc=none
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:208::9)
 by MA0P287MB0715.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.24; Mon, 15 Jan
 2024 13:09:21 +0000
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325]) by PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325%6]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 13:09:21 +0000
From: Emma Conner <Emma.Conner@USbIZinfodata.onmicrosoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: vger Hardware decisions makers
Thread-Topic: vger Hardware decisions makers
Thread-Index: AQHaR7QNHcS4vHCvF0ycFIqhA9p1OQ==
Date: Mon, 15 Jan 2024 13:09:21 +0000
Message-ID:
 <4a122644-f06e-5e78-7b75-1983974c6591@USbIZinfodata.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=USbIZinfodata.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB2559:EE_|MA0P287MB0715:EE_
x-ms-office365-filtering-correlation-id: 4be5b13e-ae0f-4789-6531-08dc15cb304a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cEyDYsUP238y32VT9YboHWsbyJPs5rQixqU28A4Us6Y2sjvu06PNffvgef6+pdEgdTRVfT46KPf2PeR54UAbF1IDeh+LDR2S0E+3+lwWzpS3dN2+fMR7bCsrfQTJlNgi0cq/QQjNj/iyeLi7HyS2RVSo7dtfe0/b+HZBDACGKOlPX3zdVBR4yCBEd3hKXyLYzhLX4Y+QbucNkikQj8TYP8bRMcQuG4Uo4QQZ+4uDsKmRDMEEA50qvKlzniQ9fDDYx/EfQlgaxsm6P7R1S28cQ4o6F6njd7Z9gkQTnEhG9ABkoPIJwmWv1BHivo3RNkcRnpNLAL9K8Uz+zFtNQsMibVLB2UjQfwbzQh/DbWvSbZdwYhU2aaMopqOFDrCzRE4kASGkdkIya+JWuMOtHbeG6agVgcxkw/q9Uq6MGFTJ3coYwR6Zesg8FsUV90cPe6V4cZgrnYV4keSqg9Iw/f3VJ/nW6UJi0rHpqGZVmBD+U80o/bJTmDKlLT40wgzzJLO6duyCRPPyBCxGYp52C+BJvwnU9xiSlt4TrSvaFAi31IwVF18dbsJ/BF6Qr5kI3TWeBHGSrby/+2ib9keeqiXjc50C3N8CM5FfDFDWpfwCneoPkEehE305eabsZWa3R09FL59+LlSz2YlWDcvKXE320A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2559.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39850400004)(366004)(34096005)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(26005)(6512007)(2616005)(122000001)(38100700002)(3480700007)(5660300002)(8676002)(6506007)(66946007)(8936002)(2906002)(66476007)(6486002)(478600001)(53546011)(66556008)(71200400001)(6916009)(64756008)(66446008)(316002)(41300700001)(76116006)(91956017)(38070700009)(31696002)(86362001)(31686004)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmFGaHhUTVhFL0NBNUlBb2hUVzkvVk96RWxZSGplazM0cUdwVEZkbW9MVjJX?=
 =?utf-8?B?Q3hiQ1FTYTdmWnFzZXU5bnhHVHY1YUc1NVJyNWYrYUdMQjhOL0FBeUNZTUtj?=
 =?utf-8?B?UUYvYURzbE9KUktQcklLSnN6dUZ4REJLMHZoRzMxWWl4VXZWUjBPVmpjcERH?=
 =?utf-8?B?WUwxaElMRzZFTlBRSGh1ZDJPa0NPaStUQ0R1T1ZWdnY3b0swaXRwVGlCZi9z?=
 =?utf-8?B?cFZETWs1ejNITHQ4MmxsZWdxTTNWQzJCbUxtMEdQTGd0WkRVM3VKYVNmZ2lO?=
 =?utf-8?B?dDBMMWVlWWtTRG9jT2xGNXNLWDNGSEFEdXJOM1phU0NIZTJwUllQaWUxKzFC?=
 =?utf-8?B?dzhENEFIZFpPRDdmUG9FdHQvRmhmcmNkblZFSXRoSDJmVlJWMUlydFNBSWpP?=
 =?utf-8?B?bjVXd2VSOVBBR1FWY1BWMGJYTkZzYmlYVXRUM2RWQXRQa3MvNGpOTUVsYkpz?=
 =?utf-8?B?M05TTlF2Mk9lMDdiTmczZk9keEdNMVdaejVLc0FTdGJpSUhFdmF1Ym0zRVNa?=
 =?utf-8?B?Rlo3ZHo2dFpWamRIMDlmZEFDcUlPMy9pS0lmRU1pNmdGbmswaUFzUTJWN3B3?=
 =?utf-8?B?VXRvaUVvVUJwTHpaWTRjOVNCcXJTaFRIbEdacXpCOFNreDZMb1VZL0M4SnhX?=
 =?utf-8?B?WlhLc0JMVzF5UnJodVlwYi9ZaTZsN1hQdU5BaTd5NWJVWW1qMFVhc1JnNTdW?=
 =?utf-8?B?M3RvcjlHUytIdXhSUVhud2NwRmFrMkNCcUQ3d3pxcjhtK1NpdXZMak1mT2ll?=
 =?utf-8?B?WEZZOG13UC90Q2YvdlVRMis2K29RSEZOUTl5QXorSVc5RDk3eE9XZUEzdE96?=
 =?utf-8?B?SkpFYnRpTmVXN1hoeDVOZTQxYkZXQXYrV0wvVmluend1eEJtL0tWRzdxYkhP?=
 =?utf-8?B?eHBXbkxuNDNRV1VqWGNwQmNma0tidFZ5emNzam1JdWY0RGdtdWVmNGd2MVdp?=
 =?utf-8?B?ZitzbGtWM05YWHFaZ0x4Qlp3YU54WG5kbHZVTEF2aHAzNmJ4V1JyMzNkMHZx?=
 =?utf-8?B?WDBXekhIWlVwQ2pmbk9wV2Y3SG03U3lZZjlaZzNpOHFlY2d3azE2eVJZRi9J?=
 =?utf-8?B?b2tRODRQZkNTMlU2S3N3eVpzcFNpMGdzcTR4dUJvYVNnTmFlZWp6emJZZ1A0?=
 =?utf-8?B?bmRTU0xUYzJYNXlNWjJ0U0ZjVVhjVDZxaUtiZS84eERlQUEvYmk1Q2ZzRi9y?=
 =?utf-8?B?dTh1VjFibjl5SzlvSnpXQk5LSHpZRHhDSG9rSnJVdXNPOWNZWHhHQXBjdEU2?=
 =?utf-8?B?SXFWMnB6K3MrSk5ZbnoyQ3Q4VU9SNHBURkhBY3pyOVRmLzNSdFdFVHd0aG1Q?=
 =?utf-8?B?U3VoR0RSYzJsMFF2SWlBZWl4Nm1lTkF6cC9VRUZ4dzcwTWdINnZDVHJnN0VV?=
 =?utf-8?B?WGpTd2cvSUJjdW14cWk5STVJYkV4cUtiYVdGQWorUlVLcE5Vb3czS3BVMTRI?=
 =?utf-8?B?ZHFIUnh0SUtSUWppSGtFamY0RHladjZlcFJlN0VoS1FUZCtVdUIxZDFYbXRG?=
 =?utf-8?B?Z1ZCVVJXb0pyZ2dkMXVwNklPZ0k0WE5jNkZ1MTZzeXpkZllWMVIzdy9UMm9y?=
 =?utf-8?B?Y3RCUnpWU082anF3OU13bmZ4eG1kZ0R6Sk0xZmJBemloUDlnbkVIOHRwd2RH?=
 =?utf-8?B?dFBQMDV0ZkswY0NPbm9vZmpZZHJZYUdnUllKbTdPbEllamlZbUlPNGFJcWRw?=
 =?utf-8?B?L2gvam9qOVU3cDA3SUxqWThZRGxSQmplZFRMOXV1OWRJbW9yUEg5cnFkRGE2?=
 =?utf-8?B?NTluVWlLbkFUV2xndEVvczY4cUxyYWdLS2puZ3dTRXo2K3ZaQjBUekV0SS8w?=
 =?utf-8?B?NmYyVU9SK1h6cGFWU1dENjlNL3ZzcWhXQTN3YnlyNUVLdHJyOVFTWlZIVjJj?=
 =?utf-8?B?U2w1b2drUlVaTFprTWxPclR6ck4vZnhtcVp5b1lEbnIzSmNNVlU5OWJzUVhZ?=
 =?utf-8?B?OXo4WkNKZStDclRidFN5RTBNWG1tQjlVV0lIWUc1cEszbzhRbWRjK3pDM0NO?=
 =?utf-8?B?SUlIaVpuZmsvM1dTM2tvVW9SSlNEdUs5N3l5cjdBdjZFVGFpZXhpZnNwOFZu?=
 =?utf-8?B?NE1xalRmcEtJUGZiK09rU1c3c2pCNjhaTHFmMStXcTZCWlR3a3VucjNHVmp4?=
 =?utf-8?B?VlRxYi9idmRjV2ZrTHgzS2VueU5LTXIxTnpLSDZBcU5hOEEyb01ZbnBOeWRC?=
 =?utf-8?Q?e6MVHiVnQ6oh/CtrUaf8Px4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD4D9E47813397428E36033B9FF09E88@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: USbIZinfodata.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be5b13e-ae0f-4789-6531-08dc15cb304a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 13:09:21.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c8985d2c-274e-4d2e-b47a-e4113825a86d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRJRHxF1K8N+U71UrIjgY8SeV2Fuo/i8jih2ctRZQx16xlHRp5r0g+Miwpxh9FRsQf+wXrMb5iborWfY6APAfYUQ3NPL9IFabBvVgljCklTuuNiQ2polclg2ELPiBxNKVDBoIVoejoqdRb1ad/OK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0715

SGksDQoNCkkgZW1haWxlZCB5b3UgYWJvdXQgb3VyIElUIGFuZCBjb21wdXRlciBkZWNpc2lvbnMg
bWFrZXJzIGNvbnRhY3RzIA0KZGF0YWJhc2UuIFdlIGNhbiBncmFudCB5b3UgYWNjZXNzIHRvIG91
ciB1cGRhdGVkIElUIGFuZCBjb21wdXRlciANCmRlY2lzaW9ucyBtYWtlcnMgd2l0aCBJVCwgSVMs
IEhlbHAgRGVzaywgQWRtaW4gbWFuYWdlcnMsIE93bmVycyBvZiBzbWFsbCANCmJ1c2luZXNzIGV0
Yy4NCg0KSSB3YW50ZWQgdG8gY2lyY2xlIGJhY2sgYW5kIHNlZSBpZiB5b3UgYXJlIGludGVyZXN0
ZWQgdG8gc2VuZCBtZSB5b3VyIA0KdGFyZ2V0IGpvYiB0aXRsZXMgYW5kIGluZHVzdHJpZXMgc28g
d2UgY2FuIHNlbmQgeW91IG1vcmUgaW5mb3JtYXRpb24uDQoNClJlZ2FyZHMsDQpFbW1hDQoNCkVt
bWEgQ29ubmVyIHwgTWFya2V0aW5nIENvbnN1bHRhbnQNCg0KT24gMDMtMTAtMjAyMyAxMTo0Mywg
RW1tYSBDb25uZXIgd3JvdGU6DQoNCkhpLA0KDQpXb3VsZCB5b3UgYmUgaW50ZXJlc3RlZCBpbiBy
ZWFjaGluZyBvdXQgdG8gSVQgYW5kIGNvbXB1dGVyIGRlY2lzaW9ucyANCm1ha2VycyB0byBwcm9t
b3RlL3NlbGwgeW91ciBwcm9kdWN0cyBhbmQgc2VydmljZXM/DQoNCiDCoMKgIEMsIFZQLCBEaXJl
Y3RvciBvciBNYW5hZ2VyIGxldmVsIFRlY2hub2xvZ3kgb2ZmaWNlcg0KIMKgwqAgQywgVlAsIERp
cmVjdG9yIG9yIE1hbmFnZXIgbGV2ZWwgSVQgT3BlcmF0aW9ucw0KIMKgwqAgQywgVlAsIERpcmVj
dG9yIG9yIE1hbmFnZXIgbGV2ZWwgSW5mb3JtYXRpb24gc2VjdXJpdHkgb2ZmaWNlcg0KIMKgwqAg
Q29tcHV0ZXIgTWFuYWdlcnMNCiDCoMKgIEhlbHAgZGVzayBNYW5hZ2VyDQogwqDCoCBJbmZvcm1h
dGlvbiBTeXN0ZW1zIE1hbmFnZXINCiDCoMKgIEFkbWluIE1hbmFnZXINCiDCoMKgIElUIFNwZWNp
YWxpc3QNCiDCoMKgIE93bmVycywgQ0VPLCBQcmVzaWRlbnRzIGV0Yw0KDQpXZSB3b3VsZCBiZSBo
YXBweSB0byBjdXN0b21pemUgeW91ciBsaXN0IGFjY29yZGluZ2x5IGZvciBhbnkgb3RoZXIgDQpy
ZXF1aXJlbWVudHMgdGhhdCB5b3UgaGF2ZS4gUGxlYXNlIGxldCBtZSBrbm93IGluZHVzdHJpZXMg
YW5kIGpvYiB0aXRsZXMgDQp5b3UgdGFyZ2V0IHNvIEkgY2FuIGdldCBiYWNrIHRvIHlvdSB3aXRo
IGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQoNCkFwcHJlY2lhdGUgeW91ciByZXNwb25zZS4NCg0K
DQpSZWdhcmRzLA0KRW1tYSBDb25uZXIgfCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQpSZXBseSBv
bmx5IG9wdC1vdXQgaW4gdGhlIHN1YmplY3QgbGluZSB0byByZW1vdmUgZnJvbSB0aGUgbWFpbGlu
ZyBsaXN0Lg0K


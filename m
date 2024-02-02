Return-Path: <linux-kernel+bounces-49461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0E846A9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88081B28C27
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A581A27D;
	Fri,  2 Feb 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="LSwV99Ek"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2128.outbound.protection.outlook.com [40.107.128.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5C1803D;
	Fri,  2 Feb 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862067; cv=fail; b=hwqUihNAzo4q0rH5CRgdmJmvpkoaEjkNuF3kh2KSHsNFv8PjWqKG1T/59qOwtKhbCuLpfC5fF/BnPX97nWuB+bDLLV/jxKI2eq0SrjWbIuP3DB8flvwN2RjDoDAagCnfQNuGvNDJVXXyGA5HT4lETeqs+kaHAVNBfRE+SoCz9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862067; c=relaxed/simple;
	bh=jjH3IWz3Jtkt6cuAIrY/eAyfvzjq9LwicbjBXRVZR6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+83oEAbNqnZTJ+3M7hUlnrbtI3UCM/hD7KTr+5QMon0NE2BA1AcPNcCYYTimBlXlUMTugdIGB5BrR6P/TPW5LCcwyvoQ6t4KgD1haVEaeJs6MKqZlP49ShByGlQu5hXAZ3kko033vqSyPmjU/RoRC/n5oSv9MfeN7pr/4zNBpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=LSwV99Ek; arc=fail smtp.client-ip=40.107.128.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1EPWw9XGElRp8FIXff715nJnHSu/JzJEMfarBFVel/f2CuxDO2IW7VZBMWe3W6i9xHRn3v74F4AIUadifCJV8k5cQ92zyHQ4EDn/67TWlUCpDRFcuag08uUCKm8LRkqE1BB4yw7SFdS/opO+N9mNWs/rCaJs23u4l3HjNskj2QmS6rSrd8nZkAgSFmKI/nKubqJsl2a7X0dQs8SBsvbLF7lGmXoiiXI/53YiqT431NdjDCEkxR0hcyC19zRIGnnBoRyFpwszT2BHYfXSg7ZZFfpqJm7YQHUO2NA49lhoxfQwYbIQkyqRiXLSua1gVSv+x5tNpKaF6GAfOvw8QSn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjH3IWz3Jtkt6cuAIrY/eAyfvzjq9LwicbjBXRVZR6U=;
 b=JsOkLlUeRtFk+R4CnsF0LxPCFrY4DBrZ2UiB0S8PWBdTwiDxW7SGNdyJCVNW9ayDyK65td1tYsV59HFJzN6TQAB6m0ac6pZzLqFQX18I5DVjM7y4cZVK7efWlKBTU9RfBXT5lh3IYUa20lfd01raE94ViCs+xiRdxcINKeh/WCxUztWQ7iyCMexOLh6Ar1AjhU4/8c13mwSFxPT5XgF+4izqDkuCYASHqtzp1A1LkNzCHx5ufMiJtZrZPNvEsLiCbPsMvQaA/NWbIsDPOlLUy1eW2hVxHpK5mBD4v6RAkUpfvprFgg2B/t1THKdUvVJMD89NOyQiH9hdrFSsfOSLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjH3IWz3Jtkt6cuAIrY/eAyfvzjq9LwicbjBXRVZR6U=;
 b=LSwV99EkL89yXEd8BvWZhyJJYWbADNMlqlI4Ie/+KDtC0PHJWiuynfAPtbyBdbw6z3ep5cRh9v5whn9SBQz9tsW+OQ8jzY4jS5OZw4yhFToSM9WHfiLvAQwXYpnKr5fLU52oJNKoP/+3DflcpEJA7KIni7yWgHaITeExEGlOQVQ=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB1438.KORP216.PROD.OUTLOOK.COM (2603:1096:301:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.30; Fri, 2 Feb 2024 08:21:00 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 08:20:59 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Sebastian Fricke <sebastian.fricke@collabora.com>
CC: "mchehab@kernel.org" <mchehab@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, lafley.kim <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>, "hverkuil@xs4all.nl"
	<hverkuil@xs4all.nl>, Nas Chung <nas.chung@chipsnmedia.com>
Subject: RE: [PATCH v1 0/5] wave5 codec driver
Thread-Topic: [PATCH v1 0/5] wave5 codec driver
Thread-Index: AQHaVaYH5qDSsL5Oc0CQvUv5VKT6xbD2tPEAgAABDGA=
Date: Fri, 2 Feb 2024 08:20:59 +0000
Message-ID:
 <SE1P216MB1303E81CBACCCA83967482C8ED422@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
 <20240202081628.bgadpzrgnl3cku3p@basti-XPS-13-9310>
In-Reply-To: <20240202081628.bgadpzrgnl3cku3p@basti-XPS-13-9310>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|PU4P216MB1438:EE_
x-ms-office365-filtering-correlation-id: bca59b12-a5af-4e0c-c523-08dc23c7e35a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z0f52gZ8KV+JL4Sm0sGf5VlagqK14sghutsaaFxpsIRFwFbAZ1xFyN4XWtJDjxAUttZntHgOd+h3P9DZWHSeqO9wXfHWIXYdPf/NOwYj0j1W++MUIZ3KhVj/PvwpysGPMbHKh7JDHVx+f1P4zS9FHKD0I/F6PYC1/9Khohp1z6D4sTrJn26B3RKnnXSc/CrLDHnEO6wbzQeK07kOMLogH3haqlXxpXRzexULC+X23nS4GQqhzmA0muPOs11l9YF2nB6j5YZzVLVEwlvPert/ZinDCS6IFnrFE/4zm2FGnJvjvJ9lCRrOdtsN5bZ+zePM/qhCm63VSjIybINdYYqIQTj+t/3ZiUeM2wMu7tzWaJh0EkNG64A40LdrP9E8jb1IwFdcEpW7SQrFznfJA6EnNqou5iVotIMiltDPsRItrzDg0Ljx28zlkbv5NRzUQ9KYpIunJ71WZyD70LaMmuo+HT4ZPXyAaiZiX+mXHdiETTYug9bgV78/P4O0XvSIDzmdwY96LaMdnUDMLhSymFyMCQnvZnZhlgLcocepPAJBLsM8iXuFM5RZG33gcwS/sn8IuINl3oYEkencjYe7Y9BCZxHfM4jJzXyh/J23MeDJkQsimn/fI4wQJ+IQ7ByICOBi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39850400004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6916009)(122000001)(66476007)(66446008)(54906003)(66946007)(66556008)(64756008)(4326008)(8676002)(8936002)(52536014)(316002)(53546011)(55016003)(478600001)(76116006)(7696005)(6506007)(86362001)(38070700009)(2906002)(38100700002)(5660300002)(33656002)(107886003)(26005)(9686003)(83380400001)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2xYMHBrZXBlb3RZZUMrRkI4SGpFUzlFUHVyV2RXWG5ySmgxZ3lTUFYwV2hR?=
 =?utf-8?B?enN5OHpDYUZQSTl4N0tCT3BsSEhxdGJ0cEdvSlE4bjJjbTVXNlBCRFZ2V1V2?=
 =?utf-8?B?RXZUbTdTdGRRbEJEKzJoYWcyaFUxcmNycjVINlR6SEVSY25WZW9OK2RxTkw1?=
 =?utf-8?B?YzlOUVEvVjBTVUl2V1dmVHRzOTJsTk04dUJnalNuSmpOSlhlaHRja0FGeGsz?=
 =?utf-8?B?SzBHUkF0Rm94Tldtb3l3M05vazV4bVoxR2J6bjZYNXdmaENQdFA5Z0Q3Mzht?=
 =?utf-8?B?WnRibmVUdTVCaktWa04zRm5KRmF2T1k3ZmRFVXYzT0FuY1pkRDdrNGtLVS9S?=
 =?utf-8?B?c01maEhIQzZlTFUzSXZBNFVGM0l1MFFMUmdxTWhBRnVIV290Y1RWVVZJVndr?=
 =?utf-8?B?Y1Nld2ZRd1YreitjZ0sySjQ2TS9xN1IzYUFCK2FPNjE2QjZWV3hWNVo2dFRL?=
 =?utf-8?B?eGI0am83dGtIMm05ZWlkMUNLRk54ZVkzeDZ0VEtNWmtiVHBndytuaXJPZlQ0?=
 =?utf-8?B?Z00vOEFhWkt0eWZTVlMyYkJoSnVqNnlyOHFxTTVGWHIvUWd1VDZUbnIrUlo5?=
 =?utf-8?B?WFJoYTdQLzEyMjdTWnduV0dwZjNTWTNOajE2cXBWZkc2NEhWNGs1UHU1QStx?=
 =?utf-8?B?K3lJb2lvb1pUMmtqQ05NVGxrenJTQUlQOVU0MTI0Q2d5c1NXZVlmTTJnbWxP?=
 =?utf-8?B?dkp0UXdOZE9PT3JFUFpxT3V4WEpGVmdVM0l2d2pobFNkQVNiNC95LzgrZXlY?=
 =?utf-8?B?TTMrT0U0YlBkWlJNSDJSRm4rM1c4L2ZTejUydTdYbTA5UlpCWWtLa1NvY0hG?=
 =?utf-8?B?ZWdheFZuNnVGSkllZ0NPaG0wa1JjQm54dTUwUmR3dUdmSFYzZjlDWk9Lb3ZV?=
 =?utf-8?B?TjN3N1hWSTBpOGg2WEhGcFFrWElUZndQdlNaWXJIQVhqYWRrZHZiTmhqNUNG?=
 =?utf-8?B?aUJMZXF4bitBb040eGNUVG0xNm1hd0NvNjQxNE5CNU9TVkU5UWJyV09mNjNK?=
 =?utf-8?B?aG9tZEF4ZFVwazNDQUR2ZVlsZnhwekRRRndVYVBwaUtWUG84cTdqOTVkbTlG?=
 =?utf-8?B?UEpEQXdQdmtkK25FMXNNMElPUVVXSEk0ZzN0ZGpod3k5SFVSYUZLdEVUcyts?=
 =?utf-8?B?R3NZNU1QbXR3WWVhL0JaTml0a2lUUzBBUjh0MHF3NVVXcHVUM3RaSGJIc2h3?=
 =?utf-8?B?RHhBdFFVaHlmdUZ5MitMK0dVMkdWS3U0eCtZeWJ3ZmhVd1V2K3hoTExuQkxQ?=
 =?utf-8?B?RmE4RTVDTittZVZvYmpNbllmNk9kemNMbmErMmUvUmxFSTJQcjFZeG55OWlV?=
 =?utf-8?B?bWh6dnhaOFM1aXh0MHNKVmVPQWxPMHVHZDg5bHhjbmViRGQvUk1RV1JCcHNn?=
 =?utf-8?B?QStlc3BsTEE0NHpOTFE0enhOOGZrNHVTclF3djhsNjBYNytpa2syYVZtSXFO?=
 =?utf-8?B?c1FDcldZUm96dHk2Q3VabmlYTkV3NmQzbVVSRGZjeWJxUUxvZmMvOWdFT0FF?=
 =?utf-8?B?UmltTmdlOEttSXZSRjBHdWJVaFJLVVF2U3ZVa2hPN3NIYVgxQkRvdkVXaCtY?=
 =?utf-8?B?bkxJZkVKanJqNGEwTzYreHp4RU1BS0JmOWN0ZHY1NlRZUUljUnozRXJZWHBB?=
 =?utf-8?B?eWQxMHpsNTlZbElBSGhHNzdIaEFNTFpqUlVscEw3SGhQNjZKK1lFdzJRcko0?=
 =?utf-8?B?aE83L0ZibjM4L0R2QXVhOEpyNFp5NTBob1FuRjFZQ3lUUkNQbG8zZ2ZUUkZq?=
 =?utf-8?B?YjhHejF0Q0VMMkU1OU5pKzN1U05sQnBTUjRUa2tNR1FFeWFLYUN3MFdPa0Mr?=
 =?utf-8?B?VkxyODhLMk1KS3JSb0JtdFdPanBIdnpmRThGUTRsNklEaWZCZ2NMRlFBQTlx?=
 =?utf-8?B?QTgrRDVQR2RnWGJTRmpISUZkaDM3VENRbVZlYUJReGxMeHhvVmZxclZuckNI?=
 =?utf-8?B?MGNvRkNBdUtyT0ppMnUvZVJ0ekRRNmU0TDQrbXZ0MTAwSFBhMzZQd0FmL0Vm?=
 =?utf-8?B?WUsvY0VFcGJrdmRlSmg1REFQU3Qrek5TL3d5RC9QbTM0cDM0dWh6QlJhMFFI?=
 =?utf-8?B?VmFkWHFkYzcySlBOeVFnOTFKUlNpNEV2T1JlTUgyZGJOaUdkaVpPNFdrd1ZQ?=
 =?utf-8?B?SEN2bGNSc2JVTFpYaG05UXRKNlI2OWxVMkFzQUJuT3hqT0s5MHhUZ280SkNF?=
 =?utf-8?B?UlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bca59b12-a5af-4e0c-c523-08dc23c7e35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 08:20:59.9115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gmdTnCRM2oytQYK1X/+5cWeevSgLjY16h+dcfnRiJb+AAKhHXBooNMWxYCUOFePJPsK/yYpt/3d/fBO3lnVGPrLSoefUsy5A0WntBWntt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1438

SGVsbG8gU2ViYXN0aWFuDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ViYXN0aWFuIEZyaWNrZSA8c2ViYXN0aWFuLmZy
aWNrZUBjb2xsYWJvcmEuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIsIDIwMjQgNTox
NiBQTQ0KPiBUbzogamFja3Nvbi5sZWUgPGphY2tzb24ubGVlQGNoaXBzbm1lZGlhLmNvbT4NCj4g
Q2M6IG1jaGVoYWJAa2VybmVsLm9yZzsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGFmbGV5LmtpbSA8bGFmbGV5LmtpbUBjaGlw
c25tZWRpYS5jb20+OyBiLQ0KPiBicm5pY2hAdGkuY29tOyBodmVya3VpbEB4czRhbGwubmw7IE5h
cyBDaHVuZyA8bmFzLmNodW5nQGNoaXBzbm1lZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MSAwLzVdIHdhdmU1IGNvZGVjIGRyaXZlcg0KPiANCj4gSGV5IEphY2tzb24sDQo+IA0KPiB0
aGFua3MgZm9yIHNlbmRpbmcgdGhlIHBhdGNoZXMhDQo+IA0KPiBJIHdvdWxkIGFkdmlzZSB0byBu
b3Qgc2VuZCB0aGUgbmV4dCB2ZXJzaW9uIG9mIGEgcGF0Y2ggc2VyaWVzIHdpdGgNCj4gbXVsdGlw
bGUgcGF0Y2hlcyB0b28gcXVpY2tseS4gU28gZmFyIHRoZSBwYXRjaGVzIG9ubHkgZ290IGEgc2lu
Z2xlIHZlcnkNCj4gbWlub3IgcmV2aWV3IGNvbW1lbnQgYW5kIG90aGVycyBtaWdodCBhbHJlYWR5
IHdvcmsgb24gYSBkZWVwZXIgcmV2aWV3IGFuZA0KPiB0ZXN0LiBUaGVyZSBpcyBubyBoYXJkIHJ1
bGUgYnV0IEkgd291bGQgc2F5IGdpdmUgc3VjaCBhIHNlcmllcyBhdCBsZWFzdCBhDQo+IHdlZWsg
b3IgdHdvIHRvIGdhdGhlciBzb21lIHJldmlldyBjb21tZW50cyBiZWZvcmUgc2VuZGluZyB0aGUg
bmV4dCB2ZXJzaW9uLA0KPiBhcyBpdCBpcyBhbHdheXMgYSBiaXQgb2YgaGFzc2xlIHRvIGFkanVz
dCB0byBhIG5ldyB2ZXJzaW9uIGFuZCB5b3UgZG9uJ3QNCj4gd2FudCB0byBzcGFtIHRoZSBtYWls
aW5nIGxpc3QuDQo+IFNob3VsZCB5b3Ugbm90IHJlY2VpdmUgYW55IG1vcmUgcmV2aWV3IGNvbW1l
bnRzLCB0aGVuIHBsZWFzZSBnbyBhaGVhZCBhbmQNCj4gcGluZyBzb21lIHJlbGV2YW50IHBlb3Bs
ZSAoSGFucyBWZXJrdWlsLCBwZW9wbGUgZnJvbSBDb2xsYWJvcmEgdGhhdA0KPiBkZXZlbG9wZWQg
dGhlIHBhdGNoZXMsIGV0Yy4pIHRvIHJldmlldywgZWl0aGVyIHBlciBtYWlsIG9yIHBlciBJUkMg
b24gdGhlDQo+IE9GVEMgc2VydmVyIG9uIHRoZSBjaGFubmVsICNsaW51eC1tZWRpYS4NCj4gDQo+
IEdyZWV0aW5ncywNCj4gU2ViYXN0aWFuDQo+IA0KPiBPbiAwMi4wMi4yMDI0IDE2OjAzLCBqYWNr
c29uLmxlZSB3cm90ZToNCj4gPlRoZSB3YXZlNSBjb2RlYyBkcml2ZXIgaXMgYSBzdGF0ZWZ1bCBl
bmNvZGVyL2RlY29kZXIuDQo+ID5UaGUgZm9sbG93aW5nIHBhdGNoZXMgaXMgZm9yIHN1cHBvcnRp
bmcgeXV2NDIyIGlucHV5IGZvcm1hdCwgc3VwcG9ydGluZw0KPiA+cnVudGltZSBzdXNwZW5kL3Jl
c3VtZSBmZWF0dXJlIGFuZCBleHRyYSB0aGluZ3MuDQo+ID4NCj4gPkNoYW5nZSBzaW5jZSB2MDoN
Cj4gPj09PT09PT09PT09PT09PT09DQo+ID5UaGUgREVGQVVMVF9TUkNfU0laRSBtYWNybyB3YXMg
ZGVmaW5lZCB1c2luZyBtdWx0aXBsZSBsaW5lcywgVG8gbWFrZSBhDQo+ID5zaW1wbGUgZGVmaW5l
LCB0YWIgYW5kIG11bHRpcGxlIGxpbmVzIGhhcyBiZWVuIHJlbW92ZWQsIFRoZSBtYWNybyBpcw0K
PiA+ZGVmaW5lZCB1c2luZyBvbmUgbGluZS4NCj4gPg0KPiA+DQo+ID5qYWNrc29uLmxlZSAoNSk6
DQo+ID4gIHdhdmU1IDogU3VwcG9ydCB5dXY0MjIgaW5wdXQgZm9ybWF0IGZvciBlbmNvZGVyLg0K
PiA+ICB3YXZlNTogU3VwcG9ydCB0byBwcmVwZW5kIHNwcy9wcHMgdG8gSURSIGZyYW1lLg0KPiA+
ICB3YXZlNSA6IFN1cHBvcnQgcnVudGltZSBzdXNwZW5kL3Jlc3VtZS4NCj4gPiAgd2F2ZTU6IFVz
ZSB0aGUgYml0c3RyZWFtIGJ1ZmZlciBzaXplIGZyb20gaG9zdC4NCj4gPiAgd2F2ZTUgOiBGaXhl
ZCB0aGUgd3JvbmcgYnVmZmVyIHNpemUgZm9ybXVsYS4NCj4gPg0KPiA+IC4uLi9wbGF0Zm9ybS9j
aGlwcy1tZWRpYS93YXZlNS93YXZlNS1ody5jICAgICB8ICAxMSArLQ0KPiA+IC4uLi9jaGlwcy1t
ZWRpYS93YXZlNS93YXZlNS12cHUtZGVjLmMgICAgICAgICB8ICA4NiArKysrKy0tLS0tDQo+ID4g
Li4uL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYyAgICAgICAgIHwgMTU3ICsrKysr
KysrKysrKysrKy0tLQ0KPiA+IC4uLi9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12
cHUuYyAgICB8ICA2OCArKysrKysrKw0KPiA+IC4uLi9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZl
NS93YXZlNS12cHVhcGkuYyB8ICAgNyArDQo+ID4gLi4uL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dh
dmU1L3dhdmU1LXZwdWFwaS5oIHwgICAxICsNCj4gPiAuLi4vbWVkaWEvcGxhdGZvcm0vY2hpcHMt
bWVkaWEvd2F2ZTUvd2F2ZTUuaCAgfCAgIDMgKw0KPiA+IDcgZmlsZXMgY2hhbmdlZCwgMjUzIGlu
c2VydGlvbnMoKyksIDgwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4tLQ0KPiA+Mi40My4wDQo+ID4N
Cj4gPg0K


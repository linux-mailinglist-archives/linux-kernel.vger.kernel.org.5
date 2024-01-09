Return-Path: <linux-kernel+bounces-20985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D582881F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA77284E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2F39AC4;
	Tue,  9 Jan 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eOfFeWmK";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6GmT+O/L"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5D1E4A7;
	Tue,  9 Jan 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704810641; x=1736346641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZVaHYbDJ4goS5WJc7nSbXxyBZGSUc/6vy3E4gPut0pU=;
  b=eOfFeWmKS8kTeT0a6L7zQNP3wYurhyEnB+cEaLqU/lOYGosYUNRK4VhL
   1Zh23KbK2JgYrnVBNS2qcQun/E9TBIVzqalVNvEJjysBwLX2rnwhFA7n6
   OKhBLh/QxlzWc6sIuRUo9j9QxNKNw0z2QU/IsfH4LC94CG8Ost1IZFiHr
   H6EN/NRbRRyjH1NbAUTTrqtrl48kO6eZCndjbGuP1fWObrZbQnlIt9PxJ
   pKySWXNChRwcB/sWG+Gi6BBFbT6u8HznLYiCBk5S5GWxSJHC7lBPbSG/r
   fuWRhOQSEKt0lfZg979a9zDcXYF/fEZP4/OuN2zdN/J4BPnOuI3Hnpa3R
   A==;
X-CSE-ConnectionGUID: XY5LWNL8ShCzQlO83QJVVA==
X-CSE-MsgGUID: oH9QM/9wQNWCj+z48wutpg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="14909266"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 07:30:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 07:30:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 07:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlYILWiAQdWLavj4Esk/dp/rJTbLOgAnhDU5BxYTUGHBvUCUtilN8uPnklwJaWP/q1I3wSb/+MR6ct8w2t5Zde6M7mvgCWjnJ05h69wEkI2oHmOxei3DMkTKzp7lNwXFLC2IK9Z8cYmcvO3vuBboTsamkPHMbpI7GJ1kip3Fo6MWAjHYQMHg3XISXu9s0wYephphUlbXqTmmOop8MWpB5l6DYyISy2Dgar2JWlkTKV70Py4Wv66GZ5l3Z6L5uhOyPZRcTj/o6CBJ7sntBSJ6z76/K74H4jPhikHlYBN3BOmHslqEFPAvo59AknNgOKyhwBoN3qRw4YO9CwMvJjlACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVaHYbDJ4goS5WJc7nSbXxyBZGSUc/6vy3E4gPut0pU=;
 b=PTlHcywWyS6c2PMRhnr8apTa51089AjuUNSdqiBWq2ZKGkwO+/d6LjuohS5V9BUmWVJ1JtTQynkNYQ+HPvfTtH3PIZeA+26sFkcyvZp6DxwaW8PPXkJSiMXHjexnthLV4+VnmtXSx3Mlws/203HsH/2ZqfPCvHT5T65AyRh5F6TnUQpiFx+PUIdsjpYKQvpXVOgAJ9gzrEw7fKpuzASdpbs++53235CRDXGpZKEbQnp3uo2XCEJ4HxurFbXXHrXtzVZQCsHc2d88RVSZnJ20scG72utEfp3Yq/C/VGefghseOY2ICcd4/kVxSg0IYOQg4xO1NtJDgG2QsGC6mEd9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVaHYbDJ4goS5WJc7nSbXxyBZGSUc/6vy3E4gPut0pU=;
 b=6GmT+O/LO1LoBjwahq55zvYFwGHB81urrVzOD7SXCzw9tQqwyx8d2ewTgw83KZrk896OAsZ34i4HNOUeWtIRKwBOYo2Gc8cjV7dBIAILolMdEHrWTNMkNidO92y82Uu7GiU/jPYrRJeBKiOcN+p7V1G9fVa4JLfsf7ly7O/JRxtV1kbGJu160dPkzwA6ClEaKrwvHFrjAfz68W7AWiicb8sVfuU05GPPqpp+YTUo0MnWhkW7vChh+5D8PHDXfVtQCljAlal0Pd9XR7mRtbm0EIFHdAATtwrJHxNeI1ch+osBEAI7QPKp6ChcXfAnur0g01RlMkS3sBlZtna2pMSesg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 14:30:24 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 14:30:24 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<vladimir.oltean@nxp.com>
Subject: Re: [RFC net-next v2 2/3] net: dsa: microchip: Remove redundant
 optimization in ksz8_w_phy_bmcr
Thread-Topic: [RFC net-next v2 2/3] net: dsa: microchip: Remove redundant
 optimization in ksz8_w_phy_bmcr
Thread-Index: AQHaQuJi35nw5FC5+k2jMVSK7QaPF7DRizcA
Date: Tue, 9 Jan 2024 14:30:24 +0000
Message-ID: <7a993639f8076e22e89a4ca96ac51085f2ee612a.camel@microchip.com>
References: <20240109095753.1872010-1-o.rempel@pengutronix.de>
	 <20240109095753.1872010-3-o.rempel@pengutronix.de>
In-Reply-To: <20240109095753.1872010-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: 83ba8af7-6f95-477f-9bd6-08dc111f8460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErHz1dKrm5+VY8764Sq0xswF110cIExnkhVyGP6xLSXxhQO7O4tgKJeljvnp9qua/4znweM/OVlDX57KTHmOOyamCfsQT77uPukhXvzme8xfV/BbHAQc8GM4NwQWKtgmB/DfUm9NoqFQBUMVEkfETzaRmcBpRACMcMKOrODNwO3icwtqTG/zEi5WUw/Fi+V56b/rtFC79ExjpIzMHpONDmjReWKRRtWPwN2+JGbKE2W9A4ZV6hYUWZPsudfEAbwsYZJZRPMqMkRoSj6OMdcCLusOgHjBx4QR/A2Zn4RXL0hy8DYE96UMMeQ3XOtoypIPiObxs9XbORow1CJ9GicZXkzY96ubwD2KxUNbQ1g9ixsUdZ2SU477PcwRlTOu/UkaoPNp7ODVJAhkqiyoYK7RcuNKsjaRGs0qqKhqIQIGDrLhw3M1GlPBzOf9VxW8JWftRusn1yKopLtDV61we2pMh4Fqy+akxWvR2WedVYuWVYvzkxu6Z8n4URdPAdjQIsBY6f/8Ja8go1sCsnWutHW4btsADR7ZonEEC3zJazC2buGtcoPkOcHI/BHWt0GaLHUV9cuzM+Ycn+JSpJ1WSYfpe5909Y5o+Hj3OPgipGXQRXkb0avxIdQv3f/3SwYnKPG6RBdsuiB3MPS0vu1p8SmN6GW9R4unOZGBLiZ+IhswjYw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(71200400001)(6506007)(478600001)(6486002)(6512007)(122000001)(38100700002)(36756003)(86362001)(5660300002)(7416002)(76116006)(41300700001)(83380400001)(38070700009)(4744005)(2906002)(91956017)(110136005)(66556008)(4326008)(54906003)(66476007)(64756008)(66446008)(316002)(8936002)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXo2dEpleW0rZkg4d09UcGk0ZGhYK1c3OXpSakNIeDY2S3pKaFhoaU5hM1g3?=
 =?utf-8?B?RlcrNm1NcVR4TnJQVlJuQkhVNzRHanUwSGR2K0FST3NwLzd6YjFvczArTkpw?=
 =?utf-8?B?cnpIbjE4VEl3NzFIbVpxTndRR0VvVlNPWHU3WGJWY2tsSnFsb3VXOUdQUXp1?=
 =?utf-8?B?dGhZeXh6S0R6aWswSzNlOHBTSnppRWgxaEI4VEtXYmNJTjJUTnFvcFQyckRP?=
 =?utf-8?B?L0VLWmVVQ2FyanJpUFdXaldBbTRIbFZBUHp6TDFETUZETUhIT3FOZS9lMnZQ?=
 =?utf-8?B?Z3JuSFN4aFF1T3NNRWRsS29BUWl0dHlxTGdQWUpobnIyc1dJNTlpSHRCWkRT?=
 =?utf-8?B?a2RIbU1rbnlNZUFhUmlOdEZ5M3hPdkFOZ0NlSzJ1VXBkYW9vdS80VEJEZnZz?=
 =?utf-8?B?ZTl3U3JSVjR2ZDl5U2J5aW5jVmtRZ3pkRmdNMkptVmlQUjd1d2VaWUh4NGdt?=
 =?utf-8?B?RWVCT1E4ejBUUzQvQjU4L3AybzYrQ0t4eWNoVG56TE5FY0FQbXpvTmlVS2Zj?=
 =?utf-8?B?ZXhnblFEZlRuOVo5RUFsN3JoMlRrbXZxM3Z1S1ppMWpIclh4UTJhN3JOaFlt?=
 =?utf-8?B?RkFsUjdqL3Z5K25TZGxHM2UzSk5acmlJd3NSQmhEcVhDdWVYR0tCMlYvNXkr?=
 =?utf-8?B?QmRFTXlLeDNBT3d1WHRmNW1MRWZYcTlVZDJNQXdXTEs3RjBiKzd3ZWFLOEpu?=
 =?utf-8?B?UWU2cDdkRmRCd0gzRHBCbVlINHdSMGFPRVpKOUxCWUxjcUc0ZmNOTUZrVEN6?=
 =?utf-8?B?U2F4OUI5NVRlRXVQdEgxMkJwZlpmaWJ1QmpGZXJUOElCT2lENTJVb0VYdUJw?=
 =?utf-8?B?dEdqOFN0N3k5OVp4Zk9xcHRrU1hDSXBsWG94Z0xuYlBwVXVjWk4xTysyOWpY?=
 =?utf-8?B?dGtSY1hzVG55SUhucmxJcHB1ZC94d2h1cFVGZ3FSd0J0bk9ISFZWWCtiTVRn?=
 =?utf-8?B?SHl2eVVjZ0N0RGxydjd1TzNBbEQrZkoyVDBtMnN4MWtlUjJYOFVLelQ4U0I1?=
 =?utf-8?B?UERnOGxPVEMzNFZucmRUdEdpTDhLam44enFOOWhBVzRvWW1BSHJYME53Rlp2?=
 =?utf-8?B?K2tRZFNxcXlqUXNlRmFQK1laajVMS292eFc3cFl6a2k0OFNadmh1VnhrM0hT?=
 =?utf-8?B?ZGVwMmJRMlFhb2dJL29Od0loeHhQV0xzVXRmelFyVCtyeVRtRDJveDFXY1Bq?=
 =?utf-8?B?MTRQS3R5L1VKVGNOTFZySCtoQUVLbTdDcXBGSjZkQzliUFBWSkJDWVdXRGMr?=
 =?utf-8?B?bXB5THJEQmdPRERxUXBZS3VIaFdkNGJBcktHMXRJZmhnWWJ3ZWtSc3ZCL3VU?=
 =?utf-8?B?cmwrazBrbVp3WlR5WEpiVVF2OE84QjhCRWFZRzRaRzRvbGxOaGhBUTJEQmNn?=
 =?utf-8?B?NUNpMThYckwwSVdGWWdBY1pPbFdJU2VEQmNlZ0lvR1Bsa09TUjVwLy9OaC9j?=
 =?utf-8?B?U0djWmtObDRmd25DM2xHTlJ4ayt3VzVBSmJabVUrNExVUXJ5Wk9vbC85K0Q3?=
 =?utf-8?B?cmlzUUxnWXlXWmJ0cG9KVGVTamk0Z0tZeXVvcW41Z2lyTTdFdmJ5bU5EZ0x0?=
 =?utf-8?B?c0puZ2NaK3lId0ZGRmhwTGY3dDZUSHZQRzVkR2g5TXlzYXpBV2pNYUV3SkpX?=
 =?utf-8?B?WWUvWElPWXpWQzJVOHZSS1lISUpYejRlbWM2MTd2ZnNaU1hGTFB2ZDM1SmR6?=
 =?utf-8?B?bFN0MStiYUJoNWpaRU9JZlNaaUNXcERHZ0tqOWJBREo1WHlqZXJFd282cmdG?=
 =?utf-8?B?WnNzU2cyS2Urd0ovbXZyNmhIUlVUZzJBbTRQL2tpUDhlOGRwakxzZXF3ZW9K?=
 =?utf-8?B?ZUJ4YmVlZVVmM3dRTFpXbFV4SVhOTVNDWkFuTWszUmFjSjBzMWh3ZUsrL1ZK?=
 =?utf-8?B?V2d0UUxGZ2ROY3lqZlZPV0dOM0JPK0lhUSswU21DZHFJb3FFd1dlR1U3QTVz?=
 =?utf-8?B?eVNiRnQrY2lEYWZxS2xFNlorUzhLZ0xWVUE4LzA5UXdUaFRXODNqMnNQd09W?=
 =?utf-8?B?YXJ3R1h6cHFxUDNyb2FKUzF1ZUladk8xbkNZRFlIYmd5dWNhRkxPSUtiWTln?=
 =?utf-8?B?YXliaWI3bi9pMDRCNFJON2gxWG8xcDNYcS91QnNhUmtaSXFtSFJnWjdQSDVF?=
 =?utf-8?B?VEl6eFRWcFJrOTBkKy9VV2hHY2xpQnJPK2FxUm8rWi8xTTNKQVBzbGdESDNz?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25C7850C27A4B645956FD2D7B388A00D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ba8af7-6f95-477f-9bd6-08dc111f8460
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 14:30:24.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuSZze5M5hguKc8gZA4UDVL1hwRobvjdFklh/aZop+VGdSlT0B7ABSRKjRzj6NyUAiBVID0uZ7KWHRttpdeQUibN/CslTW03+NZS7RUgnS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531

T24gVHVlLCAyMDI0LTAxLTA5IGF0IDEwOjU3ICswMTAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBSZW1vdmUgdGhl
IG1hbnVhbCBjaGVja3MgZm9yIHJlZ2lzdGVyIHZhbHVlIGNoYW5nZXMgaW4gdGhlDQo+IGtzejhf
d19waHlfYm1jciBmdW5jdGlvbi4gSW5zdGVhZCwgcmVseSBvbiByZWdtYXBfdXBkYXRlX2JpdHMo
KSBmb3INCj4gb3B0aW1pemluZyByZWdpc3RlciB1cGRhdGVzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPiBSZXZpZXdlZC1i
eTogVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4NCg0KQWNrZWQtYnk6
IEFydW4gUmFtYWRvc3M8YXJ1bi5yYW1hZG9zc0BtaWNyb2NoaXAuY29tPg0KDQo=


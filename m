Return-Path: <linux-kernel+bounces-26932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE582E803
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9712C1F23749
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387886AAC;
	Tue, 16 Jan 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tm/aPviE";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NqbCRV9j"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935D7E;
	Tue, 16 Jan 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705373462; x=1736909462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=etsHmOmv/8qkyp1hasOjdj3pK1VL+lf3q31y80J3+xo=;
  b=tm/aPviEUWkvN4zga+VhJrAhNg6vompkonPWkWAwy3oRNxLTGW4DEBT0
   wmc2YvXdE4Lf8DsjSjmQ5S9GJ8x7wJEDREd6Bk/gzeyUK6GMIFI0UtZze
   5wss6NyGeRD0rs5u5QE+OPAETHTCcPh9Pa89IyTFks2SIdc1NU6bMoeG3
   e+yj+qw5BquTxKuavqZwy97AdFzf+ZVy/rNmyCjFsjBcctrdv4uKEFpLI
   urMoN/X2H/+EZ0B8n2pB6IfF4dwrmZITawNT5UEHqJfwQSj0dTGEqI0px
   tFwZOlZ9mst157pj9CwKEPrexleTQbSqSKMl2F71zQRcjeo1/CQYzW5yF
   A==;
X-CSE-ConnectionGUID: Q5pFpyDYS5WlbjbaGqD6sQ==
X-CSE-MsgGUID: 966Cm8d1TCit9ymQ43ZgWg==
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="182015687"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2024 19:51:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 19:50:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 19:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHtVbUjX98kJ4WJ7ZlIilGU9ixmHrofr+VhQlpz1cW4PoxfceEhC7DZy54RQ0jek26IZSr8lBOfksCkAR38V/cCblE9Z44f7stIVAKFchc7QxntA5dTo7znvAmnI79PTSYHwP5UEedfK6roEmB/4kNl05t4VOZiUHhkqL/VXGgNmuLCNNkPHiehtPFqg4LwN/BLHvgyb7xqr5kUsaRpleMj31ccfKOVPH3+HQIb9CrcieAW23x5s/YWYerD+6sDKvo+Avb6LcUEFzi7gKLxxd8ETogcKZLsY+nIS++fmALlHgCck6kmUtqKFGAH3VwjP5uImS6HvXYiALW2h4umosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etsHmOmv/8qkyp1hasOjdj3pK1VL+lf3q31y80J3+xo=;
 b=bwpP67msQ/LIzv+tmlEkLkx70+ss740R/pwr8DY1mfXUPu9WGMjij0no66+VZaLPvhHX218TwIQtjPFNW6Z8L5ZIs2tWi07LnI1Eled5zEYnsTLzcZAo1/UbfDxN+dRgCiSPYxIBT30qRYYTI5HHPnL8Gte/ct+aVBdFJldKxFmP7dCg75vCSrzOLJWszAMnmBPiY9pvEGLK7S2In39LK8WYeSCCiMbkLjP1VxbTQv3mJACxxo1s5aQvTLiqNcicjlKya+bXnfDxsaJpSBxyDMYrszGj160drIiyXBNJmlfZ1pMputi0BZwE6OaBo5kkcybIoUnKelVcRjUm8n2/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etsHmOmv/8qkyp1hasOjdj3pK1VL+lf3q31y80J3+xo=;
 b=NqbCRV9jBJdIO4Z/7aB86/WKJYcwIWUK4C7DMRKqkJcyunFdW+AVIeFMJL9u7zWvgiD/Fbg1VrkSlcwo07XTgs2DeadFIN1yYWXv6CNGj1W/GDTalBVULJ19Aoqlq4x3vSspiJXtbFLoBYNblurtzEmOfzEJjNRK6xqbmQgBU3/oiycJrINrk6Iy7+6ySH+UtRaWrHTNUSE7o/3QwLz9BOQud05Hubpxgs9yk+AMZGrGl2wnjgv7AJhVl3GWkNfBCyA0MHeFwxrHU7DAJuw6M0I2RK0fBM+LD9bI31zbngpZDdbF7iXoaxEfiYy12tG1k8Mm0RTyPan/eknpAOurxQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 02:50:41 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4%7]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 02:50:40 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [RFC net-next v3 3/3] net: dsa: microchip: implement PHY loopback
 configuration for KSZ8794 and KSZ8873
Thread-Topic: [RFC net-next v3 3/3] net: dsa: microchip: implement PHY
 loopback configuration for KSZ8794 and KSZ8873
Thread-Index: AQHaRWDDkq5U2MnUVUuOtr6ZsUj9ybDbwwkA
Date: Tue, 16 Jan 2024 02:50:40 +0000
Message-ID: <675657756f9d27ee0fb1d6a1fc59d532f066b122.camel@microchip.com>
References: <20240112140716.2715664-1-o.rempel@pengutronix.de>
	 <20240112140716.2715664-4-o.rempel@pengutronix.de>
In-Reply-To: <20240112140716.2715664-4-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH7PR11MB7642:EE_
x-ms-office365-filtering-correlation-id: 8906c16c-a0d0-4c91-8450-08dc163ded3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yx7/M4WvKlrEk2CWegxfzN51LKoMRcprnMfXBImP8T/JAInH9gJdX6XE0mky/9Yi+Dtbzc4CxF5wxkxsM9xdvtiAfVMFzKogV/S3wRwhN723QFAvlaRFpFAHSxsCeQ8DNgi/0EuvLAf9IxchhG3i1VqQkRXP+HtnA+mi8xwcKL8I12tjQqndPRD11voY358OsvU+1BynmKBkDCnVIzEkoJGEcXBrO0uPbp5HZbUrokyGdlZRb/TWmbo4oqcER4tuSftxfGEPM1on7cCz2oP27ouqp0Ia3fHdHm8YEJbAIla+FxrdMwyBtlZVmBrAJ+CosN7RSCMfwvzF5BdUJRICrbOoUTuung9HyTaXmOiEx9pSKVKS49gg+T9nnBhMMWmjGLEdFvF1bXQwpCNGgnxcBwpGrUFtz4NWr4nUDkTB0s2DzcikevhWgQ/xQ9fyX/DiyecngSm756RcP5BLtd2bLiassX44xqdVG3xEBoshSS7jQiJQ5kzYx2O688wywnWgrkchzpmKBrCOPT9KnVY3QdoJB4ZwZsJOCalqlonnbPq3mFQT41Ff8n+VenIueyrkGA/j8Fn6Vo2bU5b/13WOmQWItY0mjkECM9TKX/rnCxongV3uRh9lrGnOCNYxIoX0L5G4siE4fRpvYR4z9WwX4jWt8aWEh8mHiZXKXid/RTU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(4744005)(2906002)(5660300002)(7416002)(36756003)(122000001)(8936002)(316002)(8676002)(86362001)(4326008)(54906003)(41300700001)(38070700009)(64756008)(66446008)(83380400001)(26005)(107886003)(478600001)(6486002)(110136005)(91956017)(76116006)(66946007)(66556008)(66476007)(6512007)(2616005)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEkzWk5wcElyMEN4dytYS1BkODhPZ3crbEpmTjY5Z29CZWJPa08zMTVZcHVG?=
 =?utf-8?B?N2VxRnI4U1Q0eTZlbnZOL0o0ZzhrVGMzeld5a0JFc3RVYWVXZnczMDRITDYw?=
 =?utf-8?B?RHN5KzJIZi80ZFRtSUVIUkhtc0pJcjFxcWJyUldKWnU2Y0VudVJWRUtpNW9j?=
 =?utf-8?B?VmxhOG5WTnZKdmpYWnBaL0NodlNZdUV5cW5NV05zSVM0ZmtlaEFXOVRWYThW?=
 =?utf-8?B?UTUwMmNaalI5cllUamxBOE9mUWlYS3ZXMFdIa2o5cEUvRDFibjM4UDBDSnZt?=
 =?utf-8?B?d2tkWGlqVkg3WHhTcHg0cWtXRnNTa3RHWDVOTXRUVmhlckVQRkdLb2E2bWtt?=
 =?utf-8?B?dXRwZnRKSjdDeVduN3RxdUFJd0ZGTnZUZHcrYWRDaXNjYTJGYms2ZDd3WXBS?=
 =?utf-8?B?UUJOQ05TWGVTcGV5a3hLblZyQ1VjbktCQ3dQL1NJQlZWMmk3VGZjd1YxMW9D?=
 =?utf-8?B?SSsyY0Y0blcrRGZ0cnpwbnhGYk5qa1RTdVRPcy96aHNMMnRjaHp4YWYvOFh4?=
 =?utf-8?B?OHZXQU81Nm1waUp4bWNzL3ZkL0lhTmhpd0tyZy9QNXpLTi9Zd2hQVlRsUytQ?=
 =?utf-8?B?L0RjUExoMnVLdzFqMHY5UmhLQVRSblB4VHloYnFpZklyTDhsU3VnM1dBTWZs?=
 =?utf-8?B?Q2EzVUxJS0tQZ00wRnVJN1FWamNmVGw4OWdxcEgxNEFaVWxiclpIalEveUtC?=
 =?utf-8?B?L25weThjcFQ2VFZ5dGFlamd6R0d6UVJTbXJUcTRwSmFCUlYwZFJLc1JKWGxS?=
 =?utf-8?B?b0xoSlA1MHZxRXRVUmd4anRzN2NkdHBlNTFnY2ZnN3RNcDVSSHBUbE1ZaC9K?=
 =?utf-8?B?RXFDUmhucWs0RGx3Y2VmV2JicWZPUUJ5VXYycENPQXZnV0wxS1ZkeHhma1Bs?=
 =?utf-8?B?Y3lxMm5yclhwMnppK1RhNm5aYXNqNkhGZ1M0ZDJlMWVMZWt1SFlScit3aGgz?=
 =?utf-8?B?YUZRSXlHMTYwOTB0Qmt6ZUxYbFBtc1dLVWRuVVIvL0gzZlZaVWptVEc5dWlw?=
 =?utf-8?B?a2pWQU5YeTMwM3FkSi9aZ0VBNHBaYTA0amNObWVHYzVQZHZ5c3poWkFobDlx?=
 =?utf-8?B?VUc4NlFWQlRaSDExb3E4RVp1UHF3UnphaGtlYnpydGUwSGlpQlVOODNOUVdv?=
 =?utf-8?B?b0llcEZIdlVkSUVLV3AvQUdSZmVKV0ZGQmdlb3ZvaHJ6VFNwV3B0NFBKZDNI?=
 =?utf-8?B?YmJzNElyYzU0a3lUTDNIWTFNUHppZ0lzZHE0eW9KaUFMemZyLzlmdjJqUUtX?=
 =?utf-8?B?U0x5bnFCSjladVc3eVVKQ21RakRwd0RUSTFNRE9VblhwUjZtUTc4VWxQZDhZ?=
 =?utf-8?B?citsVUhWZitYbU9KeWd3NWx5alhURzY2NVNJeU9XNDBESVcyOHhTTVZON3Ey?=
 =?utf-8?B?VGRDaG9kcDNBQ1VqTUlzNlpNcHFuZUNxVzhEWENBNFg1blFTc2tLK1p5c1Nw?=
 =?utf-8?B?NkxTM1FRYnZCRHJLcHIrNGcxZzkzTTY0UjdYT05aK2xNOW9LaWlYL3lEbGNy?=
 =?utf-8?B?MDNjOUh3QmovWlZuQ21yZWxkc1NuNDFHWnl0amRPYmh4QWM3c0hGczVUWW8w?=
 =?utf-8?B?U05EekNtY0ZqcDQ1WTYzQ21OcjZEaUNMS2QzZzErT1MyNktJbzVLNjY1eDd6?=
 =?utf-8?B?NEt1Sm9yMFkyYWN3V0RiVEgxTWI3Wlo1TkRZc0xLYXRsN041dkFENGtuYktt?=
 =?utf-8?B?Z1JyM1dDbVVvTHM2Q3VPSThKUVRWMjNkT0d0LzdIcnFZV2ZQTXhXWHAxV3Qx?=
 =?utf-8?B?TXVuWFIrL2M5dlpmZWF2ZUhmbmM1eFRpaU9IcG1ob2dEY1VnaEhEYjRRTUFF?=
 =?utf-8?B?bWpNd0N2c2VqNW5aWXh4d1RQY010SXZxL0dVUDR3QnU2YXY1NkcrNm8xUlVr?=
 =?utf-8?B?ZGEyTm9RUVowOXp0eEFZaCtlMXNTZFZuNHlFWGJYL0VhcG9JeFJ1N3ErajFs?=
 =?utf-8?B?cWUxNVN0R1RmaVJscHBzRVdSSjdkSmJOOVdZUmZjSjVDb2ZvR2pndVNTOExZ?=
 =?utf-8?B?MlcwN2xmTWQ1dFBGZWwxZXIwSVVrZUo5ckhpK01NdXUyM2I2c2dvd2dpZ3FI?=
 =?utf-8?B?MnRGOUl6RU5Qa1pDUlZoRlcwMnNKcXN1dDhKaFEvaEE5Rm4zbVhLWnM5SVh0?=
 =?utf-8?B?MVprOStHQTJPbkRnMWYrd1hWeHJicTR0b1BXQnczdHI4bDdzVk9vZVZTcWt0?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <974619CDB0F5A347BB9C4BBCD7C4F7AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8906c16c-a0d0-4c91-8450-08dc163ded3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 02:50:40.8441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJeV0pY0QyQ60PdFaoZi5KqXpF8LbErZvQMF+0Sd8Fm35wHJQ9F9lExeES1xZZXkAX+XxZVFvIVUaw7hHr/s3T5bD9MtFY+zI+SP61dUt3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642

T24gRnJpLCAyMDI0LTAxLTEyIGF0IDE1OjA3ICswMTAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDb3JyZWN0IHRo
ZSBQSFkgbG9vcGJhY2sgYml0IGhhbmRsaW5nIGluIHRoZSBrc3o4X3dfcGh5X2JtY3IgYW5kDQo+
IGtzejhfcl9waHlfYm1jciBmdW5jdGlvbnMgZm9yIEtTWjg3OTQgYW5kIEtTWjg4NzMgdmFyaWFu
dHMgaW4gdGhlDQo+IGtzejg3OTUNCj4gZHJpdmVyLiBQcmV2aW91c2x5LCB0aGUgY29kZSBlcnJv
bmVvdXNseSB1c2VkIEJpdCA3IG9mIHBvcnQgcmVnaXN0ZXINCj4gMHhEDQo+IGZvciBib3RoIGNo
aXAgdmFyaWFudHMsIHdoaWNoIGlzIGFjdHVhbGx5IGZvciBMRUQgY29uZmlndXJhdGlvbi4gVGhp
cw0KPiB1cGRhdGUgZW5zdXJlcyB0aGUgY29ycmVjdCByZWdpc3RlcnMgYW5kIGJpdHMgYXJlIHVz
ZWQgZm9yIHRoZSBQSFkNCj4gbG9vcGJhY2sgZmVhdHVyZToNCj4gDQo+IC0gRm9yIEtTWjg3OTQ6
IFVzZSAweEYgLyBCaXQgNy4NCj4gLSBGb3IgS1NaODg3MzogVXNlIDB4RCAvIEJpdCAwLg0KPiAN
Cj4gVGhlIGxhY2sgb2YgbG9vcGJhY2sgc3VwcG9ydCB3YXMgc2VlbiBvbiBLU1o4ODczIHN5c3Rl
bSBieSB1c2luZw0KPiAiZXRodG9vbCAtdCBsYW5YIi4gQWZ0ZXIgdGhpcyBwYXRjaCwgdGhlIGV0
aHRvb2wgc2VsZnRlc3Qgd2lsbCB3b3JrLA0KPiBidXQgb25seSBpZiBwb3J0IGlzIG5vdCBwYXJ0
IG9mIGEgYnJpZGdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVt
cGVsQHBlbmd1dHJvbml4LmRlPg0KDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1bi5yYW1h
ZG9zc0BtaWNyb2NoaXAuY29tPg0K


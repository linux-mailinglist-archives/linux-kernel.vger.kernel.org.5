Return-Path: <linux-kernel+bounces-23711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E882B09F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BE71F22C76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F23D3A2;
	Thu, 11 Jan 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="y+dOkfMJ";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="ioX7RmKR"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981D3AC10;
	Thu, 11 Jan 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BD1puq024056;
	Thu, 11 Jan 2024 14:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=dk201812; bh=jELFagvWxRzPp5qVQElZKf28NL/cUA+fx4RJtnsIXqw=; b=
	y+dOkfMJ2ZuF9Ks/KF/eJevUkC3vJW7LjlKuO0o1MB6YSU9F/H4ghhI3iPjaFrIa
	YdyEtAhTYGutebFKtGh/n09Xzi/ies8Sja1nxM3fR0/M1uJn7U9whlIDAUR9WgtV
	ct5TgPG7FzmVOxvP7j7rQkFftA7bQEXW16zwDvA394q7lzLEdFJPZ86e6DIMZDpA
	jbi6A9OdpbRtsvdTK6bhu+vT6mNYhrfKsrPD3T3h5ZNUXTXxzjvF746KUTwxJN86
	Q6VC/7hpLY8aBO5zcVqoblVxXVzC0T0EoFFDx+yu1OEi/0R297iRSfH03vbEY7WL
	Xt2CNxzDSKCYYQDLfEwf2Q==
Received: from hhmail04.hh.imgtec.org ([217.156.249.195])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 3vj6vj8dvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Jan 2024 14:24:53 +0000 (GMT)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL04.hh.imgtec.org (10.100.10.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 14:24:52 +0000
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (104.47.85.41) by
 email.imgtec.com (10.100.10.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Jan 2024 14:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxwN6qviCYEcJ/D1GgaZWtfliQZMr+SSc/CId1E3+FUd2lYB3qaLf0FYEYfvWa3lwcwnaTb6w+McNhN2RgosC4De+UkZKH3sVQMaFc2OzeynY5bJRg7IBQTZAxbQNqhedRlDQxY4LVLZuuQNMSmBUao/3NXhGf3MDvqRkouLLMUOGpSkTUFOAaBMatkak0vmF4UouSm9Zo95fCuNIl8hx+NY4TgQdSZVOKzP8saqFw07oLoy0fQ8OjUuACuD/YO7f8qNg9nm93dumx7Wue4+IzEcLE/SnFE7flTm7gyd+IG7GIXnaa7ZixtfLAN+P2aSxE8ZphG+HDhb6cESnAQJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jELFagvWxRzPp5qVQElZKf28NL/cUA+fx4RJtnsIXqw=;
 b=PGM8vso9MTTMSG0j8En7e0P0eST7fs4n2EHysNQ95wqPBi1a+4fH2hfDz50Cm2GUWSZJgGVjyYUkH19L9w1wMnSNj3bLIBdcwSMKdIFymWbvmf/36CHre2CtJcPxcuIGuYFzVnVUF75faCLrB6xe0MOZ8Ek6pE6bqeAm2MU9EGxuNGqBeYMzpPsPELWKwXTztHqW0F9+mr4HyeHCO4NE55MrFj2NEAzfQ1T8l0zkTmiinBnRaCChp713OycFD6KGc5Y4WuBqpdJjPSl6jGyQ2FERpkwpUf9NyvXGqSET3ImoJ3LMp91g5UVcgRuUnT6DPN2nAx8aWtB6g7INcC6kdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jELFagvWxRzPp5qVQElZKf28NL/cUA+fx4RJtnsIXqw=;
 b=ioX7RmKRA4HaKIg/wmNPphE+mxfV0y7GdnXQXiH8NyzmlQCGOey0FtNEP78FJyd+iposAUSdHLIjw7FlvZyG2mDzOPBDivBfzhv0O0DujQpirXJX1k4KeH+1SJFad/FBrjbrdRsThwKy7RehONSUr/bdo1xlO+r+n4rjox9AtoY=
Received: from LO0P265MB6487.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cd::14)
 by LO6P265MB6031.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 14:24:50 +0000
Received: from LO0P265MB6487.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2445:f9d8:5da:4dcd]) by LO0P265MB6487.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2445:f9d8:5da:4dcd%4]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 14:24:50 +0000
From: Sarah Walker <Sarah.Walker@imgtec.com>
To: "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>
CC: "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "jpanis@baylibre.com"
	<jpanis@baylibre.com>,
        "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "glaroque@baylibre.com" <glaroque@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "ronald.wahl@raritan.com"
	<ronald.wahl@raritan.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>
Subject: Re: [EXTERNAL] [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT
 license along with GPL-2.0
Thread-Topic: [EXTERNAL] [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT
 license along with GPL-2.0
Thread-Index: AQHaQ86axgHMC560HkeSHrcHbDinj7DUrDeA
Date: Thu, 11 Jan 2024 14:24:50 +0000
Message-ID: <8f7df220c0092a9167db7dee78861ed4d9bcd0af.camel@imgtec.com>
References: <20240110140903.4090946-1-nm@ti.com>
	 <20240110140903.4090946-4-nm@ti.com>
In-Reply-To: <20240110140903.4090946-4-nm@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB6487:EE_|LO6P265MB6031:EE_
x-ms-office365-filtering-correlation-id: ccef7803-9052-43ce-c88e-08dc12b11257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Jq2D142WHfcr3jVxdaK47+plDx1NCpPlYPO1GD79T037QIe9si6/+3/UJIg97yQN8tvzeL80ILIVKnV+ZwfjGYxXFq0Bl815Srhnys+5UEVIFn2ELxSqCghEEorxAFyUjX/xDPXhlFQjVaqEL7Kii6xiR9rilZn4C9Ji7jA+FQvkLLEDMPSApg/EQ3yMG/7WQ4Uq3hmAQNu4CqMNU92yZZm6WfnK+m9Vg2JyMF1iH8jSU8KuDD8d3Kfo4qhuKqd3obRUEtnANj+8UZq8MVNvgnbGu51ZDXEWVRiVWmfWpdmkul1J0/2JGGoiKzwkXL8gCoQ5Sg5LL656K6wdcImbLND//29EzmNlMrGesXyHshNNq6hW1581vhuTxIfVVQO+ErWwf5Ov8y8yhE2SLNsL90z/Rkx4H+FXHhpC5e7Cb5Ia94/WhIm7QP6yUUtry9GrrItr8G5zyUo1oVB/SLtK4yoFhupt1OHXpmX7g+FN5NSR5N7jScA85ysRZPbrDaqrZ49GT7zDodaP4XzkM7tcY9fvqYcKLLSDtcK+xRJyu0SuKIf9Ze3gnif9gbruC2YWU1edkK2q8RtdhnEnYWtny178s1KovlKx16nMxYTOiBgCwcoaTu3s7kVEKzvoluV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB6487.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(71200400001)(478600001)(38100700002)(122000001)(83380400001)(2616005)(26005)(6506007)(6512007)(110136005)(54906003)(8676002)(8936002)(7416002)(316002)(4326008)(2906002)(4744005)(5660300002)(38070700009)(66946007)(66556008)(76116006)(66476007)(6486002)(36756003)(66446008)(64756008)(41300700001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3hzR3E1eFJETTQzWGlNb1Nvc3QvVWN5R3cveFIzYTd1UzBoL0t5UjZQRW9Q?=
 =?utf-8?B?KzAyNFBMS1hvWFJaRjJYOUo0WTZlWkJJS2owWGpUaExpUGVTb0liOU53VitI?=
 =?utf-8?B?Rk9HdHRBZ0Z3YktpamlZNk9xbkhhK2UxVnNKMVNxTG9CUE1PZWgycXh4OVpl?=
 =?utf-8?B?RW9SbnFpTmpvY1dRWmtYVkNvUTVJK3FlTlJpUkx3RVVtU0FsUTF2elhSV1ZP?=
 =?utf-8?B?cGsxcG96MjlMR3B6Sld4SkNxZFdjYkhpMGdwWWRDUkZLQitCbGIyNU1LbWJm?=
 =?utf-8?B?dzI2Z29aSFdNN3JjMS9jNWw2MjlvWWR2MUpzQmJRZVQwRHpyUkVsZjNoSStK?=
 =?utf-8?B?YnVmOTZJRnZWK2taYnp1UHdKOUJ3bTRRZnpWT1FWdTJWV3JldG5mRXdORXF5?=
 =?utf-8?B?OS80TFZtRElXS1B1U3ZNUmJEOHRLa2MvaVo3cm5UeGlWWnlsUUg2YmswTWt4?=
 =?utf-8?B?LzB0TFdNdlZvNXZadFloQVFWbFdBQTZGRXpMT1I2cFZlQXpDVVNlRFhRY2xR?=
 =?utf-8?B?Y1lWdVpRRTl4anNqWXoxc0ttbm43Sm5LbWd2SGllVlFmeDJ0ekJScXAraHhF?=
 =?utf-8?B?SDBhM0pUUXR1Z0l6S3FNSzZnVjdSU1prKzh1NW0wQ1BvbSthMm12T2g0eDN1?=
 =?utf-8?B?Si83ci8rWGxKajgxNG9VUG0wVEdSR2d2M2tHVjF2eE56WFZJVThsR0tNL0M1?=
 =?utf-8?B?cXcwZDRkbHNmd2FZSThtaHhLeUd4NklKZHdoL3NwQmlab1V0NnNTMUoxZmJV?=
 =?utf-8?B?OC8zQ2oxeE8vOE1tZFQyVUtZL3FUYjZsYlgrNFlBaDRBL2w4UXI3YWJjVkpP?=
 =?utf-8?B?NGw1THYycmllSGNvQUhHZlpwZ2xMcnNGTk5acWM2L0xPbGg0cUU2bVJTSncy?=
 =?utf-8?B?cm5DbHRFaW10U2tVcUhGYk0xQmxLenVrRDdlMFVXN2M0OW5DZmFNdm0vNGVZ?=
 =?utf-8?B?M3lzNzh1UExGSjhPRExKd0ozbFFHZjV6eC92cCt1aHhuSm01QWhwaWxESUNU?=
 =?utf-8?B?MzZpajJQQzJYWlJlcklJZDROZk5DdGJtNnhRdTB5dnFaSStPbTFFZHBUTWtN?=
 =?utf-8?B?TVRaV29reG1HT3RrNmR4RWpwUndpVnpBbk0wS1ZNbkhrUElWQ050M3hhWW5F?=
 =?utf-8?B?UzB0aDMvOXAzajFvdGJkVFhVREZBVnNEeEFGd25OTEZaWGFudlRreitqdHND?=
 =?utf-8?B?Y2NuK3dES1QrcElSNFgxdXRTRmVVdUY4MmNVUHRBeCttS21OMlFFTFJpTTE1?=
 =?utf-8?B?L20vS2V0QXd6YXZJbTRqSUlxOS9qRUl3QzdPMFdqNHJFWGkyQk55UE5lRExt?=
 =?utf-8?B?NlR3eWhsSktyQzFIUjJ0ZlRPVnUzVHl0RlRPRElyZWE0L3cvN3d5WUdGdHZD?=
 =?utf-8?B?M2J1TFJNaUZUVEtIck5YdWV0UDJBVkRFQkM2Z0hyMEFKV2FFK21HVGVYYzc4?=
 =?utf-8?B?U21uVlhvMWpiVEJhVmYzdVZhay9vNDVGcXNoN2tuY1F5MUQ3d0JsUTdIL0oz?=
 =?utf-8?B?Z3hoMEkyWjJGRDRjemZTVUhLKzhvVEZNR2pQNllLaVgzYVRjajJEeFhJcFA1?=
 =?utf-8?B?b0w0UXZhWW15T1RZWkptQlQ4aHdnbit3MUZTeGlkVzAvU2dwZFYvMExlUW5C?=
 =?utf-8?B?ckNGYnp5T0ZDa21FWVFHWTFpVEFiWURZUDNPOUdKTGdxbGU5Qng2ZHJWTXFs?=
 =?utf-8?B?a3NkVGozZFhQb3pURFNQY093R21jL2UrOU5UcDlqNlRqOFQrVlRraFg1RGlB?=
 =?utf-8?B?YS9QUXRENGE4M2hNUXdNOEN5ZEpEVXMrSzBKZ3NBNTg0Y3VsNG9DTmNrZWdm?=
 =?utf-8?B?Zk13Sm5vTXI0RWtGZThoY1dDeG5TYThidlljVGpWd3BWV0VwYXJLV204VEV6?=
 =?utf-8?B?a0pDOUROWEQySWZSeGg0YTZDaHBBcGpCREFaaDNDRVVpYlZLWlJwNE5lTHFl?=
 =?utf-8?B?dVAzTjZiazdBK2JaZUhMRWRBMzhxcTBOa2RVYlptUGVYRzNCYVpDMmM3UnRn?=
 =?utf-8?B?UmgxdTVYQVBudjBwaldCSmhtNTZnWVJvTWhwYkl5eERCRzVha0Rka3p3bDhl?=
 =?utf-8?B?dS9XaEJhby9Pak5Id0xhWjdGVVFpb3BTbjYrQm5kMjYzb2l0ZjF4YWtRUDVm?=
 =?utf-8?B?NzZsSzhBRU5oWWJuUkdSc2Y5bEFKcEo3RkdFcWlZYkk0cXR2RDIrZ2szUEp1?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE875B6DE7D0CF40AD41D6A70E9FB8BA@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6487.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ccef7803-9052-43ce-c88e-08dc12b11257
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 14:24:50.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyVZSshfDYh4feVivZEuyODEydOYBmFo0ZmIV6lemt4iUQhTjIOToIZ5MmITKTQILP6BWLpq+LTsRT7RvkTlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6031
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: GqdmplcQl64Bq64uSGPz5SL7GOCO_h_q
X-Proofpoint-ORIG-GUID: GqdmplcQl64Bq64uSGPz5SL7GOCO_h_q

T24gV2VkLCAyMDI0LTAxLTEwIGF0IDA4OjA4IC0wNjAwLCBOaXNoYW50aCBNZW5vbiB3cm90ZToN
Cj4gTW9kaWZ5IGxpY2Vuc2UgdG8gaW5jbHVkZSBkdWFsIGxpY2Vuc2luZyBhcyBHUEwtMi4wLW9u
bHkgT1IgTUlUDQo+IGxpY2Vuc2UgZm9yIFNvQyBhbmQgVEkgZXZtIGRldmljZSB0cmVlIGZpbGVz
LiBUaGlzIGFsbG93cyBmb3IgTGludXgNCj4ga2VybmVsIGRldmljZSB0cmVlIHRvIGJlIHVzZWQg
aW4gb3RoZXIgT3BlcmF0aW5nIFN5c3RlbSBlY29zeXN0ZW1zDQo+IHN1Y2ggYXMgWmVwaHlyIG9y
IEZyZWVCU0QuDQo+IA0KPiBXaGlsZSBhdCB0aGlzLCB1cGRhdGUgdGhlIEdQTC0yLjAgdG8gYmUg
R1BMLTIuMC1vbmx5IHRvIGJlIGluIHN5bmMNCj4gd2l0aCBsYXRlc3QgU1BEWCBjb252ZW50aW9u
cyAoR1BMLTIuMCBpcyBkZXByZWNhdGVkKS4NCj4gDQo+IFdoaWxlIGF0IHRoaXMsIHVwZGF0ZSB0
aGUgVEkgY29weXJpZ2h0IHllYXIgdG8gc3luYyB3aXRoIGN1cnJlbnQgeWVhcg0KPiB0byBpbmRp
Y2F0ZSBsaWNlbnNlIGNoYW5nZSAoYW5kIGFkZCBpdCBhdCBsZWFzdCBmb3Igb25lIGZpbGUgd2hp
Y2ggd2FzDQo+IG1pc3NpbmcgVEkgY29weXJpZ2h0KS4NCj4gDQoNCkFja2VkLWJ5OiBTYXJhaCBX
YWxrZXIgPHNhcmFoLndhbGtlckBpbWd0ZWMuY29tPg0KDQpTYXJhaA0K


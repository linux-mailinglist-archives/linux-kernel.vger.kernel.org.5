Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1649776F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjHJF1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJF1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:27:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F310C0;
        Wed,  9 Aug 2023 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691645273; x=1723181273;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4nwvn8KwPEqv1Dd2WoYUOS/ShAZExstBrM+P/6qVMGc=;
  b=aMqEkdVAUPvi4X/i/tG9Il+JY2cuG8Nnr4zrERVj/giMqCbNo8B8NPf6
   nm1f4rLj/KVMA+ADRnDnasPnCZgWljnZ3S+wNbs8R6Nue35RzHLHRw3qO
   YMxT2uddmEMMdbQbcVpEQZPuGa7+kByHBq+yctRH0jAmoUYvoyf40PI6G
   H/yna4JTGvHlsQwMtuYM8a3S2vQVCb+/9HkpAxPQ04QBKhP6NoH+7rcL6
   CFE7VqLEyV71XXqFBkSq3TlYYcsR712IozW2qoDUdkg2gNWQO2qS73lGV
   zuZ3fpZ6QNaTrHeCljmVzeaW3WWFziBgBBXSOi1sip3xZm8ECiI5slZ6U
   w==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="240835385"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2023 22:27:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 9 Aug 2023 22:27:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 9 Aug 2023 22:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb+rEQ8ECugZDPCxhuXrswZtXV/0xCsfbWbEU6lrI6IARABVghIWo4ozKhbFaFasrH4/JpvKEzxHOxVXSwVuZq23TURM8R/TZ0bj29b2svm56fBJLgKqyRqOaH88FmOYXjf4f57qi/lpZygeEvrV8P4pwW8mMOIzGfGQG3uFKgbVhVYULMCDjvrMoLEecHr0tUWiKSPxeVBlLfqf8ybLoQWx0kQc4aFZLi/MzybCAWFtIeiSzdLkIPPrTVBfZ7k3c4ZgWV8epAqYCL9JGJtF6jpWt4JYT3aDkpggFRDnttiHI+Q/OA3DIkLTGOwCX8TXtWl9eGeeqkFdkMMZ0x3XZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nwvn8KwPEqv1Dd2WoYUOS/ShAZExstBrM+P/6qVMGc=;
 b=BCk2nn87fhoykcJQQWfBlWS6cJV4rCnvljVcouCc8WTwzF/Vt23SeKfHLJysxdnVk52ZsJMZufnscYZ3OcZpmdBZQeKPqfJFmvxmRvudArGlBO++fNhcDrtO7F8iPoAeSMUgLiIphY6AlSF2zPcPFtVuU5krZJWW18EDoibK+StwRor+W0bJnaBwKLHr3eAEsnZCkRMPraYFtovCN11GMJGolCgG3X8KrCUG2/cpr1PbEYkl82Cb+udi+e0zjgVzdBOtgXbpU4jG9UKPmst9DCXPNEVQSw9DIr0MxjwMKda3Fh2QW80U+erXacN5smyjzzJ5SVNXJL7/uCh6ptLccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nwvn8KwPEqv1Dd2WoYUOS/ShAZExstBrM+P/6qVMGc=;
 b=BvVWC6f9xwGw0hAABJv9k2aCYDs6Xfmyhd0fsk0+TB3k/wWAoxlozPW2FSqjgczQ9nupsaF4ZZiJCZTjdzQCOxmQn0OobnJ+quSqQ+cfSmo0StunQoN/acJVXP1ShY0/4hVGqmW6/7EbRrY9ZwVGcI5dK96TRDi7cmgvf/k8sGY=
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 05:27:50 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 05:27:49 +0000
From:   <Varshini.Rajendran@microchip.com>
To:     <tudor.ambarus@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <linux-mtd@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 20/50] dt-bindings: atmel-nand: add
 microchip,sam9x7-pmecc
Thread-Topic: [PATCH v3 20/50] dt-bindings: atmel-nand: add
 microchip,sam9x7-pmecc
Thread-Index: AQHZwT4E6+PRcc30WEOOzkEC/xL76q/PBKmAgBQPpwA=
Date:   Thu, 10 Aug 2023 05:27:49 +0000
Message-ID: <f14b1014-1f0a-c65a-943c-2933c9ca2a4e@microchip.com>
References: <20230728102636.266309-1-varshini.rajendran@microchip.com>
 <b5c44fc5-005d-6268-af68-85eda9c330ba@linaro.org>
In-Reply-To: <b5c44fc5-005d-6268-af68-85eda9c330ba@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|PH7PR11MB7430:EE_
x-ms-office365-filtering-correlation-id: 339ab13d-df2b-47f1-1d98-08db996289b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLleo2te/vxPYAzjdKquEUFOgDHxk2M/0tOJ3PoO2x3Eo5nJk1F2KQjinU4+x9HA+VZoN5/w/vIEHrI5IeBf3svg0XwY7PW5txGc1rBPucz5FJ2L6qWHR57pFDh+nrmPtI151GYNb9gcIS9n6UpYeDPTBTv7u5pJ1jeoLpNjwpu2Z6oONVLeXNuv+CNxPcKDBYKMAJ001rZBAjIQWIuBH3aFSw+wj4gqtRqkPYZLzrdn2l0RvJSKXpIdBUljPjqiAEegLXbiL+IIB7RLctt1SI7UEIml6yR0g3iKeESwhtLQgaygFvn/UuihWWx3kSr6EGck2Me7VK8NcV/w8eNuUc8HAzsDGsuVDSQpACbZRZv+jvuq22srv1HyiDCc5ap0dU2SxQrMwSnshmIcUdDNnKn4pDkKBj0yoVKq6PHcETlG/ImNDeWTH/upE8vVNPC5aRh0A2vA70FHCRHfxnWRl3E3FfrZwvr7o/VuT8w8+mfoSAGVtFZKqQ2Y572hyf9f2rLd3GQKZg5fJuQ0WlCTJUooJf3XgTJqf5697eeuvxlQZHRJrNzqs6J2Wk3/gp2dr86IV0zGsxLmCikfw8hu+AK9yV9N9W2fyfgoc2AbPREANCliKniWjZFnLQ97cjxaZFdcELFcEhVSIrYPGYkGaHG3FnbObgEZufIkjRvwqkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(1800799006)(186006)(36756003)(53546011)(2906002)(478600001)(26005)(6506007)(6512007)(71200400001)(6486002)(31696002)(86362001)(8936002)(8676002)(316002)(7416002)(64756008)(66476007)(66946007)(66446008)(66556008)(5660300002)(76116006)(91956017)(41300700001)(38070700005)(122000001)(38100700002)(921005)(31686004)(2616005)(110136005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emtudkdndmU3Q21FOUF1ekY4SkZQdGFwYlVZYzBTVHIyL3U1ajlsd0NBSmlq?=
 =?utf-8?B?WWw0QmlkMDA4NUt0Qjg3RlJTWmJ2RFdUMndtM3FndnNPNkg4SXhMUVZxRjFI?=
 =?utf-8?B?WmUzUlhUdk1VWjFPY3lkV1BOWUppRnRLWDQ0Q0N4RVlMeC9la2JMbU5KeTJQ?=
 =?utf-8?B?RU9odlZnVnFpQnpLbVFzai9DRG9DUE04STUzbFRZVEtFN3MxWHd4K2FXcjBU?=
 =?utf-8?B?enV0M3U0RjgrQnMvZkRBTEpDQkorZGljcFpkaEQ4S3AwTVc2aFRRcHMzbTha?=
 =?utf-8?B?dmNSL0FsT0J0aGFQZEZQaVNaL1Bocnc3d1hOYVFCcyt3VUZPMmxDdG1tVHJl?=
 =?utf-8?B?QVhRQVVOZ1hhWXEza2EzWTNjcDdWem5pSHFMaFhLL1Bzckg1bXducnppTEgy?=
 =?utf-8?B?Y0pkb3RzZWhnUzJWOHhkVE9meW5pdEhpU1ZDcHQrWk5XbkRxcmVVSmhQK1RY?=
 =?utf-8?B?T0UrMW80MDVyZXE5MFpNMDEzZUhjc1dqM25ER01nYlF2bjJhWXR0eXZtb09L?=
 =?utf-8?B?Nm15OHNzMXBhM1lPZHJObm01U1dKaDFLSHBydnpoVjlSU29ZK3RFUllTNWJM?=
 =?utf-8?B?L1ZtcE92ZUhlQ0pnYXIyT3hqeHRlQ3MrRXk1RlVpV1N5c29vSmkxUFFDeTY5?=
 =?utf-8?B?M3B5QmViV1lnclJ4R1lTRVdhWE9tc3lPbTJ5NjVRcHNKRDBUUVB6S0ROSzRS?=
 =?utf-8?B?VldYVS80S2pwT28wQytibDNncHJ6cXdBVU9FMzFpOVgxUVRTWDBpQXlLRE14?=
 =?utf-8?B?djdIVmIvS2FvaExXS0U0UnVqY3FIU0dyTUN0Zjh6M2J0cnB2R2E0dmNJVkx3?=
 =?utf-8?B?Q1AyNHJweHhJWlRIVE1zV3B0T3VMUWpZUEJQem1wNXhZMHY5cEUwb2ZDZHlS?=
 =?utf-8?B?TzNEdUo5RVF3NTU0RjhoaEMzUjhIZmo5OHRBb1RhSHJtWW40eEllay9CaGRw?=
 =?utf-8?B?clkvUllDOE9RTXF6aWkycmF5aEdOYjcwaDZoMzQwQm1nbnFOUVZtbGVBUy9J?=
 =?utf-8?B?UmNqNWM4c0RMY1RJTThJdndIZDJiaC8yVWliQjNTMWlCVU4ra2hRSDlBckt3?=
 =?utf-8?B?a0JjTlB2eUcxUXdDQTNlNXJzT3U2bDF0RFRaRnhFU3ZadW51aFNvNGlhZHZp?=
 =?utf-8?B?RFFnNGRIYnpJZlR4bE12Z1lDakxyN0RWeUVaK25YOG9lNmFodlFxazQ0YS9x?=
 =?utf-8?B?b3VuOWE1Nlk1aVdtOXVsVE52Ty85bG9HMVo2NENLQTN6bEVZc0h6MmxrZHkv?=
 =?utf-8?B?ZjZ0NUlzdUs3cjZWaTlFRjF6WXlEWitxb0tSSGhJbXk3ckdBRmZVTVlCWFJv?=
 =?utf-8?B?ekpTR2RNdkVONyswaFYra3R4and5MVFjZWpTTGhGbUFQMXBxSXYzM2YyQ1FD?=
 =?utf-8?B?TEJIU00vQUJ1blFxS2lub1Q2QU5xQnZKeXRvWmVUZWJYdnA0NE9veDdzQ2pl?=
 =?utf-8?B?Z0dzaE5ISXRNR3dkeG5PK2tBVTJaOFFCbGtqUXVmZVp0QVZKOFZWanpacWhY?=
 =?utf-8?B?dnMrTDc2M012YmsvdEFyeHhUVGdYSzA5TDZ0bFpoQWdyRU5qTXNwbWI1d0x2?=
 =?utf-8?B?eHVGOFpLdkkxOENUai80YVl6YlU5WkMrT2RhVGlSYzdkM3M3NGNHc3hwOWxW?=
 =?utf-8?B?aW02bHVYMnZoUjN4MG9uZjRWTVR3NVFPS1RmRlNTU3JsekgzUVlUZWhxSzN1?=
 =?utf-8?B?YWUwZEhtMHpWdkZtM0tET3ZubWkybzd1UVJaVE5TS0h6MDJ3LzJwbFY5UE1L?=
 =?utf-8?B?NmdNVmkxUkdPQ2wxa3hCaHpTaUtLN0VjK2YwZ2F1UlF5eEJCSktGZVF1SDVS?=
 =?utf-8?B?UXhqSmxTVVh4MFJ0ZHh3SzlaaGl3TFY2bnA1NW9KWFRRNkJUS2xqMElrYnI4?=
 =?utf-8?B?b2JMTWh0VTZHakR3TStBUkt3c3dIYU5lV3JlcVh1c01wbGNvcWhPZTI3dkNz?=
 =?utf-8?B?SjRDaWgwZ0YwRk9VcnZISXJ1RVVNSThDd3lrcHdreUdlZlU3bnRpaU9OSG5M?=
 =?utf-8?B?STEyVWhJYTg1cWhVeG1vY0ZOQ2ZyVktkcUZPVHB2dDY3WVIzNCtVSXZrMCtl?=
 =?utf-8?B?UEFFTVI3M2ZMTTdveHN6RFVqS3RtZkkyNHlTLzd4YUFscE9kUGpVR1VyQm9H?=
 =?utf-8?B?UTlUek0rNFRDTGZKZ3hwL2FueDhBTFhDYnorN1hmZi9DYndiekQ0ditqK1U3?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B03D5B509326145BD110D86CF3DA035@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ab13d-df2b-47f1-1d98-08db996289b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 05:27:49.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1wq+SRpf1pU/8izIz5jXW7BiGBeEeUveW4/yywxVRv4EcAxD36JsOudmPBnrjFq3qaFOnbyDHyyUTvWQdvK6AK29WI0N2zUdjXPmYglNLe3ti9NlYXMWPoWNql369FM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjgvMDcvMjMgNDozNiBwbSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA3LzI4LzIzIDExOjI2LCBWYXJzaGluaSBS
YWplbmRyYW4gd3JvdGU6DQo+PiBBZGQgbWljcm9jaGlwLHNhbTl4Ny1wbWVjYyB0byBEVCBiaW5k
aW5ncyBkb2N1bWVudGF0aW9uLg0KPj4NCj4gDQo+IFdoeT8gV2hhdCdzIHRoZSB1bmRlcmx5aW5n
IHByb2JsZW0gdGhhdCBtb3RpdmF0ZWQgeW91IGRvIHRoaXMgcGF0Y2g/DQoNCkhpIFR1ZG9yLA0K
DQpUaGUgbW90aXZhdGlvbiBpcyB0byBoYXZlIGNvbXBhdGlibGVzIHNwZWNpZmljIHRvIHRoZSBT
b0MuIEkgYW0gYXdhcmUgDQp0aGF0IHRoZXJlIGlzIG5vIGNoYW5nZSBpbiB0aGUgSVAgbm9yIHRo
ZSBkcml2ZXIuIEFzIEtyenlzenRvZiBtZW50aW9uZWQgDQppbiBhbm90aGVyIHBhdGNoLCB0aGlz
IGlzIGp1c3QgdG8gYWRkIGEgU29DIHNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5nLiANCkhvcGUg
dGhpcyBjbGVhcnMgdGhlIHF1ZXJ5Lg0KDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogVmFyc2hpbmkg
UmFqZW5kcmFuIDx2YXJzaGluaS5yYWplbmRyYW5AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4g
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2F0bWVsLW5hbmQudHh0IHwg
MSArDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2F0bWVsLW5hbmQudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9hdG1lbC1uYW5kLnR4dA0K
Pj4gaW5kZXggNTA2NDU4MjhhYzIwLi40NTk4OTMwODUxZDkgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2F0bWVsLW5hbmQudHh0DQo+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2F0bWVsLW5hbmQudHh0DQo+
PiBAQCAtNTYsNiArNTYsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgICJhdG1l
bCxzYW1hNWQ0LXBtZWNjIg0KPj4gICAgICAgICJhdG1lbCxzYW1hNWQyLXBtZWNjIg0KPj4gICAg
ICAgICJtaWNyb2NoaXAsc2FtOXg2MC1wbWVjYyINCj4+ICsgICAgICJtaWNyb2NoaXAsc2FtOXg3
LXBtZWNjIiwgImF0bWVsLGF0OTFzYW05ZzQ1LXBtZWNjIg0KPj4gICAtIHJlZzogc2hvdWxkIGNv
bnRhaW4gMiByZWdpc3RlciByYW5nZXMuIFRoZSBmaXJzdCBvbmUgaXMgcG9pbnRpbmcgdG8gdGhl
IFBNRUNDDQo+PiAgICAgICAgICBibG9jaywgYW5kIHRoZSBzZWNvbmQgb25lIHRvIHRoZSBQTUVD
Q19FUlJMT0MgYmxvY2suDQo+Pg0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNClZhcnNoaW5p
IFJhamVuZHJhbi4NCg0K

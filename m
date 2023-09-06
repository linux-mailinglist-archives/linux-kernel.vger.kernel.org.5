Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9588379352F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbjIFGPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjIFGPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:15:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147B9B;
        Tue,  5 Sep 2023 23:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693980941; x=1725516941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=46s7aj6PqbJ5skaiDZV1RkX6mxcmfHMujrX0TNr9p7U=;
  b=QeX4SezDDYv9AB7Us/Etf5dK/H0PSpxvOC4fWVCAsHF9OlO2LN8Y8bBX
   GZnzUCWPpsD4omVXzg8aFA3AQPibLFEHy4kvdcl2pgNroa8W1tUAoqKeD
   jRfwfzS9K7Lpuh1r0AxBGtrpaymMM/s2hKcRbKLv2iwQx2rPXXS+yfw9o
   ia99K693D4OUQJ4dYxjnJNVmVIvkwxI/i29Qa8YbTRBswQ4lnger9Le6g
   9PPiX/b1ovbvWCDWdMw0EBNLlF8iEpF+l/tNjaBpzxhSZv0HlA6mn/03M
   HfFpp9BLoDv/vvepqpW6ztuDjY0CFic86i/kMuTMCmRnJHrc5rrY27epV
   w==;
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="233633718"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2023 23:15:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 5 Sep 2023 23:15:40 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 5 Sep 2023 23:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXwMqvDIr3eUPQEBkao2msQtKHAxm2oxY8c/u4qWeUQeTEFdFO7sgH0dJhlNASKPtXxdEvM3Za5mJg9DR09z/Rl4npXSZk/Gez4AdFCCHbXenhCx8/sMqcCOjqdjGGFPnXEtGsB4IANqM1BKaiKd/oZS5jGDTbZVr0FNrV/OSJkLpUelPufacdSeeD1mHL2XYaTfc6cHkqgSAeebu5WTFXmDJNElFElei9iSZNPh+BBBqYMKIHm2Hi4nirK7iN3/27L5x6Klp8or6X8xjFYgNrLd2fdpotciWcW/dhK3ImI3FKFALa+3IZVDKrOZxijz4NYtsw8bl55jn9g1LqPKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46s7aj6PqbJ5skaiDZV1RkX6mxcmfHMujrX0TNr9p7U=;
 b=hX0XoEoYng/IRjWAAMsK4IhqabbHXC2zDN1t4O80w3uyJECkjLG9NRvCvJeMxTvihoEsCOMT0nn5hm4+hXDDFEq0iitst3eiJKd9tIrsfxNOOq5AEkWxFwjxcjkLO6l1J63R78QWJmD/3QjoM4njt478ZYcE5SYGpxGDW25bLNHUi+3d0+91b8H+K2gKWIKY6OS4FTH49CCMsVqkHHd1Xr2uK1XRpBcxdbHJuZPLBGcNmNcTjhGuMIjeVpeAGZaXFjwF3bef0G1O8XU0vaCzn3t6G9ssDuprALiDB/Ej6KA7wAyG3Mnbq3B9nirno03uJ4Pbdik76bZkPBqOCqKk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46s7aj6PqbJ5skaiDZV1RkX6mxcmfHMujrX0TNr9p7U=;
 b=cQkTwgZ274tpzXnQI2DgGJn24XOTt5qQy2kbZqD1ne2+RA0PD5ShQvf/deaHKzE42AenoqWvb3yC2Z5rvcIiaBVktP58SnxzqkVCreN+ua2++F0jXQCCglvpHrRnWAmAkapGjmyhXvACpxGsZiByjx+DtMskdl1ZI/w2ySZAF2Q=
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 06:15:37 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::591f:32f4:3319:e1f8]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::591f:32f4:3319:e1f8%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 06:15:36 +0000
From:   <Hari.PrasathGE@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] pwm: atmel: add missing clk_disable_unprepare()
Thread-Topic: [PATCH v2] pwm: atmel: add missing clk_disable_unprepare()
Thread-Index: AQHZ3WdS8rZ/EszNg0KFcLXEK4uBNrAHuggAgAWeQgA=
Date:   Wed, 6 Sep 2023 06:15:36 +0000
Message-ID: <f08d820b-cef3-bc9d-69ce-fc6d3f65a550@microchip.com>
References: <20230902063232.22620-1-Hari.PrasathGE@microchip.com>
 <f15da804-206b-be53-b59e-06a3edfa0e96@wanadoo.fr>
In-Reply-To: <f15da804-206b-be53-b59e-06a3edfa0e96@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4185:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 35d00196-1a42-4601-669f-08dbaea0afbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: req2SLYGroN02mpUz5na/sNCfPgfLGDvp/ze8TZLpHfZ/aNf+C3t6cIUbJ0BM0zgmrKJD9fFFz7kkY/YOlxIxqIJc5WmKRbVgQ20uRdgbohWqyOyYjhPb9Slbw634MNJ4LgnBl9Zeqv3pVs0Q2q/sTB2eNGkxlRQe92M39cyx7aDaT6JBmPtmSPscGeBVQWLhuLk9wyAlBp8UEe6WTBRLVo7VZ4aAr/slKM2h+6MCeKpduuOicOjbOC6sN/w07MyzjGg+5EH4aOO+YBO7mD19wKNwSHOu6esFqtUA7tsqCp7pDQmBN8CUjX5fVVJ4RtGUUQFFHGlI4ClS+KhSdKaWkfutugjD03PYoNnYCVJRRFlJll+pUU5Qyzx+IqdnK1BzZ7Pr6gQKsxe4rVZndL0wa52TNGO0S8uLuL6Y9eqK8/wE1Af3Ty4mR52lRfQ1oOegAKRQfuXQyQpiNlVdz7e2xQMmmWZjoUVt2o8YwTcTtePumvcOJfB3u3VN6bOyF4xq0mpImczRT5fKTgVuOKBZOHpi4SHZqChKMjJolllYJItJ9X+r3JCR6/1/OTdLrn6fZkheCpv61MUr0P1Kk792N6fi3LSwAgMBxeBPe4jIVlrBIzi8O0hXVubU7oD9MCzPWCERoUz9f++51mxxG5QVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(186009)(451199024)(1800799009)(38070700005)(38100700002)(478600001)(966005)(83380400001)(36756003)(53546011)(6512007)(6486002)(6506007)(26005)(122000001)(2616005)(71200400001)(31686004)(316002)(54906003)(64756008)(66446008)(66574015)(66476007)(2906002)(4326008)(8676002)(8936002)(41300700001)(5660300002)(86362001)(66556008)(66946007)(76116006)(110136005)(31696002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXF3S0QxZXJOV2FsSStWY2ZyM2YzczRSbVRPZnZoMGhwOE5aQjk0eEh5T3BC?=
 =?utf-8?B?U0Q0N2t3T3I3NzByZ2ZZajk1Y0Z2MmlpWkpoaHhGaTVoNUwwMkFPMFRQZlBn?=
 =?utf-8?B?OE40Nk9hUzNEUFRQU1M5bVQ5cGsvS05NZ3hYQjM5ZEtzVGlpUDVqeEl4blZP?=
 =?utf-8?B?ZXFXazBMV2xYQXhnVmlKZDRyc2xEMW9IQWppRnNJdGd5QjU5MVE3Rm5JRnA1?=
 =?utf-8?B?TXR2ZDYxdXBYZXNzWFFpT3gwbWhBZDNCeFcxY0oxYjNyREc4T1Q5MzNvR281?=
 =?utf-8?B?ODl5bUltZmZ5YkNjN0piLzdBMjJYVzd4eGZpL0JncXU4bHd3TVN6d1RIWlJu?=
 =?utf-8?B?eG1LdHZieWJXQSs4RUN3NkJWT3RERitrbG5sN0QzWjcvUFB3bEJWU3podnJP?=
 =?utf-8?B?ME1ZbzlDTFhndEFwdzcwVEsrRm1rYUZwUXJwcStFRlJMRGRJOHArK2hjWEtk?=
 =?utf-8?B?MGtUTlV5UjRIbGlRb0NRR2hlenp1WTdLL2IwZHdDSkU3L0V3VlVZL1M2aGd4?=
 =?utf-8?B?c0hoMTg2UDhVZVlWSlhxdVIxdGZkdklPUGx3L3hCQ0JqMENwSVVEeUd2Wm5l?=
 =?utf-8?B?V1ZrYnFIb2srejVkYVNzZjh5bW1pc0xBOWQvRDlyanFOTWtvb3hQUDMrVmFG?=
 =?utf-8?B?Z3pqT3BabGpCTmJuZDJjOHROMXgxOFdobUdacWtlZ2hvOWJvajBHR0Jucy9H?=
 =?utf-8?B?VUZVd0laWEg3KzRiUmdPOGwya1BveDVCbG1CMUNYWVEwVmVDSUJyQnVoSVph?=
 =?utf-8?B?RnNGTkppRE5ML2dtaVVZcG5tcXRqRDNYOXZUcXVjcGdmSjhhWlp2MjRpRTlJ?=
 =?utf-8?B?elRhVUdSYzBHRGxYVlBpT3laWTZuaWo4c0dIV3BYT1c0YlQ1eDdGMHhpK1E4?=
 =?utf-8?B?N2NUazk2ZjlOamNJa2dINStMNDQrMC9KaVNDaFBHYXRYR0ttWm1YZHFqWlNW?=
 =?utf-8?B?ZzVXMlJiVzBUQlZsN0J2U3J2aW1LMjBIN0t0MFhXY1FIWVl2bEpEYkoxcFQ0?=
 =?utf-8?B?djU1blN1dUNyTEtPSUZRcmcxUVlUV2JQVGxBV2VlSDlsclZGVmNVMk5UQ0FH?=
 =?utf-8?B?bkxqNjdTOFJRWjMvYzFuZ01Pbk04dG91NmFhNzN0bWJjZkNEeTJ4SXBpM1Fm?=
 =?utf-8?B?WEZuNnhaSGk1ZnBHVG8zYzF2TC80WmRaQ3g2QXF1Y2dYZGlNWUx3RXBDSkMy?=
 =?utf-8?B?K2NlRTBMYmp3b08rc2czMFNhWmk2cWNPakx6cE85Ym50S3Y2OTZIVlZjaExi?=
 =?utf-8?B?ZjI5RTByaGFydGxyZTRGWWsvMm45cngrblJjL1NSSmpteGNuWXh0a2NHL1k5?=
 =?utf-8?B?M2ZrR2NPRndVWGxlNTBibVR3cXJ2NjVLeWNSRTNqR3NLM0JpaXZzZEFKRStW?=
 =?utf-8?B?Qzd0bWZYQS9GZzJwV0hiQU8yWnZsWDlxeEpQRUJBNktrZDJMWjBUbFA0NERz?=
 =?utf-8?B?Q3NLdlE2cThZYzRFalo2VWhCcTJxU3lNanNaanRwQmRrcG1lMTU3UURLRW8w?=
 =?utf-8?B?aTArbHc5d1Q3SnFPNnNWOWtMaXI3NWl2THlJTWxVVWJ6ME1VVUdsVzdrQ0RR?=
 =?utf-8?B?Uktwazd6ZXcyVjhGbjJRZjkrdlV3QnNiekJLbTdXakVxd04yUHBNVXNva3Bl?=
 =?utf-8?B?clpCVkYzRUEwQVVVNzZsWkhMazAwaGtianQ2dWRWZDFCZDJycExjTkZxeUV2?=
 =?utf-8?B?dDZJSWhKNDJDV1dZZk1lSWF6WnkxQ3BESEtHSzZLWWh2Vy9PN29sUmRKTVhG?=
 =?utf-8?B?YW1JMTlyeUg2Q3RHYTRFQTdGZDRLOC85bE9nV2VBT2YraDY0RS9ONGduQUdH?=
 =?utf-8?B?NTdRTWpwQnBHTk5UNlpteU1Vc0JSc2RPYzRDZW42cjliNnkyd2FnUGY2MHNP?=
 =?utf-8?B?ZGZjZFl5c3dEd0lsc2JFY1FER21CSGVwcEdPRVRzN09LdVhVZGdHNjVEeU1o?=
 =?utf-8?B?NVlXR1VJZHd5M1llU09tVTY0WE44d3dRZ0FOdVRMOGJmQWxBU3JaMnNZWGJv?=
 =?utf-8?B?YnVSYy9ST1RGb0lieG9kdnk3SzQzVUVwdFZxYmt3aVZ5YTRtZzFGeEt2WDZT?=
 =?utf-8?B?c25zenIxZmMxdE9uMFNLcHo1amtLM2VUaEMycUNBVnM4Zm43RmZZaG5BeGtG?=
 =?utf-8?B?QXY0RFV4ZFpZaDY0SlphK2VZYmRkaXhISkV5OEtReFVTc1JzODh6ZmRhWWhl?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F55348CAC2278146BEB0F653E4740111@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d00196-1a42-4601-669f-08dbaea0afbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 06:15:36.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CV+DczdcW2ja95uWUYvA6OuXxTdYrnE+8MmyqYBi8SZFCk/1mnzoJOR1QU/T2DVuensn/SAhOBzUClNlkzTk7OsqhMxVnelnSPSOo4lB6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQ2hyaXN0b3BoZSwNCg0KT24gMDIvMDkvMjMgOTo1NyBwbSwgQ2hyaXN0b3BoZSBKQUlM
TEVUIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IA0KPiB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0K
PiBMZSAwMi8wOS8yMDIzIMOgIDA4OjMyLCBIYXJpIFByYXNhdGggR3VqdWxhbiBFbGFuZ28gYSDD
qWNyaXQgOg0KPj4gRml4IHRoZSBiZWxvdyBzbWF0Y2ggd2FybmluZzoNCj4+DQo+PiBkcml2ZXJz
L3B3bS9wd20tYXRtZWwtaGxjZGMuYzoxNjcgYXRtZWxfaGxjZGNfcHdtX2FwcGx5KCkgd2Fybjog
DQo+PiAnbmV3X2NsaycgZnJvbSBjbGtfcHJlcGFyZV9lbmFibGUoKSBub3QgcmVsZWFzZWQgb24g
bGluZXM6IA0KPj4gMTEyLDEzNywxNDIsMTQ5Lg0KPj4NCj4+ICdGaXhlczogMmI0OTg0YmVmNDdh
NSAoInB3bTogYXRtZWwtaGxjZGM6IENvbnZlcnQgdG8gdGhlIGF0b21pYyBQV00gDQo+PiBBUEki
KScNCj4gDQo+IEhpLA0KPiANCj4gVGhlcmUgc2hvdWxkbid0IGJlICcgYmVmb3JlIEZpeGVzOiwg
bmVpdGhlciBhdCB0aGUgZW5kLg0KPiBDb21taXQgaWQgc2hvdWxkIGJlIDEyIGNoYXJzLCBub3Qg
MTMuDQo+IFRoZXJlIHNob3VsZG4ndCBiZSBhIGJsYW5rIGxpbmUgYmV0d2VlbiBGaXhlcyBhbmQg
U2lnbmVkLW9mZi1ieS4NCj4gDQo+IEkgdGhpbmsgdGhhdCB0aGUgRml4ZXMgdGFnIHNob3VsZCBi
ZSAyYjQ5ODRiZWY0N2EgKCJwd206IGFkZCBzdXBwb3J0IGZvcg0KPiBhdG1lbC1obGNkYy1wd20g
ZGV2aWNlIi4NCj4gVGhlIGNvbW1pdCB5b3UgcG9pbnQgeW91IGhhdmUgdG91Y2hlZCB0aGlzIGNv
ZGUsIGJlIHBhcnQgb2Ygd2hhdCB5b3UNCj4gY2hhbmdlIHdhcyBhbHJlYWR5IHRoZXJlIGJlZm9y
ZSB0aGF0Lg0KPiANCg0KVGhhbmsgeW91LCBJIGFkbWl0IHRoYXQgSSBoYXZlIG1lc3NlcyB1cCB0
aGlzIHBhcnQuIEl0cyBiZWVuIHF1aXRlIGEgDQp3aGlsZSBzZW5kaW5nIHBhdGNoZXMgdXBzdHJl
YW0gYW5kIEkgc2VlbSB0byBoYXZlIGZvcmdvdHRlbiB0aGUgYmFzaWNzLiANCkkgd2lsbCB0YWtl
IHRpbWUgdG8gc2VuZCB0aGUgdjMgcGF5aW5nIG1vcmUgYXR0ZW50aW9uIHRvIHRoZXNlIHNtYWxs
IA0KZGV0YWlscy4NCg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEhhcmkgUHJhc2F0aCBHdWp1bGFu
IEVsYW5nbyA8SGFyaS5QcmFzYXRoR0VAbWljcm9jaGlwLmNvbT4NCj4+DQo+IA0KPiBUaGVyZSBz
aG91bGQgYmUgYSAtLS0gYmV0d2VlbiB0aGUgc2lnbmVkLW9mLWJ5IGFuZCB0aGUgYmVsb3cgY2hh
bmdlbG9nLA0KPiBzbyB0aGF0IHRoZSBjaGFuZ2Vsb2cgd2lsbCBub3QgYmUgbWVyZ2VkIGluIHRo
ZSBnaXQgaGlzdG9yeS4NCj4gDQo+IEFsc28sIGl0IGlzIGFsc28gdXNlZnVsIHRvIGFkZCB0aGUg
bGluayBhdCBsb3JlLmtlcm5lbC5vcmcgb2YgcHJldmlvdXMNCj4gdmVyc2lvbnMuDQo+IA0KPiBI
ZXJlLCBpdCB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZToNCj4gdjE6DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDIzMDgyMjA3MDQ0MS4yMjE3MC0xLUhhcmkuUHJhc2F0aEdFQG1pY3Jv
Y2hpcC5jb20vDQo+IA0KPj4gY2hhbmdlbG9nIG9mIHYyOg0KPj4NCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCAtIG1vdmVkIHRoZSBjbGtfZGlzYWJsZV91bnByZXBhcmUgdG8gc2luZ2xlIHBvaW50IG9m
IHJldHVybi4NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAtIGN1cl9jbGsgc2V0IHRvIE5VTEwgYmVm
b3JlIHJldHVybi4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9wd20vcHdtLWF0bWVsLWhsY2RjLmMg
fCAxMiArKysrKysrLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1hdG1l
bC1obGNkYy5jIA0KPj4gYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYw0KPj4gaW5kZXgg
OTZhNzA5YTlkNDlhLi40ZDM1YjgzODIwM2YgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3B3bS9w
d20tYXRtZWwtaGxjZGMuYw0KPj4gKysrIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLWhsY2RjLmMN
Cj4+IEBAIC00NCw3ICs0NCw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfaGxjZGNfcHdtX2FwcGx5KHN0
cnVjdCBwd21fY2hpcCAqYywgDQo+PiBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPj4gwqDCoMKg
wqDCoCBzdHJ1Y3QgYXRtZWxfaGxjZGNfcHdtICpjaGlwID0gdG9fYXRtZWxfaGxjZGNfcHdtKGMp
Ow0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYXRtZWxfaGxjZGMgKmhsY2RjID0gY2hpcC0+aGxjZGM7
DQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBzdGF0dXM7DQo+PiAtwqDCoMKgwqAgaW50IHJl
dDsNCj4+ICvCoMKgwqDCoCBpbnQgcmV0ID0gMDsNCj4gDQo+IFRoaXMgaW5pdGlhbGl6YXRpb24g
bG9va3MgdW4tbmVlZGVkIGFuZCB1bi1yZWxhdGVkIHRvIHlvdXIgY2hhbmdlcy4NCj4gDQoNClRo
b3VnaCB0aGUga2VybmVsIEFQSSdzIHVzZWQgYmVsb3cgcmV0dXJuIDAgdXBvbiBzdWNjZXNzIGJ1
dCBqdXN0IA0KdGhvdWdodCBJIHdpbGwgaW5pdGlhbGl6ZSBpdCB0byAwLg0KDQo+Pg0KPj4gwqDC
oMKgwqDCoCBpZiAoc3RhdGUtPmVuYWJsZWQpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBjbGsgKm5ld19jbGsgPSBobGNkYy0+c2xvd19jbGs7DQo+PiBAQCAtMTA5LDcg
KzEwOSw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfaGxjZGNfcHdtX2FwcGx5KHN0cnVjdCBwd21fY2hp
cCANCj4+ICpjLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgQVRNRUxfSExDRENfQ0xLUFdNU0VMLA0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2VuY2ZnKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBkaXNhYmxlX25ld19jbGs7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pg0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9fZGl2KHB3bWN2YWwsIHN0YXRlLT5wZXJp
b2QpOw0KPj4gQEAgLTEzNCwxOCArMTM0LDIwIEBAIHN0YXRpYyBpbnQgYXRtZWxfaGxjZGNfcHdt
X2FwcGx5KHN0cnVjdCBwd21fY2hpcCANCj4+ICpjLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBVE1FTF9ITENEQ19QV01QT0wsDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHB3bWNmZyk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0
KQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJl
dDsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZGlz
YWJsZV9uZXdfY2xrOw0KPj4NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHJl
Z21hcF93cml0ZShobGNkYy0+cmVnbWFwLCBBVE1FTF9ITENEQ19FTiwNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVRN
RUxfSExDRENfUFdNKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBkaXNhYmxl
X25ld19jbGs7DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcmVnbWFw
X3JlYWRfcG9sbF90aW1lb3V0KGhsY2RjLT5yZWdtYXAsIA0KPj4gQVRNRUxfSExDRENfU1IsDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cywNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzICYgQVRNRUxfSExDRENfUFdNLA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMCwgMCk7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChyZXQpDQo+IA0KPiBSZW1vdmluZyB0aGlzIHRlc3QgbG9va3Mgd3JvbmcuDQoN
CldpbGwgYWRkIGl0IGJhY2sgYW5kIGluY2x1ZGUgYSAnZ290bycNCg0KPiANCj4+ICtkaXNhYmxl
X25ld19jbGs6DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
bGtfZGlzYWJsZV91bnByZXBhcmUobmV3X2Nsayk7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjaGlwLT5jdXJfY2xrID0gTlVMTDsNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiANCj4gVGhpcyBp
cyBhIHJlYWxseSB1bnVzdWFsIHBhdHRlcm4uDQo+IFVzdWFsbHksIGFuIGVycm9yIGhhbmRsaW5n
IHBhdGggaXMgYWRkZWQgYXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24sIG5vdA0KPiBpbiB0aGUg
bWlkZGxlLg0KPiANCj4gQ0oNCg0KSSB3aWxsIG1vdmUgdGhpcyB0b3dhcmRzIHRoZSBlbmQgYXMg
aXQncyBkb25lIHVzdWFsbHkuDQoNCi1IYXJpDQoNCj4gDQo+PiDCoMKgwqDCoMKgIH0gZWxzZSB7
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSByZWdtYXBfd3JpdGUoaGxjZGMt
PnJlZ21hcCwgQVRNRUxfSExDRENfRElTLA0KPiANCg==

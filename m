Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CCE784089
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjHVMQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjHVMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:16:47 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2116.outbound.protection.outlook.com [40.107.105.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E584199
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT9BgIFPe+4r5sFTIYttDn95k2u6XDpnJuyiTyUP+FXS4cmqEdL4PP11dH490e/zM7ch+EjOc5C+uovPvR6LdntVLE5O3+D6cFb3cTVxlprw5rTrxY8Kxn/J6LMs6MWxRiBnaOz4KzHsX8Ch1jJp34UUeoNKdZG7B2h8hLcIDGS7ds9UST4Pq2J70byryC0HQfYu3fnbESLXITh27GIhx/cd3jw4Dzzfv7Gjw5RsKD1723FXFU9O7XZimzOmYl1ViFxfTEfrIjcvh+EqQjHy2kdDM5+5J9Wk229E8k1PZ0+eSfDZVWtzrpsIbwjLAsaAH8qApxG29X7q5KOSsT/Qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgMzUQgvRkPlRIfYWCiH0Y5W1XzAgdTPaYiLBSq80nQ=;
 b=GJlZ7TnDMeG4yrptVSQHK5Vy6A3miy3+U8LqkbxVL+83kUX0NuNfFDVKVNQl9lA/1/lWyp8UBgWM9X4TMzM0wrE0Atw77T91KuwizeInT0Li6wtOKaosAAs8Mi3xvVSFqNddb5b2AYBv456FZ6yNxra74M17whNqw95G6o1ecMvAB+zl8rRSxZhXI7FoPfZ7MMyhVDwGs/rcHkSNbo1gLH0XvSHr+Ob9d/70IkDg66r2mgK4C8lJudmWGfp/ApZveEskeuXu0M0Pc9AaqtMMqXTaOHuPMnzatXzGnwHkFtEXeBroPlkV8Uib5A5Cdm/5NGX8aM3zHGZgBRtuILEj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgMzUQgvRkPlRIfYWCiH0Y5W1XzAgdTPaYiLBSq80nQ=;
 b=Oz/4UTLV5Y+H2kY1ueDkDZOqyPApME5RBHbrgD0qUFcQF+ZqgaNeyA7TV1DcNj/jzNtGPFpGkKo/Ees5Pn30M1hsVprNDWTprI3dhZQ8uV5lkpI/uuep9RjpXhAARyVqfU/CZRcAHTZI8JuV6S/Pd+BWYBmOIkf1ph5gud7ZVPY=
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com (2603:10a6:20b:1da::16)
 by AS8PR06MB7464.eurprd06.prod.outlook.com (2603:10a6:20b:33e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 12:16:42 +0000
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::b828:856c:4735:e870]) by AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::b828:856c:4735:e870%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 12:16:42 +0000
From:   SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Topic: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Index: AQHZr1hWPkDpy3UlU0qGBS67M1mV0q+3GdCAgAHeK4CAPY5YgA==
Date:   Tue, 22 Aug 2023 12:16:42 +0000
Message-ID: <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
In-Reply-To: <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7137:EE_|AS8PR06MB7464:EE_
x-ms-office365-filtering-correlation-id: 76f3b9fb-2c09-4f51-a67b-08dba309a50c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4OYr5DnkwcvdAWL3HEFhaAba1bFZV4lYW+9CTRC7jSVA8V6Wr7FW2mzC0h/3Nsig1QvopuKjF3bAQDQHQTHnhv4OCVC6psMdawJ0phWnxUgd65q3oN7r4W0Y3XOED4GI9Itvsq9FG2YklfoocWCQkrm+Q6Qkcz2kqxL0mq2Qi3tBTUZzGOD6TOS8SXpBo/q+Lq40Pi76wj5qU1tjkprwwaxCoXYtEoiPCVDeQcwiHjoFxVfyfNHv70o3s0/xcQR6o9sEO7alisY1/s34jiwLIeMYe2ywYtsmy4g5Tx5wEftv0QxGfDJYvjOW39/DtZg/EvsE2tT8thrQLOT5YYwLBb1JqZbCtR11wmSDQ/bgVdr1FJVRmdZxFohAFlSeeH48aD+6RzKrACsr4LkU0SP5eIsRW2xLkv2Q+xrgjuD5DfOwjofkE+v5JUcOw+FiKgiRi0WR3Y6OLXd4aZryEQ2500lk/BVP3p0yGO8hRdawFE37zFXWLjw1SryioN4oiNlP/KaaOPwWjkftb+U0vt+/X/e39ogP80j01fasTvu8CPq8osw71WXrtqC2zrFujVunQHNvioMZn40v14doctTo/7th3V6Ow9dFc6PSerQLFYdXKXkHXerdRQs9Q5JTgEPYbbyXPAkxpro49fynx2XvCr9sE/DNcz9HZrmWYF0HQBRrAkfN/eHpNGfnjPM2jg58VACA7pOFJS8SQIPHKpYzfzd3P2BSZDGdpneXoNTSxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7137.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(76116006)(66446008)(66476007)(66556008)(64756008)(316002)(66946007)(6512007)(110136005)(91956017)(8676002)(8936002)(2616005)(107886003)(4326008)(966005)(36756003)(41300700001)(122000001)(478600001)(71200400001)(38100700002)(45080400002)(38070700005)(6486002)(53546011)(6506007)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(138113003)(45980500001)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDdka0tvaW1jUER2U0prTlJzcUR3aU5NN29JSitXTE5CL3FyWTY5cmNYd242?=
 =?utf-8?B?SjN1cVVZRnJKUGY3Vm5KNmhKdGErbDFzV1orUzRacTltNFpzRlJ2MGJaV2lG?=
 =?utf-8?B?ajhOR3c3SHlGcktZdXJnRE1LeDN5cDErdERKNnlyMjAxcGpZNHNjbHU0TGhT?=
 =?utf-8?B?enZIQWtDT005bXRUTVluRlRpcW8xa1R6Y2pOeGpMajQ0c3RlYVJ0NldZdzVO?=
 =?utf-8?B?MWMyUFJiQjU4Z3FpZjJ3bHhYZ2ozRTJpRUJuMDVqWVdzQ2RmZHhVMU0xOEJJ?=
 =?utf-8?B?WEV0L2RCOXZ4d21xc0svQUFlT3B3NzNzU0k3Q0dhSW5zdnBLM2RpWnFmbkYv?=
 =?utf-8?B?cHpLYnhUNTNKVU1rVzFZNERmbEtrZXFscUEzS1psaFVvbDloWXpheDVpandj?=
 =?utf-8?B?MDRTeTBsRy9RYVhCV3FIRmg2cEJHejFlS0ZPR1BmeURLY2w3bm1JRlEzUVVt?=
 =?utf-8?B?WGNqeVRFWGJ4TnNFaFowWkt6YlJSQ1c3YUtWWVQ2SnRXVC8rM0ZxWGsvSXJt?=
 =?utf-8?B?Q291ZmF2RzROMS9EemNnTmZROGsyR21aYWtmbDZxSlJtQVpwUWRTYzJ0dzRN?=
 =?utf-8?B?cXBLWWczRXV3dFBBMUd0WTVyb1JNSUhHdW9PQ1dFNkVscHNNN1Z5UVRQWGRQ?=
 =?utf-8?B?ZXdLMytvZ1Q5VXovRDJveUoxZ0tPL3pKY21HQk9UeXBGSlpVengvZGFrN1By?=
 =?utf-8?B?UEJkc0xOQkJ0enQyaFBQUkhNWXRUOTBIYnZmNzlGb0QybldqYTh0YVVIVk1D?=
 =?utf-8?B?ZkZSMWM5eHNsSklpNlYybHV0S01xTmhtR29rM1czRHoySmRwVzJGWWwrQ0hn?=
 =?utf-8?B?bkl0N3ZwajJwZjlXalg4Zk96bVNoLzE3TnJZeUU4YnI0WEU5d3NOL1JPR2Rx?=
 =?utf-8?B?Z0VOdW1PS1EvY29jN3k0UXVrTCtPa2w3Qnl4ajhmTDl0ZW1naWY1TEs0M2ox?=
 =?utf-8?B?UlZvSVplenZkbHl6SzcrRmxxekNaMHJPWFVOdFhucCtzdGhHN2I2cHZpZlVX?=
 =?utf-8?B?MUx0V3Z0L3FhV0VqWVI4UERjUWluMzExdnZ0TmNSeXhIRTNwd2hsdlVCQ0ZS?=
 =?utf-8?B?LzFJcXFDNjVsanVjb2RuZGNkODZDQ1BHYTVhNTEzc2laeXdLT0dmOVNJOGdj?=
 =?utf-8?B?R0ltZFpPcUwxWE52UEQ1aENRYk53Y2hCKzNhN2pJVFhmbGpkUmFSdzZxaW44?=
 =?utf-8?B?ZUVseEVzV2NsbXVaMFJTTTRUT25YcGw1SXI4a3R2RHpJTFppS0QraTYvd3Nt?=
 =?utf-8?B?UEYxU3dialNQSGtSRWEyNG5oY0IzNGg0d2lwWmdzaGg4Rm1GZytpbDNEUEJO?=
 =?utf-8?B?RktMVDFpNDVnemc2MmV4VGlzUHpzUFFLTm85OW5YbDR5MktvN2hxQ040dVZu?=
 =?utf-8?B?amhGMXdYZ3haZTVkMkhDNEFpUFNUdTRMYXJ4ODVrNTFRZm5tMFY2N1hycU5R?=
 =?utf-8?B?bUJlcHJaQ3VFMG00ZjF0TE5TSVJXMWtMRXViQVZIbm94TjBFZFNYaXR4MGgy?=
 =?utf-8?B?S3RxV1pZMHRQRXB1UGtrcUJ3dmNPTEhXbE9hOVdvMVpkcW1ockt5SEFFTy9a?=
 =?utf-8?B?a1B4MVZPRjdFZUpmNGVGN0hDNkZ5UEhmeXhFZDdjcklaUmxKRUloWHJONFh0?=
 =?utf-8?B?aTJFaTNOR3gzQ0JQczNnUzBwYmhjNENxWUw0ajVSbW9HajlUdWJtRWFWeEM4?=
 =?utf-8?B?bnpaMXNZRzBMUjlQeDJhMkp1eXYwZk9tVVZ1cFhjWHB3d3ZXNEV1MytYUmN1?=
 =?utf-8?B?Y21wclkyNjhvZlRWNER0SkhOd0xtZElpc1lDU3o4cVRJZXloZ3piQktYbVZu?=
 =?utf-8?B?ZHVod0ZWdzR3NEg3TUdUVlc3MEVXdEQ5dFlSSWtvZnJZbkkzU2lDWmwrMjJU?=
 =?utf-8?B?MWdhRGxBMDE1dDliZE5waHlKS2lxN0RRVHBaNlM0THFMMzJNQnNYb3FDZFBU?=
 =?utf-8?B?V2FZVUxRM2xRWWg2bmdDRE9yTVBzdUpPWHRKWlZRbFRjNFNVWmg0aGpnTjZl?=
 =?utf-8?B?MGV0eHJ0UFFGcnBodEttay8veG1pWWdjRnNVWVdnWWNKYXhUTUsyQ1BCWkho?=
 =?utf-8?B?SDRVbVI5UXIwR1RENzNLcE91TVU2aFhpVWo0R3ltRU9UK1ZsWVRkTE5nMXQ0?=
 =?utf-8?B?b3FlbEpTZnV4NWpKMDNnUHZNQk1xTzYraVZ4Z05JTmFRNldvblBQUFM4MUJs?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1712EBD729AE2C42B8941BF029AD3E09@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f3b9fb-2c09-4f51-a67b-08dba309a50c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 12:16:42.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxmCQQ6kBmvQqsCyaN5NRfNkoQ0eKik147Aafsvp4QA3Dh2AyoPUh9KH41JJw3cXu9wUbcs5Q3M4hprOzMNjw5uZyXhn3e3gPSrW42mFVUBZcHlWkFB3RbBCUpLxlH8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7464
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNC4wNy4yMyAxMDoxNSwgU0hVS0xBIE1hbXRhIFJhbWVuZHJhIHdyb3RlOg0KPiBIZWxs
byBUdWRvciwNCj4gDQo+IE9uIDEzLjA3LjIzIDA1OjQzLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0K
Pj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNl
LiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2ht
ZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4+DQo+Pg0KPj4gT24gMDUuMDcuMjAy
MyAxODo0OSwgTWFtdGEgU2h1a2xhIHdyb3RlOg0KPj4+IG10MjVxdTUxMmFbMV0gc3VwcG9ydHMg
bG9ja2luZy91bmxvY2tpbmcgdGhyb3VnaCBCUCBiaXRzIGluIFNSLg0KPj4+DQo+Pj4gVGVzdGVk
IHVzaW5nIG10ZC11dGlscy0gZmxhc2hfbG9jay9mbGFzaF91bmxvY2sgZm9yIE1UMjVRVTUxMkFC
QjhFMTIuDQo+Pj4NCj4+PiBMaW5rOiBodHRwczovL21lZGlhLXd3dy5taWNyb24uY29tLy0vbWVk
aWEvY2xpZW50L2dsb2JhbC9kb2N1bWVudHMvcHJvZHVjdHMvZGF0YS1zaGVldC9ub3ItZmxhc2gv
c2VyaWFsLW5vci9tdDI1cS9kaWUtcmV2LWIvbXQyNXFfcWxrdF91XzUxMl9hYmJfMC5wZGY/cmV2
PWIyNTlhYWRjM2JlYTQ5ZWE4MjEwYTQxYzlhZDU4MjExDQo+Pj4gU2lnbmVkLW9mZi1ieTogTWFt
dGEgU2h1a2xhIDxtYW10YS5zaHVrbGFAbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+Pj4gLS0tDQo+
Pj4gICAgQ2hhbmdlcyBpbiB2MjoNCj4+PiAgICAtIGFkZCBMaW5rIHRhZw0KPj4+ICAgIC0gZml4
IGNoaXAgcGFydCBudW1iZXIgbXQyNXFsNTEyYS0+bXQyNXF1NTEyYQ0KPj4+DQo+Pj4gICAgZHJp
dmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYyB8IDIgKysNCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9taWNyb24tc3QuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4+PiBp
bmRleCA0YjkxOTc1NmEyMDUuLjA4ZTk0MzQwZWJhYSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJz
L210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+Pj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9t
aWNyb24tc3QuYw0KPj4+IEBAIC0yMjksNiArMjI5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBm
bGFzaF9pbmZvIHN0X25vcl9wYXJ0c1tdID0gew0KPj4+ICAgICAgICAgICAgICAgICBNRlJfRkxB
R1MoVVNFX0ZTUikNCj4+PiAgICAgICAgIH0sDQo+Pj4gICAgICAgICB7ICJtdDI1cXU1MTJhIiwg
IElORk82KDB4MjBiYjIwLCAweDEwNDQwMCwgNjQgKiAxMDI0LCAxMDI0KQ0KPj4+ICsgICAgICAg
ICAgICAgRkxBR1MoU1BJX05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RCIHwgU1BJX05PUl80
QklUX0JQIHwNCj4+PiArICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfQlAzX1NSX0JJVDYpDQo+
Pj4gICAgICAgICAgICAgICAgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9S
RUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpDQo+Pj4gICAgICAgICAgICAgICAgIEZJWFVQX0ZMQUdT
KFNQSV9OT1JfNEJfT1BDT0RFUykNCj4+PiAgICAgICAgICAgICAgICAgTUZSX0ZMQUdTKFVTRV9G
U1IpDQo+Pg0KPj4gQ2FuIHlvdSB0cnkgdGhlIGZvbGxvd2luZyBpbnN0ZWFkPyBXZSB0cnkgdG8g
dXNlIFNGRFAgcGFyc2luZyB3aGVuZXZlcg0KPj4gcG9zc2libGUuDQo+PiAgICAgICAgICAgeyAi
bXQyNXF1NTEyYSIsICBJTkZPNigweDIwYmIyMCwgMHgxMDQ0MDAsIDAsIDApDQo+PiAgICAgICAg
ICAgICAgICAgICBGTEFHUyhTUElfTk9SX0hBU19MT0NLIHwgU1BJX05PUl9IQVNfVEIgfCBTUElf
Tk9SXzRCSVRfQlAgfA0KPj4gICAgICAgICAgICAgICAgICAgU1BJX05PUl9CUDNfU1JfQklUNikN
Cj4+ICAgICAgICAgICAgICAgICAgIFBBUlNFX1NGRFANCj4+ICAgICAgICAgICAgICAgICAgIE1G
Ul9GTEFHUyhVU0VfRlNSKQ0KPiANCj4gDQo+IEkgdGVzdGVkIHdpdGggU0ZEUCBQYXJzaW5nIEZs
YWcuIEl0IHdvcmtzIGZpbmUuDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gWyAg
MjE0LjcyNjA5MF0gQUNQSTogSG9zdC1kaXJlY3RlZCBEeW5hbWljIEFDUEkgVGFibGUgTG9hZDoN
Cj4gWyAgMjE0LjczMTQ4Ml0gQUNQSTogU1NEVCAweEZGRkY4OTI4ODJEODk4MDAgMDAwMEVDICh2
MDIgQUxBU0tBIE1UMjVRVQ0KPiAwMDAwMTAwMCBJTlRMIDIwMTkwNTA5KQ0KPiBbICAyMTQuNzY2
MDgyXSBzcGktbm9yIHNwaS1QUlAwMDAxOjAwOiBtdDI1cXU1MTJhICg2NTUzNiBLYnl0ZXMpDQo+
IA0KPiANCj4gY2F0IC9zeXMvYnVzL3NwaS9kZXZpY2VzL3NwaS1QUlAwMDAxOjAwL3NwaS1ub3Iv
amVkZWNfaWQNCj4gMjBiYjIwMTA0NDAwDQo+IA0KPiBjYXQgL3N5cy9idXMvc3BpL2RldmljZXMv
c3BpLVBSUDAwMDE6MDAvc3BpLW5vci9tYW51ZmFjdHVyZXINCj4gc3QNCj4gDQo+IGNhdCAvc3lz
L2J1cy9zcGkvZGV2aWNlcy9zcGktUFJQMDAwMTowMC9zcGktbm9yL3BhcnRuYW1lDQo+IG10MjVx
dTUxMmENCj4gDQo+IHh4ZCAtcCAgL3N5cy9idXMvc3BpL2RldmljZXMvc3BpLVBSUDAwMDE6MDAv
c3BpLW5vci9zZmRwDQo+IDUzNDY0NDUwMDYwMTAxZmYwMDA2MDExMDMwMDAwMGZmODQwMDAxMDI4
MDAwMDBmZmZmZmZmZmZmZmZmZg0KPiBmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZlNTIwZmJmZmZmZmZmZjFmMjllYjI3NmINCj4gMjczYjI3YmJmZmZmZmZmZmZmZmYyN2JiZmZm
ZjI5ZWIwYzIwMTBkODBmNTIwMDAwMjQ0YTk5MDA4YjhlDQo+IDAzZTFhYzAxMjczODdhNzU3YTc1
ZmJiZGQ1NWM0YTBmODJmZjgxYmQzZDM2ZmZmZmZmZmZmZmZmZmZmZg0KPiBmZmZmZmZmZmZmZmZm
ZmZmZmZlN2ZmZmYyMWRjZmZmZg0KPiANCj4gbWQ1c3VtICAvc3lzL2J1cy9zcGkvZGV2aWNlcy9z
cGktUFJQMDAwMTowMC9zcGktbm9yL3NmZHANCj4gNjEwZWZiYTE2NDdlMDBhYzZkYjE4YmViMTFl
ODRjMDQNCj4gL3N5cy9idXMvc3BpL2RldmljZXMvc3BpLVBSUDAwMDE6MDAvc3BpLW5vci9zZmRw
DQo+IA0KPiBkZCBpZj0vZGV2L3VyYW5kb20gb2Y9L3RtcC9xc3BpX3dyaXRlICBicz0xTSBjb3Vu
dD0xDQo+IDErMCByZWNvcmRzIGluDQo+IDErMCByZWNvcmRzIG91dA0KPiAxMDQ4NTc2IGJ5dGVz
ICgxLjAgTUIsIDEuMCBNaUIpIGNvcGllZCwgMC4wMjIxMzkxIHMsIDQ3LjQgTUIvcw0KPiANCj4g
bXRkX2RlYnVnIHdyaXRlIC9kZXYvbXRkMCAwIDEwNDg1NzYgL3RtcC9xc3BpX3dyaXRlDQo+IENv
cGllZCAxMDQ4NTc2IGJ5dGVzIGZyb20gL3RtcC9xc3BpX3dyaXRlIHRvIGFkZHJlc3MgMHgwMDAw
MDAwMCBpbiBmbGFzaA0KPiANCj4gbXRkX2RlYnVnIGVyYXNlIC9kZXYvbXRkMCAwIDEwNDg1NzYN
Cj4gRXJhc2VkIDEwNDg1NzYgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2gN
Cj4gDQo+IG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkMCAwIDEwNDg1NzYgL3RtcC9xc3BpX3JlYWQN
Cj4gQ29waWVkIDEwNDg1NzYgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2gg
dG8gL3RtcC9xc3BpX3JlYWQNCj4gDQo+IGhleGR1bXAgL3RtcC9xc3BpX3JlYWQNCj4gMDAwMDAw
MCBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYNCj4gKg0KPiAwMTAwMDAw
DQo+IA0KPiBtdGRfZGVidWcgd3JpdGUgL2Rldi9tdGQwIDAgMTA0ODU3NiAvdG1wL3FzcGlfd3Jp
dGUNCj4gQ29waWVkIDEwNDg1NzYgYnl0ZXMgZnJvbSAvdG1wL3FzcGlfd3JpdGUgdG8gYWRkcmVz
cyAweDAwMDAwMDAwIGluIGZsYXNoDQo+IA0KPiBtdGRfZGVidWcgcmVhZCAvZGV2L210ZDAgMCAx
MDQ4NTc2IC90bXAvcXNwaV9yZWFkDQo+IENvcGllZCAxMDQ4NTc2IGJ5dGVzIGZyb20gYWRkcmVz
cyAweDAwMDAwMDAwIGluIGZsYXNoIHRvIC90bXAvcXNwaV9yZWFkDQo+IA0KPiBzaGExc3VtIC90
bXAvcXNwaV93cml0ZSAgL3RtcC9xc3BpX3JlYWQNCj4gNGZlNGU3MWIxMWY0NGU5NjcyYmQ0OWUy
ZTMyYzBmZDk0ZGE0ZmViNiAgL3RtcC9xc3BpX3dyaXRlDQo+IDRmZTRlNzFiMTFmNDRlOTY3MmJk
NDllMmUzMmMwZmQ5NGRhNGZlYjYgIC90bXAvcXNwaV9yZWFkDQo+IA0KPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+IA0KPiBTaGFsbCBJIHdyaXRlIGEgbmV3IGNvbW1pdCBmb3IgUEFSU0Vf
U0ZEUCBGbGFnIG9yIHVwZGF0ZSB0aGlzIGNvbW1pdCBhcy0NCj4gIk1vZGlmeSBtdDI1cXU1MTJh
IEZsYWdzIiA/DQoNCg0KUGluZyEgSnVzdCB0byBmb2xsb3cgdXAgb24gdGhpcy4NCg0KPj4NCj4+
IFlvdSB0aGVuIGhhdmUgdG8gZHVtcCB0aGUgU0ZEUCB0YWJsZXMgYW5kIGRvIGEgc2FuaXR5IGNo
ZWNrIHRvIG1ha2Ugc3VyZQ0KPj4gZXZlcnl0aGluZydzIGZpbmUgYWZ0ZXIgeW91ciBjaGFuZ2Vz
LiBZb3UgY2FuIGFuIGV4YW1wbGUgb24gaG93IHRvIGRvDQo+PiB0aGF0IG9uIHRoZSBjb21taXQg
bWVzc2FnZSBmcm9tDQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tdGQvOGI3ZDI0
MjAtMjZiNi00MDViLThlZjctNzVlMGEwMjAxNDAyQGxpbmFyby5vcmcvVC8jbTM1NTA5NzNlMDg4
NGVjNGEyODhkMzQ0ZmFiZDRhOWMzYjY0YWY0NmUNCj4gDQo+IFRoYW5rcywNCj4gTWFtdGENCg==

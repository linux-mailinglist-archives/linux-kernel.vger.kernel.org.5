Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD817525BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjGMOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjGMOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:55:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488A32715;
        Thu, 13 Jul 2023 07:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLIz8YR6exEl+FAbtYw0CKKfQ5TJV7c8j91cQbro7VpaOUkDDy+0GAzH70Dyyi5a3W3Oc+GFV/lu+junY8bpTJboKX2cLZ3C+2wyvnMuf/mrW9j//Ome2g7ROHqb9MVtORdzBJeStdP4ninScJjeeVeSb8yyvxMEdvGRmRUqyHrcrLT7X4i/mdwLle7r+vmtf1tNAx5+S/t52/9lknVWZJb7ZKzMrlgbMmhhXp1nhmxcjInGPW/IrDRNrHFZVwq0z7UY7tBuBZkS0ffwCX0yorL/gJgJnmWsrMbagQekavdxt05Z+m4/PToJal9aOMULwPUmCWm07+MfQmzfhYZxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XETvo5CYjXVjWWTvwD/xr/7haK0JJFCqVZaVSXRQuKI=;
 b=KTLzzErzqdD6Mcx65lU04h1VJtdxs68497Z2IgXINZqftxciWfAf0XdaVi6cRdAZ3ISAsqkncdUUZUhXDH5t4yQ9tZ3Q3tUtQn9B/nRGRWPmx1AWODCZvHgCuzN7tGLuVqu313k0tY7EhFuNmAS3Laslq0xt5uukq69FnX9O3MdFirUWWeSQd6CX5wEihgSktvdZIyJ+gq4beSkzTsA9osYiowlLiW7lfRZii4KKEihh8A9QJPTlsgGpgTNT3HppEa/WqvejAQVNwd1WTGiW97DH+YoJynD5cBaV5SUJ1zmlEhb10vU7Dsao8gAz/uqexzKwyDs9EDb1YDn1Ld0LGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XETvo5CYjXVjWWTvwD/xr/7haK0JJFCqVZaVSXRQuKI=;
 b=pi++QT48370RzRVIHM9k58ff+5GY0Yq4gdsFPEnNpCudVfwII7EnJXlgkPKIrn1hYa6CKalQfQmz12aMYgX0WZ1iCrUwchaQ+A+qh9f00TPmA9d4aB4zoekeyacyhsDH7Gu9No6LrRlYx8COZrl8JEdrlGA9QSdf5czK6ihfdZk=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by TYVPR01MB11312.jpnprd01.prod.outlook.com (2603:1096:400:36c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 14:55:27 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a51:df81:bca7:102b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a51:df81:bca7:102b%6]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 14:55:27 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee@kernel.org>, Min Li <lnimi@hotmail.com>
CC:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH mfd v2 1/3] mfd: rsmu: support 32-bit address space
Thread-Topic: [PATCH mfd v2 1/3] mfd: rsmu: support 32-bit address space
Thread-Index: AQHZYNuRm96yAwZGi0yyXIAiy21CwK8TVJ4AgKUdJvA=
Date:   Thu, 13 Jul 2023 14:55:27 +0000
Message-ID: <OS3PR01MB6593BFFA683814654C957589BA37A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <MW5PR03MB693295AF31ABCAF6AE52EE74A08B9@MW5PR03MB6932.namprd03.prod.outlook.com>
 <20230330132600.GR434339@google.com>
In-Reply-To: <20230330132600.GR434339@google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|TYVPR01MB11312:EE_
x-ms-office365-filtering-correlation-id: 878f78df-8d16-46bf-f3f2-08db83b131e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIs7ik8TXyUxGlxxthzdvCsH5KLX0+3o8LTlg2WnAHg/ivz1RRY9vrCAlO40Jc74wAc89JFU04RnGqHaqb9cqPaOTZBlcnDX1tbA+aDwHNANExINnjLRKc8k4yGD/3QG1bmx7M+7y7oEFZOhbi5nZwober3Tf0BOAv4LvpunxWCJ+gniOu8I55D1QyFUKWJxcCC3+M4lVt3APhzJFdXdMdG4bNhr8ZzBmAv9kVFo9nJhv+yfpvTXq3apCBr18g33700FRcoqnhJ4zgDeHRYV8w+EIDYCzhFEvYnFcAO3sdhdkyMf/YKNL88c8NHobOTq3JOSkzn98PvwJfOn1avAvH+gvlNUz2rAd0SFVSONQ/Dg6nwYSZLTRDG3kLj59MwodVRQCb97OuSU9y1wN6wmU1sX5Dd6gY7ib0LPYqPJz26uyH1iZcvGH4qe1iausoGkV72/ul0U0St2eNBry84Bx81R9MinWU5JDxQHHgZiKEWHorNm4GK/cXHVR3crqTnE5QKFiSseW3oF+w+hwI2xyyON0BZMFs1UUKr3/oy68OwkklcPZekYuPQDgbJ0EHWTgcfJ4qU+fCBPGWhDgcpgUetG0kreORF75KK+X/XwqrxhdgRhytk4um5/m+XHJ+HB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(41300700001)(38100700002)(122000001)(2906002)(316002)(8676002)(52536014)(8936002)(5660300002)(66476007)(66446008)(64756008)(66946007)(4326008)(66556008)(76116006)(71200400001)(7696005)(33656002)(9686003)(83380400001)(478600001)(55016003)(110136005)(54906003)(86362001)(186003)(26005)(6506007)(53546011)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXZnZUJqNlFCdStrVDZBSDdOZjduM1h0R2czTU5hUUFraTR1L2gvWG9QOW1P?=
 =?utf-8?B?TTNSL2oyZzBPQnlhU25wdTE4QkdqQVV1NGxlUFFnekRVN0xjdCtRUzFBVVlz?=
 =?utf-8?B?VjR1SXhIRHdaZXgyOFRMbEtXazJNZ0pUbzZTSnp6dVJ6SDV5ZUp1dDhONGh3?=
 =?utf-8?B?aUhQUXl0REpVMmROMzlsSUNKclBsdmRkcDhLOXVGa0VQS2pjelBSaEgyNFlk?=
 =?utf-8?B?QnNmYmJtUmNEUEZGVUNhYjViTGZEUXpXK0R4SXdncmNyL01NUkJOZWFRQk85?=
 =?utf-8?B?T3dWTllldnhrWVFaNUE2S1ZiMVBiZi9iRkFGanpRQkxZekdNb2w0RSsvTFpp?=
 =?utf-8?B?eEwyWHhOUGx6VEVPMFcrWHVPSHRsZHNTd2prNlhOK3M4WFFEc2hud29JVTRX?=
 =?utf-8?B?QWIzenprTnl0bDZrUGFQRkg3WnBuaGNXRVFJQ053Umo4eDNSK0pET29MTUxQ?=
 =?utf-8?B?RzRKZlExOE9Rakp5THZtV1cxNjJJUDRkdVN0blRveFhPcWpIV3M4MFl4Qkxi?=
 =?utf-8?B?TWJxdjJWKzBOUXh6VmFWSmZkalNyeWdGNWpnQ0k5MG9PaldXTTEwWE1yMDQ5?=
 =?utf-8?B?RHM5bDUrWDhhQi9GVlZRNVlPOHVFVStmaGViSHNITjY5N1VzS0R1WFZtR1d6?=
 =?utf-8?B?Zk1VRFRHenBZRERYRzJacU1BbkxIQmVMS2Z1U3BtbXhaTWE2ZWF2aHd5dmxR?=
 =?utf-8?B?c0svRFpiRWlZdkhRcFBBTkt1U09ORGQ3bXM5bE44SFVHc3NyNHpDa3BJT0lj?=
 =?utf-8?B?U1pDL0t5WTZtTVB0bTR6QUxNdXpLczRjR3hqODBXRkt2eWN1K2lEQjZPWVRn?=
 =?utf-8?B?K1pCV3JWYjRYeWNaK0dxVHkwYk9TdGErb2plYzB2bDNZTVRLd0ZsbjNJTG1r?=
 =?utf-8?B?U0JZeTVZT3NUZkZmM1RxMWViS3pqQmV3TVQvejNCbmFYelVoMkt1NUYrK0F2?=
 =?utf-8?B?M0NiZHBRdlFqN0hUSnU2NTlVeFVXejkwM0YyNmdXeXN2U20yWHNIYktkNFRt?=
 =?utf-8?B?TmtYcE5ka3JQWnBKMjU5M2k2QmpHYU1jQjlEUmF2T3VFbWh6cWVCTzZTOUZ3?=
 =?utf-8?B?R2VJSVJteFlFYjdTVi9hUEhraENHWEJ5c0d0eG5jeFhrUkJITTdaUEdFV3Y2?=
 =?utf-8?B?eTVnWEpmYlFRc3htSzlqWi9EZFIwMEIrZ3ZnbFdCSlNYa0tJbDVCUEVzdm9K?=
 =?utf-8?B?Rjg2RDhha3VkVzU1UWpEdmI5QjAyM29uVkgrdEJJZDZ1VkFnK0dUV1UrMWFv?=
 =?utf-8?B?UlNsbEVFcE00WEdoQVpsTkdZWXFnMDRGUS9BWHR3OXlxdDRvY1JjcC83Q0tI?=
 =?utf-8?B?YmNPQzlSZEhxREdUVXFhRzc5ejVBb3F6OVdXWGptMUM1bkVWN1ZOQk1zRGNy?=
 =?utf-8?B?bkx3MEVEM2haV01zQ0lpNWdtakxoT2t4a2JVek0vcWhFVWpKRlVaT3Q0M3Zn?=
 =?utf-8?B?azlHVlZ0RkVTNmNQWU5tQlkrNE5uVk1ab210M2dnQlVQUldWbWQyb21RcmZY?=
 =?utf-8?B?VWp4Tytxa3FJbG5XbTFmZEs5VnpGVlNqMzVMRlBCdER4MVRpNG40MFYzQThJ?=
 =?utf-8?B?dFZDYnRqU0ZrU0d2elhtSXRIeVhHczhkVy82NldKeDZmNFl1Q1VydTdOQk44?=
 =?utf-8?B?VE5PeWlTQ1E1OHJhc2VxV3YvOFNYUnB5dTVGdnQvR2JRSStselUvZnhzSmxx?=
 =?utf-8?B?UE9pMzFQdFFPQ2xJU3BqOHNvL0RWYTF5YUhjZWx4ZFhRanZ6N1NXRzlOdkk1?=
 =?utf-8?B?Nnh1R0tDeG9DMTNjQWdHN3VHQSt4MjZjcE16dmo4TmRJWlg4RnVHTEwwVjdN?=
 =?utf-8?B?SUY0b3Z3RmJIaEU3UGcxczd6Rm8wTHFQM0Y3aEdnSDBERUxUcmlLR3JxTXB2?=
 =?utf-8?B?N2pBdGRLVFowcUdsWFhtbSsveWVBM1NQTHBJM2NYT1F3SjdyQmJMcjhTVTMr?=
 =?utf-8?B?NG10cE5obFdib3BhdkJQQVN6SC92Q2NoUlhwTWJDVHNOV2ZyQ3JRN2IwUmlS?=
 =?utf-8?B?RXpJSGRPUFdtZVZYY1JKZkJCb3pUZVZMeEpndVNOL1l5SktqVFZudjUvQm9t?=
 =?utf-8?B?MjFKTzVNSDNsNWdhMTYyb004cStMVE9UWi9JNnh3RmpBUzBhQWZjRVZEUmdB?=
 =?utf-8?Q?+qYGtGFobLHwJGBR4LUgD+mek?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878f78df-8d16-46bf-f3f2-08db83b131e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 14:55:27.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GF2iX/yCQksF2wti8wqe0sca51bdLn7K/YhT0+5UM2p0FVOSyLp33cwjmfgSyL7hC+lWSakYEoDhmDiCZeyGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlDQoNCkkgYW0gd3JpdGluZyB0byBmb2xsb3cgdXAgd2l0aCB0aGUgZm9sbG93aW5nIGNo
YW5nZS4gQnV0IEkgY2FuJ3QgdHJhY2sgaXQgYmVpbmcgbWVyZ2VkIHdpdGggYW55IGJyYW5jaCwg
Y2FuIGFueW9uZSB0ZWxsIG1lIHdoZXJlIGl0IGlzIG5vdz8gVGhhbmtzDQoNCk1pbg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExlZSBKb25lcyA8bGVlQGtlcm5lbC5v
cmc+DQo+IFNlbnQ6IE1hcmNoIDMwLCAyMDIzIDk6MjYgQU0NCj4gVG86IE1pbiBMaSA8bG5pbWlA
aG90bWFpbC5jb20+DQo+IENjOiByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE1pbiBMaSA8bWlu
LmxpLnhlQHJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG1mZCB2MiAxLzNdIG1m
ZDogcnNtdTogc3VwcG9ydCAzMi1iaXQgYWRkcmVzcyBzcGFjZQ0KPiANCj4gT24gTW9uLCAyNyBN
YXIgMjAyMywgTWluIExpIHdyb3RlOg0KPiANCj4gPiBGcm9tOiBNaW4gTGkgPG1pbi5saS54ZUBy
ZW5lc2FzLmNvbT4NCj4gPg0KPiA+IFdlIHVzZWQgdG8gYXNzdW1lIDB4MjAxMHh4eHggYWRkcmVz
cy4gTm93IHRoYXQgd2UgbmVlZCB0byBhY2Nlc3MNCj4gPiAweDIwMTF4eHh4IGFkZHJlc3MsIHdl
IG5lZWQgdG8gc3VwcG9ydCByZWFkL3dyaXRlIHRoZSB3aG9sZSAzMi1iaXQNCj4gPiBhZGRyZXNz
IHNwYWNlLg0KPiA+DQo+ID4gQWxzbyBkZWZpbmVkIFJTTVVfTUFYX1dSSVRFX0NPVU5UIGFuZA0K
PiA+IFJTTVVfTUFYX1JFQURfQ09VTlQgZm9yIHJlYWRhYmlsaXR5DQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNaW4gTGkgPG1pbi5saS54ZUByZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFu
Z2Vsb2cNCj4gPiAtY2hhbmdlIGNvbW1pdCBtZXNzYWdlIHRvIGluY2x1ZGUgZGVmaW5pbmcNCj4g
UlNNVV9NQVhfV1JJVEUvV1JJVEVfQ09VTlQNCj4gPg0KPiA+ICBkcml2ZXJzL21mZC9yc211Lmgg
ICAgICAgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL21mZC9yc211X2kyYy5jICAgfCAxNzIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+IC0tLS0tLQ0KPiA+ICBkcml2ZXJzL21mZC9y
c211X3NwaS5jICAgfCAgNTIgKysrKysrKy0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvbWZkL3Jz
bXUuaCB8ICAgNSArLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25zKCspLCA1
NiBkZWxldGlvbnMoLSkNCj4gDQo+IEkgY2hhbmdlZCB0aGUgY29tbWl0IG1lc3NhZ2UgYSBsaXR0
bGUgYW5kIHJld29yZGVkL21vdmVkIGEgY29tbWVudCBhbmQ6DQo+IA0KPiBBcHBsaWVkLCB0aGFu
a3MNCj4gDQo+IC0tDQo+IExlZSBKb25lcyBb5p2O55C85pavXQ0K

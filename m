Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1875767C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGRIY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGRIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:24:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49A188;
        Tue, 18 Jul 2023 01:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1kegIF7onLjpni54uVfLDa5dgEHlyFCn8Z5p5QuUPXvTFpQDsQZFPqSGudbLUFEdep1si027fGDEUhc3/3rAK0N1nqjgZbb0T9H4Jm9Rg+H2O0ooYY8Dwlwe39CbeJ9vmE/W4rIflFiMwZsT2oZyG7U1Q7WCct6vvl0NI8t3cerHiVuV4cmItx3uNUe4+SViVLUyzbEacFwJlKk8HOnGYHXk/aof58YUSOmtNYF+PRIe5Tdc8tyGvWq/B9XAeuP1Yjn8Y6r6B+UPNO8JDiWbNQIqOWVmct8LWG3DHYv3ryfBXfgHP7oiatcS44N9HwkJvdsCDTfw4AOhyW4XDCGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0JCGIcGLlRlTzbOOnvXuGYtlqrtJ0tq2rZzX18OXLI=;
 b=BXxFIZaVXxbSThrdsVcw3yVxdRA7zvcCBc4efk5bCuSxH+2XMO8BHngix6xHZZDtof/Lm2MO90jk1KNVm8OQXCWuShLEUjwmswY6Ryd9/RWoKJcOhlq9L5hn9cXMYpiFtHUgExobK9v9YHgVLX9ceyt1jQL2nccnWBq/eewdOz4ZivfDBvK1QfxOP8x/3grS8HvKpHQptehRqCFxtniKmqhTFX1rEowZEsR1bgTsM/LLrufo9cQQO2ZOwo1jqqSZ1bNZTaFIxkgm0jmaANtMXjByWMeHfM1kqmrlpQ9U1gYK1WVvwKdUYaLi3ZFCb8p8/Hjfaunz17rKMtI6jRjwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0JCGIcGLlRlTzbOOnvXuGYtlqrtJ0tq2rZzX18OXLI=;
 b=X0N7NWWeiJeNqFfE/nE8Bzer7MvQ7UnbSzHovZbu39D3viUGofpr/UYvVzA+2lQwy3+zk9XedQNsvtyom9jN2mlinwp9KLvLDrlFE3wpewK2kMYuunMsWEVHOFrFJG33jTy6kynCzmmVmboHVMnZKF/vR5x4U7A8jPC0WH53uOeKg9iS1zoLtmP730jzToAFM1tNx+Sxotdx/XlhlsgD4k95eC3/AXmXpopC6vHPrPTNYSRAt8SPxX9O85pp5t6CDL/6jTry8Lta1Nl9SN5DzoH11xTZY7VCoZMhBU/LxY+LCmJ8DhJw3tnrREqEt2gsbe1LAvfsuBaeh6VMNejbVQ==
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::26)
 by GVXPR10MB5839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 08:24:48 +0000
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::91b7:8d37:9bdf:548c]) by DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::91b7:8d37:9bdf:548c%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:24:48 +0000
From:   "Haener, Michael" <michael.haener@siemens.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Topic: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Index: AQHZuUWCI98JGqNiX0ejHH0KqlbSIK+/JaGAgAAAT4CAAAoigA==
Date:   Tue, 18 Jul 2023 08:24:48 +0000
Message-ID: <bc64a846d6bae04549c7decb4e036cf10168c72c.camel@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
         <20230718065937.10713-4-michael.haener@siemens.com>
         <ZLZDi22lqZfHKFUZ@shell.armlinux.org.uk>
         <ZLZDzXQN3MKfOSwk@shell.armlinux.org.uk>
In-Reply-To: <ZLZDzXQN3MKfOSwk@shell.armlinux.org.uk>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2506:EE_|GVXPR10MB5839:EE_
x-ms-office365-filtering-correlation-id: 9701a05f-da90-42c7-0393-08db87687327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vpGv1Pb+FiPsNrJF7mwkIk0n+Xj/yXrDazN0HigtzY25ykZDEUaxPlS55OiL4P3XY9WEKou5YVBGtf8IUgdr1poBlouLFYl6FJCp8jw9FX8T5IAcVTYN7QU6wfJssxnUy7oGNulLBrHWVEr8w9t3KUw2H8Mkq60eDnEyWNgqHmDUKf90y/STdaZv/0PAOFl9J6WH7DGHlGKolqr2NgOSko/1cSQAEsqedpA0QQfOvlWnqbqGWF/WjbxAbk2oAnILkap8SdJHBLUz7xA4dwiwZOKbYdJe2zmJn31eg/Jtc2SJ3p6NVICRQpjJFNs9wrwPO9gaN3eCzbauPQ7v23/Y8I8ToKh8HOYoBhUoYmjOpZiNa7hnvvdEcPV5tqDRotTtXYA135N0rzAa2IBmE/V/CAKiRJop0R7w0ZPCM5iOYihNcyVid5J6eroNipoEe22a3KHVHi4OuFwvC/kKYzbSsa8RIAnXbvfGmYSAvqYR3ejzbI/+jmkmfynpfeC3lwMjOyLHJ5ossKqqPm76/AArshnLGOiR4zpFEZ5DYbPpMzBI4UhiOYIWvPV3z4no6AFgvbmuUsIFQ9QIedbGNLMiZuK0yZ3AY/C6ux5lnK3iW1PaT1w2kVdHV6/MwKrswXLnT6KwQW9chInl3fsjy9rgQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(1590799018)(1580799015)(71200400001)(478600001)(6486002)(91956017)(54906003)(83380400001)(2616005)(36756003)(85202003)(86362001)(85182001)(38070700005)(2906002)(186003)(26005)(76116006)(6506007)(6512007)(38100700002)(122000001)(82960400001)(66476007)(4326008)(66946007)(66446008)(64756008)(316002)(41300700001)(66556008)(6916009)(7416002)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzliN2Mvd093K3A4WEIyaDc5ZUkyRjdQWXBmS3h0ZjRUdVhQVGNzR3h4bE93?=
 =?utf-8?B?RnRGZ1BVbWxhTmcrMVFNZGErOFFQTjRPZk44TXEva1ViTSt0Qi82alRvNU50?=
 =?utf-8?B?MmlsN3VvbHdIeXpXd3I1RnJjYUxqemRHNi8rTzZhRCtOdXFJOGxMNkNlRkp5?=
 =?utf-8?B?RCtackg1b1gvSkpDODRycVMxNnQzUzcwVzgrSGVQZ1dtdE95UXBTWDk5WTB1?=
 =?utf-8?B?MUhsdmo1QUdlLzFxUEE0U0I3T1pTYUZ4UlVlYlc4dms3Z1lUOTl6UjRrQ3dZ?=
 =?utf-8?B?WnZweXNNa2VHWkJKTGhpcTI0dnl2TTJrR2xsbGpYUXN5VE9xL2V4eVBGRCtR?=
 =?utf-8?B?bTFZeTMzN2RjcmZaeGdGR2dodmVHUzVQby9pMERPODAyVmVlY0pCVTY0L2Rj?=
 =?utf-8?B?S016eUk3QVYraTYvK0dOUW1CNE93LzJ1bXpwSS9kdGg2a2x6bmplckdTKzVh?=
 =?utf-8?B?YW9MTmZ1dG9KQUlnQ3B6TzJGOVc1ZktUTUIxQm1PYmpGdzlmSStvWTREMWJo?=
 =?utf-8?B?c0tscmNZWG5uN21TakM5cWhRa1owb1ZFUVptUjA4bHFZUzVSOGYyc1hJeDhG?=
 =?utf-8?B?aCtXU0JFQXRKMS91L1I4MHRVb2h5VU1HZndLRzhIK2JTeVRQTnNuUjRicVhE?=
 =?utf-8?B?ZGlra3RELzJscW5aZnN5cEVYU25YaUlPTlRuK3VrR29sV3dhZGc3bkU3VXNY?=
 =?utf-8?B?YmRVVERzU2JjaWI0Mjl6ZHBVNlBwT2dRNWVoOUNkYVV0T0pPU1hRcjY4RFJG?=
 =?utf-8?B?OVNmSmw5dkhiWkdhRFBRc2xGWHBsd2NqK3lkQWtFUXhzRjJnNUdTRnpKRVcy?=
 =?utf-8?B?c08rQnZ4N0R4V0JxZHlpb21NR0pMRi9IaTFmemUxeUtGWUNuS0svdjVmWTVo?=
 =?utf-8?B?UDc1UDFCbVlrYVZUVHFYa25xSWJNQVc4VXV2Q0JTWWkwd1JzWWZMNU95endh?=
 =?utf-8?B?SlZiVE5BMytGOXBEQksxQUN5djZqVmxxQUlxYzBONXVxOWtvTVBWRk11UlVw?=
 =?utf-8?B?Z1V5dEpKRk5Jcm1sYXd0d3pjZXYydjZGbitTUmpKNHl3NEpuTUtUSEtIM2M2?=
 =?utf-8?B?VzlzQkFDLzFzNnlZTG1adkpwWFZtYjNrSFpxVGhrc0hIdkdVTGo5RDllWEpR?=
 =?utf-8?B?QWlSalJWYXRZN20yMFFKaUpPaVR4NDB3WEZ1ODNBUDVDYlRFTUJuenkvdThX?=
 =?utf-8?B?Qlk1ZFRSODZUVWZUNlNObEkvQTN4STFqb3hRbW53eTlNKzVhb1dsY3EzMk43?=
 =?utf-8?B?MUhRa29MdkpUYytzblNwUURWNjN5emFHT1pidmdPU3MwQ25EVXVabUlsQ3Rt?=
 =?utf-8?B?RlVMV0dWRTY0ZXVzYjMxVnlhWXZ4L1FqQ3pWZGN6S0FXK2IvNDBaU053RDBJ?=
 =?utf-8?B?Z0UwcG5PNUJ6NjVPempHUm9HaFNXcWFzaVU1ckRROWpwckhIdS9JcmlKaDVr?=
 =?utf-8?B?TVd1R3NhMWZPcHcyZ3BBNjRUZXJyMlV2Nk56a05VYzF6Y1M1U1RkeWhyODIx?=
 =?utf-8?B?Y1ovcXA2VmVKMXpMVVgxQkJiZ21ka2NvUnp5N2JJZDFXRzZteVRxcTZvMmxB?=
 =?utf-8?B?YUowUFkyMDJSUERTeWNMUnFseExZdDQ1UmcvbWsrQmI2YTFtTUUwL0pyd0FG?=
 =?utf-8?B?QndXam13NVFoblFrRG1TMERTNnJRTkdPTkFEMVNOa0UwbS9yK0hocUNlYXlB?=
 =?utf-8?B?K0FZMHgrWWpKblNGRzNnR2JCN1hEYnJPSGVMV3dLc0dOQVhBZWpTUlE2dUNs?=
 =?utf-8?B?eEswcWVZSFlLenN2SCt2b1pIYmhJU2dGeWo2RG80Z1BjUENGbzBFMG1rRi9t?=
 =?utf-8?B?UU1rZGNDa09vendSK2kxUjBqc1UwbnprZnBoYkxLODd1bVJObGJzUFJ2SzhE?=
 =?utf-8?B?ak1xdjlTSFhNS08vYm9vaFMrQzVtN2FGWVNCVkwvWnF0VkpjZmRNQ1h3WEFl?=
 =?utf-8?B?TjkrNk9VS2ZEWWVZdjhXd1MxZVprNW9YdU42anlpVFc3c0NqY1RleVlIcndH?=
 =?utf-8?B?UXNpWms3aGJOUUZvaHhXRUJjQWducUlkbGN2WmhjdzZvTmc4OE15dFhpWDZ5?=
 =?utf-8?B?d2oyaXlyV1FQMzBMUzVCRzZQN1V3UVpiRzhkQlRZekVGL01aSis2NWxwTzQx?=
 =?utf-8?B?bWwyaUVPMjFVR09FNTZEVCtDRVVjL24zb1cwRlhsenBrQjRJOWV2Rm1OZ1Na?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EE092FC7F3F4242A36D74C884559B49@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9701a05f-da90-42c7-0393-08db87687327
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 08:24:48.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JEQwgMhVPn76sM91OQMOoySKIIcJeM9Uc7WmO7m567DEi2iFVu7NpOe4Wt3s+LoQ6wTXeYG7WYlKaPgMKGNxCIgr9AXK0LtYMFFFE55WSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5839
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTE4IGF0IDA4OjQ4ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+IE9uIFR1ZSwgSnVsIDE4LCAyMDIzIGF0IDA4OjQ3OjIzQU0gKzAxMDAsIFJ1c3Nl
bGwgS2luZyAoT3JhY2xlKQ0KPiB3cm90ZToNCj4gPiBPbiBUdWUsIEp1bCAxOCwgMjAyMyBhdCAw
ODo1OTozMUFNICswMjAwLCBNLiBIYWVuZXIgd3JvdGU6DQo+ID4gPiBGcm9tOiBNaWNoYWVsIEhh
ZW5lciA8bWljaGFlbC5oYWVuZXJAc2llbWVucy5jb20+DQo+ID4gPiANCj4gPiA+IFRoZSA4OGU2
MzJ4IGZhbWlseSBoYXMgc2V2ZXJhbCBTRVJERVMgMTAwLzEwMDAgYmxvY2tzLiBCeSBhZGRpbmcN
Cj4gPiA+IHRoZXNlDQo+ID4gPiBvcGVyYXRpb25zLCB0aGVzZSBmdW5jdGlvbmFsaXRpZXMgY2Fu
IGJlIHVzZWQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSGFlbmVyIDxt
aWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gQ2hhbmdlbG9nOg0K
PiA+ID4gdjM6IHJlYmFzZWQgb250byBtYWluIGJyYW5jaA0KPiA+ID4gdjI6IHJlYmFzZWQgb250
byBSdXNzZWxsIEtpbmdzIHNlcmllcyBkc2EvODhlNnh4eC9waHlsaW5rDQo+ID4gDQo+ID4gSSB0
aGluayB5b3UncmUgbWlzc2luZyBzb21ldGhpbmcgLSB5b3Ugc2VlbSB0byBiZSBhZGRpbmcgc3Vw
cG9ydCB0bw0KPiA+IHJlYWQNCj4gPiB0aGUgc3RhdGlzdGljcyBmcm9tIHRoZXNlIGJsb2Nrcywg
YnV0IHlvdSdyZSBub3QgYWN0dWFsbHkgZHJpdmluZw0KPiA+IHRoZW0NCj4gPiBhdCBhbGwgaW4g
dGVybXMgb2YgcmVhZGluZyB0aGVpciBzdGF0dXMgb3IgY29uZmlndXJpbmcgdGhlbS4NCj4gPiAN
Cj4gPiBZb3UgbmVlZCB0byBtb2RpZnkgZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9wY3MtNjM1
Mi5jIGZvciB0aGF0Lg0KPiANCj4gLi4uIGFuZCB0aGlzIGlzIHdoeSB5b3UgbmVlZCB0byBiZSBh
YmxlIHRvIHRlc3Qgb24gcmVjZW50IGtlcm5lbHMhDQo+IA0KVGhhbmsgeW91IHZlcnkgbXVjaCBm
b3IgeW91ciBmZWVkYmFjay4NCkkgY2FuIGFzc3VyZSB5b3UgdGhhdCB3ZSBhcmUgZG9pbmcgb3Vy
IGJlc3QgdG8gdGVzdCB3aXRoIHRoZSBsYXRlc3QNCmtlcm5lbC4gVW5mb3J0dW5hdGVseSB3ZSBj
YW4ndCBhbHdheXMgZG8gdGhpcyB1bmRlciBjZXJ0YWluDQpjaXJjdW1zdGFuY2VzIChsaWtlIGlu
IHRoaXMgY2FzZSkuDQoNCg0K

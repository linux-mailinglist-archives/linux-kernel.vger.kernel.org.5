Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241B3757737
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGRI61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGRI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:58:19 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150401709;
        Tue, 18 Jul 2023 01:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZYRtcrEAJ5fP/x2D3bWjO38ovTXkyFx7DZTPkIpGu1d6Kuk77Hj83PM854du7rp1NB2499f8fIqLzR3TxbLU70MWwmVQPpcV2L7QxDHcukXLKYnUwEHcAX0r8kIxIB+GAr1fY2N2bGB3XNgYBNIyWS2DjrLhbkzq4i8b0yN8c6ZzoawoHOSK31QHH5vPdCBQJAruQy50j4kExBQ8BSeDA1HokwUFuztOT0ACDkAOJAgavILqmMTbyQKVB08/Mh929+xqnKjEAIxuJe3KmjH3vzDk+2oZ4S84AoRN87aCz4pRzUVMdF/L6d9VRmGmSmlbrrXF+lshkKgEqFWIepKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+GNzKLdcnXI5Zeyc/vPetmOnRbU71DvTw7MIKqtkiQ=;
 b=U5eJ9yoPv6PKjEnHu4wnSNzB9bFtJZkTlKIrywJHO8xb8mpbu+gRoozoDEEMtrmNDkFDM4TQvFsNczI//0L+0VvASZG4uSmmHtvB3OXzylnIRPWMoaJ5kGXYSppGGSKtd9RiAjf7Wk4ab2yG+5M0CQWi+1vkp9yKNFMW1O9M+7ntzFqzzFvvkCeaAWKV5tUsBy9CN8fxYjIaKqrJz1V4g0yI9aJ6y48Tql4zlIwDP2D7QBWD+kAT80ZHvuay19CAAoLoAEg2H+Y1Oo9Oinu1uyfaWTQDHxi9wTEGIKg6yI/JBkKfDLxBBoNpH9LZYD8fhldHUkPO/Vqo0lIHyV4+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+GNzKLdcnXI5Zeyc/vPetmOnRbU71DvTw7MIKqtkiQ=;
 b=YOAtG9eMq9eO2tRVXCPArCzJKZl5d8bBSmO8iHuo2y9Va1mfC8NuHHNXZBtdnv772qT1zG8KeZZbnsQxUG0wnd4P8CVE0f9d6fVmwuzGvBQmHpME6OveGC5Z7C3d2i/oLk7WMsWL3iOHcKbvshLLiA1I+52mAVJEdUgn1Vjj+DMGSptSjl91dv//RLcaPh7YeUukBZ0V3974XXcbomwKcSPViAGSy30xyaeCqE2XKDP9/VCmMTMMs9Gw/y9YRbQnDuA2iwKxRMBoLvDe0RTasWEnWoABwI7O0Q3QZjk9l9jds6tTEC2crM+smqMpVS9TjJ5rR4GdXWGij1CNPitCPw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:315::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 08:57:53 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:57:53 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "Haener, Michael" <michael.haener@siemens.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Topic: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Index: AQHZuUWCmDeNL1+DZkuXTQMtQaAi8K+/JaGAgAAAT4CAAAojAIAABNeAgAAEaQA=
Date:   Tue, 18 Jul 2023 08:57:52 +0000
Message-ID: <98187b6bea1e3f27feadfcf378abb9e99c4b5ee3.camel@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
         <20230718065937.10713-4-michael.haener@siemens.com>
         <ZLZDi22lqZfHKFUZ@shell.armlinux.org.uk>
         <ZLZDzXQN3MKfOSwk@shell.armlinux.org.uk>
         <bd7215b802b114b75de4568cc1642f791b233338.camel@siemens.com>
         <ZLZQXYvJXl44v7MN@shell.armlinux.org.uk>
In-Reply-To: <ZLZQXYvJXl44v7MN@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7116:EE_
x-ms-office365-filtering-correlation-id: 7b9cfb54-c760-4b96-aa8b-08db876d123c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uG9SGqNPyCAHuFfg7O9eLnU7ap09cLueLd2fYPNdbZN4YWNKWruTpEjD1n4m1vMwdF59/01nNW6+Qbp4FRMgGgdL1qMPwIbNY/c7V3BaewC3aRAKX83UJBAl4unxqn1ov7sJ0hfeedwKs2K+2Ig9iLznJVVM47IRgC2Ry9PngmQvB7n/UJq2wMKXrTu2L4G7VTZNZE0fZO335ui3bo2Ad+bKol0rStIXs77nrAjMsBK95byNHZIhNpfELenXViuHSJyDzjf9W0xRaW9edMMeOWp0FL2P2ozujOXek1c2otdJiXT4+b9jKby3/+ImYudVb7sDUFkkLtWbFwy/DwAqj7e71pG0eo1TaZonxczf9O5p7nrST5SaClSxXGcv7kcUVO4HD1vfi+paJM5ra8GHozJRcAq3vyfFAZ1INXIC4nocrFVBEpHKajxrqDercIgv2FnxutCkLH7hUWsISfT89Kjoo5BF7vjwTnfXnwpGSQSMUrShR6zQKOAh+Hx14BB80t4ukV7U0WHAXWEgKSp93dwILikNyMaaP11GJ4xqP82F2JKRxS4xAf6DdqckkzyOgo2FrNVGy9n8d1bIxSpywKSeq+iyOlzdI+jjeb8apVQFQQGjMK/76UDu5PBHcCuZlDeMeHOwgfaoKZg6rzZiYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(71200400001)(82960400001)(6506007)(83380400001)(38100700002)(186003)(26005)(55236004)(15974865002)(478600001)(38070700005)(6486002)(54906003)(66476007)(7416002)(8676002)(41300700001)(66446008)(2906002)(8936002)(66556008)(6916009)(66946007)(316002)(4326008)(5660300002)(36756003)(64756008)(6512007)(2616005)(91956017)(86362001)(122000001)(76116006)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXhpeTlZRmVQZUlScW5ISDBxWGVGb0loUmRXLzhDb1UvZmR5VlBFWGE5Um1r?=
 =?utf-8?B?RzFPdXhsbGhlY242Y3lhZy9IMWhjYVpOU0hNZjhuQ2I1TkgyckdZQ1U2ZktC?=
 =?utf-8?B?SG00WDIzRm8wcWk4R2ZFeWIxLy9WUnIyYWllWTJpWGRFTC9SVnFpSWpUeVZQ?=
 =?utf-8?B?eWg4ejZwV1dGbHFEZHpzdURqaFEvWU9xd3diZE5ySTF4ay80dklsUmZpa0Nm?=
 =?utf-8?B?ZUQ3ZTIwVnFmNW9vci9VTTRmcklzV3J6MjJMZ0VnZ21PdVNGS0VOUW05U3ZV?=
 =?utf-8?B?UUdoWU1TWlBpK2lSMFFPa2tnelJ2Ukx3ckJMSlNRWktpMW93VFdKMVBxamJy?=
 =?utf-8?B?bTlYeUJ2THJ3MnkyM3pVMGc4L0dPUzlqRy9MQWp6dnNvVUZSWnJaZUtWRFlr?=
 =?utf-8?B?VTI1TzRTM3pNYk02NVJtSm9zdGQ3Njd3R092WG9tQW1xWjVxMnlyQmh1UzR5?=
 =?utf-8?B?VEVGWUZEYVpGTXdpclJIek95NkRYRG5lS29xMXFOUnVXOUdqMmQ5QjVoMlQz?=
 =?utf-8?B?VlprWVFXM05rSVFGY0d4ZklGYnRGYVUrTjRZRUg3NGYxQ2lhTEJvVnQ1U0hY?=
 =?utf-8?B?cnJXbms2ZXNPaXRvcVhTUlE4ZWdBQUh1cUZYMm1OeWUvZjdEWEtpQlkvN0FM?=
 =?utf-8?B?RVJDTXJWT1I3N2IxZTVVZ1JKQ09QZExsRHFiVi9Yd0o5Z3NCOHpNZDlFVmJ0?=
 =?utf-8?B?NUE2WHp4cWt4ZjZLaU1ENkJiNTFUd3FoZCtuWnRodVNwdGM2TjlCeC90UndO?=
 =?utf-8?B?KzhsMHYvT0VBM3ZobVRCdHNORXVpWnJ0NlFzRjlZeWtVZ1FGL1VoYXppRGdZ?=
 =?utf-8?B?TnR6NFJLVURBZjdhRjloSzUwd2tXcVNkdk92S0I4aDZvOVZWTSs2VUJUSXpk?=
 =?utf-8?B?dzNXSFBSa1R2VXBRZXZtT2lpQlJDL3NiMk5oZnpueEhhNFNSWXRSL1pSdXc4?=
 =?utf-8?B?TUF2Sm1qTU9qMjVIaWdydnZoRDNaeHNkbWlpNml5NGdLcEpaVENyUjFyT1dm?=
 =?utf-8?B?MGtqa0Q3cGk3bkt4OG9KQVhjeEJsYlBzMDE0eS9CWU1yQXJBN3VHSklYUHp0?=
 =?utf-8?B?RUVhd0t5aXNvc012MFozT0tLMnZucDVWVDBtYWJFQ1VjaUdtVGl3UWd1L0k5?=
 =?utf-8?B?d3ZicHRMM0txendJUDNIcTNPeEVpYUxxWGEzL1ZvWWdOcTc4REFlZU9Oamc3?=
 =?utf-8?B?L2YzR2Y2Ylo3Tm5UMGl6UWxsM0VGWVlVeVVkcmFydk9lWmxxZ1doY0hZNFRR?=
 =?utf-8?B?Y2poeUU1d2xtWDBBeG1kMXhDck5sdzF5QjRYK3dKZEhyNkxwL1lUdGZBUVVS?=
 =?utf-8?B?ZjZlYkJKOWwxRVkvLzJLcFZwc2Z5VXZnSE5XdHQzTFdmSkJRK3pwKzhNZXd1?=
 =?utf-8?B?Y3pOaEJPTnM4R05FS0JYUFh0RGpneWY5YlJDcStaVmRPWENjWUtnVjc3UFV3?=
 =?utf-8?B?b1QwL1IvMFNIRDRYSUROaUhac0t4Z3IwNDZCeGNjZ2gxWk9URzVjVThVclBH?=
 =?utf-8?B?ZlFhYWRJbktDRUpYMSswVWFBOU5YaXZnUXpBdEpGdGd0VzJ6ZHIveXZFY01S?=
 =?utf-8?B?YVpzU2ltYmNjMVdHM1ZTcEpTWVFHWTNvUmdMdkY5Tm1iY2laQ2d6RHVvL2V4?=
 =?utf-8?B?a3lqWDFxbVhWWVU2YzNqUGNIekpYbWtKMVozRlhLdDhwSlpPcHZjNTl2RnYz?=
 =?utf-8?B?TnBJK1FIUEJRclVCUUtyVFNxaDZxY2NWek1QeDJTUWZVd2hRVTdFSnBpbk0x?=
 =?utf-8?B?WCt3cWJPZXBJRlJDS2o5aUdXWUxjMDVsRFhqRWVNcnFkVGVYbXFZd3J1eUlz?=
 =?utf-8?B?QURoV3d5bkh6SUUvVDYvTkgxTlBVdG5hbDNINHFqaldrSU5idC80SW5Lcnly?=
 =?utf-8?B?Z2UrbUl3dkhDSXI3NnRHc0NNT2tlWGx5ZExadkphZjlETWJuLzN5Nk1NOEVw?=
 =?utf-8?B?WFBSVWVFeTJ6MkR0bGdqVUVYVzUrV0tSalJ6UkU0cUc2U3QwRnVBbHlUUkpV?=
 =?utf-8?B?KzhIUzAyZmI3c0RocDgwOW1TcmZXUTc1NG5yL2MwaTkybmZoQ0JjcnVPZ0xm?=
 =?utf-8?B?dWRnNFJ2Mm9selAvYVpnTGRTRitsb3B6MWxYaFFDeTNpVWJ3NTNSaHpFcS9o?=
 =?utf-8?B?eS9TRThPYktWSjQzOUZTcVVkNXh5eWt0dnNrc3g3SWErRnI5Z0YwU0FLWk9a?=
 =?utf-8?Q?Kpf7+3Rt+qKijryZ2XaOlGU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBA3F2D7CB71C74EAF39053741B03D9B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9cfb54-c760-4b96-aa8b-08db876d123c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 08:57:52.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOgb6Ey7O7FTXP9D2Wke/Z8mLzjRnR2ccElKduPohC72WvuHFdNdHB6BJI21rbAGmAW31bSm/kg9V+6pdqfrTJO0AT0IOV/O7TexkQs1PUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7116
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

SGkgUnVzc2VsbCwNCg0KT24gVHVlLCAyMDIzLTA3LTE4IGF0IDA5OjQyICswMTAwLCBSdXNzZWxs
IEtpbmcgKE9yYWNsZSkgd3JvdGU6DQo+ID4gPiA+IFlvdSBuZWVkIHRvIG1vZGlmeSBkcml2ZXJz
L25ldC9kc2EvbXY4OGU2eHh4L3Bjcy02MzUyLmMgZm9yIHRoYXQuDQo+ID4gPiANCj4gPiA+IC4u
LiBhbmQgdGhpcyBpcyB3aHkgeW91IG5lZWQgdG8gYmUgYWJsZSB0byB0ZXN0IG9uIHJlY2VudCBr
ZXJuZWxzIQ0KPiA+IA0KPiA+IGFyZSB5b3UgYWJzb2x1dGVseSBzdXJlIGFib3V0IGl0Pw0KPiAN
Cj4gWWVzLg0KPiANCj4gPiBtdjg4ZTYzNTJfc2VyZGVzX2dldF9zdGF0cygpIHJlbWFpbmVkIGlu
IHNlcmRlcy5jIGFmdGVyIHlvdXIgcmV3b3JrIGFuZA0KPiA+IGFzIEkgc2VlIGl0LCB5b3VyIHJl
d29yayBpcyBhYm91dCBsaW5rIHN0YXR1cywgYnV0IHlvdSBkaWRuJ3QgdG91Y2gNCj4gPiByZWdp
c3RlcnMgYW5kIHN0YXRpc3RpY3MuDQo+IA0KPiBXaGF0IEkgc2FpZCB3YXM6DQo+IA0KPiAiYnV0
IHlvdSdyZSBub3QgYWN0dWFsbHkgZHJpdmluZyB0aGVtIGF0IGFsbCBpbiB0ZXJtcyBvZiByZWFk
aW5nIHRoZWlyDQo+IHN0YXR1cyBvciBjb25maWd1cmluZyB0aGVtIg0KPiANCj4gSSB3YXMgbm90
IGNvbW1lbnRpbmcgb24gb2J0YWluaW5nIHN0YXRpc3RpY3MsIGJ1dCB0aGUgc3RhdHVzL2NvbnRy
b2wNCj4gb2YgdGhlIGJsb2Nrcywgd2hpY2ggaXMgbm93IGluIHRoZSBQQ1MgZHJpdmVycy4NCj4g
DQo+IFNvLCByaWdodCBub3cgaXQgbG9va3MgdG8gbWUgdGhhdCBfYWxsXyB0aGlzIHNlcmllcyBp
cyBkb2luZyBpcw0KPiBwcm92aWRpbmcgc3VwcG9ydCB0byByZWFkIHN0YXRpc3RpY3MgZnJvbSB0
aGUgUENTIGJsb2NrcyBhbmQgbm90aGluZw0KPiBtb3JlLCBzbyB0aGUgY292ZXIgbWVzc2FnZSBm
b3IgdGhpcyBzZXJpZXMgaXMgbWlzbGVhZGluZy4gSXQgaXMgbm90DQo+IGFkZGluZyBzdXBwb3J0
IGZvciB0aGUgc2VyZGVzIGJsb2Nrcy4gSXQgaXMgb25seSBhZGRpbmcgc3VwcG9ydCBmb3INCj4g
cmVhZGluZyBzdGF0aXN0aWNzIGZyb20gdGhlIHNlcmRlcyBibG9ja3MuDQo+IA0KPiBFaXRoZXIg
Y29ycmVjdCB0aGUgcGF0Y2ggc2VyaWVzIHRvIGRvIHdoYXQgdGhlIGNvdmVyIG1lc3NhZ2Ugc2F5
cyBpdCdzDQo+IGRvaW5nLCBvciBjaGFuZ2UgdGhlIGNvdmVyIG1lc3NhZ2UgdG8gcHJvcGVybHkg
ZGVzY3JpYmUgd2hhdCB0aGUgc2VyaWVzDQo+IGlzIGRvaW5nLiBJdCBuZWVkcyB0byBiZSBjb25z
aXN0ZW50Lg0KDQp0aGFuayB5b3UsIG5vdyBJIHNlZSBpdCwgLnBjc19vcHMgaXMgaW5kZWVkIG1p
c3NpbmcuDQpBbmQgeW91IGFyZSByaWdodCB0aGVyZSBpcyBubyB3YXkgYXJvdW5kIGl0LCB3ZSB3
aWxsIHByb3Blcmx5IHBvcnQsIHRlc3QNCmFuZCByZXNwaW4uIA0KDQotLSANCkFsZXhhbmRlciBT
dmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

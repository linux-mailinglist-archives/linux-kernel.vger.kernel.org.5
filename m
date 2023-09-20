Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E517A787F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjITKCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjITKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:02:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027C8F;
        Wed, 20 Sep 2023 03:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETp9P/Ve0enTICzAuKCngPL/uT2XT+ryo/hlqW6oW17IOZ2ZH2RsB5s7b3L/v00+PwZ5JfbZI2ZWgZNsJ5VcHx9M0mbhfK2g2HNcrdNWO5p0mbslxQXe491hprxz3wiQsS8Y+jNMKcfZdBf7AN72eABi41y52h21IuCqSLX+HTDFAuKSOeT+gePcHAeLO4U7AhQMkIk5c1joY6psGm11xU3oe9U4BG4T5Iq9tbeo2uURN/LAAd47iavcSUOPU0w3lsd5XOuCiSE3LB9fcZymQQN4s47sGcKvDkJt7HMTI/3Yq3wlUpHH5kvQ/l2OeS3tEtiPpA4TGQAXjl5KvAKRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC6W6AXfpztoXaLL34vk0H2dlWbRlAs3P+a7WB4Xch8=;
 b=ArxueIS+cxJKLMQaokSKIbhMnsQSKhcnZXGcGRhNH44lKZDRkFvfiClh4lvoheOyJZQSZz7SwoRoRrbguDL9ydqejHuu5mdk1vmG6Fkhd+eb1IJS3haHaAVytVZsIuYwm2TZhCm74W4uJCxAayUecNx8pkNtVglGrmE6qteXofTL1YjJ5uQBCSZh0tWl4o8/J+PootR7Fshicrol+LGgwrUS+yBSgdCGWuFTxmVT0L/SN2EsgmzSLoJwGRviBYSm7jHCQcWGXB8+ZlVotRKqWvKtUacdBlGz5Viydu8bXDbyHR6ifMF+FPmpj/rtNVaY+4U36Ou2CrhM2oaKZX3aVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC6W6AXfpztoXaLL34vk0H2dlWbRlAs3P+a7WB4Xch8=;
 b=Hyn62FP8W/SAS/HpM5KMgZSYzo2zVDx58imz0qim20kv3uR2l+z5EFCmovyJX12O6RBMHWHAkklCLouva18lhAtDfehRfOqwy496wncsMlKeS+yy/mdQRCpWbaIP36pB96fTV+LZXkwOqHNOBxOBKHTdtY8utp2BRaXWDsWm8VM=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 10:02:35 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 10:02:35 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anle Pan <anle.pan@nxp.com>, Xuegang Liu <xuegang.liu@nxp.com>
Subject: RE: [EXT] Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Topic: [EXT] Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Index: AQHZ5t7nwJrRJ7WJYEaDKJh4zDlG3LAjXeUAgAAngaA=
Date:   Wed, 20 Sep 2023 10:02:35 +0000
Message-ID: <DB9PR04MB9284735F735FAFC3EAB810D587F9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230914145812.12851-1-hui.fang@nxp.com>
 <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
In-Reply-To: <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|PAXPR04MB9593:EE_
x-ms-office365-filtering-correlation-id: 258fc376-1cc3-42d6-2bd2-08dbb9c0b693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCyyWfi77USqd8glnwaLkCGt5jR51t+wHR0TqhDIYlyPVzqI7aCycRMt5vCHop0ntmdiIDB3p2ZmMav65DzwiL/NmKma5/8rqHB3T0yJG6l1FlsHG9ttXPr7olVFL42s22oYnwNXOxjwUikpFqPGW+q89VYi+uCNzWqZvKca79Ztih3+U/slfS6FFXHq5kp4VuwdWo+quVasGU9Y/oltFH3ELlWA5hSmvQePfuMpJsc//99vR6OnzkKq1w4ZF37cTgBmPCXU8FH1NXV2rhQem79lGBnXDyjDInzQCyZt9x2d/oVlxJh3MedMMRD/Qpk12naEk/X5tMWD73LiPIQNepZ+Goqljcx03FmqL1TUtccBalLPBJk6qfeuu4gjNbw411i4AZp2RTyNaZP0nxQk67CR0X9Ip1dLRMExEa7p87nD1EsfFNDhDKnAEhZD3mBTrrr0k1Vo/CJn2ozPeIzQ80+g5PIHtg2FKUqVJPZPvLof7RzMZFr0QTM1WeVe1Gv8Z8gMK7G7Tg8ZIfx8ycsUwE3HHdLTGj5/l11gDFHyCjJLmzYxighsAOHS1Ln0PA83m1jg71q8+Dd1jSvwde6BIJKKmVoPHidyxVrSGk5xlzlEWKgf3H4CKUcLS+NMtL0M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(110136005)(54906003)(66446008)(316002)(478600001)(66476007)(64756008)(66946007)(76116006)(86362001)(7696005)(26005)(6506007)(71200400001)(66556008)(9686003)(53546011)(8676002)(8936002)(44832011)(52536014)(41300700001)(5660300002)(38100700002)(2906002)(38070700005)(4326008)(122000001)(33656002)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJkQkZkSktJSW54KzRqbUthUFJ0TjBUMkVVaXIvcFY2R2FueC9rRXRvNFh2?=
 =?utf-8?B?akx5QWFRQTBSbUxPeDR1MCtsMzdUb2tIdXZ2L2JPRHBnNGx3LzgzREx6dm1s?=
 =?utf-8?B?WkNDbjdTV1ludmVkUDNmTXd2YXdzMEZhTjd1M0d0emdzaGxPQzdxOHhoY0Z3?=
 =?utf-8?B?UlcxRW5nOHdJTEhoY1JQeVlpd2tsU09zd3V2YVRabm5PZWJpMWxaN1poYmFB?=
 =?utf-8?B?em9HZmNVWXNVR2tBZlVEUXkwdytjakd2ME1jUnVLSHgyc3p2c2VLOCtSSEQ2?=
 =?utf-8?B?RFZ0U1Z4eXJTSGxaWDBZaVpja0dzMVlQdXJkcDlnZVlDVkdhbjAzb29HRHls?=
 =?utf-8?B?NGV2SU5IT2lMcGdDbHFXenZYVXRmeXd1Y24rUG1Ic0s0WHZBdUxjSDhMbngr?=
 =?utf-8?B?V3NwUEx4NFcxTEVtZHNYWDlmL2JTcXNiK0xIRUV6ZTJGYVBKbE1KTlpvdUs5?=
 =?utf-8?B?YUI3WWYwRjZRa3QwRnhOU092clN3aitQeTd1Y3RzdXhWTVF0RnZqNythRElJ?=
 =?utf-8?B?VnkxbnBmZnM0QkExUDVodEZaQ0lFOUJVZC8vU2dudGRqWm50Y1YzR1Zoa2hJ?=
 =?utf-8?B?dktxZkd2OU55N3VNaVNsZWhMUWRPdnV6SUJhanVsTnErUFA1M1Y1Qkd4bmRy?=
 =?utf-8?B?QVpOQnl2N1dtWkswOVNsZ0wzcWNEbCtYdHV1Zm9BY3VjMEFycDlkekZFNWZY?=
 =?utf-8?B?RHIxUytVY0xtRk1kaUZoNkx0SHFNUTBOQ0pYYUFnTFVWWDNkbllYRXV3SE5p?=
 =?utf-8?B?WmRMZXVRa0RuYVgrKzMwMjdzVkF5MHlPbXNYMzJxRVpqUXYxZm9IVGw4SkVl?=
 =?utf-8?B?dE5MSzdROXkzbmNCQ2QwMXF2cnZOYVhOeXdGelRYMUh0Z1pzQnRMZngwSTVz?=
 =?utf-8?B?OEF6VmJ0MmJIcHduTWhFZmE3RXBBUC9WQjFML3A1UjloRDd2QTNheHRWUWRP?=
 =?utf-8?B?QklaNVkrSmhNR1E1KzNNYTRyN2VaM0svcitaSzd2ZUdTcTFGbjNCb0RyZ3NM?=
 =?utf-8?B?dzRHQzI0czMyd0krWVhVbk9SUTJ1b2Y4b0YrUXBqcGcvUVh0czV5aVZKT240?=
 =?utf-8?B?cWpuNGhuSytZTm80ejh2aml4VEltSUFpVGVyMlUrUzJ4NFhyT0g0MHBKSkN5?=
 =?utf-8?B?RjhqcjlzYkw2TzJEYUVUNlliMm5rVC9EaWRGZnFHTTFSMFdFSHc3YTU3VTdT?=
 =?utf-8?B?SThFOUVvb2R6ZkNCaEl1NTA3S2NwU05uamVzL3IxU3BGTFJURk5ncklsMWds?=
 =?utf-8?B?M3RaQndBUzJic0VwQjVXM1BFSVFuN3V2TTJsUmRLY3phMm9iMmVQalBqNThk?=
 =?utf-8?B?Rm5DYUg4WEVLYUtyMi9ueEJNWnlMc0NmUFhVRXZZU1FBTUtYdkVpQUhCdVJ4?=
 =?utf-8?B?TzNiODl0RG1DQjVQTzM3Q09ReEJyN1RIL1BjeDRac2U4WDVHcWtWbHl5T1Zq?=
 =?utf-8?B?eVZsRlB6KzNQL1hoQUF3S1lNbk1UN2FVQ1hUWmM4QkZoZTBnTTFyVm8yeDVI?=
 =?utf-8?B?bDRHckFjVnA3N1ZMRE1iMFQxSWgrTE56ZEl6YUEvOWNsanYxTGZEY3h6Sm05?=
 =?utf-8?B?TWtmbk5Ha0dGazh6djJjQU5vTk1sK3l2YmFwYkJUS2J5Q1FwZDFDN3VNaVBY?=
 =?utf-8?B?TC8waCtzOHNrckhmbHU0bTZKM2hPcG9obGZieFRsN0U3VVN5R2k3RHFPbHc4?=
 =?utf-8?B?Qk5OR0NwRFlaRXM5TExaN1FZTndlM1prMVlUYUgxMncrQU9vLzlxZmVyM2lv?=
 =?utf-8?B?ODlIYldhWkVpTkJ6SmZnUk5JZkNYU1FNcnFKT0NYcE13WWtMMlM5bVVGN1ND?=
 =?utf-8?B?enhPcysxd2NiQkthWW1iUWlpekhPRXNYeFhyZUo5VFJLR28xeVhpa1Z3WE9n?=
 =?utf-8?B?VTVYOW5zN2x0K2RYYUpKK2RBZFFMRWxoUzhrZENlMTRMek1BR1UwOUhldWpS?=
 =?utf-8?B?RkUvZllEZXpHMnArTmFuMyt5STJGY2VtWVZ0YkdQUlBybTV1TFNJTDAwNFI2?=
 =?utf-8?B?UzNFaWlvRUhLYjZpZTNFaUpRTmxMcHRiU3BpMXA1aGpGMGZES2h1VDNyalBF?=
 =?utf-8?B?cWRuMnJyVnpKTW4vTjJrNXVqY3dYVVorQTNOUGZXN295YXY0SzRacCtEOFdG?=
 =?utf-8?Q?aDzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258fc376-1cc3-42d6-2bd2-08dbb9c0b693
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 10:02:35.0424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tsTksezDHgNSwjFJ/U4FE5DpjkS6q7NFYcqMYvtP8rbm1RK55yLQ+u3/g1Q2CeljnxYr1c/s8+6m6BHVFATnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBTZXAgMjAsIDIwMjMgYXQgMTU6NDHigK9QTSBUb21hc3ogRmlnYSA8dGZpZ2FAY2hy
b21pdW0ub3JnPiB3cm90ZToNCg0KPiBJcyBDT05GSUdfWk9ORV9ETUEzMiByZWFsbHkgdGhlIGZh
Y3RvciB0aGF0IHRyaWdnZXJzIHRoZSBwcm9ibGVtPyBNeQ0KPiB1bmRlcnN0YW5kaW5nIHdhcyB0
aGF0IHRoZSBwcm9ibGVtIHdhcyB0aGF0IHRoZSBoYXJkd2FyZSBoYXMgMzItYml0IERNQSwNCj4g
YnV0IHRoZSBzeXN0ZW0gaGFzIHBoeXNpY2FsIG1lbW9yeSBhdCBhZGRyZXNzZXMgYmV5b25kIHRo
ZSBmaXJzdCA0Ry4NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBCdXQgQ09ORklHX1pPTkVfRE1BMzIg
bWF5IGFmZmVjdCBzd2lvdGxiX2luaXRfcmVtYXAoKS4NCg0KSW4gYXJjaC9hcm02NC9tbS9pbml0
LmMNCnN0YXRpYyB2b2lkIF9faW5pdCB6b25lX3NpemVzX2luaXQodm9pZCkNCnsNCi4uLi4uLg0K
I2lmZGVmIENPTkZJR19aT05FX0RNQTMyDQoJbWF4X3pvbmVfcGZuc1taT05FX0RNQTMyXSA9IGRp
c2FibGVfZG1hMzIgPyAwIDogUEZOX0RPV04oZG1hMzJfcGh5c19saW1pdCk7DQoJaWYgKCFhcm02
NF9kbWFfcGh5c19saW1pdCkNCgkJYXJtNjRfZG1hX3BoeXNfbGltaXQgPSBkbWEzMl9waHlzX2xp
bWl0Ow0KI2VuZGlmDQouLi4uLi4NCn0NCg0KDQp2b2lkIF9faW5pdCBtZW1faW5pdCh2b2lkKQ0K
ew0KCXN3aW90bGJfaW5pdChtYXhfcGZuID4gUEZOX0RPV04oYXJtNjRfZG1hX3BoeXNfbGltaXQp
LCBTV0lPVExCX1ZFUkJPU0UpOw0KfQ0KDQpJbiBrZXJuZWwvZG1hL3N3aW90bGIuYw0KDQp2b2lk
IF9faW5pdCBzd2lvdGxiX2luaXQoYm9vbCBhZGRyZXNzaW5nX2xpbWl0LCB1bnNpZ25lZCBpbnQg
ZmxhZ3MpDQp7DQoJc3dpb3RsYl9pbml0X3JlbWFwKGFkZHJlc3NpbmdfbGltaXQsIGZsYWdzLCBO
VUxMKTsNCn0NCg0Kdm9pZCBfX2luaXQgc3dpb3RsYl9pbml0X3JlbWFwKGJvb2wgYWRkcmVzc2lu
Z19saW1pdCwgdW5zaWduZWQgaW50IGZsYWdzLA0KCQlpbnQgKCpyZW1hcCkodm9pZCAqdGxiLCB1
bnNpZ25lZCBsb25nIG5zbGFicykpDQp7DQoJc3RydWN0IGlvX3RsYl9tZW0gKm1lbSA9ICZpb190
bGJfZGVmYXVsdF9tZW07DQoJdW5zaWduZWQgbG9uZyBuc2xhYnM7DQoJc2l6ZV90IGFsbG9jX3Np
emU7DQoJc2l6ZV90IGJ5dGVzOw0KCXZvaWQgKnRsYjsNCg0KCWlmICghYWRkcmVzc2luZ19saW1p
dCAmJiAhc3dpb3RsYl9mb3JjZV9ib3VuY2UpDQogIAkJcmV0dXJuOw0KfQ0KDQpBbHNvIHRoYW5r
cyBmb3IgeW91ciBzdWdnZXN0aW9uLCB3aWxsIHJlZmluZSBteSBwYXRjaC4NCg0KQlJzLA0KRmFu
ZyBIdWkNCg0K

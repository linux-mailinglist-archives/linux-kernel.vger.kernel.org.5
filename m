Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF87911CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbjIDHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIDHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:10:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE0A0;
        Mon,  4 Sep 2023 00:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naNre4h7M3A0c9iSNd7dIbU6p4Faox1IxRkrU6/uRZWKYZrcS3QP/fpIji+2LD5+MBlMxpBk/YYKQIFRGufToH+1jyDJ2PumR7Oa1NLBKVzvHPa36ED3lWuCdEwDkoQqgdI1DZE1WVmpGwb8aoO6RxUV3ApIiely3dvN35dsNz4C/Yy8F+q71yGPYp0Ugh2rurBbT+DaZG3Lx3LxY2xIoZ04IZjH/XMHFkjVN/b6JXOVgVaRMziOPlY63TqpCS0N6uE3UTyLmJM/1n4hDTZmHyqQEogwXuYbvs/n6OkOee/ON8W3pN7r7MPYRrHgH5/MCEnukQEnfJwvug4UQCEX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18X0AFgbwQ76yCf9R6PTfarDvoBYjLFhg7JzxlbYbM8=;
 b=hE4adCoglyQmkUQp4D47mMfVeOAOMgWcduVY3w5XrGd46cPOsddKXab80Vo39NbPDhoPMMr5FMMV9SE4+dgqN7jaz3IAqKNNddxcY+t6PBrM3/dAYh2lbJ4GeXoHYWkTHzm7wy/LNX6VFNnIkzMEWhvdYeaPKUejY7805hFOSpc3EbzCVLOQl3mJj/3uuKcsMsVFzML2NMrPyN+7l4TPwElTpGLvz9/7AYEh+Bzx0G9JRW6qFJ5cpy0x8aFl8Uf8RXx8byfjRgghel9uxz39ZRMrplMpAhA+rJVVvAZMYHj3OsykoZk+8usR4DvbR/Ea5xUTWDQrYw6Od0f9Gaeg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18X0AFgbwQ76yCf9R6PTfarDvoBYjLFhg7JzxlbYbM8=;
 b=X5a2VSkdT8MAdGRW+xArJUgcyQrUIsrZCx4XoNik0OoYZj+ohPvMQX1+xCljVjp7leR/VkX7D61vLeYbI76BvvWZONKgYr2N/imin/vBdVLqmpexcj2wKIFGEAU/GspCBZS8Kvtj8NRmK+aHrkOvyAjN6drhkHmgSjQ0HKHPT28=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AM8PR04MB7201.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 07:10:08 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6745.020; Mon, 4 Sep 2023
 07:10:08 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoA==
Date:   Mon, 4 Sep 2023 07:10:08 +0000
Message-ID: <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
In-Reply-To: <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AM8PR04MB7201:EE_
x-ms-office365-filtering-correlation-id: 2e76bbbf-a4b6-458e-57da-08dbad15f8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/s0sUreNXaq4Gy/9kMd8IlGdbC5CSmj2SSg+ylOtFaVWX3KhOU47tUdhCLu3se+0ZGQujc6DuQIgklApFEA6+FNYkQsEzY8etHMGx56Qhyr2UB6WthB9RDZolEK1CXFUyTtqQJ/+SUHaho+SxJSkFwBNeu+H6emxzB3FmLb+LHzCiGBkGy/VALlJQohnlUB7o2Ac0iq9LlvCp34OsnPtVz0iJJcD3KzXDEFYthPhUQdLe14SGUCBjpzs1BNNuxL7V+DiB4sdn5/ss/eTCEvpeNSSw5zIfmGGfNNBsCMtUmWAepublaowTteOr6bmBRQdmubXiZsuUBLU7/h6/HA/6KWzr2GNK/ExTeOzcMRjazFJUF0Y64Z1AdqE98G88jDBriU0FPmYd5i9q/OhHoMHsCFU+as7zajrEObGpc5Ire6yYHDMi6fUQZid4Axca8lZ4+2bqR/edArhzY4nFgoUNFc/T08CR/yk1EVlxwcqOFbYCM53k9MIPNVopUcGKu4NIpzGGNmK/6Rtsah1LEIVmygfT2oS4mHTHQ9noi63kKWRDW4MpLf/XzxDe6yTOFmzPI1i/tG6GYDb5Uhq8ns4nMG1dPqotzsjQzZVQIvH9mjHvx5QMqGJf+K+yqTL+c8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(186009)(1800799009)(451199024)(41300700001)(71200400001)(7696005)(6506007)(53546011)(478600001)(122000001)(38100700002)(38070700005)(26005)(9686003)(55016003)(76116006)(54906003)(66946007)(2906002)(66476007)(66556008)(64756008)(66446008)(6916009)(316002)(33656002)(86362001)(5660300002)(52536014)(44832011)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U040VXF1bEs4M0JCODRVMEJVbVFTZnI2UklyaXZmSkNHcEt6bHVwV2NoMUd5?=
 =?utf-8?B?ZndtSEpaT2RqVm5qKzJ6NFZhQkJDVEo4elg4cVJSR1EwT2tmb0lWVzZIYlo3?=
 =?utf-8?B?OVEzem1lTkpncFduNXFJdWV3eWlCeXREY3lsTzVVNWxKN29LVUxueXVONHZX?=
 =?utf-8?B?MWxnOVhWZW9LeFpJSkZsVlV5QXA5S01pR1Y5a215ejVGS2x2NkNiWWZCZnFY?=
 =?utf-8?B?T3ZTVWVITmlFZG5VNFl6dXIwS3hOU24wUVRsRE9icjRjRENUbEtWYnM3eW9Q?=
 =?utf-8?B?UnNrc3RNeURqM1prZmpjeHlsbUFRWXAweHN2TlhMSjFZd1h0bDFEOEpqNHRt?=
 =?utf-8?B?NXYxY3ZIMWZEdENOaTVPNXloRm4raDFvNTRzckpKYjRZK3NQNmlJZmtKVHVK?=
 =?utf-8?B?c2FhL05xc2ZEWlF5c3VlSVg3aTN1dVV6alFRVmxTeTFBSGU3UDd0eFh2SVFz?=
 =?utf-8?B?amVwR1VpS0w2eWNXZGFnc0U2d0hIM3c3THRjYWdWZlIwR3cwK1JyUnNvRGM3?=
 =?utf-8?B?ZmhqbEcxaGlNM1padWlGeXkxRCtUTE95ck55N3RTOTFpUmVCQUJkUi8xakI4?=
 =?utf-8?B?T2Vxa0pDdEg3dXNuK3JRaW1sMGEvblVxRGY4QVk2cEJGVVBkUTJaV0lnQVpK?=
 =?utf-8?B?VVgwSFhJZ3plWEIrMTBXRlBUOGloRmVSd0JoUE83bHE1VmdIcEpBRW51T3o5?=
 =?utf-8?B?TE5LMTNNTitTamNGRG1aVEJGaXplY3hhYlZOWjYrcjJwZkVpMGFiUkR1TXls?=
 =?utf-8?B?YXBHMG5zaFllbEFLTXZNNlJHVEh3czdIa3h6YndJcmxWM1RjdHJWZVNOWFVx?=
 =?utf-8?B?NEdnZEFQc2VOQm52Z1IybStCOXYzTU1YU2FUODdjOWFuTUJPNTNodE5JU1Vk?=
 =?utf-8?B?THdBWVZzRmRkUS9KTVZOMXNNQVRSS0NhUnRsRk50V1BDNXNZQXRicmJuTTdF?=
 =?utf-8?B?aHUyVm5FaEt1Rjl6RVczWFEybVl3NkNhNHE1bDRSdGNHUUlaTW8yMjFua0l1?=
 =?utf-8?B?SWx4VHJVWkFTT0RJa1VVanhxeW5UdTZCTXNDRmJ6Uk43RFc5b0ZjRkM2d01X?=
 =?utf-8?B?UlJYZ25JOFNzYlN3LzlqbjYyRnlhek5JQkJiaVE3OEE3dlQ1YlpZRlBIczRB?=
 =?utf-8?B?Si9aeHpuWmtCdk0rWmt2QXcrVnlHcXhsdnFiemJTYkF5bTh4aGNEcVJUV1FZ?=
 =?utf-8?B?T2MwQUh4Ymw3b0NaZVB3cXc0ZUs1dWg1cCtCYUo3cWhoRXY3V2xtU2xOVnhK?=
 =?utf-8?B?bmk3cjl1SFdmYWRDR0dsanlXTEFoaGNpQ09jUTJLK3dqTS9iN3M4MTFhNVpI?=
 =?utf-8?B?OTVXMjk2UXZLRnA0RFJPUmpSeW52OGovMlN4Y3RzK0NsVVZqWHhPRmFGWFk5?=
 =?utf-8?B?WTU0YW1EdjQ5bEt1aGhzOWN4ZVMrcTZWUXl0ZDMrOWZYME1VaFdMQ2F6TzFZ?=
 =?utf-8?B?OVM5dVZ4cjdXakE4SzE2T3BWU21CSk9OVGV2c2hVaWlUSi9kbUN6UlZZRVlZ?=
 =?utf-8?B?K3FSdjJkRHdyT3BleEpwc3Q3YjNFL1VpUkNKTks4YkcwdllpMlBGeTNtTlVv?=
 =?utf-8?B?ZTNwNlhhK3JMMUFKMm5GOFBabmJ0dWtxeE9FYlNHMWxwMm1IdU5PZ3JhWjln?=
 =?utf-8?B?akpMUEw5a1BCUUsrMjJLWTlLV3NHU2dUaXNoWEVyZ3ZlV2tiQkc0V3BuMm4v?=
 =?utf-8?B?cjVoUUR5bDhZNDZER2k5My8vNXdCQ0tyd2dvakJtNXdXajZkZi9vS2tLbWVv?=
 =?utf-8?B?MjJrUVdWbzY3WHpkZjhNY2ZJYUpEbVVSVFRZMDZwYjV6cGJ4Z0FVVGttM05n?=
 =?utf-8?B?ZHhnQzhUMFR4eEdEUjBHZjV0eHB1NVBHbngrOEhaaTdIaml0NFdXenNXWFJM?=
 =?utf-8?B?b01HOHRveGNra0pPdjFHRmdUMks2a1VPK2VOWDUzd01heUdiN29WcEZtdmU3?=
 =?utf-8?B?a1NqODVKdHI2N2xVYXlJSWZOT2UzSUVDcWhHRHNxcGU2R2xPRVN5N1lQakJu?=
 =?utf-8?B?bVcvWUE1SnQyaVozem9Tay9mQUhpVUtaR0tybklPZnMwMjh2dE5nL0ZmZUd1?=
 =?utf-8?B?R3ZmYlZVWFhERk00S0VHaFp5UzZDMzkxa1BVWUxZTEQ3SWE0WnVWQi9NNks2?=
 =?utf-8?Q?T0Yw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e76bbbf-a4b6-458e-57da-08dbad15f8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 07:10:08.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVHyruKrk9THEq76bc+JVqpCqFh1ii14YnvA4mHVEzwmsg2ecwEWUZXKe3JFgdo01ZZb7Es8ZurGZcKCykMNbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNjoyMOKAr1BNIFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA1OjUw4oCvUE0gSHVp
IEZhbmcgPGh1aS5mYW5nQG54cC5jb20+IHdyb3RlOg0KLi4uLi4uDQo+ID4gSSB3b25kZXIgaWYg
b25seSBOWFAgbWV0IHRoZSAic3dpb3RsYiBidWZmZXIgZnVsbCIgaXNzdWUuIEluIHRoZW9yeSwN
Cj4gPiB3aGVuIGZvcm1hdCBpcyBZVVlWLCB0aG9zZSByZXNvbHV0aW9ucyBubyBncmVhdGVyIHRo
YW4gMzIweDI0MCAoMTUzNjAwDQo+ID4gYnl0ZXMsIHdoaWNoIGxlc3MgdGhhbiB0aGUgbWF4IG1h
cHBpbmcgc2l6ZSAyNTZLICkgY2FuJ3QgbWVldCB0aGUgaXNzdWUuDQo+ID4gQnV0IHJlc29sdXRp
b25zIG5vIGxlc3MgdGhhbiA2NDB4NDgwICgzMDcyMDAgYnl0ZXMpLCBtYXkgaGF2ZSBjaGFuY2Vz
DQo+ID4gdG8gdHJpZ2dlciB0aGUgaXNzdWUuDQo+IA0KPiBJIHRoaW5rIGEgY29tYmluYXRpb24g
b2YgYSBkZXZpY2UgdGhhdCBjYW4gc3VwcG9ydCBzY2F0dGVyLWdhdGhlciwgYnV0IHJlcXVpcmVz
DQo+IHN3aW90bGIgaXMga2luZCBvZiByYXJlLiBNb3N0IGRyaXZlcnMgd291bGQgcmVxdWlyZSBh
IHNpbmdsZSBjb250aWd1b3VzIERNQQ0KPiBhZGRyZXNzIChhbmQgdGh1cyB1c2UgdmlkZW9idWYy
LWRtYS1jb250aWcpIGFuZCBwaHlzaWNhbCBkaXNjb250aW51aXR5IHdvdWxkDQo+IGJlIGhhbmRs
ZWQgYnkgYW4gSU9NTVUgKHRyYW5zcGFyZW50bHkgdG8gdmIyKS4NCj4gDQo+IEkgZ3Vlc3Mgb25l
IHRoaW5nIHRvIGFzayB5b3UgYWJvdXQgeW91ciBzcGVjaWZpYyBzZXR1cCBpcyB3aGV0aGVyIGl0
J3MgZXhwZWN0ZWQNCj4gdGhhdCB0aGUgc3dpb3RsYiBlbmRzIHVwIGJlaW5nIHVzZWQgYXQgYWxs
Pw0KDQpZZXMsIHRoZSBzd2lvdGxiIGVuZHMgdXAgYmVpbmcgdXNlZC4gV2UgbWV0IHRoZSBpc3N1
ZSB3aGVuIGJyaW5nIHVwDQpEZXZpY2VBc1dlYkNhbSAoYW5kcm9pZC0xNCBuZXcgZmVhdHVyZSwg
YW5kcm9pZCBkZXZpY2Ugd29ya3MgYXMgYSB1c2IgY2FtZXJhKS4NCg0KDQpCUnMsDQpGYW5nIEh1
aQ0K

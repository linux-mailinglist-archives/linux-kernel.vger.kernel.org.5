Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B472279FD80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjINHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjINHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:52:09 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC2B1BF9;
        Thu, 14 Sep 2023 00:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFNlSsQ3tAxzikWJsaZVFkpIfiqafTjIvGYmQRmruOfIEe7nV6FqL7nZQRNyEOWgUXHRT6v5BzfE6BX9RMbE5IVmZP3EWbeb0C48t7ne+dN/2c4JSb/QWN9+HY2nbGJcVQ10nkEppxMbKhqjsgNY93TjpLbCCw4KYvGQX4AF92DHUlBvWxAx4zIyBBb8Jkyazaj4cjXS9eK1apC9r31hrIj0IJ8BEuT/T+R5Nstk0goY1f/TqzWMtyLzed2AXRsRaMv+7jIr4hbK+7h9amxJOafUuzsYkxpedCODyRfy72mTDvKctvNhffjJi3zpwl07s6viiNELvJtge4do/Zkgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3r/yy6dfBeGDY6tF/ZjGpDlvLkjiyewLjqN5nZNTY4=;
 b=WB4+xy7x0FhHONuxqvZ/JTqjYoPcRBOgnpRXTxPlhBOqUESw8SVvB20w2EJw9vIV1ae69jDntOi3a55ha+ILy4esC0kamgjaAnk9EK8J6Z/yZ6+cuWK1HuiLjSO9AbGUPzGFStZQaMvM5QDBavqHg0O62ezPJ24n8s7T85MRTeAAvIhliFSwIv4DR69IOSQifoqNDrHe4tEnetuEAWVIRs9FW0qfvr/8ydiSCMmNLm0eZ+hh4FIKj44ya+a9uEvjShJ23TjUAZ9B6vdLPYCgqBTxvymwATfwJ/RzKXSDyZrSTtKhraaRgaq/R674opnwGdNiCV/ZKMRg6Uy7Kk4RLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3r/yy6dfBeGDY6tF/ZjGpDlvLkjiyewLjqN5nZNTY4=;
 b=dNilvkVBBv9PJdr96ACKkOcC1GHeE4+hU6EJsF0EckZVjwRhnV3I0w3A3gsRNM2cNDO2UFP+hM5JAYCACdCIku673HWhDhQkPBdwj5/NgYGhMD+cj9KYrHDE3FB/rnwbNT5WbJIESJfyr8fKM7sAVa9dIrnHqUQn1tWzrjPf4Wk=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AS1PR04MB9262.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 07:52:02 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 07:52:02 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anle Pan <anle.pan@nxp.com>, Xuegang Liu <xuegang.liu@nxp.com>
Subject: RE: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Topic: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Index: AQHZ5t7nwJrRJ7WJYEaDKJh4zDlG3LAZ8MSA
Date:   Thu, 14 Sep 2023 07:52:02 +0000
Message-ID: <DB9PR04MB928456C515C3D53744A04B1087F7A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230914145812.12851-1-hui.fang@nxp.com>
In-Reply-To: <20230914145812.12851-1-hui.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AS1PR04MB9262:EE_
x-ms-office365-filtering-correlation-id: 6ba4a9aa-4026-41a0-e648-08dbb4f77b65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EXCL2yKA0MQAbTRnt6jqoIXu4WD7vtldoOp0R30tf7zXKV/9D8o047j1foTOzlWsSVKZnrqnzy03sVl+V6wgy+GPHpEtqI2vduoWvfoBPyPwfvXp9cj66Nn9sx6RJ38At+GsC93gez9FAIL8n2+eBVk+ZLgb705PrcEXY3Foy8dLCnVWwoQwDPVlSwzduINnfKb56XiWt3uV3cr3Lx8dzl2yE2BxxfQLID7R/XHcN6tQgpCQDtLMB9LUiWpDULBEV/yM22X2UItQ92DqZTy1Xmk6URRLLscmGc9qTYEqugCfDRzSNl5/eoeg8Uw7+oCRvnKdFpWYXBjJcTJKIFGMYbCiIcGDjQd3jbxvCUBLXdwNCIJpEM6bgRoMPmW4FHh+aw6Dr3ksJNjL2MXXCKR7KoLta6dXaX3hvNUETNxFlQrmyQGW72y//YKaP8Go/WsurH1ACx/DgstG7xIUjTE2Dh2xinG7R+FZv8vFoGW1utrk60kvmNn3A+GKl7iv0ay/IkD432ikSKmjYS8MjPZCxEQZS5/qoe08tbMzX5sCaKRwRlC/5Slu3/dlXhny+1nC7nGj6vN4gaRslnMv1QKLhANesC6PWiV4Oa8U7V3MvL/I5NEpjXriHunWvZqajSWn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(71200400001)(26005)(83380400001)(53546011)(110136005)(64756008)(66946007)(316002)(44832011)(478600001)(54906003)(66446008)(9686003)(76116006)(66476007)(122000001)(41300700001)(66556008)(7696005)(6506007)(38100700002)(38070700005)(2906002)(4744005)(5660300002)(86362001)(4326008)(8676002)(55016003)(33656002)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2Z0a1Y4bkJ2Vk5iVWhqMWp2eDRETUFwamhqUzNROGZSenRKSHhlVEllU1g3?=
 =?utf-8?B?Zk9MZU5GMXRXNXp1emdNOEFyK1Q0SkNtOFQzYWdaVjVPWmlLN2l3SUhocWhK?=
 =?utf-8?B?QjNKZC9wMVhmOFJTeStNWGNqNjd3SzZXeVVlREVFdVZFalRia2xtb0NkMjQ2?=
 =?utf-8?B?NE1oYVlNV3NzeUJ4WDRZWTcwK3R1MmRpUHN0VFpyLzBid3N6UHVCbkU0aEZo?=
 =?utf-8?B?ZW0vRnMvZVNNQVRSd0E4aW12Mkd5TGp2T1dqT0ppWjdHTk9zTHc0ZGRXc2ww?=
 =?utf-8?B?cjl4NjcvVzc0MmNsME1HdXExaUlQY1ZrMjNwZTdkYm5NQUtPS0RFSmxzUUUr?=
 =?utf-8?B?ek5pUERpdTkxREhvaHpPN25ZVWtUUmZqSGF2THFDY1RTNndDd1FvKzVZbHBZ?=
 =?utf-8?B?THZxZjFrN2ZkUU9qVlE2aHVtUnBHN1dzbDltUHp5SXFOUy9CR0trbjhVSk83?=
 =?utf-8?B?MWIvOG9BMStaOGJWVzhCYXpSa0VCSXEraDliYzVTZ2ZhTFlRZ2VpcmtxN3VD?=
 =?utf-8?B?VjFHWllma0FiUFgzLzl5T1lBOWw3Vy84eEx5Wjd0UzE4ZFdnR1l1eGtNeSs4?=
 =?utf-8?B?V1ZjZ2doUmRBaG5yV1hEUmphd0diQUxtZkJHMnZWR0lZdytpUVorVlpTb3ps?=
 =?utf-8?B?Z1I1UHZxeFpVMDFVTW50blpGV2d6M1h1SWc0bFRhMW1JT2t2M0ltSVA1U0Np?=
 =?utf-8?B?UDZ0bXN6WEZ6aldFNnh1bHhDRndleFp2bWMyUGVicFJHSFJsb1dNSWthc092?=
 =?utf-8?B?RzM1K1U3SkFZSS9USVNUUUxUQmxJZDAwNjVKKzhiMlk4eFNGVUgzbWx3em4z?=
 =?utf-8?B?SWVHZmZsaWVJenR3ckhaa2ZmTk9HUVZGWWxxYlZBc2Y0RkIzNXgxekxDUkNV?=
 =?utf-8?B?Z0dFWngrRDJCWWVUcktNZkNaRy9XbHRJUDQyM2hlVTJJTlRvZ2hTd1QrLys4?=
 =?utf-8?B?Z3E0aCtObUdQcGgwSmZYNEIzVHFrVlB2OW5lOWp2WjJRbkFSMC81NGJwU2ZS?=
 =?utf-8?B?N01hb0Q1N1QrY1ZvbUxTNU1La2RjaW90VWdkYmg0UStpdE9FbVV3Z0xQSFlU?=
 =?utf-8?B?SmFUSS9RVUZJekVET08rcmhvaXlOeldwT09EU3dydzhmZjV0MXVNci8weUVk?=
 =?utf-8?B?RkVpblE0NDFwUGFZL2Nhc3RzcldxTXZYWjg3Q052SDBWN2RPVDhJWXZwb2p3?=
 =?utf-8?B?dThSZnlNS0RjanZ0dlpWQXZEWTlHbkRPVmN6L2tVZlBBRHZNUmZmUUR6YTRS?=
 =?utf-8?B?dHJ0ZmYySC9IU1M2bG9qRi9xUDRYKzNPaElENEhkRkI4UHF2UlV2bk10Rlpv?=
 =?utf-8?B?azk0Nk9jSWcwV0RVaGJ5LzA3UFE1bjR1N3BjYzM4VStzRWRXbDdpdC9QQ0Fy?=
 =?utf-8?B?Y2xPOHJIYzQ1aC9MbDN5VWZORWp4OFgyajZqbndZQlhmQjljUVJqSTVYVzJz?=
 =?utf-8?B?S2dPZnhVdkRnQWp3dmN5T2FSbWU4WStSeHpuQ3o3VW5TZnJsb1BOWVZ2RE40?=
 =?utf-8?B?Qy90QUsxZ2dxQnpRZVBsclAyNG53ZjcxbmptMTlBT05iK2R2amFFcEpzOWM5?=
 =?utf-8?B?K2xpSnA3UGp4aFNIYnhvTDU4eHVWRzJQTC80UDJpUGJSWUM3THp3TlFVODQy?=
 =?utf-8?B?TXFUeWRoV2UxNUI1YTFTRlFUVXJKRU1DVjdlU0FDNElybGFxZVlPczN3TURh?=
 =?utf-8?B?amYyTjRleWlUODFYQndsbjFLK0Izb2lsQkZDcS9PaE5PODk4d29KbldvQ2x4?=
 =?utf-8?B?akxXY3YrMkE4V3ovN3Z0N0JxYTdjelpPUkthZ1ZNNW5ndThDKzdlWTU0dkFk?=
 =?utf-8?B?T0I3bGZ4clJUaWNLTlZlUmhRcDMvUldDNXN0Rm9FOWdLSkRFQlZTU2FsdndW?=
 =?utf-8?B?aGNTWkxYYVg1c0IxMHAwSlR5SXpmc29CWDVVanB6MThScDBSY3gzdUdKNzM5?=
 =?utf-8?B?K2tueHlUVkdaVTFibk1jdzd5YU1iOGJZbEROL2x0ZFNZWFJmZFNKblFtVVRO?=
 =?utf-8?B?SGFSeXB3bXljUzYyZmxPaldVTE56Wk00Y25CYmVXZkg1anZNNjYvaEQxQWRB?=
 =?utf-8?B?SXdrUlMwdnJpMTUxSkxyZ2RTUUtOWmcxZ1B2ZS93VThyR3AxRHExY0VRcHNV?=
 =?utf-8?Q?XFfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba4a9aa-4026-41a0-e648-08dbb4f77b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 07:52:02.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRVM8MS2WjmD+k0OO45vtGJd98JHllNhtbeNCVb4hUNGP7jZk25eE6OGDUz9AFyaNahB0i8hV645gH/h0Wy4oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9262
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMTU6NDHigK9QTSBGYW5nIEh1aSA8aHVpLmZhbmdAbnhw
LmNvbT4gd3JvdGU6IA0KPiBPbiBzeXN0ZW0gd2l0aCAiQ09ORklHX1pPTkVfRE1BMzI9eSIsIGlm
IHRoZSBhbGxvY2F0ZWQgcGh5c2ljYWwgYWRkcmVzcyBpcw0KPiBncmVhdGVyIHRoYW4gNEcsIHN3
aW90bGIgd2lsbCBiZSB1c2VkLiBJdCB3aWxsIGxlYWQgYmVsb3cgZGVmZWN0cy4NCj4gMSkgSW1w
YWN0IHBlcmZvcm1hbmNlIGR1ZSB0byBhbiBleHRyYSBtZW1jcHkuDQo+IDIpIE1heSBtZWV0IGJl
bG93IGVycm9yIGR1ZSB0byBzd2lvdGxiX21heF9tYXBwaW5nX3NpemUoKQ0KPiAgICBpcyAyNTZL
IChJT19UTEJfU0laRSAqIElPX1RMQl9TRUdTSVpFKS4NCj4gInN3aW90bGIgYnVmZmVyIGlzIGZ1
bGwgKHN6OiAzOTMyMTYgYnl0ZXMpLCB0b3RhbCA2NTUzNiAoc2xvdHMpLCB1c2VkIDIzNTggKHNs
b3RzKSINCj4gDQo+IFRvIGF2b2lkIHRob3NlIGRlZmVjdHMsIHVzZSBkbWFfYWxsb2NfcGFnZXMo
KSBpbnN0ZWFkIG9mIGFsbG9jX3BhZ2VzKCkgaW4NCj4gdmIyX2RtYV9zZ19hbGxvY19jb21wYWN0
ZWQoKS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogVG9tYXN6IEZpZ2EgPHRmaWdhQGNocm9taXVtLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogRmFuZyBIdWkgPGh1aS5mYW5nQG54cC5jb20+DQogLS0tDQpU
d28gdGhpbmdzLg0KMS4gRm9yIGRtYV9kYXRhX2RpcmVjdGlvbiBwYXJhIChETUFfQklESVJFQ1RJ
T05BTCBpcyB1c2VkKSBvZiBkbWFfYWxsb2NfcGFnZXMoKSwNCiAgbWF5YmUgYmV0dGVyIHBhc3Mg
ZnJvbSBjYWxsZXJzPyBJbiBEZXZpY2VBc1dlYmNhbSBjYXNlLCBpdCdzIERNQV9UT19ERVZJQ0Uu
DQoNCjIuICJNQS0yMTY1NCIgKE5YUCB0aWNrZXQgbnVtYmVyKSBzaG91bGQgYmUgcmVtb3ZlZCBp
biB0aGUgY29tbWVudCwgbmVlZCBJDQogIHJlLXB1c2ggb3IgaXQgd2lsbCBiZSBkb25lIG9uIHlv
dXIgc2lkZSwgdGhhbmtzIQ0KDQpCUnMsDQpGYW5nIEh1aQ0K

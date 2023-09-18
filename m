Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602737A41BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbjIRHHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjIRHH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:07:27 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2552611F;
        Mon, 18 Sep 2023 00:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaSlXbHIK0d7xV1IPZmRDW4owUJYCkJSiQLi/aFGhqwaDXkV6YahuDuUMge3LECb70GRxi3A/GVeuviJAx2WmimbMjhTPz7627pm2wcji3vYg398M3XlkoIP5nSKQ6bC68hH/NqqgnM4Z5VVQ+bpbPFQQ+71vTbmlpyQLAQR0k/wUP2coyskh22VyCEFbGL988NcZwFHGkdrXxJlDLe0DwieQ9Vbg1mWVBsYIlzYRSz11GuxORStV+XbErf6wCJw95o+oZ/64VFP+NXzyyhkZ4xq+5Fw5e/1GYRIGGEqM3sKuy73tHuRmmDjKUsnSgKm9JY6pGdrhOnNZCxFCV7HTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYo5+EJ1H/vkw8YaUHaGhEwMWEZLLm9YGkXD6AOEBvU=;
 b=AiJxM7fR1aL2ifMl3ouIMF5tK04UAm70sAOQalM5JeOF7gTy8La0jrTtwY+jdDyA4iLk89QWg1C1rSIVeLmqp3ouxy2gdhOv/30W1w9Z6Mqw/RovR6dgFyVjIBEDCBAvhQ82iLKh/nHoe/e6NMyJRxIgav8b3HKWuRy3F33mRDg8xPORYbOGyUfhOInUWMduyz4NTXtFmwM/dI84laX/ishPUjQcHdG4O33q2y4xq2xibZdnqOuBVOtECEi3tii8AJMbUj6DvjKI175qTQCj86TwQc6qOBBz2Tvg6HB6XlNm2EcpkSdqTHYxHeqPWCX68J8qPuOZUltWFk9Ab5bjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYo5+EJ1H/vkw8YaUHaGhEwMWEZLLm9YGkXD6AOEBvU=;
 b=jpjkOISzd0c5cQy0JUGRapNWCN6H6Ov5h1YVx1WvBj2/W7iyJcK4qLZ3mph6u4HJO6zYusdeYKEiQIKAP5ROMGaD4moaNiYC+1o/VQ32bkLir8Qq8nm23cU2xantrur1V3P9BlIxpP5+lrgmxQMiEdCmimRLIW4j6YjzM6spu30=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AM0PR04MB7186.eurprd04.prod.outlook.com (2603:10a6:208:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 07:07:13 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 07:07:13 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anle Pan <anle.pan@nxp.com>, Xuegang Liu <xuegang.liu@nxp.com>,
        "arakesh@google.com" <arakesh@google.com>,
        "rdhanjal@google.com" <rdhanjal@google.com>,
        "jchowdhary@google.com" <jchowdhary@google.com>
Subject: RE: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Topic: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Index: AQHZ5t7nwJrRJ7WJYEaDKJh4zDlG3LAZ8MSAgAY9TAA=
Date:   Mon, 18 Sep 2023 07:07:13 +0000
Message-ID: <DB9PR04MB92843816C50A490505170DF187FBA@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230914145812.12851-1-hui.fang@nxp.com>
 <DB9PR04MB928456C515C3D53744A04B1087F7A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB928456C515C3D53744A04B1087F7A@DB9PR04MB9284.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AM0PR04MB7186:EE_
x-ms-office365-filtering-correlation-id: 7dad7a36-d4ae-464b-bb20-08dbb815e243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jUvsBpHBSuYHsQoEpq+zMuiAZosupeOQP7dMSPKABltJgMkodxwIqXsHZzdLwObpYmyO2nbwei5w8hK7vRxQYd7tuw3o+WK4Q13eXHeVP45XF6Kcd261UUtpMVQi4ymluR/tbLgs8F5U1HGWsESviU3WD+qtF9F/WBsiM0xuThe5GuhnqLMO+fdBApCJrXpYB+ryT6WWy0A6QelI/OcddWuJDekOLzBEvQn7EB32Ne1IrmtPAnk9yzQhEXIRdCLxG7hytFGOh21/L8qHg6hNoMViJ6+i10jocq244PFzf58BRkICA/PzIu9VETfS125CAiBWPOryWcbtgIH5awr8xziXj05BnKqmEXRX7c6jwzFximN4152F69jvedbjmb984dB1t9T7cn1CsGFKJSwScU37Pe64kACre/9aNvrfaewB+tq8n5EocA+oUQcWbmu9vqvTJcDW38k7B/Pxvxe719fb8AZWlHZhUkwgojcvMb61VfT48Oq0k4Powx2TSpRcvl/JXk0akFBdfD/dcIYFFOflezA5iEyZS0BNKTVdm6Bg2T2upt7Cii1e3w7Pmjd6YkZTvCujIpwy+rWwkyiaipAnLkdPqQLQCrN05jSE6Vw/cgvuR/WDCv69dueeu9R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(1800799009)(186009)(451199024)(53546011)(7696005)(6506007)(71200400001)(9686003)(83380400001)(478600001)(26005)(4744005)(2906002)(44832011)(66476007)(66446008)(64756008)(54906003)(66556008)(66946007)(76116006)(316002)(8936002)(110136005)(8676002)(52536014)(4326008)(5660300002)(41300700001)(86362001)(33656002)(38100700002)(38070700005)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHlPVU5ONXY1ZWl2SktFamdadlRKakZiMTdQMzFQcnRsRHozYnN1UE9tREU1?=
 =?utf-8?B?Q29vTjk1ZXlyNXJ4bmJIY01aZlBVLyt5bmdMMU9jcmpQaXVtclV6MG82dGtS?=
 =?utf-8?B?SGVMd1hmVWovb1hYN0FHWnVuWVhNYTc2bFN5OUhKbjZLaWxEVjhZZlcvTVpE?=
 =?utf-8?B?ZVE4QXA3UVN3Q0tjUWZ0OVJTOWJ3a3ludWs4dEdZOHZCR2pXajhyVlBJTHJq?=
 =?utf-8?B?QWlUS2o4V2gxMEFLSElTa2xHTXpUenFMeHg1enRUWG1abExRUWk4aHJVZTR1?=
 =?utf-8?B?YzBhZ1U0V0ZGU1lDWk5xdGFtRDIvZkU1ODVNUVhYWE16UW9nNmlwelN6a3dQ?=
 =?utf-8?B?UlcxUzRUVjBHQTl5MHMzcndKV0QvSVl4ZDFJUmNhb2xXeVBITGpVR00zYVUr?=
 =?utf-8?B?U1NKL2llalpEL1RrZE14QlMxbmRrelJUU3NvYmFFTHhtdzFORy9LTWFyT1NN?=
 =?utf-8?B?QXVSM09kc2dURjlNRDVZVXBNZVBLMkVtdW5Ta3lOeURuYkl5MUh2N2VWczFU?=
 =?utf-8?B?dFpQZ09FV1o5dXhoWW9EWkFrSnVCNWhpOGlsd0xnU0x5QUllT3kvTUV3WHdN?=
 =?utf-8?B?cXhGU2FjaEZSWG95WThCc09RZWJLTXhoM3lIdjhaM0wxM2oyd0NpZFNRLzdZ?=
 =?utf-8?B?S1NtSVNFMmxta3kwYlFMQXl1MEVsejU0QVoxYm5MK2txTGNoYTduTGxxU2w5?=
 =?utf-8?B?Y1ZJV0xEdmk2cU5hazFVbXNPSEpXY2ZFbWhjNFJhcGZ0eStnZ2dzbnhLYUs5?=
 =?utf-8?B?a2NGM0RuaW0zekp1ZWVtcTBjeHAwWmFZcmhlUjFCa2VId0RUK1BITm5PQTN3?=
 =?utf-8?B?ZUh4MXh0VGFHYTJZSHY4Q1crSEFQTjVtQk42QnN6Mlo3aEFiRnBpb3dMcWE2?=
 =?utf-8?B?L1NtUmZMclNPS25aQTQ1dFBNR1lPRkR0RzJpM2VHV2dvSElCd01yTElRU3c0?=
 =?utf-8?B?bFR1UTh6Y1hpZWpXb0REZVpWYk50c29sVHd2c1FvbG1tNXkrMmVuOXQrSHNS?=
 =?utf-8?B?dmxSQnJPK1M0enpTQTZRTmppSmdrV3F5RWpNK3lsdEtDVlVaelZpVHdEdnA1?=
 =?utf-8?B?bDV5dGV3a21vajVNZlpTZkg4bjFqWTJUL05JTmNHNVRWZWJObXN0TTk0S3lJ?=
 =?utf-8?B?dUg1RzZob1pHVWpITUdjdnFKRmJBZzRwb20wOFhLTmNrWnNKVGpuUmtQY1Ft?=
 =?utf-8?B?dVVVQlIxOWttczNzYTUvUkpESU1yWlBJaUxhcmhsaEJISXFLd0x0ekpGR3FQ?=
 =?utf-8?B?Q09NeVlqUUc1dnFHdHZMeTJHeVI0anEyMENOa0hsSUFJam5zMnRBdzhac1Qx?=
 =?utf-8?B?K0d6WjFXWEVwQVdtbC9TSFMvUXhPMjRxMmQrWTA0dGpqMnRTRSt5MmhMTkZI?=
 =?utf-8?B?OThxVjF4MFF4dVZxbkxuY1Bub0lORFQydHdDMWxmS2o0RE8yblpMTGRvS09X?=
 =?utf-8?B?d1lNSHo2KzRMOEFJZ3FjT2JJNEowdVZuTURXaUVDSldmMFdoUGFoNU00bTEx?=
 =?utf-8?B?dXIwdVZPTWdyM3ZVeTNkSk1PMlZWUXhRUFpIaGFSOVUrZzNsT0JERkRvak94?=
 =?utf-8?B?UTQxaUtmL0ZQdEhXMHA3SGxXdzR6S2VvVjZ4K3lqNVRDY0xKT3pCbWREK2dM?=
 =?utf-8?B?SmRnc3lFUWRsK2o2TlR6NXhUaWlxcjdjOXdOSUR1MzhOblR4S2ZWYkRSYU84?=
 =?utf-8?B?SHNlbWpiNmE3aFR4endHM1BEVHltSWtHcTRqYnJUay9Ea0U3anA4SU5aNjV1?=
 =?utf-8?B?VDlkMVBweHVWZzIwVlllU3Vtd0NtK2VieWdLb2ExMTE2cStjY3A0Ymh3ZHpm?=
 =?utf-8?B?VnREVlR1QXRpTFlBL1NoOGx6cUt0ZmlQZHpmd05takhKbmlVKzIzWFRiOHBi?=
 =?utf-8?B?blRaRE1zOWF5ZU5RaWdoVGR1QURBMWpVQU1vdHcvMGVYeVF4TGpxanlsKzZu?=
 =?utf-8?B?YzF4SDhsR0xIL0o5ZzE5am5YbnhCRGtCRWd5Z0ZhL1pBY3d2Yy9nR2h1RTJl?=
 =?utf-8?B?VXB2d1dlWTBFZ1V3d3lNc296SVpUcFBGbEZaYk1SN24vcXprWU9ONlR3VFJG?=
 =?utf-8?B?UU51Q0huNzdxRnluUm5rRWtxbDd1TXA0VDlaMXEwMmt1Q2wzRWZIbFltdDZx?=
 =?utf-8?Q?+d78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dad7a36-d4ae-464b-bb20-08dbb815e243
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 07:07:13.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8NcnEO0AGhOfmSYmQ0dssTPVxaB34zcWmEOFVma05AyUmWJ//BEY5998+sx+s31WtpNnd3c9dGerN3fpad72Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIFNlcCAxNCwgMjAyMyBhdCAxNTo1MuKAr1BNIEZhbmcgSHVpIDxodWkuZmFuZ0Bu
eHAuY29tPiB3cm90ZToNCj4gIC0tLQ0KPiBUd28gdGhpbmdzLg0KPiAxLiBGb3IgZG1hX2RhdGFf
ZGlyZWN0aW9uIHBhcmEgKERNQV9CSURJUkVDVElPTkFMIGlzIHVzZWQpIG9mDQo+IGRtYV9hbGxv
Y19wYWdlcygpLA0KPiAgIG1heWJlIGJldHRlciBwYXNzIGZyb20gY2FsbGVycz8gSW4gRGV2aWNl
QXNXZWJjYW0gY2FzZSwgaXQncw0KPiBETUFfVE9fREVWSUNFLg0KPiANCj4gMi4gIk1BLTIxNjU0
IiAoTlhQIHRpY2tldCBudW1iZXIpIHNob3VsZCBiZSByZW1vdmVkIGluIHRoZSBjb21tZW50LCBu
ZWVkDQo+IEkgcmUtcHVzaCBvciBpdCB3aWxsIGJlIGRvbmUgb24geW91ciBzaWRlLCB0aGFua3Mh
DQoNCkFub3RoZXIgY29uY2VybiBpcyB0aGF0IERNQSBtZW1vcnkgaXMgdXNlZCB1cC4gTWF5YmUg
Zmlyc3QgdHJ5IGFsbG9jYXRpbmcNCmxvdyBidWZmZXIsIGlmIGZhaWxlZCwgZmFsbCBiYWNrIHRv
IGhpZ2ggYnVmZmVyLg0KDQpCUnMsDQpGYW5nIEh1aQ0K

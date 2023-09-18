Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931677A3F70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 04:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjIRCUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 22:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjIRCUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 22:20:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E20122;
        Sun, 17 Sep 2023 19:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiS7i1hl9AYGyQjPJDnOwB3cbfYR10EZeadRYWduo96cBBfDD1vMWNdCfgHyEUIuIL7r+Ab40DF5wsLeDXvHFwNloYWYYxzcoofqGdAioALrHaUu1f2GGGSdQGr9+iMzhg31JEZ80663qKls0zCuXDyRMYRKpLGtcMTeTLYWdmvPWIW4kGaLenaYLm7CbPf764Zdlya52Cp4zhQ/YkLqOeDmyb4mzwonWxROMrmywGp9zWZwsDa81EmD2Oxvz1ujvQW6vv2WBoADO4rf4sTI1QXczEgRp33MPR/1SqHpJqHl5K2DW9xJuZutmgPNiV7KOehCXJ+5ihcBtmMDCLXEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfno31zVyGSQbl98/b5adXNkpmgdyYpnqD2tmwvNMiY=;
 b=SeNg2DMNjka4eoxYnO474Mh2Jr1yxO6gKXyVwBjBiGtz+ysOxWtWzLF5gO0f0DjXvBTJrNrLr8SZb7Wn7SdJD8mIOh0qD4okjuLifru2mTCj558/2f5wLFfj44Y8CYOcfYF9Kv6wu8IZzeZvq+MytSBUSriKXicH3Ve1wg6obrvjylOU/d9EJ5e6DPpFADdxT0GgZOkt7pAc+OaivXxOdcqrKt6lHJh48O8hOz5cbkvHpGmqorfxZerm4BATpsTT/RvUaCa07WE4jr4XWvhJvW5h5lFXjz8PUak7AtTrLIKQcXDG6qNxYL5qiIhJRXBGYyUCQnYhTpYpVY0xYa+DmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfno31zVyGSQbl98/b5adXNkpmgdyYpnqD2tmwvNMiY=;
 b=n7/tQ/rwMorfczpDZWma/6dXkpJ7op0XZL4i0arp4XKIvl51imYWe+LQIYV1eOVwo3oCSdy75WLLe70mqSy57aS/ZX6OHao6PlBBjSXrAneRVPrNBak1J9IlDR3bHWhSNo9Qa2fZNbgdp50Gn5VaPpsLZ8TWT4VVE1bJE/JT52A=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by DUZPR04MB9727.eurprd04.prod.outlook.com (2603:10a6:10:4b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 02:20:23 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 02:20:23 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anle Pan <anle.pan@nxp.com>, Xuegang Liu <xuegang.liu@nxp.com>,
        "arakesh@google.com" <arakesh@google.com>,
        "jchowdhary@google.com" <jchowdhary@google.com>,
        "rdhanjal@google.com" <rdhanjal@google.com>
Subject: RE: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Topic: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Index: AQHZ5t7nwJrRJ7WJYEaDKJh4zDlG3LAZ8MSAgAXtZCA=
Date:   Mon, 18 Sep 2023 02:20:23 +0000
Message-ID: <DB9PR04MB928463A0FC0EEAB681763B7F87FBA@DB9PR04MB9284.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|DUZPR04MB9727:EE_
x-ms-office365-filtering-correlation-id: 0190fc55-585b-44d8-3337-08dbb7edd065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A2vHh54SUUnlMv/JgRswQgoUl59AMGXIBd4qM7dch5dOuxGpOQzcdC6ZMSBbxyDS0n0MpBVXoC1Jt4/suzBRrv2edP3C7x0cbLdDbsUizgU/Bf63a9HDvUW1g/hVD+qXxmlGQbBqjFip2R1t9BO0GQmxT6lvCNSH+2aw2EnNfkn9BTKh3FLloHyD33oTT+My9+A7GFhxVX6ntH0Eva//kwHIeWAFNy1Oi+ONv5e6SAJ5ZEqksRVwdj1q/lZWwlIFfmz6z96X1dmcqR3bCiNaKXfMCvy6EIYqwfyh+SCOvoZ/JZzYna4VBUieEobItBNTDfHMizMkFQ25YAE1RAZxZ3A2bLZq5d62jiH56kIALevPf/T6W2zos1Es+VwI1n0Qa47q0IdOiyRsTpDkeVI5gj9c7jW3g8WDSFOa8/ng6Jd/23vjxB85q+q7PcfvlzzS3rdK/mBSDydKCZx3eijJf2385jokWR+T1rPHjzz0uBSkvx5ox5OOC6iQY0v1PvlcNPwunML9mbjE0+wx+HUAaytoeScSTdTlRm9ePm8cpxHc0kESCglMn8LkqBN4LSttEL0B65h0qY0ZRmiH4L59ccJICt6p6vEageJI67xwUfrXGbkxyEMms6Ssbgkv6fj6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199024)(1800799009)(186009)(55016003)(7696005)(6506007)(53546011)(38070700005)(33656002)(86362001)(38100700002)(122000001)(26005)(4744005)(2906002)(9686003)(71200400001)(478600001)(83380400001)(52536014)(316002)(110136005)(5660300002)(8936002)(8676002)(4326008)(41300700001)(44832011)(66446008)(64756008)(54906003)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhCRVpoeFVUTWJ2RHVnZ3JSdUd4SUdIemdTUW1PcEJtNUhOd3pad2FQZEJl?=
 =?utf-8?B?dFF4bzk0ODFEZDBybVUrYkdwRGJ5N1g5UWxvZ0NrdUhlamdGWTU0b2d0S1gw?=
 =?utf-8?B?eVRpVWZQM2c3UmFLTWVhaFVtR0FnSDBqWUNtN0pNOXBTUCtDb01vNmJpOVJt?=
 =?utf-8?B?cGNZYmVsWmZZelduUUFnc2JBODZSKzh4TTZrWkN0WXNzbmhQcFl4T3ZRQ2dG?=
 =?utf-8?B?cjFvMWg5OHZ6WUdIT1o2UmtPdmxDc2EzWlY1QUhGdVgycHV6b0I0Wm5sQWJW?=
 =?utf-8?B?Z1JEUk1jOEdxNmgvRmRqUUVtVXBxamhYaVU2N2tmWVFFM3FDWUJnU1gyRGdL?=
 =?utf-8?B?dDFJRFdYMmh2bUVIMVVoMjJmRXFKOThXVy9NOXJCTFNvRVQ0VnZNeHZ0T2FD?=
 =?utf-8?B?bjdSY01PUjRFTGE2ZldaMVUwOXYxVnlmZ0ZHenN4TVFxeGw1SFozUEU3UnY0?=
 =?utf-8?B?QWlld1F3V3ZEU0Qzc2xwT2NoMldLKzRFZWVLVFpneldtQXZOV1hPb1lFOEh0?=
 =?utf-8?B?MlVBYkdOS3kzbXJ6VmZCbnMxYm5TRUZndUNsWitUdEhJQk9BbnNueGQwQ3BO?=
 =?utf-8?B?enRSUHpnS2NmaTJFWmZlTk1jS2ZGNU9aUytOdld1WGdTMmxSVW0vSHJSVVpp?=
 =?utf-8?B?aE1tcFNYeHc1UDB6L1VTUkpVSXBoM0tTQzhDc0hIY3dyS3BBcmFpeUMrcVkw?=
 =?utf-8?B?Nm9rVkZtY2RrRVMxeDFkRDdPcis1eWJydUQ3WHJldW1TdXZDeDBoYzFGcU5K?=
 =?utf-8?B?UjNVbWx0UnBZL2xaYndyRUxmMFQ3S1pGeFRkbk9YTnkyTFRZNGtib01iYnBZ?=
 =?utf-8?B?a2RVK0VqaXdDVURSZmlpQlNEVFQ2aTBJL2w0a2lES05qNTZEdjJEV24xK3NY?=
 =?utf-8?B?Vlo1R2xuamZuSHhScUpWbXByMEE2MEg1OXNzeUlGb1FHWGxCb3BMUEFsdGxq?=
 =?utf-8?B?Mm1mZE5oc1Q2bW44bW4vdjBMRWpKbWhQRDYydWcwRzhsWFV0aytxUXBhRUtU?=
 =?utf-8?B?anVvSmdNTnNHaitNR3NBdWJrb2xHa2NBUU1vT0ZKdGNVeE55a2dLcXNoL2Jk?=
 =?utf-8?B?UkZCZWdhK3dWaVdRL1oza0hwU21jbVQ0eXcxWlJoeHBpNXhkWmQ0UDFWSUtj?=
 =?utf-8?B?bnRlYnFIcUFNdHpieFhxRnBhaVE1WHcxRzRlNUkzbnh0UlFjZ21iaGxJUnRh?=
 =?utf-8?B?N1JQUnhwVEI1aGdLVFA5QXBEQnk3dGNzdi9BalFCWWtnN01VVTR1cDFxMWwx?=
 =?utf-8?B?TmpITXpwUjkyMmlYdGZRK1pQczEwbyticjJpWWVzTnBRR0FobzRDZUVyNWpr?=
 =?utf-8?B?eTR3bjlJa3Nzd0RhWnZhQ1pYWWQzNXRaWEFmOGpiQ21RWlFhZkxnL1J5WWJR?=
 =?utf-8?B?N280Ym5UOXFxd1BIaEs1NkIrOEdlS3RVRi90czFFcDdHVWtVd1pYNEg5NlU2?=
 =?utf-8?B?VUhFZW8wRDJJWWpFOWZyMkYvRnpZb3ZCdVhmRWUzMVhub2VWTmRTcmd1MDZ0?=
 =?utf-8?B?TmhCcHIzdU1ZeThHMG5KZEppdnRBbTJLTys3cWxHRFVSTUR3d0NGM0FuUUg1?=
 =?utf-8?B?b3Z1YmJuc1A2SjMyN0VPaDI5UE1GS1FMZWd3SW0yL0FkcUVGOXBiMXRtYlY5?=
 =?utf-8?B?T2FRTGUvelFGbXdUK2JRajRxdzlMYlV5L2d1WU9DMGViOFMrTWwxbHhVeXYx?=
 =?utf-8?B?ZExmOG5EZjhLU3ZWVnNUWjQ5a2tCUHFZNmxVOER4ZmRwK01uWlM4eVVEN0Nq?=
 =?utf-8?B?dUhXTzBid1JybTBobkRPYzdrQ01VQWJZaDZVck1kd1daNkhWQWFYeXhBSkRX?=
 =?utf-8?B?cmtIajlwMm80YzlhQ0xzblF2eGw2eVFIUzRCUXVHVXB0TlVhYTQ4dysvRE1v?=
 =?utf-8?B?emVUN2t4enRFTk03MmY5U00xck9PdVhKZ3F4TzZIckN1N2ZPZGJmUjNrNWxE?=
 =?utf-8?B?cEpObFY5SExxMHhRRGkwYWIvMU5XNlN3RnJLUnl2bkdubnAzcU5aWkEvRlV3?=
 =?utf-8?B?NDhYdmdzYnJFU0lCOWEvdEhBaWRQbzh5OXZ3bTliVS9GOXpXY3hicDY3blFG?=
 =?utf-8?B?Y2wwZDVOYndIVHFqWXZRZkZKNmVLT2wxV0hNcU1jZ0ozbXdQb3Z2Mm01L1l5?=
 =?utf-8?Q?rk5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0190fc55-585b-44d8-3337-08dbb7edd065
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 02:20:23.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3h40QI7eQ/N4YZdsxY0O2MJdGXFT+GfvTmFmDsnccH4ailg+mZgBgwJiTpJFJKpre6NBHGajDqXpPd62064KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMTU6NTLigK9QTSBGYW5nIEh1aSA8aHVpLmZhbmdAbnhw
LmNvbT4gd3JvdGU6DQo+IFR3byB0aGluZ3MuDQo+IDEuIEZvciBkbWFfZGF0YV9kaXJlY3Rpb24g
cGFyYSAoRE1BX0JJRElSRUNUSU9OQUwgaXMgdXNlZCkgb2YNCj4gZG1hX2FsbG9jX3BhZ2VzKCks
DQo+ICAgbWF5YmUgYmV0dGVyIHBhc3MgZnJvbSBjYWxsZXJzPyBJbiBEZXZpY2VBc1dlYmNhbSBj
YXNlLCBpdCdzDQo+IERNQV9UT19ERVZJQ0UuDQo+IA0KPiAyLiAiTUEtMjE2NTQiIChOWFAgdGlj
a2V0IG51bWJlcikgc2hvdWxkIGJlIHJlbW92ZWQgaW4gdGhlIGNvbW1lbnQsIG5lZWQNCj4gSSBy
ZS1wdXNoIG9yIGl0IHdpbGwgYmUgZG9uZSBvbiB5b3VyIHNpZGUsIHRoYW5rcyENCg0KS2VlcCBn
b29nbGUgZnJpZW5kcyBpbiB0aGUgbG9vcC4NCg0KQlJzLA0KRmFuZyBIdWkNCg==
